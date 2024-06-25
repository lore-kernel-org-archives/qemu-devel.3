Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D48CC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 21:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMDbB-0008SZ-Dn; Tue, 25 Jun 2024 17:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMDaf-0008QJ-C1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 17:20:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMDa6-00073L-A6
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 17:20:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-364a39824baso4321530f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719350331; x=1719955131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hgiwM1GTLb1Ew4GegPzA5Oi1QUY7ia/+4MPTtt50CTw=;
 b=w56CMhLiJjW9GT6EHFSteMjV100kvSAkBdG8SqVm67hV4upFFZel/gisZoSfVb+h3U
 0+6KhF6jAy0bACZM4/XEoK59T1NBe4wWAt2WEHKotaVAgWhG1bzqgDhRYi+KS5TNiUNv
 rOhKnX4Htn0p+fgevCodEdIrbE/K0SGf3MzcOZQ7QC/sS7+9wPY0pQxvBuDv6yfQVbfh
 mItwJ5k8XFpcBoJHOb+XcJ2QUx4ZuMqddm+aB00JZ47cvalmqUdRi/b7RJDM+3BySNVE
 6pPqeL+gbZWWEF3LiRP9rRHiTpEDfx6oQoabj64cZ1YcKgs7HnRJdGd+dhkRwgLq7JZe
 dQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719350331; x=1719955131;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hgiwM1GTLb1Ew4GegPzA5Oi1QUY7ia/+4MPTtt50CTw=;
 b=hvIKCpjKtx4Shj8oerzZaly77uFEllncY0ST4z6UC4zZSoBv/sE4I+38Z3adRO9IN5
 aVbfQPBOQjbykI1QN1+pI3BVmc4KY65bJbWafecyP3Gf1F5WDxafitL5t65nNDMzEgsw
 uxIDa8WlznxXV9IhEIGQDa+A3n5d6YMqMLgVFObzOB11+S3nC+kotGS1hYVj7eaLgvXU
 2qE/Rpd6GtHiHNicp8wxKYOEVONpKhZdnt1/xBlH3xVpgjmFnI6NHasW6yt+N/VQB5ev
 b5XKsfwQRZDTIlFjyc1eWAy/R8YrqhDHuy+VTn4+4IZunSMcYoydCUjmq3jviXtuMShi
 h3Cg==
X-Gm-Message-State: AOJu0YzAk0UwHAh3spxGlkCE3GilStjBNXJ59bkxsWSS1leBCaxSuMBk
 PTtaPpvPQTW9TPHq8grJS8Q40ltwC/A6rUcywWqa7VekYgjAKUIrHQ88sx8kw6kt8s1YNZ+51B4
 EXZ0=
X-Google-Smtp-Source: AGHT+IH2l8opDlUnhqAvGTMn4+SNSHydEnBS+EkB0J7kpXsTSEW9uXud+2LZq0EeVCfn95r4TKlHng==
X-Received: by 2002:a7b:cb0f:0:b0:421:f4da:f4b with SMTP id
 5b1f17b1804b1-4248b9ece43mr57552395e9.40.1719343042361; 
 Tue, 25 Jun 2024 12:17:22 -0700 (PDT)
Received: from meli-email.org (adsl-193.37.6.1.tellas.gr. [37.6.1.193])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366383f6717sm13870971f8f.9.2024.06.25.12.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 12:17:22 -0700 (PDT)
Date: Tue, 25 Jun 2024 22:12:54 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: flwu@google.com, berrange@redhat.com, peter.maydell@linaro.org,
 rkir@google.com
Subject: Re: [PATCH] include: move typeof_strip_qual to compiler.h,
 use it in QAPI_LIST_LENGTH()
