Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D0BC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOfh-0000DJ-NJ; Fri, 09 Feb 2024 06:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdI-0007G7-Ki
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:25 -0500
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdF-0000s3-Qm
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:23 -0500
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7c3e01a7fdeso28611939f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476480; x=1708081280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFfabkqZ7+KZbRfwTJjM37aj+onUUvLrbV1BgbFXOZk=;
 b=Qw+oTd7egFkyQ/xUSnuzEwY8Gf9oh0SsDHXl+VqFyYPm1abgk1JPQ+dpuMdu0W69qi
 7F/OUytVlBi1ctRGNEnpi2y68RYc7L6oH7rLFkUDjeOMyc4VPOTyaEz9gv47rym+4O3P
 ue+9M6ntHaDaKTtpfrWND7NmFaK0wFB6C36vA1CAjVyC8JT3t+1xwmaHZplJDsa/pqCT
 ZH9LELn2+GFWDwBbp3T28v3PnyOTOyITO8Y1KlH9pBCrhbkK27yOQV1hdu7CI1Yac/+W
 3YJk5kCdCCA7vAsKaauv/PyEfZhHFVSYPfVbq8s3r8BWZAby2cvN2HLW8aBgShm03epD
 ioPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476480; x=1708081280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFfabkqZ7+KZbRfwTJjM37aj+onUUvLrbV1BgbFXOZk=;
 b=VYDW+W+sN8cYxZLQsUWOlsW0mq7qfy3mf/txvSW+KaWRX76tkJgB6PViNXJZpDqfg2
 CETmEWJEEOM9wEiLcbZMPqAFn3HhsKmV2S2Lr6raiJKqIOD/in2M0M7ht+ASFxsZspqh
 4OsqMvsRbI2tJACpBM07Zv+fdlGCZVd8cZe5GDvORZjGUpNtHG3UNPopEB+Lrh2xuQ0l
 5K038OOOhg0Qa0SnpchQNwdgQVgb4hJktq5mESiHQoiVViTgDHowJZTIIhA8YWxI6mI3
 XESrNN6Wy23ioy5+oDYCO8X4fXEcY+9IQ0+UfTvd+lXDW21wwgBtGhitfbD1c0TRSqru
 3Big==
X-Gm-Message-State: AOJu0YztLCMDwidolVksCjBAOWlR7pz3nb1TA3bWy5UWq/1hqGeWpnVi
 TuoniolWJTe3gD2XovKNd+axYG65XWuRpfCaz7r2yQ7VEcqLUBuIAJ+zH1UrMkBWMA==
X-Google-Smtp-Source: AGHT+IFThFb+lQJki51H4Ge6C95UaiWODlmhSzulL28urTvO38HivEEnyoYdGuzxC33bKxBru6jGCA==
X-Received: by 2002:a05:6e02:d03:b0:363:c181:ab8b with SMTP id
 g3-20020a056e020d0300b00363c181ab8bmr1514592ilj.5.1707476478274; 
 Fri, 09 Feb 2024 03:01:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW0O4k65EE+1FatG8ycXJuwD1VowPdz11odf9NEagFmARgxGpbCD21Mfmk/8VuyNr+8dBUF6AZLLjHvS2RnD/fag68hFDfq42RRgREGy37wPSLFPPXjwRe/jwM4Ado2DyXOTTGBVe9xcvIFC/xEo0SIql2fdlkva82oeuSNoFf1xuF/RomHPb5ItBRg3sGJFLR88eXdwZwFMw==
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:17 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 53/61] target/riscv: use misa_mxl_max to populate isa string
 rather than TARGET_LONG_BITS
Date: Fri,  9 Feb 2024 20:58:05 +1000
Message-ID: <20240209105813.3590056-54-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd36.google.com
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

From: Conor Dooley <conor.dooley@microchip.com>

A cpu may not have the same xlen as the compile time target, and
misa_mxl_max is the source of truth for what the hart supports.

The conversion from misa_mxl_max to xlen already has one user, so
introduce a helper and use that to populate the isa string.

Link: https://lore.kernel.org/qemu-riscv/20240108-efa3f83dcd3997dc0af458d7@orel/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240124-swear-monthly-56c281f809a6@spud>
[ Changes by AF:
 - Convert to use RISCVCPUClass *mcc
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     |  1 +
 target/riscv/cpu.c     | 10 +++++++++-
 target/riscv/gdbstub.c |  2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 285a247368..9bc14056fa 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -511,6 +511,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
+int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(const char *optname);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 84902be070..7fc45660d7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -308,6 +308,11 @@ void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
     env->misa_ext_mask = env->misa_ext = ext;
 }
 
+int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
+{
+    return 16 << mcc->misa_mxl_max;
+}
+
 #ifndef CONFIG_USER_ONLY
 static uint8_t satp_mode_from_str(const char *satp_mode_str)
 {
@@ -2357,10 +2362,13 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
 
 char *riscv_isa_string(RISCVCPU *cpu)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     int i;
     const size_t maxlen = sizeof("rv128") + sizeof(riscv_single_letter_exts);
     char *isa_str = g_new(char, maxlen);
-    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
+    int xlen = riscv_cpu_max_xlen(mcc);
+    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", xlen);
+
     for (i = 0; i < sizeof(riscv_single_letter_exts) - 1; i++) {
         if (cpu->env.misa_ext & RV(riscv_single_letter_exts[i])) {
             *p++ = qemu_tolower(riscv_single_letter_exts[i]);
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 0ae0c47df1..ca9b71f7bb 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -221,7 +221,7 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
     CPURISCVState *env = &cpu->env;
     GString *s = g_string_new(NULL);
     riscv_csr_predicate_fn predicate;
-    int bitsize = 16 << mcc->misa_mxl_max;
+    int bitsize = riscv_cpu_max_xlen(mcc);
     int i;
 
 #if !defined(CONFIG_USER_ONLY)
-- 
2.43.0


