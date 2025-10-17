Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CE3CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 07:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9fGo-000162-Vl; Fri, 17 Oct 2025 03:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9fGn-000159-GL
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 03:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9fGi-000453-HR
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 03:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760687566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vszaC9YNzbzj76CjMtfi/8uo7mq2K4hjijK9aAFEyq4=;
 b=DjMzvZoiEH/ryUFH8j3kuomOPZ4LNyKhHw25OZQxwxgk4v0LYAz8Rq+jmLC9NgX3cZe44z
 DpKLPWUlGHT014PrF1M27Qv821Hec9ru54pVwMNITtyLq3/TlBB6CYc6SAXitnhgq6Ff/N
 wJajwk7KRIyHO/Amow311aXNDrHbqvM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-4HdspZ-uMi2AS_wcQLU2rA-1; Fri, 17 Oct 2025 03:52:44 -0400
X-MC-Unique: 4HdspZ-uMi2AS_wcQLU2rA-1
X-Mimecast-MFC-AGG-ID: 4HdspZ-uMi2AS_wcQLU2rA_1760687564
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-88d842aa73aso841976485a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 00:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760687564; x=1761292364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vszaC9YNzbzj76CjMtfi/8uo7mq2K4hjijK9aAFEyq4=;
 b=FR0xKDFe4Racsvz/4Pj0p+PKaU4O6NbpJ4BXsmWCZVqsh0RPs+IGeK9RAql2IXqui5
 u/Ip0GJQUQA3g/mbRc1gq7oyGYR1bKq0stNJWy633wC59bhIMNhCiIOlZ9jPIKPts8d9
 aJA2ZLUsUDXa8VQVdKMeAKdeloEt/pKjTxAu1lHePH2RUKd6gsmofkKiRSoFHiXiuA0f
 VQ81EE9qMZZWEUfjGxjah/X+n1SMCQm6Y+GisQFKZ1HGyj4JiXyaHTOqJ99nnwxlek0i
 MrdDJrg6lw/+4PDDjRi/e3NU2SdPLca/0VMCxhEnO2Ld1yL//av3hT+MrdUyrHZQDlWF
 j1mw==
X-Gm-Message-State: AOJu0YxDRuiibMgRzhrlr00eB2u0v0yWlhUnJ1vKXYGLVyIhBMYZkvUn
 Z0qVam5ept55fcVqZ1AbX5zUJiNY1rCDNTO1on6GPFSxvFq9ldmhpmKIEJwThZcEJLdrdnFa0U9
 QMhKyAGJaNOfHdkgFGIwm+RIvzfUTEJvcCOchaIyZpl3jDdbb71i892i1
X-Gm-Gg: ASbGncvBnOMrk6a++M8f67kL24o5PoiD6qDnhAyK4kMEjbt6p+EKmP0AmOQSAch7CVA
 O64BgtJKyJlcnCR4+GC4RXNTbRJhknd70C5gAup76T0a18he21Z8WNkoRnfqBjivF1ca7DarU4f
 i6P9FDUB5d4HUMkI8gQlfcK7zhcoQvI6VUhYf9AeVucNrqFVuLTpoan53RbCGq79L17ywjCxJ+G
 C3jJM6tzM1WCmKXjMMPGKTIrCdgF+HL36dVzf9AWK6fVgfoCtYBuCoYjz02CVfKPLojS35fpv7+
 r3qJW7unw7hvUsHOQY7TNCyKCG8UPIwsr8cys9cAt2IwVPSWLWh+J7QUQxVYU8euSesv6LSAbDb
 lWgfJ0mpgXu6H/4NzC0hZEAnF4w8F31+kVTFMx6hKMZ6GaYq2He8=
X-Received: by 2002:a05:620a:6914:b0:85a:8ea3:6bc with SMTP id
 af79cd13be357-89070ae7cb1mr299548285a.76.1760687564101; 
 Fri, 17 Oct 2025 00:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZOCKoNU9Bh45VnIcvvM1Vy4A6pWIDlngJLK63houvG+KJTfFGoCKlR6v7if0If7JpNufEKQ==
X-Received: by 2002:a05:620a:6914:b0:85a:8ea3:6bc with SMTP id
 af79cd13be357-89070ae7cb1mr299546485a.76.1760687563644; 
 Fri, 17 Oct 2025 00:52:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-88f37f45c28sm383440985a.30.2025.10.17.00.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 00:52:43 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:52:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH v4 1/1] vhost-user: fix shared object lookup handler logic
Message-ID: <o4bzlzjuigla7lug6epan5eli6xo4qoatraxxxyxstou4kftgg@nozczotpu2r4>
References: <20251017072011.1874874-1-aesteve@redhat.com>
 <20251017072011.1874874-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251017072011.1874874-2-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Oct 17, 2025 at 09:20:11AM +0200, Albert Esteve wrote:
