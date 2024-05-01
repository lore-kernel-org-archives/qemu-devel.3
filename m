Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7F8C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B5g-0002en-Gr; Wed, 01 May 2024 10:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5d-0002dx-70
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5b-00026F-Mn
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ec4dd8525cso14157525ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574262; x=1715179062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0VoQ2qkKN/RYQvDr68owMd+LBRx3HOf412+iIHwvUA=;
 b=tLNv+QX3Z0KgyxF+r0rhdhom+mqpVD0E7nGJ3CwqeF2HhRn0KigF0pB2sGxDGGekh9
 FHCwzCL5KB5TBqyW3eJIKpBnOuyfSxvy6+j2yOP+WLKM9lP5/ks6QRUGoCuOKJuD+qfb
 4eN1yieIEFCSTrYrnj91UShqbfrZjYv9rriQ7mmtl3nZmv0u3MabCQ0FYKB87O0zg0Fa
 FieU3SyJhoXi5KYpA+cOUNoZUatXIYB5dXNxqc9noj3e/+M2wPFy15zt1bNMeVRpp/Bg
 NR06SDN9+5KmUhP/4fUSGD+gFRrMowVNOp/aQrUKIl3i9rsEr7j11XZnClvgiy/OZ0Bd
 f7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574262; x=1715179062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0VoQ2qkKN/RYQvDr68owMd+LBRx3HOf412+iIHwvUA=;
 b=JpBS2eowvbIbXPIKqgknwWVBtoCNxA/vVTFDX7ZqhGZELW00zhg5j+x8NdIQ45U/Wq
 rG6Y+lAjVBi0fX+Kx10athkL22bEDZOzHXPGUzgaweZz2xnVqNmOaQza55UoTn8Pgkns
 OJ6a5pGBdEPGg2oeu67bWTD70h20zqJid+TIID6GXskhqgV+N41gl+tw0JJ1Ba9RHq7y
 iWYYOkx++FtDfVSRhGNKGn16ewodsk6kBMciCDxKZKmvvaKamWCEGBaIH2B8q1XTZjpY
 zxmxsnXfE4eo7/lDDsH2tTT3tarLFA8bE4V6MC4eW3RQ9VqDv9trVZnzXBPi9zbx+wr5
 k7/Q==
X-Gm-Message-State: AOJu0YybLlFX/e+qS0Ed3srDKJdYAH/kak1LqmLFG+22sBZfl980Lwac
 SM8vmZr7U8F9cPrdelVtB9TUi3eVt36uznuFTy0LBU0ny20sJNif8/RciIiRDUCcI91ewz4bUuc
 S
X-Google-Smtp-Source: AGHT+IGoO+BS41jlSnKUW9oSlaIkqQ37bF7o7jNs+g2jfZE9TVk42vYFpyyvNcWyIQHRlGsHNFaFcg==
X-Received: by 2002:a17:902:c411:b0:1e2:9aa7:fd21 with SMTP id
 k17-20020a170902c41100b001e29aa7fd21mr2820860plk.54.1714574262287; 
 Wed, 01 May 2024 07:37:42 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/20] tcg: Make tcg/helper-info.h self-contained
Date: Wed,  1 May 2024 07:37:20 -0700
Message-Id: <20240501143739.10541-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Move MAX_CALL_IARGS from tcg.h and include for
the define of TCG_TARGET_REG_BITS.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/helper-info.h | 3 +++
 include/tcg/tcg.h         | 2 --
 tcg/tci.c                 | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 7c27d6164a..909fe73afa 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -12,6 +12,9 @@
 #ifdef CONFIG_TCG_INTERPRETER
 #include <ffi.h>
 #endif
+#include "tcg-target-reg-bits.h"
+
+#define MAX_CALL_IARGS  7
 
 /*
  * Describe the calling convention of a given argument type.
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 05a1912f8a..e4c598428d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -39,8 +39,6 @@
 /* XXX: make safe guess about sizes */
 #define MAX_OP_PER_INSTR 266
 
-#define MAX_CALL_IARGS  7
-
 #define CPU_TEMP_BUF_NLONGS 128
 #define TCG_STATIC_FRAME_SIZE  (CPU_TEMP_BUF_NLONGS * sizeof(long))
 
diff --git a/tcg/tci.c b/tcg/tci.c
index 39adcb7d82..3afb223528 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
+#include "tcg/helper-info.h"
 #include "tcg/tcg-ldst.h"
 #include <ffi.h>
 
-- 
2.34.1


