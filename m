Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEE5D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdEx-0001c9-Gj; Fri, 19 Dec 2025 11:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEt-0001Ga-8a
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:00 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEn-0006JE-TJ
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:59 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so12934055e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161312; x=1766766112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYW4inaejU0vTM/64K47OS0US0UDlIbKDRQ1w/2PTWA=;
 b=Tj/2oU4U/1cduktqW9kCsugfUM6uqhi76PpoNBhBhFK/sLodtZxG4Uk4TRxuGb4w3M
 1lbvvzvuyn7G1LTOozYiFbOalOgw9RfcsQIHbqhSHxAddhVTeCGp+Oh7TEyeJZj/wNuM
 VqVchutZwY6WGH1CGgVFUYMq+7Rv0lmX3QWoWH05RfD5LDI0ZpTDyYrh5e5IyvxUqWaZ
 qDxvsUq67gtlRFj8OjcW+McV+3HrLq5MzPPiKvmel3l6YpGKIF+BymLU0DZqRMgGCf8m
 pS3RQw6Gi3gJsinkWbb9Oz98ErADIlwsABsJ/bLxSL0uWPafr9Ukeu7sfMB0/FmQaa+5
 el8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161312; x=1766766112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XYW4inaejU0vTM/64K47OS0US0UDlIbKDRQ1w/2PTWA=;
 b=pfoXv/qnhbBb/ENO62MiRbm8EOeOLPpuP50zTDtEiTkWBj7WF/btmjbaF9vRHyi+k9
 rz+6zI0TNoqyjIRuyMpA9CidsdI8BeSxCVK1mJIsz/qWKihvKSzjg+oN5u22eoLsi41W
 ZOf/Vd23LgE3Uom+JxLFSRPW4KgXka1q55Z7fHA9m112dFlxkiqEbZZiimkLcfHQ2taG
 k0LZGcb5iXpcWPND2K0Dgr0poEtjKaWSDxNM/2DiMCldwyGi3yvdgpPIMQaph29fMsbz
 CEbtiHugUUjrYxD92WSPbGQjGGjzNPK3go4F6OWkM4T8Qvl6idDm4P3iPA1z2MDku9/H
 S6EQ==
X-Gm-Message-State: AOJu0YwClnzssfe4CQgJPYtgrYOCTHzNPrjh3KRqF70iqtKXMz9KrdHU
 39zT6mm2SWG+U2G8cV2RZHwR7oZlCIeT4X8oxIjVcsPuaynGVyZJnu3AXxqKYkPz9ci5izB8bKk
 G2/oTlcA=
X-Gm-Gg: AY/fxX75d6CJsVWOFCi+BYbvP70s7MwDhkkXHqH61DD58mxYlHF++XiUZNg+xHdhNKc
 OSXP9HGeEodyIHazFk0gXojOY4BN6y3MzFxi48ZSSJ/cwkujaBIeVfr3GWDDaZgTm+9kNQcWnw0
 ZVKHjkOxbIxv7n/6vG/2xQX3DnRRVy3XKKyvPeCLYgGJHXfh142VwF9DGR0rgPdWgNtWgNb0H+4
 PisjEL7/8SE10I/RT7mGNoT9PGoEgxfyh4arnpF5a3TNVg7lxK6glZz71JG0rgGg3U2JqRoHDaU
 ET1PkI+/Kk3iZVDucKDrhes8WyUFFHpcw/7Mh0qzhUYJaNMHmdVzUvHL262OqxpxZrZImM3v8r8
 vTEap+CD4axxNbK2/b9QnAzrPtImGu3iQfkGpqg573tz07QdlOu2GOP30gbybAu6B1YsNILaNK8
 2vkhweIreKpEgM3yMDygvtqf3HXCVpkP8zkm4dtXOOdFYz57ztR1Q7GSfhAom/
X-Google-Smtp-Source: AGHT+IGZsiqYCrKwP/db59qvwNnk4+Rtk6muLrzn9zLiz4YjPkSY4uj+NtaeCBxytTacmFHn+56nZg==
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id
 5b1f17b1804b1-47d18be144fmr34058685e9.14.1766161311792; 
 Fri, 19 Dec 2025 08:21:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3acdb87sm37492005e9.16.2025.12.19.08.21.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:21:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 16/24] configs/targets: Introduce
 TARGET_USE_LEGACY_NATIVE_ENDIAN_API
Date: Fri, 19 Dec 2025 17:19:43 +0100
Message-ID: <20251219161953.72724-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
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

