Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD0DC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravEo-0005Kv-Vl; Fri, 16 Feb 2024 05:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ravEl-0005IV-6P; Fri, 16 Feb 2024 05:14:31 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ravEj-00080j-Bo; Fri, 16 Feb 2024 05:14:30 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id ED3AA48532;
 Fri, 16 Feb 2024 11:14:25 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 yong.huang@smartx.com, berrange@redhat.com
Subject: [PATCH] iotests: adapt to output change for recently introduced
 'detached header' field
Date: Fri, 16 Feb 2024 11:14:15 +0100
Message-Id: <20240216101415.293769-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Failure was noticed when running the tests for the qcow2 image format.

Fixes: 0bd779e27e ("crypto: Introduce 'detached-header' field in QCryptoBlockInfoLUKS")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qemu-iotests/198.out | 2 ++
 tests/qemu-iotests/206.out | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 805494916f..62fb73fa3e 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -39,6 +39,7 @@ Format specific information:
     compression type: COMPRESSION_TYPE
     encrypt:
         ivgen alg: plain64
+        detached header: false
         hash alg: sha256
         cipher alg: aes-256
         uuid: 00000000-0000-0000-0000-000000000000
@@ -84,6 +85,7 @@ Format specific information:
     compression type: COMPRESSION_TYPE
     encrypt:
         ivgen alg: plain64
+        detached header: false
         hash alg: sha256
         cipher alg: aes-256
         uuid: 00000000-0000-0000-0000-000000000000
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 7e95694777..979f00f9bf 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -114,6 +114,7 @@ Format specific information:
     refcount bits: 16
     encrypt:
         ivgen alg: plain64
+        detached header: false
         hash alg: sha1
         cipher alg: aes-128
         uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
-- 
2.39.2



