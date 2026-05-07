Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AF2CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11t-00056w-0C; Thu, 07 May 2026 11:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11q-0004uJ-CR
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:46 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11o-0003zl-IW
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:46 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44c4cc7c1cfso870127f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169163; x=1778773963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GC/uWd3jRSbyTP7ymiXKyAkRj9xECMCtg5dzSRpnoFs=;
 b=TL4a2Xdkan8oooW71cKNWqERZN9NQXoVSaoeUETVuyGdOKj60ZUWPnWeE8ceIflj6t
 Hp9E1G0gXkigFpOE59qYdthoT6bviAOpLKFCorcgm+D7dUHtlzh4zO1kxMpYu7TdirBw
 gijw9yEqmsmow1Wgy8XgLAalQPh7mLayD1jHnw0XGWzm9UayjQiUCsSvD1ATG/e84J+S
 wAIsfbMuYTMaC3/NCQyWsqf32JZ9hCojEF3FxauPHOX+upqpKYBZVC4EfRQdvhuwggKL
 aRozRYxOasPwkivY3ssFVWB3KaVxM6cDPB0zsyS64orWqEIyATADdqSmzovKh2p37KXb
 FL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169163; x=1778773963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GC/uWd3jRSbyTP7ymiXKyAkRj9xECMCtg5dzSRpnoFs=;
 b=QNVgAQDnDm3jiRkbkgSL0PLE5xHTr3TxDbrsdPg7xWOhCjY9MrCnDodnvtCRMS3FJ8
 vWr4FbeGKnFRbCb854zs/MWTH9pv+8mSNfneGp2PMzJcXnFsSV3wIfzz/j3mtTRjbOxU
 DfOf+nnCMz2T5msQeOI7jpSIEnSncWVNogJKZTs4xhrbUXhJYQz6qKcBgHFaC22iJ/hO
 7xy7Q237e0mzEblEDtJ8AnLehbW/uqbFLb/+lk1crAfpDCV+1oOzlWv2Vk9+vggfjfSD
 u7ETx6Zeu4tdUpT9H0RVqRDYgKS1MS7MlUPaS4xgv3vBP/esTnhII3af/91oOaG1qBdd
 dlVg==
X-Gm-Message-State: AOJu0Yw4YD6booPPSHHisPYvsBqeSXk0afQD1FMYUx0Q0l+QpuuCIQjJ
 fgCtzCSNj2ygSZuVM6KOEyk6TlozyUXXf+RjJROagkBwwup1XXKpZT6Y10lXNtwdtj9Q/Iz3/gR
 PtXBG
X-Gm-Gg: AeBDietXhIZeogXUasfIeZz8Hlywckiu3pJdnIowpEwPQ+1FtY58fAQ7ylHqqSxIkK1
 7P3Bm+sipOGLIaQG4PjE+YleDbFPKeXfscRKHNFLW5yXZEZfN5CF4gm8VBMAdGyh0pE5tDniQIM
 iOosewDWrq+ciLyVFhduV+26HQrpb9fH6jxfNwNUQcpA0mZO2WGFYAfljxRpUHHffiyp7lH481Y
 74uOLnZNqc/HE8ZuWD0SPH4BieWK1qabxet/Q5HIlT9JgfAgFpa25uPTII4CSGbFe/m9CLpXSP7
 g5ORM0KSL4QWQT8i53O/qlXHMJMdojfbz8D2LGb9zYf0Lwwq9HaTYvdMvcBkFI1Ed2p8wuYPK5c
 wG8tftG6ywwG+tKVmGCxDDBj5DlTHgEXFFLtNoSbfTUb3yOW1jIcu1Pj9Cz2/8+pybcukbw7+rr
 uuIGz/68JPfOOgQJ84xG2FFjlUs3QKTdOYPP0xbv6SQIehWcUkleEQmnLLBd/EEZ7cqPG4aZebT
 WRa650In9XMLKnKIaYJTv782RaOTZY=
X-Received: by 2002:a05:600c:3055:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-48e51e0bc2fmr84299555e9.5.1778169162767; 
 Thu, 07 May 2026 08:52:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/67] hw/intc/arm_gicv5: Implement Activate command
