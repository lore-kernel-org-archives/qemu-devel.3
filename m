Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3027CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfOX-0004e1-4E; Tue, 14 Jan 2025 06:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNr-0004L2-WD
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:47:00 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNp-0006ee-8C
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so38450865e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855216; x=1737460016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8aoZ+4wIpFt1loPUkrjNZIwpI4hyfnz2K8d4L8ae9I=;
 b=g0+uU6/CsHp+Erbqo2m0MsAPZNeqvyo9Cze+ORQGjSyiywmiYrASK1Jag9HmT4qeAZ
 6E00O4dGBcYKUIbptYpKIjYLo7xN9EnVYCDHbFMgye2cyCZz3hC76WcmOFo9A8tb8c67
 4Q2eBTBL9b5XiuNkicA9cn5kARblutcHkWU8Ge+KKJFniVD2vT6oPkIAO94vrYPJbHxP
 KJaj4jm/Mpz9oEhFk7gwN4dfGNOI850DhGnryqT4WwV8ca0Np9O7nhREJiGoQ5JbB+Ys
 M6rjlHb320hg1fsDX6w4aidmr5LKFlSs/GizYWHr4KX1yVUGX2L6jRdJjHhrN3Qasqdn
 xuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855216; x=1737460016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8aoZ+4wIpFt1loPUkrjNZIwpI4hyfnz2K8d4L8ae9I=;
 b=aVe/C8rFYY/qXXYIIFxnlsWESEckYynJxxpcb7z3ueiAZlKqORrAoqT63h+vg4hs32
 Jo7XY9DJXNBooavFZ28jKGcCVYzks/dQdifD7LdMu3J4hl9Z60e9/S/VKwfoNivoq2Iu
 jQ0lkC40ui7mS4K2Iq+I76J9lIv2pqDAGRwjyreEK2x/xkPYFqrgub8rxNNaWZuBkF4d
 Q2PJpgfWhMjC+Rh9F9jiLO6W1D5w0NWTEtD21KNZS6GeomjwOw8P1JaIU6v5FexMzuEy
 MDqrkq7kz8fKLHmV+/AhQTgPJJWS3kUjkOP2AG5k9YaFpV60RxUpNOEreO4w0AggF71e
 aH2A==
X-Gm-Message-State: AOJu0YxQBZfJFBXUBDHac5LvG9rRoZbMiAjkDXvHdjg3KjlmY6bhuOzi
 QmgzrNOyjOozQeQf0E3B4MAUzL25vmS5GOtMTrCxfk0g6SQyiw1SmTBmfx3WxAo=
X-Gm-Gg: ASbGncse1GJNrat+lTetKndnN+zGxevvDwqFH0Xr+xEtDt5TXVnknbG0BzlzbQfidN7
 6yoIkrNxQDqKY9VFS9H1cj4ut8tazL6ZVB8rZWmex6PQXx14sCCVBktDm3/ci8hj3BalObl7gFO
 tM7DWGFYk0eF2ULeAFZbKdWqouWHaEodABiv6RAp5LAl9Z+4pwIEW3S9n3/9GyiaB/onDVeOH8f
 7DevRnPsN3axOZ/teqMvnYkIfQeaTtHFaX6siLXvo3V0styZveJSy0=
X-Google-Smtp-Source: AGHT+IFbMNMHx6ML0JUq4Mx6dDRsIeb1gFC9D84CGU5wYXl19q1NV2WvuPUiVkGT36mg83NWRyFeiQ==
X-Received: by 2002:a05:600c:1c98:b0:436:1b7a:c0b4 with SMTP id
 5b1f17b1804b1-436e2677c65mr177990345e9.1.1736855215735; 
 Tue, 14 Jan 2025 03:46:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92f60sm207387445e9.40.2025.01.14.03.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EAD665F935;
 Tue, 14 Jan 2025 11:38:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 23/37] win32: remove usage of attribute gcc_struct
Date: Tue, 14 Jan 2025 11:38:07 +0000
Message-Id: <20250114113821.768750-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This attribute is not recognized by clang.

An investigation has been performed to ensure this attribute has no
effect on layout of structures we use in QEMU [1], so it's safe to
remove now.

In the future, we'll forbid introducing new bitfields in packed struct,
as they are the one potentially impacted by this change.

[1] https://lore.kernel.org/qemu-devel/66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org/

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Stefan Weil <sw@weilnetz.de>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250110203401.178532-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build                               | 5 -----
 include/qemu/compiler.h                   | 7 +------
 scripts/cocci-macro-file.h                | 6 +-----
 subprojects/libvhost-user/libvhost-user.h | 6 +-----
 4 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index d06f59095c..da279cc112 100644
--- a/meson.build
+++ b/meson.build
@@ -377,11 +377,6 @@ elif host_os == 'sunos'
   qemu_common_flags += '-D__EXTENSIONS__'
 elif host_os == 'haiku'
   qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
-elif host_os == 'windows'
-  if not compiler.compiles('struct x { int y; } __attribute__((gcc_struct));',
-                           args: '-Werror')
-    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang')
-  endif
 endif
 
 # Choose instruction set (currently x86-only)
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c06954ccb4..d904408e5e 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -22,12 +22,7 @@
 #define QEMU_EXTERN_C extern
 #endif
 
-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
-# define QEMU_PACKED __attribute__((gcc_struct, packed))
-#else
-# define QEMU_PACKED __attribute__((packed))
-#endif
-
+#define QEMU_PACKED __attribute__((packed))
 #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
 
 #ifndef glue
diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
index d247a5086e..c64831d540 100644
--- a/scripts/cocci-macro-file.h
+++ b/scripts/cocci-macro-file.h
@@ -23,11 +23,7 @@
 #define G_GNUC_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
 #define G_GNUC_NULL_TERMINATED __attribute__((sentinel))
 
-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
-# define QEMU_PACKED __attribute__((gcc_struct, packed))
-#else
-# define QEMU_PACKED __attribute__((packed))
-#endif
+#define QEMU_PACKED __attribute__((packed))
 
 #define cat(x,y) x ## y
 #define cat2(x,y) cat(x,y)
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index deb40e77b3..2ffc58c11b 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -186,11 +186,7 @@ typedef struct VhostUserShared {
     unsigned char uuid[UUID_LEN];
 } VhostUserShared;
 
-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
-# define VU_PACKED __attribute__((gcc_struct, packed))
-#else
-# define VU_PACKED __attribute__((packed))
-#endif
+#define VU_PACKED __attribute__((packed))
 
 typedef struct VhostUserMsg {
     int request;
-- 
2.39.5


