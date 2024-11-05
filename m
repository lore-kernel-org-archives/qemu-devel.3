Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A083D3177A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Nsb-0004t8-DH; Tue, 05 Nov 2024 13:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Nsa-0004sV-1I
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:02:12 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8NsY-000471-70
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:02:11 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539f72c913aso9337328e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 10:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730829728; x=1731434528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B4flybjr/SUPciu6LlWIVGp3hVpYokY/O9EWZxZ1nKY=;
 b=hl/MlsIukO9HzmbggaVSmTBmsx3uv2hShWztEhIp10LIQCqCpL3+oVCynkqWV3nAef
 4VlWGnLmmW0usRP9Bw83HvbSzc7g6PDTLiFvFxBi0g7HdaZEfleewOOsbmDSGukuf8rQ
 PEF9HU00HQmjKMWyoYmTbaRkJWwXEEDjP6hW1stf3gyvfi/l6FHF1xC5JcjnoMIrhcsf
 cR76ogDQk+r21RlhtwZvMUKOK/4hXQZaXzKCXrXhcElbNfkK/UG3kHPawQnR/NvmFBO7
 s5apfTCBreE8ubUJbYkcLFC/85UuEhBESRd1oKZJH+Qyl7SzRoFn/o4fi8bo2bITIwf6
 PF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730829728; x=1731434528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B4flybjr/SUPciu6LlWIVGp3hVpYokY/O9EWZxZ1nKY=;
 b=A7qxI1nmTmtzofP8QYIRqBs9QT36CSnSKtLRMU3zuzu+TJzV8QmwzVMfnIK1mduV+D
 LHT3e4zw7wtsJK3ptzDPlfrWZj/W8Xlr060SGlOLkOWsiDFcc0seyG1Nref/3j6NT2vR
 DMmfc/ofx/FiIL9S7FeT5KEF0Brbvz4FCCnZ/M1sG/SGSplM748UHd4deh7pnhf1yVzO
 uPEo2t3USkQDqjlVS4Ehpeih3LXBSAc/dg/DJpsoMfIEGBfSvqaUqkMNRwrKUw9y2C3k
 C1qEge46NAqplqsw52CN/g18C/79B6V3Ml2iUIcygiwropOPKodqafyKY9/ZHS8BnMm1
 Hv6w==
X-Gm-Message-State: AOJu0YwRPrpQhTmnplfmWK3KYbwUPh5PRtnDH/BmG9FNZVw55Z9LnHMh
 3Vpq/mwjEa6qAspvGBG0Nuyf+e7gYGGvVj0sUGZeaPd9vlsBNegvYfvoCyJHqcxYDlnSdMv2ibn
 d
X-Google-Smtp-Source: AGHT+IE+f/2GzHdryF4uYYeTb0KUG9ynh6Pq1lkQ+4MaA6yzUaGmaUlgsBis5RAxhwEygeuqP9UILQ==
X-Received: by 2002:a05:6512:318c:b0:53b:1f14:e11a with SMTP id
 2adb3069b0e04-53b348d0d32mr19003740e87.15.1730829727533; 
 Tue, 05 Nov 2024 10:02:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a9a3bsm223969275e9.36.2024.11.05.10.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 10:02:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH] hw/intc/openpic: Avoid taking address of out-of-bounds array
 index
Date: Tue,  5 Nov 2024 18:02:05 +0000
Message-Id: <20241105180205.3074071-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

The clang sanitizer complains about the code in the EOI handling
of openpic_cpu_write_internal():

UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1 ./build/clang/qemu-system-ppc -M mac99,graphics=off -display none -kernel day15/invaders.elf
../../hw/intc/openpic.c:1034:16: runtime error: index -1 out of bounds for type 'IRQSource[264]' (aka 'struct IRQSource[264]')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/intc/openpic.c:1034:16 in

This is because we do
  src = &opp->src[n_IRQ];$
when n_IRQ may be -1.  This is in practice harmless because if n_IRQ
is -1 then we don't do anything with the src pointer, but it is
undefined behaviour. (This has been present since this device
was first added to QEMU.)

Rearrange the code so we only do the array index when n_IRQ is not -1.

Cc: qemu-stable@nongnu.org
Fixes: e9df014c0b ("Implement embedded IRQ controller for PowerPC 6xx/740 & 75")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Arguable whether it's worth the stable backport or not...
---
 hw/intc/openpic.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index cd3d87768e0..2ead4b9ba00 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1031,13 +1031,14 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
         s_IRQ = IRQ_get_next(opp, &dst->servicing);
         /* Check queued interrupts. */
         n_IRQ = IRQ_get_next(opp, &dst->raised);
-        src = &opp->src[n_IRQ];
-        if (n_IRQ != -1 &&
-            (s_IRQ == -1 ||
-             IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
-            DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
-                    idx, n_IRQ);
-            qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
+        if (n_IRQ != -1) {
+            src = &opp->src[n_IRQ];
+            if (s_IRQ == -1 ||
+                IVPR_PRIORITY(src->ivpr) > dst->servicing.priority) {
+                DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
+                        idx, n_IRQ);
+                qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
+            }
         }
         break;
     default:
-- 
2.34.1


