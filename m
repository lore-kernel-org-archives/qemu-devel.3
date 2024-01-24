Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AFEC48260
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 15:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSfaM-0003aZ-By; Wed, 24 Jan 2024 10:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSfaK-0003aA-Lb
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:54:40 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSfaH-0002Nc-Qa
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:54:40 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-339261a6ec2so3902037f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 07:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706111676; x=1706716476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTb7XsL1n33B1zcbpZjICkUyxotK3fc0XdMkkBFWEgg=;
 b=anQR07mYvhrjuYDuaduo4gvl2Pgyxo3W1wENdjnoClt71j+45t2IO9LvyuXVbOx14b
 Mu6OjXQX8zoSm8ZRxm2GHkQkt35blynjOZ7VYXeOQ+L+mXt9jOT8oOIqxMpF+ONZX2CP
 88dqkQw60MqV0sAEnUnBJYWUO7kdMwpBn+cc8q0TBXjupRDhWbT8vrkCpgKFut/22JXP
 7ZQmrrnd73qqfknx4zYP5Z6yPrITBCDb5Izm+rqKWIax9WOkK1QWgI/K81zq/YYeUTSX
 VGo2TMuO1EPWiHNaXoK6DyRjwljlbuRSBBvQ35EKgtmPP9U5KSIzsslGOtSvAQHHLAA4
 dxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706111676; x=1706716476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTb7XsL1n33B1zcbpZjICkUyxotK3fc0XdMkkBFWEgg=;
 b=QFXqaJHZiVzUwK60fJtCP0sQhAyYZeBhSx0xM/bauPlrRU5Xg2ZxOxTFosS6A1C6z6
 yocsHGBuOkWuDrurlpzpOSEzBJPv9Rm/lAINXTcp79rHzV/sRiFBbfp0oy885MPveIqi
 nbk40CNkGCwkKnWhRWwxoCppt4vGZCaKNRIdbLL5c+P/1VOtz9Yx6oP8AHPz8Bm/d7+X
 OO0Q+u7Rx2xNlIqKXxAuO4HNEW7lC03oxKcPuwgaoSupwZ1PTlhSyqCi/EBwQI+bv6FU
 plM3x8m/mwnd/cIGXpaA/igscrSjsthgDKhgqhOwRNdSQ5JFRa7cvbaA9L6pzRvyE1aI
 T/1w==
X-Gm-Message-State: AOJu0Yzw5n90L6dnJ0xv6L45Gy/A56hIPK+2OT7RiyQDWmzv+ye/kwhz
 a35swqaKV2GxwLNuUlLlzwYismue8SMtd4Ggok7kCFy0aqZU7lMi/WgCupwT3C6Cf0tHwvXp9Nw
 V
X-Google-Smtp-Source: AGHT+IEWNMk3AgOpr1E3McOSW2fz67zuR1pIW2mreBkz+XaNSy0I1MnJTEPBGceydnI2SuRckjj6QA==
X-Received: by 2002:adf:cc84:0:b0:337:6806:f919 with SMTP id
 p4-20020adfcc84000000b003376806f919mr854421wrj.107.1706111675960; 
 Wed, 24 Jan 2024 07:54:35 -0800 (PST)
Received: from localhost.localdomain
 (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr. [176.184.8.67])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a5d5110000000b0033763a9ea2dsm9921845wrt.63.2024.01.24.07.54.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 07:54:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/2] accel/kvm: Define KVM_ARCH_HAVE_MCE_INJECTION in each
 target
Date: Wed, 24 Jan 2024 16:54:24 +0100
Message-ID: <20240124155425.73195-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124155425.73195-1-philmd@linaro.org>
References: <20240124155425.73195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Instead of having KVM_HAVE_MCE_INJECTION optionally defined,
always define KVM_ARCH_HAVE_MCE_INJECTION for each target,
and set KVM_HAVE_MCE_INJECTION if it is not zero.

