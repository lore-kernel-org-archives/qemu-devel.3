Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3934C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 05:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSsZZ-0007oj-6F; Thu, 25 Jan 2024 00:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsZX-0007oG-DV
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:46:43 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsZV-0008B4-R9
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:46:43 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e80046264so79231245e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 21:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706161600; x=1706766400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtZZ56sUzFTpCzbFwRT2nXA8GRG0nPaTQ7hzW7FZp3I=;
 b=AkxVy75DKF4EkwXLLXBgyzngW34vQl7rQLgjYulZTAWHoCZZxkkUv+KqkLnuRBfCqV
 01j6o7U/IbynYDX2JzDj6bHd7OU2ROtHQy/MOM37iEAy8MmtaQdW1THvDTsozpNrtwba
 bADqrmM3iGMEzn9zNcE9zXw6hQJFhW5R5CQUK5WbG73dwpBUlJPAFoT+sxv+KTCOx73j
 vvliK53+kChDxI7x9K3pzJKHbbixzBC/wAAbAZxIKGN2IBxnWTprsER+E1x6s0SR5NGS
 +t3QBn8qxks1itb1iHYsZYzb7rhdyLv1zfCozwof3yygczohrr5/z2MeNMtYy/VUfNgu
 Xjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706161600; x=1706766400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtZZ56sUzFTpCzbFwRT2nXA8GRG0nPaTQ7hzW7FZp3I=;
 b=VoILyxI2+QKSQ7CE/Xat6sP/n8MfnkAQHuGvSEDTIfBb3OC9kfftGDTB/zXSxFGfra
 cm8REk3R27I51AsRIQ/jYVCd6rGZR5z+thIN7G7a0Tw9aQLdwvjteyDtkF9WeOqXsK97
 6MdyxqFFfixXviIKs9GENHkjEwWX+0xaLwSBJIS4kEBBwfX6MGEjVFA4mmJl9BNfoPy6
 33Koq+udyixfoHmKOb6HkH9zgscIE3CyX7vhYctzuWSTcSQO4TK7Wu69aZiVXKe51IqN
 bHwqKrMta3vRY6P1UalZwRRBJfYJN02B8fPhQRyAd54JVxZki9LDb5tuGdkd/nsFMeLn
 z7Rg==
X-Gm-Message-State: AOJu0YwJB9CrgTE6KmyDHBNGwfaRLK3HevmElXHa50zc5mGuFH7f7iOt
 AFnl6nO+VCMxTJfEzvyxbo4W2DMRtzgPmmvHFVKpVPTJXvXYE9F/oVWBC8zodjLfS0NBk1XOCOo
 q
X-Google-Smtp-Source: AGHT+IHqlX/+sPL3hZb5hR8uYS8ytnFnNLCorAmYcSL+/wVidpgMF3YSZ9yV1zkOZ2jWf1Kk+bSfYw==
X-Received: by 2002:a05:600c:1911:b0:40e:a7f0:a0f8 with SMTP id
 j17-20020a05600c191100b0040ea7f0a0f8mr173352wmq.33.1706161600099; 
 Wed, 24 Jan 2024 21:46:40 -0800 (PST)
Received: from m1x-phil.lan (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 b1-20020a5d4b81000000b0033920dfd287sm14975418wrt.19.2024.01.24.21.46.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 21:46:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 1/4] accel/tcg: Make use of qemu_target_page_mask() in
 perf.c
Date: Thu, 25 Jan 2024 06:46:27 +0100
Message-ID: <20240125054631.78867-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125054631.78867-1-philmd@linaro.org>
References: <20240125054631.78867-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Stop using TARGET_PAGE_MASK in order to make perf.c more
target-agnostic.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231212003837.64090-2-iii@linux.ibm.com>
---
 accel/tcg/perf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index cd1aa99a7e..ba75c1bbe4 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "elf.h"
+#include "exec/target_page.h"
 #include "exec/exec-all.h"
 #include "qemu/timer.h"
 #include "tcg/tcg.h"
@@ -335,7 +336,7 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         /* FIXME: This replicates the restore_state_to_opc() logic. */
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
-            q[insn].address |= (guest_pc & TARGET_PAGE_MASK);
+            q[insn].address |= (guest_pc & qemu_target_page_mask());
         } else {
 #if defined(TARGET_I386)
             q[insn].address -= tb->cs_base;
-- 
2.41.0


