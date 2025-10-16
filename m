Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C4BCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mzn-0007Eb-Vn; Thu, 16 Oct 2025 08:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyT-00055R-Qw
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyL-0000Q9-4z
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so7395625e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617235; x=1761222035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qj4tTUxS05lEabuFj3O1YAjM2wGI4ZJXhCwlzCfh6Ek=;
 b=uW8adXHMSqBM4gLEHoNH2pqXRu8gijae45OuHUEsRP1PCEvKACrNCLRKC8kg29KI0K
 aS1YRKvlf9ACnESUcaQW8lLlvAyKKNH8J5NJGOSJDE10VeS3rIm/fDfFnhIuUADDmttW
 Nr+FbH/y0W0obZ/RRQYbilbiQ/a52EgH0DytSYzl4DjpW+Rky8weWzkPqn3qqK66VEwY
 gO2e2CrrS5/E/IWLHig35y7RIkaSCf9fRwfWtPqRHX7rF6OR7/+0MsqEGBkAwkhHL0mp
 P/2VoZx4OmQfYIlDXmJc7fnRoofAA53JD8T5XtodRILFKPSpYbD8YB7rOb4JCQaQT55k
 ZJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617235; x=1761222035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qj4tTUxS05lEabuFj3O1YAjM2wGI4ZJXhCwlzCfh6Ek=;
 b=D+/VjbFuZAhesupMK2ymNuCvUAG+A2/IyHzqnwWmFutE4BKiTz1We/kryDVHPXNSAO
 StnzSLKkW7Tr8XMfVxg/1z0qmqwrKdatis/CQssPcVQf+KtCGhmI2M9LdRqFWSTvJPMP
 AQdsEuReH+Ufqa7PFEiToMPkOWMSmLGj34AofkG0txOTYwv+6RvoqcKCgS1EskV8ELkH
 bvTH21DqvxwW5O55l4811nnVDYaHyPf/wpubzPc+jeAFXB83fFSTSq2zf9mh6JCl10Gp
 lnSUZTaXnPpT/38so78KFDiM1R0H3Fl0hG/SujJyRk7SBo23dK8BmWuo3G5c+WlUy21W
 4FPg==
X-Gm-Message-State: AOJu0Yw2Tk8UIB+OYKZ+xIDi2KptwvySsLcpHahSmqVQFygF2sIvu2Nz
 LoVvBMvtkQG4+V8w5vZijfE0d3yxdZZWYuiSrMqoEgYlcwqanRg3rXHzWLlOosh/TcrTaFOcDWq
 oisXQlfI=
X-Gm-Gg: ASbGncsvCH00nmakx7z9lJD4zJiGTZ+FD6Yr8TDa7d/F++oGDe1IsdSYrFTkkplvhLN
 bVtxWQxbhSiFyP0Fobx/dB0jlB35gaKgWkh6eZjJ/+emKgeJqNs8r21Wylb5+kVY52732jDZKix
 kcJZlWFX9zikHREZWwypeIu8vJu2YqKOS13sbo4MkcxZLGIRXZJJlsjpnaff3MzMm5/0hY1naRp
 2khMetkRRhlNQlDApgXa0ziOsr1hVYrPuXc3r+5Xlf/ToIUbGLXOPHIr2pQ5iRhwF6NI714ftZp
 w2M5xS5pkE2n4snAca/76Gv2TutmRzXYKGGqBJZwSjob3W+ktLmh7Gwak9TEf6p1YkLQJTqMslH
 jlZzpvhy+1ABid1fo6VtXOTwEZFyZgUyFi8XSMM3/7ldgte+luqhRMA8fGnf0dkZlHyJWxcsDgQ
 fzUtKWmPKOgrCV9tK53A1Xm9Q0LoDyG9G6R67Pbh5W2YASqRu9L1FDjOB1QuK031gZ
X-Google-Smtp-Source: AGHT+IEI14KKZjLAXOmcnJgD82VZUB66qagn5zXk4dqEa5PDFTrE/H97LKqmHUaY/PNW2PmF64ZiAg==
X-Received: by 2002:a05:600c:4750:b0:45f:28d2:bd38 with SMTP id
 5b1f17b1804b1-46fa9af3095mr248694385e9.18.1760617235430; 
 Thu, 16 Oct 2025 05:20:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1024sm34166906f8f.42.2025.10.16.05.20.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/75] target/tricore: Declare registers as TCGv_i32
Date: Thu, 16 Oct 2025 14:15:21 +0200
Message-ID: <20251016121532.14042-66-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

