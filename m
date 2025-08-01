Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6BFC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpwW-0007pe-9A; Fri, 01 Aug 2025 09:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerkolothum@gmail.com>)
 id 1uhkUW-0004zU-WF; Fri, 01 Aug 2025 03:47:49 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shameerkolothum@gmail.com>)
 id 1uhkUU-0007mb-SI; Fri, 01 Aug 2025 03:47:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so649086f8f.0; 
 Fri, 01 Aug 2025 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754034464; x=1754639264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOwwy3GLPQ6ST7xJTOCyOyJnsV2gNoteuopM4onEoIE=;
 b=DF7erN5HQ1s6TYlMk6uSUrN6GYri7XrgiLPQbJLaIT+roRPvgjiiCv6EsdOc9tLkSn
 gUYnLD02lG6fQoYXx2SGyq8bZH4I//4BdaahbedrXsOPdTpfTawtW9FDPLdSgyL6E/9y
 R6KIGEvCtcgaANtoEfQuzmg6twwc3THpi73bCkiMT92WimvLdyqI548/5MYpTHDNK22F
 KlKwtPHeiMR5SYiIC7BOz+kOsWxLmDOTfHM29/mfJsTHXYR8J3WunyGERYW0S0c58/qa
 HtXzjm+c5i8VRuxt+p6sH2XEFZVuTMF1HK3BfUT6njX6Ta+TVSDyzaY+sBjEMq2on0in
 nEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754034464; x=1754639264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOwwy3GLPQ6ST7xJTOCyOyJnsV2gNoteuopM4onEoIE=;
 b=biUYbbM7LSP+4qJo/BwG6PDe4me855fXQjg0MGoqm0srL5ciYJ0Izp69tBbaoXAOqp
 uNzE8W3cnKc7lbSzFpc8wirNzfzkyw3HCOSgdNajCgSxYyaP1D6ylnAqFREe3gynd6O/
 MpFfLczDb4GPVh8/JMSdYaAQngFM/bqmF7Elw5nGk8cM1VfA6l0IqUoNA2IRaA/z7mO3
 qwFO23fAosX6sFn2yignLj+YtfFqCs1rE7xgA5rxUiL9hJfztlPpKBxbqxzCO4xCDIOY
 h6gkt0KgKe8peIiEcS2YHujbUD5TfQls0kGV98bIbBrEPfnR2PIBfG6ZSPaEE/fKvELe
 HBDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGdbnRhrLzqL/1IAcvuxKjqmyeSECE5NMdId14TATPzevSJF+p84pSIAx2pJQWEOYoHxfqhZy6ELVq@nongnu.org
X-Gm-Message-State: AOJu0Ywv4SgGLwVKlqYY/kAzosd6KkPsdDGwnasVyQuPAvNtDppIuUbz
 Jnzp91JkRfgk308L/k7pKh3NjE77CHUtlNWo9fDICWMMsKKIGDIb85+VLWnWLg==
X-Gm-Gg: ASbGncvz3djQped6tOzXBtJGajs//K0TVCKrr7DdJxnTyU2yI3fjuuX7zhw2sjRgG6/
 GcFwG/H56W93odOREHwzPjsNPZVba9Rcg8/JgwV0Y09ZmLm/5aR4mnchvS/96Y533I2OnV6dIRJ
 QcGpO4wONQmzVrPKG6mal/ytH7XCkA7mGtpyeAFhzQWANTlIGEb9VxhF9VAKF4Q48ikhksUj9AN
 eTPpAzwAhAP/p1xB6ajsjazhMihpYT+Hx8/+E7brij9JgBYKief9Me5Fl6JDs3sVc2Y8GB0s/LM
 9IJrYsWlLo0S/WDj/wp+nKDUeaiD1PLSl0BR/zwfMg+902Vl6pMPbrrzAreDINUJQolK1QtGJvF
 Dxkzb7FFMU7A+UGhxcW8y4aGatDonC2C5gw==
X-Google-Smtp-Source: AGHT+IE543fvfeJI9GhypQTiBCwSXnt7jJx8MHoitAqUiMxp4JU0t74VjvCQZ6I7aX3quxRWjJBDGg==
X-Received: by 2002:a05:6000:144b:b0:3b8:d32e:9231 with SMTP id
 ffacd0b85a97d-3b8d32e9730mr1358500f8f.29.1754034464033; 
 Fri, 01 Aug 2025 00:47:44 -0700 (PDT)
