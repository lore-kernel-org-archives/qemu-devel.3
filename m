Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EF260A2615
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bpgUcQF0;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QC2K4io4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTyk5-0005r5-Tm; Thu, 19 Nov 2026 04:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjk-0005gO-75
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjh-0006MJ-Jx
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795081640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JONgt/yP3PdUvMO+MK2zi0s+xj8Vp5+Dd4F+bpae7I4=;
 b=bpgUcQF03FWnX7ZMn3YM9pM1udZ44HdnOfqmi9aZvJETbdsrai7/ZOBXWsScA39I5fRNnA
 hUmXnZXYnBEitN3ughlpbjWlj3yPxgVPTq3fqZtMm5MQPzib5ltz/x1pBZgWHEsChr9/uh
 QErvXabOGgeF4m6iz/PQBn2jA1BmRY4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-jLa7RcPKPKedbml8I13t4w-1; Thu, 19 Nov 2026 04:47:19 -0500
X-MC-Unique: jLa7RcPKPKedbml8I13t4w-1
X-Mimecast-MFC-AGG-ID: jLa7RcPKPKedbml8I13t4w_1795081638
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e4d1e29f3so1873337f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795081638; x=1795686438; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JONgt/yP3PdUvMO+MK2zi0s+xj8Vp5+Dd4F+bpae7I4=;
 b=QC2K4io4FuipCAJhEuhsqWNuzFeJwvxEHgFFQvblDNM0i1oy9djAvuxrSz820XBoWi
 R6sHLKPLQWlKJHkU7yz177agmjPwbIVSaKoIm4Fp8a94S/5+zP48RT9l4EnMjzePUrno
 2JXVBIDCh/TjIq4/qrfrCTcE1RYCGqi3gyYT4q9Mm/4vAorKf4SQPCVenoSDITFavqHy
 6ESTKoaD5St61Nv72EBkac+05bLkK1m4B/FOuuTaymRl4pxz8nMjFbUjQxouYUQ5WdeO
 F4yVcEMIEpWIcajVmqiKyBPWXAyJaL0f9JCfY6/JxmVZNMC8/qDyw9xw3rRAnOq1SX8+
 6AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795081638; x=1795686438;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JONgt/yP3PdUvMO+MK2zi0s+xj8Vp5+Dd4F+bpae7I4=;
 b=Qqbetobpi4M7ZGndyV3+ooQAoaBH56aGrmwGr02+GZ4/IX2G5DW0mAV2hPjelbDGQB
 2pH5NM4rjCMgkfTJgt1GNNqYuvhDNpWZ6uxkLaRWRET9rFFCmuoUsKjqsXu3k3iVQU73
 LgdbxsIEDqNvmCFKSrhTehQkNZ5YeVbfWz6uEgRz6hH87rZ+N0fQmQSgKYFqop2X3Ktf
 YKQRH2klhk+pVPBLQb2T3R0hvu0NlDQ2uFDX4Sa7juvkyHccoKEOs01LlSEa502qEOX5
 MQdyRopdAHX7E1I1lLPtN9Y/HZrrvxxQs0rlkOULik3Gcjq2aMXXh/UH5snCHPvlCfav
 CUzw==
X-Gm-Message-State: APuU4Z+3UKTmD7LVoWyk2gpjdIs9kk6aQxrZqnFlvrYM20P70P96vR+X
 wwE5Xb7RtNMHCOMBGt6D770SkZMg2WeoEnn4pT60S8CKSe9YUvfyYqntVlsztGkFhvvReDd6oc8
 hgYizFlrCb/JcHs9ThJ5YyZPrlPNIgql9wDysg8c0ZjDOgzlcjyLIngLYJRw7Anbz5jsWlvouqz
 LbHIEbrO9YmfShQLF4YJeX2trU9t5k4YaQrw==
X-Gm-Gg: AYBFou1Vjyoqzt8KcuyO9aO7dDRQSNCSatml4EqXafKrSDjX1b6jLwiFJPytf6W653P
 oc43wBvAp0YOU1NGlBTaaXoq5BL2N30rB+v8MX5avBIAklDG/aoc4gax2/T7sWo93ByZwsLVSiE
 AcdMTBemfrOezyk7WoNACd5+ya/J1N+IWo9WMcMZ+BgwQmikx84bl92TC6ssVTZR/OavmsWQWwn
 0le9jD3g6esSi2tiyRK9AwTmVTFEiA0lk6I6OzeX9UHfwvKULI+v2V9crhThywd151rpX+rTaCB
 8dNEFRP52vfAG7heGRaaB1mkqfXO2mZAPVQRyLm9mL3HaKgygP9LGZ3uHxo6IUAM+oEyzI69K2I
 0mrRfSqmu18S3/8F1iGAMSA5IGV4+GvpS6rpxfwW1ewA=
X-Received: by 2002:a05:600c:45d4:b0:4bb:5f45:c97f with SMTP id
 5b1f17b1804b1-4bb7da29ad4mr98626675e9.27.1795081638048; 
 Thu, 19 Nov 2026 01:47:18 -0800 (PST)
X-Received: by 2002:a05:600c:45d4:b0:4bb:5f45:c97f with SMTP id
 5b1f17b1804b1-4bb7da29ad4mr98625835e9.27.1795081637070; 
 Thu, 19 Nov 2026 01:47:17 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm24283345e9.12.2026.11.19.01.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 01:47:15 -0800 (PST)
Date: Thu, 19 Nov 2026 04:47:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtio-fs@lists.linux.dev
Subject: [PULL 4/8] vhost-user-fs: fix virtqueue array leak on realize failure
Message-ID: <8efc85f1650d6db3a95f7aebd97bc40274d1c2ee.1795081539.git.mst@redhat.com>
References: <cover.1795081539.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1795081539.git.mst@redhat.com>
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

On failure, vhost_dev_init() clears vhost_dev, so the error path frees
NULL instead of the virtqueue array. Keep the pointer in the existing
vhost_vqs field and use it to free the array on failure and unrealize.

Fixes: 98fc1ada4cf7 ("virtio: add vhost-user-fs base device")
Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261109062401.81161-1-dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost-user-fs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 0d8842817a1..f26b5b611ac 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -255,7 +255,8 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
 
     /* 1 high prio queue, plus the number configured */
     fs->vhost_dev.nvqs = 1 + fs->conf.num_request_queues;
-    fs->vhost_dev.vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
+    fs->vhost_vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
+    fs->vhost_dev.vqs = fs->vhost_vqs;
     ret = vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0, errp);
     if (ret < 0) {
@@ -272,14 +273,14 @@ err_virtio:
     }
     g_free(fs->req_vqs);
     virtio_cleanup(vdev);
-    g_free(fs->vhost_dev.vqs);
+    g_free(fs->vhost_vqs);
+    fs->vhost_vqs = NULL;
 }
 
 static void vuf_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserFS *fs = VHOST_USER_FS(dev);
-    struct vhost_virtqueue *vhost_vqs = fs->vhost_dev.vqs;
     int i;
 
     /* This will stop vhost backend if appropriate. */
@@ -295,7 +296,8 @@ static void vuf_device_unrealize(DeviceState *dev)
     }
     g_free(fs->req_vqs);
     virtio_cleanup(vdev);
-    g_free(vhost_vqs);
+    g_free(fs->vhost_vqs);
+    fs->vhost_vqs = NULL;
 }
 
 static struct vhost_dev *vuf_get_vhost(VirtIODevice *vdev)
-- 
MST


