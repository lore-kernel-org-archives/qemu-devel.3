Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DEEC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqB-0001w4-Dy; Wed, 19 Aug 2026 22:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspr-0001qQ-7n
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:56 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspp-0000Oj-O5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:54 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-836c4474028so22774267b3.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194132; x=1787798932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IrPGfl+huHTZPIohbx6Ak3r7i9HaCjXef11B7n7gDFo=;
 b=NBO8jxrgFfm3YlkRkV3qXXYAS47JEb9hV0wI6849ftwY6JyfmQCKDIwCTWNmy5UpfL
 fRTijTB+j/NaqWmcpEdmLgsl19r/3hjilzvZ6gEPRRn990gb4tuHXFFJRO3A7GnME826
 piTmAU1c+srlsgpW6l2YJXdFoHqFHGje66Cue2xrUVuicmuIRyvhFh/CQ+oXdWO4yUHh
 7CbnYY12bokQSdaAWDbQjHxNpu9wGb41F50KfUyuDL0R401kQq06M6oNPsrcLYPIxIiY
 kUW7j+KMNnkXruKgb1rHWbvXpwQq3xWzfdwCZNs93sQ0MhZFOUJy1Bmn9E4xYO3X0oUG
 7Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194132; x=1787798932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IrPGfl+huHTZPIohbx6Ak3r7i9HaCjXef11B7n7gDFo=;
 b=rxXMh7PxmrexPG67dszMNxHN8Sv/4D4E2c8yF28QjNIIOMjLsz6Y7a9lAA0vKt8Sn6
 Ij6kx5+SYGBpRfY+GC6yojnDna8rUDkkr1SKZudgZSyUADYoooaO1NJa9N5lz4QUwlqr
 U1cIBHX3sMHZ0lmeXOdNj+YNTB0s32dnH+uqPFEpPnMThew4pBeCseq/glK0vYpYcMIi
 Qy4sMr9C+IN93Toxq3hira7c2SPXZF0Va/69Y1V9oMosTBymFnzSLm2J1plEIZ2E4kge
 QbsON0KF8ek02XjuEyA84AoWQN7o2YRo1wXiNlqYP8B07DyDooKKvQ2qCGaOwTo45cTC
 POVA==
X-Gm-Message-State: AFuF++kxgKyrKqIN89X9scjOzwgDgp2pKtjCd0MEbqtUIZcTV8gZq28B
 oepGlz/Hj86WfbbcqtKnLRs+y7fdhp+8xoJF6lj3A+fUqCOnz1E3LD1A4rLNOw==
X-Gm-Gg: AR+sD11EbGw+IyWHl/omFxtnJP76f3sXyINviWiWvC8dCQRNr7Ndf4IJnHEVYmotKXT
 rU5wJeUuPhu4HnJdrKZG9pz1Z5bBc+uPGG3+Ze3RlO26XeYWiRPNwKkGp8ouaibkwYyO++ygdHu
 DuEGV74vZT0dHfwhz5atJSLqby1TlCBbE9hXasLGrejsKmyIzsubyS7CjM2+HABZCkm7E1GFCz1
 1uG/Ce5JMHkaka98NRYu77FpSlEp2HInASR09eJ73RAhDf6OtQMvkA80l59qxqdAHJBSibEHq7K
 q1PFdRdnb8xv1mIP3NPn19pi4BKDKJ3HB+bQuqKycAYHs1e5ZVtpHUuAjGWIMdIBw+ju+ao8Yok
 01oR9RCZpuV5HYjka4bOvoa6hPOhkUoj9nEUrD9eROrcLbOTPZ1Q6b4QLZWN81WbehtuDhSAkSm
 ZenD2KvPvEnepz7YPmlkGQJnYi7TDkFPaczl1rybVRHtA35HLxNralzmXr4Q2FAQ5ej4+SOZobf
 NWVbZ75vj1MmozZBmH+uXh9DnLKjliTrIKy+ISSwGfuBMVCeWa3V8bPu5E=
X-Received: by 2002:a05:690e:4891:10b0:668:8dc0:bcc3 with SMTP id
 956f58d0204a3-66ccb3a5042mr2453152d50.0.1787194131862; 
 Wed, 19 Aug 2026 19:48:51 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:48:51 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 04/16] hw/arm/armv7m: forward pmsav7-rbar-align-down to the CPU
Date: Wed, 19 Aug 2026 21:48:22 -0500
Message-Id: <20260820024834.3286721-5-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Forward the opt-in "pmsav7-rbar-align-down" property to the CPU object,
following the existing init-svtor / vfp / dsp forwarding pattern, so an
SoC integrating a PMSAv7 core whose firmware relies on the align-down
behaviour can enable it.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/arm/armv7m.c         | 8 ++++++++
 include/hw/arm/armv7m.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 68a1cbd6316..bb0f95d423d 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -332,6 +332,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    if (object_property_find(OBJECT(s->cpu), "pmsav7-rbar-align-down")) {
+        if (!object_property_set_bool(OBJECT(s->cpu), "pmsav7-rbar-align-down",
+                                      s->pmsav7_rbar_align_down, errp)) {
+            return;
+        }
+    }
     object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
                              s->start_powered_off, &error_abort);
 
@@ -562,6 +568,8 @@ static const Property armv7m_properties[] = {
                      false),
     DEFINE_PROP_BOOL("vfp", ARMv7MState, vfp, true),
     DEFINE_PROP_BOOL("dsp", ARMv7MState, dsp, true),
+    DEFINE_PROP_BOOL("pmsav7-rbar-align-down", ARMv7MState,
+                     pmsav7_rbar_align_down, false),
     DEFINE_PROP_UINT32("mpu-ns-regions", ARMv7MState, mpu_ns_regions, UINT_MAX),
     DEFINE_PROP_UINT32("mpu-s-regions", ARMv7MState, mpu_s_regions, UINT_MAX),
 };
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 70555962bb9..23cfed222c1 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -52,6 +52,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(ARMv7MState, ARMV7M)
  * + Property "init-nsvtor": non-secure VTOR reset value (forwarded to CPU object)
  * + Property "vfp": enable VFP (forwarded to CPU object)
  * + Property "dsp": enable DSP (forwarded to CPU object)
+ * + Property "pmsav7-rbar-align-down": align down a misaligned PMSAv7 MPU
+ *   region base rather than treating it as UNPREDICTABLE (forwarded to the
+ *   CPU object, which only offers it on PMSAv7 cores)
  * + Property "enable-bitband": expose bitbanded IO
  * + Property "mpu-ns-regions": number of Non-Secure MPU regions (forwarded
  *   to CPU object pmsav7-dregion property; default is whatever the default
@@ -108,6 +111,7 @@ struct ARMv7MState {
     bool start_powered_off;
     bool vfp;
     bool dsp;
+    bool pmsav7_rbar_align_down;
 };
 
 #endif
-- 
2.34.1


