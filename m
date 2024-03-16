Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388D0C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 02:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJIs-0002lv-Qt; Fri, 15 Mar 2024 21:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIq-0002l6-La
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:40 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIj-0000ht-Ef
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:35 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29e0229d6b5so711239a91.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554251; x=1711159051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dO/ulOB4H8uJBhCl1h5X1j8smU5S71009KZPyttGPV8=;
 b=sYlrfHAwPX+dQigzS46ZO84vvi54+j2px48b3iUHUt76jzC4dAlgu0OyQiMHApxe3g
 XM4UayPBHdAMkrHkFb9efPIJft6jWAghgT2n91cfqj3v0AhmgUN/4/tHhk3fx5UvYDvU
 Uy1roKF7TtnYZDVYBl4N4KxIASDG++FJxEmlMmMPWlHiQWmqJ7g1AasuJJucRVTYb378
 6PUFb79FyPg+Epu+P2CDei1PaggwCTxnpc7kYB62UyKDKvJKnqi+ChM6JH4Q+tEAeTZH
 S0h2yaUGIfYLNy4iuW8ryaIb4+yU3oExlIazo4QaWiB9nC5r5FDR6z3PjIkqLs6/WSaN
 v8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554251; x=1711159051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dO/ulOB4H8uJBhCl1h5X1j8smU5S71009KZPyttGPV8=;
 b=WpShWlCTG3LKwUz6uXOkd9LS9cO0TSRBT6KL6xaIZcBnVwRZkTotBDBkwnj1JTUYXt
 c8CWVXvzJ0Rh8nwrkGIAzVF5hjuGviQZ4c1Ov2zPS8PLUQKlQq2h9S7O4fE1qG1dbrqv
 Fy7Y0CdiUO/nkj1/k61L852yMiU4/5LdQMgSg6mwxdVxvOUqexsMt2YynS+LLrsOJHVV
 rupbAHjxSAJ0kerlaM3bojOF6Em/XmO+nnoLLd3q59bCOHBsSmt2ZBna2q9IkRax+tc8
 B7BSCygeP3TwfW0WRye08l2GDWgURCqbsK5gWfT/o6yr0jlWZybZuBjQk1lBQ3KR43z+
 1NMQ==
X-Gm-Message-State: AOJu0YxyDH/XX6yh1MSRuFZp8VXqh2ZYeji2NpggGPU6eIV69vrgVBZE
 o4w50T9IsAvb0YT3c02EYLj56y9/8P9LInc2aAV0Vtz8JNc8A8yTpkqG/16Ce9aFmE8qDsSfp3B
 9
X-Google-Smtp-Source: AGHT+IGBDrdJC9kk4z4yR0J0OcWEVDTK7+QxgPd65ycopAfZbDjQpjnyR7nt9t8al/wOBzqMxR09Aw==
X-Received: by 2002:a17:902:f7d3:b0:1dd:b505:d556 with SMTP id
 h19-20020a170902f7d300b001ddb505d556mr5377907plw.21.1710554251553; 
 Fri, 15 Mar 2024 18:57:31 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 03/22] tcg: Pass function pointer to tcg_gen_call*
Date: Fri, 15 Mar 2024 15:57:01 -1000
Message-Id: <20240316015720.3661236-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h             | 21 +++++++++-------
 include/exec/helper-gen.h.inc | 24 ++++++++++++-------
 tcg/tcg.c                     | 45 +++++++++++++++++++----------------
 3 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a6e7df146a..95a7f4d010 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -847,19 +847,22 @@ typedef struct TCGTargetOpDef {
 
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
index c009641517..f7eb59b6c1 100644
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
index 0c0bb9d169..0bf218314b 100644
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


