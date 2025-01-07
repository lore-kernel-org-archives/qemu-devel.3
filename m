Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E86DE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xt-0001YU-On; Tue, 07 Jan 2025 03:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X9-0000Kp-3j
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:51 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X3-0002yj-JB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:47 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ef89dbd8eeso16448734a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236904; x=1736841704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLyu0Rx7tniTMn6hD6piwrODigz5OqSwTwFKViDS+vs=;
 b=QaszvH6H0BSBl/QOR6ChN9OEE7QBVUADKVRlYMsYS+fZfatGGKwhC5XQsNmrTCbE2S
 pVGEYkmGvUuR1QgSQRKq28eDin9jvl8XfiC9sgadSFwfJSbAci/dzOpj4TgiKpIUtZl9
 2SoQWAXx/Et76Mb1+zPEKKnEaFB7VvDd7lNQ078rBHBDnqQpz1jD2rgIf5xcf1Ja+t0W
 LulKBU18Is+Q1dde1c3GPzheOIQX3toMFlKPv2cJGrjCEA3xON3V7ZfpCIudR4pApGMz
 GxLbV0OeTSouTtVkHx9LGqcREIHQz8McsiiyqAKdL2Shg6XsYVvcf+LK/T/vz+B7Wimc
 ab3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236904; x=1736841704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLyu0Rx7tniTMn6hD6piwrODigz5OqSwTwFKViDS+vs=;
 b=GmVU/ynHbFyee8UG4zplBLfIHJPlGaOR/alIin3b/VIZpNy5Ojhg0OzuL015N8Kaww
 9sm9YmKL0eOG0bX/+aJYMR4VQRQs2dS/53DVK4tGit8N1AcEmFNfXbT73q0BoZ98ZAkG
 7IPvrHpwW9mChbVehB0cyibfNqJLL43XcBsss6t3GXuAy8nkiephbhoUiPCwsuuiKDhf
 ugmTFrnGUkh2x7G8Kt3llh0oKDfaB1zCzHDeIe60PmtZVhSxYkHIxP8Y2cxvGMrUwS7w
 AQDDfBZdWqJ3ftyo3DltxZasZW7uV0O2545VKmULVk8KtGjT7R+jx/tiMYgm2RbexqBb
 BzKQ==
X-Gm-Message-State: AOJu0YwuEAxph4eDIWSdgyMcThi/KRWlFGr3EoAImOSTiR+DOMh2U7TJ
 niPGf7EpnQ+Hpp8OAiQHTU4SmPakFqgQG7coNSWRJ3qQMFre3oNq4P7o8SOawJeMsqggOai3u5t
 i
X-Gm-Gg: ASbGnctUU+IxipYd7tMI7T7fmxkQh6TRG6T5Kc5yC7OhFu7r+zWbOldnHXGtmCRlfy/
 Dn77zaiFFWnqTLmntqN1mZQ816lJcoMUvP0kc0hrYm9PUStoEc9Tb6XrvhK970BQ6MaoJv1TA2G
 SIcEUfdD+YBBBHon1BxTsbUfCUnMyU1ZeR6N8VdM/jM42xb5cVsgHZSNRGx/XNftg4cvIMKIwSt
 gXh5qfMfpRc202l7QtXAcniKr2WcMOpgxfoYpLkcKmz/ca/VpGe2ozWuzZ0FU2s4co5hxl1NFW5
 qamho2Sn072xakHI9Q==
X-Google-Smtp-Source: AGHT+IEbi4gMKkbGo0l34JPb/Hj4SlkrLn/uPgoGRfqkv3TPVXN4E56IyhrCOGKq6yX69SDxFEB/Gw==
X-Received: by 2002:a17:90b:2d4c:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-2f452ec290emr84452710a91.25.1736236904240; 
 Tue, 07 Jan 2025 00:01:44 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 29/81] tcg: Remove TCG_OPF_64BIT
Date: Tue,  7 Jan 2025 00:00:20 -0800
Message-ID: <20250107080112.1175095-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

This flag is no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h | 22 +++++++++++-----------
 include/tcg/tcg.h     |  2 --
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 724e7a9de8..eb17a21f21 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -37,9 +37,9 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 
 #define IMPL(X) (__builtin_constant_p(X) && (X) <= 0 ? TCG_OPF_NOT_PRESENT : 0)
 #if TCG_TARGET_REG_BITS == 32
-# define IMPL64  TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT
+# define IMPL64  TCG_OPF_NOT_PRESENT
 #else
-# define IMPL64  TCG_OPF_64BIT
+# define IMPL64  0
 #endif
 
 DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
@@ -110,7 +110,7 @@ DEF(clz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_clz_i32))
 DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
 DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
 
-DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
+DEF(mov_i64, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, IMPL64)
 DEF(negsetcond_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_negsetcond_i64))
 DEF(movcond_i64, 1, 4, 1, IMPL64)
@@ -206,18 +206,18 @@ DEF(qemu_ld_a32_i32, 1, 1, 1,
 DEF(qemu_st_a32_i32, 0, 1 + 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_ld_a32_i64, DATA64_ARGS, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a32_i64, 0, DATA64_ARGS + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 DEF(qemu_ld_a64_i32, 1, DATA64_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a64_i32, 0, 1 + DATA64_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_ld_a64_i64, DATA64_ARGS, DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a64_i64, 0, DATA64_ARGS + DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Only used by i386 to cope with stupid register constraints. */
 DEF(qemu_st8_a32_i32, 0, 1 + 1, 1,
@@ -229,16 +229,16 @@ DEF(qemu_st8_a64_i32, 0, 1 + DATA64_ARGS, 1,
 
 /* Only for 64-bit hosts at the moment. */
 DEF(qemu_ld_a32_i128, 2, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
     IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
 DEF(qemu_ld_a64_i128, 2, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
     IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
 DEF(qemu_st_a32_i128, 0, 3, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
     IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
 DEF(qemu_st_a64_i128, 0, 3, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
     IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
 
 /* Host vector support.  */
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 1b8bb49aa8..d57cd8a810 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -699,8 +699,6 @@ enum {
     /* Instruction has side effects: it cannot be removed if its outputs
        are not used, and might trigger exceptions.  */
     TCG_OPF_SIDE_EFFECTS = 0x08,
-    /* Instruction operands are 64-bits (otherwise 32-bits).  */
-    TCG_OPF_64BIT        = 0x10,
     /* Instruction is optional and not implemented by the host, or insn
        is generic and should not be implemented by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x20,
-- 
2.43.0


