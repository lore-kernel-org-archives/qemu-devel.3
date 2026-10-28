Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC6606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7R51/Wu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nx7ibRgK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Er-0005KJ-Nk; Wed, 28 Oct 2026 13:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ek-000595-6f
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Eg-0003Vj-P8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ghv1nTWJY7Dt8HsvO7G1W2t/rsV0hlpxSqspVzCCAn8=;
 b=I7R51/WuqarrWBYvCaGTGUNFTcCS2d6uhrvSZZN47nQqjWQXYdBeVeDj+lASgG6ID/RkxS
 Cxn54rjL9++GitR50yn9UvLimZAXiN9aemQxR8OzlnFotIg4JoE02vxHDGy0oaVcWOcGsD
 DQfjVaRBGcx0gkpoW/ztoThWmITNtSc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-C35oSIwGPtG1ZUbNCu90FQ-1; Wed, 28 Oct 2026 13:14:48 -0400
X-MC-Unique: C35oSIwGPtG1ZUbNCu90FQ-1
X-Mimecast-MFC-AGG-ID: C35oSIwGPtG1ZUbNCu90FQ_1793207688
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a2b0669946so9864625e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207687; x=1793812487; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ghv1nTWJY7Dt8HsvO7G1W2t/rsV0hlpxSqspVzCCAn8=;
 b=nx7ibRgK3kTr2BF+4U6RLRS0/dlFUve91fmiVqRu7qkzwTbdetVjUGOgVa9WRTFz6A
 RWn/FCp/ZIPQSTOFWBxsksiHqAU6P4MATGJX6ZCCZQ8O1siqEo+37trmHl4AfaMEvDQ2
 tB34iWk2rRuSC1Rhm9PS7DX0d4hK5sQEtBGtlR+rAwPoAxkXw8rAX94dWEA4QU7cTdUQ
 ZH/1s4SobQE13TO4wZAJgR3j8cpAiVq34BE8SbBpJpAvzBwzZO3245hN7UuBuqUIYZsx
 UYLbffgjh3vxjQPzfqyMtePBkRqaIuFWpWCK5VJBeLfJvnKIkEODxuDWCdFbMYlvJdQy
 ZShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207687; x=1793812487;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ghv1nTWJY7Dt8HsvO7G1W2t/rsV0hlpxSqspVzCCAn8=;
 b=0uBxG+xxWPTNevrlsAhPWKlNaZwjda9TL1JgSe7KjdWne+O8Foy1J033FV0UTiqhVp
 Zvfr6zknJM+aWrdBNdw2tdKC5fPvZGlojpTrYt8sXsgBCAgh+bo6b0NL1x4idW1bCDl/
 weVpPMGUxjjhPU0M3/I9ucMd79nCST4bgcSgjUVRddjxZ7UXjFhdI/hHyL6wphe6+RXO
 jvouru+eCHZ0Y45qNI3gKdbx/7kYiyaHfN3cgIIbf5DzxZwhH8yOo6QGSYrdZj5ETgKx
 K2V6CB6mikZU1Imx5TemBNYsZU71AocdZXGizIbs9SgHwqEa8tgnDLXPJuduHq5B60UY
 dO1g==
X-Gm-Message-State: AFq9FYK0+/rRcoDqOhUhxFmFGeIfuTaOqbIKoaY73fD7W6HznocjDJcT
 SdxiGNNPzfrQQDRQS0LDvbuPZp+Td5c/q/8Em/4ePk7ZWlm+Unvr80Flk5QxTrLVavl8Cw5Z2fp
 ZJwxz1zNWu5ExFEg70o+9tjEuhBfCDv9X6QM1apZ4wkjj9plFYKlzwSY8oc0q4IMdX2UgXRvayj
 Btcrv77Zl/s58ML4o0KiSueisseWAokRbjDQ==
