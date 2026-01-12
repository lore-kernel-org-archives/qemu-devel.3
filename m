Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29379CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQmo-0004g4-8r; Mon, 12 Jan 2026 17:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmB-0003o0-K7
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:44 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQm9-0003OP-Uz
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:43 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so39930615e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258360; x=1768863160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WfqI5+0qzUAJ631ibyFSkpT2ooyvzfZGYy2XWdRSwMU=;
 b=dKFh3+2awAPdTHl4fdhsJ8svexsvxRKx1IHjispqVC5hCEnbrlD3DgNR9LDS/TuF82
 rEsYOse293f6qzMh6qarFVl7jC6o+ZNTC6TsJXZvu8V1+wX7iPShevfdGuAq99MkQk2F
 8SuQBESZlYbgMkVJA70g7l0VDNP3YDqLoti4cDy96opS0fNwFQ8ks/793fn8Jai+neBn
 zvhb7Q3D8/Ey6xopDahyg/olFt0xgslGZuLzoFcs2DR6+aa5mbLUOGCTXVD54yJ1WL0A
 bpoUvPhRg/oNk6agES4GuAkn96NKYlz5pMJvMdAS72kTfa/PH7Vnlj7cej662kitsuBB
 WLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258360; x=1768863160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WfqI5+0qzUAJ631ibyFSkpT2ooyvzfZGYy2XWdRSwMU=;
 b=EnAeXTbS745C4UgSaQmts8iLJTrkil+rZHwFX0we4AY/g5D2z3mgX7c5GggsON/edE
 LjfPrlh4H30jgfcl8LSzj72yIKMMlqb8tmedUzQeoo+ZKA5771RjQbhXlnkAG00MDCzC
 v/HH26YwcS7ToEiwm5NTW3jQXN1UIfmYknoA5Bn5rBzSJxgScUuoGsldJOPfYyLsQWaw
 eLLFwkzlqNkP9TzkSoFEEw1KMPRhGFqSnCy6ytG/NOhqeQvMFDyiei76fWYhbPGu1Z4h
 HLVoI2uXEnpqmmJXVis0GAnuDYtxXS+MWeSSt6t6wXQLcBKHnjBjRBACor9vZOO0jYIm
 xIWA==
X-Gm-Message-State: AOJu0Yyi7EK6xkJ6W2l512R6sAJl8Dpk2HdlSUZLiJeiYsqNiO7WBW9d
 htVBtalu/Qo7eBdmSr+ojfgS7FKTC7Z89KhjHyaaklYxnSQHSMZLnko2yLa8s1KRo75zRTnJjo6
 G7/xKZYM=
X-Gm-Gg: AY/fxX7cUTJS/jRai2XjNGRhCsoERpOFk37l3cHRuqLKDU1F/2vHs0pX56O53mSO3Un
 xBXLVyaQqTFI85N+4eR7gBoAsb52CFYlZxyT4kS/GO+vmMfX9k0JFLbLcKMPxW+t4+/vCiJgWjc
 7u6KBUaRGrS9AKwONXXRIaDA51FlbRkE3PGdt55Up5JqmWe9bOkkpqgNbvtc9JJsg3qcGDdI29L
 1EgeFFrs/Ap4LMRo0Eqkvd9b3OKS3bxjgiBoNFpGcBp/phiN1XxTIrBvUBdYqKmhg8v+RUB3h1b
 9k3YDsmO14FNuKrYRtrJ6dtQNLHySWpOwlwyero3ZzSvf81/RHxhwT6I1XvF2gZbnnOS/TyXjvs
 Qb1koNR5cBAUSUz8CP8AS/PO+HsiXbwHGAVr0vpC/8iIySmJdgShPksXWcDW2etNbDYl5LPSWex
 c31oYwGwh3TXDuHK67H+kg1itXyP6wsZPmgiarq0xEeFuPAg++M8b9kDaBRbCf
X-Google-Smtp-Source: AGHT+IHgrpnNYTwsAj/0DqyZbRQNK6viiFHb5YPnfeLxYe19b8Dqkx5vtO3XR2vzxfEGFdQ068J7+g==
X-Received: by 2002:a05:600c:a48:b0:47a:829a:ebb with SMTP id
 5b1f17b1804b1-47d84b36a2amr208176595e9.19.1768258360074; 
 Mon, 12 Jan 2026 14:52:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f7035f2sm358394075e9.12.2026.01.12.14.52.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:52:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/61] target/m68k: Replace MD_TLONG -> MD_I32 in monitor.c
Date: Mon, 12 Jan 2026 23:48:27 +0100
Message-ID: <20260112224857.42068-33-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

