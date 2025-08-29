Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E4DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiS-0004Eb-IB; Sat, 30 Aug 2025 11:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XH-00038a-S6
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:32 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XF-0002y5-0R
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7723bf02181so237179b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506326; x=1757111126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZ69fieo27ga4u9iCgxP9hhIT5qNBs4sxkqT2Bndt4s=;
 b=MNqdGrc2hW+WrecDDKXJiuq2+tcIwWQicW49S9LwCqItwhq+yzgp0KLEjmMUzPyhe3
 GHX6kVzMePuvnJCGztmXeEnfFw079ioJTvehQbSzNrtvQEfBziZ9RT0HdL319oJ227Gb
 5Pe0Vw4SFdPWycpu95ujcF2uLfUiIjF40OfNeKwjqgEnQgYRhnj6GL/00ESClvJlrFg8
 KY4e0FwPzjahVP2WtqoQcMoIDeFnPO17K1rePKh3mD6nVMo+ZIVXng1ZWPmALhUYp1va
 6Uk9slq/PokNsSnaYFnp845EmQ8C6t5J1kerQCO/Abl520n89uU2R6agUUzHITQCzwAD
 +90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506326; x=1757111126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZ69fieo27ga4u9iCgxP9hhIT5qNBs4sxkqT2Bndt4s=;
 b=Zh+1z9EkO7mh/akYL1JHffQVfEmuAqmIFjXfPyPoIVWnpT2fRsh0V9iWFdoKDSjwL1
 k6gYmUVKI7M0RGbYnAp4oiYy8MJebpbZx7gIRjgl2dn4zqaa17qHlBv+NdUqXjF0L988
 tkX+VLc1WEb5E3p5+HrNtaLTgEmyuQIhmuiXRnMxqX88U2KU5OT3FV2OrhUNx8QT0jYr
 pdL5Zmp3jkNINp1TH6zr70aaoP71+pjy/l+AGbCngHoYUCSEvE3TdK+rZnT6xuNKzz5N
 NIPqeVgzMjVyUmlUFT9z0UJ7WiVTAkNIgirG39vhU5iMwlZ9plExYQx7Pp9u2xPc5Xx4
 p6Lw==
X-Gm-Message-State: AOJu0YyB0Q2tNNBqdTL/0hZsyAMG4rMoScaAk5SnOcd+tBt7pgRBNres
 RQAwaOQ9rjV6okJMZ2uP3Nkl03VdaKCxAq22YClxy9jD68fVfmqaquOmxCjL+1YO1y62dltdCSR
 K0oXxGfE=
X-Gm-Gg: ASbGnctB4m6vG7aCa4YWbFtAsHQLwPSO+Oc81q4/nFpDhqZ/cY5nYtqLU/UgZ9MYYcr
 I7KAYHpYEg9HCxxo2PtEf8zEBn06MtSOzVkNZwcjIsEa8ITdwt4hRM7YkQrIoUGiE0szCFTImiM
 cKpN9JsEHd5PDJ1WNbpnAWwbnnY/UBNGpiTJ9SZImMaiwPloLnlkTyDAH/6jCgqy3z5JT15R34l
 Sndh42ieFomjXdxHYSl2DTMMpcuiFSdOeEtYQ1flienkQKlGo69qfdjHLaE86PK/3LnuPHLc81i
 1VLJ0No++Pb+sb7YuKAliSqwhmZXIF7VmzvC5q4jTlX/oC2ojjgsIe20048qP3H3JZKDtXMo8V+
 4r8AqEX4lZGCeGz+tB4DwHAsPJyvqZEaIQi2mbcr3UErvwT8radgx+vGcMabhfYg2ckb3BJk=
X-Google-Smtp-Source: AGHT+IHXoCHiUkh17itETcYBz3HYtHS1p6uyTOydKlY/p2qT0JnWOKxK/AR214x5gVB8/7gegctbHw==
X-Received: by 2002:a05:6a20:938c:b0:243:a000:5be3 with SMTP id
 adf61e73a8af0-243d6dce65emr339133637.8.1756506326502; 
 Fri, 29 Aug 2025 15:25:26 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 22/91] linux-user: Move elf_core_copy_regs to arm/elfload.c
Date: Sat, 30 Aug 2025 08:23:18 +1000
Message-ID: <20250829222427.289668-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Move elf_core_copy_regs to elfload.c.
Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
For now, duplicate the definitions of target_elf_greg_t and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_elf.h |  8 ++++++++
 linux-user/arm/elfload.c    | 12 ++++++++++++
 linux-user/elfload.c        | 15 ---------------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 856ca41b16..94db3738e8 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -11,5 +11,13 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+#define ELF_NREG                18
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 7de1f13f4b..47fe16a1a6 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -4,6 +4,7 @@
 #include "qemu.h"
 #include "loader.h"
 #include "target/arm/cpu-features.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -199,3 +200,14 @@ const char *get_elf_platform(CPUState *cs)
 
 #undef END
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
+{
+    for (int i = 0; i < 16; ++i) {
+        r->regs[i] = tswapreg(env->regs[i]);
+    }
+    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
+    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e4f821f8c8..72a291e51f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -218,21 +218,6 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-#define ELF_NREG    18
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
-{
-    for (int i = 0; i < 16; ++i) {
-        r->regs[i] = tswapreg(env->regs[i]);
-    }
-    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
-    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 /* The commpage only exists for 32 bit kernels */
-- 
2.43.0