Received: from shameer-ubuntu ([195.11.233.227])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm5049185f8f.44.2025.08.01.00.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 00:47:43 -0700 (PDT)
From: Shameer Kolothum <shameerkolothum@gmail.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, berrange@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, armbru@redhat.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, salil.mehta@huawei.com,
 yangjinqian1@huawei.com, shameerkolothum@gmail.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [RFC PATCH RESEND 2/4] target/arm/kvm: Add QAPI struct
 ArmTargetImplCPU
Date: Fri,  1 Aug 2025 08:47:28 +0100
Message-ID: <20250801074730.28329-3-shameerkolothum@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801074730.28329-1-shameerkolothum@gmail.com>
References: <20250801074730.28329-1-shameerkolothum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shameerkolothum@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 01 Aug 2025 09:35:51 -0400
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Introduce a QAPI‐defined struct (and its array) for target implementation
CPUs. This enables specifying target implementation CPU parameters
via -machine, for example:

-M virt, \
  impl-cpu.0.midr=1,impl-cpu.0.revidr=1,impl-cpu.0.aidr=1, \
  impl-cpu.1.midr=2,impl-cpu.1.revidr=2,impl-cpu.1.aidr=0

Subsequent patch will make use of this by using object_property_add(),
allowing users to configure each target CPU’s midr, revidr, and aidr
fields directly from the command line.

While at it, also provide a helper function to set the target CPUs.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 qapi/machine.json    | 34 ++++++++++++++++++++++++++++++++++
 target/arm/kvm.c     | 16 ++++++++++++++++
 target/arm/kvm_arm.h |  8 ++++++++
 3 files changed, 58 insertions(+)

diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09..d6e0e3b2e3 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1898,3 +1898,37 @@
 { 'command': 'x-query-interrupt-controllers',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
+
+##
+# @ArmTargetImplCPU:
+#
+# Info for a single target implementation CPU.
+#
+# @midr: MIDR value
+# @revidr: REVIDR value
+# @aidr: AIDR value
+#
+# Since: 10.2
+##
+{ 'struct': 'ArmTargetImplCPU',
+  'data': {
+    'midr': 'uint64',
+    'revidr': 'uint64',
+    'aidr': 'uint64'
+  }
+}
+
+##
+# @ArmTargetImplCPUs:
+#
+# List of target implementation CPUs.
+#
+# @target-cpus: List of ArmTargetImplCPU entries.
+#
+# Since: 10.2
+##
+{ 'struct': 'ArmTargetImplCPUs',
+  'data': {
+    'target-cpus': ['ArmTargetImplCPU']
+  }
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index eb04640b50..8f325c4ca4 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -66,6 +66,9 @@ typedef struct ARMHostCPUFeatures {
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
+static uint64_t target_impl_cpus_num;
+static ArmTargetImplCPU *target_impl_cpus;
+
 /**
  * kvm_arm_vcpu_init:
  * @cpu: ARMCPU
@@ -2816,3 +2819,16 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
         cpu->kvm_mte = true;
     }
 }
+
+bool kvm_arm_set_target_impl_cpus(uint64_t num, ArmTargetImplCPU *cpus)
+{
+
+    if (target_impl_cpus_num) {
+        return false;
+    }
+
+    target_impl_cpus_num = num;
+    target_impl_cpus = cpus;
+
+    return true;
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 3cd6447901..8754302333 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -244,6 +244,8 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
 int kvm_arm_get_writable_id_regs(ARMCPU *cpu, IdRegMap *idregmap);
 
+bool kvm_arm_set_target_impl_cpus(uint64_t num, ArmTargetImplCPU *cpus);
+
 #else
 
 /*
@@ -280,6 +282,12 @@ static inline int kvm_arm_get_writable_id_regs(ARMCPU *cpu, IdRegMap *idregmap)
     return -ENOSYS;
 }
 
+static inline
+bool kvm_arm_set_target_impl_cpus(uint64_t num, ArmTargetImplCPU *cpus)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
-- 
2.34.1


