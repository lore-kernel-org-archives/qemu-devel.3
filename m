Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF7EC25B10
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B5h-0002f6-6Y; Wed, 01 May 2024 10:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5f-0002ee-S0
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:47 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5c-00026U-Oa
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:47 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e65a1370b7so64098105ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574263; x=1715179063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jid2brVEKFhU0CMUENvSPUf/xlRDtdQ3X2d2opplfCQ=;
 b=Hbl7SjWiMrAXUMUnTm9vGRQx8D9wPPGkRhcRqUsRZWI+5AIl/NtmaaZvYUPiCfv2Dd
 5wdi/JYYKgjJX8tCY9CVHycbHYeKTrwfXOqD+9QKEhMWWJOabco3mXmlpyZ4mQIqgAnz
 SMJZnrTcLIMPk/IhzEAB0d5M7W1ZDQxq/QLJOf6Bl7aJstYlH4AGmzyJWpy+6RpBUfGu
 oPAWjit7/uSgqXUpYpsdVdDfBptUo7S/cTY2ukp0WSKjShzNZ3QYGt8xwTemG1r16B+R
 837T9I/l0Gsx5qs6ouHhvheXhfBqf8mZgyAB6uRlhvm/oXBqVaafD5PEOVraWYBtCF7T
 4+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574263; x=1715179063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jid2brVEKFhU0CMUENvSPUf/xlRDtdQ3X2d2opplfCQ=;
 b=X2yGHg5qeAQEM0DzV0Xd8s9bAeF8zs0xWTdaMmvH4FGvzvDo6DCVCp9CwsIf2jlg6M
 ma0ihAkFfE0GAJrwn0T7Ok9OiDXy2p7lSLX00iqQiBdmHMMGU1+mYFbo81amI+ftbY8K
 cUYeJpVlfP7J1+y+KLpVMSi82ewLjG49a03cJZPlwcRKAhR76d5TkoVv7B35L4ltdIpO
 8wFpvZZyYHEp7l5UzivCrw0Niq5GZet91Cc8Y1nUZrj+/HYDPIsk40YlPGn5C6D+4fkf
 MA9F4IY07GKDooEDqNsa8qe2+UwBBfTvvC8so13NXhGlAGJSyMm2ZDfW4qK8RrR8htrU
 Exmg==
X-Gm-Message-State: AOJu0Yz8zePB/1aIPQS0gNo5M2VxbVIzJJ7Vptvcb2o8UUkJj0k+8ZVc
 DF4nLpHLhcjeihed2UemH3kBmjFXn4rTIPii535bNnYVTqLu0DT+jaGcBBB+NcdZcu/5GuYQitL
 H
X-Google-Smtp-Source: AGHT+IGjO9Tsp4tnOCSpS5bNxVf2qiP03S6I7AU2WCsarWb0qdLDgD6krwrvmJp2o4QlQZzpeair3Q==
X-Received: by 2002:a17:903:1d2:b0:1e2:ca65:68c2 with SMTP id
 e18-20020a17090301d200b001e2ca6568c2mr3358451plh.51.1714574263267; 
 Wed, 01 May 2024 07:37:43 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/20] tcg: Pass function pointer to tcg_gen_call*
Date: Wed,  1 May 2024 07:37:21 -0700
Message-Id: <20240501143739.10541-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

