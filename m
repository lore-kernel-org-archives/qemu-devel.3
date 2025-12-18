Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAD4D711C8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLYG-0001I7-B0; Thu, 18 Dec 2025 16:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLYE-0001HX-SV
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:28:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLYC-0007MC-HR
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:28:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so7556825e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093323; x=1766698123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAK9tvM3nzP7bqefNRKb4l15uHhIOhJpG+pyKB0pNiw=;
 b=ZSqTT8aWSEdd8yPPtLyNlHAz56wiD7Iu9xPcGULJ/a9VRdP4Ec3sGlF5/yMOFCJ31a
 cy5ZC8rawa5l/gpziy4bkVfPwSQ9kiqqOGQJoi1fnKvwZpoDiX30P2/0MM/9szdDNKRN
 h/TjhAOruLvt7HiFn6o1FxMKH3c0at7D1lojJBdefLgkkbqQ8kAk+WBTOqhDinUDUPb7
 DjFFZSvK71C7ua9j8SiSKaiZuVtXDU1kXmgqFcNTsumlBMRYBLyleRZf1it+nAO3Hskd
 FeOu2P0a/hwqfqma5dVWxXZy1x+LRJQQfiFgHxlQmeVvyYB8IYDI5lEI7nB5uj9zvXna
 CRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093323; x=1766698123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iAK9tvM3nzP7bqefNRKb4l15uHhIOhJpG+pyKB0pNiw=;
 b=ORy+Ec7qTu/FupTPP/Px3jfjuyvv9FF2yjC5IsIPCNlgsVH1DnOhlKJ+tBLmCb5UUd
 sdjrIvJPsx5YSIaCTPd2JeHhzU9TJUf9EzFbFw664Z+eixHNGD4pxlv/ihSjS7fkULpW
 U64ilkcCIs5Bk0oi8JimNUGyoGYpVZpdc7b74Kccjp6OB8264fX8XTkktaJm2WwqgxSI
 jHLQbkW9cQq2Y6mpwZ0K86FrCUmP9pLWnwycYWnjLiCSwqlU2pBgNvT1rboZHsg48yHg
 pzNptyub4lnmyIVUD3O2ywcrigs80rAb40zQIXIrexCQn/XTaEASTvxMqwXTzrn4GS59
 pr6w==
X-Gm-Message-State: AOJu0Ywa9SEBxETWxtOoGJMexbnPBc4krA4eV+Rn0svk+E+S8YPrmEFt
 8mviQKgZ/X6lyQpnTrjfF1S38faZ8rHXvPlD8PxCKIQqzClwfUa4MKRWOFA5W01axBKzsmMkcd2
 GhCUYOZ0=
X-Gm-Gg: AY/fxX4HHR8+uPT0QkzHuX39fAtU/dOEGT399UgWKMpHYFpfqPgEBgeJZtfaE6SiBHX
 bsqCCyWuE84O2P8jk2yBTev+ORaGVFIUmBkKxsFLR7vJg4F5IRSGR/K2r/zp+ryqaBaUZm7OOkX
 W0x9La4H8+Qw4a7buscEMZ/73gqpcqgwSk4lydtU1ajzRDN0/cohwKRRTOfo21NT2cKoJRl6dLA
 TWH3SgyhLQ0kwQHKfoQs79QWoR+cd0l2kPGCzAUHZmYrpryD+H+RM1PZ9RIphtD/MLoyuZO9WMo
 DsEIv8w/3AwqZBZL3UfrJ78eO6U1TrMnd25TObjEcew9PKtKNUx6+oPCMVFKebz3F5ZK2Dh5v00
 983KAMN0Y3YLWd31+B0euzD7Ffyrw148VjC9PrWf+kqfMu+grvTGv+br2W8JEEIzkHtxKqJjKOp
 zvJ3i9tfxiXnxF9s8eaRJ+vR90Geh5qBJ1yFg+dCM6Wl/MV0jIJNLKuBNdgV+R
