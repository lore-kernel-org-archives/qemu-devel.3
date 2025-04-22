Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96344C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIa-0002YE-7U; Tue, 22 Apr 2025 15:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIP-0002Ub-K0
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:43 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JII-0006Bm-3T
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:40 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-af9925bbeb7so3663139a12.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350112; x=1745954912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4uV9K+TLMfIMj+MUCSSrjCJ+qc1eJ+tR/bSlvHT0v8=;
 b=FZlIMEi3JrzTbUx//hKlqto5pxbKmVuzEn7/bnXFrrfs/JUMPwTq7LLk4ODFKgXkL/
 HzhnpquddoN3dN+RnDdd9UgtOifXM4oneZ3eke5HNKgrUVeTr4CIVfytJ8/rxOj/5Wl8
 f4XzJw/Y9s62AE57+pULRzqDGVujlr40Pctn8QUrKtm2o8lgyauuHO9k2osZnGouZtEC
 a+c8HxqM65CP5tlBwuRnJYm3MzZAkp3U1qBZAhQiY+rcbMUP5fc/KqpmeSWa9EsehTf2
 jzkqQyTTLArqi9PzpmR4x/9zaGHzSUL4rHtZgNpUVAQdFbDQIzrztwdKgvvhoWi2vczv
 nlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350112; x=1745954912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4uV9K+TLMfIMj+MUCSSrjCJ+qc1eJ+tR/bSlvHT0v8=;
 b=LbetOaN6b85HbXUc4UeHWBF5/ZFveoAk+QkTPpoAxkl5gCdjwwIbhtNswg7lKIDWSG
 XeU51IJ48o4mG8b7+gLBo8Xp0BnfiKr8L7bBYszgxIzMUSbMR5pmn59FrGDbBweyu73r
 qdIvdYj7gH84WllLvPVTJfYxvAoQuqdIa4inKsExC11jLQIe2iIu7gB6hasIElcLaibs
 qFDv5RWM5NUqbeCWjcr5R+hePUhaDJZT1L19Ke87uxUcDCKR/vj5iHBXJmaoA/40vLJU
 HyLnxYitHbw2oY/CMY9F4sTj5ENWJhGIfZSz1b/dyp5hqgQ59mmBaR1Iu2SQUpbGhyrp
 lyvA==
X-Gm-Message-State: AOJu0YzDjRSgTpr6KFJ3eRe0QQYxRrOh9kOmK86DYznuVIB2IadpLyI9
 yqqTn0WjasVAQHmYlw/JX3zmxic9F4/KRsWeg3gbSiBB5w+nHX72By9QkIDbdt4WNTQZTurMn5c
 j
X-Gm-Gg: ASbGnctxf3I67sT14qIqaYyw/ok7I0Fib24IdnU6hPPy8hWtzPIBi3IEyWLnXWF3X/V
 AYXdJrnC2LEOhscFk5a1NVw6RssONyteVI2x7GRnsV2iDT32ipM1dH3sILOzIPYf8hyFCxd38Sr
 goqMPFPh/jA6Fg3Em1IgiZnxC2oP6PcekJrWZgjlJRKK2iYYyT4s7FcCvAHLEHMSv7PiWqN1HZL
 pmz/m+45iBO4JGAf27u2JvJlZlnxWXRWFtypCk0tCGBZFGNd9CwIycdvTa8Efd41ild9QWkBNDF
 5pwytQ7bn7l3cvn3lsw4r6WLiawPub4w2y6rVA+LW3WYjJGKClZNivorJgQ3V+RTBXN4QHX2Kac
 =
X-Google-Smtp-Source: AGHT+IFKM8fIBy6TAqA26pKGOVJgwYe5Xcmmy3xdiHkZq0X8crJUgfTkY5CILbO54W7SnD2QbZjQiA==
X-Received: by 2002:a17:90b:2b8b:b0:2ff:702f:7172 with SMTP id
 98e67ed59e1d1-3087bcc8fe5mr25450035a91.33.1745350112302; 
 Tue, 22 Apr 2025 12:28:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 018/147] system/ioport: make compilation unit common
Date: Tue, 22 Apr 2025 12:26:07 -0700
Message-ID: <20250422192819.302784-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-19-pierrick.bouvier@linaro.org>
---
 system/ioport.c    | 1 -
 system/meson.build | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 55c2a75239..89daae9d60 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -26,7 +26,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
diff --git a/system/meson.build b/system/meson.build
index 4f44b78df3..063301c3ad 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,6 +1,5 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
-  'ioport.c',
   'globals-target.c',
 )])
 
@@ -13,6 +12,7 @@ system_ss.add(files(
   'dirtylimit.c',
   'dma-helpers.c',
   'globals.c',
+  'ioport.c',
   'memory_mapping.c',
   'memory.c',
   'physmem.c',
-- 
2.43.0


