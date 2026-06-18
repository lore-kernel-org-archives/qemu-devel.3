Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E7ECD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIqq-0004Zw-CD; Thu, 18 Jun 2026 15:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq6-0003tn-N2
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:50 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq4-0007z8-Sh
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:50 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-37c5b9d42efso1385455a91.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812547; x=1782417347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tX8jP1jaQhitvntNHtQT9F1LEDDMetef5FQKXnkp/sQ=;
 b=mn/nK1P9Z7HS+4FCg8H0Ugo5xshYnfOczY7s2NByUq/HH900CkEKS0LZ3fCHaF7Avt
 YZagR8zK5mGaURHwWbCYNR9mj7xEwNZt4unHLkdfzuI+TtG6tDzm5DPGEW0M2P9ivsDl
 tOgrdORpbM17r66/LX9JhgSZ4uoRACzEH00Bk4xg9ZD4HzK8dGcblnnzhbHiA8OT3Tdb
 YOi8XN9pYgc2NPZT0s4dtbKqVHIhAMcjN55pIY0S75IjL2mVGK7TDWqapF/u03tIgl41
 wnTt/zvll6PV4r4Q6SgouiO9d077w67x7ZKtetl+ojt5aTtKuKj5xkOkaXaOg/MzMyxW
 e+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812547; x=1782417347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tX8jP1jaQhitvntNHtQT9F1LEDDMetef5FQKXnkp/sQ=;
 b=iBlWC4BH+7LIdrAV3busD+68V/MvMIdmhl9yf+2YlZ4I7r5mkfaJzXipLoLooNMpoW
 MIuh3eE38vn5nEuDoRtM2SSbFn7YOdmn3S2o1OpAKeAGNWY9LbhHD+r0bjIPKVgYowvL
 UlHYUhKbYbePP5aDn/NP2CDkQUQ1ZekwD4ikx62jgvChuUOQPN4U14imLpT7p8U76TPL
 8CWkgaqJ52wfFiVl7/dfDQLYkSMha/AbiuNwQB8yvIAf7+JEs6Of45rwuw1qNVWIH/hP
 R8ploGlShnntYWUZA1PfVRjWZzmtbEKeD+KV7l4OMIyLLr9Djrg8+arZfYmXA373xUuL
 bpeg==
X-Gm-Message-State: AOJu0YzdK4Yh/cIKJSxS5VljSDEcnmmjqx4/jZd6Rw4w3jjt+7jy8EsH
 3PO+aYQ1C4QYmLxRy+LBaiNxerLA8VEZH7uML1cd3NNu+LiQOdzm8e8XHPrDr51HzdU3adEzs+F
 hezdw
X-Gm-Gg: AfdE7ckz98GBxZl+zw3PRBUL1AnWjdxuIuCgvo+TGZa0T1NubufveDlsX++jElCAGw7
 E7ZqSpEfdF3kTiF4qt5NKQVhc1kjtzA3+Jnny5OvC0t5tzuBz4krVo+O8Qg69P/3rhkv2PKfZUj
 zsk4n6qyDBmmEtGq0Yzs1l3hJxNsOPZMToVLhONmWrea8CMEulIvzITYp7KSDOloVfoo2emNnuV
 nLO5+BcYMbDrQpfpJ1gqpyWlMZgTun3/9+TjzdOm6kDwTw4lX0pvxid7Lwl+BrYJP7zp9HL/YyN
 HATgRXJlgjCfNHaRRaXm5R0HeAaX8h4tI5VTJGpdLWxKxvEvcIjvVXnDAv1j1kOgNnbd8uE2KDA
 8lZvwyEIwb0L5usVC2eO3uei+gWBNCpS4WrdAjdQ1XEXnE2lO18RhNjgMmBq0mn7Z9NlrWon19S
 8fBVLAMF074FomMbLRRWHOlkSDY7+cBsfKfCZ3FdhhBZpNThEBPg==
X-Received: by 2002:a17:903:19ed:b0:2c6:6425:b343 with SMTP id
 d9443c01a7336-2c71953051emr3666435ad.6.1781812546922; 
 Thu, 18 Jun 2026 12:55:46 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/13] common-user: Move selfmap from util
Date: Thu, 18 Jun 2026 12:55:15 -0700
Message-ID: <20260618195520.589907-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195520.589907-1-richard.henderson@linaro.org>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This interface is only used for user-only.  It's more usefully
placed within common-user than util.  Temporarily add stub
implementation for bsd-user.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/{qemu => user}/selfmap.h | 0
 {util => common-user}/selfmap.c  | 6 +++++-
 linux-user/elfload.c             | 2 +-
 linux-user/syscall.c             | 2 +-
 common-user/meson.build          | 1 +
 util/meson.build                 | 4 ----
 6 files changed, 8 insertions(+), 7 deletions(-)
 rename include/{qemu => user}/selfmap.h (100%)
 rename {util => common-user}/selfmap.c (97%)

diff --git a/include/qemu/selfmap.h b/include/user/selfmap.h
similarity index 100%
rename from include/qemu/selfmap.h
rename to include/user/selfmap.h
diff --git a/util/selfmap.c b/common-user/selfmap.c
similarity index 97%
rename from util/selfmap.c
rename to common-user/selfmap.c
index 483cb617e2..a1b88dee66 100644
--- a/util/selfmap.c
+++ b/common-user/selfmap.c
@@ -8,10 +8,11 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "qemu/selfmap.h"
+#include "user/selfmap.h"
 
 IntervalTreeRoot *read_self_maps(void)
 {
+#ifdef __linux__
     IntervalTreeRoot *root;
     gchar *maps, **lines;
     guint i, nlines;
@@ -80,6 +81,9 @@ IntervalTreeRoot *read_self_maps(void)
     g_free(maps);
 
     return root;
+#else
+    return NULL;
+#endif
 }
 
 /**
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f32c52a968..ee2df35aa8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -25,7 +25,7 @@
 #include "qemu/queue.h"
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
-#include "qemu/selfmap.h"
+#include "user/selfmap.h"
 #include "qemu/lockable.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fbe357b7e0..dc4fb72385 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -141,7 +141,7 @@
 #include "user/safe-syscall.h"
 #include "user/signal.h"
 #include "qemu/guest-random.h"
-#include "qemu/selfmap.h"
+#include "user/selfmap.h"
 #include "special-errno.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
diff --git a/common-user/meson.build b/common-user/meson.build
index f9e2e83f9a..831a7273fb 100644
--- a/common-user/meson.build
+++ b/common-user/meson.build
@@ -8,4 +8,5 @@ user_ss.add(files(
   'mmap-min-addr.c',
   'safe-syscall.S',
   'safe-syscall-error.c',
+  'selfmap.c',
 ))
diff --git a/util/meson.build b/util/meson.build
index e29cbd948a..fa174c07a5 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -67,10 +67,6 @@ util_ss.add(files('memalign.c'))
 util_ss.add(files('interval-tree.c'))
 util_ss.add(files('lockcnt.c'))
 
-if have_user
-  util_ss.add(files('selfmap.c'))
-endif
-
 if have_system
   util_ss.add(files('crc-ccitt.c'))
   util_ss.add(when: gio, if_true: files('dbus.c'))
-- 
2.43.0


