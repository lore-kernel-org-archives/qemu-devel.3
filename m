Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D557C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb89k-0003TD-Ps; Fri, 16 Feb 2024 19:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89h-0003QW-Gd
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:10 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89T-0007wc-30
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:09 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ce942efda5so1048428a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708128113; x=1708732913;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oxyEiqQDEFal+EA6ojT4NXNxxDrwI+eq54mzrdFIs8=;
 b=twkgfs19OUSXCwkXN0HzqkZOXD68K14Y8H9NAZtsr8ZRcz2c/C2+D6hqdLfGoFE16k
 j7kuLx6YlukoeJYAh9BtmhdSuJNOHLMm2eYCJJeT4aHOnLwBaegiWbR8OcrvJWlWvtL9
 TcsChVBMV7MTYqGM3wLPrUIJRXBKwET8dtNEZKRVEWje6Lj85Etv8Qrhm12Vgpiegg8A
 1nZZCnrpa46g4FWgIxjUD6Wdq9iEVS+0UTUtJPUmYbN7lhGDTaY1IuYOc7Q/T5h8gXHf
 EHRa02Cf/nShT4l59kEXAoXfyIcV9AGrxklRYclrwHRzm9v9rHqHmWm0GzSCfcSuxBED
 XvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708128113; x=1708732913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oxyEiqQDEFal+EA6ojT4NXNxxDrwI+eq54mzrdFIs8=;
 b=HOPZ9Ym1GVXpoPzgzTmYAoOTjO60OgL+iUIdHJBAwKC/gn0PYahtpY6Edo5ZedfgRX
 jGhA8/evSWFk8NihkHFK8IEEWTbTNYNa2F5rzYNGi7cMpcNjc0lgpv9sF9hWxERWR+Q+
 9mKIg4SXP3En++P0GMjTXox1iT8TOazjSRuTjzljMdRBBc6Jr3LYPG2YpQ4PtlzYGWC4
 vdqdpLsDiVtdgUBGBix2qSbKR9mTHdGIgYE/s3IojB/FlAY1x+isqfy7FKZAabBB+pIA
 Czwb/dh/tSWZOnlm8jhegVbwuqG8q6ouBhvx+eQB7tsdvMS8Ervkp2ll/eHbf2UTM6YK
 /C6Q==
X-Gm-Message-State: AOJu0YxELBNN4jHItijHy5p0ATVvmgoGttwfAx9NB0SbM5etHKYBEgrB
 K7eCgK/4wB8kdQl4ECpN0LKZnHzN9Y26c3L3X4DSIpxoz+16j4MRt0hlSXSiyliRkwgJqTZt3IE
 S
X-Google-Smtp-Source: AGHT+IFkoGYMRX0Fh7GdRCDrZsnJmE9IsfPpw90nt9RCPLqHbXHSaF4p193Ud4u4lAv41bH74tIxuw==
X-Received: by 2002:a17:90b:1b08:b0:299:3511:1554 with SMTP id
 nu8-20020a17090b1b0800b0029935111554mr2844270pjb.40.1708128113023; 
 Fri, 16 Feb 2024 16:01:53 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a635b0d000000b005d66caee3d0sm464015pgb.22.2024.02.16.16.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:01:52 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Subject: [PATCH RFC 6/8] target/riscv: Add counter delegation definitions
Date: Fri, 16 Feb 2024 16:01:32 -0800
Message-Id: <20240217000134.3634191-7-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217000134.3634191-1-atishp@rivosinc.com>
References: <20240217000134.3634191-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=atishp@rivosinc.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.h      | 1 +
 target/riscv/cpu_bits.h | 8 +++++++-
 target/riscv/machine.c  | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 85afde48fade..d7dcfdb0e5e0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -342,6 +342,7 @@ struct CPUArchState {
     target_ulong scounteren;
     target_ulong mcounteren;
 
+    target_ulong scountinhibit;
     target_ulong mcountinhibit;
 
     /* PMU cycle & instret privilege mode filtering */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3a66f83009b5..0bffec3476ab 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -213,6 +213,9 @@
 #define CSR_SSTATEEN2       0x10E
 #define CSR_SSTATEEN3       0x10F
 
+/* Supervisor Counter Delegation */
+#define CSR_SCOUNTINHIBIT   0x120
+
 /* Supervisor Trap Handling */
 #define CSR_SSCRATCH        0x140
 #define CSR_SEPC            0x141
@@ -779,6 +782,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_CDE                        (1ULL << 60)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -870,7 +874,9 @@ typedef enum RISCVException {
 #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
 #define ISELECT_MASK_AIA                   0x1ff
 
-/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
+/* [M|S|VS]SELCT value for Indirect CSR Access Extension */
+#define ISELECT_CD_FIRST                   0x40
+#define ISELECT_CD_LAST                    0x5f
 #define ISELECT_MASK_SXCSRIND              0xfff
 
 /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 72fe2374dc2a..d26742f99ed7 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -400,6 +400,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINTTL(env.scounteren, RISCVCPU),
         VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
+        VMSTATE_UINTTL(env.scountinhibit, RISCVCPU),
         VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),
-- 
2.34.1


