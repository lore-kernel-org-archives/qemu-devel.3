Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E188FCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11W-0003j9-41; Thu, 07 May 2026 11:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11U-0003cO-23
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11S-0003sg-1M
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so9001615e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169140; x=1778773940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mzKl+lbW+z67na7zbBkRxEC+ZYWf7DRAQ11ALD4aoGc=;
 b=vOiLju3vzs9RiDbm1F+BYLI6KdAQ+2ucxKUW8s8ddiy++BIoVoY55RroSkf2r3i9Xe
 8wYXa9jr28Jr+728WAVlZ1pjhi0R5lrvEEIR1NfnlGbvJhKfbMr0fOELLpoDSLXrcad7
 nBwh1gfuBBF1JfrV8bemy52RC3kXZlhWA1ZW5aFS7uKC5BbruapwGuSolFLtHe9dToVn
 NSah1MtQjT2tTGeTjw6QgXAdJJiEziDw5dNuPkXSCQs5EM/tW/+uA6/30aa7CCS2mz6U
 zZyL5wbL3Jhsey/XvrhTyxQqJY9YlBo5pu0AViZpkxliZrG0dq3O8lYwIPqIqoIxblCg
 2rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169140; x=1778773940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mzKl+lbW+z67na7zbBkRxEC+ZYWf7DRAQ11ALD4aoGc=;
 b=oRd02Tb9JXCY4wjsjaRacAb6om62cwqxLhV2jwPq0C+7m0VCoeucjbSm5i0T4+V4Bu
 /0xkZgMwxfd4OsWzfFGmYFUprDf2bpmm+EISfc867wsphGRl/Z038g5nFmGrk3yEw2go
 wbpCs38ssOwQ8NC98QrEHQcdXuJ0wCrDuuLXDyFzhlllr3GIXgt5h3RdcAvtyzOSabrW
 HConHYJjsJHAMgTtTWB5pe9+ktfARcNDxLd/uclV3CO41fw/Vuk/V02zy4bkwYaDc1ZB
 g+J/kbBm7GrsFS/B47a0uANHfd5SKSvSrI5w+ZE/zaG6pwpIIM0yL9iBvnfru59WTynm
 4udw==
X-Gm-Message-State: AOJu0Yx1Fp8fz+8CaDn2fz0J1Jj2nT8H+L/N3hwtkuo3xl2OvwaLHmPA
 M27WET0zN/tvUcI2EVRd/fxSVGj9ZBezMT8YFmipPgTqMBOucYuxc+thtX1VgccdQv9FcG4VRnQ
 v2AFm
X-Gm-Gg: AeBDiesqA8rOXEaaQ0epmCJGF7m1KvyynLNKndPsZxHX/pw/+eePtsV9ci50ghHZkyc
 kj9ZUWomSSix2ckDXWrn6OtRFsvjW6I32PVQhZgffhe++aQMs/PwfHsLr0PIie7nUS/VcEDiPoV
 mwjw2lVdy+QyQQThcGVn+gcG55GUTmUD5V9IrcZjPxD//wNag132K8hCe0F5XpfKpLtu/cPe5AN
 mX1+dXvm+tE/Cs1+2NZSFKKFkFx8mmRiF54o3qQmaL7TuQ7T7bgr3QNxlTpjeg4rxTIuc5SCbgx
 i6zUiTps2hQSG1gtqwRQK58hEyHSgBOH5Uu2gTfHgXC6CMUeDY9cNnkwA9PES6Cvc0akMMn0Zn8
 +J6XnSPjV+QRYP+MEeK0El9DyciQF4vS88EX1DiKgtf4HCzD+NfE3xRtWgJYhYs393QsY9pPgs6
 5ChinjESiujYi4WKvzmOqQwI4lbnGWNfN3vzVbTk3Tq13G0RHhXq7Tc4rgUuPGx1C1T/TAdJjqf
 GltmFsJ25QMDBvL2eL9zAnP+F+PliGL3Fj2HA==
X-Received: by 2002:a05:600c:8485:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-48e51f2f853mr148905885e9.14.1778169140436; 
 Thu, 07 May 2026 08:52:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/67] hw/intc/arm_gicv5: Make gicv5_set_* update SPI state
Date: Thu,  7 May 2026 16:51:11 +0100
Message-ID: <20260507155154.1886557-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
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

The GIC CD* insns that update interrupt state also work for SPIs.
Instead of ignoring the GICV5_SPI type in gicv5_set_priority() and
friends, update the state in our SPI state array.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-25-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 64 ++++++++++++++++++++++++++++++
 include/hw/intc/arm_gicv5_common.h | 40 +++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index d1eb96fce0..9ca1826253 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -490,6 +490,19 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
         put_l2_iste(cs, cfg, &h);
         break;
     }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
+                          "priority of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->priority = priority;
+        break;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
                       "priority of bad interrupt type %d\n", type);
@@ -524,6 +537,19 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
         put_l2_iste(cs, cfg, &h);
         break;
     }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
+                          "enable state of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->enabled = true;
+        break;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
                       "enable state of bad interrupt type %d\n", type);
@@ -558,6 +584,19 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
         put_l2_iste(cs, cfg, &h);
         break;
     }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
+                          "pending state of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->pending = true;
+        break;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
                       "pending state of bad interrupt type %d\n", type);
@@ -593,6 +632,18 @@ void gicv5_set_handling(GICv5Common *cs, uint32_t id,
         put_l2_iste(cs, cfg, &h);
         break;
     }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
+                          "priority of unreachable SPI %d\n", id);
+        }
+
+        spi->hm = handling;
+        break;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
                       "handling mode of bad interrupt type %d\n", type);
@@ -642,6 +693,19 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
         put_l2_iste(cs, cfg, &h);
         break;
     }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
+                          "target of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->iaffid = iaffid;
+        break;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
                       "target of bad interrupt type %d\n", type);
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 983faa5ef1..6897f94117 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -200,4 +200,44 @@ static inline const char *gicv5_class_name(void)
     return "arm-gicv5";
 }
 
+/**
+ * gicv5_raw_spi_state
+ * @cs: GIC object
+ * @id: INTID of SPI to look up
+ *
+ * Return pointer to the GICv5SPIState for this SPI, or NULL if the
+ * interrupt ID is out of range. This does not do a check that the SPI
+ * is assigned to the right domain: generally you should call it via
+ * some other wrapper that performs an appropriate further check.
+ */
+static inline GICv5SPIState *gicv5_raw_spi_state(GICv5Common *cs, uint32_t id)
+{
+    if (id < cs->spi_base || id >= cs->spi_base + cs->spi_irs_range) {
+        return NULL;
+    }
+
+    return cs->spi + (id - cs->spi_base);
+}
+
+/**
+ * gicv5_spi_state:
+ * @cs: GIC object
+ * @id: INTID of SPI to look up
+ * @domain: domain to check
+ *
+ * Return pointer to the GICv5SPIState for this SPI, or NULL if the
+ * interrupt is unreachable (which can be because the INTID is out of
+ * range, or because the SPI is configured for a different domain).
+ */
+static inline GICv5SPIState *gicv5_spi_state(GICv5Common *cs, uint32_t id,
+                                             GICv5Domain domain)
+{
+    GICv5SPIState *spi = gicv5_raw_spi_state(cs, id);
+
+    if (!spi || spi->domain != domain) {
+        return NULL;
+    }
+    return spi;
+}
+
 #endif
-- 
2.43.0


