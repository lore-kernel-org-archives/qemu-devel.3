Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3487C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIel-0000fP-HA; Mon, 13 Jul 2026 11:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeU-0008Uq-1G
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:06 -0400
Received: from mail-wm2-x01.google.com ([2a00:1450:4864:31::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeQ-0001DB-Gq
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:01 -0400
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-493c234fba7so7599495e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956777; x=1784561577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/609RMZa89NYqvuF+HwOL5OypxMf2knqG/PNO6QODEI=;
 b=q5cjrmgpCdPUdtxL11kDfZvufQ/OpuHcpzMFNRXaSFvd/0tsUxXBNLzLQYdEDYNn6U
 PiF8KRtPJTJE60SgQq5lWomZmxuIThxV2aqIDT72zMt6r5AVdFP77+610c4BwXxiiAPV
 lnVY1xgnt3n+A7RKnXwOs2VhTtB3KeWUneVBG1L0cQiumFyrGAba93Ada1AEGDJbppy8
 +L8y5HDFv5HvzDwxzqhNz9U7XsR0FkHvu+oTe5bK1oQcYatAeOdbxKQ93n9+BOXMFjeU
 Q9YlfSfechRlB3uGrvp+hQ0gfdBKASP07Boqy9Wamp+bpf7ekw1zzHNvqHloC1oQ0bfo
 bDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956777; x=1784561577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/609RMZa89NYqvuF+HwOL5OypxMf2knqG/PNO6QODEI=;
 b=orOlQ3c5gL0sbBDKlKKt5uBRwjgjo3q168wnlyDLKn1z8+wx9BoVHZC7q1YR2D9VlW
 udXAlR+gBD3rYfd7eAndZw1LsnddG877vmDw6VW/I9DOanHbjP+WgiOi8Qdc1Dhxca2l
 eF1PKv6GgVc6NvDRGK+kI/CKZQ5HNZKqVOFHw/F1tqMxXvv2J+QWUOhclDjs95jip/pZ
 Y1OQBAkL5pH/Z40hd4wm0w34ddsaa7V32HqCvkj8dCB6xdsHCTYmuQp1/+8EChxpVBcF
 rIYWqXNO0JeKKckIH6kA4qBznE9/uYvtvJhDboVur8pBc5YEVoLUzjjX1Va4jHp/ts0Y
 Ip0Q==
X-Gm-Message-State: AOJu0YyEtyYuyUBJsWX+d3Vtc+DDLR1MD9KXMnyTYgrlm6vkt0VfOUO4
 CpzOhKMxY10Vb+QyUKJBisHRGlapF4W/KJ5lp9xON0p5f7vZptAl4uYHookvNecfLbn44rpKl3E
 gLM4WX2jNpZtI
X-Gm-Gg: AfdE7cmgX6Pl35wr4keCH9BEfEGj/zFvIsfA/RS49qQ4N9ui2SkGD5J0NT8lMSyqnzJ
 l8DUAXYT4CKf0uMu9dpvEmAyP8/EIEjLIYoXRYPWTz1HwVwT3a8EiTffjRquyZrtTXp4k3o4hze
 JvQt45UHLFvSrrTYRalYlzn8S7CqhmQma0TsTbxWooGtGItuMqMGNfkkwUg+ER62OW6vN7AalOW
 /sAxgzdDbPWgq65sSuQ6ujMUNtkh0GhfJRrQEsOGpoSVoGBFPuKQCBbXBWfHDnEhBV7ce8rG2br
 MNGiOQcj/dzf68Y8VUT77gGmnZm6yfNu36YJrJCRR9h9XZVGcvoYiZxM5I35h3Uhnm+QbfSlH3k
 BX3gdTn7ko5GwDUHJMQNcHxV8JjiqaXBQElf6H5jpkfawORHbnk1byNEadewwjKmvoVHrihY9VJ
 gtxz9JDvYnnfmM2REyXhelvUa29m5vygoBwtXTmiKh8sW7iplEPPgiSbcrv70Gg2R2Nyd/h0HmB
 FLwUlLcDIurkXcMY6Bhx4ojBUZ10DuN
X-Received: by 2002:a05:600c:1f91:b0:493:aa0a:45b0 with SMTP id
 5b1f17b1804b1-493f8824b9amr96447615e9.23.1783956777024; 
 Mon, 13 Jul 2026 08:32:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/26] hw/display/sm501: Don't allow guest to set ram size
 larger than it is
Date: Mon, 13 Jul 2026 16:32:31 +0100
Message-ID: <20260713153233.3391818-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::1;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x01.google.com
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

The SM501 DRAM_CONTROL register has a 7 bit Size field which allows
the guest to change the local memory size.  We use the local memory
size in bounds checks calculations for 2D operations. Currently we
have no check on the validity of the value the guest programs to
this field, which means that the guest can:
 - set it to a reserved value (6 or 7) which will cause
   get_local_mem_size() to read outside sm501_mem_local_size[]
 - set it to a value corresponding to more RAM than the card
   was created with, so that the 2D bounds check will let 2D
   operations access off the end of the memory region

Fix this by decoupling the value the guest reads and writes to this
field from the internal size we consider the local memory to have.
We validate changes and ignore them except for readback if they would
be reserved values or values for more memory than the card has.

Cc: qemu-stable@nongnu.org
Reported-by: Heechan Kang
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260707150933.1410507-4-peter.maydell@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3811
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/sm501.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index d5e165daefc..cacb6c87ec9 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -571,6 +571,25 @@ static uint32_t get_local_mem_size_index(uint32_t size)
     return index;
 }
 
+static void set_new_local_mem_size_index(SM501State *s, uint32_t idx)
+{
+    /*
+     * Update local_mem_size_index on guest write. We don't allow this
+     * to be set to larger than the actual RAM size. (The guest will
+     * still read back the SYSTEM_CONTROL.Size bits that it wrote.)
+     */
+    if (idx < ARRAY_SIZE(sm501_mem_local_size) &&
+        sm501_mem_local_size[idx] <= memory_region_size(&s->local_mem_region)) {
+        s->local_mem_size_index = idx;
+        return;
+    }
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "sm501: Guest set DRAM_CONTROL.Size to 0x%x but "
+                  "local memory is not that large\n",
+                  idx);
+    /* Don't change the effective size, leave it as whatever it was */
+}
+
 static ram_addr_t get_fb_addr(SM501State *s, int crt)
 {
     return (crt ? s->dc_crt_fb_addr : s->dc_panel_fb_addr) & 0x3FFFFF0;
@@ -990,7 +1009,7 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
         ret = 0x050100A0;
         break;
     case SM501_DRAM_CONTROL:
-        ret = (s->dram_control & 0x07F107C0) | s->local_mem_size_index << 13;
+        ret = (s->dram_control & 0x07F1E7C0);
         break;
     case SM501_ARBTRTN_CONTROL:
         ret = s->arbitration_control;
@@ -1049,8 +1068,7 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
         s->gpio_63_32_control = value & 0xFF80FFFF;
         break;
     case SM501_DRAM_CONTROL:
-        s->local_mem_size_index = (value >> 13) & 0x7;
-        /* TODO : check validity of size change */
+        set_new_local_mem_size_index(s, (value >> 13) & 0x7);
         s->dram_control &= 0x80000000;
         s->dram_control |= value & 0x7FFFFFC3;
         break;
-- 
2.43.0


