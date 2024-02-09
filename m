Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06793C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOb2-0000LW-4r; Fri, 09 Feb 2024 05:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOaz-0000B3-CV
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:01 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOax-0000Es-R8
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:01 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-59cf4872e1dso352718eaf.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476338; x=1708081138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvSrjBWPr8+krUa2FgRCezO4cbWcCwvAHM73Bgb9B9g=;
 b=CIGopDsrmLxkuvISgrdx/nCo18yIoYToXezs8eZtEbm9ecztMncifmXwYETAln7NS9
 1OV0Lcviso4anfWm76TLj8KiUbBPJxfB8sEZlXShKyvo5muYDw1TNdPnSg5RUJwHmMdP
 lT2CY1sOlpkKZ3E5R/eMQN7nfw2MA5RVe9ktJybNs2KHge1CwQmD4Vpn6CIBwIGv0RNl
 wVH0S4a9EPckLD8Bh++z8c5ZfzgKPYeWM2VaAIuV8/qFyKWXS5x3hGc/jJH0lQoOb/Nh
 DGNyoTQ1vxJeH+rI4af7I8HisTxoF5jCjLcfK66kARHQ+HNtYQRYqAT2+kPQoOIS6e0U
 8qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476338; x=1708081138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvSrjBWPr8+krUa2FgRCezO4cbWcCwvAHM73Bgb9B9g=;
 b=tHqKXvxGaGGhYkZUNaA3sdg7PddgfpB0ZP+M8J4LyzNN7+wyT0JrmkSbXMxZdVyPfw
 XARhB6cImqWhCJhspR876wTLs4v2mWb312oWrj9C5eCTpJ7eMYpKXvIuu2106OhcbVyl
 9ofICQkQRyTkVvy6uIOsiH7brtLA4t6dVHkoCX6lunEanEbexOKKcXCdk3UGu0BuEG+K
 dDDZ6gtRt+yGbBZtKuYkc+AUfVLLDdpWJzvxJOMaWf9DhmpZjPMhZDEok5RsF3RlvfcY
 WvCozA//muaFmPNif1RMTVrPauFomIlQk0WDEvcrEx3xoRxfStrmrKznXenWX6f+f4AS
 9LMw==
X-Gm-Message-State: AOJu0Yw2ykIGbgwVQLv8bOOxF0shIQ7rsieAGxqbft7/SXA39vfzCYye
 E+xAbMTrPcwZ58uf6k2ILfPooxupaj9oCxEc4j3AutWHQtuH6VhSJJCJgYUfqed+ag==
X-Google-Smtp-Source: AGHT+IEQUrqhsGrsSptKQ2FHg9JE6MxjFYkXdeY+VwgeP8wEVCDOe/Ha0HhPai0H2tU3iJViFd8eEA==
X-Received: by 2002:a05:6358:c83:b0:178:98c8:9d76 with SMTP id
 o3-20020a0563580c8300b0017898c89d76mr1142132rwj.26.1707476338521; 
 Fri, 09 Feb 2024 02:58:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXJEmj3gtbFSdyFVRor8/CYQ1sDMuEqGcHe6DOrdz/RR3Zqu1rppf3iFHRJ1kVQcFzXLSNRvfq028kZsLbW++wzr7qUCa4JgoeqYKgGcHO4ZPQDYCftQP6GtFYxSHbbILS/vM4C2H9MSdHOVB2Kla3J/Z8/oIYwZ1fMZXYdRtHTgMY=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:58:58 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 10/61] target/riscv: rework 'vext_spec'
Date: Fri,  9 Feb 2024 20:57:22 +1000
Message-ID: <20240209105813.3590056-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2e.google.com
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

The same rework did in 'priv_spec' is done for 'vext_spec'. This time is
simpler, since we only accept one value ("v1.0") and we'll always have
env->vext_ver set to VEXT_VERSION_1_00_0, thus we don't need helpers to
convert string to 'vext_ver' back and forth like we needed for
'priv_spec'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Message-ID: <20240105230546.265053-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/cpu_cfg.h     |  1 -
 target/riscv/cpu.c         | 35 +++++++++++++++++++++++++++++++++--
 target/riscv/tcg/tcg-cpu.c | 15 ---------------
 4 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index afecbbb0c1..2a5e67c141 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -106,6 +106,7 @@ enum {
 };
 
 #define VEXT_VERSION_1_00_0 0x00010000
+#define VEXT_VER_1_00_0_STR "v1.0"
 
 enum {
     TRANSLATE_SUCCESS,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 68965743b6..fea14c275f 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -139,7 +139,6 @@ struct RISCVCPUConfig {
     bool ext_XVentanaCondOps;
 
     uint32_t pmu_mask;
-    char *vext_spec;
     uint16_t vlen;
     uint16_t elen;
     uint16_t cbom_blocksize;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b8c8374a11..1a7a2f1d64 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1317,6 +1317,7 @@ static void riscv_cpu_init(Object *obj)
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
+    cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
 typedef struct misa_ext_info {
@@ -1756,9 +1757,38 @@ static const PropertyInfo prop_priv_spec = {
     .set = prop_priv_spec_set,
 };
 
-Property riscv_cpu_options[] = {
-    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
+static void prop_vext_spec_set(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    g_autofree char *value = NULL;
 
+    visit_type_str(v, name, &value, errp);
+
+    if (g_strcmp0(value, VEXT_VER_1_00_0_STR) != 0) {
+        error_setg(errp, "Unsupported vector spec version '%s'", value);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, VEXT_VERSION_1_00_0);
+    cpu->env.vext_ver = VEXT_VERSION_1_00_0;
+}
+
+static void prop_vext_spec_get(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    const char *value = VEXT_VER_1_00_0_STR;
+
+    visit_type_str(v, name, (char **)&value, errp);
+}
+
+static const PropertyInfo prop_vext_spec = {
+    .name = "vext_spec",
+    .get = prop_vext_spec_get,
+    .set = prop_vext_spec_set,
+};
+
+Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
 
@@ -1846,6 +1876,7 @@ static Property riscv_cpu_properties[] = {
     {.name = "pmp", .info = &prop_pmp},
 
     {.name = "priv_spec", .info = &prop_priv_spec},
+    {.name = "vext_spec", .info = &prop_vext_spec},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fdcbea4b23..9820612f36 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -321,21 +321,6 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                    "in the range [8, 64]");
         return;
     }
-
-    if (cfg->vext_spec) {
-        if (!g_strcmp0(cfg->vext_spec, "v1.0")) {
-            env->vext_ver = VEXT_VERSION_1_00_0;
-        } else {
-            error_setg(errp, "Unsupported vector spec version '%s'",
-                       cfg->vext_spec);
-            return;
-        }
-    } else if (env->vext_ver == 0) {
-        qemu_log("vector version is not specified, "
-                 "use the default value v1.0\n");
-
-        env->vext_ver = VEXT_VERSION_1_00_0;
-    }
 }
 
 static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
-- 
2.43.0


