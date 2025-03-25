Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2ABC36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0T-0002J3-3y; Tue, 25 Mar 2025 18:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0J-0001bW-8c
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0G-00074C-B6
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:14 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22435603572so114894545ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942651; x=1743547451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5VV71JY8goeor4xQCwdYnut93y9ysd8cImiGLe4Oic=;
 b=nCuF6PD/FRcp45a/9c8QzRZBhcy4jaMmCQE3XmCI7jRCmDNbGhi+cehg4dc4aczuGK
 mJ0conJalEGS2vKRIeNrIgAvk16ipf1b3qLUui2HwX8trfsSdYnhcIPpk2WNk6tS8hcT
 Cf4YdcwXcrKkNaAXoZMwfz0bwEDNqH8rhWtfT+NT0zq2vxG9IwTa/IhjK0CGt4RnATR6
 ATOkZllUoPk1i6Giojk2UwNRYDbWsNsAjf2r3TL8UJ07KNapp7CgnK34wAl5PBAZMD5t
 A1yFIcuf4K+xb8Koc8rzhD0XomqlG/ukVmk4mQ22oCgIKCic2gPEJoK1oMxhowMmb3oN
 fDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942651; x=1743547451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5VV71JY8goeor4xQCwdYnut93y9ysd8cImiGLe4Oic=;
 b=r2pGQ2bUgfkV/tuQhjm5rSF8/pTNg8Z5n401XpqOJ8BPd1h5qJT4hRlSfB2OturwYG
 5Zb/inZ8hzt/M0gZj1dAbO96bRj9dv8NUuzlSdFumsTY+w3jSa/7YsNG0WCcE0PrscIU
 hbG2jSw045uuZta3jd/NLQDjVnq25KPRc16Mn+oqt+c7ULOJqJ8EFqN8EeoSNeEmTr49
 uLozQ0EKyz2rQYpWJ3XB3XKn6W2nZ+5DZSH7Mq90ZWjGY3T1iKait6u86WADwv2U0HLm
 5wDj2do/FpbT33ExLEEeRUOmqIM7Qg2RFq5Qf1nrFojFG5J0aC/9Hdodfp6eKQa+r8j5
 QaMQ==
X-Gm-Message-State: AOJu0Yy5FaEwNn/mI+L0AbCEWWgOpjIY7lNaRPc3x2/QjYnO8mCQFEEo
 EUDoPZcPvO0PfL2l0s/B8e97sqWfs8JoHKYA1ARUNGPcNL/KJW8EmNDyBlvOkgs7gUl/yxtpLN1
 b
X-Gm-Gg: ASbGncu8lofDRA2zofzKNFfzlO7dRMLmJBgTnU2Rf9AjvUGSVoCPsr/e2okoYYZgSwX
 T5gd0IVu5Ize1lu7K/Q3BQz7cKphKnTompxW8GxjOqhaIVy1BAEGU2anuQRWDSnKNuVmuryaT1q
 EvZ87BO1+3zDBxOJiVRWe2qN6e2iDMbE2rxn8wsxn7qxFsVOwARgOlUOK5v13Kh3he1/k/DyUn/
 6LBS4mg0JitUWRZTthncmoRR7RDN9L2F7AKc2PTY9pbX0Hgsx7+r/fzJZaTcKLM8y5vOL17wrzA
 qz2Gw0dbHwf9bBdl74QeMbBF9xDZKs1v41jg/I+CQrAzeni8ruNvLXUrWmyAXKxCCdQPgGqYTQi
 H
X-Google-Smtp-Source: AGHT+IFm8a9NNf+4zvz2VHdcREc8xFi6eznh/Umr4XhI3SDmP0l4cw/4H0AepL6UTIWhemGEE41j/A==
X-Received: by 2002:a05:6a00:1a93:b0:736:6ac4:d1ff with SMTP id
 d2e1a72fcca58-7390598e236mr32895302b3a.3.1742942650615; 
 Tue, 25 Mar 2025 15:44:10 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 08/11] target/avr: Use cpu_stb_mmuidx_ra in helper_fullwr
Date: Tue, 25 Mar 2025 15:44:00 -0700
Message-ID: <20250325224403.4011975-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Avoid direct use of address_space_memory.
Make use of the softmmu cache of the i/o page.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index d0e86f5614..7d6954ec26 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -23,10 +23,10 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/getpc.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
-#include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
@@ -67,6 +67,11 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
+static void do_stb(CPUAVRState *env, uint32_t addr, uint8_t data, uintptr_t ra)
+{
+    cpu_stb_mmuidx_ra(env, addr, data, MMU_DATA_IDX, ra);
+}
+
 void avr_cpu_do_interrupt(CPUState *cs)
 {
     CPUAVRState *env = cpu_env(cs);
@@ -311,8 +316,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
         break;
 
     default:
-        address_space_stb(&address_space_memory, OFFSET_DATA + addr, data,
-                          MEMTXATTRS_UNSPECIFIED, NULL);
+        do_stb(env, addr, data, GETPC());
         break;
     }
 }
-- 
2.43.0


