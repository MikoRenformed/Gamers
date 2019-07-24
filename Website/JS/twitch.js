const TwitchDefaultConfig = {
  client_id: null,
  mount_id: null,
  game_list_heading: 'Game listing',
  dialog_id: '#twitch-feature-dialog',
  dialog_width: 600,
  dialog_height: 400
};

const TwitchFeature = function(config, Twitch, $) {
  const conf = Object.assign({}, TwitchDefaultConfig, config);
  const fetchFromURL = function(url, params) {
    return $.ajax({
      url: url,
      data: params,
      headers: { 'Client-ID': conf.client_id }
    });
  };

  const LIST_GAME_ENDPOINT = 'https://api.twitch.tv/helix/games/top';
  // https://dev.twitch.tv/docs/api/reference/#get-top-games
  const LIST_STREAM_ENDPOINT = 'https://api.twitch.tv/helix/streams';
  // https://dev.twitch.tv/docs/api/reference/#get-streams

  const playStream = function() {
    const selectedStream = $(this);
    const channelName = selectedStream.data('channelname');
    const options = {
      width: conf.dialog_width - 50,
      height: conf.dialog_height,
      channel: channelName
    };

    $(conf.dialog_id).attr('title', channelName);
    const player = new Twitch.Player(conf.dialog_id.replace('#', ''), options);

    $(conf.dialog_id).dialog({ modal: true, minWidth: conf.dialog_width });
  };

  const listGames = function(cursor) {
    const params = { first: 100 };
    if (cursor) {
      params.after = cursor;
    }
    return fetchFromURL(LIST_GAME_ENDPOINT, params);
  };

  const listStreams = function(gameID, cursor) {
    const params = { first: 100, game_id: gameID };
    if (cursor) {
      params.after = cursor;
    }
    return fetchFromURL(LIST_STREAM_ENDPOINT, params);
  };

  const fetchStreamListing = function() {
    const selectedStream = $(this);
    const gameID = selectedStream.data('gameid');

    const elementTemplate =
      '<p class="twitch-active-stream" data-streamid="{{stream_id}}" data-channelname="{{channel_name}}"><a href="#">{{user_name}}</a></p>';

    const renderStreamListing = function(response) {
      const elements = response.data
        .map(function(stream) {
          return elementTemplate
            .replace('{{user_name}}', stream.user_name)
            .replace('{{started_at}}', stream.started_at)
            .replace('{{stream_id}}', stream.id)
            .replace('{{channel_name}}', stream.user_name);
        })
        .join('');

      selectedStream.find('div').append(elements);

      $(conf.mount_id).on('click', '.twitch-active-stream', playStream);
    };

    listStreams(gameID).then(renderStreamListing);
  };

  const renderGamesListing = function(response) {
    const accordionHeader = '<h2 class="twitch-feature-heading">{{conf_game_list_heading}}</h2>'.replace(
      '{{conf_game_list_heading}}',
      conf.game_list_heading
    );

    const accordionContainer = $('<div id="accordion"></div>');
    const accordionElementTemplate =
      '<div class="group" data-gameid="{{game_id}}"><h3>{{game_name}}</h3><div class="streams"></div></div>';
    const elements = response.data
      .map(function(game) {
        return accordionElementTemplate
          .replace('{{game_id}}', game.id)
          .replace('{{game_name}}', game.name);
      })
      .join('');

    accordionContainer.append(elements);
    $(conf.mount_id).append($(accordionHeader));
    $(conf.mount_id).append(accordionContainer);

    $('#accordion').accordion({
      header: '> div > h3',
      height: 'content',
      active: false,
      collapsible: true,
      heightStyle: 'content'
    });

    $('#accordion').on('click', '.group', fetchStreamListing);
  };

  const setupDialog = function() {
    if ($(conf.dialog_id).length != 1) {
      $(conf.mount_id).after(
        '<div id="{{dialog_id}}" title=""></div>'.replace(
          '{{dialog_id}}',
          conf.dialog_id.replace('#', '')
        )
      );
    }
  };
  const init = function() {
    setupDialog();
  };
  const integrate = function() {
    init();
    listGames().then(renderGamesListing);
  };

  return {
    integrate: integrate
  };
};
