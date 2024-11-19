Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B005D44161
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8j-0005wq-71; Tue, 19 Nov 2024 09:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8f-0005v1-3Y
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8d-0006EM-Ct
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso31785225e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026210; x=1732631010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=voQfSzJ7jd39BkjtcjnGrb6m8ESBL3wvl/jN0QK3w8k=;
 b=MSkrWGugjJI49GFjq3kZ1ukhWTwTGYpFnZCTVh+rvcEZ/dqIiAju/ZFuRSm9VAMVJ4
 zNUm/6Fky82Tzax/wgwUs/Au4lHXsK4GrSkdt0Fzf3++wRXJLZJOV1E9YctbS9XIiB6/
 AngKTaDBRz/mU+r0+wKZtXFEOGFoJ/RiC1QgW2CQeCkgC2XRt0/B5Ijchrl4yAiczol4
 HOn1cQUAy2Lhq5ErxTx9Kh5TKwoUnlz+YoQvZm0HWnLkwswtW1A9LwQ7cN6+NfJGDCQe
 dROZilYqnzr6ceQ3A8+vgIWtuuVYvpMpcF/nncW5fn0m1eA765dg4m9QNu+eBw5RY4T+
 k/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026210; x=1732631010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voQfSzJ7jd39BkjtcjnGrb6m8ESBL3wvl/jN0QK3w8k=;
 b=bg68aFLaYAqD/DmvFKf8uNp6tKhDo6HWsfh/yUQjqa//8m+zFX2lrFCPyU2WkgS4Vs
 bDicmWQng9CO7n+S37vqEO/ISwKsnypAcAuCR4soLIjoO8u39XXayTInEDaSGFOL6T9k
 V28xbZmHTEBngNbCW6iGWTdJGLePkBeHMhmdKCrplAjB0XIPSee/yXQclAqR+dewlHOE
 Ns3K6ezk4JctpCWuf+qigdPgBRXDAbJgpIv0usPj5BBQXsFRmPBqSFjdCYccrRPdtmde
 ae0uAmy6OzykSNUDRTH08S1qmSTanNw6wT2A0mU5nxWz0dDF7vzHXlo7eQQpSvPuUH8n
 xO+g==
X-Gm-Message-State: AOJu0YwLsST48zUQTdX2Mme4qSGFs5IrYUjdaggdIu9Ei2D046zMh7y9
 fdShKR0MKwxGZ5k7PfXvtqnyf8FIDXNNFmMhrp9+pDMoVOPPY9Gz6V7cvhlnVsfBzCQQ9BXzCev
 R
X-Google-Smtp-Source: AGHT+IGbHaTf9u4dCq+LWc3+mC/6FQaIOdvghmlYqbNUbclOc/1DDQ4UGDo2e3ifuhHXUKpp61wTSg==
X-Received: by 2002:a05:600c:4f87:b0:42c:b826:a26c with SMTP id
 5b1f17b1804b1-432f57b37bcmr28529395e9.8.1732026209602; 
 Tue, 19 Nov 2024 06:23:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] hw/intc/loongarch_extioi: Use set_bit32() and
 clear_bit32() for s->isr
Date: Tue, 19 Nov 2024 14:23:18 +0000
Message-Id: <20241119142321.1853732-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In extioi_setirq() we try to operate on a bit array stored as an
array of uint32_t using the set_bit() and clear_bit() functions
by casting the pointer to 'unsigned long *'.
This has two problems:
 * the alignment of 'uint32_t' is less than that of 'unsigned long'
   so we pass an insufficiently aligned pointer, which is
   undefined behaviour
 * on big-endian hosts the 64-bit 'unsigned long' will have
   its two halves the wrong way around, and we will produce
   incorrect results

The undefined behaviour is shown by the clang undefined-behaviour
sanitizer when running the loongarch64-virt functional test:

/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitops.h:41:5: runtime error: store to misaligned address 0x555559745d9c for type 'unsigned long', which requires 8 byte alignment
0x555559745d9c: note: pointer points here
  ff ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^
    #0 0x555556fb81c4 in set_bit /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitops.h:41:9
    #1 0x555556fb81c4 in extioi_setirq /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/intc/loongarch_extioi.c:65:9
    #2 0x555556fb6e90 in pch_pic_irq_handler /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/intc/loongarch_pch_pic.c:75:5
    #3 0x555556710265 in serial_ioport_write /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/char/serial.c

Fix these problems by using set_bit32() and clear_bit32(),
which work with bit arrays stored as an array of uint32_t.

Cc: qemu-stable@nongnu.org
Fixes: cbff2db1e92f8759 ("hw/intc: Add LoongArch extioi interrupt controller(EIOINTC)")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-id: 20241108135514.4006953-4-peter.maydell@linaro.org
---
 hw/intc/loongarch_extioi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 02dc4e6db3b..97d1af5ccc2 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -57,14 +57,9 @@ static void extioi_setirq(void *opaque, int irq, int level)
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
     trace_loongarch_extioi_setirq(irq, level);
     if (level) {
-        /*
-         * s->isr should be used in vmstate structure,
-         * but it not support 'unsigned long',
-         * so we have to switch it.
-         */
-        set_bit(irq, (unsigned long *)s->isr);
+        set_bit32(irq, s->isr);
     } else {
-        clear_bit(irq, (unsigned long *)s->isr);
+        clear_bit32(irq, s->isr);
     }
     extioi_update_irq(s, irq, level);
 }
@@ -154,7 +149,7 @@ static inline void extioi_update_sw_coremap(LoongArchExtIOI *s, int irq,
             continue;
         }
 
-        if (notify && test_bit(irq + i, (unsigned long *)s->isr)) {
+        if (notify && test_bit32(irq + i, s->isr)) {
             /*
              * lower irq at old cpu and raise irq at new cpu
              */
-- 
2.34.1


