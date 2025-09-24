Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D02CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1PhR-00072P-Pq; Wed, 24 Sep 2025 09:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1v1PhN-000720-5P
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:38:21 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1v1PhI-0004uM-FL
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:38:20 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 74BB980843;
 Wed, 24 Sep 2025 16:38:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c4e::1:9] (unknown [2a02:6bf:8080:c4e::1:9])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7cYYZi0GpeA0-aTbEM5FQ; Wed, 24 Sep 2025 16:38:08 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758721088;
 bh=pqQYLO5gH7Pt8pzlWX6ZJb8N64oYwGQpvfPFZALVfRI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1LqpvTTOxsdaMuEG+YUJBY0NXvsdniD3CQK/2uMIAxdEMvhzQMcPmx356VVMvOsvZ
 a/BlZoq+wVJLWA4c3iGF2Lx578SHCTdLs4QFbj7McMy16Qikxjy1f3qIaCXac1Jb/Z
 ga8JcbI0pdqlQqIGe4wRd0b7Bw6WlFLWQxJs8vI4=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cbe3f6b5-65b5-4ad9-9ee5-b9725c6d9f50@yandex-team.ru>
Date: Wed, 24 Sep 2025 16:38:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] chardev: remove deprecated 'reconnect' option
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jasowang@redhat.com,
 devel@lists.libvirt.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 yc-core@yandex-team.ru
References: <20250924133309.334631-1-vsementsov@yandex-team.ru>
 <20250924133309.334631-2-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20250924133309.334631-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/24/25 4:33 PM, Vladimir Sementsov-Ogievskiy wrote:

> It was deprecated in 9.2, time to remove.
>
> Note, that (which become obvious with this commit) we forget to do some
> checks for reconnect-ms options, for example, it was silently ignored
> for listening server, instead of error-out. The commit fixes this, as
> now we use reconnect_ms everywhere.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

