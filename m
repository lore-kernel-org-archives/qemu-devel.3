Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6998CD342D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 06:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slMoJ-0005Np-Hi; Tue, 03 Sep 2024 02:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMoH-0005Fy-JW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:37 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMoF-0002Fd-PJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:37 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7c6aee8e8daso3486618a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 23:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725344074; x=1725948874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=folyLjZC+gAsCGvjBm1lXgO8dCUSFEawIl5b8lF+iF0=;
 b=L+cAzWebSa6ky2pLasS1h8A2ykF0ftPqYZxqJC1wSKiw3V2L3h12sFV6FCh1HHphSS
 ub4lE/gqYua/wl3P7dfC47QuDE3THXPZrdpi86Ror58bwvJ48lz9OIB0DhXqfl8E/aC0
 4S8qFd0vutxesAQT9V+fkZyABHdBFQrUBMLDMCyUs9d+krkKWRnEpQzqJk6cscH9PIid
 20CY4y2ON2VfOgGGw3Jao65ekD18mHcRgWu+n3kz4ndbmDo15ANLOzhQU6LZ5BKLui6R
 dwBt0yldcOKrmKmGPzg4lsc/3fyWKKAHszdFv1UZZZG9X+1RenB4RytmkkPPTvlprvKj
 YCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725344074; x=1725948874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=folyLjZC+gAsCGvjBm1lXgO8dCUSFEawIl5b8lF+iF0=;
 b=kENaVYlqZpbjiPQb8amiEfFG0ijeKvDeHXjcRBvwf04JKSeNceLiOxXhkKBAle0ZXY
 AM0MyVPWqoKFyBd4FlnuF+gRTyVo7qloiphdp1ol920CZDJ+VSgvBAoE3/BsLyKhHkaq
 vvHaDp5SVPtyyIA9kYy8aff5I6gQPm7HEFjcyC7ID7U+gG7kMKkezcjjW0hkFUpXrpbz
 oXDAJvlfUK/9Ek0jBrdvC9z3FdA4G959fr0ph5K9PM+Ywq1EPfKdAC088Pq8RTa+QYx5
 yfih6XERBRCVz6cV4YjwBALQG+4hRn83iGr0UaWMMs6IeWceNu7ZKuO09E0QZgfKSN1Y
 s/Hg==
X-Gm-Message-State: AOJu0YzkpvRA0Nue3rQBrMLD/b4uUkikC2w4GU8ECtpKmBwznUtul9qO
 RtWDAbv/MIRb1Sfs2TxdMe115N5KfV91CKdUeczacwRFaYxCF2FU+qpdz0nEuh0j6D5UJhPIwhN
 FCjHvQNEdUpDMoq9Z2IZc016v+kbbqYRFBeA9OtsVhLj/HfDBZzJomvARyBh7zumyncrq+otczt
 CmfgpmtOVqJ13mNygakL2weC3K56knOe6SETg=
X-Google-Smtp-Source: AGHT+IEyN2rUfbGr134wm+tqxlU2vIVN3oo6zzz+Zv6lMjPNdnPHz/LRLxMnKc9te3n3Yelt2JN9hQ==
X-Received: by 2002:a05:6a20:c88b:b0:1c4:ba7c:741c with SMTP id
 adf61e73a8af0-1cecdf0fb58mr11741360637.21.1725344073713; 
 Mon, 02 Sep 2024 23:14:33 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20524c16145sm60467145ad.98.2024.09.02.23.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 23:14:33 -0700 (PDT)
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
Subject: [PATCH 4/5] target/riscv: Check memory access to meet svuket rule
Date: Tue,  3 Sep 2024 14:17:56 +0800
Message-Id: <20240903061757.1114957-5-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903061757.1114957-1-fea.wang@sifive.com>
References: <20240903061757.1114957-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 target/riscv/cpu_helper.c | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 395a1d9140..db65ed14b9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -777,6 +777,54 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
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
+    /*
+     * Check hstatus.HUKTE if the effective mode is switched to VU-mode by
+     * executing HLV/HLVX/HSV in U-mode.
+     * For other cases, check senvcfg.UKTE.
+     */
+    bool ukte = (env->priv == PRV_U && !env->virt_enabled && virt) ?
+                                           !!(env->hstatus & HSTATUS_HUKTE) :
+                                           !!(env->senvcfg & SENVCFG_UKTE);
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
@@ -814,11 +862,18 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     MemTxResult res;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int mode = mmuidx_priv(mmu_idx);
+    bool virt = mmuidx_2stage(mmu_idx);
     bool use_background = false;
     hwaddr ppn;
     int napot_bits = 0;
     target_ulong napot_mask;
 
+    if (first_stage) {
+        if (!check_svukte_valid(env, addr, mode, virt)) {
+            return TRANSLATE_FAIL;
+        }
+    }
+
     /*
      * Check if we should use the background registers for the two
      * stage translation. We don't need to check if we actually need
-- 
2.34.1


