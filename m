Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC44D41D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 09:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAmwp-0007gE-Jg; Tue, 12 Nov 2024 04:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmwa-0007XX-RH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:12:19 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmwY-0007lV-E1
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:12:16 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7f3da2c2cb5so3785550a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 01:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731402733; x=1732007533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Or39Asyq2WcOevg1FvpeaHy7EaesyoBx5lPamPpthoM=;
 b=CNOjSwLUSB5LDdleNyaOfsusjmsph8VgEIrfYtbcM6Xx6g69fQ1LLPm5bQqGnwYTWy
 MYjfysNr3OLycQqXOXdLn/D/kA8jpUVAoq8bHh3DAnYyQ17GqjT2TM2i6CPfXoNleLa5
 il8njviSjN+tdG1+PLbpwryyBBbF7wfGL/hyTHJxDPRSVLWMczlkBeEC4BB8vzjygWn5
 WX/5AMmSzCjJ/KGx+wn6iXZvrMbVpADdMJMNRlGj3d77i+zLynK0R2FXKT18ve3O4v4Y
 IUu8sRDiMHVUtDlUEudT7z7UsFn40vn97IitHtfTZATQRGJkzbDfSKnzvNYcygEyQNZO
 FwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731402733; x=1732007533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Or39Asyq2WcOevg1FvpeaHy7EaesyoBx5lPamPpthoM=;
 b=Ok/mP9g80VTIj645M/trT71TEvNemcPv4c8F4tEQnYAaxt+LqagKv/CzqyULXW9kh4
 AKUWmFOep2KkgIhURn31E2wzIxV7pW44Hx5cs9IZY9QFbDG1usKuRuiPlCnlw//Ef5W1
 WBwtmbQo6nZPFpA/S3vkEfpGApDanzKc+a7jCHuW06ExItqBUHWlJQ7WR1dLk/Xm4YJj
 f5SVq0nbFOOrP40+theowNG5FS6yP7yPWdIsHQ5K5cvqhLqoT6G883SUZYRQbYluR6GT
 RAfjJQjHFdUxhvsmpy14HL9QUVqQOgyTQ9NMD20Y6gTfKmk+NLoT5/bbm00PNcbvf+op
 HDxQ==
X-Gm-Message-State: AOJu0YxskkIehV73aZlyaDqOO36AQ+sz0pM5Yxmggm5i/JawxFEfc7CJ
 lLr+N8r2ScSqjCgg4KNncxBfdgt6M030PYlM0zDmVPL3FI34z8Tvcwfju/ZbsyBaRHlPED0pA1v
 bhWH6+qiihl5qbjf4BLef9yohcDB1aRJGUqxCfPo0/czS+V/1gbAyFO5TdfEZIlKGrwxXcVm4si
 ueIxDMVKBWg3egeRh3uy8HqnGyMyeaM745968=
X-Google-Smtp-Source: AGHT+IGhp/SBPIH6KNAvbjUW72Fx7Irq+8fYAD7u9t9cbEn+/GAom3C0zk+Ta/aXIRkIQvUeLdXeLQ==
X-Received: by 2002:a17:90b:3811:b0:2e2:bf7f:3369 with SMTP id
 98e67ed59e1d1-2e9b16eb57bmr21010199a91.5.1731402732509; 
 Tue, 12 Nov 2024 01:12:12 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a4f6c96sm13495347a91.2.2024.11.12.01.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 01:12:11 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 4/5] target/riscv: Check memory access to meet svukte rule
Date: Tue, 12 Nov 2024 17:14:22 +0800
Message-Id: <20241112091423.2529583-5-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112091423.2529583-1-fea.wang@sifive.com>
References: <20241112091423.2529583-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x52f.google.com
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

Follow the Svukte spec, do the memory access address checking

1. Include instruction fetches or explicit memory accesses
2. System run in effective privilege U or VU
3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
instruction is HLV, HLVX, HSV and execute from U mode to VU mode
4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]
5. Raises a page-fault exception corresponding to the original access
type.

Ref: https://github.com/riscv/riscv-isa-manual/pull/1564/files

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu_helper.c | 61 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0a3ead69ea..5b29344c4f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -857,6 +857,61 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
     return TRANSLATE_SUCCESS;
 }
 
+/* Returns 'true' if a svukte address check is needed */
+static bool do_svukte_check(CPURISCVState *env, bool first_stage,
+                             int mode, bool virt)
+{
+    bool ukte;
+
+    /* Svukte extension depends on Sv39. */
+    if (!(env_archcpu(env)->cfg.ext_svukte ||
+        !first_stage ||
+        VM_1_10_SV39 != get_field(env->satp, SATP64_MODE))) {
+        return false;
+    }
+
+    /*
+     * Check hstatus.HUKTE if the effective mode is switched to VU-mode by
+     * executing HLV/HLVX/HSV in U-mode.
+     * For other cases, check senvcfg.UKTE.
+     */
+    if (env->priv == PRV_U && !env->virt_enabled && virt) {
+        ukte = !!(env->hstatus & HSTATUS_HUKTE);
+    } else {
+        ukte = !!(env->senvcfg & SENVCFG_UKTE);
+    }
+
+    if (!ukte) {
+        return false;
+    }
+
+    /*
+     * Svukte extension is qualified only in U or VU-mode.
+     *
+     * Effective mode can be switched to U or VU-mode by:
+     *   - M-mode + mstatus.MPRV=1 + mstatus.MPP=U-mode.
+     *   - Execute HLV/HLVX/HSV from HS-mode + hstatus.SPVP=0.
+     *   - U-mode.
+     *   - VU-mode.
+     *   - Execute HLV/HLVX/HSV from U-mode + hstatus.HU=1.
+     */
+    if (mode != PRV_U) {
+        return false;
+    }
+
+    return true;
+}
+
+static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
+{
+    uint32_t sxl = riscv_cpu_sxl(env);
+    sxl = (sxl == 0) ? MXL_RV32 : sxl;
+    uint32_t sxlen = 32 * sxl;
+    uint64_t high_bit = addr & (1UL << (sxlen - 1));
+
+    return !high_bit;
+}
+
 /*
  * get_physical_address - get the physical address for this virtual address
  *
@@ -894,6 +949,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     MemTxResult res;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int mode = mmuidx_priv(mmu_idx);
+    bool virt = mmuidx_2stage(mmu_idx);
     bool use_background = false;
     hwaddr ppn;
     int napot_bits = 0;
@@ -901,6 +957,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
     bool sstack_page = false;
 
+    if (do_svukte_check(env, first_stage, mode, virt) &&
+        !check_svukte_addr(env, addr)) {
+        return TRANSLATE_FAIL;
+    }
+
     /*
      * Check if we should use the background registers for the two
      * stage translation. We don't need to check if we actually need
-- 
2.34.1


