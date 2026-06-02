Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF66CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULGy-0000fC-KM; Tue, 02 Jun 2026 05:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wULGi-0000Xx-AY
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:18:44 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wULGa-0007WM-3V
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:18:35 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-306f36df4feso1477421eec.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780391908; x=1780996708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2E86yNzatxnQca835DMjkBt+7nm3dHtMLB7OKJHEifQ=;
 b=jgfRjBTnpFJELqZqBk0g6l6cZbMWyZH/fpdesIQT3bw0spX+mx/BBPtiQmgvO7erli
 2ZnnukxbgZVVAfRXT/tn9iQatcJWKiFdwylMTP8MgKSoPKrluKrPLPnQ7Awh6GEBNwLQ
 Rwhg76F17E+/6rbjDj0joI8xpeBrdodSJ3vKOxuDrI3VY9kXiX3yu/XX2E2zYccLfkIj
 2AGnqSs5E5bZ0nrMcbePExYzXApriPolLZonmSx6yjxtD1TAOm+/a2HePzRVlD2kox7l
 +o6WUpVqDo36JVqk9N51TtpBsor24bsdDx7cElo2qQcO5+YKFtS7oX0NJfPXqsHONJFH
 qtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391908; x=1780996708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2E86yNzatxnQca835DMjkBt+7nm3dHtMLB7OKJHEifQ=;
 b=AHGWEM1B47JHhCoZp8QytoQPScu4u4tYAcTvtpI8pja13eNHrmKxSrQz/yBFiiS5UG
 0mttZiatIEftITpjA0P4e0HNdFdlBKb3/73flGcMBsHQ6yIGRWX2QQN0HuzbOg06Vov+
 4Uwd3Tig56M1bz3LxbPUg3S9hmxatPQPLuhZElTaCM+r6gxPwbMs+vFyDKPwZkKrfSan
 OHxcDFzO5644i+TXeHfO+1teNuADYN9QHswkib0L+ZoSMhWkeObCaFoSCMyQK2CX62q1
 f51oeAcgIQoADX6yKJpBaD1LKMyAbqKJH7H6eCcqDnqVwSZPSY2LnHjvkY4FnHHe0ePM
 n4FA==
X-Gm-Message-State: AOJu0Yyx9BMDRzlCOmJVckMoCHlm72gBtciqBJGSaERsRTbHfgsygWgM
 RYXQoYDRntRwgmPs16q15OKdaMAnPQHcYBVna2zII6ZqslDWo+bR8zbs4Az9kO/K8JWGhw==
X-Gm-Gg: Acq92OHj8U7H7qE7yy9AiVfaReo5qZnr+xfPTo4LtNgSmr4UDu/fdS0g5k0pV6GyRdc
 2Fgpx5r5w6fUth+USwtPgAHDuRw9l1rFFwGPmBlvmQIZCOOEA3rcQjyyau7lHhEylkT53ydGOuA
 5QodXgeJelRz6TaLX2KpzBIVGIhuGvaAXY0tXbGGp1H6mGN3OvC3eKMZdcyKmj6wFqmbbLozisM
 uiqc1GM/WHJNIN+sBAP27udbZ7+Jc6Mi2YfDV9yDx1KS5i8absOHN1q0C5P446eVT06l1TBjT8Q
 4bFI4bsCuDGJfL092haY5ycj7dzNk6n7C3LZb6ENLhfqujwLidbHqIVNLCV+hmGYYidJ+dwFvjK
 WCEeGdav8F/iEZxnfIzhVLqzG7FSYTmBMK4+QbekXubdZEyrdmLmYfo5HU+dKEw+ulSuj3HE//6
 JIssgVgez1o+YPiyIp4JcoZGrgMA/txbylqv2bwdsfd7Y+5swqWEb5O/pgfYzbKfPgD3owzRG7M
 9or9Tp7gwCqHD3Pug8YuBg8dxo=
X-Received: by 2002:a05:7300:3b04:b0:2c1:67e1:61a9 with SMTP id
 5a478bee46e88-30734b66b7dmr1396766eec.13.1780391908530; 
 Tue, 02 Jun 2026 02:18:28 -0700 (PDT)