User-Agent: meli 0.8.6
References: <20240625111848.709176-1-pbonzini@redhat.com>
In-Reply-To: <20240625111848.709176-1-pbonzini@redhat.com>
Message-ID: <fnhkw.xyx5xkm2lgb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 25 Jun 2024 14:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>The typeof_strip_qual() is most useful for the atomic fetch-and-modify
>operations in atomic.h, but it can be used elsewhere as well.  For example,
>QAPI_LIST_LENGTH() assumes that the argument is not const, which is not a
>requirement.
>
>Move the macro to compiler.h and, while at it, move it under #ifndef
>__cplusplus to emphasize that it uses C-only constructs.  A C++ version
>of typeof_strip_qual() using type traits is possible[1], but beyond the
>scope of this patch because the little C++ code that is in QEMU does not
>use QAPI.
>
>The patch was tested by changing the declaration of strv_from_str_list()
>in qapi/qapi-type-helpers.c to:
>
>    char **strv_from_str_list(const strList *const list)
>
>This is valid C code, and it fails to compile without this change.
>
>[1] https://lore.kernel.org/qemu-devel/20240624205647.112034-1-flwu@google.com/
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> include/qapi/util.h     |  2 +-
> include/qemu/atomic.h   | 42 -------------------------------------
> include/qemu/compiler.h | 46 +++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 47 insertions(+), 43 deletions(-)
>
>diff --git a/include/qapi/util.h b/include/qapi/util.h
>index 20dfea8a545..b8254247b8d 100644
>--- a/include/qapi/util.h
>+++ b/include/qapi/util.h
>@@ -62,7 +62,7 @@ int parse_qapi_name(const char *name, bool complete);
> #define QAPI_LIST_LENGTH(list)                                      \
>     ({                                                              \
>         size_t _len = 0;                                            \
>-        typeof(list) _tail;                                         \
>+        typeof_strip_qual(list) _tail;                              \
>         for (_tail = list; _tail != NULL; _tail = _tail->next) {    \
>             _len++;                                                 \
>         }                                                           \
>diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
>index 99110abefb3..dc4118ddd9e 100644
>--- a/include/qemu/atomic.h
>+++ b/include/qemu/atomic.h
>@@ -20,48 +20,6 @@
> /* Compiler barrier */
> #define barrier()   ({ asm volatile("" ::: "memory"); (void)0; })
> 
>-/* The variable that receives the old value of an atomically-accessed
>- * variable must be non-qualified, because atomic builtins return values
>- * through a pointer-type argument as in __atomic_load(&var, &old, MODEL).
>- *
>- * This macro has to handle types smaller than int manually, because of
>- * implicit promotion.  int and larger types, as well as pointers, can be
>- * converted to a non-qualified type just by applying a binary operator.
>- */
>-#define typeof_strip_qual(expr)                                                    \
>-  typeof(                                                                          \
>-    __builtin_choose_expr(                                                         \
>-      __builtin_types_compatible_p(typeof(expr), bool) ||                          \
>-        __builtin_types_compatible_p(typeof(expr), const bool) ||                  \
>-        __builtin_types_compatible_p(typeof(expr), volatile bool) ||               \
>-        __builtin_types_compatible_p(typeof(expr), const volatile bool),           \
>-        (bool)1,                                                                   \
>-    __builtin_choose_expr(                                                         \
>-      __builtin_types_compatible_p(typeof(expr), signed char) ||                   \
>-        __builtin_types_compatible_p(typeof(expr), const signed char) ||           \
>-        __builtin_types_compatible_p(typeof(expr), volatile signed char) ||        \
>-        __builtin_types_compatible_p(typeof(expr), const volatile signed char),    \
>-        (signed char)1,                                                            \
>-    __builtin_choose_expr(                                                         \
>-      __builtin_types_compatible_p(typeof(expr), unsigned char) ||                 \
>-        __builtin_types_compatible_p(typeof(expr), const unsigned char) ||         \
>-        __builtin_types_compatible_p(typeof(expr), volatile unsigned char) ||      \
>-        __builtin_types_compatible_p(typeof(expr), const volatile unsigned char),  \
>-        (unsigned char)1,                                                          \
>-    __builtin_choose_expr(                                                         \
>-      __builtin_types_compatible_p(typeof(expr), signed short) ||                  \
>-        __builtin_types_compatible_p(typeof(expr), const signed short) ||          \
>-        __builtin_types_compatible_p(typeof(expr), volatile signed short) ||       \
>-        __builtin_types_compatible_p(typeof(expr), const volatile signed short),   \
>-        (signed short)1,                                                           \
>-    __builtin_choose_expr(                                                         \
>-      __builtin_types_compatible_p(typeof(expr), unsigned short) ||                \
>-        __builtin_types_compatible_p(typeof(expr), const unsigned short) ||        \
>-        __builtin_types_compatible_p(typeof(expr), volatile unsigned short) ||     \
>-        __builtin_types_compatible_p(typeof(expr), const volatile unsigned short), \
>-        (unsigned short)1,                                                         \
>-      (expr)+0))))))
>-
> #ifndef __ATOMIC_RELAXED
> #error "Expecting C11 atomic ops"
> #endif
>diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>index c797f0d4572..554c5ce7df7 100644
>--- a/include/qemu/compiler.h
>+++ b/include/qemu/compiler.h
>@@ -227,4 +227,50 @@
> #define SECOND_ARG(first, second, ...) second
> #define IS_EMPTY_(junk_maybecomma)     SECOND_ARG(junk_maybecomma 1, 0)
> 
>+#ifndef __cplusplus
>+/*
>+ * Useful in macros that need to declare temporary variables.  For example,
>+ * the variable that receives the old value of an atomically-accessed
>+ * variable must be non-qualified, because atomic builtins return values
>+ * through a pointer-type argument as in __atomic_load(&var, &old, MODEL).
>+ *
>+ * This macro has to handle types smaller than int manually, because of
>+ * implicit promotion.  int and larger types, as well as pointers, can be
>+ * converted to a non-qualified type just by applying a binary operator.
>+ */
>+#define typeof_strip_qual(expr)                                                    \
>+  typeof(                                                                          \
>+    __builtin_choose_expr(                                                         \
>+      __builtin_types_compatible_p(typeof(expr), bool) ||                          \
>+        __builtin_types_compatible_p(typeof(expr), const bool) ||                  \
>+        __builtin_types_compatible_p(typeof(expr), volatile bool) ||               \
>+        __builtin_types_compatible_p(typeof(expr), const volatile bool),           \
>+        (bool)1,                                                                   \
>+    __builtin_choose_expr(                                                         \
>+      __builtin_types_compatible_p(typeof(expr), signed char) ||                   \
>+        __builtin_types_compatible_p(typeof(expr), const signed char) ||           \
>+        __builtin_types_compatible_p(typeof(expr), volatile signed char) ||        \
>+        __builtin_types_compatible_p(typeof(expr), const volatile signed char),    \
>+        (signed char)1,                                                            \
>+    __builtin_choose_expr(                                                         \
>+      __builtin_types_compatible_p(typeof(expr), unsigned char) ||                 \
>+        __builtin_types_compatible_p(typeof(expr), const unsigned char) ||         \
>+        __builtin_types_compatible_p(typeof(expr), volatile unsigned char) ||      \
>+        __builtin_types_compatible_p(typeof(expr), const volatile unsigned char),  \
>+        (unsigned char)1,                                                          \
>+    __builtin_choose_expr(                                                         \
>+      __builtin_types_compatible_p(typeof(expr), signed short) ||                  \
>+        __builtin_types_compatible_p(typeof(expr), const signed short) ||          \
>+        __builtin_types_compatible_p(typeof(expr), volatile signed short) ||       \
>+        __builtin_types_compatible_p(typeof(expr), const volatile signed short),   \
>+        (signed short)1,                                                           \
>+    __builtin_choose_expr(                                                         \
>+      __builtin_types_compatible_p(typeof(expr), unsigned short) ||                \
>+        __builtin_types_compatible_p(typeof(expr), const unsigned short) ||        \
>+        __builtin_types_compatible_p(typeof(expr), volatile unsigned short) ||     \
>+        __builtin_types_compatible_p(typeof(expr), const volatile unsigned short), \
>+        (unsigned short)1,                                                         \
>+      (expr)+0))))))
>+#endif

Should we add an #else to provide a fallback for cplusplus until the 
alternative is merged?

-#endif
+#else /* __cpluplus */
+#define typeof_strip_qual typeof
+#endif /* __cplusplus */

>+
> #endif /* COMPILER_H */
>-- 
>2.45.2
>
>



With that comment addressed,

Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

