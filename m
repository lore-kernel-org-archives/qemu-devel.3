Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C773FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOCY-0008AU-B0; Wed, 25 Feb 2026 18:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCO-00089s-Um
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:44 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCN-0004NF-1j
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:44 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43770c94dfaso201437f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061701; x=1772666501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3DLoTKLygsNC2czWhDSGu2a29ae0ql/RSaplYlZuvHA=;
 b=UnLNldV+OtFrGK6UnjtD6EL3Bn99l8lQQbaEh8AWh3tXnVgoCmCWIeq/onrV+efxbp
 58/dUh+g4wHZuFWipv3Zyo2v8INEMUH3i0bgCdJLJ5l3VKbcIocRl3o98bfnqKkZMe6L
 TQkZt61TM8k0MPb7NjJYD3f3HscJBAls6EfGSC7oBgJNsyOZjfzRTYrF1cLgo12ckNnT
 BZh4A5J6eA7tt/qu4w52WmbjtI1wY+WFLBuOZlQHyBNxNUkHuoBKQmCSvKR+2myaHZhJ
 u9gbe6AkWzk1vr7KjFml1zj6eLROeE12RVQeltkRMQXGwvrt5dwys0F3kjdgY6LF9JNC
 CkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061701; x=1772666501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3DLoTKLygsNC2czWhDSGu2a29ae0ql/RSaplYlZuvHA=;
 b=CqYHhYMdgnN/3KOa1Qm5dT5paXX4AKBkQHFdh08EguPeGk469FvcziA/w5BtYZjNWS
 P47lHA4cMe/UAHEeLUn7sYqqEgzDv8otWNlWIDQ0B7z/pdx3eGzOZbUNHH5w9Rz6mmEs
 jkF+qhOz+aX5Fy5kZSYBycKwY4ajqxgy1Zef6uI4yZyKIqfphv8U/fm8Z1q4qirZUdAn
 gqxNi7hH2imcitkkk9fsikHV/fXrMdZqXVynEGNDEq0zeVqphQr8KuX7kvJIFyYJOSD+
 G+d2NRYhjDe4lXqGs1RNmvp+8awXww+UHafXBFWHBoDDmY1h4DTDFHfEWW8klZQnYv13
 uqKQ==
X-Gm-Message-State: AOJu0Yx451ypExe4lwcRzBfJSdPu87Xb2iJTVItdxEk+QOnD7OnYKUfp
 g8VPiMuPNmS9r/7P8phBFloqkSuwAmisAtiuAC4MzNC9Ir5wWlEn0P/poUFw0FFMt3UzT1hMF41
 tO3cs17U=
X-Gm-Gg: ATEYQzx2VCssKz8bpseyRZF8urIihHiDrsWXHboozJkG2GjQfxRX+1/MtUuf72mv7FQ
 V3UfLl2GcIrR7z8gI+s7riwS5/0KYQDijraTYQ/7TqQZkC0hKYuE3pIYeluOQ4ZiSdhLMWB6285
 Cjm2tMgVGWcnDK/4sWvV1OIHIpJPR75/fET1mociKXFVBc63w2P14YsAOL7yV7uouz+ZXgd+nRw
 CvbepqVP8IstWXJD6vSxJ6NdvmqHYXBtzVIc2keDn1c8vI6MNzEr+WvJgYQFIh7QEjuMraaX/a7
 tFo9if2Qj3+/eAlH/k6bFuSTn4B710uDum8T/rrzXwC2JzOrd/fReIp2AJEotrWfiufCJc2NAUj
 5CPH8bAwiF9GpBbgOmu7MFnKqxA6PbcEvTiKBzKpyhMmKfSH1HwaxOuqqosR13sELBdsalgWYNV
 qNC0gQh5UveK8uJKpl2nJkjbWRznbU5Y42E6+A/PHwH+GeT2cOvrcBn7PkXGdzwAKvp59uDntz
X-Received: by 2002:a05:6000:290f:b0:439:5e4d:baa3 with SMTP id
 ffacd0b85a97d-43997ed6d8emr500527f8f.11.1772061701068; 
 Wed, 25 Feb 2026 15:21:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d54a68sm40708097f8f.39.2026.02.25.15.21.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:21:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 66/70] target-info: Add page_bits_{init,vary}
Date: Thu, 26 Feb 2026 00:14:06 +0100
Message-ID: <20260225231411.96482-67-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Add two fields that will hold TARGET_PAGE_BITS,
TARGET_PAGE_BITS_VARY, TARGET_PAGE_BITS_LEGACY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260217095106.598486-3-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info-impl.h   | 7 +++++++
 configs/targets/aarch64-softmmu.c | 3 +++
 configs/targets/arm-softmmu.c     | 3 +++
 target-info-stub.c                | 9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index e446585bf53..c917d546eab 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -25,6 +25,13 @@ typedef struct TargetInfo {
     const char *machine_typename;
     /* related to TARGET_BIG_ENDIAN definition */
     EndianMode endianness;
+    /*
+     * runtime equivalent of
+     *   TARGET_PAGE_BITS_VARY ? TARGET_PAGE_BITS_LEGACY : TARGET_PAGE_BITS
+     */
+    unsigned page_bits_init;
+    /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
+    bool page_bits_vary;
 } TargetInfo;
 
 /**
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 4e1e2f64da1..82ccb575759 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -10,6 +10,7 @@
 #include "qemu/target-info-impl.h"
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/cpu-param.h"
 
 static const TargetInfo target_info_aarch64_system = {
     .target_name = "aarch64",
@@ -18,6 +19,8 @@ static const TargetInfo target_info_aarch64_system = {
     .cpu_type = TYPE_ARM_CPU,
     .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
+    .page_bits_vary = true,
+    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
 };
 
 const TargetInfo *target_info(void)
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 9b3fdd2854a..18940e51e55 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -10,6 +10,7 @@
 #include "qemu/target-info-impl.h"
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/cpu-param.h"
 
 static const TargetInfo target_info_arm_system = {
     .target_name = "arm",
@@ -18,6 +19,8 @@ static const TargetInfo target_info_arm_system = {
     .cpu_type = TYPE_ARM_CPU,
     .machine_typename = TYPE_TARGET_ARM_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
+    .page_bits_vary = true,
+    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
 };
 
 const TargetInfo *target_info(void)
diff --git a/target-info-stub.c b/target-info-stub.c
index 65220cc7820..896f16e582b 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -23,6 +23,15 @@ static const TargetInfo target_info_stub = {
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
+#ifdef TARGET_PAGE_BITS_VARY
+    .page_bits_vary = true,
+# ifdef TARGET_PAGE_BITS_LEGACY
+    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
+# endif
+#else
+    .page_bits_vary = false,
+    .page_bits_init = TARGET_PAGE_BITS,
+#endif
 };
 
 const TargetInfo *target_info(void)
-- 
2.52.0


