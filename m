Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551F3C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPk-0005ft-Oh; Fri, 28 Jun 2024 13:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPh-0005fP-O0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPf-0002EB-6Z
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QfPlkzAs6rsHhlewBnoT9acE//vGyzsRmxi7a5l5ZQw=;
 b=WRQ7+OF3IMc93RT9dTsvLsjbke7qLippQTU15Hx9IqfH1HPw4q8GxZpSsgwx0m2ICcej/f
 nTs5QWVxSuIFEVbkySDBekBAXCk697CXjc1wZr2w2mznj1g65+7N3tWOwzuX5FJnDXDSNM
 7H9ZdFLmBRfASy1sUVXRjAhvAKd7rgI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-0oyQnOc6Nt28fGWWYEhg5g-1; Fri, 28 Jun 2024 13:29:29 -0400
X-MC-Unique: 0oyQnOc6Nt28fGWWYEhg5g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57cad6e94e5so655566a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595767; x=1720200567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QfPlkzAs6rsHhlewBnoT9acE//vGyzsRmxi7a5l5ZQw=;
 b=KBAHYJv7q8cKd2rAeU4rwAe2qDJF1kjE3sGIHw4xCDGBBbHyY89jtTyTjiOGCStHlA
 /OujMTwDunuNs264UzWSaKeHKXRtCW5ze5ZROgsTFC2d/NgYayxw5p8fC9jKebpDjtrz
 KIFSkMsmdKaUGKKKWCIk0huqOOPaBuMYSY0bMRH/O2rRQsnArUu0z6olsD48VmloKref
 box8nIbONnWWB2EdN6K3nCXtxmplhTExXBn14Kzkjbsucr8AyU5EPrxFKMT7h1izEY/N
 83hDtWlNXbLxptSoHY7RgMMU7GoguwYXuhOSHpzR30rVjq2ViUbtQZ3CPigYqm86exgT
 TQ9g==
X-Gm-Message-State: AOJu0YyK+oPCSLAD84GrMQNQdq/gFBWI+2v7bDfOTFt75reflRmYOG4S
 A50OS1NALgcA16s3qVEROkZ8kL1l2fX7QUj3uR09rDtu1WvutbciSYIPEbKpnAWbdcJI4fJAWL6
 AKYkSMpkEPpoXaaKIFNSDmGESpD87PMElXYRpNyTZgLx0YRNymRLWkUV0yMjEoRtgtJQFtRmCXc
 dxNbnL9xBQDKdu3W3oOgAvYzGiIlo/ITLJGN85
X-Received: by 2002:a50:a69d:0:b0:57d:3791:e8e1 with SMTP id
 4fb4d7f45d1cf-57d4bde09cemr12004351a12.36.1719595766667; 
 Fri, 28 Jun 2024 10:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Af0/BdshL/SI4nNDR3kR4XB/x7OSG/J0PJ0knYTnfBjfPYrujix9tJMcKYdJOKryBt1gGQ==
X-Received: by 2002:a50:a69d:0:b0:57d:3791:e8e1 with SMTP id
 4fb4d7f45d1cf-57d4bde09cemr12004334a12.36.1719595766274; 
 Fri, 28 Jun 2024 10:29:26 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861503b4c5sm1253186a12.93.2024.06.28.10.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 13/23] include: move typeof_strip_qual to compiler.h,
 use it in QAPI_LIST_LENGTH()
Date: Fri, 28 Jun 2024 19:28:45 +0200
Message-ID: <20240628172855.1147598-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The typeof_strip_qual() is most useful for the atomic fetch-and-modify
operations in atomic.h, but it can be used elsewhere as well.  For example,
QAPI_LIST_LENGTH() assumes that the argument is not const, which is not a
requirement.

Move the macro to compiler.h and, while at it, move it under #ifndef
__cplusplus to emphasize that it uses C-only constructs.  A C++ version
of typeof_strip_qual() using type traits is possible[1], but beyond the
scope of this patch because the little C++ code that is in QEMU does not
use QAPI.

The patch was tested by changing the declaration of strv_from_str_list()
in qapi/qapi-type-helpers.c to:

    char **strv_from_str_list(const strList *const list)

This is valid C code, and it fails to compile without this change.

