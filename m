Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926BDCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7S-0000kc-90; Fri, 15 May 2026 06:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7L-0000fK-TF
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7I-0001Zk-Sg
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso103721935e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842203; x=1779447003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CVNvm1I1sJtyDtBTJOjkPFwhPQX3HHSubyF1ffpDdds=;
 b=AUiN1ntLvYAawyZyCraRQ02XGwel66q1K43jcE7rKO40OQ65IqAnYDs0RE/La7dq+A
 PCMMnXVQyuiJqfJTZbyxoQ9f44f9S4ZHxaTWFAIHfauGH1K1/GPBemEZ9XAEoXpS/j9G
 1x2SwvFYQ1vJco/eIrv4Fi56LgPbwLEws7OhQcArT15pDPjD+zjOGmmSgVGzKcALA/M1
 A4R1NOjlGeVpC5R7uV127NW81thU1aQLIu6eIJ7P5TXLlMDqOOh4RqdX0sobNVkmasvu
 e7yLeC+GybalCcdHxKje84pJkos0TNfAj+zVjgUmAXuQViTtw4jAMq1hWwqh0Y8AXUJx
 nhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842203; x=1779447003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CVNvm1I1sJtyDtBTJOjkPFwhPQX3HHSubyF1ffpDdds=;
 b=MAXowtqUo7lRUHKDgkhm2wUSj0ooJbuixdHbVrz1knawOiGOhO4I9h8878taNOpQ4a
 /vr3uZnZNP6U/ROczxslLX4ihtl2GNUi8oX344jR6BZSjvvj4weygFRHJIVQake/Zsya
 WCJvH4CLlW9/3d5SLfh7SyHTfGzh3WHXeFbV48ZifMyjvn+Ihp194u34mSJEZP+kaIqJ
 5X6CEWa4K30wnTnHv8KX1gz7DxlVqnWO/7ARlFlg5ecxCXIN3803UyKO6aE7ko0x7HAv
 OqsrXqS4CCIAp2POLlI6lRemk0qIlW+tS2ufyzSGj5KtyCbeLVvBwm0uysl5tP9hUHU9
 VyFA==
X-Gm-Message-State: AOJu0YyHZxSREFdfB5JL1Ctzc8ZsLJj4iaTcH0SdwgtNiEdIA09QyrdM
 6aZqYDmtkwzZ6tq0iUiDP1yhJ9c2StrVwMaox5EbTX2IBS5uVKjsWHquDySftyGTRODk97GPnTy
 BpR7t
X-Gm-Gg: Acq92OHpgq2BBtxa6SwGzDkx7C6vDClJTWvKetBtZttjaTaFniLRDW+/fiTmmuHNGxm
 zpxFmvtoRy41V61o2zz89u9bi/wa0tC7jlzp1047KkxS1FpBKwOdDJuwl76FyoaAdhOf0vvOPFR
 tNbbt0Xv67c+9CBJ6JRWYtNlEpX9KPKyzHdnVffYpg89gP/Kl4bXBVKby5OWlqJUEnA7/q6xPA9
 LBFKc4YQiukrs1KCEd9gKrnBfR6v0xCKp11eSkoYZd/B1Ic4kjHWqSIwuLlsvGntZREcR5iZTWd
 BjgLfLJhEyrrpjlGX7GumUB5xqW3CzhPqVi3zL+x660avO71h7604YVeRvcGVgqbNYh5wuBwDTR
 /NhIukXPZllH/CKyB4EBu3kxao8JjlC54izxxZHI+N4dEp9RgSCzYFXa30DYpqGIy2bQVCX2vaj
 e/B53Da1kP0beETWComPLCTPhmKgmBgZNtQs14wZamwTJYPSKX3fNRhouzXxz1f2s5hoCrT09Iy
 omgr1CpNAgw7G/czbgT15S3/YWMQxheSGFHSx9mVTCVFvLobZDs
X-Received: by 2002:a05:600c:8b18:b0:48f:de5a:4a6 with SMTP id
 5b1f17b1804b1-48fe6515806mr50415185e9.26.1778842203046; 
 Fri, 15 May 2026 03:50:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/23] hw/arm/integratorcp: Use LOG_UNIMP rather than hw_error()
Date: Fri, 15 May 2026 11:49:35 +0100
Message-ID: <20260515104945.4145203-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The integratorcp board has some onboard registers which can be used
to raise IRQ and FIQ to the CPU; these outputs are supposed to be
ORed together with the main ones from the PIC.  We've never
implemented this obscure bit of functionality, and instead call
hw_error() if the guest does try to raise an interrupt this way.

Replace the hw_error() call with the more modern way to note
unimplemented QEMU behaviour, a LOG_UNIMP log.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3406
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260508162013.2751001-3-peter.maydell@linaro.org
---
 hw/arm/integratorcp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 164af03f7b..c25bbf3c82 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -23,7 +23,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
-#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
@@ -178,10 +177,17 @@ static void integratorcm_set_ctrl(IntegratorCMState *s, uint32_t value)
 
 static void integratorcm_update(IntegratorCMState *s)
 {
-    /* ??? The CPU irq/fiq is raised when either the core module or base PIC
-       are active.  */
-    if (s->int_level & (s->irq_enabled | s->fiq_enabled))
-        hw_error("Core module interrupt\n");
+    /*
+     * ??? The CPU irq/fiq is raised when either the core module or base PIC
+     * are active. To implement this we would need to run these signals
+     * through an OR gate with the PIC outputs. In practice guests don't
+     * use this, which is intended for an external debugger.
+     */
+    if (s->int_level & (s->irq_enabled | s->fiq_enabled)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: raising IRQ/FIQ via core module registers is not implemented\n",
+                      __func__);
+    }
 }
 
 static void integratorcm_write(void *opaque, hwaddr offset,
-- 
2.43.0