It is now clearer for KVM targets to detect if they lack the
MCE injection implementation. Also, moving headers around
is no more painful, because if a target neglects to define
KVM_ARCH_HAVE_MCE_INJECTION, the build will fail.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
I'd rather keep "cpu-param.h" simple/short.

Is a per-target "kvm-param.h" any better?
Or per-target "accel-param.h"? For example TCG_GUEST_DEFAULT_MO
is TCG specific and could also go there. Otherwise it will go
in "cpu-param.h".
---
 include/sysemu/kvm.h         | 5 +++++
 target/arm/cpu-param.h       | 5 +++++
 target/arm/cpu.h             | 4 ----
 target/i386/cpu-param.h      | 2 ++
 target/i386/cpu.h            | 2 --
 target/loongarch/cpu-param.h | 2 ++
 target/mips/cpu-param.h      | 2 ++
 target/ppc/cpu-param.h       | 2 ++
 target/riscv/cpu-param.h     | 2 ++
 target/s390x/cpu-param.h     | 2 ++
 10 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index d614878164..2e9aa2fc53 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -212,6 +212,7 @@ int kvm_on_sigbus(int code, void *addr);
 
 #ifdef NEED_CPU_H
 #include "cpu.h"
+#include "cpu-param.h"
 
 void kvm_flush_coalesced_mmio_buffer(void);
 
@@ -349,6 +350,10 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
+#if KVM_ARCH_HAVE_MCE_INJECTION
+#define KVM_HAVE_MCE_INJECTION
+#endif
+
 #ifdef KVM_HAVE_MCE_INJECTION
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 #endif
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index f9b462a98f..d71cc29864 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -30,7 +30,12 @@
  */
 # define TARGET_PAGE_BITS_VARY
 # define TARGET_PAGE_BITS_MIN  10
+#endif
 
+#ifdef TARGET_AARCH64
+#define KVM_ARCH_HAVE_MCE_INJECTION 1
+#else
+#define KVM_ARCH_HAVE_MCE_INJECTION 0
 #endif
 
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ec276fcd57..f92c8d3b88 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -30,10 +30,6 @@
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
-#ifdef TARGET_AARCH64
-#define KVM_HAVE_MCE_INJECTION 1
-#endif
-
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
 #define EXCP_PREFETCH_ABORT  3
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index 911b4cd51b..5933b0b756 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -24,4 +24,6 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
+#define KVM_ARCH_HAVE_MCE_INJECTION 1
+
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7f0786e8b9..230ab1cded 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -33,8 +33,6 @@
 /* The x86 has a strong memory model with some store-after-load re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
-#define KVM_HAVE_MCE_INJECTION 1
-
 /* support for self modifying code even if the modified instruction is
    close to the modifying instruction */
 #define TARGET_HAS_PRECISE_SMC
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index cfe195db4e..f69a94e6b5 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -14,4 +14,6 @@
 
 #define TARGET_PAGE_BITS 12
 
+#define KVM_ARCH_HAVE_MCE_INJECTION 0
+
 #endif
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 594c91a156..45c885e00e 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -30,4 +30,6 @@
 #define TARGET_PAGE_BITS_MIN 12
 #endif
 
+#define KVM_ARCH_HAVE_MCE_INJECTION 0
+
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 0a0416e0a8..9975ae73ab 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -33,4 +33,6 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
+#define KVM_ARCH_HAVE_MCE_INJECTION 0
+
 #endif
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index b2a9396dec..e6199f4f6d 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -28,4 +28,6 @@
  *  - M mode HLV/HLVX/HSV 0b111
  */
 
+#define KVM_ARCH_HAVE_MCE_INJECTION 0
+
 #endif
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index 84ca08626b..4728b3957e 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -13,4 +13,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 
+#define KVM_ARCH_HAVE_MCE_INJECTION 0
+
 #endif
-- 
2.41.0


