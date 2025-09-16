Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A5ACAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4N-0002lK-SA; Tue, 16 Sep 2025 14:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4K-0002dm-7h
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:20 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4H-0001Yf-FH
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:19 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso3455056f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045976; x=1758650776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zbL/G8mN2BNh+V2oSHOnBLz0A1pT2V/TomDGK0lNimw=;
 b=PgQgk4G3bmyZBx8geKyxTf9lZO0s3IsC6ccceWwjWyafI429AG0tXsSO06gyiT9RL7
 R5sDKyC3SnkAhE+k0OxspLLaIjiq+A8CurbdCdHI1cGWB2jZOYEas9GTGnGcNygyQkiH
 iX3gUrDbVFJSZmExvM7h1D6ji+z72TC7+X9UKs4WRAyWiHrNVVA8Kt0Mim7tIsz3xe9N
 XqRazD4YeJtUO3uddALEL8qERPzb7BU3Od39ZIMc1RaDFkHq4uWXuQDuVEhdkvAzS7cQ
 xDceVz1dsMac3dgKpLthbVWbjvwDSlNbMwW63iiM6D5FQynW6f+tbTLC5P9QqW/e+kiI
 V3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045976; x=1758650776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbL/G8mN2BNh+V2oSHOnBLz0A1pT2V/TomDGK0lNimw=;
 b=n86UZK9jmJycLZsEgC2XOAK7G4DpApxMqD3xCXCoobvgQDaxlYJab//G0UcV4wkgoL
 myLsTUOP2vlFy92yne5EwUji/shsxMkaMP6yEB/NQwdWqGOg8dPqTzMiWUqmOc3iwCW7
 cTbWAhWynakGksIeub/7lSXTpz0yg99nJ0WBgBi+iPCAz3AQP5v51vRI8hPZ3Nr+bGXR
 K6ZbvcT6IM+lHuj7/5rslDLWVyYZ+Z6I8TGx09KZafbLEOQj1hFCZc3ffCCkhddQAqz9
 Jh4quLXI8CMGj1y/Q357W9NKsxd4v4ksDV7K5tpA5ByA4cyDMtcRSoADrMFvyqTTY+ct
 B9FQ==
X-Gm-Message-State: AOJu0Yyy/hsiDTu1Ifw5U+TlkX2bRHbdDelIrsEMNlfdeYiPkVsgkKBH
 k1y42YGmrZPxPzIO8E5JDnqTpk9s44I/3c+D0jhSxxrQrj92u4fThZK6YFzlCE4SSna4Z4AXF3U
 dW7+Q
X-Gm-Gg: ASbGncsxE/u7IQKWcq1AC8btSoQYCe095CvKZLFz7WCwhjfUvY24WeTkw7C2xljV1+T
 xCNUVL3BYQhabJTE81tNKC3JcKaWHScpw6L5GXmdQuQkLBO5TfMc18iIJmCo+H4ISPT+cy1lHsR
 SEQdixcaHO5Aa9FpeniXs7Jt3L+KFDnaWOaFC6MQrjGYuvMFbLAqBCKZ9rsHdlpyYzO0a01CtbT
 ii8NSS+oGubaJQmBabQtuB7G6rqk8uwK2nKUGUVW4UhAxg6kEgdDx4dAivlDRfB7IYLgLsQ7ES1
 +2N2L7oGy8ZRNcAan8cVObABLOTJN9wr6Cm7zNmtFX8KLZIOSDIbnGp2kvjO7tAgT5Tlrshe2rm
 Rc1dVyQFdcOusFRo4TepPu7Hoo4LH
X-Google-Smtp-Source: AGHT+IEp6/dwwajpe+FRuQNNVtDgHZqJ/OeRex+EWDCBedEQ4yyTT1c9HEeEyTLi/2gz/UDifwlzpA==
X-Received: by 2002:a05:6000:4006:b0:3eb:bbd9:9c08 with SMTP id
 ffacd0b85a97d-3ebbbd9a3bbmr6596029f8f.46.1758045975841; 
 Tue, 16 Sep 2025 11:06:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/36] linux-user/aarch64: Split out signal_for_exception
