Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42960C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7Qe-0005RV-HP; Tue, 07 Jul 2026 11:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh7Qc-0005Qq-MX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:09:42 -0400
Received: from mail-wm2-x01.google.com ([2a00:1450:4864:31::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh7Qa-0006PB-TO
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:09:42 -0400
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-493b567a019so10608735e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783436979; x=1784041779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNyCnYjc9gI/MdleLfh7mXv3shlCrWbZOFKPeIq3AKk=;
 b=rHQTXxZfVS5svoa41w6UqYmQFtc9mYqBXVLPJu6mmeCbVqa5CCRa1CWUD9ncXzEOd1
 jsein7mf3KEprJhckOSsudBVcCieBhEhjJJq9IGCU8+es4zKxok+HH/aumAKcEdxUTHp
 aumnZx98zR2/iwKLr9VFRavc8bULLVNH5skQ5S2nNFaO2xJ8M5kGbuIeWvQhzp4f5jSH
 j66+W3jVqLmFeJf5IYO5mJjIkUh6GKKKvISz2smsVlu31p4fGLpeAuPM3+3VD1QG+dg/
 oL0Z94kuWSlrTzfn5ZRelaQ4uFmIfJ477vjZsxY/Ruc18wku3rBo1sTfmObGO8hHsMuG
 UGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436979; x=1784041779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNyCnYjc9gI/MdleLfh7mXv3shlCrWbZOFKPeIq3AKk=;
 b=Ffzcr4jw1rFT76OLotYBamdU5rdfSUaHa86O2E5Io+6MuaEYssggpCJBzYh4Nbmojx
 GqLJv6JcOzC2lJP+E4PKsCROUtVnLIlYqcdLDSjIZQnH8b7G7A9i2AlnYA8/yDYSiZBw
 yPuwk5UWpwMJ7fUMd46F4PVPuvBNUVIGXb/xGnEGP9ETWrUtOxPV43YXzdWZc7DHoj4E
 reQJwkoRPiX4Bb+vPfkhITqb1YGQwEyon99MvhxZo/Djj0hgnrTeY5NCtNh77BSFiHa7
 J+CmsZhbSRkbn1OFQHzrElP1WdCYcMqYsZBjIAWvI9yjp/asArlCJJPQooTdES5C7Q2k
 0SVw==
X-Gm-Message-State: AOJu0Yzbz6f0NlMUAfRiHqqNlilRaM3aaeGFev1rNmql4GuBlyg7ra97
 Y7P7YLnvwJk0trZdwUto4JWc/9EvmZ+yQia2VhXfefEst6yRkqcg3T7/nRiSgUhEE9+vO1GVnES
 cCzzYG+ue5LOV
X-Gm-Gg: AfdE7ckS/3kuzoT6p9BTSSVIZRaXcwzfuMGO9I4lSBNHxRPOsC2q2CK0RS8occxKE7N
 QiBqb40A95c+knLLaumcRI4F/zpxtXimnoT+2Ig9I1ksCxTkW1H026hYJ8YL+2r/hJ2i9us3SkQ
 /smnyO3wDXziNJAh3Ckh0L2iIlXSbluyKiPPeYD/arlgSPsjjCZB42DnCwr7ViT+juwXSn9F3XF
 hARpnD2jHsOZEozp9oUY57mLlup6Cs+IMzefPfnSMHm0wbkCZ50bmgi23G6KBxS3IpLbi/zDD+0
 7mO/c4EKjAqR/k0JK3OJyJNENL3wtUzYetB7ILMW4RxpoGuoxxBqrGXJyXS2+UIf+7jbhuxvAat
 IvhG86u2hmz17G5c/NlAZwH1+VIip+16ZMYWPHcANEM8rwuqc4j1lstJ1zCI/YeA3qDzVdlp8UH
 EkWAd88Z3cyPJoSLkvtBFVEFCH32zBD6avGJMSE7ualjBy1LJiIhge4GyajaoMycUruFS/6EBWp
 xkNCogBGnG2YVpn/4ZOHw==
X-Received: by 2002:a05:600c:3b9d:b0:493:e311:5f10 with SMTP id
 5b1f17b1804b1-493e3af1279mr28652685e9.10.1783436979277; 
 Tue, 07 Jul 2026 08:09:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e785sm34181813f8f.8.2026.07.07.08.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:09:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 3/3] hw/display/sm501: Don't allow guest to set ram size
 larger than it is
Date: Tue,  7 Jul 2026 16:09:33 +0100
Message-ID: <20260707150933.1410507-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707150933.1410507-1-peter.maydell@linaro.org>
References: <20260707150933.1410507-1-peter.maydell@linaro.org>
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
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3811
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/sm501.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index d5e165daef..cacb6c87ec 100644
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


