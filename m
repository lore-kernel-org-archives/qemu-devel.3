Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EF2CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v148J-00038b-Al; Tue, 23 Sep 2025 10:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1v148F-00037Z-4W
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:36:39 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1v148C-0002r1-Uq
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:36:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F007433AF;
 Tue, 23 Sep 2025 14:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28360C113D0;
 Tue, 23 Sep 2025 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758638194;
 bh=HjFoetad7pVh56arqUjyTqmHVD2kvUjNM6Qt9XVUY6o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q7MpH9CfdeeR9O4RaZXlMviBorSf2k6lIiar8rOr51qPzINu4JjwTvPWzdc/oH4U2
 5FiFiS7lm8XW65Ur6p2iAJr3++a2BZAZh+l7Ji2QHg7i1vYtMGCaqUBZ4Kq4AMoY+f
 eR0qTsfNWV9XEvGtdsY6JpO/lJ7C1SxXNoLTWyySb3oOMBIUCxMo08NzHWyBSXl6DW
 tETJaBha3sRBEFpWZOeR79Gdd/fQEbSCE8c0LSm3eHrur92ElYoKyh62aaOoRQ85FP
 3EybSXOPP0MRH/4yQiYEJs2sORbeIPrPnsMcn3Pf8sMzng2nJKuy0q3KQgyqdUK7GL
 Z2mM8eTqjEVZQ==
From: Huacai Chen <chenhuacai@kernel.org>
To: Bibo Mao <maobibo@loongson.cn>,
	Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, WANG Xuerui <git@xen0n.name>,
 qemu-devel@nongnu.org, Huacai Chen <chenhuacai@loongson.cn>,
 Nathan Chancellor <nathan@kernel.org>, WANG Rui <wangrui@loongson.cn>
Subject: [PATCH 2/3] hw/loongarch/virt: Align VIRT_GED_CPUHP_ADDR to 4 bytes
Date: Tue, 23 Sep 2025 22:35:41 +0800
Message-ID: <20250923143542.2391576-3-chenhuacai@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923143542.2391576-1-chenhuacai@kernel.org>
References: <20250923143542.2391576-1-chenhuacai@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=chenhuacai@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Huacai Chen <chenhuacai@loongson.cn>

Now VIRT_GED_CPUHP_ADDR is not aligned to 4 bytes, but if Linux kernel
is built with ACPI_MISALIGNMENT_NOT_SUPPORTED, it assumes the alignment,
otherwise we get ACPI errors at boot phase:

ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
ACPI Error: Aborting method \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
ACPI Error: Method execution failed \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/uteval-68)

VIRT_GED_MEM_ADDR and VIRT_GED_REG_ADDR are already aligned now, but use
QEMU_ALIGN_UP() to explicitly align them can make code more robust.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/hw/loongarch/virt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 602feab0f0..be4f5d603f 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -28,9 +28,9 @@
 #define VIRT_LOWMEM_SIZE        0x10000000
 #define VIRT_HIGHMEM_BASE       0x80000000
 #define VIRT_GED_EVT_ADDR       0x100e0000
-#define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
-#define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
-#define VIRT_GED_CPUHP_ADDR     (VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT)
+#define VIRT_GED_MEM_ADDR       QEMU_ALIGN_UP(VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN, 4)
+#define VIRT_GED_REG_ADDR       QEMU_ALIGN_UP(VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN, 4)
+#define VIRT_GED_CPUHP_ADDR     QEMU_ALIGN_UP(VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT, 4)
 
 #define COMMAND_LINE_SIZE       512
 
-- 
2.47.3


