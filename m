Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D755CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 14:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uojx1-0002Wu-TI; Wed, 20 Aug 2025 10:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uojwz-0002Vs-4w
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uojwv-0000za-Sm
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755700680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jppW6HcDvdqelkJVNJoAj37I7kiH0gi3XN/Kui+b5o=;
 b=DtT7y5PS2hMldXt60y4noBrqiAVm7TmnVtE/ElpSIW0xDuFDlMRYb5Eden5G/Kn28Cc2ZA
 7u3lqc8lLs/HY3luaEZZGFTGNYATD9AHUMyhfU+vi0BVztIq8xd21LR0miihqq42ghrCaH
 Wkvc7DrPjvgPmXRsZ7lZIHxAS1RaVFY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-9VtejQg5OdOhz3r2UxbiDw-1; Wed, 20 Aug 2025 10:37:59 -0400
X-MC-Unique: 9VtejQg5OdOhz3r2UxbiDw-1
X-Mimecast-MFC-AGG-ID: 9VtejQg5OdOhz3r2UxbiDw_1755700678
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-71d60b39826so85147227b3.3
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 07:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755700678; x=1756305478;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3jppW6HcDvdqelkJVNJoAj37I7kiH0gi3XN/Kui+b5o=;
 b=UCokFdNAyWs2WXP2ulpjOnyN6YB8fV9B1phHqeOhfBHhs4NaeFKINemynOsQH3cTu9
 h4yHzHyWH8/N/pUT1wSwDsawoPgO5ZTU/1FhMrC/O+bvDV3BmB9/Ib24aDx087xv05Uh
 mi7vU9UPe83mQGg42zDEc3nGVc7AvAERPpI+oCIxEnYf1dByKxUdRN1mAr1Sw7pWGIHt
 0LsZ7MUENvoKJPdLJe+7C4WAh3Af6LrnWBbfLZ4MxyZKLjjtb1S1jW2X+baJ7rchBnEK
 d33nOV1P5y0dc8w3Y+Vb4ZoQGsAa2+/m6kB55q27n34p6HC0oXrjklt2eUaday/Cfj+7
 SSVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw6pkM54LX40wnd51lmi7JGnLoMiFLjocYCpI1lxl+pLfgaFLPRXOMRT+6lnYTRhJDyqzF4azq1goR@nongnu.org
X-Gm-Message-State: AOJu0Yy2VXVIjOJwAQK++LrMNA4sm3h3cPi4SwUob/lb8t/7R82NOwZv
 a83pczn7tK+XRq+ufOE6YCRk8M7uqqYEHU7Sic/8Fd/zjGdrusGVjbFD5WsY53yxhonunIdA+rO
 cmcrlXW8Ke/tDZ8eew5MNsGc5uwSBu4Z+R2FFTev7afZ5/sidU7iSDxFh
X-Gm-Gg: ASbGncu1lbyMVC6HHaRc3yl0xCZDjjZXIoE9ExbCcFDOPd90duqIToot5Ygq+I3ogEY
 Clwo8l+I8xz1Z3q8md6Gdm8nAmV/ApLS3ddVqw11yDUOvjHqUBfYLz9VtZCfKqq7EHxLBScKoNC
 OK6F/1hGc+ltgIno98orrZh7hf1NYj+t1Jb0RG3AyJfUxHprRyPevdwYqNkHmw3nC6wsrD4Vtw2
 yKNORl3pZQkEfDCF2ABDzaK7mf9JFL9L2VF18anGecIG82tHp7YhPZI91FC1/EXPp99aUQ2NecM
 nNfMeej0rsa//HNq1SXvfGNC0UtYQ4cg
X-Received: by 2002:a05:690c:7a1:b0:71c:1754:26a0 with SMTP id
 00721157ae682-71fb320e837mr37915797b3.19.1755700678353; 
 Wed, 20 Aug 2025 07:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoYjHLc56azZY6qVDgnmT4BDkIdmTTlP2powo6ZiwerBVbGYMqCfLWU2xIwtg0q0BNnW9uOQ==
