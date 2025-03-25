Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3686C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOI-0004EG-Fb; Tue, 25 Mar 2025 00:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO4-0003tB-0E
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:40 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO0-0005ty-M1
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:39 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so9161060a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878775; x=1743483575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=da9qCgJ+S1UaM0j+OYD82icAp+J1ucJQQo9Biij6cxI=;
 b=P5qbc44yqxpd4FwvDAY8ku4vCk+v0BahlK7LS9O15nkQd4cnklhgNOIJKJuFs+NxVt
 PhUNFyYPnKIeoF9W3jmM20NhR0BUNhRMjXm+yAfecazQ57uCtOvjTLHc4ObKCWB1PlPT
 bwd7qxzIT3PN4pKeRWEs0LfjN7XKdYp50tmtQzy0KZ2fKKI04NmBEGVIAC361X7c7luK
 H37Ld6O2Tmkv6+E3z/IvtZClbwOmg0vK0ityWfp/jP6TAVfQ70CFeebsaKnfAiUUwoU/
 3iMV5F/cWc8R9FEC2oecEcaSVgIvASbQk54T9xlGCKleyus1VT3km9N/0I2EqZUAA1SW
 MP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878775; x=1743483575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=da9qCgJ+S1UaM0j+OYD82icAp+J1ucJQQo9Biij6cxI=;
 b=E/uSAd6/gBBVnSu3UHe8kgt+8+NdKIzAGrhY3AlnswnJsN7QYhx0eepdkxZ4l+5I+I
 qTVsZAnkI26f62Ge3duKq2FnJYgv5xx+yVebSW9rO4V/SylnpMxrrTr/8ZCU/byH+ewc
 jOLIqB2solcZpUFqM3dLldjbYXjAVgAZA0ZGDSFOdTPsO9okNmUv9/Ril7b0cO6aRpC/
 5OhGdpuGCN08xy+79kTo3c6ggJu3F52k5VssotkLi4G2hYsxG63opm99WFMxCfxpqhOa
 h5b1GfnDgy7SUubExcR0CJ5UwsfLvhp6PbgmpSKv9AaNytULUfpdhvrEkVF4z3KsJQSP
 EvtQ==
X-Gm-Message-State: AOJu0Yx1mPDqifGeuveryQ83MBAIUc70CLrv/K1Iuv+nrrb8Wk0/PDQe
 gnJt+czCN+UMxAYjLsBpGufE7OF6MCua9xxSdvSbacBte3a/2jQ31kY2LHVroiqwXOFVBfafHBy
 4
X-Gm-Gg: ASbGncs/hRGdPRVJVnWPTXYVNkpJoT626Y7tqs9x7MxCS2fMTFCjtXdl4zt3T/A6Ikl
 eoCcx9aVydc4thr3qZaVFPvxbAFhTjhbvLyxym1vfl3Pmf19hbBh4OdTtVOGPGdQA8VIfurAxoa
 PfnR6c0lFN/AenRfdJRWQ1ZB2qRvl+xHzKTu9OeH40EU4VMaV8rK9e5FF2Yrp0d2QGdWDWF5C7M
 DTUbKlcexnLmXOzf+/wCEES0i8CXrLEdHW0nMWerIxgdAm1NPBPateBcGOmGCCg+FWUZsUOlOQM
 ckCdqQo+MCSBOUW21YHsL5kwQo9YsbGrxvFrjmckVIny
X-Google-Smtp-Source: AGHT+IEgjGxzJS/SsixkRPa7V7unRDt/oD82QlFwQaCLK26d+wtOW0DzMMqVormswycOEINYKmOvCQ==
X-Received: by 2002:a17:90b:4b8e:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-3030fe8bdf1mr32282657a91.14.1742878775136; 
 Mon, 24 Mar 2025 21:59:35 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 14/29] exec/cpu-all: transfer exec/cpu-common include to
 cpu.h headers
