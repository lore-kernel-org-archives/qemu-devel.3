Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB14DE68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQv-0003qp-T1; Thu, 31 Oct 2024 00:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQl-0003f8-PV
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:07 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQj-00051r-QF
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:07 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2e050b1c3so1262011a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347504; x=1730952304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoWX44V0fGpE1g+o7be5wb7qyUlUtcMzAcPzXC+tmrQ=;
 b=AJje5q7AMb9ky9l+pbiX5Ssnqng4Qol4bftjvOb0F7xQa0hL+cG24V8NMe+nUam9QZ
 jE672JLpQBhjqAnDUIf0rfuu2VduD4BydNFsWrxNEWSqLQ5GXhKhTt5JHmRSZoO8G+G1
 Asm1KoMgikqt0SAJamCw8j1M/O6+LYTLuGWIqyrWW2W63J+uFeVMpxv5c97vMTtNi8QZ
 cPnhfJ6DjRIP3sQH0fB99uGXU34VNeIBc2L7MY2YiqZP0To3XI9O03c7x7U8gnNL0nfg
 m1T3qwSzoHl2ONM4hQey3Gi0/SFgeUJFu7XHWJP2YF3fCmPucdUdt6JHmaPo1ZRNlYO/
 s7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347504; x=1730952304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hoWX44V0fGpE1g+o7be5wb7qyUlUtcMzAcPzXC+tmrQ=;
 b=dM3FTvnZfHhK3Glt91ODYCwSZ+toDaF1AW2Gsg2yw7EeTeU2uy8VIL83FXdbWiHKV0
 W5EgYBcJHKvG2xf0S2wkugACcMIUNhAiuLWeQQVwtDObr2euSA9IKdndovgBAKLYAcW5
 y1nNjoAqsSxoQCC7ShWnNPQ0YHNGVuIrZ8tNipDa4s6oQmkS30vCYk2Hvhd7xjoP6G39
 etwktfmldGRcSaAWm5Hk4Fve3MDbJ2jz7c81H3OQSsk/LriKKGIaycwj94IWJ4qw+wjV
 vzn0Mav/OTBIPZAnHO4seTwbBAVCpRjJBoBZZzJsy7KanmoRBalxaUDmp13aF1GMr8cV
 w42Q==
X-Gm-Message-State: AOJu0YwjEHgcY2Y0HbxfaOpktRQse9p1nMygwKr7iW7aPW/8MuTajWdM
 OT85raQdiDxdhLEH2fCW2IM9p+Wljmte3gp2sniO6beevdZsE8DZ3Qghda5ITvzCanqwQdEVzcs
 oxNurbw==
X-Google-Smtp-Source: AGHT+IHE8BrDQ0Lf7lFYuWM7cfuT09fTZKXigQJc4Y6aGz7tpvHkrpIFJePpZfaeejeZGXKiO+LZjg==
X-Received: by 2002:a17:90b:1844:b0:2da:6e46:ad48 with SMTP id
 98e67ed59e1d1-2e93e058c03mr1631473a91.1.1730347503974; 
 Wed, 30 Oct 2024 21:05:03 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:05:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 07/12] win32: use compiler option instead of attribute
 gcc_struct
Date: Wed, 30 Oct 2024 21:04:21 -0700
Message-Id: <20241031040426.772604-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

This attribute is not recognized by clang, but the associated option is.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                               | 8 ++++----
 include/qemu/compiler.h                   | 7 +------
 subprojects/libvhost-user/libvhost-user.h | 6 +-----
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/meson.build b/meson.build
index d8af08299e0..d0d5dbe1479 100644
--- a/meson.build
+++ b/meson.build
@@ -330,10 +330,10 @@ elif host_os == 'sunos'
 elif host_os == 'haiku'
   qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
 elif host_os == 'windows'
-  if not compiler.compiles('struct x { int y; } __attribute__((gcc_struct));',
-                           args: '-Werror')
-    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang')
-  endif
+  # https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html
+  # We use this compilation option instead of relying on gcc_struct attribute
+  # because clang does not support it (but supports the option).
+  qemu_common_flags += ['-mno-ms-bitfields']
 endif
 
 # Choose instruction set (currently x86-only)
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c06954ccb41..d904408e5ed 100644
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
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index deb40e77b3f..2ffc58c11b1 100644
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


