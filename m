Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9777FE66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKLQ-00017G-Ky; Sun, 21 Dec 2025 09:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLP-000170-7V
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:35 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLN-0001IL-OH
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:34 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso3647690b3a.0
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327012; x=1766931812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnmBsO3QIMZqiiQB9gmAI8e116+uSWX1dZXwpIlj+EY=;
 b=Ktje2F3jmHi8sY1G2yMYg8sH4U5hlDT+Ac3/ANX0fUIpWYIr64ZDIMJpNECnUmWR+y
 xwJkpgKwQMeQXIVb7Yoief7FYFe4D7KUaNsqsS4a0gXnHziS5hQgOZLMjcuRgEzlS1Bv
 j98DoI6kF80hPIYDQanq7/OjGz/QhApUXhGX28tB8EepHlZ9BzZLtsS06iRNdnIAKpqm
 eZI6jIkfek2xECmiGFWIy8sFYn5Ch7FD9vDUJSj9MXLpuIyfsVpgukd/XlA2an+P//5g
 WTPkI9xvH5TdUoOt8w9wJc1/n0Xv3eM1aiV9MIjkTh7CrT+KF5SF/Lem0NCBjsoDlu6J
 ux7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327012; x=1766931812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XnmBsO3QIMZqiiQB9gmAI8e116+uSWX1dZXwpIlj+EY=;
 b=p/6s3AzFGoVE0GxCBwhH8zhGjl6gsI8ewQ4NrO5WVPaggPPf8Li+dvPjG8GnesReaB
 xR9+ddOBPuZVvCU9QuLKNLgFAVompcVk6Fm0RIjpl91T04E4S4ZlyPJmKK+yFNJAzB5e
 wXWKNMzkym0WXi6EG36Fk9OUUJpwPfbzj/j0NLdqDs4l6G5Wu206XVx+siT54WoNVyGh
 jb5SI8dH1d5edmvC3CLRUjqfiUc0rg8pzL6KolnPT3e8eoBdhOBNkWsQGoGJE0eLH6Gm
 YyahPERTYOjJwJN0264ydiFa56q1SJ1MjiC20cU8NzkuvlMOaaDEwxrjzKUkKdAbDSaJ
 wzhQ==
X-Gm-Message-State: AOJu0YynNzJh31ei0Zrm+oCUaMX9O9L/ELEoos2gS0TKUm6RE/xGVaui
 cpHNRldmz9cwfJH5pn10KhU9KIBoT2tNDhT9jJ8H4N+Da9Tc1HFWFUsqN9Pf04jej4Y=
X-Gm-Gg: AY/fxX71ByxfdEWaK3n4ZKrx58P/UvaNhyn+1mRHNbzrIRcUHiLqMHsSdEXPly3yBZm
 Cdi/nXzGpUbFLNe/8XY/kpAV3gxwZARPbmIbfVDAO+pUHi0cSXEDaTi3ZToBUDAnACx0/MT6x1V
 qb0esZs2wVA6G3PnDOOLlH/t1+ZAh5XkjN8BVLviuHPtQ0ws+qUVrWUCdhHCRGw6ZwNmWb3fC43
 2/b2Z6MoJzL8XIMPjDISNhh22p7+LDI3lq/8sw07zyzMeAmtcaDVyKjQ6oD5W2udJqDRkeoiz40
 Ojih/sQ5kd4tbUJaHIDktkdfOFjI8QC6/UCK/NFsdO8FcW5MG0rPdMcsU84BxuVsTyS0vLAAtTv
 wM428twQ65FjVK4ZqdHO/8ENyxAcHqTFIqf0H4HuxgsWWjQrAiAkbcF4VmjlJJRNkOITajshzgn
 Dp0+ipV1UcYB0tUNj6qLM=
X-Google-Smtp-Source: AGHT+IH4reJV4fDLeMGNZF8oa8bqfeu4Pv/tHSxdI9Oia7pVXvqJnWfPjQqj/euKCkZ1zm4dh+rFrA==
X-Received: by 2002:a05:6a00:ab0d:b0:7ab:78be:3212 with SMTP id
 d2e1a72fcca58-7ff65d7e735mr6949142b3a.19.1766327011892; 
 Sun, 21 Dec 2025 06:23:31 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:31 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 03/10] scsi:ncr710: Fix interrupt related register handing
Date: Sun, 21 Dec 2025 19:53:10 +0530
Message-ID: <20251221142317.266293-4-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x442.google.com
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

- Mask DFE bit in ncr710_update_irq()
- Remove manual ISTAT_DIP clearing, let ncr710_update_irq()
  handle it consistently
- Fix SSTAT0 read to clear unconditionally when non zero
- Fix SSTAT2 read was returning DSTAT instead
- Preserve DFE status bit when clearing DSTAT

These fixes ensure proper interrupt signaling and status
register behavior during SCSI operations.

Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index ac1ca4cef8..0b7734a129 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -593,7 +593,7 @@ static void ncr710_update_irq(NCR710State *s)
 {
     int level = 0;
 
-    if (s->dstat) {
+    if (s->dstat & ~NCR710_DSTAT_DFE) {
         if (s->dstat & s->dien) {
             level = 1;
         }
@@ -1785,7 +1785,6 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         }
         s->dstat = 0;  /* Clear all DMA interrupt status bits */
         s->dstat |= NCR710_DSTAT_DFE;
-        s->istat &= ~NCR710_ISTAT_DIP;
         ncr710_update_irq(s);
 
         if (s->waiting == NCR710_WAIT_RESELECT && s->current &&
@@ -1811,7 +1810,7 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         return ret;
     case NCR710_SSTAT0_REG: /* SSTAT0 */
         ret = s->sstat0;
-        if (s->sstat0 != 0 && !(s->sstat0 & NCR710_SSTAT0_STO)) {
+        if (s->sstat0 != 0) {
             s->sstat0 = 0;
             s->istat &= ~NCR710_ISTAT_SIP;
             ncr710_update_irq(s);
@@ -1824,14 +1823,7 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         ret = s->sstat0;
         break;
     case NCR710_SSTAT2_REG: /* SSTAT2 */
-        ret = s->dstat;
-
-        if (s->dstat & NCR710_DSTAT_SIR) {
-            /* SIR bit processing */
-        }
-        s->dstat = 0;
-        s->istat &= ~NCR710_ISTAT_DIP;
-        ncr710_update_irq(s);
+        ret = s->sstat2;
         break;
         CASE_GET_REG32(dsa, NCR710_DSA_REG)
         break;
@@ -1902,7 +1894,6 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         if (s->dsps == GOOD_STATUS_AFTER_STATUS &&
             (s->dstat & NCR710_DSTAT_SIR)) {
             s->dstat &= ~NCR710_DSTAT_SIR;
-            s->istat &= ~NCR710_ISTAT_DIP;
             ncr710_update_irq(s);
         }
         break;
-- 
2.49.0


