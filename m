Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE8606A32C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gnu.org header.i=@gnu.org header.a=rsa-sha256 header.s=fencepost-gnu-org header.b=MrMmWbA6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPoZ3-0001II-64; Sat, 07 Nov 2026 17:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1xPoZ0-0001I5-7F
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 17:07:06 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1xPoYy-00065b-O3; Sat, 07 Nov 2026 17:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=WGkmQS7RFv9EYBv8QoSzEx3qLMg6VpAe634WTJC3vm8=; b=MrMmWbA6NfqFgWGIig9u
 XizSRV4owrc33TgAgkvipfa8+532uAUfeUoTS14eEoPbAZz6j7PBu5M2iWWg3OPAlW+QfFyZ+1/ds
 qsZXDnMKroKQkjiJo6I56aPFlpYfOOHDLjydLpObM4ZIDDwh/mtFI6CuRUxm2b/Xjl6/kqRhhZgKe
 yUjU7Kdz13JYwE+/t7RKiV8OtfzMsowzMaDrurDcljTLaUIaW0ml145nLksLhd10X9Ox3TomIUgcK
 4rh+tmWJug7kaFKKx45g7i049o0J6fSp3K3M1ewyM3qfkH8NOtIrc881HZYHgIljH9+H100PwOjIa
 3/hr368GUuYDUA==;
Date: Sat, 7 Nov 2026 23:07:01 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Gavin Li <gavin.li@samsara.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v1] net: add per-connection guestfwd unix support
Message-ID: <au-hBYP1bA3qxYht@end>
References: <20261107044225.2786-1-gavin.li@samsara.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261107044225.2786-1-gavin.li@samsara.com>
Organization: I am not organized
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Gavin Li, le ven. 06 nov. 2026 23:42:25 -0500, a ecrit:
> For -netdev user,guestfwd=..., add support for unix-per-connection: in
> addition to the currently supported tcp: and cmd:. With
> unix-per-connection:, a new connection is opened to the given unix
> socket.  This is an improvement over the current unix: support, which
> does not support 1:1 guest:host connections.
> 
> Also update the minimum libslirp version to 4.2.0 (released in 2020) as
> it adds support for the slirp_add_unix() function.
> 
> Signed-off-by: Gavin Li <gavin.li@samsara.com>

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Samuel

> ---
>  meson.build     | 2 +-
>  net/slirp.c     | 6 ++++++
>  qemu-options.hx | 9 +++++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index d7bcb581c1..6567ede5d9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1289,7 +1289,7 @@ endif
>  slirp = not_found
>  if not get_option('slirp').auto() or have_system
>    slirp = dependency('slirp', required: get_option('slirp'),
> -                     method: 'pkg-config')
> +                     method: 'pkg-config', version: '>=4.2.0')
>    # slirp < 4.7 is incompatible with CFI support in QEMU.  This is because
>    # it passes function pointers within libslirp as callbacks for timers.
>    # When using a system-wide shared libslirp, the type information for the
> diff --git a/net/slirp.c b/net/slirp.c
> index 451c0fd1ba..b0b03b2bf5 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -1159,6 +1159,12 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
>                         "forwarding rule '%s'", config_str);
>              return -1;
>          }
> +    } else if (g_str_has_prefix(p, "unix-per-connection:")) {
> +        if (slirp_add_unix(s->slirp, &p[20], &server, port) < 0) {
> +            error_setg(errp, "Conflicting/invalid host:port in guest "
> +                       "forwarding rule '%s'", config_str);
> +            return -1;
> +        }
>      } else {
>          Error *err = NULL;
>          /*
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5fe9d73eaa..062cd39aa3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3553,6 +3553,15 @@ SRST
>              # and connect the TCP stream to its stdin/stdout
>              |qemu_system| -nic  'user,id=n1,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'
>  
> +    ``guestfwd=[tcp]:server:port-unix-per-connection:path``
> +        With ``unix-per-connection:``, a new connection is opened to the
> +        given unix socket per TCP connection made by the guest. The unix socket
> +        need not exist at startup time.
> +
> +        .. parsed-literal::
> +
> +            |qemu_system| -nic user,guestfwd=tcp:10.0.2.100:1234-unix-per-connection:/tmp/socket
> +
>  ``-netdev tap,id=id[,fd=h][,ifname=name][,script=file][,downscript=dfile][,br=bridge][,helper=helper]``
>      Configure a host TAP network backend with ID id.
>  
> 
> base-commit: 71f25c75417d31c214ba2cd26b273c114fc99987
> -- 
> 2.55.0
> 

-- 
Samuel
 PS> Salut ! J'ai un sujet de philo à vous soumettre : "Suffit-il
 PS> d'observer pour connaître" Idées + plan Merçi
 Oui, ya qu'a t'observer pour connaître le fait que tu es une feignasse.
 -+- FF in: Guide du Neuneu d'Usenet - Neuneu fait de la philo -+-

