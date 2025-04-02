Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF35C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Hu-0008B2-Iv; Wed, 02 Apr 2025 17:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05HT-0006mW-D3
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05HR-0006YL-GZ
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso143579f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627947; x=1744232747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EVyO4Mxkb0F/UGcN3gePDsdWIGD9Ydr6wuyRdXDPD+Q=;
 b=vD0/Wy8CU5DuOx98Ri74nCFnoq6YlG6T8NQXe4U+IICZ6X5b79z2vuHwTaPkwkp4zh
 NngIpzzvV72fBRC6Fgl2jOqQzJvC4knZxBabTnZSEeZEKrWdiT2llyFGXYAH9NUhRJiU
 fgvM9jgWypegb4Ks3ciVgejYvJl5aEz9VXLtIPnFoHJ0XVoFjjEyX7kEKiA3Av46fXhh
 bwxh2cnjgB+6vTobsjRq0xiClJoukHnCu5hVDzdqz3ZD1/bUUukN2BovOQn8DUXt/qzX
 RRULchZNogKT+3kHENfWrJuPypHsXjEgIOy+8q/0Nrw9pJ5CURm+c4Z1WsnQj1pk1vwk
 6zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627947; x=1744232747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVyO4Mxkb0F/UGcN3gePDsdWIGD9Ydr6wuyRdXDPD+Q=;
 b=PpbkSlemnv4pz6TCSo8cbj0eQ0xbWaSrDWjfCuLJLlFSfMVXgK1J85OfqqIuHQe6ir
 Kyy/U+9CEE9dh/Zr9T0lrluvqKS1GNiCDKlLzKe6wHZE1sAhZ1dDVRFaodDQWhOU1jXJ
 h6pb32c/rtCagdj360yFPLYrZk9VLPz8eNdLpvn5+v3pQo4Rl0gzBzmbWvKCV0gaIYsU
 sfvP/Y1GjAsNyYXIen0gmTadTMz82P5nLhKgl1Ttt9bkZ7O521Pyvzng77ac7Sq7gvdt
 KLwuus5SftudKB42isOsccddddPxaxNxOvBRQtxywI8R4guByZWqIr2swcGMzlpQj8Ah
 eF9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzOQEBYGX19vCHFBcoGnhNdW/R2tYYZhzdERAthj4s785k6HJ5jW9T5PEKIDWq0geyWJy4iPrXz3wv@nongnu.org
X-Gm-Message-State: AOJu0YzEW+SP9wy3yLI5rgIWRnLhxQZVtnLLO/LNZJT0jFpYIdHQsnCO
 OiT6D4Vk3HCTVlnvNK3h7bncFjQsdV7X562ZhHhzeE1GlkWHJNpzj8TMVICAnrSqJcUUkcQgyqV
 m
X-Gm-Gg: ASbGncs7yxX1tQTQrvDtzwuithly8xRsryBhj9CTRBr8UT7wFEztP19/APiGwDi2dAD
 aD1dyDCNh2aV1GhVhXWNTGr/qqc6pUykKPvejGH1Dt7zFNAQOS/7RhHDDeYU3kJ8v9O5YRQ5k7e
 OsDAS9zv+v7tiKOEnKFtntPKqawMlB+Ez4/7DKLSFRTnVVeVnHcgvQs4oq1QNYdJ8PI9MKalS35
 IDySHPKeauDAkLbhdHpPSaRn6eNkbfGIGJikB+UhlgZ1MjRrlXY0NmKSOtaeElhmDwIV4OEE7HW
 q8e0xNaG+X2VHws/qEHn9Go+9O4UQBY3EZWPZoxa6l4hqvps5o5fEtt2eoyF4bIK3NGSV+P1LSR
 coZyyEriyvZUcInhQocM=
X-Google-Smtp-Source: AGHT+IFOSsrCo7en6nQT5+bMR6jGTx639Lk4FHdl5LoMOCI8dLEMLWfdWoRY/VsYvwDoZSDRb5PQjA==
X-Received: by 2002:a05:6000:2907:b0:397:8f09:5f6 with SMTP id
 ffacd0b85a97d-39c2f951192mr78575f8f.47.1743627947242; 
 Wed, 02 Apr 2025 14:05:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e37bsm18237563f8f.61.2025.04.02.14.05.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:05:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 28/43] exec: Restrict 'cpu-ldst-common.h' to
 accel/tcg/
Date: Wed,  2 Apr 2025 23:03:13 +0200
Message-ID: <20250402210328.52897-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/{exec => accel/tcg}/cpu-ldst-common.h | 6 +++---
 include/exec/cpu_ldst.h                       | 2 +-
 accel/tcg/translator.c                        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename include/{exec => accel/tcg}/cpu-ldst-common.h (97%)

diff --git a/include/exec/cpu-ldst-common.h b/include/accel/tcg/cpu-ldst-common.h
similarity index 97%
rename from include/exec/cpu-ldst-common.h
rename to include/accel/tcg/cpu-ldst-common.h
index c46a6ade5db..8bf17c2fab0 100644
--- a/include/exec/cpu-ldst-common.h
+++ b/include/accel/tcg/cpu-ldst-common.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-#ifndef CPU_LDST_COMMON_H
-#define CPU_LDST_COMMON_H
+#ifndef ACCEL_TCG_CPU_LDST_COMMON_H
+#define ACCEL_TCG_CPU_LDST_COMMON_H
 
 #ifndef CONFIG_TCG
 #error Can only include this header with TCG
@@ -119,4 +119,4 @@ uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
 uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra);
 
-#endif /* CPU_LDST_COMMON_H */
+#endif /* ACCEL_TCG_CPU_LDST_COMMON_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 63847f6e618..74761ba5f30 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -67,7 +67,7 @@
 #endif
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-ldst-common.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index c53bbdef99f..034f2f359ef 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,7 +11,7 @@
 #include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "exec/cpu-ldst-common.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
 #include "exec/translator.h"
-- 
2.47.1


