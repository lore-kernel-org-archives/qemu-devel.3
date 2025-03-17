Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FE1C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBIN-0006lj-Ol; Mon, 17 Mar 2025 10:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tuBIM-0006lS-No
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tuBIK-0007km-HY
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742221095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zSZ8Do+JUpykJ2zCQhUxERaTrqkaxuPL1EfpZMPmHTI=;
 b=Ly2mXOEeRoCSbJMIVjPcf1cgC9JVYa1g5cp9Ue1cQPx84DnQnplcpnpQNL9pzTdgFp582F
 5tbSoHf6t6m/w8Kpetbb7ERpoYPfugjb2SKHQAf0Zna/CHGKHz2cCNrmbVZ5CGjQnAPrr9
 TAK6abhyAWFmNfd4mPNZMglx+EJKZ1s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-vGbgpIsvNVm7Td2oxVF79A-1; Mon, 17 Mar 2025 10:18:13 -0400
X-MC-Unique: vGbgpIsvNVm7Td2oxVF79A-1
X-Mimecast-MFC-AGG-ID: vGbgpIsvNVm7Td2oxVF79A_1742221092
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so11385575e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221092; x=1742825892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSZ8Do+JUpykJ2zCQhUxERaTrqkaxuPL1EfpZMPmHTI=;
 b=YARKvQssmuXnYChuZbY5TQc9vm/V4aMExxVOXKWfjU+bmIBlFDSWueXgbqtyLHfQkN
 RzQXwz+szTsdX7Dw+mC+uJqnfe0g3PEktHLSrZrXV4l527MeZNLZMuSXkaYSCkgTmHE1
 mHBClmFRhgsHWrPdrN93Wh0fURYUkCvqkQy6LHMeI/mKYHPenk+7L/vIhus17PejEAm0
 llSvqDRfmzoJF304HyifnbTn7oloqiCU4PGSYx76dIZ8YLT7fwykiLFiIOZhmQvrJIHM
 m2dEOOqWbrMR2wb5W39kBElFCJkOGPFE4kxshlMWmsz8v0wOeuXBMugCvJdRPiAtm0/X
 R7eA==
X-Gm-Message-State: AOJu0YxPLTEPWF6VgmEP+jTIdjeJfm8M60SpgqqIMEd4afIVgUCp1ARI
 Qgnc4WxhLp6jcR+JyfSLQMwHNEw+oVr1G0ug12yN27UKMDCvSOnt6cGQVQC5tr9tgluEbtS8VZ7
 W/H7XWZkiAhYD/uKTGUWFqHs5pfWGao3gyrVovcUOLtMqZaUAGXm/
X-Gm-Gg: ASbGncvrCT2RfWaPQSBYwVJ2u+Cyg45HgS2taOATXpnRNGu+LohG3JSLHJkubqA+HLO
 TK52ZKiTDkCjwUrMB+TBX7MJFMVMesjQGNQEpo9ONCIfm09mEbcAiLVbETzbScK6rIo1Alh0K0c
 j0wZYLneKbdsx4WVmluvE2c8NHRx/h1Mt+zEr9KOFoI5kI8RILkjskb4fwS2S4P6x6N9EeFhvS5
 yUc0VlCCxabD14eL52TmggB9CBJpffOAyN/WixXkR1qOO3PTpsXTwOLDuyVM84bz+nGZCbLByP0
 t8XlUyuZvQ==
X-Received: by 2002:a05:600c:4451:b0:43c:fa24:8721 with SMTP id
 5b1f17b1804b1-43d1ec8a44cmr128896685e9.17.1742221092094; 
 Mon, 17 Mar 2025 07:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3kITUxkS53hQ/af6lqcfNUNwqZnhcJaxt7iESKS4HX/Yz/FY1iAC4t9+XcraSANS3NMYxSQ==
X-Received: by 2002:a05:600c:4451:b0:43c:fa24:8721 with SMTP id
 5b1f17b1804b1-43d1ec8a44cmr128896305e9.17.1742221091429; 
 Mon, 17 Mar 2025 07:18:11 -0700 (PDT)
Received: from rh-jmarcin ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm106961425e9.2.2025.03.17.07.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:18:11 -0700 (PDT)
Date: Mon, 17 Mar 2025 15:18:08 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] util/qemu-sockets: Add support for keep-alive flag
 to passive sockets
