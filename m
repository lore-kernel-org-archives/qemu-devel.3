Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936C2C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 14:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4DO-0003wp-3z; Wed, 15 Jan 2025 09:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tY4DL-0003vp-87
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:17:48 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tY4DJ-00043w-Bh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:17:46 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so8542321a91.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 06:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736950663; x=1737555463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hGKhrWasU+AV7YHxN8tVRXvw4hZD+9qEd3l1jgWJACs=;
 b=RdrARRDDRpo/cE3DUMULVtFYrvLsQ+k370ueAnA8sObgfmk6pRsPxra869Nj9zLXcR
 fkFNgZSQTMqSwgd0Elow11SDScjhA+HYW/dRM+Qi2DqN1ZFPmfswNuAXt5wcCXIiVMvM
 De2hfH6eBPb4fTTr7Ac+qQRLyg0QduXek/DKjeaZxDTpje3w5YHf2nDSFYe6OQk4R9zQ
 Zv+YolbEszHDUqmtpDvkp/Yo6UjMAQbWLavqnv1Zovct4Z5tlIGlYD6vucUYsYxM3h+s
 oNEVBrI0IBi8oVMXI1mn2r4h7IrStfrrybj2FUsuWoMtIrdYIJxgvv+OXJ5P3xW4YT/V
 cvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736950663; x=1737555463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hGKhrWasU+AV7YHxN8tVRXvw4hZD+9qEd3l1jgWJACs=;
 b=Ir0NEWbPE6+Xkc9uuM5nnHwqAxhFDtg/EGdzhNuoCda/q8tywab42tq9rlpklx+bYc
 rmKeSiQDuZviBQzEauQngn4qJ8g4LSxFPjxOC8dF4ZycOOpoziP+Ae5ob15WYXe/Ozak
 8Gico0ReuVtvGtxlX/RmIZ9sMXH55si09mz8pWvCYsjfxzk1LDO9LdVbWXjcXJ02XG8n
 zqrhCx0190U8x0k9Tj12bnikIGhSqkC7E15DIHAYUj7d+TP07Y4ehELHVmUnJ+t9m+XA
 miiTa0b4AcjE4tsEJu1K50Fgp8hWe8B/axF/E27LRCThv9Wnh7rHNdkb3jFSMB/Y23Uc
 +Geg==
X-Gm-Message-State: AOJu0YwENQJdDKo+pCPZ49bVpxUGBRHGZTsM9HHjwHqe5MP3BwDE5jUK
 8edq+oBAOo5C/KcnINssI8OOZQdMVOuIJQxq8e1NWKRubRK1RbtYNnvk6Tm8Nr90dv5qA3sOfX/
 Iy/q39FymfFvJ7EoC24+jsaEW30YbIYf1L2RHzstcwK6oSJ65KZO2yBNIhaOx2tsJaqObh9kbzk
 6n4q/Z4mWuc5Zw7wK2vg4oBSAXmkmYqG1JQtwK8EM=
X-Gm-Gg: ASbGncuiJ4mBK+A54j8qw6zImjeRuP520xftuhA2GMCgPvuVnDZM+13S0BTqe5ZsZMn
 g95e6FeBz3DZfmg++PMMhTQggxYQpVreONig0w5qpileKGwAoicGYwSHjm6Isal1T/I7whoqnp1
 x1BP/rICWvqSLDdeEcyz0XbQ3wpFmepkrVbgdBKAR4sBcHT5a0nHXxfyN4wtvi1qwk4E2yy7aRs
 z/5RMB50QnFM12L70BonBdv5i8yo5KIbRKqFcGQjc1bI2hgK0TxqMY5zy8pjzhTD6lfNyWZ//j8
 7aPTBRjQ
X-Google-Smtp-Source: AGHT+IHC0TaKPKwHRkMVLPM8XqOe4416utXrCwUeh0aZ+sdMHuRGT11QxGOIiQHFF5f9w3gx8ksK0w==
X-Received: by 2002:a17:90b:2b8b:b0:2ee:d824:b594 with SMTP id
 98e67ed59e1d1-2f548f761d7mr37381677a91.31.1736950662494; 
 Wed, 15 Jan 2025 06:17:42 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c1cba9csm1432858a91.24.2025.01.15.06.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:17:41 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jason Chien <jason.chien@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 1/2] hw/riscv/riscv-iommu: Remove redundant struct members
Date: Wed, 15 Jan 2025 22:17:29 +0800
Message-ID: <20250115141730.30858-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=jason.chien@sifive.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Initially, the IOMMU would create a thread, but this thread was removed in
the merged version. The struct members for thread control should have been
removed as well, but they were not removed in commit 0c54acb8243
("hw/riscv: add RISC-V IOMMU base emulation").

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 hw/riscv/riscv-iommu.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 9424989df4..fa8a50fa24 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -58,11 +58,6 @@ struct RISCVIOMMUState {
     /* interrupt notifier */
     void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
 
-    /* IOMMU State Machine */
-    QemuThread core_proc; /* Background processing thread */
-    QemuCond core_cond;   /* Background processing wake up signal */
-    unsigned core_exec;   /* Processing thread execution actions */
-
     /* IOMMU target address space */
     AddressSpace *target_as;
     MemoryRegion *target_mr;
-- 
2.43.2


