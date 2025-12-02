Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C850BD116FE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQIR-0005T6-VW; Tue, 02 Dec 2025 08:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vQQIQ-0005Rb-A2
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:19:58 -0500
Received: from m16.mail.163.com ([220.197.31.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vQQIK-0005kB-IU
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Bo
 +fojq08lpMx60axXAa91mtLZVXnvDRxJVAPI3KsUM=; b=WDb5QrPuQoIdhBR5GE
 fgjNoAAgtEB04dARZ8TXZl7KtDwwey6tsILyMl//+AxWIfvxEYcjJsQoe4n3P20i
 CJpQvyCU9GHJ7VKJVwhsz0yiHcv+Jxx6xJilGk2ozcpAWc9yOgafyaQlEY6/pDwB
 QfdWy0poj802taIxmArgOUgJo=
Received: from DESKTOP-V2BFH29.localdomain (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wDHe6dn5y5pSkvkDw--.4022S2; 
 Tue, 02 Dec 2025 21:19:36 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, berrange@redhat.com, Alano Song <AlanoSong@163.com>
Subject: [PATCH 1/2] docs/devel: Correct typo
Date: Tue,  2 Dec 2025 21:19:34 +0800
Message-ID: <20251202131934.17324-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHe6dn5y5pSkvkDw--.4022S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1rWr4xuFWDAry7urWfXwb_yoWkKrX_KF
 yUtF1DXr4rAr4Yqw4Ykr4fArZ5AwsIvry8Gw17JFW3Xr93KryYyr1DWwsxXr1xuan0kr4a
 yF18Wr18Kr15WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMWrXPUUUUU==
X-Originating-IP: [221.232.164.177]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC1Aj5Dmku52iRyAAA36
Received-SPF: pass client-ip=220.197.31.4; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Correct typo in atomics.rst

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 docs/devel/atomics.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index 95c7b77c01..ea4ede4b8c 100644
--- a/docs/devel/atomics.rst
+++ b/docs/devel/atomics.rst
@@ -266,7 +266,7 @@ Splitting a loop can also be useful to reduce the number of barriers:
     |   n = 0;                                 |     smp_mb_release();            |
     |   for (i = 0; i < 10; i++) {             |     for (i = 0; i < 10; i++)     |
     |     qatomic_store_release(&a[i], false); |       qatomic_set(&a[i], false); |
-    |     smp_mb();                            |     smb_mb();                    |
+    |     smp_mb();                            |     smp_mb();                    |
     |     n += qatomic_read(&b[i]);            |     n = 0;                       |
     |   }                                      |     for (i = 0; i < 10; i++)     |
     |                                          |       n += qatomic_read(&b[i]);  |
@@ -283,7 +283,7 @@ as well) ``smp_wmb()``:
     |                                          |     smp_mb_release();            |
     |   for (i = 0; i < 10; i++) {             |     for (i = 0; i < 10; i++)     |
     |     qatomic_store_release(&a[i], false); |       qatomic_set(&a[i], false); |
-    |     qatomic_store_release(&b[i], false); |     smb_wmb();                   |
+    |     qatomic_store_release(&b[i], false); |     smp_wmb();                   |
     |   }                                      |     for (i = 0; i < 10; i++)     |
     |                                          |       qatomic_set(&b[i], false); |
     +------------------------------------------+----------------------------------+
-- 
2.43.0


