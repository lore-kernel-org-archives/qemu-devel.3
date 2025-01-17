Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8BEC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr29-0004AL-1V; Fri, 17 Jan 2025 13:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr27-00049s-GW
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:27 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr24-0007uM-A7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:25 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2163dc5155fso47383755ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138322; x=1737743122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMIoy9Qr4sAYc0TTIYm5/vud8Vv6iAFrh69jyElbj4I=;
 b=wSnrDg+Fehy4DwnU1cxvg+lOYOp+ihKMQDFP/4H6Bsb8DOIxKJUmimuVif1er3uu5C
 OYZiJ5DjM0qBs/+QgFJQUHsJayTnuqT1k/ePNcCW9Mmh2YvZz5NUVhs5WFkxxWaUNyvB
 GKLeDD4YYcMzTTbdRHlMGbuFLv0MHQrLaSVEUPjEaus36rf75j3J23HAuXVzsWaO5Hqb
 XYiRS/LvT1UrfM4esXCg7imoK7LXfOnU4Fs+j8ccaNpBi8xbx8/fMymIf5o6hFBdcmHv
 55SBoqTRlmanxcpRuJrorI3d5fRfyNJ2OmbfkWpkA1JqPEfLWg+Cv+HuLZBAXO58dGtZ
 LT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138322; x=1737743122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMIoy9Qr4sAYc0TTIYm5/vud8Vv6iAFrh69jyElbj4I=;
 b=htDOIkLJoYiHLzLG6bUwov6ibXkl9K7j2GJIgoj4FGCXSUCSUjpaYcB5/rPLIt9Icc
 RsMNAdnBTv831LAN8LCjezO2fq+uHhNDuOIVkxDI0vZ+pVx7c//iMX9Mzo25oEIsCygc
 SZmNsZercHjNStFmYQrNn8y//VW1c4Bg8ukMuIjqowItmiwwX0JF4btR+wor0TVpr8Qi
 WFetOERfeA9C32CZEiYBp2SG0WTIgKgvPj414AOtlKKvp3znI/UUFReCPkx7umM/0z2t
 +/PQ89TxyzkgtH5aDYl6yzzcgt8+A2fWWkX9jI49LtztWFGH3nj6PTb7P/WIQpCCuNs+
 pLGQ==
X-Gm-Message-State: AOJu0YwNmVdnw3R0nm9LSxlHzisJ853NFcNDpOuYMX6P8gqtqGrsM881
 QdOIm0cAKWWZ85slJG0SWakN7Z6DsJPME4phuIxoH1QXtAOoYddwGRB9CRfcuuiELbxypQIikNi
 r
X-Gm-Gg: ASbGncu7B52Qm2A/V9s7bu6TSGXwF9RTPB+SgCYiFYcLEMZKfioBAhOdd6h4DECFlZF
 69hAFRrnMhBGvNA+l6BEdNg246a/s2CSZToykChuYLqPKKjpsue3bK56vyCO2qKAZe5zglB56RH
 bNZGXxWwZYRDEo5zvt4ZeTE6QOfxDEVyE3ldTyzFJuRqHLgfwE5AlQS5FkbsaKP1/l5lWV4X71r
 T/32DjmwakNc5p7qqzCHICrqzVqjELoNF4qaz7qz5kjOb9iZD7RwnkX+KC5Mg9TEeuHog8N3QKq
 nsZrMmjVHWgC1nI=
X-Google-Smtp-Source: AGHT+IFoErb/GN9oE+YGivZ0qj+Xnr9gujAVlu49YRejgRjP0QjH/bbeW8+Ms1yOMBxfXnwmXhevsw==
X-Received: by 2002:a17:902:c951:b0:20c:5533:36da with SMTP id
 d9443c01a7336-21c355ebb3dmr45385115ad.42.1737138321847; 
 Fri, 17 Jan 2025 10:25:21 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/68] tcg: Only include 'tcg-has.h' when necessary
Date: Fri, 17 Jan 2025 10:24:20 -0800
Message-ID: <20250117182456.2077110-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

TCG_TARGET_HAS_* definitions don't need to be exposed
by "tcg/tcg.h". Only include 'tcg-has.h' when necessary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250108215156.8731-15-philmd@linaro.org>
---
 include/tcg/tcg.h | 2 --
 tcg/optimize.c    | 1 +
 tcg/tcg-common.c  | 1 +
 tcg/tcg-op-gvec.c | 1 +
 tcg/tcg-op-ldst.c | 2 +-
 tcg/tcg-op-vec.c  | 1 +
 tcg/tcg-op.c      | 2 +-
 tcg/tcg.c         | 1 +
 tcg/tci.c         | 1 +
 9 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 4352ec012f..e5fa69d20b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -64,8 +64,6 @@ typedef uint64_t TCGRegSet;
 #error unsupported
 #endif
 
-#include "tcg/tcg-has.h"
-
 typedef enum TCGOpcode {
 #define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,
 #include "tcg/tcg-opc.h"
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6823569ee2..c363c5c04b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -28,6 +28,7 @@
 #include "qemu/interval-tree.h"
 #include "tcg/tcg-op-common.h"
 #include "tcg-internal.h"
+#include "tcg-has.h"
 
 #define CASE_OP_32_64(x)                        \
         glue(glue(case INDEX_op_, x), _i32):    \
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 35e7616ae9..fadc33c3d1 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
+#include "tcg-has.h"
 
 TCGOpDef tcg_op_defs[] = {
 #define DEF(s, oargs, iargs, cargs, flags) \
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 97e4df221a..d32a4f146d 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg-op-common.h"
 #include "tcg/tcg-op-gvec-common.h"
 #include "tcg/tcg-gvec-desc.h"
+#include "tcg-has.h"
 
 #define MAX_UNROLL  4
 
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 0d8fe3b4f5..ec3ef4dcb4 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -30,7 +30,7 @@
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
-
+#include "tcg-has.h"
 
 static void check_max_alignment(unsigned a_bits)
 {
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 364cd089df..893d68e7d8 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg-op-common.h"
 #include "tcg/tcg-mo.h"
 #include "tcg-internal.h"
+#include "tcg-has.h"
 
 /*
  * Vector optional opcode tracking.
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 872fb22ef8..ab5ccd8dcb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -29,7 +29,7 @@
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
-
+#include "tcg-has.h"
 
 /*
  * Encourage the compiler to tail-call to a function, rather than inlining.
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 505e43c128..3576299a1c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -56,6 +56,7 @@
 #include "tcg/tcg-temp-internal.h"
 #include "tcg-internal.h"
 #include "tcg/perf.h"
+#include "tcg-has.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/guest-base.h"
 #endif
diff --git a/tcg/tci.c b/tcg/tci.c
index 3eb95e20b6..39a68db287 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -22,6 +22,7 @@
 #include "tcg/helper-info.h"
 #include "tcg/tcg-ldst.h"
 #include "disas/dis-asm.h"
+#include "tcg-has.h"
 #include <ffi.h>
 
 
-- 
2.43.0