Set it to all our targets, taking care to not poison it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/aarch64-bsd-user.mak        | 1 +
 configs/targets/aarch64-linux-user.mak      | 1 +
 configs/targets/aarch64-softmmu.mak         | 1 +
 configs/targets/aarch64_be-linux-user.mak   | 1 +
 configs/targets/alpha-linux-user.mak        | 1 +
 configs/targets/alpha-softmmu.mak           | 1 +
 configs/targets/arm-bsd-user.mak            | 1 +
 configs/targets/arm-linux-user.mak          | 1 +
 configs/targets/arm-softmmu.mak             | 1 +
 configs/targets/armeb-linux-user.mak        | 1 +
 configs/targets/avr-softmmu.mak             | 1 +
 configs/targets/hexagon-linux-user.mak      | 1 +
 configs/targets/hppa-linux-user.mak         | 1 +
 configs/targets/hppa-softmmu.mak            | 1 +
 configs/targets/i386-bsd-user.mak           | 1 +
 configs/targets/i386-linux-user.mak         | 1 +
 configs/targets/i386-softmmu.mak            | 1 +
 configs/targets/loongarch64-linux-user.mak  | 1 +
 configs/targets/loongarch64-softmmu.mak     | 1 +
 configs/targets/m68k-linux-user.mak         | 1 +
 configs/targets/m68k-softmmu.mak            | 1 +
 configs/targets/microblaze-linux-user.mak   | 1 +
 configs/targets/microblaze-softmmu.mak      | 1 +
 configs/targets/microblazeel-linux-user.mak | 1 +
 configs/targets/microblazeel-softmmu.mak    | 1 +
 configs/targets/mips-linux-user.mak         | 1 +
 configs/targets/mips-softmmu.mak            | 1 +
 configs/targets/mips64-linux-user.mak       | 1 +
 configs/targets/mips64-softmmu.mak          | 1 +
 configs/targets/mips64el-linux-user.mak     | 1 +
 configs/targets/mips64el-softmmu.mak        | 1 +
 configs/targets/mipsel-linux-user.mak       | 1 +
 configs/targets/mipsel-softmmu.mak          | 1 +
 configs/targets/mipsn32-linux-user.mak      | 1 +
 configs/targets/mipsn32el-linux-user.mak    | 1 +
 configs/targets/or1k-linux-user.mak         | 1 +
 configs/targets/or1k-softmmu.mak            | 1 +
 configs/targets/ppc-linux-user.mak          | 1 +
 configs/targets/ppc-softmmu.mak             | 1 +
 configs/targets/ppc64-linux-user.mak        | 1 +
 configs/targets/ppc64-softmmu.mak           | 1 +
 configs/targets/ppc64le-linux-user.mak      | 1 +
 configs/targets/riscv32-linux-user.mak      | 1 +
 configs/targets/riscv32-softmmu.mak         | 1 +
 configs/targets/riscv64-bsd-user.mak        | 1 +
 configs/targets/riscv64-linux-user.mak      | 1 +
 configs/targets/riscv64-softmmu.mak         | 1 +
 configs/targets/rx-softmmu.mak              | 1 +
 configs/targets/s390x-linux-user.mak        | 1 +
 configs/targets/s390x-softmmu.mak           | 1 +
 configs/targets/sh4-linux-user.mak          | 1 +
 configs/targets/sh4-softmmu.mak             | 1 +
 configs/targets/sh4eb-linux-user.mak        | 1 +
 configs/targets/sh4eb-softmmu.mak           | 1 +
 configs/targets/sparc-linux-user.mak        | 1 +
 configs/targets/sparc-softmmu.mak           | 1 +
 configs/targets/sparc32plus-linux-user.mak  | 1 +
 configs/targets/sparc64-linux-user.mak      | 1 +
 configs/targets/sparc64-softmmu.mak         | 1 +
 configs/targets/tricore-softmmu.mak         | 1 +
 configs/targets/x86_64-bsd-user.mak         | 1 +
 configs/targets/x86_64-linux-user.mak       | 1 +
 configs/targets/x86_64-softmmu.mak          | 1 +
 configs/targets/xtensa-linux-user.mak       | 1 +
 configs/targets/xtensa-softmmu.mak          | 1 +
 configs/targets/xtensaeb-linux-user.mak     | 1 +
 configs/targets/xtensaeb-softmmu.mak        | 1 +
 scripts/make-config-poison.sh               | 1 +
 68 files changed, 68 insertions(+)

