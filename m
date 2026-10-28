Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F5606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GBE4Nq2K;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=k65hplqY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7F3-0005oo-Fi; Wed, 28 Oct 2026 13:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EB-0004sL-98
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7E9-0003Rw-MX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XnAuZFhO072c0WyvJ+C3gOBSJIk3oezJFcFetKX2BdE=;
 b=GBE4Nq2KkJ4OCQ2Bxf32iFDAz579KHrnLCcgJwrsmtHr/RFBAoJJapNBbeFTVbSsKymhuF
 K7qoFi03vyyKJYq6q9R0qyM5X1GNsTBhm3zPWvaWFTIEoDJLRYps7uSl1f/5qFEnMhjWVj
 MrnUKOvmnyE07cU+VOUgevmowJRdRg0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-qXPonOCLNnKpzp6I-C-Qww-1; Wed, 28 Oct 2026 13:14:13 -0400
X-MC-Unique: qXPonOCLNnKpzp6I-C-Qww-1
X-Mimecast-MFC-AGG-ID: qXPonOCLNnKpzp6I-C-Qww_1793207652
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e1d839ddaso797266f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207652; x=1793812452; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XnAuZFhO072c0WyvJ+C3gOBSJIk3oezJFcFetKX2BdE=;
 b=k65hplqYJ3LyFsz+TBOR4HfNf9tOYdsPJb8OgHij5IVbYoUXUMK1RpZ48waG/r1lXA
 VpKFw9m6ups2bqovpJM5gydlUudULizjQAc9nqy9wdEkrcjWRfY1Wls1b680+JvAuUGb
 SRc7uTqbKaW+wv+yAH4HXjn7uDp8uP3tiUBW1BrWpFoRcQqCKZ6Y/VMJxmGFuWvxA9tr
 SGoNf7WJBCWBXi+/1kvMX890BgwyXahCFD3RHA9ARTZ8bxfPFa3HkpRhv0PjT+TKtINL
 MmLh6oPbgRnPUzJy6zeNgW3oghJAf0Z/3lPSxGCzr7BUZpQ80r8Cps7RPwy+pEeXEwYK
 nOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207652; x=1793812452;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XnAuZFhO072c0WyvJ+C3gOBSJIk3oezJFcFetKX2BdE=;
 b=J4C/sCxUZxWFEQEZBnCE+cjzGjfaZD0EUbCnra2m0dfxIdxrDGYF83m2LDpJK+uyrh
 pes3M1fdmfacZib229BKaXMSYHMFpbrCNfPFCv+zM2XsBhXsgqUbpiTZIlGInLV+0p21
 4XyBkxI2TK5ZZeAN3QCmqF8FxwhOFZ2fHCQrG5KvfDhBBH8yRfAxnIYXb5nsDXGv+ZiB
 ESk1AU4nvn7u6efewJIWBhktwlT0sYzW2L1nSsWE+OUAxfwzkuH9NXxi1JjZ2HMrHGLZ
 Pqq3dCTr31kefAbkvWDAYCSz4trWaHCzUmZv7KqvnlvwmYiyAanHUthFHr5gQ7mjdVJS
 t9YA==
X-Gm-Message-State: AFq9FYIwQU24FXsZuc83NA8XjgWrDaUyx7p9vzNiPECfCyuXG0Pdyxoa
 nv7b/5hO5leaa72srqJ2QdIPhVmTZC7zy0T1m0evDfxms1a8ReeB1k4UDASMvXZ9WEvOZ8zEISl
 DKXoKU2JICwnwzzBQDC2+UusuCqF97VsnaGIiOrFe4tfqnR2sFz5rox2mpNhVe2CcbWQggeQQLO
 +4orGLspc2q15M8dAK80N7sMq2J2sKQaMrIQ==
