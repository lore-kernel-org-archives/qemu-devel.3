Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D1FD66BB2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 21:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVyxQ-0000C1-VB; Wed, 17 Dec 2025 16:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vVyxM-00007M-MO
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:21:12 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vVyxL-0004dq-0j
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:21:12 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so7097583b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 13:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766006469; x=1766611269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uL2mCK6rnb99hwd+Wqz4LI6bREO75gA3FJH4GnyvXvQ=;
 b=blbz8FkqBdFUHzFdtzUlxBkAAGig06krgmO2BcQOGDQBsBChagwg61w9oTDHJffOkY
 x7q/o74lIrhbvmdYWTpUeRuzhXAGea836f2MzfC5i3hg+TVLVXi1W+o0XrrSr4svHpun
 hL+JTSv90oscokIbJoiNZuXOby0r+rCC7zYycwTzSxEUAnBPA3+HtqfSwRESPckDiV9H
 Dh4ZprX2TII+8nQ6rzCnwFU4lo6J13Cr7qYAc8LUfWSTFcSFRQkzgPe9mh7K94v2SoMb
 190Ob67//TKfL4jQxedKFWpi5Oe+xm4NkEnka0kDmJ5WjGEQvpMF4K1sLldDw9NO2ja6
 A9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766006469; x=1766611269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uL2mCK6rnb99hwd+Wqz4LI6bREO75gA3FJH4GnyvXvQ=;
 b=BvGDKsjctHgSHX1QoUFqww4rjoTJlDqYZbXtoBRGrX0sUBCUZBMklWJVaKB/Nls/U3
 nTGK4eg/39lw7LMjuHWpwJi1+D8Lc6zRuPk248fu7r8fS/VkH9xWKce0ignW0yDeY4Wt
 K85ZyE7WkTmywJES8/zawkPf2cZ39wvYMfqIYkQXDG2RKt2zI9TSu6OxWjHRyzdBBx2F
 G/TMKlbqYHlN1YYdYfSmOZMQ+Ge/2r64v/dJ7J7DZDVln3QIBF7eEuZTmJJhF/HlUb49
 gV3Cws6A55o9zuYp9fAxCTCqrClNxd/DoSgJrwa3Y4EsEu+dXlxn3LgCn0Ef5rt1RwEF
 N9dA==
X-Gm-Message-State: AOJu0YweRkEQ291T5lDw3h+WVJMZqx6aOD8p5jdy9E27offnHyZcWHIa
 ncgwmyk0EfUbx7kiQvI8dMjbR1AH1u8zlXdypvkWKsl7DtAvRzSs/XQfe38AztfvVAsXvMDH2gJ
 0d9gL
X-Gm-Gg: AY/fxX7njvjtf5LREzMwQ6rKgvSUWitBXM2gRXiyQdJIpHhFQ+BdrmQLRZaf+3ndWlH
 Ss/R12Cr2YLuEMj0sw9C6Zou/oy2pPVMbeqn4RN+I3OIYgvov1gff8BNtT+iUY3o4/fdrVwKwnn
 dUiCAfF2AM/h2Zb4/CtpfO2u5qi9Uzk1A+kAeN3MWIFCO3/O18JgZfIl+447+Jv/6tcmGfS34d5
 bBFcfeci8luRf6WEL4PpnTqjpmjjIw0eanV71HHFE1oB2aM+Ryr5iu4USRul11UHfTNZQf+Rf9Q
 fqddShXmbsGk5yzcafal4iJWOtCVTfbCNrxOsTaLbMPSY029XqouU4yKaQPyQzsym8wGse0IA9I
 Uk9JtJLf11x6J2n0KGao/WloJcXdeNj323IcTfpY3sIITSX3hj3/iSC9TMenvFbfh9JHrj5SVyK
 nJTO47dLVmCFzyIlmqvwi55BcNHQ==
X-Google-Smtp-Source: AGHT+IG72lzChL8ifKR0ow59YOMJO8E+H2l9V6i5v8SneILZwhDj+kBGORNmvP48etxnHFShnT/big==
X-Received: by 2002:a05:701b:2714:b0:119:e56b:9596 with SMTP id
 a92af1059eb24-11f34c4b478mr11234849c88.27.1766006469324; 
 Wed, 17 Dec 2025 13:21:09 -0800 (PST)
Received: from gromero0.. ([191.8.216.160]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12061ef3383sm1852476c88.0.2025.12.17.13.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 13:21:09 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 6/6] system/physmem: Use cpu_address_space_init to set
 cpu->num_ases
Date: Wed, 17 Dec 2025 18:20:18 -0300
Message-Id: <20251217212018.93320-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217212018.93320-1-gustavo.romero@linaro.org>
References: <20251217212018.93320-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x432.google.com
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

Use the new cpu_address_space_init function to set the total number of
ASes in a CPU instead of directly setting it via cpu->num_ases.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 system/cpus.c                    |  4 ++--
 target/arm/cpu.c                 | 10 +---------
 target/i386/kvm/kvm-cpu.c        |  3 ++-
 target/i386/tcg/system/tcg-cpu.c |  2 +-
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index fa9deafa29..54be6a3faf 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -718,8 +718,8 @@ void qemu_init_vcpu(CPUState *cpu)
         /* If the target cpu hasn't set up any address spaces itself,
          * give it the default one.
          */
-        cpu->num_ases = 1;
-        cpu_address_space_add(cpu, 0, "cpu-memory", cpu->memory);
+        cpu_address_space_init(cpu, 1 /* Number of ASes */);
+        cpu_address_space_add(cpu, 0 /* AS index */, "cpu-memory", cpu->memory);
     }
 
     /* accelerators all implement the AccelOpsClass */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1902c510f9..67ad6f0a6e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2148,15 +2148,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     unsigned int smp_cpus = ms->smp.cpus;
     bool has_secure = cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY);
 
-    /*
-     * We must set cs->num_ases to the final value before
-     * the first call to cpu_address_space_init.
-     */
-    if (cpu->tag_memory != NULL) {
-        cs->num_ases = 3 + has_secure;
-    } else {
-        cs->num_ases = 1 + has_secure;
-    }
+    cpu_address_space_init(cs, ARMASIdx_MAX);
 
     cpu_address_space_add(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index a6d94d0620..dbb04ef051 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -92,13 +92,14 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
         kvm_set_guest_phys_bits(cs);
     }
 
+    cpu_address_space_init(cs, X86ASIdx_MAX);
+
     /*
      * When SMM is enabled, there is 2 address spaces. Otherwise only 1.
      *
      * Only initialize address space 0 here, the second one for SMM is
      * initialized at register_smram_listener() after machine init done.
      */
-    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
     cpu_address_space_add(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
 
     return true;
diff --git a/target/i386/tcg/system/tcg-cpu.c b/target/i386/tcg/system/tcg-cpu.c
index 231a4bdf55..ab72c5ff7b 100644
--- a/target/i386/tcg/system/tcg-cpu.c
+++ b/target/i386/tcg/system/tcg-cpu.c
@@ -73,7 +73,7 @@ bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
     memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->cpu_as_mem, 0);
     memory_region_set_enabled(cpu->cpu_as_mem, true);
 
-    cs->num_ases = 2;
+    cpu_address_space_init(cs, X86ASIdx_MAX);
     cpu_address_space_add(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
     cpu_address_space_add(cs, X86ASIdx_SMM, "cpu-smm", cpu->cpu_as_root);
 
-- 
2.34.1


