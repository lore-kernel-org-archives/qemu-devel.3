Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73731C27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 15:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJxDz-0005iF-W7; Wed, 19 Jun 2024 11:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sJxDy-0005hG-4S
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:27:50 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sJxDv-0005vr-V9
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:27:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f44b441b08so50047935ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718810867; x=1719415667;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87kQqrwaKGU5/TzwrjZD+hI4GRX3oCm189uPL8uLQeQ=;
 b=2T6yBpVzqAS74phJkba49L1pcLauz7ndqsDOBZiBM3DKjMOFM4Hab5CdISVKd8hrZU
 TQz4qrjNF7P5ksFJJKD9WhwwL9OXwOhuI6yZl6HOezcKYW3L8XIg6QzUbj/x2boO5TpI
 s5Am+jK97Urg0xa3TgR8PGqC3VVSgDi/E4y/h29r02CGbRLwviceEBKfyhzDIgSgypQj
 md2/0olh5fT0CZhUEDKishU3e8AUPpn0nFM4H41/yUEEBAmyhJz1fCKfb1u//Pa6Xzy5
 myftfWo4DM40xamOrcrLP/YbNyOddtAaVGI45mqXOUkXkpTevWB+xJQnh/ldBhl/4o9N
 M/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718810867; x=1719415667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87kQqrwaKGU5/TzwrjZD+hI4GRX3oCm189uPL8uLQeQ=;
 b=Xbu7elpFU98oB1pG0QDy2c9tNb2fbz95Bg+ObMotZv5eAWkVeWG/h03o+O1aiQk8I1
 mF2nSpX2FwKmYNX2UGhCI6MWE8/PqdfeMod9lHJVGVHa1NJvwNaP1SjkGRprazdA3bIj
 Loe97eicDdSkCdzw6AjkRDmuyL9rukUfUFlqoESd1cO2ofdgSau4rgXPKWOzNxhx8vMI
 Sq8BDhUcwOnIKf2HL1gAId3zrc3KMuS+Dl5h8p0TJ3xN3Xv7hvPCi7PEPtZ5vuqBC7DM
 C952yvpmYNiKxOesKAoV9SbzFPlSwH7GDAmjw08CiPOGod2gqduahlkmWm4aMemLjNSn
 O01w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/GpXJkigRJ+xW2qBfHBtaeKj+MXix82lgGuf3arJMiMq9sG5ycn0+vEIia482tRD2ScUKkwW1CBgOLmQTWgVedI4XBoQ=
X-Gm-Message-State: AOJu0YzCJ1YDPZydnDQroYyJMpwlro1V6g5ig6Qc9uu3ETf9FvBRXtsG
 eW33UClB7K+WIQQ7ZEQGEzHiAYitOUIPL2OruGRq5R8yRbqZNT5B85aeK9UiZNU=
X-Google-Smtp-Source: AGHT+IH8FwI9X23gzgts6KmePiWIGqAbaZRP76xbrbYXfI10WpxHQoGdPpn83Cs8qb87/+TaO5sVEw==
X-Received: by 2002:a17:903:41c6:b0:1f8:44f8:a384 with SMTP id
 d9443c01a7336-1f9aa42f5c2mr26763365ad.30.1718810866686; 
 Wed, 19 Jun 2024 08:27:46 -0700 (PDT)
Received: from localhost.localdomain ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9afada50dsm15956865ad.166.2024.06.19.08.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:27:46 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org,
 jason.chien@sifive.com
Subject: [PATCH v2 6/6] target/riscv: Add support to access ctrsource,
 ctrtarget, ctrdata regs.
Date: Wed, 19 Jun 2024 16:27:08 +0100
Message-Id: <20240619152708.135991-7-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619152708.135991-1-rkanwal@rivosinc.com>
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=rkanwal@rivosinc.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

CTR entries are accessed using ctrsource, ctrtarget and ctrdata
registers using smcsrind/sscsrind extension. This commits extends
the csrind extension to support CTR registers.

ctrsource is accessible through xireg CSR, ctrtarget is accessible
through xireg1 and ctrdata is accessible through xireg2 CSR.

CTR supports maximum depth of 256 entries which are accessed using
xiselect range 0x200 to 0x2ff.

This commits also adds properties to enable CTR extension. CTR can be
enabled using smctr=true and ssctr=true now.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.c         |   4 +
 target/riscv/csr.c         | 148 ++++++++++++++++++++++++++++++++++++-
 target/riscv/tcg/tcg-cpu.c |   6 ++
 3 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 30bdfc22ae..a77b1d5caf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -193,6 +193,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
+    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
+    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
@@ -1473,6 +1475,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
     MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
+    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
+    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0b5bf4d050..3ed9f95a4f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2278,6 +2278,13 @@ static bool xiselect_cd_range(target_ulong isel)
     return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
 }
 