Received: from openkylin..
 (ec2-54-176-108-193.us-west-1.compute.amazonaws.com. [54.176.108.193])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c3121sm11419146eec.5.2026.06.02.02.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:18:26 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 alex.bennee@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 philmd@linaro.org, Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v3 2/6] target/riscv: move fflags helpers to common code
Date: Tue,  2 Jun 2026 17:17:49 +0800
Message-ID: <20260602091753.3209261-3-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
References: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

riscv_cpu_get_fflags() and riscv_cpu_set_fflags() are used by CSR/FCSR
handling and operate on architectural CPU state rather than translated
floating-point instructions.

Move them out of fpu_helper.c so fpu_helper.c can be built only when TCG
is enabled.

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/cpu.h        |  3 ---
 target/riscv/cpu_helper.c | 28 ++++++++++++++++++++++++++++
 target/riscv/fpu_helper.c | 27 ---------------------------
 target/riscv/internals.h  |  3 +++
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7d79c7a5a7..2273567139 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -666,9 +666,6 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       RISCVException exception,
                                       uintptr_t pc);
 
-target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
-void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
-
 #ifndef CONFIG_USER_ONLY
 void cpu_set_exception_base(int vp_index, target_ulong address);
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 17305e1bb7..678c106ae5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "fpu/softfloat.h"
 #include "internals.h"
 #include "pmu.h"
 #include "exec/cputlb.h"
@@ -38,6 +39,33 @@
 #include "pmp.h"
 #include "qemu/plugin.h"
 
+target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
+{
+    int soft = get_float_exception_flags(&env->fp_status);
+    target_ulong hard = 0;
+
+    hard |= (soft & float_flag_inexact) ? FPEXC_NX : 0;
+    hard |= (soft & float_flag_underflow) ? FPEXC_UF : 0;
+    hard |= (soft & float_flag_overflow) ? FPEXC_OF : 0;
+    hard |= (soft & float_flag_divbyzero) ? FPEXC_DZ : 0;
+    hard |= (soft & float_flag_invalid) ? FPEXC_NV : 0;
+
+    return hard;
+}
+
+void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
+{
+    int soft = 0;
+
+    soft |= (hard & FPEXC_NX) ? float_flag_inexact : 0;
+    soft |= (hard & FPEXC_UF) ? float_flag_underflow : 0;
+    soft |= (hard & FPEXC_OF) ? float_flag_overflow : 0;
+    soft |= (hard & FPEXC_DZ) ? float_flag_divbyzero : 0;
+    soft |= (hard & FPEXC_NV) ? float_flag_invalid : 0;
+
+    set_float_exception_flags(soft, &env->fp_status);
+}
+
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index af40561b31..eec6328281 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -23,33 +23,6 @@
 #include "fpu/softfloat.h"
 #include "internals.h"
 
-target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
-{
-    int soft = get_float_exception_flags(&env->fp_status);
-    target_ulong hard = 0;
-
-    hard |= (soft & float_flag_inexact) ? FPEXC_NX : 0;
-    hard |= (soft & float_flag_underflow) ? FPEXC_UF : 0;
-    hard |= (soft & float_flag_overflow) ? FPEXC_OF : 0;
-    hard |= (soft & float_flag_divbyzero) ? FPEXC_DZ : 0;
-    hard |= (soft & float_flag_invalid) ? FPEXC_NV : 0;
-
-    return hard;
-}
-
-void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
-{
-    int soft = 0;
-
-    soft |= (hard & FPEXC_NX) ? float_flag_inexact : 0;
-    soft |= (hard & FPEXC_UF) ? float_flag_underflow : 0;
-    soft |= (hard & FPEXC_OF) ? float_flag_overflow : 0;
-    soft |= (hard & FPEXC_DZ) ? float_flag_divbyzero : 0;
-    soft |= (hard & FPEXC_NV) ? float_flag_invalid : 0;
-
-    set_float_exception_flags(soft, &env->fp_status);
-}
-
 void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
 {
     int softrm;
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 4e1bb8849a..7f28190c29 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -193,6 +193,9 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
 bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
+target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
+void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong val);
+
 void riscv_cpu_ext_user_opts_init(void);
 void riscv_cpu_cfg_ext_add_user_opt(uint32_t ext_offset, bool value);
 void riscv_cpu_misa_ext_add_user_opt(uint32_t bit, bool value);
-- 
2.43.0


