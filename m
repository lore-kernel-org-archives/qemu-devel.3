Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B87BC28B24
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqrP-0000MX-9p; Wed, 05 Mar 2025 10:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqr9-0000B7-VA
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:25 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqr8-0002Yd-0r
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:23 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso3709630f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189220; x=1741794020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYDAc70iCmEcsaAQpim9Lu0U9CfOBiddFcVryIIgw1c=;
 b=YkMY0QYPt/LvwyelHu9FWgbr6h6iETjtGO5oUtRKzVuRdXJmU0MvggKrPQ5nos1x/r
 UDjkG3fCKv0GXa8tPhFJcDUXJ/DZQN7ppa6/8+8GUmRgpVA+ReWCWLu2bgGLzzNtgGGI
 XTYYcDLf6mmjzy1Di5Ir2qgO/4ih5bb25/0HtyYCDzUOqNDHUiou5DIf0y3utI4RVy4d
 4yP0ArNp9ef4YAvAoMN43bd6X84Z4j1kfmJx9LFdiyidgxQ9axqLyv2ujgdtTjxWtJUL
 NgdzieO6bH2fKwXUFGt8CwdCyiSzg1PLQPJHQ/58sPhcdtaun1T+Vno55fTTc/nQN1Wu
 ZB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189220; x=1741794020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYDAc70iCmEcsaAQpim9Lu0U9CfOBiddFcVryIIgw1c=;
 b=QTZLQa2MnORvXC34Q59v14NuKZCuIkY1E/wtoyzS73Yci5Y5UjNAkEbGWnwrz9fBmj
 wwVlC4CMKbzEerpwr487HMW8pjc3BbcICLSNP2VJcNA4EW7sa/iSR/vTFeRjf1DKEN2x
 lpu1y3W45WtxDuT0k9IdjIdr0/9YmIMS9jUoHTBj/1v73eSjwja97RdJrKLapdXrbALl
 tmf40EAuwAy7TamKGTG8dw5l2ZngyLjY0OeTH8W+e6sYU6ry3OomIGnm6RJci6DGL3vf
 rfLo0uMjpioOdkwTPqQ4rW0lpRRh0Yxlo93WxxqM5fCVYlttCBfaDk8bSgpgu+iiIyeK
 PNww==
X-Gm-Message-State: AOJu0Yw7degxVPtBDUT/WVO7/U8pHvL9aOKV3CLtAMO46srizBzXeA3c
 JQRP9oi/v/fq1YVLQDPXX6j0UqHrpffc7cq2v25jMndtrpf4myEm6FhelQ0GnIfDZ0ZN8a9iv/e
 Redo=
X-Gm-Gg: ASbGnctSjetN0JxQCsUTkEQMMm3FZt/rjeIWjnbzoDc0Lqk7h6aks788h/f8ooRnaoT
 D1bmE48/au18JGf0iaFRJgmBNSRzibyn1uMryS364EE/r8mvKS+TXebQbPQdxeT32mLWv7Z+4oZ
 JE4E/0Jwy/ELtX/hXY6wloaaJF2MkpPs8rKHRBW1W5GxtnVAsk5S93N1WUdfBBV2PDi/XL44Duj
 305RemwBjtQFBIFPu4UqM+ETOia1eMH66j9ChclosOaQcZ9SUtmq3e7nkg0YGBzOiHOg/VoRYgw
 qe4zE6Pb52TnXrAYqHeBBQjDvlXvGZ6JHweerz5PqiJCHinI16t87tYE8TxRZ0e/12maF2ToTGA
 EOVrwytjiveO8c1mlsuY=
X-Google-Smtp-Source: AGHT+IHroEkV8P6Vz2KqqECLrWsyC5n3bWV3S4dxFGiwdRq/c7o7hZuQb8VuOSVRyA0UAd26buKBew==
X-Received: by 2002:a05:6000:1869:b0:390:fbba:e64b with SMTP id
 ffacd0b85a97d-3911f789f82mr4109789f8f.31.1741189220035; 
 Wed, 05 Mar 2025 07:40:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485dbe7sm21577111f8f.93.2025.03.05.07.40.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 10/18] qemu: Introduce legacy_binary_is_big_endian() helper
Date: Wed,  5 Mar 2025 16:39:20 +0100
Message-ID: <20250305153929.43687-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
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

Introduce legacy_binary_endianness() to return the endianness
of a legacy binary, and legacy_binary_is_big_endian() being
equivalent of compile time TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/legacy_binary_info.h |  8 ++++++
 legacy_binary_info.c              | 43 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/qemu/legacy_binary_info.h b/include/qemu/legacy_binary_info.h
index 2d42e852b7a..18886a05402 100644
--- a/include/qemu/legacy_binary_info.h
+++ b/include/qemu/legacy_binary_info.h
@@ -9,9 +9,17 @@
 #ifndef QEMU_LEGACY_BINARY_INFO_H
 #define QEMU_LEGACY_BINARY_INFO_H
 
