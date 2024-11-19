Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AE1D44162
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8h-0005w2-OM; Tue, 19 Nov 2024 09:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8e-0005ui-NE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8c-0006Dw-Rc
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-431688d5127so8484235e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026209; x=1732631009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4ehduTFlaV1+xi/7EuVQOcXgUVFMZSbQcp7hEKKJAOA=;
 b=kGhex8sgUrIm3BcJQ9sJPDh6MSUD0Fo6go7qDFipKnJ9JcecYNelY3w2TkYWeOVTgE
 zBavXMyO3WF8SAqA6WNMRh4bMI1PH+bLH44dQXD9cw8NKWrHKiLhBRLve9RgHtqPMsCj
 rei+slThoh+cvfoFBqzGXbWZiELmd+a6kVyxQw3wV+EY+DVDO+He72MyIO+l2CoF9hRH
 n34njvf2e62jx8Us5t73EfmI2iXTMsLsHAtqMV6wuskNBOcecFgkVr2uHGjMm5PuBtAC
 N3Uu5SVepV/7NSdJM8sg606qMMd7iBcxAUt9lh36RzUwYEOhzGfSWVkibqVF7pYQxfos
 Aviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026209; x=1732631009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ehduTFlaV1+xi/7EuVQOcXgUVFMZSbQcp7hEKKJAOA=;
 b=FYWZcDsGttBeNZCIZdcBmht0KM/v0MmA52iYfuXto2F83OpDQdHN980bcUsnzQs3Mw
 yuB3yZUZoubQxL9vq2uPks36rkkrgnGxUXoFBnhDR06HjcyFnXEM0DZaMUprKSvihc8q
 gFIwWBd6Qa44mUms5qvAIkoEQAZhkfhc7kvOglqlPZ5UWhdmtYTig23rxas0ObLrchlM
 RBby3BMX7/bGOFtMH1yCKgDLh2yg7FKVcDqfXCMRim8h5COUzQCHOZ2WJ4yXYQMf488Z
 TNZSysGH1Huxj9XGTUm/26kNuyKK6qq0nq2VQZDwAzozhLDqEQ5CMQ+SJ3iYjjmWUQIn
 +ssw==
X-Gm-Message-State: AOJu0YypCHcFqMzZCL2SSH7WsdISgxh7Q2EIbYbqgBZbniQLErsdQ9i6
 pQcAmIrTstSIkqqYXvlJ3haRabhqT+nKJ3+j0eH3V9BikX8XtfmEVHAa1WZTpUk40V5dngG5E6t
 o
X-Google-Smtp-Source: AGHT+IEybf/vmBD1Q87UjQgJrO3poKAWaDSWamL3EXzoaGY0unU8cFO0p0BdbBjdYC/Q8DHcxNCEWQ==
X-Received: by 2002:a05:600c:4f10:b0:431:5c1c:71b6 with SMTP id
 5b1f17b1804b1-432df74c8f1mr165322315e9.17.1732026209125; 
 Tue, 19 Nov 2024 06:23:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/15] hw/intc/arm_gicv3: Use bitops.h uint32_t bit array
 functions
Date: Tue, 19 Nov 2024 14:23:17 +0000
Message-Id: <20241119142321.1853732-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Now we have official uint32_t bit array functions in bitops.h, use
them instead of the hand-rolled local versions.

We retain gic_bmp_replace_bit() because bitops doesn't provide that
specific functionality.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241108135514.4006953-3-peter.maydell@linaro.org
---
 include/hw/intc/arm_gicv3_common.h | 54 ++++++++----------------------
 1 file changed, 14 insertions(+), 40 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index cd09bee3bc4..a3d6a0e5077 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -51,13 +51,13 @@
 /* Maximum number of list registers (architectural limit) */
 #define GICV3_LR_MAX 16
 
