Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841E2C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLp-00011Z-27; Thu, 01 May 2025 17:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLW-0000mc-Pp
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:31 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLU-0001Tu-Vd
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:30 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223fb0f619dso16757805ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134487; x=1746739287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7DR11p+9YzUqSf4ui6D78GVslxIUwiZ1FLspSn5Nw4=;
 b=Q6G0DMYYQz1INGG4eK4ckty/D/NqcJxrJXkyUNpjv/LHBaQws4yFeuy/9ybyOFK8uE
 b/2siR1APt069xmeIxeDj9/YtwRPKfxUYR9N3t3vkcUcarRSVyadJEdOBB9RHHaa9pSg
 OeF/Ize2r8BzmqEnUcYLgiYqQa7vX4QOiF1mrWXY1gZwkhs8iVzZYCJzriiIOw8Rg8uV
 p7fKOJDP2ifZOgY2vj+igz0JiqY71Z4mODbvmJmH8Hv0IPrtUBj2j0vnHMHivJIjnYow
 gCYAt/LVjOf619jG6HahHUqsK6rVMhrXXkmij8CJKf60bD2gNkI2vy7o67YAl7IrpeOQ
 IEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134487; x=1746739287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7DR11p+9YzUqSf4ui6D78GVslxIUwiZ1FLspSn5Nw4=;
 b=Ybw6NA6NGfz5LDU7d1NqcSVIljfqge0HtGnCGdqgMdfiIQfVr/3UxmQiYruRDvKHQ+
 Q8ol++7eNhGDrfngkd0aejXJK3yc4m+qRtvVkAQ9nc91qZXslgJgiW1yZWr7yCflylm9
 WtmTHN+iN0iN7U65JmhWdX0TEvnRPBloj2UbXsWQbmjibN+DDXtmQ/jT02Q3ATvYOBai
 9xe7a9GQLOlE2n1NbcJG/XuoZAJsvDntswIdfJcL7sKj0yL1OWEIW5IWazZYm7F/cSby
 kjjjfJYWIgFS5EuMkwpUdIdyT7s9nAvs/t5fIyr1SYw9/XE/2eRZ6KSiQIBouCBne55D
 Xjig==
X-Gm-Message-State: AOJu0YxhkpVVX9whKhrrgHsjkWzuezR8eQLhzwDjFM30NfGrKZ+4lPmU
 fwg6xrmNS6tvU9kR6iPVPLquvCFn/KD7HI/SchrFQsvVigupABmtDmeHkxYYGMvaECoK9rPRT/t
 p
X-Gm-Gg: ASbGncu4aYWyT5AtiCZfWnq9KYlQRya/aKVLH8L0LUZ61A2bqjWmdSkWug0JP4pORch
 2vl7OdKzteCKAgZUQtDDjBf6GVwmNUqFaS8x/+WSwBMF99t/Oj9e1g9CcAoFE8VBOS/OOI96Hg1
 k7dypkYRdvqKDfZG4Wt2ZBjLrCOm+hp9cWF1Pw3oXwOUFNP08sOQrW6QmO6/HJtNUyPZVKU2Zd9
 TLUc/NSL2/2AiVixHpahCs/FCDSO+WNPCK5VDnE2HZ50FEjTd+U6Bg0CKnsYRs/xkkeJab+2TN4
 xuh0Yv/TPo8mVDHyevliaN+jkVmmcdWPDBrRGtfGBnJqzp0sObYpV6OKspe1ar50hZg9+GcmIog
 =
X-Google-Smtp-Source: AGHT+IFotK9/XIvfl/hnxlXRRSEmnBVnAZHtULd5s6Tw/Ms7cGHOSshdSt0iheQhYYG3VxAO9duDBw==
X-Received: by 2002:a17:90b:5252:b0:301:9f62:a944 with SMTP id
 98e67ed59e1d1-30a4e6949a3mr959109a91.33.1746134487599; 
 Thu, 01 May 2025 14:21:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/59] accel/tcg: Compile tb-maint.c twice
Date: Thu,  1 May 2025 14:20:30 -0700
Message-ID: <20250501212113.2961531-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-hash.h   | 3 +--
 accel/tcg/tb-maint.c  | 2 --
 accel/tcg/meson.build | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index 3bc5042d9d..f7b159f04c 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -20,8 +20,7 @@
 #ifndef EXEC_TB_HASH_H
 #define EXEC_TB_HASH_H
 
-#include "exec/cpu-defs.h"
-#include "exec/exec-all.h"
+#include "exec/vaddr.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
 #include "qemu/xxhash.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index b144fcd4a0..0048316f99 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -20,10 +20,8 @@
 #include "qemu/osdep.h"
 #include "qemu/interval-tree.h"
 #include "qemu/qtree.h"
-#include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/log.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 047afa49a2..3f7b127130 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -8,6 +8,7 @@ tcg_ss.add(files(
   'cpu-exec-common.c',
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
+  'tb-maint.c',
   'translator.c',
 ))
 if get_option('plugins')
@@ -21,7 +22,6 @@ tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
   'cpu-exec.c',
-  'tb-maint.c',
   'translate-all.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-- 
2.43.0


