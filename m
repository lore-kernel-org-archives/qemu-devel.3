Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29208606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 04:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=NRvgrwPu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMdsO-0002Fz-FN; Fri, 30 Oct 2026 00:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdsL-0002FX-QU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:05:57 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdsJ-0004pY-La
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:05:57 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-363cd582f45so31307eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793333154; x=1793937954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xSgCeOGytrY3ihqWjb3zCK/EAyb5eBljfe57gKZmKdo=;
 b=NRvgrwPu4hrHYnBVHyEdgiENYJhPJxF8DMQM5FUxoKaPPijTXSpYvCb7DWrLzOBgib
 N1m389YLneiOA1QP3zW0MfnyaFZn4BK/9HOFdJIo8g8UpD9tqMtM6S+FnRRHLZhnNqMA
 eTGTWAr/KpzJS5+9balNqbeB4MburPc1Kc19ACweErtOWF5kRIsLyzYhhUeGRvTa8CKJ
 pmRhXr3PmZTNy0cSg5prSyHZS5oj1zDdT34AKKwRUCd05Nwsv+klbz3zqaJ2hdtNh3il
 wvG+r8J/dHh/hSvNXy/vCo1zdJz3C00GzzLfTmhs3OKhTnZPxOTQyYFYh/qvNCw0gy08
 yW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793333154; x=1793937954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xSgCeOGytrY3ihqWjb3zCK/EAyb5eBljfe57gKZmKdo=;
 b=u2l3C1gPsONkbfISjGLq/JzOWPPSYFG00w9mV5Ws+YdFBLfaV+cQqOlpNUKedrrH/w
 uRtlXrf5uV26WPq6d63hX+a0YDjhhE4MJXrD8+IOMT8H0cG6VTZU515F7WnoAxHfBeiR
 456Hpc1RDljlR5sjGCRX6YGWqII8dv5zAIF6x/5dlbp/bW7vPcAPWVWyXFCZHVtzQhLO
 6lWfBEiuoqhGA3rocRsiJ2FNcvkbSJ3BMAeSPOs+XUssL2jrlvcdC1lr0esM8dwEaGRJ
 mp0Iw3xzRkGCXAIt0RocS6anRKbRcJNeQqwlkexGbB7bDHLEnf2uE08VN9CKUVxYdgMI
 m5Iw==
X-Gm-Message-State: AFq9FYIguS1xWJcYfgBmL+YReSN/GKBwMndbgFWcAeoTjykwkb3gcB7s
 fOFcZ5lvPrSRTwdYG6zjFJ6gFK7Dq7HamYeGvFUsGjk72EtvSWImTmZrsfe5RU8Uh18dgIDXdNb
 U7kow3V4=
X-Gm-Gg: AYBFou3xX/15Zma1Tbotu53xFLQ+ZBDP1WqHw4Wq6WDy//wWoWGQd5tdYsR81WgxWy9
 e7qA4NNnpaQn67P+fDCS4TKz23m6pQwmqMwoSRreAwXJL0vXp4GtjrePK8ak5ZT9v+3by3phU9a
 pR8/sgZPUhrYNR4BlDt+AKMJkHeUbpOq6YcI368adUiBBmGgAidCWvNANH6XkJy5zsAEDSIy2/q
 U2XznZHfMIca3gX7xTM/Xhdgyi8u3JRrum6ZlqxYDOzMSR2aQ90+wJw0xFLPOKY9NVnA8PVFVeS
 kzSQlSTTVOm2LvBmN2qz7+KTVE6UzcZdlagXN9fdjwyJLyfPQy/EdH+cv2yCkenuBSgM1IlEbY2
 moJXwRI2XCafuRvxecfPXoho8fBDAmGoIadm64mrVBswmwuatVvwDwHePbZ0SDkkMT0VQQDwEuz
 JHVokqs0uybQox/WOdK+Xxm5cVjZ2TZzb10/gz7cd3n5VVhJTtfkXn4PIjjGR7WVgvMutrMZn0T
 3lp9kNeynZfP7mxHEKhiN91r1q/R2BA2Nht6Ib8Hq/9ITUFvCt0wHGQH68rn3CeTGbv1UrDpnrU
 w9OP/OjaZjgcXKBlb55GwlnWm5ssfMhGIdsR7k16J1MrD27ZDDdeuuFUuSyAiRfjJiQ/MuEwnY2
 vWpI=
X-Received: by 2002:a05:7300:fb14:b0:351:7883:bf47 with SMTP id
 5a478bee46e88-36a41daec1emr2807623eec.0.1793333154039; 
 Thu, 29 Oct 2026 21:05:54 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1easm2957687eec.5.2026.10.29.21.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 21:05:53 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Michael Ellerman <mpe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Zhao Liu <zhao1.liu@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v3 5/9] target/riscv: Add Tenstorrent Real-time CPU
Date: Fri, 30 Oct 2026 14:05:11 +1000
Message-ID: <20261030040516.853444-6-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030040516.853444-1-portias@oss.tenstorrent.com>
References: <20261030040516.853444-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=portias@tenstorrent.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RCPU is a high-performance 32-bit RISC-V embedded processor featuring
a 6-stage, dual-issue superscalar pipeline, with tightly-coupled memories
(TCMs), advanced interrupt controller (CLIC), and comprehensive
debug/trace capabilities. It is designed for real-time, system
management, and safety-critical applications requiring deterministic
execution and low interrupt latency. See the Atlantis Datasheet, section
2.2 for more information [1].