m68k's monitor_defs[] array implicitly uses type=MD_TLONG for
all its entries. Since we only build this target as 32-bit,
use the explicit MD_I32 type to avoid an indirect target_long
use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260107200702.54582-10-philmd@linaro.org>
---
 target/m68k/monitor.c | 60 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 2bdf6acae0a..161f41853ec 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -23,36 +23,36 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 }
 
 static const MonitorDef monitor_defs[] = {
-    { "d0", offsetof(CPUM68KState, dregs[0]) },
-    { "d1", offsetof(CPUM68KState, dregs[1]) },
-    { "d2", offsetof(CPUM68KState, dregs[2]) },
-    { "d3", offsetof(CPUM68KState, dregs[3]) },
-    { "d4", offsetof(CPUM68KState, dregs[4]) },
-    { "d5", offsetof(CPUM68KState, dregs[5]) },
-    { "d6", offsetof(CPUM68KState, dregs[6]) },
-    { "d7", offsetof(CPUM68KState, dregs[7]) },
-    { "a0", offsetof(CPUM68KState, aregs[0]) },
-    { "a1", offsetof(CPUM68KState, aregs[1]) },
-    { "a2", offsetof(CPUM68KState, aregs[2]) },
-    { "a3", offsetof(CPUM68KState, aregs[3]) },
-    { "a4", offsetof(CPUM68KState, aregs[4]) },
-    { "a5", offsetof(CPUM68KState, aregs[5]) },
-    { "a6", offsetof(CPUM68KState, aregs[6]) },
-    { "a7", offsetof(CPUM68KState, aregs[7]) },
-    { "pc", offsetof(CPUM68KState, pc) },
-    { "sr", offsetof(CPUM68KState, sr) },
-    { "ssp", offsetof(CPUM68KState, sp[0]) },
-    { "usp", offsetof(CPUM68KState, sp[1]) },
-    { "isp", offsetof(CPUM68KState, sp[2]) },
-    { "sfc", offsetof(CPUM68KState, sfc) },
-    { "dfc", offsetof(CPUM68KState, dfc) },
-    { "urp", offsetof(CPUM68KState, mmu.urp) },
-    { "srp", offsetof(CPUM68KState, mmu.srp) },
-    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
-    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
-    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
-    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
-    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
+    { "d0", offsetof(CPUM68KState, dregs[0]), NULL, MD_I32 },
+    { "d1", offsetof(CPUM68KState, dregs[1]), NULL, MD_I32 },
+    { "d2", offsetof(CPUM68KState, dregs[2]), NULL, MD_I32 },
+    { "d3", offsetof(CPUM68KState, dregs[3]), NULL, MD_I32 },
+    { "d4", offsetof(CPUM68KState, dregs[4]), NULL, MD_I32 },
+    { "d5", offsetof(CPUM68KState, dregs[5]), NULL, MD_I32 },
+    { "d6", offsetof(CPUM68KState, dregs[6]), NULL, MD_I32 },
+    { "d7", offsetof(CPUM68KState, dregs[7]), NULL, MD_I32 },
+    { "a0", offsetof(CPUM68KState, aregs[0]), NULL, MD_I32 },
+    { "a1", offsetof(CPUM68KState, aregs[1]), NULL, MD_I32 },
+    { "a2", offsetof(CPUM68KState, aregs[2]), NULL, MD_I32 },
+    { "a3", offsetof(CPUM68KState, aregs[3]), NULL, MD_I32 },
+    { "a4", offsetof(CPUM68KState, aregs[4]), NULL, MD_I32 },
+    { "a5", offsetof(CPUM68KState, aregs[5]), NULL, MD_I32 },
+    { "a6", offsetof(CPUM68KState, aregs[6]), NULL, MD_I32 },
+    { "a7", offsetof(CPUM68KState, aregs[7]), NULL, MD_I32 },
+    { "pc", offsetof(CPUM68KState, pc), NULL, MD_I32 },
+    { "sr", offsetof(CPUM68KState, sr), NULL, MD_I32 },
+    { "ssp", offsetof(CPUM68KState, sp[0]), NULL, MD_I32 },
+    { "usp", offsetof(CPUM68KState, sp[1]), NULL, MD_I32 },
+    { "isp", offsetof(CPUM68KState, sp[2]), NULL, MD_I32 },
+    { "sfc", offsetof(CPUM68KState, sfc), NULL, MD_I32 },
+    { "dfc", offsetof(CPUM68KState, dfc), NULL, MD_I32 },
+    { "urp", offsetof(CPUM68KState, mmu.urp), NULL, MD_I32 },
+    { "srp", offsetof(CPUM68KState, mmu.srp), NULL, MD_I32 },
+    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]), NULL, MD_I32 },
+    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]), NULL, MD_I32 },
+    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]), NULL, MD_I32 },
+    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]), NULL, MD_I32 },
+    { "mmusr", offsetof(CPUM68KState, mmu.mmusr), NULL, MD_I32 },
     { NULL },
 };
 
-- 
2.52.0


