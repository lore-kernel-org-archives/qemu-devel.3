Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B42CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90wd-0004ns-PX; Wed, 15 Oct 2025 08:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v90wa-0004nH-Ui
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v90wU-0006Wg-LP
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760532553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wuxCCVShtMmlBb1+/FqlB2SSFvwk/s0dfJL4JIRhvO4=;
 b=TucqSCnozzsQ+yBYt1ee9rI876USU3CAY+LdOr9M71M3xVO0d57xksrhoGqUnXLr+dIs1E
 p+GPtE21Z2B0C6RCSr44JHVziKDiEfKCTcZRlh/MU/bm54NRhiF2JGIxvL8LVqsc5zporc
 PTSry5FbDaYvq1/fDqWiEm2KxRCUzuU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-d-JLo8CLO42u6qysLUV8jQ-1; Wed, 15 Oct 2025 08:49:12 -0400
X-MC-Unique: d-JLo8CLO42u6qysLUV8jQ-1
X-Mimecast-MFC-AGG-ID: d-JLo8CLO42u6qysLUV8jQ_1760532552
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b650a3e0efcso10443084a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 05:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760532551; x=1761137351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuxCCVShtMmlBb1+/FqlB2SSFvwk/s0dfJL4JIRhvO4=;
 b=b/qDikYDLOzoIFouN/NdvVpSoLbdNDzc1Cq4/CMplgVstOVC8Og/fSUd5sYCsmLiE2
 CLCh0eD0I0P8BNwG6dwyzCW06YGFAmggFeMU4TiwVH79Z+ipaD6KT7Bu63hOE5D4xUcb
 MpFote8cWE95Hv6hrB3e9qIPOI1VX596exL+Mby0vDYl32yuMSEnr6XVAkTgUCbm156B
 0B8+SHGOq+Aya2Y3zed+uVRAWg0I0qM5Ma3qjhmDyYu8InqnWUkSqf82Ma/lOBGmYKTg
 lY1Op4J4goSXa1JnC6hEc/eSUkNrw4prHPY33P4miC0Xl5xNJ73Z90oFlKWwTBuk0+3h
 7H+g==
X-Gm-Message-State: AOJu0Yzjdt2gwliPSCYN9KEZkn9e5ckeZSXsOZxCUvnqhu+0fun7TqOk
 eFWuBMV393YivwdSHsYXyREGUbeNhlkWEjj0eF4sKEsOqOg9s0yKZFG68eCR1Z+Ukb4lI7CAs/B
 wCzxCAyW+DyOKFG9h2sp741FJ0F1cZVwg7kYKgtntkhBy8rBB5nl1/l0CTjcN1SVpc1eSuXeDEQ
 QJU+swFSztwz5tgBZOGqdKfNoFo2EjaqfAC8SzC1o=
X-Gm-Gg: ASbGncuZDBBqyHI7JpGaDf1OWCNFI0m7p6lXsOtsjlhq/3bGg7QSsS/mS2nhrr/DYCx
 HfZBNsDq6v+XRjqlS0qicEchEAg8Lt7M4gT+nWwaOtizN9lUPJTHCXHg6V9P3wQXhwS2Gs+iYcV
 cImnQvXTdSFATWnP7k
X-Received: by 2002:a17:902:c945:b0:28e:80d7:663e with SMTP id
 d9443c01a7336-29027369d05mr394235005ad.40.1760532551376; 
 Wed, 15 Oct 2025 05:49:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkvwftXawbzGOWMeLzO4nB3vZuxO1Ojx+TPdCB9/wwqCT18xBexynGzKR3meLaox/W+uk7lIRRhysCd4fZVAg=
X-Received: by 2002:a17:902:c945:b0:28e:80d7:663e with SMTP id
 d9443c01a7336-29027369d05mr394234625ad.40.1760532550911; Wed, 15 Oct 2025
 05:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251015113634.1566785-1-aesteve@redhat.com>
 <lsk6b2gl76fmp7zukzjnuncxs7nrscwhy2vxq3wv77rhed4kmg@5lcajhmx2kef>
In-Reply-To: <lsk6b2gl76fmp7zukzjnuncxs7nrscwhy2vxq3wv77rhed4kmg@5lcajhmx2kef>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 15 Oct 2025 14:48:59 +0200
X-Gm-Features: AS18NWDi_f_kZXGsebvSddXJdBHReHiUgpXsqoR2ZerUOYLIm8voDXZ9F5P1LI0
Message-ID: <CADSE00Jwr6KdCEiJH2HOxpzQ1Yii5UOVzG+rOMifSFy2ELLjRQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-user: add reply_ack to backend_read
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

