Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E1CCCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 11:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8zG8-0002AU-Is; Wed, 15 Oct 2025 07:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8zFl-0001tY-PC
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8zFd-00078o-Hq
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760526057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LrNWEvmtTc52nSUz03E2yVG0r5MjYnorIilZ+oiahI=;
 b=Ip0yI4bW/Om4wYND9Lrhb+Rxd4IrO5wQnDWlIOFmeXBcZSN5+hkTOFrDSXeT69qaDDoZXO
 o0kccNBGTXmXGaJkulxY9VoXwiuvdC+Wpt303eszpwVe8YxU+Kh5IqweriiLvXaJDOMUxq
 QgCqC7mr4n6auXdiZzN/zofA0/IB690=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-3MOyJkfrMUq-fqyn-fC85g-1; Wed, 15 Oct 2025 07:00:56 -0400
X-MC-Unique: 3MOyJkfrMUq-fqyn-fC85g-1
X-Mimecast-MFC-AGG-ID: 3MOyJkfrMUq-fqyn-fC85g_1760526055
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b551338c2c9so7720325a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 04:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760526054; x=1761130854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LrNWEvmtTc52nSUz03E2yVG0r5MjYnorIilZ+oiahI=;
 b=eno5dBBmKcP4bwlEaUBZ8SJsC94NFsXVNTi0SdOstMFgy75ug8RHRGAGmffaxyvSmG
 +6BANE2pxhr7lHOB9zONtA2VGXvPPnenvSiG/H3pbrhA92NBTEQHGc2ub1zGHzwu/oQ2
 kfPcRL+ieUIZi5SLy3vfuysdnnyPix4td95/nxNPRI0870G0PlG6vZynhBdCqLtVUbc/
 2I2UatdPQ0q+SbVkqYUMPMIpQOKCtIWMZFk1jChdYf/+wQ6JoozwXDWvH0xwGnhtjVty
 sqP1Szc/SJzWLzjYTfDLdahB73fX/N9dTDjIGHeiJvjobCX4rYQTLUrcFG2cFEAbb06b
 lrIw==
X-Gm-Message-State: AOJu0Yyx36pSWhV3NoO+hYDmOZrhjwoOrAV9piioI+R/FzVx110VB/wD
 H1JoIWz2EdEI1RkbcTJS9xdFT2TPc0kIicC+aakS48+5COLWgF/gE6XLOtO17ArYxmaXALw6Yhl
 4rdlhusRIAE2NcYJMGGj/U2VogbXnqt1K4U1tQ4djh2T0mvRTKGn+nlInPSOa+5XBEKW7KWNSOA
 BqID0qdETmBdXmGyHy9D9la+SdR+D/We9l1ppWINk=
X-Gm-Gg: ASbGncscb7m9KOtSeodyqWaonzSXdNhXFMmAIhaPoDp225Q3RpTI3QmWDHCZIop2g26
 631v9fNrGotvGIa0BIoOf6MvzbMbGvOa6wbdfbc5g0nuC7uhBEx9XOONjiEM9iu8CrvuOa0iqZk
 YcA25626sq6neU+mBD
X-Received: by 2002:a17:902:d585:b0:249:1234:9f7c with SMTP id
 d9443c01a7336-290273043b5mr311412375ad.60.1760526054243; 
 Wed, 15 Oct 2025 04:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU1OJ1xfVt8mq7al58xEMfFPf0692o95yr8YnTTXw7/mlSiuBFhySb34icGnez1Ir6AhrMr23SpS6J/TA9/Fk=
X-Received: by 2002:a17:902:d585:b0:249:1234:9f7c with SMTP id
 d9443c01a7336-290273043b5mr311411955ad.60.1760526053584; Wed, 15 Oct 2025
 04:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20251015091955.1524800-1-aesteve@redhat.com>
 <rkqjxwyd7nvrkklswqkc3mpwopivefjieq5ckbt3jklt43hr5i@4qpv3dx2nogl>
