Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB113C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOet-0008Hr-Qj; Fri, 09 Feb 2024 06:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcG-0005nb-BO
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:23 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcE-0000Zo-MZ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:20 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-21946b0f3f1so332486fac.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476417; x=1708081217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyU40T5eXc0YHOxx1vI3eqoUAF1Nm4nWleOZJTdBJKg=;
 b=nAVOegGY9E0HW7/afvblYdBu29R1TLK7+kl70diWAyHU/UUoUzFfGyrQOVZEGtpGFh
 Pv42FDyfBIttcVCkKCHEQ3tzfFahbMlUZZSKEh2m7e8X/rMzFeS1/41mUBlQ8MNwsf3H
 PzWTxxGP6pS2/cdvCqP3VbDoS2j89OdYh4M2KXhVuvrN33zciBz3bEP+KJCCDjtaz0DF
 FInBNVQEsYMLljBPfRDXWFvT4ph6ZzUqVz65J1QcBR3zW8iINLSSWxIsI132wyo8JgA8
 9hVyQ/oO651uvorjNXVOU8azqutAVf4+A14Fcy4xjR5W2xfJVsI1uf52EVbl+loh4m8M
 PB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476417; x=1708081217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyU40T5eXc0YHOxx1vI3eqoUAF1Nm4nWleOZJTdBJKg=;
 b=L4yrkR3JXaeiFwpJRskNpL7vw4dsKaodhL0qYFOV6/u3ZH/zr5Ej2VVWF6CaFXydsi
 kIFQN9iNYXWh5OFm202pC1UFNirb9VIyX6xjWFeYMelDfG1M0lYjIVgz9RPehR22wQKu
 adNXyRgoTvAM4KbZbbube8q6kMXY9axzv3O1Fg0SCi47HcQdSrAUqQbPZIEbpsAko3zN
 wbTlg6nT2pstF1kid1jtOqpK6sEZgPooIOOA/sPZGweBzA2mjbDnCgamKTCk2Cl+iH0I
 CI94eBlBLeVfq45IdSPJGgSkzE51wG+ylL5xfnrNj5MueTAwSo4UuPpS2tvnHsTbN3p7
 TQVw==
X-Gm-Message-State: AOJu0YzApVi6YE5xR3axHEa1Id7Y2y27LC4MIOLhNfsSqqDucjkcLSBV
 pF0UWwt/J5HG2uOyNRH6+4gPys+XGO4QBEOCcVtfh6tBPYo42Q+w7va9C/SjOKgJHA==
X-Google-Smtp-Source: AGHT+IGEQ6xKJbX9OJTcl1H7XOYJzf5068reyJr7607ratjsMkvVdd78ZlzDKUE3jVagY3WqPVqpAQ==
X-Received: by 2002:a05:6870:b24f:b0:21a:e4e:8e76 with SMTP id
 b15-20020a056870b24f00b0021a0e4e8e76mr1226639oam.7.1707476416740; 
 Fri, 09 Feb 2024 03:00:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWGUcAHRSEV8byqQByouVxbNhFPlVz35Tg+9qJhtM7LygV36NEcWITzuv6rp0/5NprkmMFsqlZsR85og+cfST9hdGwp+Qjj3M71TBdG/aKhYAY5sJMj1H1WgU4/NOzmlw9jp07uDdhh3wArLfnMIFRmwCDmJBZ3/ugbxFExJ3UvPp0=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:16 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/61] target/riscv/cpu.c: remove cpu->cfg.vlen
Date: Fri,  9 Feb 2024 20:57:46 +1000
Message-ID: <20240209105813.3590056-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x36.google.com
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

There is no need to keep both 'vlen' and 'vlenb'. All existing code
that requires 'vlen' is retrieving it via 'vlenb << 3'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-14-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     | 1 -
 target/riscv/cpu.c         | 8 +++-----
 target/riscv/tcg/tcg-cpu.c | 4 +++-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 50479dd72f..e241922f89 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -139,7 +139,6 @@ struct RISCVCPUConfig {
     bool ext_XVentanaCondOps;
 
     uint32_t pmu_mask;
-    uint16_t vlen;
     uint16_t vlenb;
     uint16_t elen;
     uint16_t cbom_blocksize;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d34e87684d..bf58ba4b57 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1324,7 +1324,6 @@ static void riscv_cpu_init(Object *obj)
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
-    cpu->cfg.vlen = 128;
     cpu->cfg.vlenb = 128 >> 3;
     cpu->cfg.elen = 64;
     cpu->cfg.cbom_blocksize = 64;
@@ -1816,22 +1815,21 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value != cpu->cfg.vlen && riscv_cpu_is_vendor(obj)) {
+    if (value != cpu->cfg.vlenb && riscv_cpu_is_vendor(obj)) {
         cpu_set_prop_err(cpu, name, errp);
         error_append_hint(errp, "Current '%s' val: %u\n",
-                          name, cpu->cfg.vlen);
+                          name, cpu->cfg.vlenb << 3);
         return;
     }
 
     cpu_option_add_user_setting(name, value);
-    cpu->cfg.vlen = value;
     cpu->cfg.vlenb = value >> 3;
 }
 
 static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    uint16_t value = RISCV_CPU(obj)->cfg.vlen;
+    uint16_t value = RISCV_CPU(obj)->cfg.vlenb << 3;
 
     visit_type_uint16(v, name, &value, errp);
 }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b580b83f9a..5618769a00 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -298,7 +298,9 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
-    if (cfg->vlen > RV_VLEN_MAX || cfg->vlen < 128) {
+    uint32_t vlen = cfg->vlenb << 3;
+
+    if (vlen > RV_VLEN_MAX || vlen < 128) {
         error_setg(errp,
                    "Vector extension implementation only supports VLEN "
                    "in the range [128, %d]", RV_VLEN_MAX);
-- 
2.43.0