Date: Tue, 16 Sep 2025 19:05:36 +0100
Message-ID: <20250916180611.1481266-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 84 ++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 4c4921152e8..3b2782581b6 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -27,11 +27,56 @@
 #include "target/arm/syndrome.h"
 #include "target/arm/cpu-features.h"
 
+/* Use the exception syndrome to map a cpu exception to a signal. */
+static void signal_for_exception(CPUARMState *env, vaddr addr)
+{
+    uint32_t syn = env->exception.syndrome;
+    int si_code, si_signo;
+
+    switch (syn_get_ec(syn)) {
+    case EC_DATAABORT:
+    case EC_INSNABORT:
+        /* Both EC have the same format for FSC, or close enough. */
+        switch (extract32(syn, 0, 6)) {
+        case 0x04 ... 0x07: /* Translation fault, level {0-3} */
+            si_signo = TARGET_SIGSEGV;
+            si_code = TARGET_SEGV_MAPERR;
+            break;
+        case 0x09 ... 0x0b: /* Access flag fault, level {1-3} */
+        case 0x0d ... 0x0f: /* Permission fault, level {1-3} */
+            si_signo = TARGET_SIGSEGV;
+            si_code = TARGET_SEGV_ACCERR;
+            break;
+        case 0x11: /* Synchronous Tag Check Fault */
+            si_signo = TARGET_SIGSEGV;
+            si_code = TARGET_SEGV_MTESERR;
+            break;
+        case 0x21: /* Alignment fault */
+            si_signo = TARGET_SIGBUS;
+            si_code = TARGET_BUS_ADRALN;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case EC_PCALIGNMENT:
+        si_signo = TARGET_SIGBUS;
+        si_code = TARGET_BUS_ADRALN;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    force_sig_fault(si_signo, si_code, addr);
+}
+
 /* AArch64 main loop */
 void cpu_loop(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
-    int trapnr, ec, fsc, si_code, si_signo;
+    int trapnr;
     abi_long ret;
 
     for (;;) {
@@ -67,42 +112,7 @@ void cpu_loop(CPUARMState *env)
             break;
         case EXCP_PREFETCH_ABORT:
         case EXCP_DATA_ABORT:
-            ec = syn_get_ec(env->exception.syndrome);
-            switch (ec) {
-            case EC_DATAABORT:
-            case EC_INSNABORT:
-                /* Both EC have the same format for FSC, or close enough. */
-                fsc = extract32(env->exception.syndrome, 0, 6);
-                switch (fsc) {
-                case 0x04 ... 0x07: /* Translation fault, level {0-3} */
-                    si_signo = TARGET_SIGSEGV;
-                    si_code = TARGET_SEGV_MAPERR;
-                    break;
-                case 0x09 ... 0x0b: /* Access flag fault, level {1-3} */
-                case 0x0d ... 0x0f: /* Permission fault, level {1-3} */
-                    si_signo = TARGET_SIGSEGV;
-                    si_code = TARGET_SEGV_ACCERR;
-                    break;
-                case 0x11: /* Synchronous Tag Check Fault */
-                    si_signo = TARGET_SIGSEGV;
-                    si_code = TARGET_SEGV_MTESERR;
-                    break;
-                case 0x21: /* Alignment fault */
-                    si_signo = TARGET_SIGBUS;
-                    si_code = TARGET_BUS_ADRALN;
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
-            case EC_PCALIGNMENT:
-                si_signo = TARGET_SIGBUS;
-                si_code = TARGET_BUS_ADRALN;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            force_sig_fault(si_signo, si_code, env->exception.vaddress);
+            signal_for_exception(env, env->exception.vaddress);
             break;
         case EXCP_DEBUG:
         case EXCP_BKPT:
-- 
2.43.0


