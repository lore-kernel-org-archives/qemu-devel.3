Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0B8C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 17:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNxuR-0001UT-5K; Sun, 30 Jun 2024 13:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sNxuM-0001Ta-Ow; Sun, 30 Jun 2024 13:00:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sNxuJ-0001mT-OU; Sun, 30 Jun 2024 13:00:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-425809eef0eso2031625e9.3; 
 Sun, 30 Jun 2024 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719766805; x=1720371605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X7+B7DTvILz0hprjNPMxWKHIpvY7dKU6NeCNL63whXc=;
 b=GqkzUGZNtoX51VT86dMXJgsujYj+9w31jy0Gtehve6B1p12mXXloUiErqmvlQvc46k
 zB4kjfRbOgFIimVU7MUd9HCT/KWiIDYqaXVg6SnxTr0qFeJCAmJJk6fAk514rxl4CAFi
 iVFJigXD5t5NIdK68rbKW2lJM0DT1fp2keWT5U/J8oq3TZXH8tJ+Rw7/ABNVPFyNjvN3
 NvuRWsrYQFZ5HPvwG6diiu4ldb2VLL+phAAm9x2cErzeXHF+UgGqLhTHAWdEPPbFe5pC
 /9ZiMoeZ/m3CGiRd2XvR/Wit+kFb2+5z4f3WVKedxR3AQdeASU83soKl8rnWChtaiUQB
 XPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719766805; x=1720371605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X7+B7DTvILz0hprjNPMxWKHIpvY7dKU6NeCNL63whXc=;
 b=X4YS2CApfAwDWFu4eqnhXl28uUWE4ffiOvVjhylDNDHOrDemozhVz0HB6d6Px3nYhA
 hVwh5FmnYKYOBeGvXbA+PuIesOlyzvZrtVHWnJ/iooAinxAITG3Udu+7tOacVfI6VqDa
 gIhNPdi1j9euUzcpQ9sxQUsjOR6OWR5ALYtFTANKFKfdoD+IwaaVHx15/llWnxbwfAmt
 e99O7Rg01hY8f/ERFNx31o05wXNGZTLQBm+JeOYE3R6C1L+p2rvikdCgiBGmy3w5L37z
 aGksbTAI9yOcqYhlqGoqVB7kUHySPG8fMMxaXA2OGUOau4WVSAjKWWf+CzjTyF45AVyt
 CIgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbUEk5RXAtRy0J7DWtyGFNmlKThVA19YKUYkyqPP1Iqs9g78mfZPROrmuO/fpqyErSw2ouQmjBhIlcQElG0xcnpbNHbKKz8PvzDU/A4dY2ty7Vi7FB3gaD7YU=
X-Gm-Message-State: AOJu0YzOepwPox+s+27WkRb5dpb03pfIRBo4iQXRNvzXhp7T6wyppkP3
 9QtKSipg189oMorJKkP8sqWMCOAIil5K5tnRRps69cM7DK87JSk=
X-Google-Smtp-Source: AGHT+IF4dU4YOWKtU7TDIrFUipixuuBduoRpjonV/oMYOAC0SuQBXVJvsiSqd4Lz/44nMpdyP+/Ang==
X-Received: by 2002:a5d:47c5:0:b0:366:ee9b:847 with SMTP id
 ffacd0b85a97d-36775699500mr2359287f8f.14.1719766805184; 
 Sun, 30 Jun 2024 10:00:05 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb9absm7892869f8f.80.2024.06.30.10.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 10:00:04 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/char/pl011: ensure UARTIBRD register is 16-bit
Date: Sun, 30 Jun 2024 18:59:47 +0200
Message-Id: <20240630165947.2975457-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=zheyuma97@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The PL011 TRM says that "The 16-bit integer is written to the Integer Baud Rate
Register, UARTIBRD". Updated the handling of the UARTIBRD register to ensure
only 16-bit values are written to it.

ASAN log:
==2973125==ERROR: AddressSanitizer: FPE on unknown address 0x55f72629b348 (pc 0x55f72629b348 bp 0x7fffa24d0e00 sp 0x7fffa24d0d60 T0)
    #0 0x55f72629b348 in pl011_get_baudrate hw/char/pl011.c:255:17
    #1 0x55f726298d94 in pl011_trace_baudrate_change hw/char/pl011.c:260:33
    #2 0x55f726296fc8 in pl011_write hw/char/pl011.c:378:9

Reproducer:
cat << EOF | qemu-system-aarch64 -display \
none -machine accel=qtest, -m 512M -machine realview-pb-a8 -qtest stdio
writeq 0x1000b024 0xf8000000
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/char/pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 8753b84a84..f962786e2a 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -374,7 +374,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         s->ilpr = value;
         break;
     case 9: /* UARTIBRD */
-        s->ibrd = value;
+        s->ibrd = value & 0xFFFF;
         pl011_trace_baudrate_change(s);
         break;
     case 10: /* UARTFBRD */
-- 
2.34.1