+static bool xiselect_ctr_range(int csrno, target_ulong isel)
+{
+    /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */
+    return CTR_ENTRIES_FIRST <= isel && isel <= CTR_ENTRIES_LAST &&
+           csrno < CSR_MIREG;
+}
+
 static int rmw_iprio(target_ulong xlen,
                      target_ulong iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
@@ -2323,6 +2330,124 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
+static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val,
+                          target_ulong new_val, target_ulong wr_mask)
+{
+    /*
+     * CTR arrays are treated as circular buffers and TOS always points to next
+     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
+     * 0 is always the latest one, traversal is a bit different here. See the
+     * below example.
+     *
+     * Depth = 16.
+     *
+     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
+     * TOS                                 H
+     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
+     */
+    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
+    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
+    uint64_t idx;
+
+    /* Entry greater than depth-1 is read-only zero */
+    if (entry >= depth) {
+        if (val) {
+            *val = 0;
+        }
+        return 0;
+    }
+
+    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
+    idx = (idx - entry - 1) & (depth - 1);
+
+    if (val) {
+        *val = env->ctr_src[idx];
+    }
+
+    env->ctr_src[idx] = (env->ctr_src[idx] & ~wr_mask) | (new_val & wr_mask);
+
+    return 0;
+}
+
+static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val,
+                          target_ulong new_val, target_ulong wr_mask)
+{
+    /*
+     * CTR arrays are treated as circular buffers and TOS always points to next
+     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
+     * 0 is always the latest one, traversal is a bit different here. See the
+     * below example.
+     *
+     * Depth = 16.
+     *
+     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
+     * head                                H
+     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
+     */
+    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
+    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
+    uint64_t idx;
+
+    /* Entry greater than depth-1 is read-only zero */
+    if (entry >= depth) {
+        if (val) {
+            *val = 0;
+        }
+        return 0;
+    }
+
+    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
+    idx = (idx - entry - 1) & (depth - 1);
+
+    if (val) {
+        *val = env->ctr_dst[idx];
+    }
+
+    env->ctr_dst[idx] = (env->ctr_dst[idx] & ~wr_mask) | (new_val & wr_mask);
+
+    return 0;
+}
+
+static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask)
+{
+    /*
+     * CTR arrays are treated as circular buffers and TOS always points to next
+     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
+     * 0 is always the latest one, traversal is a bit different here. See the
+     * below example.
+     *
+     * Depth = 16.
+     *
+     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
+     * head                                H
+     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
+     */
+    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
+    const uint64_t mask = wr_mask & CTRDATA_MASK;
+    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
+    uint64_t idx;
+
+    /* Entry greater than depth-1 is read-only zero */
+    if (entry >= depth) {
+        if (val) {
+            *val = 0;
+        }
+        return 0;
+    }
+
+    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
+    idx = (idx - entry - 1) & (depth - 1);
+
+    if (val) {
+        *val = env->ctr_data[idx];
+    }
+
+    env->ctr_data[idx] = (env->ctr_data[idx] & ~mask) | (new_val & mask);
+
+    return 0;
+}
+
 static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
                          target_ulong isel, target_ulong *val,
                          target_ulong new_val, target_ulong wr_mask)
@@ -2473,6 +2598,25 @@ done:
     return ret;
 }
 
+static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
+                        target_ulong isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask)
+{
+    if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr) {
+        return -EINVAL;
+    }
+
+    if (csrno == CSR_SIREG || csrno == CSR_VSIREG) {
+        return rmw_ctrsource(env, isel, val, new_val, wr_mask);
+    } else if (csrno == CSR_SIREG2 || csrno == CSR_VSIREG2) {
+        return rmw_ctrtarget(env, isel, val, new_val, wr_mask);
+    } else if (csrno == CSR_SIREG3 || csrno == CSR_VSIREG3) {
+        return rmw_ctrdata(env, isel, val, new_val, wr_mask);
+    }
+
+    return 0;
+}
+
 /*
  * rmw_xireg_sxcsrind: Perform indirect access to xireg and xireg2-xireg6
  *
@@ -2484,11 +2628,13 @@ static int rmw_xireg_sxcsrind(CPURISCVState *env, int csrno,
                               target_ulong isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
-    int ret = -EINVAL;
     bool virt = csrno == CSR_VSIREG ? true : false;
+    int ret = -EINVAL;
 
     if (xiselect_cd_range(isel)) {
         ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
+    } else if (xiselect_ctr_range(csrno, isel)) {
+        ret = rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask);
     } else {
         /*
          * As per the specification, access to unimplented region is undefined
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 683f604d9f..df75bb190b 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -726,6 +726,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->pmu_avail_ctrs = 0;
     }
 
+    if ((cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr) &&
+        (!riscv_has_ext(env, RVS) || !cpu->cfg.ext_sscsrind)) {
+        error_setg(errp, "Smctr and Ssctr require S-mode and Sscsrind");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.34.1