> ---
>   chardev/char-socket.c           | 24 +++++-------------------
>   chardev/char.c                  |  3 ---
>   docs/about/deprecated.rst       |  6 ------
>   docs/about/removed-features.rst | 12 ++++++++++++
>   qapi/char.json                  | 14 +-------------
>   5 files changed, 18 insertions(+), 41 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index cb4ec78ebe..62852e3caf 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1296,9 +1296,9 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
>       /* Validate any options which have a dependency on address type */
>       switch (addr->type) {
>       case SOCKET_ADDRESS_TYPE_FD:
> -        if (sock->has_reconnect) {
> +        if (sock->has_reconnect_ms) {
>               error_setg(errp,
> -                       "'reconnect' option is incompatible with "
> +                       "'reconnect-ms' option is incompatible with "
>                          "'fd' address type");
>               return false;
>           }
> @@ -1342,9 +1342,9 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
>   
>       /* Validate any options which have a dependency on client vs server */
>       if (!sock->has_server || sock->server) {
> -        if (sock->has_reconnect) {
> +        if (sock->has_reconnect_ms) {
>               error_setg(errp,
> -                       "'reconnect' option is incompatible with "
> +                       "'reconnect-ms' option is incompatible with "
>                          "socket in server listen mode");
>               return false;
>           }
> @@ -1361,12 +1361,6 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
>           }
>       }
>   
> -    if (sock->has_reconnect_ms && sock->has_reconnect) {
> -        error_setg(errp,
> -            "'reconnect' and 'reconnect-ms' are mutually exclusive");
> -        return false;
> -    }
> -
>       return true;
>   }
>   
> @@ -1384,7 +1378,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>       bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
>       bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
>       bool is_websock     = sock->has_websocket ? sock->websocket : false;
> -    int64_t reconnect_ms = 0;
> +    int64_t reconnect_ms = sock->has_reconnect_ms ? sock->reconnect_ms : 0;
>       SocketAddress *addr;
>   
>       s->is_listen = is_listen;
> @@ -1456,12 +1450,6 @@ static void qmp_chardev_open_socket(Chardev *chr,
>               return;
>           }
>       } else {
> -        if (sock->has_reconnect) {
> -            reconnect_ms = sock->reconnect * 1000ULL;
> -        } else if (sock->has_reconnect_ms) {
> -            reconnect_ms = sock->reconnect_ms;
> -        }
> -
>           if (qmp_chardev_open_socket_client(chr, reconnect_ms, errp) < 0) {
>               return;
>           }
> @@ -1526,8 +1514,6 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>        */
>       sock->has_wait = qemu_opt_find(opts, "wait") || sock->server;
>       sock->wait = qemu_opt_get_bool(opts, "wait", true);
> -    sock->has_reconnect = qemu_opt_find(opts, "reconnect");
> -    sock->reconnect = qemu_opt_get_number(opts, "reconnect", 0);
>       sock->has_reconnect_ms = qemu_opt_find(opts, "reconnect-ms");
>       sock->reconnect_ms = qemu_opt_get_number(opts, "reconnect-ms", 0);
>   
> diff --git a/chardev/char.c b/chardev/char.c
> index bbebd246c3..a43b7e5481 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -892,9 +892,6 @@ QemuOptsList qemu_chardev_opts = {
>           },{
>               .name = "nodelay",
>               .type = QEMU_OPT_BOOL,
> -        },{
> -            .name = "reconnect",
> -            .type = QEMU_OPT_NUMBER,
>           },{
>               .name = "reconnect-ms",
>               .type = QEMU_OPT_NUMBER,
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index aa300bbd50..ba0be97513 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -438,12 +438,6 @@ Backend ``memory`` (since 9.0)
>   
>   ``memory`` is a deprecated synonym for ``ringbuf``.
>   
> -``reconnect`` (since 9.2)
> -^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -The ``reconnect`` option only allows specifying second granularity timeouts,
> -which is not enough for all types of use cases, use ``reconnect-ms`` instead.
> -
>   
>   Net device options
>   ''''''''''''''''''
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index a5338e44c2..d67928956a 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1361,4 +1361,16 @@ The ``blacklist`` config file option has been renamed to ``block-rpcs``
>   (to be in sync with the renaming of the corresponding command line
>   option).
>   
> +Device options
> +--------------
> +
> +Character device options
> +''''''''''''''''''''''''
> +
> +``reconnect`` (removed in 10.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``reconnect`` has been replaced by ``reconnect-ms``, which provides
> +better precision.
> +
>   .. _Intel discontinuance notification: https://www.intel.com/content/www/us/en/content-details/781327/intel-is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.html
> diff --git a/qapi/char.json b/qapi/char.json
> index f0a53f742c..b07e3bb827 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -269,22 +269,11 @@
>   # @websocket: enable websocket protocol on server sockets
>   #     (default: false) (Since: 3.1)
>   #
> -# @reconnect: For a client socket, if a socket is disconnected, then
> -#     attempt a reconnect after the given number of seconds.  Setting
> -#     this to zero disables this function.  The use of this member is
> -#     deprecated, use @reconnect-ms instead.  (default: 0) (Since: 2.2)
> -#
>   # @reconnect-ms: For a client socket, if a socket is disconnected,
>   #     then attempt a reconnect after the given number of milliseconds.
> -#     Setting this to zero disables this function.  This member is
> -#     mutually exclusive with @reconnect.
> +#     Setting this to zero disables this function.
>   #     (default: 0) (Since: 9.2)
>   #
> -# Features:
> -#
> -# @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
> -#     instead.
> -#
>   # Since: 1.4
>   ##
>   { 'struct': 'ChardevSocket',
> @@ -297,7 +286,6 @@
>               '*telnet': 'bool',
>               '*tn3270': 'bool',
>               '*websocket': 'bool',
> -            '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
>               '*reconnect-ms': 'int' },
>     'base': 'ChardevCommon' }
>   

