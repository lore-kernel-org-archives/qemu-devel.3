Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BB1C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8w3-0000z0-Dw; Fri, 14 Mar 2025 13:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tt8vl-0000tP-8B
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:34:45 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tt8vc-00009o-R0
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:34:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C5100609F8;
 Fri, 14 Mar 2025 20:34:31 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a420::1:c] (unknown
 [2a02:6b8:b081:a420::1:c])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id UYII1m4FY0U0-OD6CR4il; Fri, 14 Mar 2025 20:34:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1741973671;
 bh=hOYtcml10fClTglWTCzNU5YHKIi5VKA4k4Xv7DI91G4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CudL3UmXRekMoHnXaDdBPDeIsJ0lmPtorfKp1fEdepOTnAuO4ZdtHW71Aetb2GvuB
 6gELwF+avQN8wfgtgsUD5/3rCN8KZvjTbIHxiHYm/ZNIUBziIsZv0vO65YTrwYPBiW
 VCYjLyRmCY6BbrEM5j9ikw+1HzpHkZHjbd2N4VlQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2442a3e3-c934-447d-9c9d-57e32dd3e0f5@yandex-team.ru>
Date: Fri, 14 Mar 2025 20:34:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] utils/qemu-sockets: Introduce keep-alive-idle-period
 inet socket option
To: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250303143312.640909-1-jmarcin@redhat.com>
 <20250303143312.640909-3-jmarcin@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250303143312.640909-3-jmarcin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

On 03.03.25 17:33, Juraj Marcin wrote:
> The default idle period for TCP connection could be even 2 hours.
> However, in some cases, the application needs to be aware of a
> connection issue much sooner.
> 
> This is the case, for example, for postcopy live migration. If there is
> no traffic from the migration destination guest (server-side) to the
> migration source guest (client-side), the destination keeps waiting for
> pages indefinitely and does not switch to the postcopy-paused state.
> This can happen, for example, if the destination QEMU instance is
> started with '-S' command line option and the machine is not started yet
> or if the machine is idle and produces no new page faults for
> not-yet-migrated pages.
> 
> This patch introduces a new inet socket parameter on platforms where
> TCP_KEEPIDLE is defined and passes the configured value to the
> TCP_KEEPIDLE socket option when a client-side or server-side socket is
> created.
> 
> The default value is 0, which means system configuration is used, and no
> custom value is set.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>   io/dns-resolver.c   |  4 ++++
>   meson.build         |  2 ++
>   qapi/sockets.json   |  5 +++++
>   util/qemu-sockets.c | 39 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 50 insertions(+)
> 
> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> index ee7403b65b..03c59673f0 100644
> --- a/io/dns-resolver.c
> +++ b/io/dns-resolver.c
> @@ -128,6 +128,10 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
>   #endif
>               .has_keep_alive = iaddr->has_keep_alive,
>               .keep_alive = iaddr->keep_alive,
> +#ifdef HAVE_TCP_KEEPIDLE
> +            .has_keep_alive_idle_period = iaddr->has_keep_alive_idle_period,
> +            .keep_alive_idle_period = iaddr->keep_alive_idle_period,
> +#endif
>           };
>   
>           (*addrs)[i] = newaddr;
> diff --git a/meson.build b/meson.build
> index 0ee79c664d..ca726f317f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2724,6 +2724,8 @@ config_host_data.set('HAVE_OPTRESET',
>                        cc.has_header_symbol('getopt.h', 'optreset'))
>   config_host_data.set('HAVE_IPPROTO_MPTCP',
>                        cc.has_header_symbol('netinet/in.h', 'IPPROTO_MPTCP'))
> +config_host_data.set('HAVE_TCP_KEEPIDLE',
> +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPIDLE'))
>   
>   # has_member
>   config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index eb50f64e3a..ddd82b1e66 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -59,6 +59,10 @@
>   # @keep-alive: enable keep-alive when connecting to/listening on this socket.
>   #     (Since 4.2, not supported for listening sockets until 10.0)
>   #
> +# @keep-alive-idle-period: time in seconds the connection needs to be idle
> +#     before sending a keepalive packet.  Only supported for TCP sockets on
> +#     systems where TCP_KEEPIDLE socket option is defined.  (Since 10.0)
> +#
>   # @mptcp: enable multi-path TCP.  (Since 6.1)
>   #
>   # Since: 1.3
> @@ -71,6 +75,7 @@
>       '*ipv4': 'bool',
>       '*ipv6': 'bool',
>       '*keep-alive': 'bool',
> +    '*keep-alive-idle-period': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPIDLE' },
>       '*mptcp': { 'type': 'bool', 'if': 'HAVE_IPPROTO_MPTCP' } } }
>   
>   ##
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index c30e4ac2ce..edcda846ef 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -349,6 +349,18 @@ listen_ok:
>               slisten = -1;
>               goto exit;
>           }
> +#ifdef HAVE_TCP_KEEPIDLE
> +        if (saddr->has_keep_alive_idle_period && saddr->keep_alive_idle_period) {
> +            int keepidle = saddr->has_keep_alive_idle_period;
> +            ret = setsockopt(slisten, IPPROTO_TCP, TCP_KEEPIDLE, &keepidle, sizeof(keepidle));
> +            if (ret < 0) {
> +                error_setg_errno(errp, errno, "Unable to set TCP_KEEPIDLE");
> +                close(slisten);
> +                slisten = -1;
> +                goto exit;
> +            }
> +        }
> +#endif
>       }
>   exit:
>       freeaddrinfo(res);
> @@ -492,6 +504,17 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
>               close(sock);
>               return -1;
>           }
> +#ifdef HAVE_TCP_KEEPIDLE
> +        if (saddr->has_keep_alive_idle_period && saddr->keep_alive_idle_period) {
> +            int keepidle = saddr->keep_alive_idle_period;
> +            ret = setsockopt(sock, IPPROTO_TCP, TCP_KEEPIDLE, &keepidle, sizeof(keepidle));
> +            if (ret < 0) {
> +                error_setg_errno(errp, errno, "Unsable to set TCP_KEEPIDLE");
> +                close(sock);
> +                return -1;
> +            }
> +        }
> +#endif
>       }


Looks like we need some inet_setsockopt(*saddr) {}, which set both options and called from both client and server sockets, to avoid duplication.

>   
>       return sock;
> @@ -698,6 +721,22 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
>           }
>           addr->has_keep_alive = true;
>       }
> +#ifdef HAVE_TCP_KEEPIDLE
> +    begin = strstr(optstr, ",keep-alive-idle-period=");
> +    if (begin) {
> +        begin += strlen(",keep-alive-idle-period=");
> +        if (sscanf(begin, "%" PRIu32 "%n", &addr->keep_alive_idle_period, &pos) != 1 ||
> +            (begin[pos] != '\0' && begin[pos] != ',')) {
> +            error_setg(errp, "error parsing keep-alive-idle-period argument");
> +            return -1;
> +        }
> +        if (addr->keep_alive_idle_period > INT_MAX) {
> +            error_setg(errp, "keep-alive-idle-period value is too large");
> +            return -1;
> +        }
> +        addr->has_keep_alive_idle_period = true;
> +    }
> +#endif
>   #ifdef HAVE_IPPROTO_MPTCP
>       begin = strstr(optstr, ",mptcp");
>       if (begin) {

-- 
Best regards,
Vladimir