diff --git a/configs/targets/aarch64-bsd-user.mak b/configs/targets/aarch64-bsd-user.mak
index 7f42e060477..ca0de574c22 100644
--- a/configs/targets/aarch64-bsd-user.mak
+++ b/configs/targets/aarch64-bsd-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-sme2.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aarch64-linux-user.mak
index bf328b3b80c..de5120907a0 100644
--- a/configs/targets/aarch64-linux-user.mak
+++ b/configs/targets/aarch64-linux-user.mak
@@ -7,3 +7,4 @@ CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_SYSTBL_ABI=common,64,renameat,rlimit,memfd_secret
 TARGET_SYSTBL=syscall_64.tbl
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index d14bcfc4900..523a1b98045 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-c
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/aarch64_be-linux-user.mak b/configs/targets/aarch64_be-linux-user.mak
index 284430add7b..6e5a7888f57 100644
--- a/configs/targets/aarch64_be-linux-user.mak
+++ b/configs/targets/aarch64_be-linux-user.mak
@@ -8,3 +8,4 @@ CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_SYSTBL_ABI=common,64,renameat,rlimit,memfd_secret
 TARGET_SYSTBL=syscall_64.tbl
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha-linux-user.mak
index aa25766236e..c5bdb83b443 100644
--- a/configs/targets/alpha-linux-user.mak
+++ b/configs/targets/alpha-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index e31f059a52d..914fc32cff4 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=alpha
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/arm-bsd-user.mak b/configs/targets/arm-bsd-user.mak
index 472a4f9fb11..073e8cc84e3 100644
--- a/configs/targets/arm-bsd-user.mak
+++ b/configs/targets/arm-bsd-user.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=arm
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/arm-linux-user.mak b/configs/targets/arm-linux-user.mak
index bf35ded7fea..c67ebecb54d 100644
--- a/configs/targets/arm-linux-user.mak
+++ b/configs/targets/arm-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/arm-softmmu.mak b/configs/targets/arm-softmmu.mak
index 6a5a8eda949..1397b860f47 100644
--- a/configs/targets/arm-softmmu.mak
+++ b/configs/targets/arm-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/armeb-linux-user.mak b/configs/targets/armeb-linux-user.mak
index 35fa4d91b3c..e01622c55b6 100644
--- a/configs/targets/armeb-linux-user.mak
+++ b/configs/targets/armeb-linux-user.mak
@@ -7,3 +7,4 @@ TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmmu.mak
index b6157fc465d..d888683f47b 100644
--- a/configs/targets/avr-softmmu.mak
+++ b/configs/targets/avr-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexagon-linux-user.mak
index aec1a04d1b4..fc09ae96a54 100644
--- a/configs/targets/hexagon-linux-user.mak
+++ b/configs/targets/hexagon-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,32,hexagon,time32,stat64,rlimit,renameat
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/hppa-linux-user.mak b/configs/targets/hppa-linux-user.mak
index 59190f63358..0c290bcce9a 100644
--- a/configs/targets/hppa-linux-user.mak
+++ b/configs/targets/hppa-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 # Compromise to ease maintenance vs system mode
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/hppa-softmmu.mak b/configs/targets/hppa-softmmu.mak
index ea331107a08..0f99ce5f168 100644
--- a/configs/targets/hppa-softmmu.mak
+++ b/configs/targets/hppa-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=hppa
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/i386-bsd-user.mak b/configs/targets/i386-bsd-user.mak
index 70e098da491..09c22cde339 100644
--- a/configs/targets/i386-bsd-user.mak
+++ b/configs/targets/i386-bsd-user.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=i386
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-linux-user.mak
index ea68a266fce..f9ce4100e98 100644
--- a/configs/targets/i386-linux-user.mak
+++ b/configs/targets/i386-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml gdb-xml/i386-32bit-linux.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index e9d89e8ab41..8e11a5f0796 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
index 249a26a798c..7349a1d6c78 100644
--- a/configs/targets/loongarch64-linux-user.mak
+++ b/configs/targets/loongarch64-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES=gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,64
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index fc44c54233d..3d925e2ff53 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/m68k-linux-user.mak b/configs/targets/m68k-linux-user.mak
index 2d9bae22707..d5c93135ac3 100644
--- a/configs/targets/m68k-linux-user.mak
+++ b/configs/targets/m68k-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
 TARGET_HAS_BFLT=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/m68k-softmmu.mak b/configs/targets/m68k-softmmu.mak