CPUTriCoreState register are declared as uint32_t since the
target introduction in commit 48e06fe0ed8 ("target-tricore:
Add target stubs and qom-cpu").

Mechanical replacement of:

  TCGv -> TCGv_i32
  tcg_temp_new -> tcg_temp_new_i32

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-8-philmd@linaro.org>
---
 target/tricore/translate.c | 82 +++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 116f45135bb..112a1b9a12e 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -44,19 +44,19 @@
 /*
  * TCG registers
  */
-static TCGv cpu_PC;
-static TCGv cpu_PCXI;
-static TCGv cpu_PSW;
-static TCGv cpu_ICR;
+static TCGv_i32 cpu_PC;
+static TCGv_i32 cpu_PCXI;
+static TCGv_i32 cpu_PSW;
+static TCGv_i32 cpu_ICR;
 /* GPR registers */
-static TCGv cpu_gpr_a[16];
-static TCGv cpu_gpr_d[16];
+static TCGv_i32 cpu_gpr_a[16];
+static TCGv_i32 cpu_gpr_d[16];
 /* PSW Flag cache */
-static TCGv cpu_PSW_C;
-static TCGv cpu_PSW_V;
-static TCGv cpu_PSW_SV;
-static TCGv cpu_PSW_AV;
-static TCGv cpu_PSW_SAV;
+static TCGv_i32 cpu_PSW_C;
+static TCGv_i32 cpu_PSW_V;
+static TCGv_i32 cpu_PSW_SV;
+static TCGv_i32 cpu_PSW_AV;
+static TCGv_i32 cpu_PSW_SAV;
 
 static const char *regnames_a[] = {
       "a0"  , "a1"  , "a2"  , "a3" , "a4"  , "a5" ,
@@ -8480,14 +8480,14 @@ void cpu_state_reset(CPUTriCoreState *env)
 
 static void tricore_tcg_init_csfr(void)
 {
-    cpu_PCXI = tcg_global_mem_new(tcg_env,
-                          offsetof(CPUTriCoreState, PCXI), "PCXI");
-    cpu_PSW = tcg_global_mem_new(tcg_env,
-                          offsetof(CPUTriCoreState, PSW), "PSW");
-    cpu_PC = tcg_global_mem_new(tcg_env,
-                          offsetof(CPUTriCoreState, PC), "PC");
-    cpu_ICR = tcg_global_mem_new(tcg_env,
-                          offsetof(CPUTriCoreState, ICR), "ICR");
+    cpu_PCXI = tcg_global_mem_new_i32(tcg_env,
+                                      offsetof(CPUTriCoreState, PCXI), "PCXI");
+    cpu_PSW = tcg_global_mem_new_i32(tcg_env,
+                                     offsetof(CPUTriCoreState, PSW), "PSW");
+    cpu_PC = tcg_global_mem_new_i32(tcg_env,
+                                    offsetof(CPUTriCoreState, PC), "PC");
+    cpu_ICR = tcg_global_mem_new_i32(tcg_env,
+                                     offsetof(CPUTriCoreState, ICR), "ICR");
 }
 
 void tricore_tcg_init(void)
@@ -8496,30 +8496,32 @@ void tricore_tcg_init(void)
 
     /* reg init */
     for (i = 0 ; i < 16 ; i++) {
-        cpu_gpr_a[i] = tcg_global_mem_new(tcg_env,
-                                          offsetof(CPUTriCoreState, gpr_a[i]),
-                                          regnames_a[i]);
+        cpu_gpr_a[i] = tcg_global_mem_new_i32(tcg_env,
+                                              offsetof(CPUTriCoreState,
+                                                       gpr_a[i]),
+                                              regnames_a[i]);
     }
     for (i = 0 ; i < 16 ; i++) {
-        cpu_gpr_d[i] = tcg_global_mem_new(tcg_env,
-                                  offsetof(CPUTriCoreState, gpr_d[i]),
-                                           regnames_d[i]);
+        cpu_gpr_d[i] = tcg_global_mem_new_i32(tcg_env,
+                                              offsetof(CPUTriCoreState,
+                                                       gpr_d[i]),
+                                              regnames_d[i]);
     }
     tricore_tcg_init_csfr();
     /* init PSW flag cache */
-    cpu_PSW_C = tcg_global_mem_new(tcg_env,
-                                   offsetof(CPUTriCoreState, PSW_USB_C),
-                                   "PSW_C");
-    cpu_PSW_V = tcg_global_mem_new(tcg_env,
-                                   offsetof(CPUTriCoreState, PSW_USB_V),
-                                   "PSW_V");
-    cpu_PSW_SV = tcg_global_mem_new(tcg_env,
-                                    offsetof(CPUTriCoreState, PSW_USB_SV),
-                                    "PSW_SV");
-    cpu_PSW_AV = tcg_global_mem_new(tcg_env,
-                                    offsetof(CPUTriCoreState, PSW_USB_AV),
-                                    "PSW_AV");
-    cpu_PSW_SAV = tcg_global_mem_new(tcg_env,
-                                     offsetof(CPUTriCoreState, PSW_USB_SAV),
-                                     "PSW_SAV");
+    cpu_PSW_C = tcg_global_mem_new_i32(tcg_env,
+                                       offsetof(CPUTriCoreState, PSW_USB_C),
+                                       "PSW_C");
+    cpu_PSW_V = tcg_global_mem_new_i32(tcg_env,
+                                       offsetof(CPUTriCoreState, PSW_USB_V),
+                                       "PSW_V");
+    cpu_PSW_SV = tcg_global_mem_new_i32(tcg_env,
+                                        offsetof(CPUTriCoreState, PSW_USB_SV),
+                                        "PSW_SV");
+    cpu_PSW_AV = tcg_global_mem_new_i32(tcg_env,
+                                        offsetof(CPUTriCoreState, PSW_USB_AV),
+                                        "PSW_AV");
+    cpu_PSW_SAV = tcg_global_mem_new_i32(tcg_env,
+                                         offsetof(CPUTriCoreState, PSW_USB_SAV),
+                                         "PSW_SAV");
 }
-- 
2.51.0