For normal helpers, read the function pointer from the
structure earlier.  For plugins, this will allow the
function pointer to come from elsewhere.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h             | 21 +++++++++-------
 include/exec/helper-gen.h.inc | 24 ++++++++++++-------
 tcg/tcg.c                     | 45 +++++++++++++++++++----------------
 3 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e4c598428d..8d9f6585ff 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -852,19 +852,22 @@ typedef struct TCGTargetOpDef {
 
 bool tcg_op_supported(TCGOpcode op);
 
-void tcg_gen_call0(TCGHelperInfo *, TCGTemp *ret);
-void tcg_gen_call1(TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
-void tcg_gen_call2(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *);
-void tcg_gen_call3(TCGHelperInfo *, TCGTemp *ret, TCGTemp *,
+void tcg_gen_call0(void *func, TCGHelperInfo *, TCGTemp *ret);
+void tcg_gen_call1(void *func, TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
+void tcg_gen_call2(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *);
-void tcg_gen_call4(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
-                   TCGTemp *, TCGTemp *);
-void tcg_gen_call5(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
+void tcg_gen_call3(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *, TCGTemp *);
-void tcg_gen_call6(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
+void tcg_gen_call4(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *);
-void tcg_gen_call7(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
+void tcg_gen_call5(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *);
+void tcg_gen_call6(void *func, TCGHelperInfo *, TCGTemp *ret,
+                   TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *,
+                   TCGTemp *, TCGTemp *);
+void tcg_gen_call7(void *func, TCGHelperInfo *, TCGTemp *ret,
+                   TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *,
+                   TCGTemp *, TCGTemp *, TCGTemp *);
 
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
diff --git a/include/exec/helper-gen.h.inc b/include/exec/helper-gen.h.inc
index d9fd3ed72a..dabe138e20 100644
--- a/include/exec/helper-gen.h.inc
+++ b/include/exec/helper-gen.h.inc
@@ -14,7 +14,8 @@
 extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-    tcg_gen_call0(&glue(helper_info_, name), dh_retvar(ret));           \
+    tcg_gen_call0(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret));            \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
@@ -22,7 +23,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
-    tcg_gen_call1(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call1(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1));                                       \
 }
 
@@ -31,7 +33,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
-    tcg_gen_call2(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call2(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2));                        \
 }
 
@@ -40,7 +43,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
-    tcg_gen_call3(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call3(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
 }
 
@@ -50,7 +54,8 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
     dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
 {                                                                       \
-    tcg_gen_call4(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call4(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2),                         \
                   dh_arg(t3, 3), dh_arg(t4, 4));                        \
 }
@@ -61,7 +66,8 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
 {                                                                       \
-    tcg_gen_call5(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call5(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5));                        \
 }
@@ -72,7 +78,8 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
 {                                                                       \
-    tcg_gen_call6(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call6(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6));         \
 }
@@ -84,7 +91,8 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
     dh_arg_decl(t7, 7))                                                 \
 {                                                                       \
-    tcg_gen_call7(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call7(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),          \
                   dh_arg(t7, 7));                                       \
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6a32656cd4..7484a07722 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2251,7 +2251,8 @@ bool tcg_op_supported(TCGOpcode op)
 
 static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs);
 
-static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
+static void tcg_gen_callN(void *func, TCGHelperInfo *info,
+                          TCGTemp *ret, TCGTemp **args)
 {
     TCGv_i64 extend_free[MAX_CALL_IARGS];
     int n_extend = 0;
@@ -2329,7 +2330,7 @@ static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
             g_assert_not_reached();
         }
     }
-    op->args[pi++] = (uintptr_t)info->func;
+    op->args[pi++] = (uintptr_t)func;
     op->args[pi++] = (uintptr_t)info;
     tcg_debug_assert(pi == total_args);
 
@@ -2345,56 +2346,58 @@ static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
     }
 }
 
-void tcg_gen_call0(TCGHelperInfo *info, TCGTemp *ret)
+void tcg_gen_call0(void *func, TCGHelperInfo *info, TCGTemp *ret)
 {
-    tcg_gen_callN(info, ret, NULL);
+    tcg_gen_callN(func, info, ret, NULL);
 }
 
-void tcg_gen_call1(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1)
+void tcg_gen_call1(void *func, TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1)
 {
-    tcg_gen_callN(info, ret, &t1);
+    tcg_gen_callN(func, info, ret, &t1);
 }
 
-void tcg_gen_call2(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1, TCGTemp *t2)
+void tcg_gen_call2(void *func, TCGHelperInfo *info, TCGTemp *ret,
+                   TCGTemp *t1, TCGTemp *t2)
 {
     TCGTemp *args[2] = { t1, t2 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
-void tcg_gen_call3(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
-                   TCGTemp *t2, TCGTemp *t3)
+void tcg_gen_call3(void *func, TCGHelperInfo *info, TCGTemp *ret,
+                   TCGTemp *t1, TCGTemp *t2, TCGTemp *t3)
 {
     TCGTemp *args[3] = { t1, t2, t3 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
-void tcg_gen_call4(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
-                   TCGTemp *t2, TCGTemp *t3, TCGTemp *t4)
+void tcg_gen_call4(void *func, TCGHelperInfo *info, TCGTemp *ret,
+                   TCGTemp *t1, TCGTemp *t2, TCGTemp *t3, TCGTemp *t4)
 {
     TCGTemp *args[4] = { t1, t2, t3, t4 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
-void tcg_gen_call5(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
+void tcg_gen_call5(void *func, TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
                    TCGTemp *t2, TCGTemp *t3, TCGTemp *t4, TCGTemp *t5)
 {
     TCGTemp *args[5] = { t1, t2, t3, t4, t5 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
-void tcg_gen_call6(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1, TCGTemp *t2,
-                   TCGTemp *t3, TCGTemp *t4, TCGTemp *t5, TCGTemp *t6)
+void tcg_gen_call6(void *func, TCGHelperInfo *info, TCGTemp *ret,
+                   TCGTemp *t1, TCGTemp *t2, TCGTemp *t3,
+                   TCGTemp *t4, TCGTemp *t5, TCGTemp *t6)
 {
     TCGTemp *args[6] = { t1, t2, t3, t4, t5, t6 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
-void tcg_gen_call7(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
+void tcg_gen_call7(void *func, TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
                    TCGTemp *t2, TCGTemp *t3, TCGTemp *t4,
                    TCGTemp *t5, TCGTemp *t6, TCGTemp *t7)
 {
     TCGTemp *args[7] = { t1, t2, t3, t4, t5, t6, t7 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
 static void tcg_reg_alloc_start(TCGContext *s)
-- 
2.34.1


