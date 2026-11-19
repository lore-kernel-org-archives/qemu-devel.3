Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC14606A332
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bLLFRAkZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=n4T34pcJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTykD-00068H-Qa; Thu, 19 Nov 2026 04:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjw-0005l8-K8
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjs-0006Ox-Gv
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795081651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uR5yadMCiYBDHx6cdYQqdbYOSfJusa2Mc0izMbIjnuo=;
 b=bLLFRAkZC3LFKT2fWbA2QBvdxYbw0WxitMQTPzjGwf5KN61ZZM5MBXrFrOO9WDyMad8Tuu
 W5QBrBJ4tFWYJfFPWAx7Q+ZRn2hVcYzu83KZyyXxI6SB6CkA9MW/zRTdBaLUyTo9m0MgdX
 oTnuZin3aiJlLnus9s79sJ79EozWAK0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-kIgaxAhXOC6OWyh6s3vfJw-1; Thu, 19 Nov 2026 04:47:30 -0500
X-MC-Unique: kIgaxAhXOC6OWyh6s3vfJw-1
X-Mimecast-MFC-AGG-ID: kIgaxAhXOC6OWyh6s3vfJw_1795081649
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so13161775e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795081649; x=1795686449; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uR5yadMCiYBDHx6cdYQqdbYOSfJusa2Mc0izMbIjnuo=;
 b=n4T34pcJSNPdJhbxBxaGIT8x1veLOSEdf5ZHzSPuMzUK7+I/+Jc+f83k81hUUg8XCH
 0rb9uPsUzOC6brejuWUH6VWeriPkUxcDwyKbi/95YkQZtPeUv7nsmbGogZ3zp2LQQREa
 7u5OQ1vDdAvP8L+9waM/UCtnqn0gCuUj94TyIue6P2gMwIGSIMDps1k/4STUC192lYqW
 v3ODoXvf8iNAJ4o/SDDwvViwOvOw/AnRoz0soO7ygEUlOL7s74volLnPsRQrKbee4n3y
 WmUiMDoELKZVddZ/2qaXkJIGB6gksIdNLBgDjO5dnGotpbPquArEqKVxGKB2YBMqD1UE
 4pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795081649; x=1795686449;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uR5yadMCiYBDHx6cdYQqdbYOSfJusa2Mc0izMbIjnuo=;
 b=BCtMNgmZEf435zH00T+C3kPY1aIopXLkYww+3xivzGNhAfxyTVG1k4VuOS6T1pk+Ux
 lLcB996d2VDcOXj7r+Rutm+gtkl0I0TRwh/jHp0U664wPXLj2C1XFuaKd5dxY8NmarN0
 6pj5v36t+DRwuwJEbZZozv7Vz02RuVnvCHINQBYXfPaHcV5O6NAY0e0meKzXsApgAkKr
 NKtdl6Ou+BwUhbKoaHo2L2o9WItIPSKHGccTM10nCq1W2/bRqZMHWQHZDHXHyXe4i+vf
 9w6sQMyTJdSJjWROX4iHpRX9PNgSZhYgCnVhYJMWLpqHDiCv/XDMPCMcd78faH4getvq
 wx7A==
X-Gm-Message-State: APuU4Z+Dwl4oSPtcH3eB8ztLKNxsx4I6pkQMeHcT7LkqI+DUdAY4FnDD
 lQnaC5Gewjay2Zt8YmD2V/ytwdAtqgJ38sHmp4W7UtYJmXnS+S7o42JCSGlrxbjuJ7SFSYYkgEn
 GBhkd2TOXGEutfiVzZzQq/jyVDPEM5LxG6usgYZJOgEnh3Jbq8gXNAKxlyxFf0+auoIfo38teA5
 TzwhLsZgKvW9sNQ0t+n9yAQSpSuk/bKkYcUQ==
X-Gm-Gg: AYBFou3y5OeQC/gIsXayV4VY66D3TJbtjYlPIZNePb7xr8HucVx8xGrfbAH/+RY1D7g
 XVjtklOyLv3OyQXGgqXKnYs6Vxt6RTSRdQY4Po3WjXcVPotj7YV2rOXn8b7DLLdX/iHowYQzOQE
 CGPA8yKcgnvP1Vr1d2THffmlz6h+MX6vA7aegZVBx74RLS0G7iT496Qit3k6O3kOsrFBcct6dgf
 sn8i/7ULGqwvqcHJgBPu3j/WT5GEb6G07i32QtEddW+obPNMeKr8ZlrGSNIvsAfFI2ejzQH33jg
 urHpC5S59lg0M+/VDYm17WiSDJQXe5lNOLvwxMNJfyJCobypEznU7J3WliPiVCITGQsQjoze3SK
 7QJw0rVUFKPuDsFwNuN7PxZPj/56ZO4/Z2Fb0nI0140M=
