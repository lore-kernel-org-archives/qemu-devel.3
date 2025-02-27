Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4915C282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tni7e-0003OW-Kx; Thu, 27 Feb 2025 12:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tni7c-0003HA-LU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tni7Z-0004UO-SW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740678987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgybdmoWnngaX0YM5Qbp9bCFPOqwt7Nf7cmvf1Z32p4=;
 b=FxU4yWCx5HBK45Mb+2gkFj/OCP6xfvHrs+4r9Z0gXPfEUtfwlj9mmgqnEc72tIR0q1DAkw
 4xJoKuVxdCwhJq8LTsisrjen4Pcz/oxXn7JTK8jN4y7vbjRd33ummL8kXDQM97MT9WHppk
 ctEsMQ8S8x17PUAN0ah4h5SoqTQ46Hs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-BuTNrOQPPWyW3Bs-d8ZafA-1; Thu, 27 Feb 2025 12:56:24 -0500
X-MC-Unique: BuTNrOQPPWyW3Bs-d8ZafA-1
X-Mimecast-MFC-AGG-ID: BuTNrOQPPWyW3Bs-d8ZafA_1740678984
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e664e086f1so26978846d6.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740678984; x=1741283784;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgybdmoWnngaX0YM5Qbp9bCFPOqwt7Nf7cmvf1Z32p4=;
 b=JuJ1TUDGCYfNYaklRi3n4hozEVVpFAs24EbVhJIL+L5u9hrMLwMU4hkQhg35gC+04X
 5qGlJtLcNlbYQcAEkOX93Xmn+8fQUN2WbUGtS6NEBsHY0GYMsIyFbVPOj8WNFpKL19Tg
 Hnw76VTbypY9pbJ5igYp5TFuEOWVF5WV675phdzQkxwNrTfBNrwFRpGjtMEwubdqBPec
 jfjW4j6ZpLLFLMejJFTzen92K82fyqYHzyQX7klAPZc76EjDhYvrI3Md9PPYbpHFbVBI
 +1grmcFUmWxC1LrGsZijc+raiqlAH563saKzIXdSqg/Zlqgz5sj/QsbIN8I4KKgNoOCM
 eWsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDzOxqtJG+Oz/N8UiUjeGSXfxN664oEbZMShqUG97cEMOHwxwNr3eAtbkAW7FDLoyxXvMhZWHETzHi@nongnu.org
X-Gm-Message-State: AOJu0YxU1z4RYzkUGOpRhGwiuCpxrfVhVldkHdQ6JuHWuRDpiZwiMoqH
 rF6P7j8FaAEew9jezWaZhlsg7ThpyD7qF7RmxlZ1InROWNnGycfoMTFrHU63ZBQOpegD0xIvu2G
 uCzb4Xr00aGu0Bo5O2QwD0PiOdJ6EsqI4G5gyi4fNC3FayocBK3Kq
X-Gm-Gg: ASbGncs3aclT4XwlbtdSciCqHT9Sx4YnyntgHalEHcmHemf/VG1IvLtrqfAAWJvwU39
 w+UJlC9pZDmBGBx/Jx0PWLpbHI6I+fN9rNCCH5AThSguSGF99w+1EzOUrhoMknXpZ7J0lQn5UhB
 FiosJabHKzTa1NS4OKKn4lR8Zn1qro7OOLyqtifnwrIelUTchLSzhBkaygoLX7tMTdNSYoMn0r0
 fYX2RJDy9rhpkFtVvQcy+jeischlCiFJR6NrvhYUWExQfAnqFNZOIf+H6erjoniFgvxRbBTt9i5
 t7qW2IU=
X-Received: by 2002:a05:6214:dae:b0:6e8:9866:7398 with SMTP id
 6a1803df08f44-6e8a0d4e1c3mr4565556d6.22.1740678984083; 
 Thu, 27 Feb 2025 09:56:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGpmQHtJi8DXMlS4xjCO13YexJMk0z9c4xukDJKuNK9iYGa/cLADIpjCF3DxkyLzNmGMraSA==
X-Received: by 2002:a05:6214:dae:b0:6e8:9866:7398 with SMTP id
 6a1803df08f44-6e8a0d4e1c3mr4565286d6.22.1740678983654; 
 Thu, 27 Feb 2025 09:56:23 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976cca94sm12078006d6.77.2025.02.27.09.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:56:23 -0800 (PST)
Date: Thu, 27 Feb 2025 12:56:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Manish <manish.mishra@nutanix.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, leobras@redhat.com
Subject: Re: [PATCH] QIOChannelSocket: Flush zerocopy socket error queue on
 ENOBUF failure for sendmsg
