Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25A2C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqgY-0002zk-Nf; Fri, 19 Apr 2024 12:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqej-0001Fn-Bd
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeb-00019N-AH
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:02 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-346b09d474dso2032878f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542395; x=1714147195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6nYDbfiehTdxZ4oKQVaAYQN5jvjqz012O7hP4xktYbg=;
 b=ZjRQcMD3Xx0BKMjZrbWgFtTm0A5ycbuKX+djZhe4EAASdcr0A6pTcZlaZoAQ0iOPTE
 rSytwbC1zKg0Ii1k1KcVb75dg0A1TdIAvT0+bt40Xcl+qAGGCRWGRFeeHBc6nwy4v+fi
 KuexClAQ/zo9gAz2JuEA4RN4dcx9mcvEYDgIh7ixyQDh/wfMe/+MW7XUS55q2yoVaYoA
 KE1KuUnE8Ux0GjjWJpurdYOjBoc70IHCr6wEWtzNBGq9HCJ02cLZ88TVruAgREm7vsH3
 TFkCXBzfL03rMPIAtvRyEOz7s6gCPquZ3ZmKx5KLdiXwT7DxlSLc8Ql67aqafEvO4mhY
 3GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542395; x=1714147195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nYDbfiehTdxZ4oKQVaAYQN5jvjqz012O7hP4xktYbg=;
 b=enjKn9yl0G4X9i34j/oulqfm/vYvtdmxJgs+hSpRmPy6vXoeBOLG9m+y49t3Qdb03S
 Afz6DtLdY96a4QDjdr6ofcEsyAY6LBreIrIYKDD2UQHACnUbMQbtPhvK6xnii8vkCgRh
 hpmGTiRleSnNmwtoUmhO0CCYbY/8GimNr0dzeyDe8NYsANf4eynjt9wK0c1zmdiu8a8H
 j1s8dEepF4pg8oV4kZ8UBQJ+lgyK46G0nfkLes9weiHJpprS90ID40nePQ3jpHrZxh8W
 Xu1CJmRjEzj0rOQuGnpOT1P/zA9TuFH4LOUuzgNNW2yvyeVJVKGJUflLekxC42xSlNv+
 bG+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCURIuWTYg1/2xLgApiuuazL/WPtmma+LC9KU/ksASTx5thcfStQXcXkqghY2zBRrC1ckdyZoFlU18KNVIM7bpwxcnesqnQ=
X-Gm-Message-State: AOJu0YyTLF+HATMqwFfWeAqt7RAcoDtVgJwd+QCBJw8HWDCLB/oOH9yH
 xhZ8X4bCZHRTCi/XyL4LO3wy241bqeCSH0viorh5pJpHC2aEaSqVvuPJ/qYJIhY=
X-Google-Smtp-Source: AGHT+IENd+TeX2PBr9ChBBd+ruacRcP4c4TYBzXGQ3ipRL9oc1orolv3f+o8CLX8XZE/mgXca1Ufaw==
X-Received: by 2002:a5d:6da8:0:b0:343:7032:7283 with SMTP id
 u8-20020a5d6da8000000b0034370327283mr2695209wrs.8.1713542395421; 
 Fri, 19 Apr 2024 08:59:55 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:55 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 13/22] hw/arm/boot: Register Linux BSS section for
 confidential guests
Date: Fri, 19 Apr 2024 16:57:01 +0100
Message-ID: <20240419155709.318866-15-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42d.google.com
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

Although the BSS section is not currently part of the kernel blob, it
needs to be registered as guest RAM for confidential guest support,
because the kernel needs to access it before it is able to setup its RAM
regions.

It would be tempting to simply add the BSS as part of the ROM blob (ie
pass kernel_size as max_len argument to rom_add_blob()) and let the ROM
loader notifier deal with the full image size generically, but that
would add zero-initialization of the BSS region by the loader, which
adds a significant overhead. For a 40MB kernel with a 17MB BSS, I
measured an average boot time regression of 2.8ms on a fast desktop,
5.7% of the QEMU setup time). On a slower host, the regression could be
much larger.

Instead, add a special case to initialize the kernel's BSS IPA range.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: new
---
 target/arm/kvm_arm.h |  5 +++++
 hw/arm/boot.c        | 11 +++++++++++
 target/arm/kvm-rme.c | 10 ++++++++++
 3 files changed, 26 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 47777386b0..4b787dd628 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -218,6 +218,7 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 int kvm_arm_rme_init(MachineState *ms);
 int kvm_arm_rme_vm_type(MachineState *ms);
+void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
 
 bool kvm_arm_rme_enabled(void);
 int kvm_arm_rme_vcpu_init(CPUState *cs);
@@ -243,6 +244,10 @@ static inline bool kvm_arm_sve_supported(void)
     return false;
 }
 
+static inline void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
+{
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 84ea6a807a..9f522e332b 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -26,6 +26,7 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
+#include "kvm_arm.h"
 
 /* Kernel boot protocol is specified in the kernel docs
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
@@ -850,6 +851,7 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
 {
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
     uint64_t kernel_size = 0;
+    uint64_t page_size;
     uint8_t *buffer;
     int size;
 
@@ -916,6 +918,15 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
     *entry = mem_base + kernel_load_offset;
     rom_add_blob_fixed_as(filename, buffer, size, *entry, as);
 
+    /*
+     * Register the kernel BSS as realm resource, so the kernel can use it right
+     * away. Align up to skip the last page, which still contains kernel
+     * data.
+     */
+    page_size = qemu_real_host_page_size();
+    kvm_arm_rme_init_guest_ram(QEMU_ALIGN_UP(*entry + size, page_size),
+                               QEMU_ALIGN_DOWN(kernel_size - size, page_size));
+
     g_free(buffer);
 
     return kernel_size;
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index bee6694d6d..b2ad10ef6d 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -203,6 +203,16 @@ int kvm_arm_rme_init(MachineState *ms)
     return 0;
 }
 
+/*
+ * kvm_arm_rme_init_guest_ram - Initialize a Realm IPA range
+ */
+void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
+{
+    if (rme_guest) {
+        rme_add_ram_region(base, size, /* populate */ false);
+    }
+}
+
 int kvm_arm_rme_vcpu_init(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.44.0


