Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ECEC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 13:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDVG-0000tf-2x; Thu, 06 Jun 2024 09:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDVD-0000sr-GY
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:50:04 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDVB-0008Vc-UH
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:50:03 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7025c5e6b94so824803b3a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717681800; x=1718286600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usOqXbXkbJ9HZDlyGy80tWgPo2DcyM3jU9sVK9mHWJY=;
 b=V41fEu4tn9Frhsxr0S/sK000Saoo0jPdyip4YdbAWezn5tTZcaG+60GORd/g24QPXA
 9F9nOcQ95bRe3A6T1pgdGRDN5tcFS8hdhbls4dyxH57oZ9zbPBJpI7zfB0V8eJF4nUfy
 n+quNBcSvpJwxrAaaYj57UqnsEHfS1Kvsi9P0NMIEzXtM9nTmmNTyAv7v7SE11EoVRJ8
 kDa8rfI48jmPYh+k0Eq4Aq0YdA0J5pIUkzD5x2eG+C2cbw7XP5q9htsG/SePIYvVqEyj
 JMVctEmV3I9hM1L8Ns6QQ+tZqn13Cx73r2jGGAUNkJWEdzg3V2SWwljhymaS58JFfe7l
 M2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681800; x=1718286600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usOqXbXkbJ9HZDlyGy80tWgPo2DcyM3jU9sVK9mHWJY=;
 b=J8mPK2vzf0pm4vVB5P173TFpC3E+/QfgA3bOFh10YEB2mhzd9YORbobZjVzo5EPB5p
 ZGjkLEN9aYcktPXOeYoWOkgeMjuurOOBPeqh3F+kGQCMSZjybz5wxRZJolJvWRACaHMW
 lRNW/Fpsg94efik9TqW+tnA38k5sDvmRbBaaAEI6dbwy12QRspzgIe79RxMq11mWkiSX
 Nrc46qxyP0bMpvlIbsc39nuxuiFsWY4fEd+WBtcT7jXM6tkIsZKdC3WR/KpuWBl3mjEE
 jKAaU9mGrKILbV+wVgIkgjlRpwaChEOB6GSNnduDKVgDYE36mn5LrH2f0AmaXJ0sLJqq
 Z6Aw==
X-Gm-Message-State: AOJu0YzXebb082C6IAc7S85p0yyM/8077ND0PGpG+/f4y2/OQAE4x2yB
 5oj0FAu+ATBVJ1NtH+YkirUe2gOP6xvPGj0F6Qq33lb96dlA/eowqP/anruA2aP1zCGF7eRrbuQ
 8ehYfmYXXtQE13IH1uOtxolfoEsbvtuUFvarQoNLQEid9DTdjAEuW+7C2tkUoTl4s0He5eigX2j
 n+w/HrfbwbxPL5cuSj2xQzx3qwewtpVUZc91Q=
X-Google-Smtp-Source: AGHT+IFpm4pG3TsS7kmwb10xDXEYL9i/Udy7tN3biW8ZeVQgclq0r3hr7Ert7f6b4kX6A+6mE2i3jg==
X-Received: by 2002:a05:6a00:298c:b0:6ec:d76b:6fac with SMTP id
 d2e1a72fcca58-703e594ad8amr6043039b3a.12.1717681799964; 
 Thu, 06 Jun 2024 06:49:59 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd50bc86sm1150919b3a.175.2024.06.06.06.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:49:59 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 6/6] target/riscv: Support the version for ss1p13
Date: Thu,  6 Jun 2024 21:54:54 +0800
Message-Id: <20240606135454.119186-7-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606135454.119186-1-fea.wang@sifive.com>
References: <20240606135454.119186-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add RISC-V privilege 1.13 support.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c         | 6 +++++-
 target/riscv/tcg/tcg-cpu.c | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fd0f09c468..4760cb2cc1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1779,7 +1779,9 @@ static int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
 
-    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
+    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
+        priv_version = PRIV_VERSION_1_13_0;
+    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
         priv_version = PRIV_VERSION_1_12_0;
     } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
         priv_version = PRIV_VERSION_1_11_0;
@@ -1799,6 +1801,8 @@ const char *priv_spec_to_str(int priv_version)
         return PRIV_VER_1_11_0_STR;
     case PRIV_VERSION_1_12_0:
         return PRIV_VER_1_12_0_STR;
+    case PRIV_VERSION_1_13_0:
+        return PRIV_VER_1_13_0_STR;
     default:
         return NULL;
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4c6141f947..eb6f7b9d12 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -318,6 +318,10 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_12 = true;
     }
 
+    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
+        cpu->cfg.has_priv_1_13 = true;
+    }
+
     /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-- 
2.34.1


