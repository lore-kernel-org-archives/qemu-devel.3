Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC29E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4b5-0002Ap-Vw; Tue, 07 Jan 2025 03:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aL-0000Kg-OD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:17 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aD-0003Le-Qg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:07 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21631789fcdso162839335ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237100; x=1736841900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIM8q57Dg+aT1NLOwIU9Hlx+n02I0UIsaBRFnPIQTh4=;
 b=IrAqFeWvKnZn7lEDF+Fp5QkYw5noPurF2JVd/ArthyhliimVdKY0UfCobC+RH/sxGO
 YTcn46lPcGBqsRMuCWbB8KESrEYoC7qvtBmgpSb+XKYHNLvEGIowUpIMRmomQ+tNg6Nc
 LXCfmv2O1OSn5GItnE9hOjrgUxiKoebnwnFC88KNny7jCx4jGHwJwerfoEyTZtGYGZ71
 qZYn5rH/Dgri6nfBS3N7l6VSzU+i0xJQLQ77Lrvhn6oHH0yrxQnetVzMkrVrupfU7NP5
 DSbKgI3b+G/aviMAwHmRoitkv0qSoQdkq1pLqhOKw500I7aI69cUYOcM4H6UpNP5vIyN
 9tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237100; x=1736841900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIM8q57Dg+aT1NLOwIU9Hlx+n02I0UIsaBRFnPIQTh4=;
 b=E7NQN8O4CbasJaQQo3gdDBWVrg1N/FPyRZbBVPIMt5JC7dA49u+UjW4UT9zZT4Iy3D
 C91oRP5L1oN94EvGmJfADYwt+o5voGVIDHtHeMQo/fgxzapAH7PwQw1PVFH0JEY7ZD+H
 YvkMieeYkhoaji/30bjrYE4o92lxPOcUDpL3I/dZGlIHtzkhSJf+1Syt4ju6R1MjN31e
 cLVlQVwgyTskaBhYal2XrsF47t2OhorCLh1aSehs3hRIqLIssYORD4bywxCU6u4gY8I6
 ldKvm9e5pojshBkXB7TQEnPCfsTKiXttvVbln+HaV11psTgxxiCGpT2LFeemCENlnOYU
 m7zg==
X-Gm-Message-State: AOJu0YxBXwaXHedYt3HyrBozjTHmuejyt9Ea9zBkzYEdpmz1i+Y2/64a
 1DNUazfiHX7uzXe0vaapXlIj0sTZ996eMpdbA1ncUP92LvzWSNT1fUrq+7BwSsSnHc+CWMMvU3j
 V
X-Gm-Gg: ASbGncuzpzoGZcWFdXSPkY/iUKeuqYC3Ws6vwBrsH1Cx40F83bdqEWsg2t+IXlBbqEC
 E3tcQIHa4TpUjGSXi3V8f9akbAUv483wFjTKeT21y/x4VoWqli9W7jxscboi8hSnLuz/inw3i3k
 GN/W6CAU6HH3mWgVsNC/krMjJVIpdiBENT8StXKxdySbWmQiuNiq6Tp5L649qdb36+hXPxePJ3z
 D2UWpJZt39BAXM4ezIH3pnQVyB2wL0rd5in9bOV920+cnfnJEBYDtOIlj5Y9wzVi/r7D8DbmvdG
 tU4z8YXWdz76zCxK8w==
X-Google-Smtp-Source: AGHT+IEqPnx33/ai9LG5FotF/aoy4w0f60QTpttzepJf0Y5JYd5p6PyX9NcioDtm76OUifMqumecfg==
X-Received: by 2002:a05:6a00:1381:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-72d103b553fmr3541648b3a.5.1736237100195; 
 Tue, 07 Jan 2025 00:05:00 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:04:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 42/81] tcg/riscv: Use SRAIW, SRLIW for {s}extract_i64
Date: Tue,  7 Jan 2025 00:00:33 -0800
Message-ID: <20250107080112.1175095-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Extracts which abut bit 32 may use 32-bit shifts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-has.h | 24 +++++++-----------------
 tcg/riscv/tcg-target.c.inc | 16 ++++++++++++----
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 5bf62c7c7f..e890546c3a 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -112,31 +112,21 @@
 static inline bool
 tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 {
-    if (ofs == 0) {
-        switch (len) {
-        case 16:
-            return cpuinfo & CPUINFO_ZBB;
-        case 32:
-            return (cpuinfo & CPUINFO_ZBA) && type == TCG_TYPE_I64;
-        }
+    if (type == TCG_TYPE_I64 && ofs + len == 32) {
+        /* ofs > 0 uses SRLIW; ofs == 0 uses add.uw. */
+        return ofs || (cpuinfo & CPUINFO_ZBA);
     }
-    return false;
+    return (cpuinfo & CPUINFO_ZBB) && ofs == 0 && len == 16;
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 {
-    if (ofs == 0) {
-        switch (len) {
-        case 8:
-        case 16:
-            return cpuinfo & CPUINFO_ZBB;
-        case 32:
-            return type == TCG_TYPE_I64;
-        }
+    if (type == TCG_TYPE_I64 && ofs + len == 32) {
+        return true;
     }
-    return false;
+    return (cpuinfo & CPUINFO_ZBB) && ofs == 0 && (len == 8 || len == 16);
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index fc93900c6d..4f6e18f59e 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2344,8 +2344,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_extract_i64:
-        if (a2 == 0 && args[3] == 32) {
-            tcg_out_ext32u(s, a0, a1);
+        if (a2 + args[3] == 32) {
+            if (a2 == 0) {
+                tcg_out_ext32u(s, a0, a1);
+            } else {
+                tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2);
+            }
             break;
         }
         /* FALLTHRU */
@@ -2358,8 +2362,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_sextract_i64:
-        if (a2 == 0 && args[3] == 32) {
-            tcg_out_ext32s(s, a0, a1);
+        if (a2 + args[3] == 32) {
+            if (a2 == 0) {
+                tcg_out_ext32s(s, a0, a1);
+            } else {
+                tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2);
+            }
             break;
         }
         /* FALLTHRU */
-- 
2.43.0


