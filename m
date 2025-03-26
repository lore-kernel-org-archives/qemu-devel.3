Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4165C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQ4b-00051h-Tp; Wed, 26 Mar 2025 08:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1txQ4E-0004n7-9s
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1txQ4A-0000iQ-Sj
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742992864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pb7AbEPISotCCDmddMUCjH4+TnRCiGD446XtsauwMeo=;
 b=gGjDnsU7T3KMTvS/dRFnkjMU1opHua/sdh4Z5+9mFyzdBAz0pzZOvMnb1UAolVAiCSSYtm
 hUU64EcWJBevWZWoR7usFUWnjm3uz4g0XdRC9QMOpnb3wKi+oo+xUknOm23+3rJK/Gn6we
 AwRYW0aDE3DlSI9NfwVqMzFlYjL5S4E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-PHzlxEpePJisd_eKSZOZ1A-1; Wed, 26 Mar 2025 08:41:02 -0400
X-MC-Unique: PHzlxEpePJisd_eKSZOZ1A-1
X-Mimecast-MFC-AGG-ID: PHzlxEpePJisd_eKSZOZ1A_1742992861
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39ac9b0cb6aso1208820f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 05:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742992861; x=1743597661;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pb7AbEPISotCCDmddMUCjH4+TnRCiGD446XtsauwMeo=;
 b=lbfN9FWYJjLttJjKIOrxP4vSCW2yANw7FhnnBvowoSXu8PP8ObAkHl/a9Rmauce1Om
 YGp11T9ThJemDk4BUoxj3ebvBmJGLdgGpT6O+4m23NzCCLHFIF49gR98H+QRIKmN4PPg
 b+8jYixKQBfOuVIRbbXDVLiwpbHFSKr92usplTF/beQRHzc3GRbr4pktAa71kK6PZA42
 qGNZagAfRskpRvFl7JI0a8D/TLP8UkOAg+D4aWJ521DTKOcTBYaXsI9tJA7VDj7bT9C1
 S4U6GRbLZSb8+N5lOjBlfqQ5gri9e0Ftex6DO15eVC1o/OMW6fUDjclSCnYxCTWoyYyv
 hQHg==
X-Gm-Message-State: AOJu0YzK+3fy4vqFQ40atvE+ffM4d3ZOsyCLmoqlxHLGrHekb2wACZ1b
 B29FAFW1aBMnY+r0WxOIW1n4Qiwg2zs31yi31rY2wLw07Z6728USPrp9Xhdb+F5FkcoXcM+ybES
 Tx29aH7WtYG0fdGpil60c7c3inxap/WyRfVG6N/uQDX0hzQJRJtiDuJz1WAWJqMA=
X-Gm-Gg: ASbGncuMk/osN7GtLxqT1ZQ09VqbGKZ0lO8104X9Cq5c5yMnvAYgvmKUj6sqB8g4s+3
 TZGaquB0+l2boKqdvDofnwxgnyOJwR4g5SCzzlwt5mD5iFkfp0c3pePHwKAYgUDSyR82VNffk2I
 r/7Z5d2eGP0b+qBbmn3O+s+xhZLojg7vxrn0VVVz2U564tPHx7X+6Y6XwdNXVuPK2N/agBnPlRG
 1kVKqFL+AIkFqzOJ2Fr++kjCITD4m3IcSDeUaTxeKt4hx7VRSUyBo8tYDOZ3oCIgQQSY+Dhljzy
 tcLKkyy6pA==
X-Received: by 2002:a05:6000:178b:b0:391:4c0c:c807 with SMTP id
 ffacd0b85a97d-3997f942453mr19687694f8f.53.1742992860820; 
 Wed, 26 Mar 2025 05:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkbdH8g/MxK/0PgD+WobwxzKLhtVveNA48Aa0E0ixQeEUCmOe27r+9ZU6ZITB2beaLkJssFw==
X-Received: by 2002:a05:6000:178b:b0:391:4c0c:c807 with SMTP id
 ffacd0b85a97d-3997f942453mr19687653f8f.53.1742992860265; 
 Wed, 26 Mar 2025 05:41:00 -0700 (PDT)
Received: from rh-jmarcin ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efca6sm16903932f8f.93.2025.03.26.05.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 05:40:59 -0700 (PDT)
Date: Wed, 26 Mar 2025 13:40:57 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/2] util/qemu-sockets: Add support for keep-alive
 flag to passive sockets
Message-ID: <b43i4ekfqmmqka5tifr26jv3o5hj2qzclyccgnrjxbjju3d35b@yim2qc4x4yph>
References: <20250319163638.456417-1-jmarcin@redhat.com>
 <20250319163638.456417-2-jmarcin@redhat.com>
 <Z-E0Te99X7LOeLj6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-E0Te99X7LOeLj6@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Daniel,

