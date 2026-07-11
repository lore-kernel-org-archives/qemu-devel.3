Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B057AC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifnf-00014b-TU; Sat, 11 Jul 2026 18:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifnd-000132-PO; Sat, 11 Jul 2026 18:03:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifnc-0000Cv-7m; Sat, 11 Jul 2026 18:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=sOb7KOaB9Fa5lT3CgCH9pL8kdvFT6gD12EgC3VN22GE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ECAKRPbDnYFMhwWCJa14wpzEst2uQtxdYdla2e9MoMSdnbqF82woyemPfwOhlsIOD
 4gLmb+x9/NBsrGfzMViP3co6jK+T9cD/omg57XjmmdhmgVlaP+9HI5PS7KlNDVGWAV
 U3b0EY2PIs0f5HPH0Fx+RymjQuui2E3rGLxAUnvl5ELFnurvFKyShyW29kZ1on2Gi4
 F9r7xSGwUw8HyhcARa48R+MxRz00xseTVmLG9JHN6y67Dhh73E/oVE/Pl4b7A3WCey
 I9wvnRgOwvA2GJBMAqxZwpbl4N5/vo11HzxgtVy1cTFl4Qaph/cy8u48s7fO/WQgrl
 4GPJTy9OSqStg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 222A31C0AB7;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CD16E3EAF42;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A0DDD1333B; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Miao Wang <shankerwangmiao@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 44/81] target/loongarch: Enable TARGET_PAGE_BITS_VARY
 for loongarch64 user-only
Date: Sun, 12 Jul 2026 00:58:22 +0300
Message-ID: <20260711215904.3757-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Miao Wang <shankerwangmiao@gmail.com>

Hard coding PAGE_SIZE to 4K will prevent user-only emulation from
working on hosts with 16K page size.

Fixes: 1d832c19db1e ("target/loongarch: Support 4K page size")
Fixes: qemu-project/qemu#3651

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260630-loong64-vary-page-sz-v1-1-1d1a894674be@gmail.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit e819c126a8d9629f57deef31689f3a7fc476fa45)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 3bcf77b3755..6abe72ff5ca 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -10,6 +10,11 @@
 
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
 
-#define TARGET_PAGE_BITS 12
+#ifdef CONFIG_USER_ONLY
+/* Allow user-only to vary page size from 4k */
+# define TARGET_PAGE_BITS_VARY
+#else
+# define TARGET_PAGE_BITS 12
+#endif
 
 #endif
-- 
2.47.3


