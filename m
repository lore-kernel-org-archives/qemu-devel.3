Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ACBD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi72L-0005Kk-T3; Tue, 20 Jan 2026 03:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi72J-0005Ga-Ra
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:24:27 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi72H-00033M-OA
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:24:27 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a75a4a140eso2812165ad.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768897464; x=1769502264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2VQiMNkQmKk0Gf4SL+MIOp2QrhXkeZ5QdOOake/81k=;
 b=aFMfRghU14ElVjcygft685th21WGxPeVtfvRICnvCWd0TdRZdP9PrgTnpjwvFRpTnJ
 MRBlMNxEyeLgvghvBQK9pFjMRqzyeeFp2PF2xgTv6Hu/6qVjfeIuTa7SO2Nrzius5Mg4
 8eWeNbwf8U8Osvya4GdchXhaNZffadIj7fETpz9N7UUJanEMLiGc3mNQ6V2sFQXKuLAI
 xJq1PTAI6F9xqR2Sl/FJnbqy/v+2Hf8V+1t93NTRdD0QT1qQMMH5IDUTPuRkXTfsKIxC
 vjukkuXy5hcuQeRXpIxvcCu4kS7luo4e8OkLm3iLiKHOB+ZY2WNvqnZ6lxeOGAOP4U2V
 Q1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768897464; x=1769502264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V2VQiMNkQmKk0Gf4SL+MIOp2QrhXkeZ5QdOOake/81k=;
 b=NVkZp24SPVyu/DDlnLh5NvW8ySljAEA/QpGh0VGWomZ3j/wnvYilg7MPM8PqXD6agp
 rUWBaR5e3jOBVPOt3u3Hfm2wQXtvz4Fvy/DkY9vid8hxRLPDlR4wcAAiRr+9kkGoklSH
 afzFYFnAS4q8LmUPfS7D8C+PkGXd//GVtx+PzoP00xLWtVd+ELBnYjB9P0Kr6QM13r+B
 Y7NzrGCrTyAI4+OCv1dYZnu7jCfo2mKa1FzZZEqASljKQItJEAJDJc6Mf9IfjwvNUD5s
 Z7QfMDz/YmRYh4KRyXYCuhW3mjdmwMGgANxzTRgvS/29ak64xkd7Zac37BhF4o6zae6O
 uxPw==
X-Gm-Message-State: AOJu0YycgAqdU3T3TjDUMiF6TUKOL1WJyN+wAHr12vX7+JkabjeTWD6I
 THsJL1DJ/zSqg5a3reCc6vvXIHJCAHpuoFzRjxnfiiYWuDx5/Yz2d5kj
X-Gm-Gg: AZuq6aL6GaryFsGeFhSbGstYXbtSwV7cMyXBqVlhJIqmToCVUWpSbizoUc+Itc4Z2SP
 ZFMV1i6aPjruxScvEXaSmChfwT9G4KgeHWkXZnWlRzaBxVbNvmFnmfyBX8vzFnRBkiMBk7RQRoH
 IvBOTazQh+ywdHtiHKS1EXcqbX/JfkbmC8VARSxjor4r7lzLFqSf2AWgNuXS/xMbjgjDUTVTggA
 4IWd7p8bJqy9bxtPLo7IQnDoXTtVhApZvAET7rZszS2rpUGN0R7FepQ/J43reKgPXQAkM37vygV
 FjVxJYBS+z/Wwcnt49KBz2KzMNet/qIYYEKwNXkX07SqI0Y2Ao+/YXKjd9HPmviMwnfFFxlKxq9
 rHV82IbkEKwDjuzgY1t8MW8dxhuAHA1UQRn7CbpwjiFdCoZawaX8EdC53nfgtP/+gDKAHZmv50x
 Y7KAIvmA6Yn9JaT3ETvYcOB6v7PuFR2qKbwvN2s0lOeMZ0QDWcsQYMbJxUhBWveixt9oLq
