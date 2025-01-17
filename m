Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0091FC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfOI-0003KM-TD; Fri, 17 Jan 2025 00:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMj-0007oM-Pu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:02 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMg-00067M-TK
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:57 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2166651f752so39901925ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093473; x=1737698273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ewxmmoBs65ycXwDjd7P7EmPHKkjsnm9AN9i3jAUcJw=;
 b=TZb9kMO6x7lwzw+o5WFTxFCT+EqFgt1dNyd9ndFrKhdxNH3BPWf2RMVVNeB1ez9jeo
 pWjlH2cBlyHCUZJg4GbDlZc2NgQjpzy29mJ9IaDYgpADaJMEm3HziFiFw1vx+9v/1Wcn
 u5SrIrFoHZahHIlkpBCI5kjBKk8QkD952D04pvebKy5C29l0MrvjpSNBQaCpgCH3Ofnb
 a7raR9C2l4jPKssORUPNg3i6Ef6QJAp+j0C3KS0WT++/LL8Xwf09Br4SYbQwWMyw5c12
 9rPwfH8YHm/x0JJaxPcExN7A6adbOSYiGLyT0pzA6PxatspubKJdx4xMth7HlqgeDMwk
 L9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093473; x=1737698273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ewxmmoBs65ycXwDjd7P7EmPHKkjsnm9AN9i3jAUcJw=;
 b=DQm1MJ/TrhjcSPX1y/FFoRVP8G8uDcbRAuSmYc/MFzQuXn8L+KhcUlZIyFFb8SYZ0s
 8evQCYJb/h8FwuqgDdpDDEeOUztaelQ2dM/ke0KhZi1SH4hqYVfMizrshbgabTj8e7OB
 ANC79jX25KzGFRcqkU5lJMTK7bQQ2G9kf8R0SXRbwGxngQZzxso8wexqXOf1c9hknGSb
 YpwFq64svWepyWbYxubkphgovO/uuMn+/KlgopaO/MrsZJkJxHGv7dMfSx0Y+TiVL2tq
 iso/tMrGTism1M8KNMcgNEnkEAiL2oi53kKb5lFrOqvTrjDtj/SSti7Gdif5xiJuCbgB
 PG6A==
X-Gm-Message-State: AOJu0YxYoXFosSP42BklWazWcymNS2nyb1XsyLGBXLK54T+fYB1e4gYU
 jHGKxC3C0I8/lEfTOTY5Uv1IF1seeQGG4aSuTFnVa03Yt+pFmCgNtPjVtQ==
X-Gm-Gg: ASbGncv5wttBsvSg/8LLHkMO2t/2aAtqU8p9wLtBzVV0hHweq5K0erI26p0vYBSSqSI
 Vlk4Jy2byRlilbHT1+rgYygFzs7ssuRepp5TMn5O6nGzvzuIqZdvbn4M0sDCPxZ9jQ/PJZhNvO7
 UnpOYpkSZs8qicLlYdz6giFE8m1T66iQj5okwPqX4d0wcyXuGEfjG3FigZ3C9RZnoaP24pK1qEE
 3tVlnzioC5S8u+/sJibkwdu7cbtoYN4s1OUIaySMcgntyEHikJpQKcJd66URjKyPI5sVm8deC0O
 x+vIVh23/uOPekDWcp5Ozy6VkP+WmcEpY0jLwY7EZy0XDD8mjeUHWcCPwTa5
X-Google-Smtp-Source: AGHT+IE48t3Aw9o2Fs6cFXG03dixFym4L+yRMOkvO1E7c+NG5fpafBCgUGFrdNPrvkA8mkeKsLaqaA==
X-Received: by 2002:a17:902:f544:b0:215:e98c:c5bc with SMTP id
 d9443c01a7336-21c3563a33cmr21572305ad.48.1737093473378; 
 Thu, 16 Jan 2025 21:57:53 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:52 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL 33/50] target/riscv: Add counter delegation definitions
Date: Fri, 17 Jan 2025 15:55:35 +1000
Message-ID: <20250117055552.108376-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds definitions for counter delegation, including the new
scountinhibit register and the mstateen.CD bit.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-6-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h      | 1 +
 target/riscv/cpu_bits.h | 8 +++++++-
 target/riscv/machine.c  | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 08215efb09..a936300103 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -392,6 +392,7 @@ struct CPUArchState {
     uint32_t scounteren;
     uint32_t mcounteren;
 
+    uint32_t scountinhibit;
     uint32_t mcountinhibit;
 
     /* PMU cycle & instret privilege mode filtering */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 6b1446fb7e..73f7d37d80 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -210,6 +210,9 @@
 #define CSR_SSTATEEN2       0x10E
 #define CSR_SSTATEEN3       0x10F
 
+/* Supervisor Counter Delegation */
+#define CSR_SCOUNTINHIBIT   0x120
+
 /* Supervisor Trap Handling */
 #define CSR_SSCRATCH        0x140
 #define CSR_SEPC            0x141
@@ -779,6 +782,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
 #define MENVCFG_PMM                        (3ULL << 32)
+#define MENVCFG_CDE                        (1ULL << 60)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -826,7 +830,9 @@ typedef enum RISCVException {
 #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
 #define ISELECT_MASK_AIA                   0x1ff
 
-/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
+/* [M|S|VS]SELCT value for Indirect CSR Access Extension */
+#define ISELECT_CD_FIRST                   0x40
+#define ISELECT_CD_LAST                    0x5f
 #define ISELECT_MASK_SXCSRIND              0xfff
 
 /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index d81621010d..d8445244ab 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -423,6 +423,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
+        VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
         VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),
-- 
2.47.1


