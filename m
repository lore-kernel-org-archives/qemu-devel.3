Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B408CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 08:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9JEk-0002BM-Ge; Thu, 16 Oct 2025 04:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9JEd-0002A4-Go
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9JEZ-0001GD-I9
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760602871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ol31qbMSgWME9pNPv10rR2IwTqbNG7FTE391kG/d00A=;
 b=h4zg0JmVDibjshAIbd4i4SpiCo1dMIyfyMTQxtUSSjKMD8MbQC1wclzfsvZo8kf2YP6ll7
 aSrZcNSBcQvrJIzc3MlFrd3HqneYZ2bjD+ayFv2HMIHzR+Jmknkk/r0DuJ6T+ScGz7CUWr
 vfm38CEcRxZarmw71osd18Qn2E7SBN8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-A4p7SW0BNdOC-wDvqyL9jA-1; Thu, 16 Oct 2025 04:21:10 -0400
X-MC-Unique: A4p7SW0BNdOC-wDvqyL9jA-1
X-Mimecast-MFC-AGG-ID: A4p7SW0BNdOC-wDvqyL9jA_1760602869
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-28c58e009d1so10311415ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 01:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760602869; x=1761207669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ol31qbMSgWME9pNPv10rR2IwTqbNG7FTE391kG/d00A=;
 b=lkiNmY4VbBRcZAdqI5C/3NJ9fvk4ulr+ES9qEYAx8wR1q1TbwcFb7q7e8qTMd587Xp
 hIRicZOPqa8x3lqtTKYruMtRlCdNIBzd54NHxdRDaAaL/YMFOHHdjw0XfMkxGwLjnE3l
 kqJe61ejORnXdsGqjLmrN+0m2bQhsQHwhyoh+bS4Kp3GKwYx2/Adh/KprsLpFafqeEos
 uI2sCmENVVE8e+xU9Mueo/IcLlaFLtBpvyb+ECzGaupNQtc+HB+NHZUoKXFYkBPPqFq9
 xS1dsgzBaqOa7+MzgSp0MPx9xJOuNEUsXkoZuqkSKNHV4hLDVs0JFLuA4RWuxTzSqYqd
 Hk8g==
X-Gm-Message-State: AOJu0YzaLtyF+fhMIq6GPOa2su8d0UlclGMBW4Porwv1YIoluxwwWBKF
 epFP+0QZGxMhD3qpooWYk0IWzfzFGP7JnPCAgbeUstb7dDpPoJXv9dBLujOoySAIc94Xr21qhtQ
 e1dSExx9xGM6C6Bl/wmUP4930BH+Z6Y7iHrjs0OVD4auwo+TJSbBVc+rDI6UyDkEp64SaT+i13o
 UrOvQCIpAe/JvsH0aegbGBA783TiyDXRg=
X-Gm-Gg: ASbGnctf4ZDh0iH9HJs2fv8RsDrw6bTo4K9SVgrqQp3ofpIKtlokEwflCb7bJlnLVb8
 gOmdIT+RjZFLarAh1u4r2mUFR37qiXPk5WHCsB6U2XDttVfpAm18CRRFkygayI5z6D4zml15O8m
 ECYzcQEhN9hHFkt5SUJ8Op6/TY6o2JvTbDhH7dD7PB+riVO0gJ6WI=
X-Received: by 2002:a17:903:1447:b0:275:3ff9:ab88 with SMTP id
 d9443c01a7336-290273ffcc7mr455072455ad.49.1760602869069; 
 Thu, 16 Oct 2025 01:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ7dvz/VPMBeKA+EacvYw+9xyH20xt/iNzBkHfs9HM4IPbAD+Vvi+GG3544RwnlEiXkvO1+/yIvSdeG1oVeu8=
X-Received: by 2002:a17:903:1447:b0:275:3ff9:ab88 with SMTP id
 d9443c01a7336-290273ffcc7mr455072245ad.49.1760602868666; Thu, 16 Oct 2025
 01:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251015124314.1588018-1-aesteve@redhat.com>
 <zey3wf53mapbrc25xwal3dia5fb4tddyxghvzjpy2p2fm6cdcp@7dlkcuzpcoho>
In-Reply-To: <zey3wf53mapbrc25xwal3dia5fb4tddyxghvzjpy2p2fm6cdcp@7dlkcuzpcoho>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 16 Oct 2025 10:20:57 +0200
X-Gm-Features: AS18NWAzIHy4c5SLQQzusjbu5UZc4gnRKpkBb3ZAUaaAz5ZQGkOYt819CQqnQFI
Message-ID: <CADSE00+1xp8o9UQbL=BOwAFXUKAFZ9M=+oeevCFF5xEWJkb8ug@mail.gmail.com>
Subject: Re: [PATCH v3] vhost-user: fix shared object lookup handler logic
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org
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

On Wed, Oct 15, 2025 at 2:57=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Oct 15, 2025 at 02:43:14PM +0200, Albert Esteve wrote:
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
> >Cc: qemu-stable@nongnu.org
> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >---
> > hw/virtio/vhost-user.c | 40 +++++++++++++---------------------------
> > 1 file changed, 13 insertions(+), 27 deletions(-)
>
> Thanks! This patch LGTM, so
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
> But I left couple of comments that is not related to this fix and maybe
> should be fixed separately:
>
> >
> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >index 36c9c2e04d..8a93f1d4b5 100644
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
> >-                                               VhostUserPayload
> >*payload)
> >+                                               VhostUserShared *object)
> > {
> >     QemuUUID uuid;
> >     CharBackend *chr =3D u->user->chr;
> >-    Error *local_err =3D NULL;
> >     int dmabuf_fd =3D -1;
> >     int fd_num =3D 0;
> >
> >-    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid=
));
> >+    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
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
>
> So, after this patch, we are not going to call
> `qemu_chr_fe_set_msgfds()` when we are returning an error to the
> backend. I guess this is even better than before, right?

Yeah, otherwise it was sending fd_num =3D 0 which should be safe, but it
is indeed cleaner and clearer to read.


>
> >     }
> >
> >     if (dmabuf_fd !=3D -1) {
> >@@ -1757,11 +1743,6 @@
> >vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> >
>
> Should we call qemu_chr_fe_set_msgfds() only if fd_num > 0?
> Or should we return an error if `dmabuf_fd` is not a valid fd?

Unless I misunderstood the code, I think if fd_num =3D 0 the function
will not send any FD through the communication channel. But indeed, it
would be fair to return an error if `dmabuf_fd` is not valid, to let
the backend know something unexpected happened. I will prepare a
follow-up patch soonish with this :)

>
> I guess this is pre-existing and maybe should be fixed in another patch
> if it's a problem.
>
> Thanks,
> Stefano
>
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
> >+                                                             &payload.o=
bject);
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