Date: Thu,  7 May 2026 16:51:34 +0100
Message-ID: <20260507155154.1886557-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Implement the equivalent of the GICv5 stream protocol's Activate
command, which lets the cpuif tell the IRS to move its current
highest priority pending interrupt into the Active state, and to
clear the Pending state for an Edge handling mode interrupt.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-48-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 58 ++++++++++++++++++++++++++++++
 hw/intc/trace-events               |  1 +
 include/hw/intc/arm_gicv5_stream.h | 23 ++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 605cf6fd6f..942f3eba2e 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1095,6 +1095,64 @@ uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
     }
 }
 
+void gicv5_activate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
+                    GICv5IntType type, bool virtual)
+{
+    GICv5 *s = ARM_GICV5(cs);
+    uint32_t iaffid;
+
+    trace_gicv5_activate(domain_name[domain], inttype_name(type), virtual, id);
+
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_activate: tried to "
+                      "activate a virtual interrupt\n");
+        return;
+    }
+
+    switch (type) {
+    case GICV5_LPI:
+    {
+        const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
+        L2_ISTE_Handle h;
+        uint32_t *l2_iste_p = get_l2_iste(cs, cfg, id, &h);
+
+        if (!l2_iste_p) {
+            return;
+        }
+        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ACTIVE, true);
+        if (FIELD_EX32(*l2_iste_p, L2_ISTE, HM) == GICV5_EDGE) {
+            *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PENDING, false);
+        }
+        iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
+        put_l2_iste(cs, cfg, &h);
+        break;
+    }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_activate: tried to "
+                          "activate unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->active = true;
+        if (spi->hm == GICV5_EDGE) {
+            spi->pending = false;
+        }
+        iaffid = spi->iaffid;
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_activate: tried to "
+                      "activate bad interrupt type %d\n", type);
+        return;
+    }
+
+    irs_recalc_hppi(s, domain, iaffid);
+}
+
 static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 6475ba5959..636c598970 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -241,6 +241,7 @@ gicv5_set_pending(const char *domain, const char *type, bool virtual, uint32_t i
 gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t id, int handling) "GICv5 IRS SetHandling %s %s virtual:%d ID %u handling %d"
 gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
 gicv5_request_config(const char *domain, const char *type, bool virtual, uint32_t id, uint64_t icsr) "GICv5 IRS RequestConfig %s %s virtual:%d ID %u ICSR 0x%" PRIx64
+gicv5_activate(const char *domain, const char *type, bool virtual, uint32_t id) "GICv5 IRS Activate %s %s virtual:%d ID %u"
 gicv5_spi_state(uint32_t spi_id, bool level, bool pending, bool active) "GICv5 IRS SPI ID %u now level %d pending %d active %d"
 gicv5_irs_recalc_hppi_fail(const char *domain, uint32_t iaffid, const char *reason) "GICv5 IRS %s IAFFID %u: no HPPI: %s"
 gicv5_irs_recalc_hppi(const char *domain, uint32_t iaffid, uint32_t id, uint8_t prio) "GICv5 IRS %s IAFFID %u: new HPPI ID 0x%x prio %u"
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index cc1c7cc438..7ac24f0f09 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -151,6 +151,29 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
 uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
                               GICv5IntType type, bool virtual);
 
+/**
+ * gicv5_activate
+ * @cs: GIC IRS to send command to
+ * @id: interrupt ID
+ * @domain: interrupt domain to act on
+ * @type: interrupt type (LPI or SPI)
+ * @virtual: true if this is a virtual interrupt
+ *
+ * Activate the IRS's highest priority pending interrupt; matches the
+ * stream interface's Activate command.
+ *
+ * In the stream interface, the command has only the domain and
+ * virtual fields, because both the IRS and the CPUIF keep track of
+ * the IRS's current HPPI. In QEMU, we also have arguments here for
+ * @id and @type which are telling the IRS something that in hardware
+ * it already knows. This is because we have them to hand in the cpuif
+ * code, and it means we don't need to pass in an iaffid argument to
+ * tell the IRS which CPU we are so it can find the right element in
+ * its hppi[][] array.
+ */
+void gicv5_activate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
+                    GICv5IntType type, bool virtual);
+
 /**
  * gicv5_forward_interrupt
  * @cpu: CPU interface to forward interrupt to
-- 
2.43.0