On Wed, Oct 15, 2025 at 1:52=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> Thanks for the refactoring, IMO now it's much better and easy to read.
>
> BTW, the previous title was better IMHO because it made it clear that
> this is a fix, whereas now it looks more like a refactoring and could
> therefore be difficult to interpret as something to be backported to
> stable branches. So I suggest just to revert the title, the following
> description LGTM.
>
> On Wed, Oct 15, 2025 at 01:36:34PM +0200, Albert Esteve wrote:
> >Refactor backend_read() function and add a reply_ack variable
> >to have the option for handlers to force tweak whether they should
> >send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
> >flag.
> >
> >This fixes an issue with
> >vhost_user_backend_handle_shared_object_lookup() logic, as the
> >error path was not closing the backend channel correctly. So,
> >we can remove the reply call from within the handler, make
> >sure it returns early on errors as other handlers do and
> >set the reply_ack variable on backend_read() to true to ensure
> >that it will send a response, thus keeping the original intent.
> >
> >Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
>
> Should we cc stable?
> If yes, please add:
>
> Cc: qemu-stable@nongnu.org
>
> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >---
> > hw/virtio/vhost-user.c | 36 +++++++++++-------------------------
> > 1 file changed, 11 insertions(+), 25 deletions(-)
> >
> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >index 36c9c2e04d..b0bcee2d30 100644
> >--- a/hw/virtio/vhost-user.c
> >+++ b/hw/virtio/vhost-user.c
> >@@ -1668,14 +1668,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc,=
 VhostUserHeader *hdr,
> >     return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
> > }
> >
> >-static bool
> >-vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr=
,
> >-                                  VhostUserPayload *payload, Error **er=
rp)
> >-{
> >-    hdr->size =3D sizeof(payload->u64);
> >-    return vhost_user_send_resp(ioc, hdr, payload, errp);
> >-}
> >-
> > int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *=
uuid,
> >                                  int *dmabuf_fd)
> > {
> >@@ -1716,19 +1708,15 @@ int vhost_user_get_shared_object(struct vhost_de=
v *dev, unsigned char *uuid,
> >
> > static int
> > vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> >-                                               QIOChannel *ioc,
> >-                                               VhostUserHeader *hdr,
> >                                                VhostUserPayload *payloa=
d)
>
> Can we now uniform this function with the other `*_shared_object_*`
> functions, passing `VhostUserShared *object` instead of the entire
> payload?
>
> The rest LGTM!

Agreed and addressed all your comments in the next revision :)
Thanks!

>
> Thanks,
> Stefano
>
> > {
> >     QemuUUID uuid;
> >     CharBackend *chr =3D u->user->chr;
> >-    Error *local_err =3D NULL;
> >     int dmabuf_fd =3D -1;
> >     int fd_num =3D 0;
> >
> >     memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid=
));
> >
> >-    payload->u64 =3D 0;
> >     switch (virtio_object_type(&uuid)) {
> >     case TYPE_DMABUF:
> >         dmabuf_fd =3D virtio_lookup_dmabuf(&uuid);
> >@@ -1737,18 +1725,16 @@ vhost_user_backend_handle_shared_object_lookup(s=
truct vhost_user *u,
> >     {
> >         struct vhost_dev *dev =3D virtio_lookup_vhost_device(&uuid);
> >         if (dev =3D=3D NULL) {
> >-            payload->u64 =3D -EINVAL;
> >-            break;
> >+            return -EINVAL;
> >         }
> >         int ret =3D vhost_user_get_shared_object(dev, uuid.data, &dmabu=
f_fd);
> >         if (ret < 0) {
> >-            payload->u64 =3D ret;
> >+            return ret;
> >         }
> >         break;
> >     }
> >     case TYPE_INVALID:
> >-        payload->u64 =3D -EINVAL;
> >-        break;
> >+        return -EINVAL;
> >     }
> >
> >     if (dmabuf_fd !=3D -1) {
> >@@ -1757,11 +1743,6 @@ vhost_user_backend_handle_shared_object_lookup(st=
ruct vhost_user *u,
> >
> >     if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
> >         error_report("Failed to set msg fds.");
> >-        payload->u64 =3D -EINVAL;
> >-    }
> >-
> >-    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_er=
r)) {
> >-        error_report_err(local_err);
> >         return -EINVAL;
> >     }
> >
> >@@ -1790,6 +1771,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
> >     struct iovec iov;
> >     g_autofree int *fd =3D NULL;
> >     size_t fdsize =3D 0;
> >+    bool reply_ack;
> >     int i;
> >
> >     /* Read header */
> >@@ -1808,6 +1790,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
> >         goto err;
> >     }
> >
> >+    reply_ack =3D hdr.flags & VHOST_USER_NEED_REPLY_MASK;
> >+
> >     /* Read payload */
> >     if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_e=
rr)) {
> >         error_report_err(local_err);
> >@@ -1833,8 +1817,10 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
> >                                                              &payload.o=
bject);
> >         break;
> >     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> >-        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opa=
que, ioc,
> >-                                                             &hdr, &pay=
load);
> >+        /* The backend always expects a response */
> >+        reply_ack =3D true;
> >+        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opa=
que,
> >+                                                             &payload);
> >         break;
> >     default:
> >         error_report("Received unexpected msg type: %d.", hdr.request);
> >@@ -1845,7 +1831,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
> >      * REPLY_ACK feature handling. Other reply types has to be managed
> >      * directly in their request handlers.
> >      */
> >-    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> >+    if (reply_ack) {
> >         payload.u64 =3D !!ret;
> >         hdr.size =3D sizeof(payload.u64);
> >
> >--
> >2.49.0
> >
>