X-Received: by 2002:a17:90b:2ccd:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-352c3e9b01cmr1168854a91.16.1768897464070; 
 Tue, 20 Jan 2026 00:24:24 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.21.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35274573a7esm4273592a91.11.2026.01.20.00.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 00:24:23 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v2 2/7] target/riscv: add sdext debug CSRs state
Date: Tue, 20 Jan 2026 16:23:58 +0800
Message-ID: <329a6d5fde74c5cce615053e7f4a0e1c48a27a1b.1768892407.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
References: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add architectural state for Sdext Debug Mode: debug_mode, dcsr, dpc
and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and gate
them to Debug Mode (or host debugger access).

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.c                |   9 +++
 target/riscv/cpu.h                |   4 +
 target/riscv/cpu_bits.h           |  33 ++++++++
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/csr.c                | 126 ++++++++++++++++++++++++++++++
 target/riscv/machine.c            |  20 +++++
 6 files changed, 193 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f1b977f0ee..bd6cff33cf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -211,6 +211,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
@@ -788,6 +789,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     set_ocp_fp8_same_canonical_nan(true, &env->fp_status);
     set_ocp_fp8e5m2_no_signal_nan(true, &env->fp_status);
     env->vill = true;
+    env->debug_mode = false;
+    env->dcsr = DCSR_DEBUGVER(4);
+    env->dpc = 0;
+    env->dscratch[0] = 0;
+    env->dscratch[1] = 0;
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.ext_sdtrig) {
@@ -1140,6 +1146,9 @@ static void riscv_cpu_init(Object *obj)
      */
     cpu->cfg.ext_sdtrig = true;
 
+    /* sdext is not fully implemented, so it is disabled by default. */
+    cpu->cfg.ext_sdext = false;
+
     if (mcc->def->profile) {
         mcc->def->profile->enabled = true;
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c0676ed53..2a265faae5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -476,6 +476,10 @@ struct CPUArchState {
 
     /* True if in debugger mode.  */
     bool debugger;
+    bool debug_mode;
+    target_ulong dcsr;
+    target_ulong dpc;
+    target_ulong dscratch[2];
 
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7..bb59f7ff56 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -467,6 +467,39 @@
 #define CSR_DCSR            0x7b0
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
+#define CSR_DSCRATCH1       0x7b3
+
+/* DCSR fields */
+#define DCSR_XDEBUGVER_SHIFT    28
+#define DCSR_XDEBUGVER_MASK     (0xfu << DCSR_XDEBUGVER_SHIFT)
+#define DCSR_DEBUGVER(val)      ((target_ulong)(val) << DCSR_XDEBUGVER_SHIFT)
+#define DCSR_EXTCAUSE_SHIFT     24
+#define DCSR_EXTCAUSE_MASK      (0x7u << DCSR_EXTCAUSE_SHIFT)
+#define DCSR_CETRIG             BIT(19)
+#define DCSR_PELP               BIT(18)
+#define DCSR_EBREAKVS           BIT(17)
+#define DCSR_EBREAKVU           BIT(16)
+#define DCSR_EBREAKM            BIT(15)
+#define DCSR_EBREAKS            BIT(13)
+#define DCSR_EBREAKU            BIT(12)
+#define DCSR_STEPIE             BIT(11)
+#define DCSR_STOPCOUNT          BIT(10)
+#define DCSR_STOPTIME           BIT(9)
+#define DCSR_CAUSE_SHIFT        6
+#define DCSR_CAUSE_MASK         (0x7u << DCSR_CAUSE_SHIFT)
+#define DCSR_V                  BIT(5)
+#define DCSR_MPRVEN             BIT(4)
+#define DCSR_NMIP               BIT(3)
+#define DCSR_STEP               BIT(2)
+#define DCSR_PRV_MASK           0x3u
+
+#define DCSR_CAUSE_EBREAK       1
+#define DCSR_CAUSE_TRIGGER      2
+#define DCSR_CAUSE_HALTREQ      3
+#define DCSR_CAUSE_STEP         4
+#define DCSR_CAUSE_RESET        5
+#define DCSR_CAUSE_GROUP        6
+#define DCSR_CAUSE_OTHER        7
 
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a8c133d663..99b5529161 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
 BOOL_FIELD(ext_zimop)
 BOOL_FIELD(ext_zcmop)
 BOOL_FIELD(ext_ztso)
+BOOL_FIELD(ext_sdext)
 BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smstateen)
 BOOL_FIELD(ext_sstc)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 870fad87ac..3e38c943e0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3136,6 +3136,126 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static RISCVException sdext(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_sdext) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (!env->debug_mode && !env->debugger) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static target_ulong dcsr_visible_mask(CPURISCVState *env)
+{
+    target_ulong mask = (target_ulong)-1;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!riscv_has_ext(env, RVH)) {
+        mask &= ~(DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V);
+    }
+    if (!riscv_has_ext(env, RVS)) {
+        mask &= ~DCSR_EBREAKS;
+    }
+    if (!riscv_has_ext(env, RVU)) {
+        mask &= ~DCSR_EBREAKU;
+    }
+    if (!cpu->cfg.ext_zicfilp) {
+        mask &= ~DCSR_PELP;
+    }
+    if (!cpu->cfg.ext_smdbltrp) {
+        mask &= ~DCSR_CETRIG;
+    }
+
+    return mask;
+}
+
+static RISCVException read_dcsr(CPURISCVState *env, int csrno,
+                                target_ulong *val)
+{
+    *val = env->dcsr & dcsr_visible_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static target_ulong dcsr_writable_mask(CPURISCVState *env)
+{
+    target_ulong mask = DCSR_EBREAKM | DCSR_EBREAKS | DCSR_EBREAKU |
+                        DCSR_STEPIE | DCSR_STOPCOUNT | DCSR_STOPTIME |
+                        DCSR_STEP | DCSR_PRV_MASK;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    mask |= DCSR_MPRVEN;
+
+    if (riscv_has_ext(env, RVH)) {
+        mask |= DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V;
+    }
+    if (riscv_has_ext(env, RVS)) {
+        mask |= DCSR_EBREAKS;
+    }
+    if (riscv_has_ext(env, RVU)) {
+        mask |= DCSR_EBREAKU;
+    }
+    if (cpu->cfg.ext_zicfilp) {
+        mask |= DCSR_PELP;
+    }
+    if (cpu->cfg.ext_smdbltrp) {
+        mask |= DCSR_CETRIG;
+    }
+
+    return mask;
+}
+
+static RISCVException write_dcsr(CPURISCVState *env, int csrno,
+                                 target_ulong val, uintptr_t ra)
+{
+    target_ulong mask = dcsr_writable_mask(env);
+    target_ulong new_val = env->dcsr;
+
+    new_val &= ~mask;
+    new_val |= val & mask;
+    new_val &= ~DCSR_XDEBUGVER_MASK;
+    new_val |= DCSR_DEBUGVER(4);
+    env->dcsr = new_val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_dpc(CPURISCVState *env, int csrno,
+                               target_ulong *val)
+{
+    *val = env->dpc & get_xepc_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_dpc(CPURISCVState *env, int csrno,
+                                target_ulong val, uintptr_t ra)
+{
+    env->dpc = val & get_xepc_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_dscratch(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
+
+    *val = env->dscratch[index];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_dscratch(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
+
+    env->dscratch[index] = val;
+    return RISCV_EXCP_NONE;
+}
+#endif /* !CONFIG_USER_ONLY */
+
 /* Execution environment configuration setup */
 static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
                                    target_ulong *val)
@@ -6297,6 +6417,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
     [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
     [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
+#if !defined(CONFIG_USER_ONLY)
+    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
+    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
+    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch },
+    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch },
+#endif
 
     [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
     [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 62c51c8033..52264cf047 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -248,6 +248,25 @@ static const VMStateDescription vmstate_sdtrig = {
         VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
         VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
         VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sdext = {
+    .name = "cpu/sdext",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdtrig_needed,
+    .post_load = sdtrig_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ctr,
         &vmstate_sstc,
         &vmstate_sdtrig,
+        &vmstate_sdext,
         NULL
     }
 };
-- 
2.52.0


