Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0557AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZZ-0003MC-6k; Tue, 18 Mar 2025 17:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY3-0001JH-CC
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY0-0000mj-6R
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22438c356c8so107499075ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333547; x=1742938347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrnLnr+uuMo0u5RlpGRH5yvm9z5ZGh78Msw1Ubctmpo=;
 b=I9LnFM0sN4SwFyIeLFHtCMQGT9vkDtwsoSwcCV4grF7WyXGV1YAzhxscIHD/H5ayo4
 ah6w1NAmx4HfS8GpsQLJElKJRfiE+FG8HgQWQOt8h30rqxlVEa9xd57NpS++GIw1m3iZ
 HCtxYIFODAe+JmqesOS5ng3XywErzJglnkzeVGIgJKrbzskj9g23maQNvMMvbADtRpBa
 x6TAVISUhLuj24nQNDeW4YVDu+WsrBd5Rc17A26RPyRajMeXqBNkcdkNHYfkwS2OLFtS
 k4VlomGVkGH+xIEDe2D05v2LZ5jXd8sWsIsIQ5TSN6L3H4bkWsFCCvnzTcdfO4KPe/5u
 T/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333547; x=1742938347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HrnLnr+uuMo0u5RlpGRH5yvm9z5ZGh78Msw1Ubctmpo=;
 b=pxriGkhF0svYkapwTLeqHQJS7yb+9ga0SH1oSZMowD87O3HJFOp5UeeJbFk00Y6Fpo
 2HuwmDYPaWt5RoDem7+HRWq3Q8piJ8Qd2UCWBWlm8vZeR6g87tbIhoAHFTWwmrWibTPF
 UwyY5+B+rgKyhrPg7a/z4HqsgmxGCVmd5SCSKhHtPnZlKDScZh6Zd2qMMyjoxkzVFcvX
 iZ36qhEhjDv+XAnmvW/t1hnpo6+7CgQQrtppS10V9zSEYk+MIsdtH8q5gAfboLXarDI3
 mjgvJzt4vp1g8mATGNZ/EIKDGFce/ZPM706mNDzTY0Rg7cxuHL9H8ytdgv1MtsHTzOeF
 ih6A==
X-Gm-Message-State: AOJu0YwCyeAHFNS1clNWrkxmCoAckj6UmUjxEny2M0Ze8+V+nBI87b4b
 T7vsB3eOZeK+TMg9ZXPhLN/zMftMxXSf8viokPndw+/ZwumvVZAd7anNZvwxH7+6iVTwgUBJo8l
 h
X-Gm-Gg: ASbGncuE5JdaB1cl+jE4GoEEIf+YZWgkHlyh0/xnPdet8ppylOcBLZnnOK07BzUCXg+
 tbLLfQfAE2NFjY3mSG14Uf8VR0DidihAfwXEgAyZafXPl8e8YPlP94fFjyGnDKNWcg8SgZQXeYc
 A8jBso1HabYyegmZgaSfw/Px9bU86Zjfx4W7fbqf5bT5D2d46gnmBGc6y+wB4aoo5zu+bAd5uTy
 ufl+Oe8hcM6D9HRLxHXr3iRx5pHjYVdWk8Aczjny2K153USGiP73QocDZP2f8fLYGxCaE2vL3ig
 N7HnXKnG26JA2twC+rK4OmwOXRyJuO83d1MfrmLg91lXyrDXAxhA8yE09O3CIlYV5lZcJ6ACVPv
 y
X-Google-Smtp-Source: AGHT+IEH7rndf1iJLJ2xP0p6NzqyweY+Bx03PTv75VP+xh+bMaxHMJ0O9Hrzn6zqoGauJafDF9u4fg==
X-Received: by 2002:a05:6a20:9f43:b0:1f3:2a83:7548 with SMTP id
 adf61e73a8af0-1fbed40d0bamr269209637.38.1742333546657; 
 Tue, 18 Mar 2025 14:32:26 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 22/42] exec: Restrict memory-internal.h to system/
Date: Tue, 18 Mar 2025 14:31:47 -0700
Message-ID: <20250318213209.2579218-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Only file units within the system/ directory need access to
"memory-internal.h". Restrict its scope by moving it there.

The comment from commit 9d70618c684 ("memory-internal.h:
Remove obsolete claim that header is obsolete") is now obsolete,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317161329.40300-3-philmd@linaro.org>
---
 {include/exec => system}/memory-internal.h | 6 ------
 system/memory.c                            | 4 ++--
 system/physmem.c                           | 3 ++-
 MAINTAINERS                                | 2 +-
 4 files changed, 5 insertions(+), 10 deletions(-)
 rename {include/exec => system}/memory-internal.h (88%)

diff --git a/include/exec/memory-internal.h b/system/memory-internal.h
similarity index 88%
rename from include/exec/memory-internal.h
rename to system/memory-internal.h
index c75178a3d6..085e81a9fe 100644
--- a/include/exec/memory-internal.h
+++ b/system/memory-internal.h
@@ -11,12 +11,6 @@
  *
  */
 
-/*
- * This header is for use by exec.c, memory.c and accel/tcg/cputlb.c ONLY,
- * for declarations which are shared between the memory subsystem's
- * internals and the TCG TLB code. Do not include it from elsewhere.
- */
-
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
diff --git a/system/memory.c b/system/memory.c
index 6a5d853071..7e2f16f4e9 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -24,8 +24,6 @@
 #include "qemu/qemu-print.h"
 #include "qom/object.h"
 #include "trace.h"
-
-#include "exec/memory-internal.h"
 #include "system/ram_addr.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
@@ -35,6 +33,8 @@
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
 
+#include "memory-internal.h"
+
 //#define DEBUG_UNASSIGNED
 
 static unsigned memory_region_transaction_depth;
diff --git a/system/physmem.c b/system/physmem.c
index 765d195cb0..1bf97a5704 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -66,7 +66,6 @@
 #include "qemu/main-loop.h"
 #include "system/replay.h"
 
-#include "exec/memory-internal.h"
 #include "system/ram_addr.h"
 
 #include "qemu/pmem.h"
@@ -88,6 +87,8 @@
 #include <daxctl/libdaxctl.h>
 #endif
 
+#include "memory-internal.h"
+
 //#define DEBUG_SUBPAGE
 
 /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
diff --git a/MAINTAINERS b/MAINTAINERS
index 18a5381afd..51267f1c78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3115,7 +3115,7 @@ F: system/ioport.c
 F: system/memory.c
 F: system/memory_mapping.c
 F: system/physmem.c
-F: include/exec/memory-internal.h
+F: system/memory-internal.h
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
-- 
2.43.0


