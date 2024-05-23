Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E85C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 16:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAB7I-0005D6-JI; Thu, 23 May 2024 12:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6q-000519-OJ
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:12 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6m-0002Ya-17
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f44a2d1e3dso2609750b3a.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716480956; x=1717085756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFTOPbft/bN6xCHi2Bkanbe02vp6jJNJx4gYp69CKLg=;
 b=AkwPplFpKjPkli1pbEyYxf9G4VH7CliMvQwUv91ENFosjo3mB5nliDnXrNkFNgkGNA
 /A0r9KoI158FeP0Y4OXLobL1xi20W6LpPIoryUULB8KbnoTSDLWG4y3TueQL/4hOh1Pt
 7JD6ZqYPeYQZB1KE5ICy3RITAGftM/ru2fSLD0gQVLWxD3Am5BPHGHovZAJNosWFv20m
 /6gdUWK0eA6iVObvK8yumFFvr8wC9Fdkarl+eF2Fr75RtT2ZY04OoLEJrDOzwfKFSs6r
 kJlczEyz4EVrRI+cw7ujl/kLzAyKc63FoQWIMGrqrEKTFMhgITIVT++W89Frmf8BgU6v
 Y3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716480956; x=1717085756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XFTOPbft/bN6xCHi2Bkanbe02vp6jJNJx4gYp69CKLg=;
 b=QYvWfYha6bG/h8nBmPe41aW+KT+6LLJAeHtMHZ0pAfVDzxhZa+BTYrdse/me3jpzzG
 l76ddl2uqCw9NQrjmD4arnLDasd6Q8e1TAMcOwwJ4YZxpHDgDo2X7oE/aLyNkHZN4rox
 xBw8/NVECACbkMV3AvL59/+AjvxMWy5ApHSYrxX7brdby52Ihrq8DyBT7jsOvwhFiyE2
 x5dZY/qxmSaA9Y1mw68yU36hxcxATsxrcTYv1oSq9J9ZzHpl8shZPY8rbo11mo3MRBSs
 Uy67A+lDk02Q4bouFQdWQuGR5cvYmdfPWmKgLh/sgDzVvaUJZ4bF3b3Rqr7mh8GECdZS
 InEw==
X-Gm-Message-State: AOJu0YxPJSinv32UAQSy4Y9QAkt9EjzuC1/dtoxqq8F4GXRXB8hU66S2
 3HDA0ta+S5FwMRANPj1C8sRinHzWoOivoEI47+iVdI9QKRy2jAsOnR4drJxpxqaoCN7rMTSSqcs
 b
X-Google-Smtp-Source: AGHT+IFN/WtFEd3t9uvdQkfa9vxO6YJoT3Z9VlkZOwOp314IRHmkDJ9CHUcRivqFaI1tAH1d1ZL/AQ==
X-Received: by 2002:a05:6a00:929b:b0:6e6:98bf:7b62 with SMTP id
 d2e1a72fcca58-6f6d60dfae6mr6467087b3a.8.1716480955890; 
 Thu, 23 May 2024 09:15:55 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a9d9acsm24890255b3a.90.2024.05.23.09.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 09:15:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] tcg: Introduce TCG_TARGET_HAS_tst_vec
Date: Thu, 23 May 2024 09:15:49 -0700
Message-Id: <20240523161553.774673-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523161553.774673-1-richard.henderson@linaro.org>
References: <20240523161553.774673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Prelude to supporting TCG_COND_TST* in vector comparisons.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            | 1 +
 tcg/aarch64/tcg-target.h     | 1 +
 tcg/arm/tcg-target.h         | 1 +
 tcg/i386/tcg-target.h        | 1 +
 tcg/loongarch64/tcg-target.h | 1 +
 tcg/ppc/tcg-target.h         | 1 +
 tcg/s390x/tcg-target.h       | 1 +
 7 files changed, 7 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 2a1c080bab..21d5884741 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -155,6 +155,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_minmax_vec       0
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 85d5746e47..138bafb9da 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -167,6 +167,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index a43875cb09..434a892e07 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -150,6 +150,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index a10d4e1fce..2f67a97e05 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -224,6 +224,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
 #define TCG_TARGET_HAS_cmpsel_vec       -1
+#define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index fede627bf7..29e4860d20 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -194,6 +194,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 04a7aba4d3..e154fb14df 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -173,6 +173,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_vsx
 #define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index ae448c3a3a..62ce9d792a 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -163,6 +163,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_minmax_vec     1
 #define TCG_TARGET_HAS_bitsel_vec     1
 #define TCG_TARGET_HAS_cmpsel_vec     0
+#define TCG_TARGET_HAS_tst_vec        0
 
 /* used for function call generation */
 #define TCG_TARGET_STACK_ALIGN		8
-- 
2.34.1


