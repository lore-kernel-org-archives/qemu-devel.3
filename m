Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CACBD5E145
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 08:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KhX-0004lN-2U; Fri, 08 Nov 2024 03:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1t9KhK-0004it-KB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:50:30 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1t9KhH-0000zS-PY
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:50:30 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ed9c16f687so1314995a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 00:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731055826; x=1731660626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjPXxhHgkURlI8UX1KuKe1nxTTSvfnRKKrN/i3Rc46w=;
 b=BGtmdXnVKArdFT1QPSXiy5fiWNgFvyAg37IvIjme7oI1EVfCqjpF99PZKQVahP5tnF
 PV0pxyZXMO2GSGisMhHjlGnCSS4Pym/AJZeOxzWO5rqGDWFzSGh5BGbEuz41XPNC6ZeP
 4Lzd6mxXhcrCdN53XnwCrQnA3EcO8ReVs8OAgtpDqXz2ICFAScbbPgSIKiYfT++XgoTO
 JKQ9RFivyeOlg/6FuPySttjQxU9wUQIhf1bnRkiIdr+hlmZxUKid4KbB3HGBxYg0bQb+
 Wyc/QNGkda0TW3hW6qoq9h2QL6sVehFEiR/im+PV9wMJ2tSLDx4EIvpVRlg43aw3KwO/
 DdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731055826; x=1731660626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CjPXxhHgkURlI8UX1KuKe1nxTTSvfnRKKrN/i3Rc46w=;
 b=Ny9XtB6K8e42p1+MRXQlnosV2QS2EYMVxoScepr5JUC7yTeH0631zQAUZOe3i9wxbI
 faRlOAwI6a1TkxeztIRW7iDNEb6R3unz0fhmibQfSwE2dhQ2QWByWR1xKP4f0q2wuZm/
 2BYngii0fe16fn0D/QFw3YK/TkzuqVXPKwdZeAZthuw7tAVStA1BXfPwRpSqk+uqvw2R
 vVVNIT4gylucFJbbdafXncGjUO4ocoPp2QjGBh7bJCfQHNAPdN+o6VIKf0EDA8RCB7xs
 pCyd5cNPie88JEBItddZJ4vNkuUpWoADAeeScTvJnInuFhzTm3x3gbLHSyAbshWQVJFA
 1dhg==
X-Gm-Message-State: AOJu0Yw2ffujkyOvWqrhlsHPLbNzCpgHeQitYLFydN3tmK0xEer7JoNt
 RP5MMTY5kxYuOQ35efQBKVrx2acZpz5PH55TAWpdyNyI7zRt/8TX6qsTp2ziDBLFvk1wdqwlbPE
 wq2mjrEy4zhS78NjkTMjU7949qVGOHddpD4zu5a2V0QT8dvK15xsBC6PsX9bQBFTNUTH0jgsoVp
 7eMUcY8gVYYCg2kw6NyMK+CzVQQ+XaEhvW7Cg=
X-Google-Smtp-Source: AGHT+IF98wvlR++RvwmJqJQ+2bT6A+fJGUqbJwK3jwwx76w4Eou4mdzxk8M70TwNzlfUrPA+YJJn/w==
X-Received: by 2002:a05:6a21:3418:b0:1d9:261c:5943 with SMTP id
 adf61e73a8af0-1dc2296b919mr2538588637.10.1731055825984; 
 Fri, 08 Nov 2024 00:50:25 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a541da0sm5540135a91.13.2024.11.08.00.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 00:50:25 -0800 (PST)
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
Subject: [PATCH v2 4/5] target/riscv: Check memory access to meet svuket rule
Date: Fri,  8 Nov 2024 16:52:38 +0800
Message-Id: <20241108085239.2927152-5-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108085239.2927152-1-fea.wang@sifive.com>
References: <20241108085239.2927152-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Follow the Svukte spec, do the memory access address checking

1. Include instruction fetches or explicit memory accesses
2. System run in effective privilege U or VU
3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
   instruction is HLV, HLVX, HSV and excute from U mode to VU mode
4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]
5. Raises a page-fault exception corresponding to the original access
   type.

Ref: https://github.com/riscv/riscv-isa-manual/pull/1564/files

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu_helper.c | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0a3ead69ea..725c049f7a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -857,6 +857,57 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
     return TRANSLATE_SUCCESS;
 }
 
+/*
+ * Return 'true' means no need to do svukte check, or need to do svukte and the
+ * address is valid. Return 'false' means need to do svukte check but address
+ * is invalid.
+ */
+static bool check_svukte_valid(CPURISCVState *env, vaddr addr,
+                               int mode, bool virt)
+{
+    /*
+     * Check hstatus.HUKTE if the effective mode is switched to VU-mode by
+     * executing HLV/HLVX/HSV in U-mode.
+     * For other cases, check senvcfg.UKTE.
+     */
+    bool ukte;
+    if (env->priv == PRV_U && !env->virt_enabled && virt) {
+        ukte = !!(env->hstatus & HSTATUS_HUKTE);
+    } else {
+        ukte = !!(env->senvcfg & SENVCFG_UKTE);
+    }
+
+    if (VM_1_10_SV39 != get_field(env->satp, SATP64_MODE))  {
+        /* Svukte extension depends on Sv39. */
+        return true;
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
+        return true;
+    }
+
+    if (!ukte) {
+        return true;
+    }
+
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
@@ -894,6 +945,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     MemTxResult res;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int mode = mmuidx_priv(mmu_idx);
+    bool virt = mmuidx_2stage(mmu_idx);
     bool use_background = false;
     hwaddr ppn;
     int napot_bits = 0;
@@ -901,6 +953,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
     bool sstack_page = false;
 
+    if (env_archcpu(env)->cfg.ext_svukte && first_stage &&
+        !check_svukte_valid(env, addr, mode, virt)) {
+        return TRANSLATE_FAIL;
+    }
+
     /*
      * Check if we should use the background registers for the two
      * stage translation. We don't need to check if we actually need
-- 
2.34.1