+#include "qapi/qapi-types-common.h"
+
 void legacy_binary_info_init(const char *argv0);
 
 /* Return runtime equivalent of TARGET_LONG_BITS == 64 check */
 bool legacy_binary_is_64bit(void);
 
+/* Return runtime equivalent of TARGET_BIG_ENDIAN definition */
+bool legacy_binary_is_big_endian(void);
+
+/* Return endianness of legacy binary */
+EndianMode legacy_binary_endianness(void);
+
 #endif
diff --git a/legacy_binary_info.c b/legacy_binary_info.c
index be50d3f50ea..c9a8e99699e 100644
--- a/legacy_binary_info.c
+++ b/legacy_binary_info.c
@@ -9,10 +9,12 @@
 #include "qemu/osdep.h"
 #include "qemu/arch_info.h"
 #include "qemu/legacy_binary_info.h"
+#include "qapi/qapi-types-common.h"
 
 typedef struct LegacyBinaryInfo {
     const char *binary_name;
     QemuArchBit arch_bit;
+    EndianMode endianness;
     unsigned long_bits;
 } LegacyBinaryInfo;
 
@@ -21,146 +23,175 @@ static const LegacyBinaryInfo legacy_binary_infos[] = {
     {
         .binary_name = "qemu-system-aarch64",
         .arch_bit = QEMU_ARCH_BIT_ARM,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-alpha",
         .arch_bit = QEMU_ARCH_BIT_ALPHA,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-arm",
         .arch_bit = QEMU_ARCH_BIT_ARM,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-avr",
         .arch_bit = QEMU_ARCH_BIT_AVR,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-hppa",
         .arch_bit = QEMU_ARCH_BIT_HPPA,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-i386",
         .arch_bit = QEMU_ARCH_BIT_I386,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-loongarch64",
         .arch_bit = QEMU_ARCH_BIT_LOONGARCH,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-m68k",
         .arch_bit = QEMU_ARCH_BIT_M68K,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-microblaze",
         .arch_bit = QEMU_ARCH_BIT_MICROBLAZE,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-microblazeel",
         .arch_bit = QEMU_ARCH_BIT_MICROBLAZE,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-mips",
         .arch_bit = QEMU_ARCH_BIT_MIPS,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-mips64",
         .arch_bit = QEMU_ARCH_BIT_MIPS,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-mips64el",
         .arch_bit = QEMU_ARCH_BIT_MIPS,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-mipsel",
         .arch_bit = QEMU_ARCH_BIT_MIPS,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-or1k",
         .arch_bit = QEMU_ARCH_BIT_OPENRISC,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-ppc",
         .arch_bit = QEMU_ARCH_BIT_PPC,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-ppc64",
         .arch_bit = QEMU_ARCH_BIT_PPC,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-riscv32",
         .arch_bit = QEMU_ARCH_BIT_RISCV,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-riscv64",
         .arch_bit = QEMU_ARCH_BIT_RISCV,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-rx",
         .arch_bit = QEMU_ARCH_BIT_RX,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-s390x",
         .arch_bit = QEMU_ARCH_BIT_S390X,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-sh4",
         .arch_bit = QEMU_ARCH_BIT_SH4,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-sh4eb",
         .arch_bit = QEMU_ARCH_BIT_SH4,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-sparc",
         .arch_bit = QEMU_ARCH_BIT_SPARC,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-sparc64",
         .arch_bit = QEMU_ARCH_BIT_SPARC,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-tricore",
         .arch_bit = QEMU_ARCH_BIT_TRICORE,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-x86_64",
         .arch_bit = QEMU_ARCH_BIT_I386,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-xtensa",
         .arch_bit = QEMU_ARCH_BIT_XTENSA,
+        .endianness = ENDIAN_MODE_LITTLE,
         .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-xtensaeb",
         .arch_bit = QEMU_ARCH_BIT_XTENSA,
+        .endianness = ENDIAN_MODE_BIG,
         .long_bits = 32,
     },
 };
@@ -182,6 +213,7 @@ void legacy_binary_info_init(const char *argv0)
     for (size_t i = 0; i < ARRAY_SIZE(legacy_binary_infos); i++) {
         if (!strcmp(legacy_binary_infos[i].binary_name, binary_name)) {
             assert(legacy_binary_infos[i].long_bits);
+            assert(legacy_binary_infos[i].endianness != ENDIAN_MODE_UNSPECIFIED);
             current_index = i;
             return;
         }
@@ -195,3 +227,14 @@ bool legacy_binary_is_64bit(void)
     assert(current_index != -1);
     return legacy_binary_infos[current_index].long_bits == 64;
 }
+
+EndianMode legacy_binary_endianness(void)
+{
+    assert(current_index != -1);
+    return legacy_binary_infos[current_index].endianness;
+}
+
+bool legacy_binary_is_big_endian(void)
+{
+    return legacy_binary_endianness() == ENDIAN_MODE_BIG;
+}
-- 
2.47.1