X-Received: by 2002:a05:600c:1d0f:b0:4bb:56bb:1196 with SMTP id
 5b1f17b1804b1-4bb7da349e2mr108996245e9.23.1795081648668; 
 Thu, 19 Nov 2026 01:47:28 -0800 (PST)
X-Received: by 2002:a05:600c:1d0f:b0:4bb:56bb:1196 with SMTP id
 5b1f17b1804b1-4bb7da349e2mr108995405e9.23.1795081647781; 
 Thu, 19 Nov 2026 01:47:27 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a655608733sm8648511f8f.22.2026.11.19.01.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 01:47:26 -0800 (PST)
Date: Thu, 19 Nov 2026 04:47:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jia Jia <physicalmtea@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PULL 8/8] hw/virtio/virtio-crypto: Drain in-flight operations
 before unrealizing (CVE-2026-50625)
Message-ID: <902c849979ce2be367dc0a643310d6b45b76bcd4.1795081539.git.mst@redhat.com>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Huth <thuth@redhat.com>

virtio_crypto_device_unrealize() does not drain or cancel requests that
are sitting in the cryptodev backend's throttle delay queue. So when
hot-unplugging the device, the throttle timer callback can still run and
complete the queued operation later through the virtio_crypto_req_complete()
callback, which dereferences the already-freed VirtIOCrypto device and its
deleted virtqueue, so we end up with a host use-after-free bug here.

Fix it by draining the queue first before deleting the virtqueue and the
device.

CVE: CVE-2026-50625
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3918
Reported-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261118123948.221366-1-thuth@redhat.com>
---
 include/system/cryptodev.h |  9 +++++++++
 backends/cryptodev.c       | 19 +++++++++++++++++++
 hw/virtio/virtio-crypto.c  |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/include/system/cryptodev.h b/include/system/cryptodev.h
index b20822df0dc..a160a6781a7 100644
--- a/include/system/cryptodev.h
+++ b/include/system/cryptodev.h
@@ -389,6 +389,15 @@ int cryptodev_backend_close_session(
            CryptoDevCompletionFunc cb,
            void *opaque);
 
+/**
+ * cryptodev_backend_drain_requests:
+ * @backend: the cryptodev backend object
+ *
+ * Drain crypto operations that might still be in flight on a throttled
+ * backend.
+ */
+void cryptodev_backend_drain_requests(CryptoDevBackend *backend);
+
 /**
  * cryptodev_backend_crypto_operation:
  * @backend: the cryptodev backend object
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 46059faa26c..faf5592bc87 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -263,6 +263,25 @@ static void cryptodev_backend_throttle_timer_cb(void *opaque)
     }
 }
 
+void cryptodev_backend_drain_requests(CryptoDevBackend *backend)
+{
+    CryptoDevBackendOpInfo *opinfo, *tmp;
+
+    /* Cancels pending timer, prevent it from firing during or after drain */
+    if (throttle_enabled(&backend->tc)) {
+        throttle_timers_detach_aio_context(&backend->tt);
+    }
+
+    QTAILQ_FOREACH_SAFE(opinfo, &backend->opinfos, next, tmp) {
+        QTAILQ_REMOVE(&backend->opinfos, opinfo, next);
+        cryptodev_backend_operation(backend, opinfo);
+    }
+
+    if (throttle_enabled(&backend->tc)) {
+        throttle_timers_attach_aio_context(&backend->tt, qemu_get_aio_context());
+    }
+}
+
 int cryptodev_backend_crypto_operation(
                  CryptoDevBackend *backend,
                  CryptoDevBackendOpInfo *op_info)
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 85c7279aae2..6d053e7d936 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1116,6 +1116,8 @@ static void virtio_crypto_device_unrealize(DeviceState *dev)
     VirtIOCryptoQueue *q;
     int i;
 
+    cryptodev_backend_drain_requests(vcrypto->cryptodev);
+
     for (i = 0; i < vcrypto->max_queues; i++) {
         virtio_delete_queue(vcrypto->vqs[i].dataq);
         q = &vcrypto->vqs[i];
-- 
MST


