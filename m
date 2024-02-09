Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E28C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOar-00008v-Gx; Fri, 09 Feb 2024 05:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOap-0008Vy-Sv
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:51 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOao-0000Cs-2d
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:51 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso240300b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476328; x=1708081128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkBieeUpGVnFbhuy6NCd8xFId+mBILOYnx7B36fkTzs=;
 b=jR8SYOsDR7mo1YI+yXfg5s1zBu3QyvZal3X0NWxSxlnMIhiPeKyOGNW0qrxHICRxx8
 dEUMrYOGbJTZ9bg5E9kyahFHtQ1Zn7lI28Ij01ATbEl0XdzXwdnNTv/qezHCqLHQ8PMO
 MCxUanVruibQ4aVNN65dmLtDpbwYSQItibXurOraw+hGJgCWUn0QvCU0vmF7xvJsbYXS
 xhDREALMi2RCVRFL95Uph5t03BrqRIxMv/4AZ6at4JanAyIlNi85lWSDetdQnuQ6O3XC
 qFwDlCSglIx+Qgt2FKBIKnAYXJiBxMLPxV6fSXTd21EZfg2kw67XQx6BEu8e4tMB9vp6
 CFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476328; x=1708081128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkBieeUpGVnFbhuy6NCd8xFId+mBILOYnx7B36fkTzs=;
 b=LdRC+tt5YnUwjSi/Qj0k+oBD93+hhnxzv8P5hp5WY+KnMvaK0FKbGI7EKYVgfr2Fme
 OJ1pw+b/XyQ6tY3FDu2e0mHPlY1DonHHHt8DkZjVBcjrTN/oBQgsQwHcjwRpem23rQXA
 lKuSD27nz3pdt6eZ5l2vGmn8G9+uRvcqGNaian5+6Ae+jLADxc8xZBtd6WLshR4LvzrX
 FBLz+cjeefL75GOhoayV70/FwYqVBCTMC6iI3bSYnReLv3ERiDYW1YZu4b8XWDaSHxjs
 4IskISMmY4zpswFjnaD3xvNdQyhUo2SvAYJb2904qF+ba2+vIQsv/2QBoHmQuhbxyWyX
 RALQ==
X-Gm-Message-State: AOJu0YwF9fsGQ20BmOw35FSA/gveVwz7wfcvdI+97mYQ5NDwXahg64bp
 jq5/uyDloF4bOxXnwxjqO1oiHva80O9txPdjL8IZVRV7GjHFk50Qs+QjqWZtOIOPmg==
X-Google-Smtp-Source: AGHT+IGuos9C8djF1W7gwjdn7iosTbRHpHtyfNe92jTuh2IxASD2jAEvq99q57OFMv0zUrHfNrjLMg==
X-Received: by 2002:a05:6a21:31c8:b0:19e:b706:fe97 with SMTP id
 zb8-20020a056a2131c800b0019eb706fe97mr755009pzb.3.1707476328460; 
 Fri, 09 Feb 2024 02:58:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW5pczA6evAbm4XvxX325Q8eRCCwLQWeYaAuNAGGTzbLzZyOLgLdn92xCQvwttYyPq476g7d4xG0q51c6tCEjz+0SYXdCkPvcR+sJnIv2HzzkfRxkQ8BGSUUUU6O6W5yaeVZCyVrn/hl2KKShwj5zB7Lonr7qwpAcIp3oztDUnNO1g=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:58:48 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 07/61] target/riscv: move 'mmu' to riscv_cpu_properties[]
Date: Fri,  9 Feb 2024 20:57:19 +1000
Message-ID: <20240209105813.3590056-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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

Commit 7f0bdfb5bfc ("target/riscv/cpu.c: remove cfg setup from
riscv_cpu_init()") already did some of the work by making some
cpu_init() functions to explictly enable their own 'mmu' default.

The generic CPUs didn't get update by that commit, so they are still
relying on the defaults set by the 'mmu' option. But having 'mmu' and
'pmp' being default=true will force CPUs that doesn't implement these
options to set them to 'false' in their cpu_init(), which isn't ideal.

We'll move 'mmu' to riscv_cpu_properties[] without any defaults, i.e.
the default will be 'false'. Compensate it by manually setting 'mmu =
true' to the generic CPUs that requires it.

Implement a setter for it to forbid the 'mmu' setting to be changed for
vendor CPUs. This will allow the option to exist for all CPUs and, at
the same time, protect vendor CPUs from undesired changes:

$ ./build/qemu-system-riscv64 -M virt -cpu sifive-e51,mmu=true
qemu-system-riscv64: can't apply global sifive-e51-riscv-cpu.mmu=true:
   CPU 'sifive-e51' does not allow changing the value of 'mmu'

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Message-ID: <20240105230546.265053-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 55 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1b11e9098b..3b5d6da736 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -437,6 +437,8 @@ static void riscv_max_cpu_init(Object *obj)
     CPURISCVState *env = &cpu->env;
     RISCVMXL mlx = MXL_RV64;
 
+    cpu->cfg.mmu = true;
+
 #ifdef TARGET_RISCV32
     mlx = MXL_RV32;
 #endif
@@ -451,7 +453,11 @@ static void riscv_max_cpu_init(Object *obj)
 #if defined(TARGET_RISCV64)
 static void rv64_base_cpu_init(Object *obj)
 {
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
+    cpu->cfg.mmu = true;
+
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV64, 0);
     /* Set latest version of privileged specification */
@@ -569,13 +575,18 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 
 static void rv128_base_cpu_init(Object *obj)
 {
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
     if (qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_report("128-bit RISC-V currently does not work with Multi "
                      "Threaded TCG. Please use: -accel tcg,thread=single");
         exit(EXIT_FAILURE);
     }
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+
+    cpu->cfg.mmu = true;
+
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV128, 0);
     /* Set latest version of privileged specification */
@@ -609,7 +620,11 @@ static void rv64i_bare_cpu_init(Object *obj)
 #else
 static void rv32_base_cpu_init(Object *obj)
 {
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
+    cpu->cfg.mmu = true;
+
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV32, 0);
     /* Set latest version of privileged specification */
@@ -1605,8 +1620,38 @@ static const PropertyInfo prop_pmu_mask = {
     .set = prop_pmu_mask_set,
 };
 
+static void prop_mmu_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value;
+
+    visit_type_bool(v, name, &value, errp);
+
+    if (cpu->cfg.mmu != value && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, "mmu", errp);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.mmu = value;
+}
+
+static void prop_mmu_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    bool value = RISCV_CPU(obj)->cfg.mmu;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_mmu = {
+    .name = "mmu",
+    .get = prop_mmu_get,
+    .set = prop_mmu_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
 
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
@@ -1695,6 +1740,8 @@ static Property riscv_cpu_properties[] = {
     {.name = "pmu-mask", .info = &prop_pmu_mask},
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
 
+    {.name = "mmu", .info = &prop_mmu},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
-- 
2.43.0


