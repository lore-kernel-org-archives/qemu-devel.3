Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7943BC4829F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObL-0000wv-Cd; Fri, 09 Feb 2024 05:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObJ-0000wV-DY
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:21 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObH-0000GI-Rp
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:21 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-219122781a3so417389fac.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476358; x=1708081158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hr51UkfS9KrgxOQVsxVtiiiAUSbgyo6cNS0t0YX3ZV4=;
 b=ikhWaYAzizEBdten77eLSjlWMX3zbUnyNtuh3U8ThC19JgIfriMscug/3kab65Yf6B
 BsV286TugdRwSpNLBta9neMInjLg2IlcRoXtrD5isTUFtbwA4Si9VaBfsHz8Vjk/DMFM
 vYFF+a+8Fp1CP1dlDhT9q5Qt0IoWYDuhtqtLFTiqf6mynwlXQ1EgS8HgNmAw2961LlGL
 ElGUjOCPP4c2e3okuIfGzZ/kFEcgbU+p9h+DQ4eRnUboWqnnxTs1OHh5KV/ZULfP3/C/
 NGYgIoOEhLKUd2lwM9hBEqKDCNa+wtQapUbW/W8bjEtv8tKWOmAyf7PwJwZ8Nxrh9xRy
 yIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476358; x=1708081158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hr51UkfS9KrgxOQVsxVtiiiAUSbgyo6cNS0t0YX3ZV4=;
 b=fjC5bOcCyBQ4w3oSjSEKU9pFmsrcORCAy92CPUHPt4V2Vo4jaw+iyuVQNzVLjYiHiB
 cBPkKAd2Ml9BIFyIxKV+uFc9ITDf1nq6JW3bz0v+llBV5F1uFvXIfManJawPg7KLh5lf
 yb8oAqQeFqIlh1b/YLEPF+QzahsxM9+AAecqSaG3svJJ7sa/eqiEjc+WR8x7TSrW9YN7
 Xc/czMtC0EfCTw2jQLf7uBQ6lOXEvJOk9bW4mlnO54PBLShImPz8+hYgbHLbPIEQtRQy
 L19+vupeXRfp3pzT4LgWGO0WV5OSVc5sOW78U0NRcfK4c/C+MnJX/N/+/JJQc+TkNlxw
 kP3A==
X-Gm-Message-State: AOJu0YzVTCoGzdDyXcY2URQamYlBbZVp4BHEz6fA/9RbLlz8BqIHRsuX
 pqtejbhOLb/y2CZks4LCfZpIxd6nKBa2lXFm6r1s4Lhd1Kfp3RVGodq+IKtVtgrYtg==
X-Google-Smtp-Source: AGHT+IHMBF1UHvF/WTomxB3OhO4oaCyPKRO270RvJzPBG90oeh4MrGFJJ7KeZE+IMSOeXqRdhjVXdA==
X-Received: by 2002:a05:6870:330b:b0:219:f071:416c with SMTP id
 x11-20020a056870330b00b00219f071416cmr1092684oae.16.1707476358415; 
 Fri, 09 Feb 2024 02:59:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWIJYSSuNvQG6hPb7xoyV8Kb9tRT78E1ZRggJUI3pnht08Nb2LemgW64DGpLwlnVs9Jk3Y7Ezgi22nhsWCtUeikrO+ynj5JwChYZSktGr0LBPtcVpJfTcJyt+DCyNiGVEPWmmsEegehVjgPrWrbO2jBtdcKQZcrUeaH1++/1llMPbo=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:17 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 16/61] target/riscv: move 'cboz_blocksize' to
 riscv_cpu_properties[]
Date: Fri,  9 Feb 2024 20:57:28 +1000
Message-ID: <20240209105813.3590056-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

And remove the now unused kvm_cpu_set_cbomz_blksize() setter.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
tested-by tags added, rebased with Alistair's riscv-to-apply.next.
Message-ID: <20240112140201.127083-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 38 +++++++++++++++++++++++++++++++++++++-
 target/riscv/kvm/kvm-cpu.c | 28 ----------------------------
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1828366d93..da8d19c790 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1328,6 +1328,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.elen = 64;
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cbop_blocksize = 64;
+    cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1949,8 +1950,42 @@ static const PropertyInfo prop_cbop_blksize = {
     .set = prop_cbop_blksize_set,
 };
 
+static void prop_cboz_blksize_set(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value != cpu->cfg.cboz_blocksize && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.cboz_blocksize);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.cboz_blocksize = value;
+}
+
+static void prop_cboz_blksize_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.cboz_blocksize;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_cboz_blksize = {
+    .name = "cboz_blocksize",
+    .get = prop_cboz_blksize_get,
+    .set = prop_cboz_blksize_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -2039,6 +2074,7 @@ static Property riscv_cpu_properties[] = {
 
     {.name = "cbom_blocksize", .info = &prop_cbom_blksize},
     {.name = "cbop_blocksize", .info = &prop_cbop_blksize},
+    {.name = "cboz_blocksize", .info = &prop_cboz_blksize},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 094bc5f47c..748a690b73 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -352,30 +352,6 @@ static KVMCPUConfig kvm_cboz_blocksize = {
     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
 };
 
-static void kvm_cpu_set_cbomz_blksize(Object *obj, Visitor *v,
-                                      const char *name,
-                                      void *opaque, Error **errp)
-{
-    KVMCPUConfig *cbomz_cfg = opaque;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    uint16_t value, *host_val;
-
-    if (!visit_type_uint16(v, name, &value, errp)) {
-        return;
-    }
-
-    host_val = kvmconfig_get_cfg_addr(cpu, cbomz_cfg);
-
-    if (value != *host_val) {
-        error_report("Unable to set %s to a different value than "
-                     "the host (%u)",
-                     cbomz_cfg->name, *host_val);
-        exit(EXIT_FAILURE);
-    }
-
-    cbomz_cfg->user_set = true;
-}
-
 static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
 {
     CPURISCVState *env = &cpu->env;
@@ -493,10 +469,6 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
                             NULL, multi_cfg);
     }
 
-    object_property_add(cpu_obj, "cboz_blocksize", "uint16",
-                        NULL, kvm_cpu_set_cbomz_blksize,
-                        NULL, &kvm_cboz_blocksize);
-
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental_exts);
-- 
2.43.0