Message-ID: <Z8CnRGOA_hxu39TN@x1.local>
References: <20250221094448.206845-1-manish.mishra@nutanix.com>
 <Z72ITCJlkz9711bU@redhat.com>
 <d87fa87c-46c0-4620-9741-fafb3b522e67@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d87fa87c-46c0-4620-9741-fafb3b522e67@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

On Thu, Feb 27, 2025 at 10:30:31PM +0530, Manish wrote:
> Again really sorry, missed this due to some issue with my mail filters and
> came to know about it via qemu-devel weblink. :)
> 
> On 25/02/25 2:37 pm, Daniel P. Berrangé wrote:
> > !-------------------------------------------------------------------|
> >    CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Fri, Feb 21, 2025 at 04:44:48AM -0500, Manish Mishra wrote:
> > > We allocate extra metadata SKBs in case of zerocopy send. This metadata memory
> > > is accounted for in the OPTMEM limit. If there is any error with sending
> > > zerocopy data or if zerocopy was skipped, these metadata SKBs are queued in the
> > > socket error queue. This error queue is freed when userspace reads it.
> > > 
> > > Usually, if there are continuous failures, we merge the metadata into a single
> > > SKB and free another one. However, if there is any out-of-order processing or
> > > an intermittent zerocopy failures, this error chain can grow significantly,
> > > exhausting the OPTMEM limit. As a result, all new sendmsg requests fail to
> > > allocate any new SKB, leading to an ENOBUF error.
> > IIUC, you are effectively saying that the migration code is calling
> > qio_channel_write() too many times, before it calls qio_channel_flush(.)
> > 
> > Can you clarify what yu mean by the "OPTMEM limit" here ? I'm wondering
> > if this is potentially triggered by suboptimal tuning of the deployment
> > environment or we need to document tuning better.
> 
> 
> I replied it on other thread. Posting it again.
> 
> We allocate some memory for zerocopy metadata, this is not accounted in
> tcp_send_queue but it is accounted in optmem_limit.
> 
> https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1607
> 
> Also when the zerocopy data is sent and acked, we try to free this
> allocated skb as we can see in below code.
> 
> https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1751
> 
> In case, we get __msg_zerocopy_callback() on continous ranges and
> skb_zerocopy_notify_extend() passes, we merge the ranges and free up the
> current skb. But if that is not the case, we insert that skb in error
> queue and it won't be freed until we do error flush from userspace. This
> is possible when either zerocopy packets are skipped in between or it is
> always skipped but we get out of order acks on packets. As a result this
> error chain keeps growing, exhausthing the optmem_limit. As a result
> when new zerocopy sendmsg request comes, it won't be able to allocate
> the metadata and returns with ENOBUF.
> 
> I understand there is another bug of why zerocopy pakcets are getting
> skipped and which could be our deployment specific. But anyway live
> migrations should not fail, it is fine to mark zerocopy skipped but not
> fail?
> 
> 
> > > To workaround this, if we encounter an ENOBUF error with a zerocopy sendmsg,
> > > we flush the error queue and retry once more.
> > > 
> > > Signed-off-by: Manish Mishra<manish.mishra@nutanix.com>
> > > ---
> > >   include/io/channel-socket.h |  1 +
> > >   io/channel-socket.c         | 52 ++++++++++++++++++++++++++++++++-----
> > >   2 files changed, 46 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> > > index ab15577d38..6cfc66eb5b 100644
> > > --- a/include/io/channel-socket.h
> > > +++ b/include/io/channel-socket.h
> > > @@ -49,6 +49,7 @@ struct QIOChannelSocket {
> > >       socklen_t remoteAddrLen;
> > >       ssize_t zero_copy_queued;
> > >       ssize_t zero_copy_sent;
> > > +    bool new_zero_copy_sent_success;
> > >   };
> > > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > > index 608bcf066e..c7f576290f 100644
> > > --- a/io/channel-socket.c
> > > +++ b/io/channel-socket.c
> > > @@ -37,6 +37,11 @@
> > >   #define SOCKET_MAX_FDS 16
> > > +#ifdef QEMU_MSG_ZEROCOPY
> > > +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> > > +                                             Error **errp);
> > > +#endif
> > > +
> > >   SocketAddress *
> > >   qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
> > >                                        Error **errp)
> > > @@ -65,6 +70,7 @@ qio_channel_socket_new(void)
> > >       sioc->fd = -1;
> > >       sioc->zero_copy_queued = 0;
> > >       sioc->zero_copy_sent = 0;
> > > +    sioc->new_zero_copy_sent_success = FALSE;
> > >       ioc = QIO_CHANNEL(sioc);
> > >       qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> > > @@ -566,6 +572,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> > >       size_t fdsize = sizeof(int) * nfds;
> > >       struct cmsghdr *cmsg;
> > >       int sflags = 0;
> > > +    bool zero_copy_flush_pending = TRUE;
> > >       memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
> > > @@ -612,9 +619,21 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> > >               goto retry;
> > >           case ENOBUFS:
> > >               if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
> > > -                error_setg_errno(errp, errno,
> > > -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
> > > -                return -1;
> > > +                if (zero_copy_flush_pending) {
> > > +                    ret = qio_channel_socket_flush_internal(ioc, errp);
> > Calling this is problematic, because qio_channel_socket_flush is
> > designed to block execution until all buffers are flushed. When
> > ioc is in non-blocking mode, this breaks the required semantics
> > of qio_channel_socket_writev which must return EAGAIN and not
> > block.
> > 
> > IOW, if we need to be able to flush at this point, we must be
> > able to do a partial flush, rather than blocking on a full
> > flush
> 
> sure
> 
> > > +                    if (ret < 0) {
> > > +                        error_setg_errno(errp, errno,
> > > +                                         "Zerocopy flush failed");
> > > +                        return -1;
> > > +                    }
> > > +                    zero_copy_flush_pending = FALSE;
> > > +                    goto retry;
> > > +                } else {
> > > +                    error_setg_errno(errp, errno,
> > > +                                     "Process can't lock enough memory for "
> > > +                                     "using MSG_ZEROCOPY");
> > > +                    return -1;
> > > +                }
> > >               }
> > >               break;
> > >           }
> > > @@ -725,8 +744,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> > >   #ifdef QEMU_MSG_ZEROCOPY
> > > -static int qio_channel_socket_flush(QIOChannel *ioc,
> > > -                                    Error **errp)
> > > +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> > > +                                             Error **errp)
> > >   {
> > >       QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> > >       struct msghdr msg = {};
> > > @@ -791,15 +810,34 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
> > >           /* No errors, count successfully finished sendmsg()*/
> > >           sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
> > > -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
> > > +        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
> > >           if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> > > -            ret = 0;
> > > +            sioc->new_zero_copy_sent_success = TRUE;
> > >           }
> > >       }
> > >       return ret;
> > >   }
> > > +static int qio_channel_socket_flush(QIOChannel *ioc,
> > > +                                    Error **errp)
> > > +{
> > > +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> > > +    int ret;
> > > +
> > > +    ret = qio_channel_socket_flush_internal(ioc, errp);
> > > +    if (ret < 0) {
> > > +        return ret;
> > > +    }
> > > +
> > > +    if (sioc->new_zero_copy_sent_success) {
> > > +        sioc->new_zero_copy_sent_success = FALSE;
> > > +        ret = 0;
> > > +    }
> > > +
> > > +    return ret;
> > > +}
> > I don't see the point in these changes adding new_zero_copy_sent_success.
> > 
> > IIUC, you seem to be trying to make it so that qio_channel_socket_flush
> > will return 0, if  qio_channel_socket_writev had called
> > qio_channel_socket_flush_internal behind the scenes.
> > That should already be working though, as the first thing we do in flush
> > is to check if anything was pending and, if not, then return zero:
> > 
> >      if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
> >          return 0;
> >      }
> >      ....do the real flush logic....
> > 
> > 
> > With regards,
> > Daniel
> 
> 
> yes but current logic is, if there was any successful zerocopy send in the
> iteration, return 0. I did not want to change the behavior. Now
> qio_channel_socket_flush_internal() can be called at any point of time and
> as many times depending on when the optmem_limit is full. So we may or may
> not have any data to process when actual qio_channel_socket_flush() comes.

IIUC the whole point of that flag was to guarantee the current stat counter
(dirty_sync_missed_zero_copy) keeps working. That counter looks like pretty
much for debugging purpose.  If we want, I think we can drop that but
replacing it with a tracepoint:

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066e..bccb464c9b 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -791,10 +791,9 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
 
-        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
-        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            ret = 0;
-        }
+        /* Enable this tracepoint if one wants to track zerocopy fallbacks */
+        trace_qio_channel_socket_zerocopy_fallback(
+            serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED);
     }

Then we deprecate this entry in QAPI:

# @dirty-sync-missed-zero-copy: Number of times dirty RAM
#     synchronization could not avoid copying dirty pages.  This is
#     between 0 and @dirty-sync-count * @multifd-channels.  (since
#     7.1)

I doubt any mgmt consumes it at all.  Probably we shouldn't ever expose
that to QAPI..

-- 
Peter Xu


