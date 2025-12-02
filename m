Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06097CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQKL-0006y6-9p; Tue, 02 Dec 2025 08:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vQQKK-0006xi-0F
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:21:56 -0500
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vQQKG-0006HB-HZ
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1y
 Bh5bAlxFXKDxT277s3sK6yV4v/HI4L12nI7ZZvkg8=; b=aG5WhiLaSKeexcsyqr
 Ez3AVm3QNmKRKojqT0DlQN1MB97ftojmaqDsV6XEs1dSrEE6tHujKG98Fq+NnbT9
 +U+JgBk4siuNsQ7algW7Yqq6fRLvm35iKGFlk+IxO5qIVStoLxrnMvPJ3lZO/dmc
 qy+vwCHW0+jxdNp9hHbkEQHEY=
Received: from DESKTOP-V2BFH29.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wAHb8fd5y5po6DhEQ--.13728S2; 
 Tue, 02 Dec 2025 21:21:34 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org,
 Alano Song <AlanoSong@163.com>
Subject: [PATCH 2/2] hw/9pfs: Correct typo
Date: Tue,  2 Dec 2025 21:21:32 +0800
Message-ID: <20251202132132.17636-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHb8fd5y5po6DhEQ--.13728S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW5Zry7Ww45ZFy3Xw43Wrg_yoWxuFb_Ga
 1kJr97ur45AFsFya43ZrW3tr9293y8Jrn8Kan2krsI93yUZr45Zws8AFs3X3yxXw47CrW3
 Ww1qqayayrW3AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMtxSPUUUUU==
X-Originating-IP: [221.232.164.177]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbBXx0YFGku4d1glgAAsD
Received-SPF: pass client-ip=220.197.31.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Correct comment typo in xen_9pfs_bh()

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 hw/9pfs/xen-9p-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 79359d911a..ca0fff5fa9 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -310,7 +310,7 @@ static void xen_9pfs_bh(void *opaque)
 
 again:
     wait = ring->co != NULL && qemu_coroutine_entered(ring->co);
-    /* paired with the smb_wmb barriers in xen_9pfs_init_in_iov_from_pdu */
+    /* paired with the smp_wmb barriers in xen_9pfs_init_in_iov_from_pdu */
     smp_rmb();
     if (wait) {
         cpu_relax();
-- 
2.43.0