X-Gm-Gg: AYBFou3hvmZZ/tc2y76kdFaYTdez1KfSSxwMABsZSwm1zPzl3MUt/sbP+gFpYbMbfNb
 eUoiW6z2Qw6N4zVVRZWPgvUe2itERat6kuMnC6DSnhQi1gZlf36a39h+muLWCdcdSZUSznoUsCI
 LjslPNXamLGx8Sw0cRtACPfnJQnJPaFy/jVRDipA4/VT6qNtxZwn44oz36TdJsKUSnI4H/0qlWC
 FWD/i74R4fMnfq28e9cLvbXhOSVad3aSVghEH2RB9oj7WDhJtsZ9gmidFzFmXIaMTULxUEVlQTl
 QfFMhEX5XdfQcYPgRlGrlze7htlEv7HrRw8aw6GxR7zWvEckxqUDfGMD2+o2vdi422P6RhtYouj
 t7RwI3U8DkqouHTvuw30NCDVAyj9m1qozcnMh+7Rs
X-Received: by 2002:a05:600c:4e03:b0:4a7:7d22:c50c with SMTP id
 5b1f17b1804b1-4a963ffcf87mr65724635e9.2.1793207687257; 
 Wed, 28 Oct 2026 10:14:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4e03:b0:4a7:7d22:c50c with SMTP id
 5b1f17b1804b1-4a963ffcf87mr65723695e9.2.1793207686635; 
 Wed, 28 Oct 2026 10:14:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f7f50d3sm9259945e9.8.2026.10.28.10.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:45 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 19/78] vhost-vsock: preserve vhost FD during CPR
Message-ID: <194a0afc851d071eae6b783d4e344bd6b2da5e63.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Use the (suffixed) device path as the key in CPR hash table.  Device
path is obtained with qdev_get_dev_path() and is essentially the
device's address on the underlying bus.  As any vhost-vsock device is
attached to a virtio bus, whose .get_dev_path() forwards to the proxy
device, and every proxy bus (PCI, MMIO, CCW) implements it, we should
always be getting a unique non-empty path with qdev_get_dev_path().

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.  Until then CPR remains blocked, so the restore path
added here is not reachable yet.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-10-36c38bd15ffc@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d8760..6e89007b2c 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -69,6 +69,18 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
     return 0;
 }
 
+/*
+ * Any vhost-vsock device is attached to a virtio bus, whose .get_dev_path()
+ * forwards to the proxy device, and every proxy bus (PCI, MMIO, CCW)
+ * implements it.  Thus qdev_get_dev_path() always returns a non-empty string,
+ * which guarantees us a unique CPR name.
+ */
+static char *vhost_vsock_cpr_name(DeviceState *dev)
+{
+    g_autofree char *path = qdev_get_dev_path(dev);
+    g_assert(path && path[0]);
+    return g_strdup_printf("%s/vhost-vsock", path);
+}
 
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
@@ -143,6 +155,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -170,7 +184,14 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
+    if (cpr_incoming) {
+        /* Reuse the fd handed over from the source QEMU */
+        vhostfd = cpr_find_fd(cpr_name, 0);
+        if (vhostfd < 0) {
+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
+            goto err_blocker;
+        }
+    } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
@@ -186,6 +207,9 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     if (!qemu_set_blocking(vhostfd, false, errp)) {
         close(vhostfd);
+        if (cpr_incoming) {
+            cpr_delete_fd(cpr_name, 0);
+        }
         goto err_blocker;
     }
 
@@ -207,11 +231,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+        goto err_vhost_dev;
+    }
+
     return;
 
 err_vhost_dev:
     /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() */
     vhost_dev_cleanup(&vvc->vhost_dev);
+    if (cpr_incoming) {
+        /* The fd came from cpr_find_fd() and is closed now, drop the entry */
+        cpr_delete_fd(cpr_name, 0);
+    }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
 err_blocker:
@@ -223,10 +256,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    cpr_delete_fd(cpr_name, 0);
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
-- 
MST