Date: Mon, 24 Mar 2025 21:58:59 -0700
Message-Id: <20250325045915.994760-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h  | 2 --
 include/exec/cpu_ldst.h | 1 +
 target/alpha/cpu.h      | 1 +
 target/arm/cpu.h        | 1 +
 target/avr/cpu.h        | 1 +
 target/hexagon/cpu.h    | 1 +
 target/hppa/cpu.h       | 1 +
 target/i386/cpu.h       | 1 +
 target/loongarch/cpu.h  | 1 +
 target/m68k/cpu.h       | 1 +
 target/microblaze/cpu.h | 1 +
 target/mips/cpu.h       | 1 +
 target/openrisc/cpu.h   | 1 +
 target/ppc/cpu.h        | 1 +
 target/riscv/cpu.h      | 1 +
 target/rx/cpu.h         | 1 +
 target/s390x/cpu.h      | 1 +
 target/sh4/cpu.h        | 1 +
 target/sparc/cpu.h      | 1 +
 target/tricore/cpu.h    | 1 +
 target/xtensa/cpu.h     | 1 +
 cpu-target.c            | 1 +
 22 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index da8f5dd10c5..b488e6b7c0b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -19,6 +19,4 @@
 #ifndef CPU_ALL_H
 #define CPU_ALL_H
 
-#include "exec/cpu-common.h"
-
 #endif /* CPU_ALL_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 82e67eff682..313100fcda1 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -66,6 +66,7 @@
 #error Can only include this header with TCG
 #endif
 
+#include "exec/cpu-common.h"
 #include "exec/cpu-ldst-common.h"
 #include "exec/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 42788a6a0bc..fb1d63527ef 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -21,6 +21,7 @@
 #define ALPHA_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 958a921490e..ee92476814c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -24,6 +24,7 @@
 #include "qemu/cpu-float.h"
 #include "hw/registerfields.h"
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 714c6821e2f..f56462912b9 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -22,6 +22,7 @@
 #define QEMU_AVR_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index f78c8f9c2a0..e4fc35b112d 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -21,6 +21,7 @@
 #include "fpu/softfloat-types.h"
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "hex_regs.h"
 #include "mmvec/mmvec.h"
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 986dc655fc1..5b6cd2ae7fe 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -21,6 +21,7 @@
 #define HPPA_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "system/memory.h"
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 64706bd6e5d..38ec99ee29c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -23,6 +23,7 @@
 #include "system/tcg.h"
 #include "cpu-qom.h"
 #include "kvm/hyperv-proto.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/memop.h"
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 1dba8ac6a7c..167989ca7fe 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -9,6 +9,7 @@
 #define LOONGARCH_CPU_H
 
 #include "qemu/int128.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 451644a05a3..5347fbe3975 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -21,6 +21,7 @@
 #ifndef M68K_CPU_H
 #define M68K_CPU_H
 
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d29681abed4..90d820b90c7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -21,6 +21,7 @@
 #define MICROBLAZE_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-interrupt.h"
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 29362498ec4..79f8041ced4 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -2,6 +2,7 @@
 #define MIPS_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index c153823b629..f16a070ef6c 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -21,6 +21,7 @@
 #define OPENRISC_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7489ba95648..aa5df47bdaf 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -22,6 +22,7 @@
 
 #include "qemu/int128.h"
 #include "qemu/cpu-float.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "cpu-qom.h"
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 556eda57e94..14a6779b4c1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -23,6 +23,7 @@
 #include "hw/core/cpu.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 5f2fcb66563..e2ec78835e4 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -23,6 +23,7 @@
 #include "hw/registerfields.h"
 #include "cpu-qom.h"
 
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 0a32ad4c613..83d01d5c4e1 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -27,6 +27,7 @@
 
 #include "cpu-qom.h"
 #include "cpu_models.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 18557d8c386..7581f5eecb7 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -21,6 +21,7 @@
 #define SH4_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 923836f47c8..5dc5dc49475 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -3,6 +3,7 @@
 
 #include "qemu/bswap.h"
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index cf9dbc6df8e..abb9cba136d 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "hw/registerfields.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "tricore-defs.h"
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 66846314786..c5d2042de14 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -30,6 +30,7 @@
 
 #include "cpu-qom.h"
 #include "qemu/cpu-float.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "hw/clock.h"
diff --git a/cpu-target.c b/cpu-target.c
index 587f24b34e5..52de33d50b0 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -23,6 +23,7 @@
 #include "qemu/qemu-print.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
+#include "exec/cpu-common.h"
 #include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/log.h"
-- 
2.39.5


