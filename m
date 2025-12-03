Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0007AD116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjHX-00006c-Kl; Wed, 03 Dec 2025 04:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjHW-0008Vx-36; Wed, 03 Dec 2025 04:36:18 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjHT-00072O-Qz; Wed, 03 Dec 2025 04:36:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 27FC01708AC;
 Wed, 03 Dec 2025 12:35:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B1C932B5A3;
 Wed, 03 Dec 2025 12:36:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jack Wang <jinpu.wang@ionos.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 77/96] qmp: Fix a typo for a USO feature
Date: Wed,  3 Dec 2025 12:35:10 +0300
Message-ID: <20251203093612.2370716-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jack Wang <jinpu.wang@ionos.com>

There is a copy & paste error, USO6 should be there.

Fixes: 58f81689789f ("qmp: update virtio feature maps, vhost-user-gpio introspection")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 5fbcbf76a19a0d3500a4103fc8876c6cace2afcf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3b6377cf0d..f2c7a327d0 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -299,7 +299,7 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
             "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
-            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
+            "VIRTIO_NET_F_GUEST_USO6: Driver can receive USOv6"),
     FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
             "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
     FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
-- 
2.47.3


