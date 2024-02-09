Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79C0C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOb7-0000a2-NI; Fri, 09 Feb 2024 05:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOb6-0000Xg-Ns
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:08 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOb4-0000FX-SI
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:08 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-204f50f305cso481354fac.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476345; x=1708081145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6Wj7lZTGPCv3rG1ScHAmX9FVviImc2o0oAoK/xkuDU=;
 b=SYNmozR3X3eIb2R8AFcD52DryM7ilXScnA4WjvKPgNnELxugmme4RIqvg9mLVGeaQ4
 hf4342V6nZiLnaxh58iZ1dSq2ZU0meF2GGUpXY8nSgmo0B6d9yw2gnbcFz/G4lE50DqP
 pDTh2d/bVP2DM3q9fHjxy2sg0FErKPubqYCoQ4M9BL9vVE9aw4t0qfYExXl0BcDm70jG
 IQKQMnCgTmDgz6XBk4Vt/XhtidNaQ2ERa8tuPWtxm08gRpJtHU/2ku0kworGmG5/DRPc
 q8HQO9hvTzhBrFwCXrtC8lDPTx0EF/CW/gQ8so22ZAMIt9QIZTkBVtjnE302wP5W5Fhy
 aqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476345; x=1708081145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6Wj7lZTGPCv3rG1ScHAmX9FVviImc2o0oAoK/xkuDU=;
 b=Hu9r1FTGYvCJRNWU7bVTfiHhKNqZUAWzTIc57AR7DdLzUdDSajzd1uK6d7XVNgsizp
 6KKyYlNUUWLM2w0Mb3aMVu6IJZf4StQMm3OR7R9R1az7FuMXelXqAbGrDzEDbSbDPCTI
 oMCoB1ic3OhUOlqDUn7nZMDToVvfNKNP0/jUuRqjgDosntsAUVbC6waraSZOfJn9PuI4
 w4ZNtVwTIjcVeMjksnxG1Kuy4Y5pGOl8GT1XYowZXKZxOaXyNSP817jkmj9/2z9w7LoP
 vXZYsJVorfBSEPB9vIEXZcrRfh9Xh3gu0SPi2zGflvcL9lwqcFtXR3brcNv01pvlovAB
 9WNg==
X-Gm-Message-State: AOJu0YycFG9uczZQSgHmX6p50OZ4w8KZXGazGv8OKKe/4Pv8G7dVk9id
 fmQggfSY0pqwHF5hQo+Es+mGNZM4cJxNIUgZk8vgVZ6++5LdqfWVXBRWNtoNP8ZidQ==
X-Google-Smtp-Source: AGHT+IFlS1MV8UB+JQM2UqrrCDzVnn6XV121JSA+hhWaOJRDUhypNOOBCXhsVl8+ttczW+NSh6VKDg==
X-Received: by 2002:a05:6870:d88:b0:21a:2171:ac41 with SMTP id
 mj8-20020a0568700d8800b0021a2171ac41mr366846oab.31.1707476345281; 
 Fri, 09 Feb 2024 02:59:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVJTGYvtUtQoc7YH1dU5CCrF0RKC5OVC78wXE9tWMjXaqgz61DvWap6+t/WGnbp7OUD+KPl9ReENQ1/uoq+Ap1nulXx229/U03zgx+FNRbIpDr3u/J/JOtj0AvJQjJATQ6mPQLcRo4LrAmSGeE/f6NLAC3SbMqoqWuLE1pYdu6/qsU=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 12/61] target/riscv: move 'elen' to riscv_cpu_properties[]
Date: Fri,  9 Feb 2024 20:57:24 +1000
Message-ID: <20240209105813.3590056-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x33.google.com
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

Do the same thing we did with 'vlen' in the previous patch with 'elen'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Message-ID: <20240105230546.265053-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 44 ++++++++++++++++++++++++++++++++++++--
 target/riscv/tcg/tcg-cpu.c |  5 -----
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 140bb09816..1d4b2b1544 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1319,6 +1319,7 @@ static void riscv_cpu_init(Object *obj)
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
     cpu->cfg.vlen = 128;
+    cpu->cfg.elen = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1830,9 +1831,47 @@ static const PropertyInfo prop_vlen = {
     .set = prop_vlen_set,
 };
 
-Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
+static void prop_elen_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(value)) {
+        error_setg(errp, "Vector extension ELEN must be power of 2");
+        return;
+    }
+
+    if (value != cpu->cfg.elen && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.elen);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.elen = value;
+}
 
+static void prop_elen_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.elen;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_elen = {
+    .name = "elen",
+    .get = prop_elen_get,
+    .set = prop_elen_set,
+};
+
+Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cbop_blocksize", RISCVCPU, cfg.cbop_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
@@ -1920,6 +1959,7 @@ static Property riscv_cpu_properties[] = {
     {.name = "vext_spec", .info = &prop_vext_spec},
 
     {.name = "vlen", .info = &prop_vlen},
+    {.name = "elen", .info = &prop_elen},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index eb182ca876..8afc501a67 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -305,11 +305,6 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
         return;
     }
 
-    if (!is_power_of_2(cfg->elen)) {
-        error_setg(errp, "Vector extension ELEN must be power of 2");
-        return;
-    }
-
     if (cfg->elen > 64 || cfg->elen < 8) {
         error_setg(errp,
                    "Vector extension implementation only supports ELEN "
-- 
2.43.0