Message-ID: <vlbkduq3jivca5je6fwgfb6dwxf6jyv5mb474ilx7gpywjemki@3rwsttdfcshp>
References: <20250303143312.640909-1-jmarcin@redhat.com>
 <20250303143312.640909-2-jmarcin@redhat.com>
 <8ca88996-07e7-4882-8169-328b599e5570@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ca88996-07e7-4882-8169-328b599e5570@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025-03-14 20:24, Vladimir Sementsov-Ogievskiy wrote:
> On 03.03.25 17:33, Juraj Marcin wrote:
> > Commit aec21d3175 (qapi: Add InetSocketAddress member keep-alive)
> > introduces the keep-alive flag, which enables the SO_KEEPALIVE socket
> > option, but only on client-side sockets. However, this option is also
> > useful for server-side sockets, so they can check if a client is still
> > reachable or drop the connection otherwise.
> > 
> > This patch enables the SO_KEEPALIVE socket option on passive server-side
> > sockets if the keep-alive flag is enabled. This socket option is then
> > inherited by active server-side sockets communicating with connected
> > clients.
> > 
> > This patch also fixes an issue in 'qio_dns_resolver_lookup_sync_inet()'
> > where the keep-alive flag is not copied together with other attributes.
> > 
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >   io/dns-resolver.c   |  2 ++
> >   qapi/sockets.json   |  4 ++--
> >   util/qemu-sockets.c | 19 +++++++++++++------
> >   3 files changed, 17 insertions(+), 8 deletions(-)
> > 
> > diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> > index 53b0e8407a..ee7403b65b 100644
> > --- a/io/dns-resolver.c
> > +++ b/io/dns-resolver.c
> > @@ -126,6 +126,8 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
> >               .has_mptcp = iaddr->has_mptcp,
> >               .mptcp = iaddr->mptcp,
> >   #endif
> > +            .has_keep_alive = iaddr->has_keep_alive,
> > +            .keep_alive = iaddr->keep_alive,
> >           };
> >           (*addrs)[i] = newaddr;
> > diff --git a/qapi/sockets.json b/qapi/sockets.json
> > index 6a95023315..eb50f64e3a 100644
> > --- a/qapi/sockets.json
> > +++ b/qapi/sockets.json
> > @@ -56,8 +56,8 @@
> >   # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
> >   #     IPv6
> >   #
> > -# @keep-alive: enable keep-alive when connecting to this socket.  Not
> > -#     supported for passive sockets.  (Since 4.2)
> > +# @keep-alive: enable keep-alive when connecting to/listening on this socket.
> > +#     (Since 4.2, not supported for listening sockets until 10.0)
> >   #
> >   # @mptcp: enable multi-path TCP.  (Since 6.1)
> >   #
> > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > index 77477c1cd5..c30e4ac2ce 100644
> > --- a/util/qemu-sockets.c
> > +++ b/util/qemu-sockets.c
> > @@ -220,12 +220,6 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
> >       int saved_errno = 0;
> >       bool socket_created = false;
> > -    if (saddr->keep_alive) {
> > -        error_setg(errp, "keep-alive option is not supported for passive "
> > -                   "sockets");
> > -        return -1;
> > -    }
> > -
> >       memset(&ai,0, sizeof(ai));
> >       ai.ai_flags = AI_PASSIVE;
> >       if (saddr->has_numeric && saddr->numeric) {
> > @@ -344,6 +338,19 @@ listen_failed:
> >       return -1;
> >   listen_ok:
> > +    if (saddr->keep_alive) {
> > +        int val = 1;
> > +        int ret = setsockopt(slisten, SOL_SOCKET, SO_KEEPALIVE,
> > +                             &val, sizeof(val));
> > +
> > +        if (ret < 0) {
> > +            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
> > +            close(slisten);
> 
> previous code do the trick to not rewrite errno by close() call. I'm not sure it's really needed, but consistency counts. So should do the same here. Or drop the logic around errno at all in this function if it's not really needed (need to check the callers).
> 
> Or this way: just goto listen_failed here. And don't add extra "exit:" label. And to make final code more readable, move "listen_failed:" block to the and of the function and rename to just "fail:" (better to do it in additional preparation patch).

Good point, I will update it. Thank you.

> 
> > +            slisten = -1;
> > +            goto exit;
> > +        }
> > +    }
> > +exit:
> >       freeaddrinfo(res);
> >       return slisten;
> >   }
> 
> -- 
> Best regards,
> Vladimir
> 
> 