X-Gm-Gg: AYBFou2GUlnPOtbfVNYTggJp5SNc/34Qjn4PKmYLPCTm6o43HSwxXWWsg/zjYmLsTps
 iUUxmYoFRMoQJPA+k7QR36A9iQ1NQ+KKCfKVQzxhGGx7FpsmrGu8NFasEOnEJqJTjHOmgNOphf5
 Da/s81Ytto4cqYOiGhrQXQjqvM0D+sFa+ceCTZMgMCNNf3sAiY+iNmeHmjkgqgto573LXL7oj7c
 fvWCCqYLoA7U8UeGM3pZ2Ww0ItS4W6SRhixiLy8nFopaPIEE5ejkw5J7f1lSuQAsbp1es5g6dfg
 Zt+NtcZj1BJn3+yNYx5u1UrECHvYIE5bWn6xy/fcMdIiabZ8C+PP+TtJwmy4/jQZx0yfRhnnbh2
 jUqk08XP5BU2v0TycOuPScXlV4AAMasKPDjc99+wG
X-Received: by 2002:a05:600c:3b24:b0:4a0:2391:6540 with SMTP id
 5b1f17b1804b1-4a966e2b4damr63033435e9.25.1793207652082; 
 Wed, 28 Oct 2026 10:14:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3b24:b0:4a0:2391:6540 with SMTP id
 5b1f17b1804b1-4a966e2b4damr63032505e9.25.1793207651445; 
 Wed, 28 Oct 2026 10:14:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa820492cesm5438485e9.13.2026.10.28.10.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:10 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 06/78] hw/net: finish backend initialization earler for local
 migration
Message-ID: <8b6638b507e1183c4d646e44b75e1575a9ae0f95.1793207602.git.mst@redhat.com>
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks to pririty, backend is migrated before the virtio-net itself.
So we can finish the releate initialization already in .pre_load,
not postponing it to .post_load.

Fixes: bb71b1bffe58 ("virtio-net: support local migration of backend")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260914175351.393680-4-vsementsov@yandex-team.ru>
---
 hw/net/virtio-net.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 19f453fb7d..4794496b96 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3250,13 +3250,28 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     }
 }
 
+static bool virtio_net_pre_load_device(void *opaque, Error **errp)
+{
+    ERRP_GUARD();
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    if (n->peers_wait_incoming) {
+        /* MIG_PRI_BACKEND ensures the peers have already been loaded. */
+        n->peers_wait_incoming = false;
+        peer_test_vnet_hdr(n);
+        virtio_net_get_features(vdev, vdev->host_features_ex, errp);
+    }
+
+    return !*errp;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int i, link_down;
     bool has_tunnel_hdr = virtio_has_tunnel_hdr(vdev->guest_features_ex);
-    Error *local_err = NULL;
 
     trace_virtio_net_post_load_device();
     virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
@@ -3314,20 +3329,6 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     }
 
     virtio_net_commit_rss_config(n);
-
-    /*
-     * If live-migration is enabled for some backend, than backend
-     * has already been migrated at higher priority (MIG_PRI_BACKEND)
-     * and virtio_net_vnet_post_load() has already called
-     * peer_test_vnet_hdr().  Recompute host_features so that virtio-net
-     * reflects the capabilities of the restored backend.
-     */
-    virtio_net_get_features(vdev, &vdev->host_features, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return -EINVAL;
-    }
-
     return 0;
 }
 
@@ -3478,14 +3479,6 @@ static int virtio_net_vnet_post_load(void *opaque, int version_id)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
-    /*
-     * If live-migration is enabled for some backend, than backend
-     * has already been migrated at higher priority (MIG_PRI_BACKEND),
-     * so n->has_vnet_hdr can be refreshed from the live backend right
-     * here.
-     */
-    peer_test_vnet_hdr(tmp->parent);
-
     if (tmp->has_vnet_hdr && !peer_has_vnet_hdr(tmp->parent)) {
         error_report("virtio-net: saved image requires vnet_hdr=on");
         return -EINVAL;
@@ -3674,6 +3667,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
+    .pre_load_errp = virtio_net_pre_load_device,
     .post_load = virtio_net_post_load_device,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(mac, VirtIONet, ETH_ALEN),
-- 
MST


