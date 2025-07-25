Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C10FC87FCF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 23:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufRXB-0002r4-Cf; Fri, 25 Jul 2025 19:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRXA-0002qU-CG
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:09:00 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRX8-0001of-Np
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:09:00 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23694cec0feso24954045ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753484937; x=1754089737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwS5enWBqWLAF6dbF1XYZSIiH0+6jDOiUSGG3x6eJCk=;
 b=XYLhxozxxLd8x9uj0fLeLfKfoUtc8dtxgGRgdIFMhsZ3J/xtAy/SQBVeiCQKn+s+HG
 sfjaKxRHeKGKY570hacUzhej/sLgRyVlLOEyE5m/rRJ6nSuCNqK4+z4g7WIDkep+Mbe7
 3vsXnYjyMQFaoU8+iQzYfoeG6DlUxtjLx16EzJ9WJ2iZs/bbQcmhJLxhWHQ4jQ/0gTvr
 lHYbf3Tsm7bz6rl8fhSvmvFwLG+gCjjdbXCIClvtbLoFkRAGQ+dAFoc7ToN2DJR2eixP
 0tomgKbJMjUfj8rWVnFU1TXNatlbY3KrYwCnjWuAQWv+syfqCHsOYhl3fkWQk3EV8re3
 ciCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753484937; x=1754089737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwS5enWBqWLAF6dbF1XYZSIiH0+6jDOiUSGG3x6eJCk=;
 b=edjaPlTmA6CBGDyQyJOw4BPjDR1chTnTXj1kaZXLLSZXXe9ABa2v/IIchrZx6wvY3V
 t0ow5wLkgoTuiS+0lPuWa+LrnxqKiRSVyIjbZck3qCtzWFoZ1R7gyCTqYyQ0tW8IkPkt
 ZqjH6qTKYhiQH4Pf11BGjO3qi3Rb4wcDLi52sh9Fqi2uUWKHIEKgjxzW3Qg0jNGBvGcH
 xCYxDzWhsAtA/F3setA0BFx7k1U+iVqHarNkfIpQ7zbWKT5HR1nr+DyA3MlAp7VNuPW4
 LFdRnHsf9kWdbLzLApPzgx8aCTgGlmVWf6AYsbWW0Qj8KdZxdYLLBqddJTVDjqxMU9xE
 lgKw==
X-Gm-Message-State: AOJu0YyZpCR+ieBu9eiER6mA5vnqQDqltd2iAgSMOzAbCKV7thgY0Ucj
 dAhaAMjTxOz02rJlB09Roc6G6M2PgMCJO/xzbsyAqz4dmUNPLKh5vYZu1Kkoqc9gFVVd41nBVVR
 rhkDl
X-Gm-Gg: ASbGnctZNZQZ0WlAlsaho2rfT5Hk/V25jHi2mNnBHQv87Gi0sLU545/gbtjZ/BgnIiX
 LxzGjDRav0cZqdoonPXVC055grsajW+h1ip+kE1wiNRAGbUAAm6H520uDIYFfL8PiWLFWtKId0J
 3GNJ6TReWMenz6GMb1OraL+AxiAWiGZOjpaTjnbpDzcjyFlvsci5MCkvU8n9dLvDsI+bURWBheT
 56eWfJwUF2t9RSG0xVxS8/qUQnWrFmX3v/tGgyZKfMb5sI+50yAPds+AP21o8eiEaDpWdMUqzdV
 cxrZahD36+9ssIGKF3qSShHJLka0k1fIoKn1Nei4HYYL/vGqRO8u4tsNsc8D0uCs9pcK0a+tiCP
 7fsHAg+SvwSmOBFNAiQupfepF72VuNdaHa4EW4P1kk9ENw+iq/0SSSezGhOUgFx06hBH7p5Wfto
 LZGfy250feF4WphPpKSmAo
X-Google-Smtp-Source: AGHT+IHzZg9Xatj5BxMqVD8nP1xF0HLa6TbnWyPZ+sAPC9nIj89ZWnTgMagW9M8kslh8ptHKwaLmAQ==
X-Received: by 2002:a17:902:f252:b0:234:ed31:fc94 with SMTP id
 d9443c01a7336-23fb30bb5edmr26394585ad.26.1753484937073; 
 Fri, 25 Jul 2025 16:08:57 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe545368sm5033375ad.172.2025.07.25.16.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 16:08:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 1/3] linux-user/aarch64: Split out signal_for_exception
Date: Fri, 25 Jul 2025 13:08:47 -1000
Message-ID: <20250725230849.13026-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725230849.13026-1-richard.henderson@linaro.org>
References: <20250725230849.13026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 84 ++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index fea43cefa6..85d455d018 100644
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