[1] https://lore.kernel.org/qemu-devel/20240624205647.112034-1-flwu@google.com/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/util.h     |  2 +-
 include/qemu/atomic.h   | 42 -------------------------------------
 include/qemu/compiler.h | 46 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index 20dfea8a545..b8254247b8d 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -62,7 +62,7 @@ int parse_qapi_name(const char *name, bool complete);
 #define QAPI_LIST_LENGTH(list)                                      \
     ({                                                              \
         size_t _len = 0;                                            \
-        typeof(list) _tail;                                         \
+        typeof_strip_qual(list) _tail;                              \
         for (_tail = list; _tail != NULL; _tail = _tail->next) {    \
             _len++;                                                 \
         }                                                           \
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 99110abefb3..dc4118ddd9e 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -20,48 +20,6 @@
 /* Compiler barrier */
 #define barrier()   ({ asm volatile("" ::: "memory"); (void)0; })
 
-/* The variable that receives the old value of an atomically-accessed
- * variable must be non-qualified, because atomic builtins return values
- * through a pointer-type argument as in __atomic_load(&var, &old, MODEL).
- *
- * This macro has to handle types smaller than int manually, because of
- * implicit promotion.  int and larger types, as well as pointers, can be
- * converted to a non-qualified type just by applying a binary operator.
- */
-#define typeof_strip_qual(expr)                                                    \
-  typeof(                                                                          \
-    __builtin_choose_expr(                                                         \
-      __builtin_types_compatible_p(typeof(expr), bool) ||                          \
-        __builtin_types_compatible_p(typeof(expr), const bool) ||                  \
-        __builtin_types_compatible_p(typeof(expr), volatile bool) ||               \
-        __builtin_types_compatible_p(typeof(expr), const volatile bool),           \
-        (bool)1,                                                                   \
-    __builtin_choose_expr(                                                         \
-      __builtin_types_compatible_p(typeof(expr), signed char) ||                   \
-        __builtin_types_compatible_p(typeof(expr), const signed char) ||           \
-        __builtin_types_compatible_p(typeof(expr), volatile signed char) ||        \
-        __builtin_types_compatible_p(typeof(expr), const volatile signed char),    \
-        (signed char)1,                                                            \
-    __builtin_choose_expr(                                                         \
-      __builtin_types_compatible_p(typeof(expr), unsigned char) ||                 \
-        __builtin_types_compatible_p(typeof(expr), const unsigned char) ||         \
-        __builtin_types_compatible_p(typeof(expr), volatile unsigned char) ||      \
-        __builtin_types_compatible_p(typeof(expr), const volatile unsigned char),  \
-        (unsigned char)1,                                                          \
-    __builtin_choose_expr(                                                         \
-      __builtin_types_compatible_p(typeof(expr), signed short) ||                  \
-        __builtin_types_compatible_p(typeof(expr), const signed short) ||          \
-        __builtin_types_compatible_p(typeof(expr), volatile signed short) ||       \
-        __builtin_types_compatible_p(typeof(expr), const volatile signed short),   \
-        (signed short)1,                                                           \
-    __builtin_choose_expr(                                                         \
-      __builtin_types_compatible_p(typeof(expr), unsigned short) ||                \
-        __builtin_types_compatible_p(typeof(expr), const unsigned short) ||        \
-        __builtin_types_compatible_p(typeof(expr), volatile unsigned short) ||     \
-        __builtin_types_compatible_p(typeof(expr), const volatile unsigned short), \
-        (unsigned short)1,                                                         \
-      (expr)+0))))))
-
 #ifndef __ATOMIC_RELAXED
 #error "Expecting C11 atomic ops"
 #endif
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c797f0d4572..554c5ce7df7 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -227,4 +227,50 @@
 #define SECOND_ARG(first, second, ...) second
 #define IS_EMPTY_(junk_maybecomma)     SECOND_ARG(junk_maybecomma 1, 0)
 
+#ifndef __cplusplus
+/*
+ * Useful in macros that need to declare temporary variables.  For example,
+ * the variable that receives the old value of an atomically-accessed
+ * variable must be non-qualified, because atomic builtins return values
+ * through a pointer-type argument as in __atomic_load(&var, &old, MODEL).
+ *
+ * This macro has to handle types smaller than int manually, because of
+ * implicit promotion.  int and larger types, as well as pointers, can be
+ * converted to a non-qualified type just by applying a binary operator.
+ */
+#define typeof_strip_qual(expr)                                                    \
+  typeof(                                                                          \
+    __builtin_choose_expr(                                                         \
+      __builtin_types_compatible_p(typeof(expr), bool) ||                          \
+        __builtin_types_compatible_p(typeof(expr), const bool) ||                  \
+        __builtin_types_compatible_p(typeof(expr), volatile bool) ||               \
+        __builtin_types_compatible_p(typeof(expr), const volatile bool),           \
+        (bool)1,                                                                   \
+    __builtin_choose_expr(                                                         \
+      __builtin_types_compatible_p(typeof(expr), signed char) ||                   \
+        __builtin_types_compatible_p(typeof(expr), const signed char) ||           \
+        __builtin_types_compatible_p(typeof(expr), volatile signed char) ||        \
+        __builtin_types_compatible_p(typeof(expr), const volatile signed char),    \
+        (signed char)1,                                                            \
+    __builtin_choose_expr(                                                         \
+      __builtin_types_compatible_p(typeof(expr), unsigned char) ||                 \
+        __builtin_types_compatible_p(typeof(expr), const unsigned char) ||         \
+        __builtin_types_compatible_p(typeof(expr), volatile unsigned char) ||      \
+        __builtin_types_compatible_p(typeof(expr), const volatile unsigned char),  \
+        (unsigned char)1,                                                          \
+    __builtin_choose_expr(                                                         \
+      __builtin_types_compatible_p(typeof(expr), signed short) ||                  \
+        __builtin_types_compatible_p(typeof(expr), const signed short) ||          \
+        __builtin_types_compatible_p(typeof(expr), volatile signed short) ||       \
+        __builtin_types_compatible_p(typeof(expr), const volatile signed short),   \
+        (signed short)1,                                                           \
+    __builtin_choose_expr(                                                         \
+      __builtin_types_compatible_p(typeof(expr), unsigned short) ||                \
+        __builtin_types_compatible_p(typeof(expr), const unsigned short) ||        \
+        __builtin_types_compatible_p(typeof(expr), volatile unsigned short) ||     \
+        __builtin_types_compatible_p(typeof(expr), const volatile unsigned short), \
+        (unsigned short)1,                                                         \
+      (expr)+0))))))
+#endif
+
 #endif /* COMPILER_H */
-- 
2.45.2


