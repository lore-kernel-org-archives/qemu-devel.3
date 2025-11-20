Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9087CF64A0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 01:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLt4w-0000EY-Q5; Wed, 19 Nov 2025 20:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vLski-0004Gx-So; Wed, 19 Nov 2025 19:42:24 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vLskg-0002SK-J5; Wed, 19 Nov 2025 19:42:24 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B2AF6018C;
 Thu, 20 Nov 2025 00:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFD9C16AAE;
 Thu, 20 Nov 2025 00:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763599340;
 bh=tJ5dZ6rB4D0yQnxyuqiTuMlgY3k1as9eWH7lsEHvC8U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XpWilP2GzrgaD8a5yYDIoTMS/qnfZ14IewN0+jlxPFugeej3p4spqznKLRp5tO8Ru
 bZaGBUzVSK9Xv3AKZAx4ni9/4hfIbqUOZZIFFC+/ELfHt9b8QTr5mPwNTLX2hw0N1e
 8ukIzFa2VazIHXt1bjunKwjV2OJriAbXWDO3G17cTVCh3puk+iCYG/ZnR30c913v0I
 I5FWBZg1wmtqbELu0ATVnHc4f5ZQ6QjqtiujhzKkNyA5eWL6mWNCIFUOvNNJDGV60s
 3sthqyssxOaYkSyeCBziXYQdCFFtnXAKo1vya9PsDa0fr5b5Ee5KPavm4Cn3bvXiJ5
 4a0bpkWEXdGaQ==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 19 Nov 2025 16:42:21 -0800
Subject: [PATCH 5/7] hw/riscv: Kconfig: add CBQRI options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-riscv-ssqosid-cbqri-v1-5-3392fc760e48@kernel.org>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Nov 2025 20:03:17 -0500
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

From: Nicolas Pitre <npitre@baylibre.com>

Add boolean property for CBQRI and imply it should be enabled for the
RISC-V virt machine.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/riscv/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd981e..663cb78b813c 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,3 +1,6 @@
+config RISCV_CBQRI
+    bool
+
 config RISCV_IOMMU
     bool
 
@@ -68,6 +71,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    imply RISCV_CBQRI
 
 config SHAKTI_C
     bool

-- 
2.43.0


