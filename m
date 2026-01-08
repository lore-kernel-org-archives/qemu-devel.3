Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4DFD1D475
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlI-0000uR-VH; Thu, 08 Jan 2026 10:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlH-0000t6-5C
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:19 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlF-0003Mx-Ar
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:18 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7e2762ad850so2802204b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885435; x=1768490235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzZWMHTjiXjVIbO6WLfyyL8tkTs0pi+ESIBnuSvkgSI=;
 b=OkNt8lIeNKAq1bJSsB0BQN21MNDjpx35d7YHq6QjibqWdVDbfYB2iYjqnEMq1GXNaI
 wUD8TSv2gweEn7bUpdxCvBrttYYWK7Q/TjdjlfISGXZJZ6tQ96RONziwl9FGgPnR91Yx
 5JE7vN9PMbaifNjY4FYugpW9KyPuM3LnE68mps4Cb0SJoAn5ZLvfBYPtIJtCNf9ALSXj
 3iGzMdtc3JBaD7ageaCFSPhcShkF4x32hT6zpTBMNGa3NuqqieLUtJAKTAaBwhxN5kQS
 zVR56NlyOhkMvWF8r7AyMIn9Zzban+RcwLM0ii/4IMFnjT03ppBGdKfm6vPBU5pCgvXP
 92EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885435; x=1768490235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CzZWMHTjiXjVIbO6WLfyyL8tkTs0pi+ESIBnuSvkgSI=;
 b=NWMLkY3M/f/ceK1vsy4BVePGrGLWWsbT80H9UkSwXnRN54E2Y9K8rAlZjPUwG0dLLT
 IGl3pLnOfGjTZpLM+BGIOZFYRQByZURlCa22YpHNnpWIea+E5tqaQOcriD/fq00stvf0
 UZFv5PHuugJEAQ/za1nikFkcuxirTA2U1faYIwQmdMKnDopNQp+z6HMb4Hldsj8qynZ4
 0/PVbnHL8l7uUgqdTOJvz8KyTnwxQHsK8bRbgbQrJJEu1dmtZMb7iyzGOwlg4szoTmhE
 QU3QbAEsNpSTrxoTVrOg8gRXapmg2KEBujvSbFIwlOSPPmpSdFOTOCNgfAOQREUBFK9S
 72oQ==
X-Gm-Message-State: AOJu0YyUn7c8SNg3F+GeAMO/FtbBtd3cYv7DFP9/cneGiNIWmhuHh8y1
 MYdjpHHxZDTJee7l3NS5jkfbDEVontKZ+cmiO+ZrdDe+zs5U20elNWgrPqCOxcIPN2NsFe+DoJV
 bhuFCM6YicE8OZsXwCjrAPAl83GXbBvgkusu5U/FQMMmfNLQ5FzzrsNCuiLD0YwKvqQwhBkiExc
 hgUufXsPtBHMTKl7NQQhPjoRoilhY+XPPihHeftRw=
X-Gm-Gg: AY/fxX7teupT0CqiIOvXOVzWSWZhILJM0JE/QI+Vuv4wKUXkltaGmIu392k6Pk4qHLF
 WfhrGNCL3EnTjHQ8VfBCqxtBinVd2zth/3Vmy7VzPaJc7jwlPmPhmzJi8LQRv/sQSlhBY2IW7R0
 27Wj1LieiYs79+SRPr+b7lix2VYf1AWox+QJbUi4HzFAOciPXUTf/Y9YVtWSWG3O3aNLFQ0tPdA
 2zL0GzkkZDC1fu6NCkbfjg7MHRg1U2y86/9Y39Eb9bxzX/8Eo0QInC+Cy11/8ytXy0lhzJv0/G+
 L41Gj0nRZGUe/6AG9w6XhesCQ+LSQrZtl1sqZjxa5dr/C4M6vN48WeTGpRHamzeiq9ao9NVNLhU
 h01gqd5w2zSBkBAabMZtcH2gMISabJ6rlqtuzGC4FcIL+iiStovxLdXpn/pj3iEoUuXWL3ZaHur
 G5HEiVvQhGkBA6GHWJkWoG7GV+1GDnzvTzP4bUV5rlw6Z3TRaBL/kIOyRSdfpEQ7qEQA==
X-Google-Smtp-Source: AGHT+IEiPeY5Zjyrh76G39V1GI1DlZa2t5SRbG9kggg5QX2iUdOzdwPIrMjfQ/yQXzX5LSc2Zvd4nA==
X-Received: by 2002:a05:6a00:1ca2:b0:81d:8d00:76d6 with SMTP id
 d2e1a72fcca58-81d8d0079e1mr1008228b3a.59.1767885435109; 
 Thu, 08 Jan 2026 07:17:15 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:14 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 06/18] target/riscv: Add cfg properity for Zvfofp8min extension
Date: Thu,  8 Jan 2026 23:16:37 +0800
Message-ID: <20260108151650.16329-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

According to the ISA spec of Zvfofp8min extension,

"The Zvfofp8min extension requires on the Zve32f extension."

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 8 ++++++++
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 target/riscv/vector_helper.c      | 3 ++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8eab992154..b4b10b52d8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -193,6 +193,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
@@ -778,6 +779,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     set_default_nan_mode(1, &env->fp_status);
     /* Default NaN value: sign bit clear, frac msb set */
     set_float_default_nan_pattern(0b01000000, &env->fp_status);
+    /*
+     * RISC-V Zvfofp8min extension requires:
+     * - Same canonical NaN (0x7F) for both E4M3 and E5M2 formats
+     * - E5M2 format does not generate signaling NaNs (all NaNs are quiet)
+     */
+    set_ocp_fp8_same_canonical_nan(true, &env->fp_status);
+    set_ocp_fp8e5m2_no_signal_nan(true, &env->fp_status);
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 3696f02ee0..59302894af 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfofp8min)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 378b298886..ba89436f13 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -710,6 +710,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfofp8min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp8min extension depends on Zve32f extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
         error_setg(errp, "Zvfh extensions requires Zfhmin extension");
         return;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ec0ea4c143..ee5a1e595b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -38,7 +38,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     int xlen = riscv_cpu_xlen(env);
     target_ulong reserved = 0;
 
-    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
+    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
+        riscv_cpu_cfg(env)->ext_zvfofp8min) {
         reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     } else {
-- 
2.43.7