X-Google-Smtp-Source: AGHT+IEGjA9Z1Fmb3GSTSqsxRRNY39jWxLL7tw3hQZ72ODQz7ZKs9MCXwaWj4fGoYl/RoLRqDb+g+g==
X-Received: by 2002:a05:600c:524f:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-47d19594b2emr4830355e9.20.1766093322523; 
 Thu, 18 Dec 2025 13:28:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346d33sm10737775e9.3.2025.12.18.13.28.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:28:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH 3/4] configs/targets: Introduce
 TARGET_USE_LEGACY_NATIVE_ENDIAN_API
Date: Thu, 18 Dec 2025 22:28:13 +0100
Message-ID: <20251218212814.61445-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218212814.61445-1-philmd@linaro.org>
References: <20251218212814.61445-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

TARGET_USE_LEGACY_NATIVE_ENDIAN_API is a definition that will
let us gradually remove legacy APIs related to "native" endianness.

Set it to all our system emulation targets, taking care to not
poison it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/aarch64-softmmu.mak      | 1 +
 configs/targets/alpha-softmmu.mak        | 1 +
 configs/targets/arm-softmmu.mak          | 1 +
 configs/targets/avr-softmmu.mak          | 1 +
 configs/targets/hppa-softmmu.mak         | 1 +
 configs/targets/i386-softmmu.mak         | 1 +
 configs/targets/loongarch64-softmmu.mak  | 1 +
 configs/targets/m68k-softmmu.mak         | 1 +
 configs/targets/microblaze-softmmu.mak   | 1 +
 configs/targets/microblazeel-softmmu.mak | 1 +
 configs/targets/mips-softmmu.mak         | 1 +
 configs/targets/mips64-softmmu.mak       | 1 +
 configs/targets/mips64el-softmmu.mak     | 1 +
 configs/targets/mipsel-softmmu.mak       | 1 +
 configs/targets/or1k-softmmu.mak         | 1 +
 configs/targets/ppc-softmmu.mak          | 1 +
 configs/targets/ppc64-softmmu.mak        | 1 +
 configs/targets/riscv32-softmmu.mak      | 1 +
 configs/targets/riscv64-softmmu.mak      | 1 +
 configs/targets/rx-softmmu.mak           | 1 +
 configs/targets/s390x-softmmu.mak        | 1 +
 configs/targets/sh4-softmmu.mak          | 1 +
 configs/targets/sh4eb-softmmu.mak        | 1 +
 configs/targets/sparc-softmmu.mak        | 1 +
 configs/targets/sparc64-softmmu.mak      | 1 +
 configs/targets/tricore-softmmu.mak      | 1 +
 configs/targets/x86_64-softmmu.mak       | 1 +
 configs/targets/xtensa-softmmu.mak       | 1 +
 configs/targets/xtensaeb-softmmu.mak     | 1 +
 scripts/make-config-poison.sh            | 1 +
 30 files changed, 30 insertions(+)

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index d14bcfc4900..5a9e8a32374 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -4,4 +4,5 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-sme2.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index e31f059a52d..05c696ead2d 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=alpha
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
diff --git a/configs/targets/arm-softmmu.mak b/configs/targets/arm-softmmu.mak
index 6a5a8eda949..b8466614fa9 100644
--- a/configs/targets/arm-softmmu.mak
+++ b/configs/targets/arm-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=arm
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmmu.mak
index b6157fc465d..1aba1ccf13b 100644
--- a/configs/targets/avr-softmmu.mak
+++ b/configs/targets/avr-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/hppa-softmmu.mak b/configs/targets/hppa-softmmu.mak
index ea331107a08..290eadd2939 100644
--- a/configs/targets/hppa-softmmu.mak
+++ b/configs/targets/hppa-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=hppa
 TARGET_BIG_ENDIAN=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index e9d89e8ab41..3dc1e9e8eab 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index fc44c54233d..bb6051835b2 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -4,4 +4,5 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/m68k-softmmu.mak b/configs/targets/m68k-softmmu.mak
