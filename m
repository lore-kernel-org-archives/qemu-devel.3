Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62733FEA806
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5GOn-0006x2-Ct; Wed, 25 Mar 2026 01:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1w5GOi-0006wD-Cy
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:03:17 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1w5GOh-0007Zt-1B
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:03:16 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35c06831dd3so1168876a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 22:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1774414993; x=1775019793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nW7hx28RyC9DLmAomfhq9Pb0z5+5GVSIqfCp2VrXip4=;
 b=JGTouy5TV/VGWMIWZunJZF/kX93z9r3rLo/N9X1D09Iavvar4jaSRHU4N1Mbi9OnP/
 7EVclXIbIWeF5B9qq26E/NqyA688GD8byBK/kni0vvUXOZtZ+i97NLaO3zZW115j1vsF
 XyU4nqqa3hhNBk1TtbvddQiTk3/PMI9nqUGnym5fzBEubDnTy/nWgWvN1O2X37mbrNFZ
 PXoA4hFwcR/xAyioZEt8S4p0k9AHvLocfIYZQAzrJKnpaoj45qsy1YnESjGGLVBCwigl
 CWTz19e6vMNrj2Fzw41GHHpF78PK6i86oBAkc2tbos9PGEnUp17PcUgKgOzUMO5rABOO
 KROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774414993; x=1775019793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nW7hx28RyC9DLmAomfhq9Pb0z5+5GVSIqfCp2VrXip4=;
 b=NB3LXdCvFQp68dQ/OLmSzAuufEkdFjIo5X6rP8u5lFlvrvqrtrLpvenz6premAy38g
 PdtH4/f+DJ3tGOQVdnkNPFHOcUy3uLSym+1TB7/FItP4IKmOOp/Qt6lFCJs07VAD5/Vh
 XyRW7AzNcADYr1jrlmc0z8in9PWS8MS9MDe+QtKkEXD+jJPu7zWBUDiZdTLdhhC8D57p
 4plT1FMOTm4MpyarpuiZ3cMrdwCXnuvhmXEDSUbVxKyAXPP+UkxkdgsBy38537XDaAGy
 KbTAo0eZKjYDnFw4CQ0gXbFaQG1LP/d+FPN2uPgcEf7PyVPK812zfwbgya3O3Xx/ioZl
 5Kuw==
X-Gm-Message-State: AOJu0YxQ7cTD8xvrd/qtfJb2yuX2qMBnIYmtgX+emYKl7lcF+YMWL5TH
 zi2j2r9fkvBKVxb3F+KdYV+EEJuNzTREuydOcEa1NcnCoa9FTF6/S2L9O95+2PyAJfcvwlca8mt
 0RYwlwgbc0WX8u+cJNkdb2Tdejl909OszlWf9tmkGnEUwcP1tllfBmnKy9b092Ze9jSv2xAE/O9
 0AANmzsLuMq3B9vNbqTZ4hh3KwUPGXqMEofn9Jb/tZyxU=
X-Gm-Gg: ATEYQzwLU8GTJPDaK1Gcy48O04czS82CfZBT+gbyHnkqwPi401Ia+v2ji8gafuuutc2
 YHphvsmr0PIL3v96qhiy7ecst46hLGf2ghc8gEytnQJumdtYJVdJnfrgb803WaND2NTk9ay/+y1
 tAYMlCUBtlPtGAfauFPU4fjsm0686A3tZvx7LppK5F7TO/LA85ju6p2uy7wAlxI4XFmnvaWd5gU
 5t/Em+PklEsBKb4R9rrEi5ND3g0P50tjKXePtXeprD8PkRS6dXa/wSyBAjK0Je1svGqIsQJiklj
 J2i7+YqJkrlQLPRGTvgaZvN/MCtjTKhS9VEo16Oiw1Gxgz62EhcsUvdqdGaFm7SK6cwJzPn5cLh
 amyYpZWkN2MTawIZdg+b5MB9ZgSIdGp5S9eOR7IZ2wWGDQc0TsePzT3VDe0jKCu5b8apjLAFvrb
 ZP28YKU/Ht2ezViPoNRNfBqjyBggRqRk9rvSeIY7QLmyVSYyKaamqEF3R/ByyTFg==
X-Received: by 2002:a17:90b:3890:b0:359:8c89:96d3 with SMTP id
 98e67ed59e1d1-35c0dcea990mr2113142a91.15.1774414993192; 
 Tue, 24 Mar 2026 22:03:13 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c03149db2sm4218866a91.9.2026.03.24.22.03.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Mar 2026 22:03:12 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v2 2/2] hw/riscv/riscv-iommu: Add IPSR.PMIP RW1C support
Date: Wed, 25 Mar 2026 13:00:11 +0800
Message-ID: <20260325050011.66722-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260325050011.66722-1-jay.chang@sifive.com>
References: <20260325050011.66722-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1033.google.com
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

Add proper RW1C (Read/Write 1 to Clear) support for the IPSR.PMIP
(Performance Monitor Interrupt Pending) bit, which was missing from
the IPSR register implementation.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/riscv-iommu-bits.h | 1 +
 hw/riscv/riscv-iommu.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 47fe01bee5..a938fd3eb4 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -189,6 +189,7 @@ enum riscv_iommu_ddtp_modes {
 #define RISCV_IOMMU_REG_IPSR            0x0054
 #define RISCV_IOMMU_IPSR_CIP            BIT(0)
 #define RISCV_IOMMU_IPSR_FIP            BIT(1)
+#define RISCV_IOMMU_IPSR_PMIP           BIT(2)
 #define RISCV_IOMMU_IPSR_PIP            BIT(3)
 
 enum {
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 225394ea83..f8b5187328 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2153,6 +2153,10 @@ static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
         ipsr_clr |= RISCV_IOMMU_IPSR_FIP;
     }
 
+    if (!(data & RISCV_IOMMU_IPSR_PMIP)) {
+        ipsr_clr |= RISCV_IOMMU_IPSR_PMIP;
+    }
+
     if (data & RISCV_IOMMU_IPSR_PIP) {
         pqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
 
-- 
2.48.1