index bacc52e96a9..0750e065cc1 100644
--- a/configs/targets/m68k-softmmu.mak
+++ b/configs/targets/m68k-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=m68k
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/microblaze-linux-user.mak b/configs/targets/microblaze-linux-user.mak
index 37727797695..d1a235c89b1 100644
--- a/configs/targets/microblaze-linux-user.mak
+++ b/configs/targets/microblaze-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_HAS_BFLT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index bab7b498c24..52ba849aa16 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/microblazeel-linux-user.mak b/configs/targets/microblazeel-linux-user.mak
index a51a05488d3..0b7634d5a2d 100644
--- a/configs/targets/microblazeel-linux-user.mak
+++ b/configs/targets/microblazeel-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_HAS_BFLT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index 8aee7ebc5cf..44ac4e5b659 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_ARCH=microblaze
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/mips-linux-user.mak b/configs/targets/mips-linux-user.mak
index 69bdc459b69..a12452cc5d0 100644
--- a/configs/targets/mips-linux-user.mak
+++ b/configs/targets/mips-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/mips-softmmu.mak b/configs/targets/mips-softmmu.mak
index c9588066b8d..170d026bc25 100644
--- a/configs/targets/mips-softmmu.mak
+++ b/configs/targets/mips-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/mips64-linux-user.mak b/configs/targets/mips64-linux-user.mak
index 04e82b3ab11..0112e300eca 100644
--- a/configs/targets/mips64-linux-user.mak
+++ b/configs/targets/mips64-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/mips64-softmmu.mak b/configs/targets/mips64-softmmu.mak
index 7202655fcac..f0850233b98 100644
--- a/configs/targets/mips64-softmmu.mak
+++ b/configs/targets/mips64-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/mips64el-linux-user.mak b/configs/targets/mips64el-linux-user.mak
index 27f41694265..50efedc1f11 100644
--- a/configs/targets/mips64el-linux-user.mak
+++ b/configs/targets/mips64el-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_BASE_ARCH=mips
 TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
index 3ebeadb29ea..f352fed914a 100644
--- a/configs/targets/mips64el-softmmu.mak
+++ b/configs/targets/mips64el-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/mipsel-linux-user.mak b/configs/targets/mipsel-linux-user.mak
index 8b7e86ab288..dea6c52cf24 100644
--- a/configs/targets/mipsel-linux-user.mak
+++ b/configs/targets/mipsel-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_ABI_MIPSO32=y
 TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-softmmu.mak
index 90e09bdc3e5..34be6987edf 100644
--- a/configs/targets/mipsel-softmmu.mak
+++ b/configs/targets/mipsel-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=mips
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/mipsn32-linux-user.mak b/configs/targets/mipsn32-linux-user.mak
index 39ae214633f..412f75180c6 100644
--- a/configs/targets/mipsn32-linux-user.mak
+++ b/configs/targets/mipsn32-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_SYSTBL_ABI=n32
 TARGET_SYSTBL=syscall_n32.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/mipsn32el-linux-user.mak b/configs/targets/mipsn32el-linux-user.mak