On 2025-03-24 10:30, Daniel P. Berrangé wrote:
> On Wed, Mar 19, 2025 at 05:36:19PM +0100, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
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
> >  io/dns-resolver.c   |  2 ++
> >  qapi/sockets.json   |  4 ++--
> >  util/qemu-sockets.c | 52 +++++++++++++++++++++++++--------------------
> >  3 files changed, 33 insertions(+), 25 deletions(-)
> > 
> > diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> > index 53b0e8407a..ee7403b65b 100644
> > --- a/io/dns-resolver.c
> > +++ b/io/dns-resolver.c
> > @@ -126,6 +126,8 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
> >              .has_mptcp = iaddr->has_mptcp,
> >              .mptcp = iaddr->mptcp,
> >  #endif
> > +            .has_keep_alive = iaddr->has_keep_alive,
> > +            .keep_alive = iaddr->keep_alive,
> >          };
> >  
> >          (*addrs)[i] = newaddr;
> 
> This is a bugfix, so should be a separate commit to facilitate cherry
> picking back to stable branches.
> 
> > diff --git a/qapi/sockets.json b/qapi/sockets.json
> > index 6a95023315..eb50f64e3a 100644
> > --- a/qapi/sockets.json
> > +++ b/qapi/sockets.json
> > @@ -56,8 +56,8 @@
> >  # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
> >  #     IPv6
> >  #
> > -# @keep-alive: enable keep-alive when connecting to this socket.  Not
> > -#     supported for passive sockets.  (Since 4.2)
> > +# @keep-alive: enable keep-alive when connecting to/listening on this socket.
> > +#     (Since 4.2, not supported for listening sockets until 10.0)
> 
> This needs to be '10.1', since we're past feature freeze for '10.0'
> 
> >  #
> >  # @mptcp: enable multi-path TCP.  (Since 6.1)
> >  #
> > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > index 77477c1cd5..99357a4435 100644
> > --- a/util/qemu-sockets.c
> > +++ b/util/qemu-sockets.c
> > @@ -205,6 +205,22 @@ static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
> >  #endif
> >  }
> >  
> > +static int inet_set_sockopts(int sock, InetSocketAddress *saddr, Error **errp)
> > +{
> > +    if (saddr->keep_alive) {
> > +        int keep_alive = 1;
> > +        int ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
> > +                             &keep_alive, sizeof(keep_alive));
> > +
> > +        if (ret < 0) {
> > +            error_setg_errno(errp, errno,
> > +                             "Unable to set keep-alive option on socket");
> > +            return -1;
> > +        }
> > +    }
> > +    return 0;
> > +}
> > +
> >  static int inet_listen_saddr(InetSocketAddress *saddr,
> >                               int port_offset,
> >                               int num,
> > @@ -220,12 +236,6 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
> >      int saved_errno = 0;
> >      bool socket_created = false;
> >  
> > -    if (saddr->keep_alive) {
> > -        error_setg(errp, "keep-alive option is not supported for passive "
> > -                   "sockets");
> > -        return -1;
> > -    }
> > -
> >      memset(&ai,0, sizeof(ai));
> >      ai.ai_flags = AI_PASSIVE;
> >      if (saddr->has_numeric && saddr->numeric) {
> > @@ -313,13 +323,18 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
> >                      goto listen_failed;
> >                  }
> >              } else {
> > -                if (!listen(slisten, num)) {
> > +                if (listen(slisten, num)) {
> > +                    if (errno != EADDRINUSE) {
> > +                        error_setg_errno(errp, errno,
> > +                                         "Failed to listen on socket");
> > +                        goto listen_failed;
> > +                    }
> 
> The implicit '} else {' fallthough is a success code path,
> but you're failing to set socket opts in that case. We
> accept that the socket might already be listening, but
> we must still ensure the keepalives are set.

Actually, it is not a success code path. Regardless of how 'listen()'
fails, it is still a failure. The only difference is that with
'EADDRINUSE' it does not fail completely, but it continues with
'close()' at the end of the loop and tries the next port. This is the
same behaviour as before:


    rc = try_bind(slisten, saddr, e);
    if (rc < 0) {
        if (errno != EADDRINUSE) {
            error_setg_errno(errp, errno, "Failed to bind socket");
            /*** don't try next ports, just fail ***/
            goto listen_failed;
        }
        /*** close this one and try the next port ***/
    } else {
        if (!listen(slisten, num)) {
            /*** the only success path ***/
            goto listen_ok;
        }
        if (errno != EADDRINUSE) {
            error_setg_errno(errp, errno, "Failed to listen on socket");
            /*** don't try next ports, just fail ***/
            goto listen_failed;
        }
        /*** close this one and try the next port ***/
    }
    /* Someone else managed to bind to the same port and beat us
     * to listen on it! Socket semantics does not allow us to
     * recover from this situation, so we need to recreate the
     * socket to allow bind attempts for subsequent ports:
     */
    close(slisten);
    slisten = -1;


This loop probably deserves some more refactoring before modifying.

Best regards,

Juraj Marcin

> 
> > +                } else {
> > +                    if (inet_set_sockopts(slisten, saddr, errp)) {
> > +                        goto listen_failed;
> > +                    }
> >                      goto listen_ok;
> >                  }
> 
> Stylewise, don't nest the success codepath - this also would
> fix the comment above.
> 
> > -                if (errno != EADDRINUSE) {
> > -                    error_setg_errno(errp, errno, "Failed to listen on socket");
> > -                    goto listen_failed;
> > -                }
> >              }
> >              /* Someone else managed to bind to the same port and beat us
> >               * to listen on it! Socket semantics does not allow us to
> > @@ -474,19 +489,10 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
> >          error_propagate(errp, local_err);
> >          return sock;
> >      }
> > -
> > -    if (saddr->keep_alive) {
> > -        int val = 1;
> > -        int ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
> > -                             &val, sizeof(val));
> > -
> > -        if (ret < 0) {
> > -            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
> > -            close(sock);
> > -            return -1;
> > -        }
> > +    if (inet_set_sockopts(sock, saddr, errp)) {
> > +        close(sock);
> > +        return -1;
> >      }
> 
> This is the refactoring of existing code into a separate function. This
> can be done in a separate commit, then the new feature of adding it to
> the listener socket codepath  can be a followon commit.
> 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 


