Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA0FC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLP-0005QK-Pu; Fri, 04 Sep 2026 01:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLM-0005Ph-0g
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:04 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLG-00011n-0R
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-852c481415fso616160b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499196; x=1789103996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R/bmbpHd5SjFAsmA8kAw5YlABsteWaUi9Gle/d6ZH6w=;
 b=TsLYpcjE4iKAs8BGUkAZasaeKYOD3fyT0HEou+nQ8Q6IchmmvZn7Jby6zbygJ66Fkr
 PXyuZA8a80E3BLyAJAPux1pxqLIMdAkbbY+eszQDN6fuIlGcDjm+E/BWjvKkIKJvV8vQ
 a5gTfer/55LDsdmWZ/9pHieURO11S0F6iGUY6VNLf0w/mzCqeHKXiT6gacIX2xd9hZ5a
 QPDs9+R1pPjvBLtyOTxp4XJKE76k1lnaHrs5uES7NdCnxeGXPmveAGlyAwKUvX8W7Kc0
 2eI8+MfoEQWzZoTQySb1+uo/3TKLyFvPxRXAYfUu4CiTp9J3pQdkzx4xmAzMfgGtk/tS
 fcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499196; x=1789103996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R/bmbpHd5SjFAsmA8kAw5YlABsteWaUi9Gle/d6ZH6w=;
 b=j1wUxgP7Cbubk/J51nMIahledLs2zhApIn9whI32OeM8PbpdUBGoCmc1pmrvHTHCrj
 qBsNdC6Ppyho9ueDg1etmg52fAKL9THlONkEGO4W4VnKTJkcJyefEoiGeb4Dq+87Fkbh
 LglFc/XbljYO4sSRPIun96TBuZy7jmZ80mxcP9ErA1Jz2UMdybCGxtGULgv6utIB5AhL
 d4BO1aaa9FNvcDJRJm9or3VS7hUS0W5jXp/JQM3px2ogNCrTvpnkwLh+3SKdP22d++Rq
 Z01m4mQ7P9l14EfFZI29o0i++qcXNAsUqMXFH5kEPA5uawBPmKa1PS4jH1e3+UbINjJc
 gLlg==
X-Gm-Message-State: AFuF++nTn3F/qo2wlqmohD8n00eM43Mupa8VSkJHE8cunQ+uGw5hmjkI
 SHmSaLB4ZX0IogwZCXdxSAjmX0SNx/JhcbyIEJJ+NJPmt46QoUHq6U1ubCPLVQ==
X-Gm-Gg: AYBFou0S7eS1d65v5JlNntn4zX037TiSq6RXxR0TenC7oZgf35AWSyjKM4+uWv+f3Qj
 6sRhQzyuUetwdIdAJnGzdnSw8IiSdTlEp2uwPZKYabatwAqrWwl0rVBiFdwXpFIMkRWhsn/cfG6
 s8tfaYVDo5BQBcyDmr8ZB2bujnG6GUVxJZW87pJNTyktcil430J/aWVbxvVMQZjDHLo0hLLq/M4
 Xi9SqeXHHjZDpc8yvEw+yS+nknTBCDsb16gmp9+AaeISK2CnoA0bho3PSoTsQ0Rev30e3u1M8mm
 Fcv22GPyBCM1tk4ll3yAFM54VZl8La1VfNdt+QxmRDI43sLxR4tlpXU9RKCpYv9EG5n7ea4EDa5
 bdOwGuS0FH5e3hXpvk7rE68+x8vtJewWKx80ba50mfWIpqexGReCUl+kIlmZ4tOTKSxX39EoYCv
 2KHwKQYVE3RRSXDPWndBBG8lgcaAm1QH7LjmLSNJSLy4GtzBRmNe8IeS0oOFHdBdpJVR+L4FJJH
 x9lZA==
X-Received: by 2002:a05:6a20:d10e:b0:3da:28b3:7c5a with SMTP id
 adf61e73a8af0-3da3a08ed08mr5730582637.13.1788499196573; 
 Thu, 03 Sep 2026 22:19:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:19:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/47] target/riscv: split 'debug' and 'sdtrig' flags
Date: Fri,  4 Sep 2026 15:18:57 +1000
Message-ID: <20260904051943.799041-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We need to support modern debug extensions that happens to be
dependencies of other things that we want to support (e.g. a riscv
server spec board).  These extensions, namely sdext, depends on Debug
1.0.  At this moment we support Debug 0.13, and so it happens that 0.13
and 1.0 aren't backwards compatible, i.e. we need design changes to
support both.

The easier way is to deprecate the Debug 0.13 support, together with its
legacy 'debug' flag and call it a day.  But there's a demand to keep the
0.13 support around and this idea got scrapped.

We're going to support both 0.13 and 1.0, where the 'debug' flag will
refer to 0.13 and 'sdtrig' to 1.0.  We need to split both in distinct
flags first to handle the backend changes, so:

- add a new cpu->cfg.ext_sdtrig flag;
- all code that checks "if debug enabled" now checks for both debug and
  ext_sdtrig;
- amend riscv_isa_string_ext() to keep adding 'sdtrig' in riscv,isa if
  we have just the 'debug' flag enabled.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260805182506.2943757-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/cpu.c                | 21 ++++++++++++++++-----
 target/riscv/machine.c            |  2 +-
 target/riscv/tcg/csr.c            |  2 +-
 target/riscv/tcg/tcg-cpu.c        |  3 ++-
 5 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index f8c27a574f..f91c780299 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -105,6 +105,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fd1afbc7fe..a760ba3a52 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -248,7 +248,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
-    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
                                 has_priv_1_12),
     ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
@@ -1091,7 +1091,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 #endif
@@ -1331,7 +1331,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
@@ -1348,7 +1348,7 @@ static void riscv_cpu_unrealize(DeviceState *dev)
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     RISCVCPU *cpu = RISCV_CPU(dev);
 
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_unrealize(&cpu->env);
     }
 #endif
@@ -2925,6 +2925,11 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
 };
 
 static const Property riscv_cpu_properties[] = {
+    /*
+     * The 'debug' flag enables support for the legacy Debug
+     * 0.13 spec.  In case cpu->ext.ext_sdtrig is also enabled
+     * the CPU will enable Debug 1.0 instead.
+     */
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
     DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
 
@@ -3146,7 +3151,13 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
     char *new = *isa_str;
 
     for (edata = isa_edata_arr; edata && edata->name; edata++) {
-        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset)) {
+        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset)
+            /*
+             * We've been adding 'sdtrig' in riscv,isa for
+             * Debug 0.13 for awhile.  Until we decide to
+             * move away from it we'll keep doing it.
+             */
+            || (!g_strcmp0(edata->name, "sdtrig") && cpu->cfg.debug)) {
             new = g_strconcat(old, "_", edata->name, NULL);
             g_free(old);
             old = new;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index c3f5a25509..bf203bffce 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -268,7 +268,7 @@ static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug;
+    return cpu->cfg.debug || cpu->cfg.ext_sdtrig;
 }
 
 static int debug_post_load(void *opaque, int version_id)
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 002f7e69c1..bd4b6dc114 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -804,7 +804,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 
 static RISCVException debug(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->debug) {
+    if (riscv_cpu_cfg(env)->debug || riscv_cpu_cfg(env)->ext_sdtrig) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 9e3cc87f8a..54f1b66216 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -182,7 +182,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.debug && !icount_enabled()) {
+    if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
+        && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
-- 
2.55.0


