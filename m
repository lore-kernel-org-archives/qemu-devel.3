Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE01CC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIef-0000Ww-Mj; Mon, 13 Jul 2026 11:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeS-0008Um-O9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:06 -0400
Received: from mail-wm2-x0b.google.com ([2a00:1450:4864:31::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeP-0001Cp-Ig
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:59 -0400
Received: by mail-wm2-x0b.google.com with SMTP id
 5b1f17b1804b1-493f17dc838so11291005e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956776; x=1784561576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ieQsAJoqFn50qrRvzEKESxTia16D/RzkytXdep5v5mI=;
 b=ZIeQXp/jpMZ8smUDN8KHZsZ9H0soYcVoDj4E5I3LDrrg7P2QMFzNG8Zb+nyLn6SxPA
 yXG///AbA8u6e2PCdoGkZGLlZOegqZterQoPnZvZTE8HfsR2xg0PwG3PkqlRBgPA8gwx
 ksN7G0h51p67D80OLrs1neYDggrN5GMlV8tGreSVpC16CtcIPeVE+VPlf9BXyJGAFngT
 j1Oq1C0KSwDjBrbVF/FDLdpgeMHkuQQVoKPpFOnx4lV3deP421lwLhgZRnUluXVmoJSx
 JiZ10c6Te0Jt7daDBuIJPfjYWZAn9h14CkrT4gu22fuaHOA5aiUeDDNLJtg0aQhFM45L
 uzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956776; x=1784561576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ieQsAJoqFn50qrRvzEKESxTia16D/RzkytXdep5v5mI=;
 b=L0y984mGzOqlPLhMj8wTLwSMR0jT75pTTlcRb6CyF7+pfS9hsLEqrCp8Try+GNIJFV
 YBEIzLnUVb85CJx0FuogEvFHw8Ul2zvQSHoHYh77ptHwiAfeiPIKdMOcWaeFOtfODbOC
 N0p5VdN1taHVzWXycUJsQ+JtmkcmGxlJXfRSrWxLfSdEJIi0Hk//Bho8qjSHr2i4fMGS
 hihsO7HJFuvWMoy/AzFMAXT+jAKzZelqwzgS8nrRxWgevhFYgLHkFft7Qn0dbVNKTIvr
 qm8ku/7yYn6P6cFsCrwBdMYnJdA0wY6BdYWcujWArn9C4MWvOGVST4Qbt0ZBYPvAbz06
 zJ2A==
X-Gm-Message-State: AOJu0Yw5nQVTSt9edbZNzlLJeggg6rRvww6dziCMdgd90EK6nOChqg6B
 F+0qjhpjaEMy5T6jcYkaxzlWVZ9VRinZTEZwwsX6KECeHNfs9eHckGG+USEGAxmN63O+hOTWdEd
 RdxifhU7KfSpS
X-Gm-Gg: AfdE7clz7yP18+hXPIp/ZG1X5KP/j/kW3XuYjiJVjZBFo16RRoNmrVM4KWQpoOiDKWV
 ybFJUJ8wfcfDK1d+n9r7vonohdlXiVgxMElI1LC/n0lt5qpQKdpHHBvw2oo+D1CaIiEPlb4FKGr
 ePRNbJeYEIwoO1MNKS1tNaULAgao03dm64cTeEkQQSnXRH3j9ijylMTR/pVE/jsx0Wd+rAbohaW
 z3Ha8X2E9fG0irk0yTSg1boQKj3DD+C1L8O7QOrh4edR4TeQzPBKsO+umGeT2zJNE8fJ/T930c3
 n8L/kXf17Hgw/yXslATVA/o5iRaTs6fDLdDfGGdlxKosNnQ1LbB5Dg+5AGT+tvyQ9NYWVa1lqFN
 RzN/gVzBOZZxECxtqOpcXNTifWS/6a2lUIRh5WJ1Js7NgiSPQRwpwqNT975PL/iM9C5u5wdZuTt
 jGmpQolsR0lqzURVCWDcx/DuusAlOX0j8S9FOMiQe3tk1b5q3ioytvkiR1ALGExVci5Nq8O5jxg
 dl/CKFcOimQZGUizT5sbw==
X-Received: by 2002:a05:600c:4fca:b0:492:437a:a653 with SMTP id
 5b1f17b1804b1-493f8826c59mr97760855e9.26.1783956776189; 
 Mon, 13 Jul 2026 08:32:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/26] hw/display/sm501: Avoid overflow problems in bounds
 check calculations
Date: Mon, 13 Jul 2026 16:32:30 +0100
Message-ID: <20260713153233.3391818-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x0b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When we check that a 2D rectangle operation isn't going to run off
the end of video RAM, we do the calculations as 32 bit arithmetic.
This means that carefully chosen guest register values can cause an
overflow so we don't detect that the operation is going to go outside
video memory.

Abstract the check out into a function, do the calculations as
64-bit arithmetic, and add assertions about the ranges of the
inputs.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3584
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 20260707150933.1410507-3-peter.maydell@linaro.org
---
 hw/display/sm501.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 0da25477bcc..d5e165daefc 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -682,6 +682,28 @@ static inline void hwc_invalidate(SM501State *s, int crt)
                             get_fb_addr(s, crt) + start, end - start);
 }
 
+static bool sm501_rect_outside_vram(SM501State *s, uint32_t base,
+                                    uint32_t x, uint32_t y,
+                                    uint32_t width, uint32_t height,
+                                    uint32_t pitch, uint32_t bypp)
+{
+    /*
+     * Return true if the 2D area specified by the arguments is
+     * partially or completely outside the VRAM (a guest error)
+     *
+     * Limits on the input sizes mean we can't overflow as long as
+     * we do all the arithmetic at 64 bits.
+     */
+    uint64_t rect_size, last_addr;
+
+    assert(x <= UINT16_MAX && y <= UINT16_MAX && height <= UINT16_MAX &&
+           pitch <= UINT16_MAX && bypp <= 8);
+    rect_size = (((uint64_t)y + height) * pitch + x + width) * bypp;
+    last_addr = base + rect_size;
+
+    return last_addr >= get_local_mem_size(s);
+}
+
 static void sm501_2d_operation(SM501State *s)
 {
     int cmd = (s->twoD_control >> 16) & 0x1F;
@@ -731,9 +753,8 @@ static void sm501_2d_operation(SM501State *s)
         dst_y -= height - 1;
     }
 
-    if (dst_base >= get_local_mem_size(s) ||
-        dst_base + (dst_x + width + (dst_y + height) * dst_pitch) * bypp >=
-        get_local_mem_size(s)) {
+    if (sm501_rect_outside_vram(s, dst_base, dst_x, dst_y, width, height,
+                                dst_pitch, bypp)) {
         qemu_log_mask(LOG_GUEST_ERROR, "sm501: 2D op dest is outside vram.\n");
         return;
     }
@@ -760,9 +781,8 @@ static void sm501_2d_operation(SM501State *s)
             src_y -= height - 1;
         }
 
-        if (src_base >= get_local_mem_size(s) ||
-            src_base + (src_x + width + (src_y + height) * src_pitch) * bypp >=
-            get_local_mem_size(s)) {
+        if (sm501_rect_outside_vram(s, src_base, src_x, src_y, width, height,
+                                    src_pitch, bypp)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "sm501: 2D op src is outside vram.\n");
             return;
-- 
2.43.0


