Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3F3CD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcu4-00069G-3s; Wed, 06 May 2026 10:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsr-0004te-9I
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsp-0001jL-Hg
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ba840146so57432735e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076349; x=1778681149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pVWa7HWZcWALpqfD4g2BMHRotgfjymp5ZOIdJK0YkHM=;
 b=DrbOs2quAqmCvR4w9qIH1UnKipbETZ+nKObM1X9QibqA3jh/Ghp47QGfS63MnAv4M6
 gMcCpG4/yaNGXhSgQgIOddARGIyqOD1wh+eEnAdF7Z/cA2YXpO9fD07NHbWFSaTIQp+7
 O/HKfrUT3bV7L9BOeLlH+W0Mi+Rdpd9OmuQ1QOooaGX0JfVZTp3W1/r3BnkF59B0VFEm
 R4zduiVn4pGUzFzJFXhAjQ/Kr83KBBpy6HUEMN17gX2pIWU6ic/pSW0JtDLFVxnFzufU
 DaF6MZaW2p1dSH83y/GTFhZEqGeKTHSTGOmL3Kp4l6g6hnN8D00egrbE9UNIqTsY9XTC
 GCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076349; x=1778681149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pVWa7HWZcWALpqfD4g2BMHRotgfjymp5ZOIdJK0YkHM=;
 b=oSkg3OKbtqc/LwZRa5jB3FH6cHuB7/Ue3rSi1Lsrfhkvsx5oXH1VXjptYGpzdtSi6U
 lTxeNXCoXQe7gPxIdDXJfNsK9fiYmw3A8ir1rDYymab8nw97lX0Eyzq5MQrJ7y3+1/HV
 PeVxP8v9ZoXWgUic2ccqvwQ4+VAVsROPnoaEOdx3cN1YJDJfUfsPzdhZMMnABcXPhiYt
 AYZSOs6PHJ8AkHFaGqS0WjttPT/6yF3L7DwwdmiQpGA32iYgKo1Cpcv6rIW1ER1XrZGV
 20b4eWcu8z2+1jj+1amDwoZ4FcsvejYnqmXjabMp91kjaKgSoo5AFvpqHYQ8Pj1khysp
 NGJA==
X-Gm-Message-State: AOJu0YxS3ce6Iaiy8rvJwTRCU4m9hbQgxO54zSit7CX158z6dhpk0j7E
 KL/KTepRYDmFMnAQ7Lzd57/MQA1bVwtp+BBPpZ00zdQ9HSTk+RmVVzVCbHgsyxoFT/QqGckYxgD
 fnauPzY4=
X-Gm-Gg: AeBDiesbhHVkTZgTdbF6aO+HWvnKs3IlfpajkGOAkzzH8GjpMUZzcOFEKaUYw41BqL1
 2c2vvsS5SWQRW1y4KBsGWKIrXn28QBxWA36u8/TmgSMRUKhwMrzXSvi0+QpauXHO8100nDV+SEs
 wKyiba5qypPhpHdQsvg/G+BQKMFOsA4J/Hf3u279SQ/T4RDZOLBlsUdixzwSOHURKPblCSIp6xP
 SZ0eYl/1dv2kfKZLuQ6pWcKBgXbj/9wE4229ZmsvIZQ8W0DmU1QAJL4HC6ruaAeZT+IyUZKfpEg
 91SG2eaff6/K+hARcFNANHVGtVaELHLapoqB+JwzjV3gMo3/+qjOI+EcnWQ3HopT74XfZgFIw7/
 BPMhCukAAvaSeQ5dtI3AshYypvJdEjVgHe5X4ZlTovwCuDaTtgaxHcsKYQG0oglXwDaOZhWIMXr
 p2F8jJq8P71H4X3WFXh7xyeED9YL3sHdy4xpBIx/5cFaFFyYqXXv/PwBeVG7pgytjS9/KEEvwTN
 FaAwTh5guUtOUQYnOAi6g==
X-Received: by 2002:a05:600c:1d18:b0:489:149a:f9e6 with SMTP id
 5b1f17b1804b1-48e51f46dcfmr58859745e9.28.1778076349037; 
 Wed, 06 May 2026 07:05:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538d2878sm81005545e9.15.2026.05.06.07.05.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:05:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 079/110] tcg: Include missing 'tcg/tcg-op-common.h' header in
 'tcg-op-mem.h'
Date: Wed,  6 May 2026 15:54:51 +0200
Message-ID: <20260506135524.20617-80-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

"tcg-op-mem.h" uses methods declared in "tcg/tcg-op-common.h".
Include the latter to avoid when including the former:

  include/tcg/tcg-op-mem.h:34:5: error: call to undeclared function 'tcg_gen_qemu_ld_i32_chk'
   34 |     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
      |     ^

  $ git grep -w tcg_gen_qemu_ld_i32_chk
  include/tcg/tcg-op-common.h:328:void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
  include/tcg/tcg-op-mem.h:35:    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
  tcg/tcg-op-ldst.c:286:void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,

Cc: qemu-stable@nongnu.org
Fixes: a8af0fb24da ("include/tcg/tcg-op: extract memory operations to tcg-op-mem.h")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20260423135035.50126-2-philmd@linaro.org>
---
 include/tcg/tcg-op-mem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index 36931d1dd57..ea35a02fb40 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -12,6 +12,8 @@
 #error TCG_ADDRESS_BITS must be defined
 #endif
 
+#include "tcg/tcg-op-common.h"
+
 #if TCG_ADDRESS_BITS == 32
 typedef TCGv_i32 TCGv_va;
 #define TCG_TYPE_VA TCG_TYPE_I32
-- 
2.53.0


