Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78C1C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVoi-0006yr-Ge; Thu, 15 May 2025 06:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVns-0005hn-SN
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:05 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnr-0008JM-1v
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:04 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a1f5d2d91eso427581f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304817; x=1747909617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=97ZZBvdmNF0X3lx5ZR5EO55LMqvaqGIqAUiNymsGAhM=;
 b=huGK8PV/zX+/eL+mAatduOl88RQCK/wH65GEOTJ5QU8Ynb0iUhb8mkfBt6QZMpkFcx
 s2d2dVyYVE/n3M6lffVvY1fiRf/Gnv5nRx65Ie5rrnVseNa1kt2LkaphcO4BQnLF1VTz
 rhrOvR99g5t2Lmb6QP8Ssl+LohegTHFKYRGYMi0n480Whm9WoNESGoz058j2if4M1R7w
 zqNyo02Te9DMsPdhGKaPAHVQGsPWpMZCKUXGtOPPFCrEPI5ZO0JvaoCOJYGr9CJq21Cs
 EQNfxWDp0aYJz56VEjrlNtR/audtUqLH23e+i8p+3eA5kuA8u1xEDnOEE1xzF13i6pXG
 ZZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304817; x=1747909617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97ZZBvdmNF0X3lx5ZR5EO55LMqvaqGIqAUiNymsGAhM=;
 b=Z7rOae9LhgFxXSA/TGGGuo/hI4Lw0QB75xdQL3A7P3+nhLTgvae2UKfJN2q7xRZ7wF
 2BjnUree23z2FTBaRdZUPvl3gwPTfNfmIuL5q/qxZ2V/X8xpRLIybRfet+q1USrTVPl1
 umgYhoabhQq+2gxIEzHymj8ds4tO5FnhFO/WaYyUdpxLsmIJTnh/KB0TMQybUpwm4zWe
 loD4Vbdtplhth1lrIuIu4I9Douc9b3IdGY2EQD3R5DuAFpjg8e8WKW6iB5encoJYRsA6
 +CcZxpxg6ni0THaNg++HHpmqS8mYwzTNZSOPMrpGqJOTlsyxkkU10Q4gDPh9P21jDiPD
 alrQ==
X-Gm-Message-State: AOJu0YyFTEXjtpDwpRd/wiDPIXm0U5S6dZgIhjwdePRrHbLnzhMeTzx8
 MnI79XdX+VJGRkNUU+mHQYQ6yfBqbPIRqrGqWs7QEDGOsR3ZpzV6ibwRzUKnpB/7pPQOMgQMssh
 MzE0=
X-Gm-Gg: ASbGncvcUJwXB0ba5qoU10xDuPjMBRF/cHhUYNg2B3Y29CMdJInTPaSzEV9TcvjacT7
 nq7zMj1312A/+pe7ZPna0wsCbqjuBiC7QRZrwgErM5zEUZ2bNbWQ/lBnLaRIXImEKanl4bB2RmN
 bFIrSiUBi4k79eAPYm/1A1TSplWZ/tMnzglGEWDrzQKqwowCNcNy2t8F480rdWiSHh/8nau5oZh
 IJcR1XsR1zmQXDQVic7ORcfNCPnoADobEsDvoCN1YJNVuYqeeKSFOFpvumtn05o8qeLLVISuIi/
 dmwo0OvQtsZ2HfZrLnDtJma3n/mfjOCymZrGjjfyzdlbl+474Uh+b+YGog==
X-Google-Smtp-Source: AGHT+IElbrCTemBYe6bJToe/SAe9fFH/bdWOmt5RLPqUURuYg84icWQnI3bjpPa4HHwHbGYjrKw0SA==
X-Received: by 2002:a05:6000:1864:b0:391:4873:7940 with SMTP id
 ffacd0b85a97d-3a34994d99amr5866627f8f.54.1747304816781; 
 Thu, 15 May 2025 03:26:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/58] target/arm/tcg/arith_helper: compile file once
Date: Thu, 15 May 2025 11:25:45 +0100
Message-ID: <20250515102546.2149601-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-48-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/arith_helper.c | 5 +++--
 target/arm/tcg/meson.build    | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
index 9a555c7966c..670139819df 100644
--- a/target/arm/tcg/arith_helper.c
+++ b/target/arm/tcg/arith_helper.c
@@ -6,11 +6,12 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
-#include "exec/helper-proto.h"
 #include "qemu/crc32c.h"
 #include <zlib.h> /* for crc32 */
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 /*
  * Note that signed overflow is undefined in C.  The following routines are
  * careful to use unsigned types where modulo arithmetic is required.
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 5d326585401..7502c5cded6 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'arith_helper.c',
   'vfp_helper.c',
 ))
 
@@ -59,6 +58,7 @@ arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(files(
+  'arith_helper.c',
   'crypto_helper.c',
 ))
 
-- 
2.43.0


