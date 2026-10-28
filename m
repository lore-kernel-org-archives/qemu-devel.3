Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D660A260D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XaTKBbO2;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mwM1vq7D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Ex-0005Qw-3o; Wed, 28 Oct 2026 13:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EX-00050k-1G
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EV-0003UN-3U
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IGAasCOUtNnTrrwN35jFP2NQ2pimHTrnQ4NgMlN/VPQ=;
 b=XaTKBbO2eFDNTZjzcsMxE+hVLSOpUcBE2W0O3/PvAq9XX93gJ+7atup2brik8HnmX1gKJP
 vT4cEQp6mPLD2jV85qGB1DKS5oELsDSEXM0zQ4fnIGnTqgAEqdUyAMGmqBBiGtv/lV96si
 0OsApYMawFxz6/c9pjtsIwxS8f6AeL4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-e-8oHRzCNF6mtG5YCzU_Fw-1; Wed, 28 Oct 2026 13:14:37 -0400
X-MC-Unique: e-8oHRzCNF6mtG5YCzU_Fw-1
X-Mimecast-MFC-AGG-ID: e-8oHRzCNF6mtG5YCzU_Fw_1793207676
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e1291432aso900376f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207676; x=1793812476; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IGAasCOUtNnTrrwN35jFP2NQ2pimHTrnQ4NgMlN/VPQ=;
 b=mwM1vq7DfziicagtukBerIoisSJOs8wCut33wEYaX5EmKGR4Lp3yIuJsRhArR79RNj
 PoV8WPwawPBodCNyPVEjGFFxF9lR1xOP35pcdu96jP9r+2Pu3qFddi4tZUNRGkvrLhkI
 e7bnWcnuRptwTsmjhgE3LDgMXyRt2diIqPf5ehq1fdbhoNMvGc8JWWU5cSnFQNF8W6bd
 jS4UDDDGhIagKpOcGK32MPVqly24ylLJp0yivraPj5OmWJKonGPTJmNVsrQ3Qpevyz+a
 5bTh4b3p1J4LFMdzJZ1Wyy0diNbfb/qb1dvm0Cj3jZOljuZYFpDrpPaDDq8d+2egqtDG
 +DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207676; x=1793812476;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IGAasCOUtNnTrrwN35jFP2NQ2pimHTrnQ4NgMlN/VPQ=;
 b=MzAFxUoSow32xeAQ5OIV9p0Nct14w4Sp3H8fC/F0T/tsBsZbofQ0uHArZl3eoFDbMX
 ISnMzha3UDufrdZkQT8WsfoEUXezWhn4Z3J9veb3fS1Hzbcj9CkxyfZkOjei5yzJeUuO
 JkV/i3VA62TrRIRTis6+/bggvQx3SlYVw1WDh1SKSIQLmTrzJsnvuYToiZPM1DryVd27
 /LRLtcb+EHrh4n8zujCIKwFwBeWzfc7HTLx3CP1Q4o1+eYW6yuPiUTWe9MNjbZpTAF8n
 kSt3SjVMuo1OJ4XAYsgZ6XFs6jBf4ANyWW/HyxqNNKvpbWuPoPEP/pGxX8jNU0jQz1Xw
 VULA==
X-Gm-Message-State: AFq9FYLyk56RD4235bVZBJ/7W10u+bqGZS+fNUMgKuYKyoaDUcJRMWmx
 pXy0mF8e/ocWfZvzEh/grZGC7rLUoKgCOTfDwY6K/83I3j5kQJMzayQEyfbslpvrXZRMSG0D40P
 T5zdkUZROIlU0Wa4NjxXwRodpEOeLuDFUIcSso331Fyfm3I3YQMmdYjsaN4XE3pZ/keX2YIXw58
 by0bPlOn8rPfu+ngbkbGFsa0NGpxcfZ+0utA==
X-Gm-Gg: AYBFou3N1yyL1rctGpmU9X3nHKCppRzcP5tpZ+05kFPkdduJisfTVNLIbuIVRxhU+pV
 g4J761doaISlShL8PYYtD2vtNLkMXs99SxK3IQ128zf+QgdT6q4AyZ9DW6hu9rtR/oS6yX0EZpv
 hXfrXYB2qmu9qGGj4xO/gXcfzPWjjz3QQ/KajGjYscz1BF7p6PvoPPem5PZxonfvCEk3nbb8B+i
 rtNCHzTEKfYQzapwxQrbz/kV/l/4lk/p1UZJlRtll6+vEp+MA/UJjz88IKl8yCdUFjQgp11SL5Z
 3EQQZgqYUJHF50BXi+b2czqy5f02AVMKvnPMybqktB0q3mKyumsfKqQQMnnYnkVAeqrnAHG5YA1
 VN7dzdcF2Zd8/6hNvkLUsZLUasw0avithqczKNtEA
X-Received: by 2002:a5d:4d11:0:b0:48d:e6f6:21cf with SMTP id
 ffacd0b85a97d-48e5d5cf427mr5642512f8f.31.1793207675727; 
 Wed, 28 Oct 2026 10:14:35 -0700 (PDT)
X-Received: by 2002:a5d:4d11:0:b0:48d:e6f6:21cf with SMTP id
 ffacd0b85a97d-48e5d5cf427mr5642457f8f.31.1793207675096; 
 Wed, 28 Oct 2026 10:14:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd37f4sm35247995f8f.44.2026.10.28.10.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:34 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 15/78] vhost-vsock: block CPR migration modes
Message-ID: <dd80bd57bdfb4ec813ff465aca4acd85ff3bff82.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CPR migration with a vhost-vsock device currently crashes the target
QEMU.  The device ownership is not handed over, so while the source
QEMU still holds the guest CID hashed in the kernel, the target's freshly
opened vhost-vsock device fails to set the same CID in realize():

  qemu-system-x86_64: -device vhost-vsock-pci,id=vsock0,guest-cid=3:
  vhost-vsock: unable to set guest cid: Address already in use

Add an unconditional migration blocker for the CPR modes, so that such
a migration fails early and gracefully instead.  The following patches
implement the actual vhost-vsock CPR support, and the blocker is lifted
once it's fully working.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-6-36c38bd15ffc@virtuozzo.com>
---
 include/hw/virtio/vhost-vsock.h |  1 +
 hw/virtio/vhost-vsock.c         | 27 +++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 84f4e727c7..a964d57e1b 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,6 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
+    Error *migration_blocker;   /* CPR migration is not supported */
 
     /*< public >*/
 };
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb165..503d248a61 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -140,25 +142,38 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPR migration of a vhost-vsock device is not supported yet: the
+     * device ownership is not handed over, so the target fails to set
+     * up its device.  Fail the migration early and gracefully instead.
+     */
+    error_setg(&vsock->migration_blocker,
+               "vhost-vsock: CPR migration is not supported");
+    if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                  BIT(MIG_MODE_CPR_TRANSFER) |
+                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+        return;
+    }
+
     if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     }
 
@@ -187,16 +202,20 @@ err_vhost_dev:
     vhost_dev_cleanup(&vvc->vhost_dev);
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
+err_blocker:
+    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostVSock *vsock = VHOST_VSOCK(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
-- 
MST


