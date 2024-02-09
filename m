Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E1DC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOfF-0008TU-Il; Fri, 09 Feb 2024 06:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdj-0007hs-64
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:54 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdd-0000vg-Lt
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:48 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e0518c83c6so526832b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476501; x=1708081301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrmiXcpe1bZMLQTSTIo9vxkWrCjtZwGRKfh570INs5g=;
 b=lQOHlUBQMP12DTujDulgV3kze3fpQk9+KMbnyQjBExraLaUbZ31ebvw/vf7RUm/yxn
 LgJqD8XAq8xIMoD/9yLoK3qJCncWqIbRkH4iyexqatJM2QScbl0lxRuTkuxN2UzGtpkO
 F73utTlJ1gKQtJpUi4bhDqlgMhPBwtzWL5KvhF9obkmkcLNeFbL82/iYSFZu/j/65Qh/
 A0KxkVsUj6Qh+vKPhKUcy9pPpoPn+Ii41iHaqGQnBCbXkXu1qSkc7e4KCOIChbfhiS9q
 Ka0Bjcg8HYjgCxmPMEIvO22hU+jDXvja5wn0vbp/HeoeOJmGTYRCFDaQ+NZrEz2TtpJ2
 l27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476501; x=1708081301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JrmiXcpe1bZMLQTSTIo9vxkWrCjtZwGRKfh570INs5g=;
 b=UmeGP1PUEh99lw9UVTKxbeRZbwsT4p1lqeE8OqJ5uC7AerpUnfbSLrcPLuJNKkGvFm
 ZHvNTngu6KcsX34n42zH1s8h6LkbGQito2QjT22gX+Aof86SmjzzWuBOy7ANw2tuhRSz
 p5J4oQeQJ5buV6pjviTEbw5I3BhhIaGc07mVQX3yU7i1d+HDzDawMB7qZBUUp/2rBhIo
 JEiYXDkAJ9/jHm3FmY+EX+R046wMqB+nTyCrjrk5AaUh0SEOwBg/dlDBVq1Ut7+Y6i8y
 qIF9h3nroj/haCXUUVn1eFwfFV+jTROH0SgHRsAHnSxRKu806bXkBlez/G6bEfNpPzcW
 zSig==
X-Gm-Message-State: AOJu0Ywadb63pg8cxwW3l2TUkd1jTFsHkv0eSuHI/lIYwGv/0SfOEmWk
 uKg3DKF7lBtC1ULc3krw7AYfaWHy59Cqns8W4MBaEBolMBDl4TocfGbhWeGIVWFnEA==
X-Google-Smtp-Source: AGHT+IEoym8TtjJE0CbCJkSLq50VB7hI5mJ1Z37RQnTZ2i9gYKW9L1iyUQl2oLSdRYpmdVZyMGbsyA==
X-Received: by 2002:a05:6a00:3a97:b0:6e0:5281:e0d1 with SMTP id
 fk23-20020a056a003a9700b006e05281e0d1mr1288582pfb.1.1707476501436; 
 Fri, 09 Feb 2024 03:01:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXoVICyZ5QsGp5jjM725+Sc0E1WKd8J7qHbLvbELVws65DEHtEYGAcWM0fur8R+evFFYVSDDdokzFFepzd+U4m5E8jY2JxMBuRuAvBHVKGbV7Wa8nmGuWAeEB95zh8uQRj+Uq8=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 60/61] target/riscv/cpu.c: add riscv_bare_cpu_init()
Date: Fri,  9 Feb 2024 20:58:12 +1000
Message-ID: <20240209105813.3590056-61-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

Next patch will add more bare CPUs. Their cpu_init() functions would be
glorified copy/pastes of rv64i_bare_cpu_init(), differing only by a
riscv_cpu_set_misa() call.

Add a new .instance_init for the TYPE_RISCV_BARE_CPU typ to avoid this
code repetition. While we're at it, add a better explanation on why
we're disabling the timing extensions for bare CPUs.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122123348.973288-2-dbarboza@ventanamicro.com>
[ Changes by AF:
 - Rebase on latest changes
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6b5878c603..08fc24c3f4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -605,22 +605,6 @@ static void rv64i_bare_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     riscv_cpu_set_misa_ext(env, RVI);
-
-    /* Remove the defaults from the parent class */
-    RISCV_CPU(obj)->cfg.ext_zicntr = false;
-    RISCV_CPU(obj)->cfg.ext_zihpm = false;
-
-    /* Set to QEMU's first supported priv version */
-    env->priv_ver = PRIV_VERSION_1_10_0;
-
-    /*
-     * Support all available satp_mode settings. The default
-     * value will be set to MBARE if the user doesn't set
-     * satp_mode manually (see set_satp_mode_default()).
-     */
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV64);
-#endif
 }
 #else
 static void rv32_base_cpu_init(Object *obj)
@@ -1329,6 +1313,34 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
+static void riscv_bare_cpu_init(Object *obj)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
+    /*
+     * Bare CPUs do not inherit the timer and performance
+     * counters from the parent class (see riscv_cpu_init()
+     * for info on why the parent enables them).
+     *
+     * Users have to explicitly enable these counters for
+     * bare CPUs.
+     */
+    cpu->cfg.ext_zicntr = false;
+    cpu->cfg.ext_zihpm = false;
+
+    /* Set to QEMU's first supported priv version */
+    cpu->env.priv_ver = PRIV_VERSION_1_10_0;
+
+    /*
+     * Support all available satp_mode settings. The default
+     * value will be set to MBARE if the user doesn't set
+     * satp_mode manually (see set_satp_mode_default()).
+     */
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(cpu, VM_1_10_SV64);
+#endif
+}
+
 typedef struct misa_ext_info {
     const char *name;
     const char *description;
@@ -2505,6 +2517,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_BARE_CPU,
         .parent = TYPE_RISCV_CPU,
+        .instance_init = riscv_bare_cpu_init,
         .abstract = true,
     },
 #if defined(TARGET_RISCV32)
-- 
2.43.0