index bacc52e96a9..33649a00132 100644
--- a/configs/targets/m68k-softmmu.mak
+++ b/configs/targets/m68k-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=m68k
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index bab7b498c24..20756f3c6cd 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -3,4 +3,5 @@ TARGET_BIG_ENDIAN=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index 8aee7ebc5cf..70cdbcb8aec 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=microblaze
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/mips-softmmu.mak b/configs/targets/mips-softmmu.mak
index c9588066b8d..4ef1f6892cd 100644
--- a/configs/targets/mips-softmmu.mak
+++ b/configs/targets/mips-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips
 TARGET_BIG_ENDIAN=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/mips64-softmmu.mak b/configs/targets/mips64-softmmu.mak
index 7202655fcac..acd60bd9713 100644
--- a/configs/targets/mips64-softmmu.mak
+++ b/configs/targets/mips64-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_BIG_ENDIAN=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
index 3ebeadb29ea..759c47ddf7e 100644
--- a/configs/targets/mips64el-softmmu.mak
+++ b/configs/targets/mips64el-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-softmmu.mak
index 90e09bdc3e5..6b5aad7fe84 100644
--- a/configs/targets/mipsel-softmmu.mak
+++ b/configs/targets/mipsel-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=mips
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 0e47d9878b0..f4621b8fe08 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=openrisc
 TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 9bfa7df6c36..e7c1543727a 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -1,5 +1,6 @@
 TARGET_ARCH=ppc
 TARGET_BIG_ENDIAN=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 74572864b36..bb6b769836e 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -1,6 +1,7 @@
 TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_BIG_ENDIAN=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
 # all boards require libfdt
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index db55275b868..1a6e6f2a53a 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -3,4 +3,5 @@ TARGET_BASE_ARCH=riscv
 TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 2bdd4a62cd2..f7c09be186b 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -4,4 +4,5 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.mak
index 1c250a6450d..0c3932e73c4 100644
--- a/configs/targets/rx-softmmu.mak
+++ b/configs/targets/rx-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=rx
 TARGET_XML_FILES= gdb-xml/rx-core.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index 76dd5de6584..d7d165c5781 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=s390x
 TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/sh4-softmmu.mak b/configs/targets/sh4-softmmu.mak
index 787d349b501..fd8ec407139 100644
--- a/configs/targets/sh4-softmmu.mak
+++ b/configs/targets/sh4-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=sh4
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/sh4eb-softmmu.mak b/configs/targets/sh4eb-softmmu.mak
index cdea2c61c58..7a1dfdbe211 100644
--- a/configs/targets/sh4eb-softmmu.mak
+++ b/configs/targets/sh4eb-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sh4
 TARGET_BIG_ENDIAN=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 57801faf1fc..7254e5dd1b6 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index d9d51d21e59..7b5d475c85d 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,5 +1,6 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricore-softmmu.mak
index 781ce49a62f..63e040ccc2b 100644
--- a/configs/targets/tricore-softmmu.mak
+++ b/configs/targets/tricore-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=tricore
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 5619b2bc686..263ec88b7d7 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -3,4 +3,5 @@ TARGET_BASE_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/xtensa-softmmu.mak b/configs/targets/xtensa-softmmu.mak
index 2a9797338a6..1ce74cd8e5e 100644
--- a/configs/targets/xtensa-softmmu.mak
+++ b/configs/targets/xtensa-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=xtensa
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/xtensaeb-softmmu.mak b/configs/targets/xtensaeb-softmmu.mak
index 5204729af8b..9be73447c88 100644
--- a/configs/targets/xtensaeb-softmmu.mak
+++ b/configs/targets/xtensaeb-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=xtensa
 TARGET_BIG_ENDIAN=y
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 2b36907e239..543119c074e 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -10,6 +10,7 @@ exec sed -n \
   -e' /CONFIG_TCG/d' \
   -e '/CONFIG_USER_ONLY/d' \
   -e '/CONFIG_SOFTMMU/d' \
+  -e '/TARGET_USE_LEGACY_NATIVE_ENDIAN_API/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.52.0