index d9b61d69902..2fa89882035 100644
--- a/configs/targets/mipsn32el-linux-user.mak
+++ b/configs/targets/mipsn32el-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_BASE_ARCH=mips
 TARGET_SYSTBL_ABI=n32
 TARGET_SYSTBL=syscall_n32.tbl
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-linux-user.mak
index 810567a98f9..4cc6f2a6616 100644
--- a/configs/targets/or1k-linux-user.mak
+++ b/configs/targets/or1k-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_SYSTBL_ABI=common,32,or1k,time32,stat64,rlimit,renameat
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 0e47d9878b0..5a8eb66cbc5 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/ppc-linux-user.mak b/configs/targets/ppc-linux-user.mak
index 970d04a5ba1..eb86b5fa721 100644
--- a/configs/targets/ppc-linux-user.mak
+++ b/configs/targets/ppc-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 9bfa7df6c36..96310350ba4 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/ppc64-linux-user.mak b/configs/targets/ppc64-linux-user.mak
index 461f1c67d15..627f2f1b87d 100644
--- a/configs/targets/ppc64-linux-user.mak
+++ b/configs/targets/ppc64-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 74572864b36..6aa381fe025 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -6,3 +6,4 @@ TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-a
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/ppc64le-linux-user.mak b/configs/targets/ppc64le-linux-user.mak
index cf9d8a400d9..7c3d97191af 100644
--- a/configs/targets/ppc64le-linux-user.mak
+++ b/configs/targets/ppc64le-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_SYSTBL_ABI=common,nospu,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv32-linux-user.mak b/configs/targets/riscv32-linux-user.mak
index a0ef03c0c3f..0ad8b7da436 100644
--- a/configs/targets/riscv32-linux-user.mak
+++ b/configs/targets/riscv32-linux-user.mak
@@ -8,3 +8,4 @@ TARGET_SYSTBL_ABI=32
 TARGET_SYSTBL_ABI=common,32,riscv,memfd_secret
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index db55275b868..d76aabe14b1 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xm
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
index c6348a79629..442e117db9f 100644
--- a/configs/targets/riscv64-bsd-user.mak
+++ b/configs/targets/riscv64-bsd-user.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv64-linux-user.mak b/configs/targets/riscv64-linux-user.mak
index aac7568305d..64802031bd1 100644
--- a/configs/targets/riscv64-linux-user.mak
+++ b/configs/targets/riscv64-linux-user.mak
@@ -8,3 +8,4 @@ TARGET_SYSTBL_ABI=64
 TARGET_SYSTBL_ABI=common,64,riscv,rlimit,memfd_secret
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 2bdd4a62cd2..d1386d7238f 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xm
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.mak
index 1c250a6450d..3886905f9fc 100644
--- a/configs/targets/rx-softmmu.mak
+++ b/configs/targets/rx-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_XML_FILES= gdb-xml/rx-core.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/s390x-linux-user.mak b/configs/targets/s390x-linux-user.mak
index 68c2f288724..677ca12e828 100644
--- a/configs/targets/s390x-linux-user.mak
+++ b/configs/targets/s390x-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index 76dd5de6584..6258170ee53 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sh4-linux-user.mak b/configs/targets/sh4-linux-user.mak
index d58c5471b77..cbb3eca483f 100644
--- a/configs/targets/sh4-linux-user.mak
+++ b/configs/targets/sh4-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_HAS_BFLT=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sh4-softmmu.mak b/configs/targets/sh4-softmmu.mak
index 787d349b501..547abc225f6 100644
--- a/configs/targets/sh4-softmmu.mak
+++ b/configs/targets/sh4-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=sh4
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sh4eb-linux-user.mak b/configs/targets/sh4eb-linux-user.mak
index 99007f0f2d6..c09c571e893 100644
--- a/configs/targets/sh4eb-linux-user.mak
+++ b/configs/targets/sh4eb-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_HAS_BFLT=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sh4eb-softmmu.mak b/configs/targets/sh4eb-softmmu.mak
index cdea2c61c58..5d56cf79f3f 100644
--- a/configs/targets/sh4eb-softmmu.mak
+++ b/configs/targets/sh4eb-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sh4
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/sparc-linux-user.mak
index 4ff4b7287d2..1b4ee80fe17 100644
--- a/configs/targets/sparc-linux-user.mak
+++ b/configs/targets/sparc-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 57801faf1fc..f02bacb8bbf 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index 7a16934fd17..75c3a600bf0 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/sparc64-linux-user.mak
index 7c2ecb7be06..1b75d276426 100644
--- a/configs/targets/sparc64-linux-user.mak
+++ b/configs/targets/sparc64-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index d9d51d21e59..bfa1bcfb427 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricore-softmmu.mak
index 781ce49a62f..cac4eb54154 100644
--- a/configs/targets/tricore-softmmu.mak
+++ b/configs/targets/tricore-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=tricore
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/x86_64-bsd-user.mak b/configs/targets/x86_64-bsd-user.mak
index d62d656f2c6..f1a39573452 100644
--- a/configs/targets/x86_64-bsd-user.mak
+++ b/configs/targets/x86_64-bsd-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index b093ab5a167..ec46e6b1bb2 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-linux.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 5619b2bc686..5658d325f34 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
 TARGET_LONG_BITS=64
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/xtensa-linux-user.mak b/configs/targets/xtensa-linux-user.mak
index cbec6e368af..8c3d6442797 100644
--- a/configs/targets/xtensa-linux-user.mak
+++ b/configs/targets/xtensa-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_HAS_BFLT=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/xtensa-softmmu.mak b/configs/targets/xtensa-softmmu.mak
index 2a9797338a6..82bcc49ad90 100644
--- a/configs/targets/xtensa-softmmu.mak
+++ b/configs/targets/xtensa-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=xtensa
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/xtensaeb-linux-user.mak b/configs/targets/xtensaeb-linux-user.mak
index f455b1c7801..f766d635938 100644
--- a/configs/targets/xtensaeb-linux-user.mak
+++ b/configs/targets/xtensaeb-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_HAS_BFLT=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/xtensaeb-softmmu.mak b/configs/targets/xtensaeb-softmmu.mak
index 5204729af8b..8774e3e5a23 100644
--- a/configs/targets/xtensaeb-softmmu.mak
+++ b/configs/targets/xtensaeb-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=xtensa
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
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


