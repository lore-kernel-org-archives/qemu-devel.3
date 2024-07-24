Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315FEC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 13:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWbiN-0006U5-4B; Wed, 24 Jul 2024 09:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWbiI-0006Sw-Bg
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 09:07:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWbiG-0006cd-BS
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 09:07:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso5122015e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 06:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721826442; x=1722431242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UtsY1bvw8cza1TfxQVby+OILiLbukpOWIF0kGG2aS/I=;
 b=cYdGDtCcKAfZkZmOCzA3Jj5fhfAJzXWWlhKdMz5rS/EhwWx9GUTALM/W6fXQwN65bL
 SXstTzyx12crh3M16HmYHx41cdPwTsxdADOyJ+80TztyauTeWWKJD2nsXCwP7F8rpcAc
 WJdJvfigYYjq4bePLe0BI07yJ26BBtCi8rPuAHRjXjOyZ/2SYlnqu/LsipVVOO2uGJwS
 lyal732tGdMK6KpS8zzH6G08w09BiqnggJWTLwth24ytmwplMjZqmoPCJcZ/+HS+Zs5h
 2mirN2URwiw8A1eLj7ElZOdWQmHqTS5noIGucjxLJ32L+gNyIQHtAOFDBPNvyV+/rujF
 vTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721826442; x=1722431242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UtsY1bvw8cza1TfxQVby+OILiLbukpOWIF0kGG2aS/I=;
 b=GgRT9ZJczNXzO+0nyDm7qW/fZbQ7LOufp4AdlDCgV/fhPFf772LceVRDOKurhkwVal
 ypPL8/+CDPB6OZlbFsuGejvzfaE7TuFDZMYdqu7sWzoJj52BIkQVD/QoMVZc5arVHfE4
 JOEbRwweP0S1b4B1q5njHU/XjFSnX8be+b3dY5T43Vm7k1WdihjNolDO4Fta8+vIL2xN
 PC6JZ72eyUqWazR+cXWcp6cdUhe80yiSIY/nCNQohC1RTd5jlhyPBnFl1dNwmpWUemST
 X77iM+sYy1y3IVMMRhqhA+tzUG5N6OKzlKRICv0eeRvd7IWP8YtLtKnfAC7+GVC/rEjw
 zrPg==
X-Gm-Message-State: AOJu0YwsGASQNDj2yBKGC2Gs8y59YmgvB3+z0DxJuZC59z5gONdEsuBs
 eYaE0tAYQG/kYct0+raW4gGrWReAWzUIWHiMjPMRRIYY8PKgG3l2yAJlpOcE9XgkOaQ0QvPS9Up
 C
X-Google-Smtp-Source: AGHT+IEqgKVH1y9yUO4WI4o72OCI6xYvXOOky0qFlrlGvFTd+zBXA2w7MY2tkYWjnPS1M1U+VDiEKQ==
X-Received: by 2002:a05:600c:138b:b0:426:5b19:d2b3 with SMTP id
 5b1f17b1804b1-427f9a20aecmr14565075e9.14.1721826441516; 
 Wed, 24 Jul 2024 06:07:21 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93e6021sm30000985e9.35.2024.07.24.06.07.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jul 2024 06:07:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, devel@lists.libvirt.org,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1] target/riscv: Remove the deprecated 'any' CPU type
Date: Wed, 24 Jul 2024 15:07:17 +0200
Message-ID: <20240724130717.95629-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The 'any' CPU is deprecated since commit f57d5f8004b
("target/riscv: deprecate the 'any' CPU type"). Users
are better off using the default CPUs or the 'max' CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       | 13 -------------
 docs/about/removed-features.rst |  8 ++++++++
 target/riscv/cpu-qom.h          |  1 -
 target/riscv/cpu.c              | 28 ----------------------------
 4 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 88f0f037865..0ac49b15b44 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -347,19 +347,6 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
 which the 9p ``proxy`` backend currently suffers. However as of to date nobody
 has indicated plans for such kind of reimplementation unfortunately.
 
-RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The 'any' CPU type was introduced back in 2018 and has been around since the
-initial RISC-V QEMU port. Its usage has always been unclear: users don't know
-what to expect from a CPU called 'any', and in fact the CPU does not do anything
-special that isn't already done by the default CPUs rv32/rv64.
-
-After the introduction of the 'max' CPU type, RISC-V now has a good coverage
-of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature complete
-CPU for both 32 and 64 bit builds. Users are then discouraged to use the 'any'
-CPU type starting in 8.2.
-
 RISC-V CPU properties which start with capital 'Z' (since 8.2)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index fc7b28e6373..f3e9474a73e 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -850,6 +850,14 @@ The RISC-V no MMU cpus have been removed. The two CPUs: ``rv32imacu-nommu`` and
 ``rv64imacu-nommu`` can no longer be used. Instead the MMU status can be specified
 via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
 
+RISC-V 'any' CPU type ``-cpu any`` (removed in 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The 'any' CPU type was introduced back in 2018 and was around since the
+initial RISC-V QEMU port. Its usage was always been unclear: users don't know
+what to expect from a CPU called 'any', and in fact the CPU does not do anything
+special that isn't already done by the default CPUs rv32/rv64.
+
 ``compat`` property of server class POWER CPUs (removed in 6.0)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 3670cfe6d9a..4464c0fd7a3 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -29,7 +29,6 @@
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
 #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
 
-#define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
 #define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a90808a3bac..4bda754b013 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -438,27 +438,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
-static void riscv_any_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj),
-        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
-        VM_1_10_SV32 : VM_1_10_SV57);
-#endif
-
-    env->priv_ver = PRIV_VERSION_LATEST;
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-}
-
 static void riscv_max_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -1161,11 +1140,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_ANY) != NULL) {
-        warn_report("The 'any' CPU is deprecated and will be "
-                    "removed in the future.");
-    }
-
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -2952,7 +2926,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .abstract = true,
     },
 #if defined(TARGET_RISCV32)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV32,  riscv_any_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
@@ -2962,7 +2935,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
 #elif defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV64,  riscv_any_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
-- 
2.45.2