The Atlantis SoC includes an RCPU used for boot, low-level control, and
ongoing system management [1]. This adds a cpu entry for the RCPU
and implementation specific CSRs. The CSRs are stubbed to allow code to
run without exceptions but does not implement their functionality.

[1] https://github.com/tenstorrent/atlantis-soc-docs/blob/main/data_sheet/atl_soc_data_sheet.pdf

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 MAINTAINERS                  |  1 +
 target/riscv/cpu-qom.h       |  1 +
 target/riscv/cpu.c           | 33 +++++++++++++++++++
 target/riscv/tcg/csr.h       |  3 ++
 target/riscv/tcg/meson.build |  1 +
 target/riscv/tcg/tt_csr.c    | 63 ++++++++++++++++++++++++++++++++++++
 6 files changed, 102 insertions(+)
 create mode 100644 target/riscv/tcg/tt_csr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ca1751e30..cfbb322da7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1850,6 +1850,7 @@ R: Portia Stephens <portias@oss.tenstorrent.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/tt_*.rst
+F: target/riscv/tcg/tt_*.c
 F: hw/misc/tt_*.c
 F: hw/riscv/tt_*.c
 F: include/hw/misc/tt_*.h
diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 61234842e3..72570ed47e 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -57,6 +57,7 @@
 #define TYPE_RISCV_CPU_THEAD_C908V      RISCV_CPU_TYPE_NAME("thead-c908v")
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
+#define TYPE_RISCV_CPU_TT_RCPU          RISCV_CPU_TYPE_NAME("tt-rcpu")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a0529fbda..bcdac7c82f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3480,6 +3480,39 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp_regions = 8
     ),
 
+#if defined(TARGET_RISCV32) || \
+    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_RCPU, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI | RVM | RVA | RVB | RVC | RVD | RVF | RVU,
+        .priv_spec = PRIV_VERSION_1_13_0,
+
+        .cfg.mmu = false,
+        .cfg.ext_zbc = true,
+
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_zca = true,
+        .cfg.ext_zcb = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zihpm = true,
+        .cfg.ext_zicond = true,
+        .cfg.pmp = true,
+        /*
+         * marchid for the Atlantis RCPU. The RCPU is based off the Rondel CPU.
+         * Future Rondel cores may have a different marchid
+         */
+        .cfg.marchid = 0x80000171,
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+        .custom_csrs = tt_csr_list,
+#endif
+    ),
+#endif
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
diff --git a/target/riscv/tcg/csr.h b/target/riscv/tcg/csr.h
index 53ba3b4a4d..4bc55b70d6 100644
--- a/target/riscv/tcg/csr.h
+++ b/target/riscv/tcg/csr.h
@@ -87,6 +87,9 @@ extern const RISCVCSR th_csr_list[];
 /* Implemented in mips_csr.c */
 extern const RISCVCSR mips_csr_list[];
 
+/* In tt_csr.c */
+extern const RISCVCSR tt_csr_list[];
+
 /* PMP CSRs, defined in pmp.c */
 void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
                       target_ulong val);
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 86805b30cb..77357475c3 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -25,6 +25,7 @@ riscv_system_ss.add(files(
   'pmp.c',
   'pmu.c',
   'th_csr.c',
+  'tt_csr.c',
 ))
 
 
diff --git a/target/riscv/tcg/tt_csr.c b/target/riscv/tcg/tt_csr.c
new file mode 100644
index 0000000000..6ab9117486
--- /dev/null
+++ b/target/riscv/tcg/tt_csr.c
@@ -0,0 +1,63 @@
+/*
+ * Tenstorrent CPU implementation specifics.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Tenstorrent
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "target/riscv/tcg/csr.h"
+
+/* RCPU custom CSRs */
+#define RCPU_CSR_MICACHE          0x7c0
+#define RCPU_CSR_MDCACHE          0x7c1
+#define RCPU_CSR_MITCMCR          0x7c5
+#define RCPU_CSR_MDTCMCR          0x7c6
+#define RCPU_CSR_MHCR             0x7c7
+#define RCPU_CSR_MEXINFO          0x7ca
+#define RCPU_CSR_MNMIE            0xbc6
+
+#define RCPU_MARCH_ID             0x80000171
+
+/* predicate for an RCPU core */
+static RISCVException rcpu(CPURISCVState *env, int csrno)
+{
+    if (env_archcpu(env)->cfg.marchid != RCPU_MARCH_ID) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_zero(CPURISCVState *env, int csrno,
+                                target_ulong *val)
+{
+    *val = 0;
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_none(CPURISCVState *env, int csrno,
+                                 target_ulong val, uintptr_t ra)
+{
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR tt_csr_list[] = {
+    { .csrno = RCPU_CSR_MICACHE,
+      .csr_ops = { "micache", rcpu, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MDCACHE,
+      .csr_ops = { "mdcache", rcpu, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MITCMCR,
+      .csr_ops = { "mitcmcr", rcpu, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MDTCMCR,
+      .csr_ops = { "mdtcmcr", rcpu, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MHCR,
+      .csr_ops = { "mhcr", rcpu, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MEXINFO,
+      .csr_ops = { "mexinfo", rcpu, read_zero, write_none} },
+    { .csrno = RCPU_CSR_MNMIE,
+       .csr_ops = { "mnmie", rcpu, read_zero, write_none} },
+    { },
+};
-- 
2.43.0