X-Received: by 2002:a05:690c:7a1:b0:71c:1754:26a0 with SMTP id
 00721157ae682-71fb320e837mr37915467b3.19.1755700677959; 
 Wed, 20 Aug 2025 07:37:57 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71e6de96d4esm37389417b3.1.2025.08.20.07.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 07:37:57 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:37:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 mst@redhat.com, farosas@suse.de, raphael@enfabrica.net,
 sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
Subject: Re: [PATCH 26/33] io/channel-socket: introduce
 qio_channel_socket_keep_nonblock()
Message-ID: <aKXdtd8OIkdPCHP3@x1.local>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-27-vsementsov@yandex-team.ru>
 <aKXNLfKWzHKUhGaz@x1.local> <aKXRGiDQlyPyhNsh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKXRGiDQlyPyhNsh@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 20, 2025 at 02:43:54PM +0100, Daniel P. Berrangé wrote:
> On Wed, Aug 20, 2025 at 09:27:09AM -0400, Peter Xu wrote:
> > On Wed, Aug 13, 2025 at 07:48:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Add a possibility to keep socket non-block status when passing
> > > through qio channel. We need this to support migration of open
> > > fds through migration channel.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > ---
> > >  include/io/channel-socket.h |  3 +++
> > >  io/channel-socket.c         | 16 ++++++++++++----
> > >  2 files changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> > > index a88cf8b3a9..0a4327d745 100644
> > > --- a/include/io/channel-socket.h
> > > +++ b/include/io/channel-socket.h
> > > @@ -49,6 +49,7 @@ struct QIOChannelSocket {
> > >      socklen_t remoteAddrLen;
> > >      ssize_t zero_copy_queued;
> > >      ssize_t zero_copy_sent;
> > > +    bool keep_nonblock;
> > >  };
> > >  
> > >  
> > > @@ -275,4 +276,6 @@ int qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc,
> > >                                         size_t size,
> > >                                         Error **errp);
> > >  
> > > +void qio_channel_socket_keep_nonblock(QIOChannel *ioc);
> > > +
> > >  #endif /* QIO_CHANNEL_SOCKET_H */
> > > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > > index 3b7ca924ff..cd93d7f180 100644
> > > --- a/io/channel-socket.c
> > > +++ b/io/channel-socket.c
> > > @@ -462,9 +462,16 @@ static void qio_channel_socket_finalize(Object *obj)
> > >  }
> > >  
> > >  
> > > +void qio_channel_socket_keep_nonblock(QIOChannel *ioc)
> > > +{
> > > +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> > > +    sioc->keep_nonblock = true;
> > > +}
> > > +
> > > +
> > >  #ifndef WIN32
> > >  static void qio_channel_socket_copy_fds(struct msghdr *msg,
> > > -                                        int **fds, size_t *nfds)
> > > +                                        int **fds, size_t *nfds, bool set_block)
> > >  {
> > >      struct cmsghdr *cmsg;
> > >  
> > > @@ -497,8 +504,9 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
> > >                  continue;
> > >              }
> > >  
> > > -            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> > > -            qemu_socket_set_block(fd);
> > > +            if (set_block) {
> > > +                qemu_socket_set_block(fd);
> > > +            }
> > 
> > "keep_nonblock" as a feature in iochannel is slightly hard to digest.  It
> > can also be read as "keep the fd to be always nonblocking".
> > 
> > Is this feature required, or can this also be done in a get() or
> > post_load() on the other side to set nonblock to whatever it should be
> > (that dest QEMU should be aware of)?
> 
> Either we preserve state of the flag when receiving the FD,
> or every QEMU backend that we're receiving FDs on behalf of
> needs to reset the flag when migration passes over the FD.
> 
> The latter might actually be a more robust scheme. If we're
> migrating across QEMU versions, there is not a strict
> guarantee that the new QEMU version's backend will want the
> O_NONBLOCK flag in the same state as the old QEMU version.
> The code might have been re-written to work in a different
> way than previously.

Good point.

Do you remember why we reset that in the very initial git commit?

Thanks,

-- 
Peter Xu


