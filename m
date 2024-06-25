Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052D4C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4CR-0005R6-Jx; Tue, 25 Jun 2024 07:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sM4CQ-0005Qw-GK
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sM4CO-0003H4-DD
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719314335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y5FfZzLdp4sxkwTUiJC9NH6gLl3dKj93haMIBXGjZ/4=;
 b=ROZBD+pOKoSHExTWxTWmqg+IB7LAcx3Tx33kziMpPdsvBu+ssXT7twTq1pj6oGBP+6t935
 p0YDfmi7Hn9BU9iMqj5hLbJWYtJ6sYgarhViONnCKi8kTYiIPzdlMyWpzH5MD/hdQzAJhZ
 WN/gjEzfp8G0LHfNzSUKM4x7c7hQU0Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-7rcsUe6dPqaEkFFo5jA4jQ-1; Tue, 25 Jun 2024 07:18:54 -0400
X-MC-Unique: 7rcsUe6dPqaEkFFo5jA4jQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7274fd9099so40201366b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719314332; x=1719919132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y5FfZzLdp4sxkwTUiJC9NH6gLl3dKj93haMIBXGjZ/4=;
 b=Et72dfDZNyKTnP6FIbMV9FF7paLf7c43BNpWOYtluWaq91fUj8OEIPmdb5oFSlelnR
 6w+cfAE46ORUd/KvcxnR0bRk4/OuxXFiH13A+x3VY6RHd6aoJHE3dm35LxwWXvGHET0v
 6Vin0WJo7pk8JHjQnyOVfHXTQdSD0srxZgfIZVlSzv6VJEHC7FcGAPW93r9Vukdc/I6o
 t8w/wMzo66ErX3mTdz6gUtcEBNyK+DrSjIw/IBusi2Kg1jVIEQ70I5U8OogjudRUM2G3
 AwTYkg7mfES7s/sGqvfukW9oeAO7MUncmJz3akB06eY3NVW3YHBXWqS+X7L0yKNUjlh+
 VlbQ==
X-Gm-Message-State: AOJu0YynI0cOtqEWEYbyMiVsFyzmvrfYYtvoOgAF4JvQ/wSLF78Kqe9g
 IzLY7H3HI3iZD++eZiOkGslStOBRPfeR0SnYeM74uYfh6XTvDungKnWUGBhRpmrWY0nqWhXAwOl
 taCz9M/8vASzoI7oVpraU2shxbhhXew1DZ+OHOxz91qvtJQGDsiaee6ct2xsNaJizPc5OUYy1n7
 lLLm2t4EmATQ12gZWYijW7Ndht9RewAAnw50Nl
X-Received: by 2002:a17:907:c787:b0:a6f:b6c3:fb30 with SMTP id
 a640c23a62f3a-a7245b84f56mr710028066b.7.1719314331866; 
 Tue, 25 Jun 2024 04:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUYgt582YliqFKpeBZWupiJsH2UBhB4aGot8ki1bqX9rpdWG62R2BWUIZ5uCJYKRo/Zu6O+w==
X-Received: by 2002:a17:907:c787:b0:a6f:b6c3:fb30 with SMTP id
 a640c23a62f3a-a7245b84f56mr710025266b.7.1719314331353; 
 Tue, 25 Jun 2024 04:18:51 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a724c83fad0sm253184766b.168.2024.06.25.04.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 04:18:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: flwu@google.com, berrange@redhat.com, peter.maydell@linaro.org,
 rkir@google.com
Subject: [PATCH] include: move typeof_strip_qual to compiler.h,
 use it in QAPI_LIST_LENGTH()
Date: Tue, 25 Jun 2024 13:18:48 +0200
Message-ID: <20240625111848.709176-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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


