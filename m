Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45497C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiUR-0005Kv-Qy; Mon, 24 Mar 2025 10:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1twiUH-0005G8-47
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1twiU8-0005ZU-K6
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742825334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hA9M1B4yvdck0fn8XvTOk+NM2ZGOZygG00aXXl1W8WA=;
 b=C3wTA3aV8pGj78DdSoeYoiAm9xmhnNYzRbSgsQPHc+fG95ubH/XQVi5XmUh2yLEZLSEQnQ
 RGpNgDY4zeDVwwWnGJ0x6+Vl5qWlnGlyVJOAgrNfdc2U8nHOZ78gwJIlVmSCjrWTZ8yBoz
 1wlo2AWQmZ+b7TZFm1Ih1V2PZu7nX9E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-MyZWDImqPM2oWwQTyEA2VA-1; Mon, 24 Mar 2025 10:08:53 -0400
X-MC-Unique: MyZWDImqPM2oWwQTyEA2VA-1
X-Mimecast-MFC-AGG-ID: MyZWDImqPM2oWwQTyEA2VA_1742825332
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so23045395e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742825332; x=1743430132;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hA9M1B4yvdck0fn8XvTOk+NM2ZGOZygG00aXXl1W8WA=;
 b=CyUEKC1Yi3DsX1AR7DeyCflCSPkySKywlwPnAHK9QGrutob8P4YzyCzZW8i2UP62/l
 p5HX1qctT0en25kDDu8FFaI079slfnmOU6OWoxO07HuQ8QcTIsyroyNtDRmy2OstbWKt
 DePw956UATHyY0E9fiWK7hXIyCqakzc/5EEVkMgR2DEvJGB23fW4NuuIV8uNg2mngR8E
 S2wNqx0woAiBC+ujDJlbV8OwffvaCEogI00pAKy1RIyTs/qNm7iAHnmEcKvdLuoJMrQE
 qqU9NU/CijWjGzBfgzqGb/0/lGKa7EV4qIlVCqP6mIMTmHECIbjSIw+IQ0k7eB7OA5Ba
 +7mg==
X-Gm-Message-State: AOJu0YxyCaNbva7ahvMHN1mwTn4xkUObKoIEYBRCIdmEUQfhc/Hc0loE
 FHBiUztBJMvFMzC/ZDn1SCpJx9SC9LUdPtKz/6y4X83S++KwNFb8IyssNFUyCR0++fNdnqsYGQk
 pFfeIp9q/HSYt3kiIxcOWk5oZKlN9RnsyMB8WDBVXpkYOQfWrBUjc
X-Gm-Gg: ASbGncvo667XAkgkUuLYeEdzLoopq4753TWJiaj9CwTqONqjrB/f8uhT3aGPOjFAJL3
 r//SIqXhN6jwUYLGyH1+pM9iOFv6i1kl40puCL+X431yw7noZ5Lmmv94/Tg57PhUkUEc2jq+Zcl
 hygFsxr4lqBBSVesN46u8HrkYEMoGeoa9VB6VRIECk0jEeX89XHYKnfNmL9tbIlQNTjjy0ym07Q
 y8Wj2vKmdXPktpwczscaLWsi/UF2UxTTLCuYB+z0ZGyCa04Bg5w5CNiOj+9+SIdSKNLkS2L4JQx
 nTJigMMGSA==
X-Received: by 2002:a05:600c:5025:b0:43d:300f:fa51 with SMTP id
 5b1f17b1804b1-43d509ea850mr116847205e9.9.1742825331703; 
 Mon, 24 Mar 2025 07:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5eyEfBYrHYad5NPuIHXvv4i4rmE+nrbwfMJLyCFh3yg9S41GdX7O/lCB15cVqAwmcY84LxA==
X-Received: by 2002:a05:600c:5025:b0:43d:300f:fa51 with SMTP id
 5b1f17b1804b1-43d509ea850mr116846595e9.9.1742825331115; 
 Mon, 24 Mar 2025 07:08:51 -0700 (PDT)
Received: from rh-jmarcin ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55c99sm173355095e9.24.2025.03.24.07.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 07:08:50 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:08:48 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/2] utils/qemu-sockets: Introduce
 keep-alive-idle-period inet socket option
Message-ID: <io7z2ds3sw66f75wlb5noln3wcewaek4hulm2ysho25siknh35@syhcgxoypjmn>
References: <20250319163638.456417-1-jmarcin@redhat.com>
 <20250319163638.456417-3-jmarcin@redhat.com>
 <Z-E-JNWlGYuTTK8t@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-E-JNWlGYuTTK8t@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2025-03-24 11:12, Daniel P. Berrangé wrote:
> On Wed, Mar 19, 2025 at 05:36:20PM +0100, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > The default idle period for TCP connection could be even 2 hours.
> > However, in some cases, the application needs to be aware of a
> > connection issue much sooner.
> > 
> > This is the case, for example, for postcopy live migration. If there is
> > no traffic from the migration destination guest (server-side) to the
> > migration source guest (client-side), the destination keeps waiting for
> > pages indefinitely and does not switch to the postcopy-paused state.
> > This can happen, for example, if the destination QEMU instance is
> > started with '-S' command line option and the machine is not started yet
> > or if the machine is idle and produces no new page faults for
> > not-yet-migrated pages.
> > 
> > This patch introduces a new inet socket parameter on platforms where
> > TCP_KEEPIDLE is defined and passes the configured value to the
> > TCP_KEEPIDLE socket option when a client-side or server-side socket is
> > created.
> > 
> > The default value is 0, which means system configuration is used, and no
> > custom value is set.
> > 
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  io/dns-resolver.c   |  4 ++++
> >  meson.build         |  2 ++
> >  qapi/sockets.json   |  5 +++++
> >  util/qemu-sockets.c | 29 +++++++++++++++++++++++++++++
> >  4 files changed, 40 insertions(+)
> > 
> > diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> > index ee7403b65b..03c59673f0 100644
> > --- a/io/dns-resolver.c
> > +++ b/io/dns-resolver.c
> > @@ -128,6 +128,10 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
> >  #endif
> >              .has_keep_alive = iaddr->has_keep_alive,
> >              .keep_alive = iaddr->keep_alive,
> > +#ifdef HAVE_TCP_KEEPIDLE
> > +            .has_keep_alive_idle_period = iaddr->has_keep_alive_idle_period,
> > +            .keep_alive_idle_period = iaddr->keep_alive_idle_period,
> > +#endif
> >          };
> >  
> >          (*addrs)[i] = newaddr;
> 
> I feel like this code is somewhat fragile. It is probably best to add a
> commit that refactors it to do a struct copy, and then override the few
> fields that need to be different.
> 
>      newaddr->u.inet = iaddr;
>      newaddr->u.inet.host = g_strdup(uaddr);
>      ...
> 
> that way we don't risk forgetting to copy fields as fixed in the previous
> commit
> 
> > diff --git a/meson.build b/meson.build
> > index 41f68d3806..e3440b09c8 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2734,6 +2734,8 @@ if linux_io_uring.found()
> >    config_host_data.set('HAVE_IO_URING_PREP_WRITEV2',
> >                         cc.has_header_symbol('liburing.h', 'io_uring_prep_writev2'))
> >  endif
> > +config_host_data.set('HAVE_TCP_KEEPIDLE',
> > +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPIDLE'))
> >  
> >  # has_member
> >  config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
> > diff --git a/qapi/sockets.json b/qapi/sockets.json
> > index eb50f64e3a..ddd82b1e66 100644
> > --- a/qapi/sockets.json
> > +++ b/qapi/sockets.json
> > @@ -59,6 +59,10 @@
> >  # @keep-alive: enable keep-alive when connecting to/listening on this socket.
> >  #     (Since 4.2, not supported for listening sockets until 10.0)
> >  #
> > +# @keep-alive-idle-period: time in seconds the connection needs to be idle
> > +#     before sending a keepalive packet.  Only supported for TCP sockets on
> > +#     systems where TCP_KEEPIDLE socket option is defined.  (Since 10.0)
> 
> There are three tunables for keepalive on TCP sockets:
> 
>    TCP_KEEPCNT (since Linux 2.4)
>        The maximum number of keepalive probes TCP should send before
>        dropping the connection.  This option should not be used in
>        code intended to be portable.
> 
>    TCP_KEEPIDLE (since Linux 2.4)
>        The time (in seconds) the connection needs to remain idle
>        before TCP starts sending keepalive probes, if the socket
>        option SO_KEEPALIVE has  been  set  on  this socket.  This
>        option should not be used in code intended to be portable.
> 
>    TCP_KEEPINTVL (since Linux 2.4)
>        The time (in seconds) between individual keepalive probes.
>        This option should not be used in code intended to be portable.
> 
> Shouldn't we be supporting all of these, rather than just a subset ?

They were not strictly necessary for the Live Migration use case, but I
can also include them in the next version.

Thank you for your feedback, also for the first patch.

Best regards,

Juraj Marcin

> 
> > +#
> >  # @mptcp: enable multi-path TCP.  (Since 6.1)
> >  #
> >  # Since: 1.3
> > @@ -71,6 +75,7 @@
> >      '*ipv4': 'bool',
> >      '*ipv6': 'bool',
> >      '*keep-alive': 'bool',
> > +    '*keep-alive-idle-period': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPIDLE' },
> >      '*mptcp': { 'type': 'bool', 'if': 'HAVE_IPPROTO_MPTCP' } } }
> >  
> >  ##
> 
> > @@ -697,6 +710,22 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
> >          }
> >          addr->has_keep_alive = true;
> >      }
> > +#ifdef HAVE_TCP_KEEPIDLE
> > +    begin = strstr(optstr, ",keep-alive-idle-period=");
> 
> A bit too verbose - make it just 'keep-alive-idle='
> 
> > +    if (begin) {
> > +        begin += strlen(",keep-alive-idle-period=");
> > +        if (sscanf(begin, "%" PRIu32 "%n", &addr->keep_alive_idle_period, &pos) != 1 ||
> > +            (begin[pos] != '\0' && begin[pos] != ',')) {
> > +            error_setg(errp, "error parsing keep-alive-idle-period argument");
> > +            return -1;
> > +        }
> > +        if (addr->keep_alive_idle_period > INT_MAX) {
> > +            error_setg(errp, "keep-alive-idle-period value is too large");
> > +            return -1;
> > +        }
> > +        addr->has_keep_alive_idle_period = true;
> > +    }
> > +#endif
> >  #ifdef HAVE_IPPROTO_MPTCP
> >      begin = strstr(optstr, ",mptcp");
> >      if (begin) {
> > -- 
> > 2.48.1
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 