In-Reply-To: <rkqjxwyd7nvrkklswqkc3mpwopivefjieq5ckbt3jklt43hr5i@4qpv3dx2nogl>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 15 Oct 2025 13:00:42 +0200
X-Gm-Features: AS18NWCe7-ddTdoqfEc02eElb6bWABT8h23nayQbUDYI-Z-edN8JTsmfD0XZrTA
Message-ID: <CADSE00L227mNXx__m=hRdjg92e0RmjMwzEu270FtSZWZvNG9ww@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: fix shared object lookup handler logic
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 12:02=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Wed, Oct 15, 2025 at 11:19:55AM +0200, Albert Esteve wrote:
> >Fix vhost_user_backend_handle_shared_object_lookup() logic to handle
> >the error path the same way as other handlers do. The main
> >difference between them is that shared_object_lookup handler
> >sends the reply from within the handler itself.
> >
> >What vhost_user_backend_handle_shared_object_lookup() returns, depends
> >on whether vhost_user_backend_send_dmabuf_fd() succeded or not to send
> >a reply. Any check that results in an error before that only
> >determines the return value in the response. However, when an error
> >in sending the response within the handler occurs, we want to jump
> >to err and close the backend channel to be consistent with other message
> >types. On the other hand, when the response succeds then the
> >VHOST_USER_NEED_REPLY_MASK flag is unset and the reply in backend_read
> >is skipped, going directly to the fdcleanup.
> >
> >Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
>
> Looking at that commit, I honestly don't understand why the reply is
> handled differently for
> vhost_user_backend_handle_shared_object_lookup().
> Why can't we handle it here like we do for all the other calls?
>
> If the backend always expects a response for that, can't we do something
> like this? (And of course
> vhost_user_backend_handle_shared_object_lookup() returns the value
> instead of touching the payload.)

Exactly, if I remember correctly (and judging by the specs and code
it's like that), the reason is that this handler needed a response
unconditionally. Your proposal looks good to me, and we can clean the
dmabuf_fd static function, which does not do much either.

Let me send a quick v2, thanks for checking.

>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 36c9c2e04d..da874c4add 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1790,6 +1790,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCo=
ndition condition,
>       struct iovec iov;
>       g_autofree int *fd =3D NULL;
>       size_t fdsize =3D 0;
> +    bool reply_ack;
>       int i;
>
>       /* Read header */
> @@ -1808,6 +1809,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCo=
ndition condition,
>           goto err;
>       }
>
> +    reply_ack =3D hdr.flags & VHOST_USER_NEED_REPLY_MASK;
> +
>       /* Read payload */
>       if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_e=
rr)) {
>           error_report_err(local_err);
> @@ -1833,6 +1836,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCo=
ndition condition,
>                                                                &payload.o=
bject);
>           break;
>       case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> +        /* The backend always expects a response (XXX: is that right?) *=
/
> +        reply_ack =3D true;
>           ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opa=
que, ioc,
>                                                                &hdr, &pay=
load);
>           break;
> @@ -1845,7 +1850,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCo=
ndition condition,
>        * REPLY_ACK feature handling. Other reply types has to be managed
>        * directly in their request handlers.
>        */
> -    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> +    if (reply_ack) {
>           payload.u64 =3D !!ret;
>           hdr.size =3D sizeof(payload.u64);
>
> Thanks,
> Stefano
>
> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >---
> > hw/virtio/vhost-user.c | 7 +++++--
> > 1 file changed, 5 insertions(+), 2 deletions(-)
> >
> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >index 36c9c2e04d..163c3d8ca5 100644
> >--- a/hw/virtio/vhost-user.c
> >+++ b/hw/virtio/vhost-user.c
> >@@ -1833,8 +1833,11 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
> >                                                              &payload.o=
bject);
> >         break;
> >     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> >-        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opa=
que, ioc,
> >-                                                             &hdr, &pay=
load);
> >+        /* Handler manages its own response, check error and close conn=
ection */
> >+        if (vhost_user_backend_handle_shared_object_lookup(dev->opaque,=
 ioc,
> >+                                                           &hdr, &paylo=
ad) < 0) {
> >+            goto err;
> >+        }
> >         break;
> >     default:
> >         error_report("Received unexpected msg type: %d.", hdr.request);
> >--
> >2.49.0
> >
>


