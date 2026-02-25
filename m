Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61C1FD377B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 18:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvJch-00089P-PL; Wed, 25 Feb 2026 13:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1vvJHm-0000Mk-4R
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 13:06:58 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1vvJHk-0001ik-D3
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 13:06:57 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4836d9d54f6so13845e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 10:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772042813; x=1772647613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h5i/S0F8WaVSH6FBxTagf0cVwpWVUmKIj+pLQmf7lvE=;
 b=HO4fiU/AooQNzxM0ZvEwoSs+V93HnsUiLMOrHWTty+vNeGhTz7GkUJY56JfOYPZx3l
 wnEKbzh0k4wzZTnDHG/mzzjs5CRtuaBcp3+C8TRmC92Tu9qYNMXsxiG1krUGpXb6IfWN
 /X6XWDhtPpw0pssh4Lrzgv+rwcLNhD825eByQAInDbzOfsjJnzJr0UN/6De9mafwWXRa
 yNyvtSMnWAVwHi8ExY7Ccu/1wEvqDE5UFfmSrls/Mzwo3JoDHHR4rt1/Q/ETg4ZHU9cd
 V+klygWg4KhLXuLgHDDyzTh77vE27Y2wqu8BoyM1pmJOlpUhzqiuD9ZbcVn7IHPlSVBi
 7D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772042813; x=1772647613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5i/S0F8WaVSH6FBxTagf0cVwpWVUmKIj+pLQmf7lvE=;
 b=bPzSXHA6OPuHLFr/jcClUt57tHkGEEr2AGkwWSJZLMUL34Hk/QeWOMhXJv5CnPh2pe
 fR6bHI3is1gzLgKGA4nzxB1EYDWYPsS9rzsYGVhHb/veuaRg+0KIICkkG+n30FqN6PtC
 DCnjSMga0fTJi3M/vQZkQCwNDq5woKk0LF1YId8C9vx1QSXG9ikUW1kTMUcvj4+4kljt
 Ik/MTrmLMal49M9f9hU2iesx6U/j8rQZhQTETMScbTXR4N3SHZwtOUr45YyZ6TaL1gYy
 rhuVCuRHGukTbrW9XDwqKNAihPgRtml9ouUxsbR/Y0Ybz21GFJTh/aibLnoDlPWAtrGq
 AjgQ==
X-Gm-Message-State: AOJu0Yykh+8cv+wLrD4ezf4vWLxNazRs431vv5JfbEMyB+Pn/9CbbORQ
 aCh8bnVBKBc1AEhb3Vvy1ZoBqy+y9pF1+aEw0WIsDAdczH0/xDyKbQ3xnmxfmgOEhtM=
X-Gm-Gg: ATEYQzwCWlLd0jBshEYtm6fbUEuX4YU5OiVdrvGZBmv4J5GneXtWxozMkM5/6pDw2Zk
 ZZRgzq44/0CDaGENYEA6iKj01psBhzFUJM0JQ+zGOcazmXbZUKnCfGHjrencsit59Z2dXCwC49W
 zPSVHupiGSdBix4ULrUgs02E0r4ZogTTAI31ViYVjXigAjcA+Dx3pLv1zRSv87iq2F8WWvu0q79
 icBrigjEbonRB5nNU1kZknkYm8XIAZ+mcjCnJ4QBiOQvP8chrTUngvxsb8bZceMozqhlEq63d46
 FkmJbZlLwuB0uXfhpD3d8lEHZiHoiyKGqQi8IBzRmZwFyOU988W6LwGNyVL1AGZsQyX2gt02Ftg
 sm3EXSHDlxijv8rdH0OUQrSbdSm5RzFQsPW4sE0Btg3pFG4RJ6CKiR0OPPrLp08py/+7f+4vKKI
 7L/+KxPaUjB2RcseRUj29fpAfBNN/a09KaTg==
X-Received: by 2002:a05:600c:450c:b0:47e:e20e:bbbc with SMTP id
 5b1f17b1804b1-483a95aea49mr162371815e9.1.1772042812741; 
 Wed, 25 Feb 2026 10:06:52 -0800 (PST)
Received: from AtiePC ([79.116.184.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3ff6dsm37225977f8f.25.2026.02.25.10.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 10:06:52 -0800 (PST)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com,
 Daniel Paziyski <danielpaziyski@gmail.com>
Subject: [PATCH] hw/intc/apic: mask LVTs when software disabling the APIC
Date: Wed, 25 Feb 2026 19:05:55 +0100
Message-ID: <20260225180555.154428-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Feb 2026 13:28:30 -0500
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

According to the Intel SDM Vol. 3 and the AMD64 Programmer's Manual Vol. 2, when
the APIC is software disabled, doing so by clearing the software enable bit from
the spurious interrupt register, the LVT entries must then have their mask bit set,
and any attempts to clear them must be ignored until the APIC is software enabled
again. This patch implements that behavior.

Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 hw/intc/apic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 8766ed0..ef52961 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -919,6 +919,13 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
+static void apic_mask_lvts(APICCommonState *s)
+{
+    for (int i = 0; i < APIC_LVT_NB; i++) {
+        s->lvt[i] |= APIC_LVT_MASKED;
+    }
+}
+
 static int apic_register_write(APICCommonState *s, int index, uint64_t val)
 {
     trace_apic_register_write(index, val);
@@ -964,6 +971,11 @@ static int apic_register_write(APICCommonState *s, int index, uint64_t val)
     case 0x0f:
         s->spurious_vec = val & 0x1ff;
         apic_update_irq(s);
+
+        if (!(val & APIC_SV_ENABLE)) {
+            apic_mask_lvts(s);
+        }
+
         break;
     case 0x10 ... 0x17:
     case 0x18 ... 0x1f:
@@ -997,6 +1009,9 @@ static int apic_register_write(APICCommonState *s, int index, uint64_t val)
         {
             int n = index - 0x32;
             s->lvt[n] = val;
+            if (!(s->spurious_vec & APIC_SV_ENABLE)) {
+                s->lvt[n] |= APIC_LVT_MASKED;
+            }
             if (n == APIC_LVT_TIMER) {
                 apic_timer_update(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
             } else if (n == APIC_LVT_LINT0 && apic_check_pic(s)) {
-- 
2.53.0