>Refactor backend_read() function and add a reply_ack variable
>to have the option for handlers to force tweak whether they should
>send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
>flag.
>
>This fixes an issue with
>vhost_user_backend_handle_shared_object_lookup() logic, as the
>error path was not closing the backend channel correctly. So,
>we can remove the reply call from within the handler, make
>sure it returns early on errors as other handlers do and
>set the reply_ack variable on backend_read() to true to ensure
>that it will send a response, thus keeping the original intent.
>
>Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
>Cc: qemu-stable@nongnu.org
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> hw/virtio/vhost-user.c | 42 +++++++++++++++---------------------------
> 1 file changed, 15 insertions(+), 27 deletions(-)

IIUC to backport this to stable now, we need to remove a couple of 
blocks, but I think that's fine.

@Michael, or would it be better to rebase "[PATCH v10 0/7] vhost-user: 
Add SHMEM_MAP/UNMAP requests" on this and make sure this applies cleanly 
to stable?

Either way, the changes are fine with me:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 890be55937..762d7218d3 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -1696,14 +1696,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
>     return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
> }
>
>-static bool
>-vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
>-                                  VhostUserPayload *payload, Error **errp)
>-{
>-    hdr->size = sizeof(payload->u64);
>-    return vhost_user_send_resp(ioc, hdr, payload, errp);
>-}
>-
> int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
>                                  int *dmabuf_fd)
> {
>@@ -1744,19 +1736,15 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
>
> static int
> vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>-                                               QIOChannel *ioc,
>-                                               VhostUserHeader *hdr,
>-                                               VhostUserPayload *payload)
>+                                               VhostUserShared *object)
> {
>     QemuUUID uuid;
>     CharBackend *chr = u->user->chr;
>-    Error *local_err = NULL;
>     int dmabuf_fd = -1;
>     int fd_num = 0;
>
>-    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
>+    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
>
>-    payload->u64 = 0;
>     switch (virtio_object_type(&uuid)) {
>     case TYPE_DMABUF:
>         dmabuf_fd = virtio_lookup_dmabuf(&uuid);
>@@ -1765,18 +1753,16 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>     {
>         struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
>         if (dev == NULL) {
>-            payload->u64 = -EINVAL;
>-            break;
>+            return -EINVAL;
>         }
>         int ret = vhost_user_get_shared_object(dev, uuid.data, &dmabuf_fd);
>         if (ret < 0) {
>-            payload->u64 = ret;
>+            return ret;
>         }
>         break;
>     }
>     case TYPE_INVALID:
>-        payload->u64 = -EINVAL;
>-        break;
>+        return -EINVAL;
>     }
>
>     if (dmabuf_fd != -1) {
>@@ -1785,11 +1771,6 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>
>     if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
>         error_report("Failed to set msg fds.");
>-        payload->u64 = -EINVAL;
>-    }
>-
>-    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err)) {
>-        error_report_err(local_err);
>         return -EINVAL;
>     }
>
>@@ -2008,6 +1989,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>     struct iovec iov;
>     g_autofree int *fd = NULL;
>     size_t fdsize = 0;
>+    bool reply_ack;
>     int i;
>
>     /* Read header */
>@@ -2026,6 +2008,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>         goto err;
>     }
>
>+    reply_ack = hdr.flags & VHOST_USER_NEED_REPLY_MASK;
>+
>     /* Read payload */
>     if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
>         error_report_err(local_err);
>@@ -2051,11 +2035,14 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>                                                              &payload.object);
>         break;
>     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
>-        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
>-                                                             &hdr, &payload);
>+        /* The backend always expects a response */
>+        reply_ack = true;
>+        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque,
>+                                                             &payload.object);
>         break;
>     case VHOST_USER_BACKEND_SHMEM_MAP:
>         /* Handler manages its own response, check error and close connection */
>+        reply_ack = false;
>         if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &payload,
>                                                 fd ? fd[0] : -1) < 0) {
>             goto err;
>@@ -2063,6 +2050,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>         break;
>     case VHOST_USER_BACKEND_SHMEM_UNMAP:
>         /* Handler manages its own response, check error and close connection */
>+        reply_ack = false;
>         if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &payload) < 0) {
>             goto err;
>         }
>@@ -2076,7 +2064,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>      * REPLY_ACK feature handling. Other reply types has to be managed
>      * directly in their request handlers.
>      */
>-    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
>+    if (reply_ack) {
>         payload.u64 = !!ret;
>         hdr.size = sizeof(payload.u64);
>
>-- 
>2.49.0
>


