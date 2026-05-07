Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E213CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 14:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL04K-0007yy-DF; Thu, 07 May 2026 10:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wL04I-0007xE-FQ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:51:14 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wL04D-0003Mh-Vx
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:51:13 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c7980c060cfso386548a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778165468; x=1778770268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gg+yQpxnjMcbYAS/ikBybrI3GZRRSBIF8hpU/1immNw=;
 b=R/r8V1fQoNtrweothuySP/icU17a7EBi0LS2onhcqhvGL1EfX4SP/G2WidTerDVIMN
 KLGflR8mYKlOa9bUqEvi3Rzx/SDiWDQ1cbHHX95RGM5hgxtPt0f3KuKmzOKloRwnX5LM
 fN6mdrBpi6Ut7bqGgJDvsmpQEIppsTv6GTHCB4tHLx5atHS24Xc0/mQ1yocGVVSjGGaZ
 GapKdSLxfe3fsCAIl+Dc782cFLUkz8KrIMiZxs8JYypNCOaqkD8GIbRg2fGhvWGh6H6z
 51P/ituhNzwfIbCWMJdEyAUVx6jd+IcEpyjyZqhYl6DrLXkcZeQ7gBMX5MDRpSWYHgAG
 jRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778165468; x=1778770268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gg+yQpxnjMcbYAS/ikBybrI3GZRRSBIF8hpU/1immNw=;
 b=cE6mvdc2AuTuS6rtmLglWsq0kaQPIHFHB1PIKmQjP2cYnovrkuW9pGPK9A5sdoK6LX
 WFdKKfRWrr8+FgsQ7QlhF1v4gmI7B6/Vx4Bm7zac9FnzKSx/FvhLtmzk0Kl+N2t4snK4
 IbGJ5xREOjA/9hNruwZzw/fKOVNfZhxGUq1fWxUzEq26uLDMuz+PBblL4VYDBo/+ISYP
 dBINkBCCG0ZK5Jzwz6KmiMR49dcaIuplfawCeTtl2/z6EyxMgAl0bxyROmIvihqC/7f+
 7kjd3f9V0Pyp7jdNgiVx3+nEN5sCIV/qKgrHC3SoGD00RhuAbRtc3OCckqtY9Bs9uvCF
 BCaQ==
X-Gm-Message-State: AOJu0Yz6FYU9UNGFn7juo1xSgfUjHPa1ewGvwQdFrAX85UINehRZHCos
 vGs67dFsfhvLpP7Q9/BXiuyHEH8PqWDLYbNjY/uLDDSSR6THPhm8j+4TaR6V4hm2Bf8=
X-Gm-Gg: AeBDieuvJ/gmuDQkAIZy1isdPBT6IGGAORjIsAhWeIq7qLr9fRa+QSNhLG3tMyxniI4
 zew8YHipqVKSc08yKq5waWMkPElKdP+MUMBgvQTT7Hu9a4jWhmivG4uXDcj/VBGKn7u9JGGEA4L
 EzE3pMqBsryPZETSLbxsbFH90YR9QyfTBSxSwrffuKodPIhugsR/8C53i2M1RoEg3/fwBRRBC3x
 CgwCb4YqfQyeraCDIXY/wR7Z5Y+Jpf2DeUM0dvFxzP4jNs3e2ydOoc2+WnQGJzFqUmCi0Uh451D
 142u0wqzipcOOTm8c+FYqNTn8Darh7cPyQmaGl7HqAB7g6NAjIIrfM5KbGNY6R6ysVKBT+AZWvF
 cGwqtjFH8BlOLCYFPHHfpyQ5B5y5cVUXSXWAgjYS/zGyYeK8FRPpRVE+tKzVjuCue0XBL+Zvhy9
 aP74TNFEChjVs2Mf9zlOLzTIz3qqtenetNH5WG3Y+DCMW0UJ6h1Wd01D7fKirKJrn997Q/O8d8p
 tmIlRC90Ybt
X-Received: by 2002:a05:6a20:4320:b0:3a3:bb6:70a1 with SMTP id
 adf61e73a8af0-3aa5a911f31mr8664616637.20.1778165467706; 
 Thu, 07 May 2026 07:51:07 -0700 (PDT)
Received: from localhost.localdomain ([2407:6400:c000:f1c:65df:6a03:fc0e:2005])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8253790c29sm2448374a12.11.2026.05.07.07.51.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 May 2026 07:51:07 -0700 (PDT)
From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Subject: [PATCH] hw/virtio/virtio: Rebuild vring caches when packed ring
 changes
Date: Thu,  7 May 2026 22:51:00 +0800
Message-ID: <20260507145100.4861-1-munkhuu0825@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=munkhuu0825@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A guest can enable a virtqueue before feature negotiation completes, so
virtio_queue_set_rings() creates caches before VIRTIO_F_RING_PACKED is
loaded into guest_features.
Packed rings need a writable descriptor cache because used descriptors are
written back into the descriptor ring. If the cache was created as a split
ring cache, this can later trigger an assertion.
Rebuild existing vring caches when VIRTIO_F_RING_PACKED changes, as already
done for VIRTIO_RING_F_EVENT_IDX.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3466

Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
---
 hw/virtio/virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 63e2faee99..14e7dd70be 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3223,8 +3223,9 @@ int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
     }
 
     ret = virtio_set_features_nocheck(vdev, features);
-    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
+    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) || virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
         /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
+        /* VIRTIO_F_RING_PACKED changes the cache->is_write value. */
         int i;
         for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
             if (vdev->vq[i].vring.num != 0) {
-- 
2.50.1 (Apple Git-155)