-/* For some distributor fields we want to model the array of 32-bit
+/*
+ * For some distributor fields we want to model the array of 32-bit
  * register values which hold various bitmaps corresponding to enabled,
- * pending, etc bits. These macros and functions facilitate that; the
- * APIs are generally modelled on the generic bitmap.h functions
- * (which are unsuitable here because they use 'unsigned long' as the
- * underlying storage type, which is very awkward when you need to
- * access the data as 32-bit values.)
+ * pending, etc bits. We use the set_bit32() etc family of functions
+ * from bitops.h for this. For a few cases we need to implement some
+ * extra operations.
+ *
  * Each bitmap contains a bit for each interrupt. Although there is
  * space for the PPIs and SGIs, those bits (the first 32) are never
  * used as that state lives in the redistributor. The unused bits are
@@ -65,39 +65,13 @@
  * avoids bugs where we forget to subtract GIC_INTERNAL from an
  * interrupt number.
  */
-#define GICV3_BMP_SIZE DIV_ROUND_UP(GICV3_MAXIRQ, 32)
-
-#define GIC_DECLARE_BITMAP(name) \
-    uint32_t name[GICV3_BMP_SIZE]
-
-#define GIC_BIT_MASK(nr) (1U << ((nr) % 32))
-#define GIC_BIT_WORD(nr) ((nr) / 32)
-
-static inline void gic_bmp_set_bit(int nr, uint32_t *addr)
-{
-    uint32_t mask = GIC_BIT_MASK(nr);
-    uint32_t *p = addr + GIC_BIT_WORD(nr);
-
-    *p |= mask;
-}
-
-static inline void gic_bmp_clear_bit(int nr, uint32_t *addr)
-{
-    uint32_t mask = GIC_BIT_MASK(nr);
-    uint32_t *p = addr + GIC_BIT_WORD(nr);
-
-    *p &= ~mask;
-}
-
-static inline int gic_bmp_test_bit(int nr, const uint32_t *addr)
-{
-    return 1U & (addr[GIC_BIT_WORD(nr)] >> (nr & 31));
-}
+#define GIC_DECLARE_BITMAP(name) DECLARE_BITMAP32(name, GICV3_MAXIRQ)
+#define GICV3_BMP_SIZE BITS_TO_U32S(GICV3_MAXIRQ)
 
 static inline void gic_bmp_replace_bit(int nr, uint32_t *addr, int val)
 {
-    uint32_t mask = GIC_BIT_MASK(nr);
-    uint32_t *p = addr + GIC_BIT_WORD(nr);
+    uint32_t mask = BIT32_MASK(nr);
+    uint32_t *p = addr + BIT32_WORD(nr);
 
     *p &= ~mask;
     *p |= (val & 1U) << (nr % 32);
@@ -106,7 +80,7 @@ static inline void gic_bmp_replace_bit(int nr, uint32_t *addr, int val)
 /* Return a pointer to the 32-bit word containing the specified bit. */
 static inline uint32_t *gic_bmp_ptr32(uint32_t *addr, int nr)
 {
-    return addr + GIC_BIT_WORD(nr);
+    return addr + BIT32_WORD(nr);
 }
 
 typedef struct GICv3State GICv3State;
@@ -301,15 +275,15 @@ struct GICv3State {
 #define GICV3_BITMAP_ACCESSORS(BMP)                                     \
     static inline void gicv3_gicd_##BMP##_set(GICv3State *s, int irq)   \
     {                                                                   \
-        gic_bmp_set_bit(irq, s->BMP);                                   \
+        set_bit32(irq, s->BMP);                                         \
     }                                                                   \
     static inline int gicv3_gicd_##BMP##_test(GICv3State *s, int irq)   \
     {                                                                   \
-        return gic_bmp_test_bit(irq, s->BMP);                           \
+        return test_bit32(irq, s->BMP);                                 \
     }                                                                   \
     static inline void gicv3_gicd_##BMP##_clear(GICv3State *s, int irq) \
     {                                                                   \
-        gic_bmp_clear_bit(irq, s->BMP);                                 \
+        clear_bit32(irq, s->BMP);                                       \
     }                                                                   \
     static inline void gicv3_gicd_##BMP##_replace(GICv3State *s,        \
                                                   int irq, int value)   \
-- 
2.34.1


