Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6523C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6JZ-0001vO-0g; Wed, 31 Jan 2024 03:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JT-0001uS-RC
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:21 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JQ-0007qO-0s
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:17 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40fb5d67763so1514385e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 00:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706691074; x=1707295874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUU2OsysmeYjtlDgPMbUT7x1rpWKo5GkfDES6teYBdY=;
 b=PV34dV6HSMdyHIzENNGZ2KDFFcmxMGW+D2Vf+KsHJOEDSGFi/KgEKUZBhvNvIe3ZSs
 ONAtpqLwB0n58rZTYwEdzoEQ9+VAAkYudKRkmclqqoHz6H+83t9NdeuvQ8lv8SGD2q8j
 enhDdILIVOTmYUXzQFTfHPxUCbg5VUF2blrKykbB1eMKsdla9BAxjcRvDImnNJkUjoXd
 4JK4+wugVg2g5MyfCIPxAtSoRNS4//omgZzaZM4+z7F8I2zoGGJWcbCNNKGebH3gvYBh
 YgyBg18FoGw9grjAOmBD/kXOfgM62gEJ5Gb/Q967kw1A/UgVWMCIUOY2lF8qtPLZH6X4
 ZtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706691074; x=1707295874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUU2OsysmeYjtlDgPMbUT7x1rpWKo5GkfDES6teYBdY=;
 b=fKeRmO3ByDcjHKDBgc23veZV7sGWh9jUA+edPyYHFFb8jooj8+54YrhwuXK5kgnAMD
 cOEA/OnNAsVdvmdLaBVlLqo2r8P/WD7jczWZ3lTve8fXAB2T8MV2PkTJ1KG6XF3nGuvj
 VNuNDfNSHM74LIUJMl5quHEDXqmJbO3ulEECVIb+8RWqH4FSSgE+doJjRFtTqWneHKaL
 caqfcn4uV0RrcS/aJYZ3YO/XfJa8C9s6lfGR4i7rsCUsFT9qjuLHFbFTncBjPIv+bKv9
 1vDaP1S52/Ey3umCWHCS9gJCjVVCWnAZ8KD3bFUyZOSWpLWOCs+2XNcgZGFGYA0NpyX/
 m1ww==
X-Gm-Message-State: AOJu0Yws98FjY32SkWE1jh8rodyO+rRUKKvkiLOqONr+Q/joPwcCX60e
 dUNppRpRHVY6OCBrpGIuCmUL6jXsUCrVLYV3eB4R6hm9ywqyIZEqx42cg8TGU3qicXvI2aOVKUY
 =
X-Google-Smtp-Source: AGHT+IEysSa5YspvsShTwBbW9xPU4Cui3kKxfEeS88udYSZ2/odEuwQb9eW0Pl2JKk8iQp2sHFHY6Q==
X-Received: by 2002:a05:600c:3411:b0:40e:f6a1:ad02 with SMTP id
 y17-20020a05600c341100b0040ef6a1ad02mr767476wmp.14.1706691074278; 
 Wed, 31 Jan 2024 00:51:14 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUSGcp/WPJNqFLCN91P3Z62hfHVVn8apf70Q8IAXmSq9BHxuHFhIYAjj0tiiPsHmqjWshaoOqOCZuQV8iKAZiE06GJ5DM3VeAZbk3LjlhTsSO05u1ZRQlndaM7N8PpsYp8ozIXBe5JG1RX5aSmNmFGa5FqDsaQQAxpx
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:aea2:cdf3:9482:a36])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a05600c181c00b0040efd216050sm909926wmp.35.2024.01.31.00.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 00:51:13 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/9] target/sparc: implement asr17 feature for smp
Date: Wed, 31 Jan 2024 09:50:43 +0100
Message-Id: <20240131085047.18458-6-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131085047.18458-1-chigot@adacore.com>
References: <20240131085047.18458-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This allows the guest program to know its cpu id.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/helper.c    | 16 ++++++++++++++++
 target/sparc/helper.h    |  1 +
 target/sparc/translate.c | 13 +++----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index bd10b60e4b..2247e243b5 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -212,4 +212,20 @@ void helper_power_down(CPUSPARCState *env)
     env->npc = env->pc + 4;
     cpu_loop_exit(cs);
 }
+
+target_ulong helper_rdasr17(CPUSPARCState *env)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong val;
+
+    /*
+     * TODO: There are many more fields to be filled,
+     * some of which are writable.
+     */
+    val = env->def.nwindows - 1;    /* [4:0]   NWIN   */
+    val |= 1 << 8;                  /* [8]      V8    */
+    val |= (cs->cpu_index) << 28;   /* [31:28] INDEX  */
+
+    return val;
+}
 #endif
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 55eff66283..fc818b8678 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -2,6 +2,7 @@
 DEF_HELPER_1(rett, void, env)
 DEF_HELPER_2(wrpsr, void, env, tl)
 DEF_HELPER_1(rdpsr, tl, env)
+DEF_HELPER_1(rdasr17, tl, env)
 DEF_HELPER_1(power_down, void, env)
 #else
 DEF_HELPER_FLAGS_2(wrpil, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9387299559..1cabda9565 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -37,6 +37,7 @@
 
 #ifdef TARGET_SPARC64
 # define gen_helper_rdpsr(D, E)                 qemu_build_not_reached()
+# define gen_helper_rdasr17(D, E)               qemu_build_not_reached()
 # define gen_helper_rett(E)                     qemu_build_not_reached()
 # define gen_helper_power_down(E)               qemu_build_not_reached()
 # define gen_helper_wrpsr(E, S)                 qemu_build_not_reached()
@@ -2681,16 +2682,8 @@ static bool trans_RDY(DisasContext *dc, arg_RDY *a)
 
 static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 {
-    uint32_t val;
-
-    /*
-     * TODO: There are many more fields to be filled,
-     * some of which are writable.
-     */
-    val = dc->def->nwindows - 1;   /* [4:0] NWIN */
-    val |= 1 << 8;                 /* [8]   V8   */
-
-    return tcg_constant_tl(val);
+    gen_helper_rdasr17(dst, tcg_env);
+    return dst;
 }
 
 TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
-- 
2.25.1


