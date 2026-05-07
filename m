Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E34CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11a-0003w2-Jp; Thu, 07 May 2026 11:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11W-0003lt-RL
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11U-0003th-VP
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso9866955e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169143; x=1778773943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6PxEjiAL0LMewzxVDQQEeO72wrHqLuLKT9LMHvMzfhk=;
 b=iPEGhr/e3reCJ1kS0dwY5fqOW5Swrf6l2+24mb3ZoYVUWn8EMrY9bspAVqHc3t64qg
 NCOdQSzu98akgO8bN7ZYvkm6XNCYq4MFQ9nrHjs1ESr+ha/l3jb3Z8iP2CJLFDaYc5NJ
 GHGNmFkWYa6ffkO6SwnbZTAQDNcJtPFgPm4943TZJCbQ91gvk3zT91QADHDltoNaSbKz
 SSVFmCI0ZHeaUVnrE8etevkCAc0t9IL1aiKFQw8hNbc2+5zE5FcudVZ5khCY09F41FKI
 uazN5EYxEEoZJHdADv59sJ13u468nl3/+mQNiDb3n2Ka+gJGnITqKEq6K9xqo1/VgXxf
 AxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169143; x=1778773943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6PxEjiAL0LMewzxVDQQEeO72wrHqLuLKT9LMHvMzfhk=;
 b=XuVv0sZRR6+9daGnRHS8nd5xDmLXnlOuUOaztfpwZoDMPE65s4lS3UFV+1Pd+W0YKn
 QySsknxoh9vsbv+8bw51WlvckX+ZKY2RfMevW5g8mg/TZs8JswZPCTLVKoYtGUtd3TEd
 e2oK/sOwGJzjsJxM/9MefvZVHvncHaSsnYnfhDwTOkbV/+v3Mq4IKGl/6Cunn+IZgIPM
 Btf1YI8b1qN2li7YxLzjrMoScqL3IaABv6QiFHvTYl8xtcZAeBDE/D8jOwV7ppq99Y3l
 V7AMWq/SjZelacoLLZElZoOuXsuxfllL3VDYbP+GxPww6uYO9bMLP58ASX1PybE7WCK7
 oR5g==
X-Gm-Message-State: AOJu0YwbER7J6Nrnk5l9B/OmOf2dvqMH4ue+zV/urtXnS8jm5dHijV/G
 eQ0mACdd+nOzbKa8iAyMJ1CzT51HYhpLKWPp8b9Z75zhCzuMPTdP/sRpowMqXpA/vbMjdKq24n3
 Ava7O
X-Gm-Gg: AeBDiesvhrjzEv01V7nTm0kpZ2DGk7Qm/Jor+WW6gsCEGV+u3IueFXQo9YBWnNXyo3Y
 XkYdTsj0WlkZ8U5kZEm8tltlfRua31qSPMKu7jIDl0kpI+m7VzYBgcKx/Uyb3Yiz7hLmk2T9jKN
 HY551unIORXd9OuTAkaIduK9DZix9k4MF8kfQxqg9u+g4oZ4OqR+LgAdDCbGYSt9XWUwlvNKqwi
 388GkCBEa+TBsW/8g9t/TyF+5nTMH97HiCNm90bv3/+DKbSuuaqY6akBk2jw8dj8L+p2ipTvK4P
 0LcnOQwLQYx7+ozT/FpbxSYNzdrAeDdKcOyioG0WPGm8l7Fi7YzD+TuDPTSIwiQ+oNw2ESX0OK1
 hdKTaotxzKnzUZnUWFYmLnRwGH7DZGCZp3kxuWRBBP9pkh0f8FrmhOQbe7lfb0Ki1nwPJmU9NG2
 RO/BZR/z1RoAc5v5mGX0Up4cOPhL0DROYZMo9OmoeTuDio02gTSgFZIXkCHqurzzH+fEqX1lFDC
 n6VB075GByWS1C0G9uDYewvVT5XW4k=
X-Received: by 2002:a05:600c:8011:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-48e51f3bbabmr134562975e9.22.1778169143274; 
 Thu, 07 May 2026 08:52:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/67] hw/intc/arm_gicv5: Implement IRS_SPI_{SELR, STATUSR, CFGR,
 DOMAINR}
Date: Thu,  7 May 2026 16:51:14 +0100
Message-ID: <20260507155154.1886557-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Implement the IRS registers IRS_SPI_{SELR,STATUSR,CFGR,DOMAINR} which
form the config access for setting the trigger mode and domain of an
SPI.  The way these work is that the guest writes the ID of the
interrupt it wants to configure to IRS_SPI_SELR, and then it can read
and write the trigger mode of that SPI via IRS_SPI_CFGR and the
domain via IRS_SPI_DOMAINR.  IRS_SPI_STATUSR has a bit to indicate
whether the SPI is valid, and the usual IDLE bit to allow for
non-instantaneous updates (which QEMU doesn't do).

Since the only domain which can configure the domain of an SPI is EL3
and our initial implementation is NS-only, technically the DOMAINR
handling is unused code.  However it is straightforward, being almost
the same as the CFGR handling, and we'll need it later on.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-28-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 68 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  9 ++++
 include/hw/intc/arm_gicv5_common.h |  1 +
 3 files changed, 78 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 04d4391ae5..6ff3a79745 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -310,6 +310,22 @@ FIELD(ICSR, HM, 5, 1)
 FIELD(ICSR, PRIORITY, 11, 5)
 FIELD(ICSR, IAFFID, 32, 16)
 
+static GICv5SPIState *spi_for_selr(GICv5Common *cs, GICv5Domain domain)
+{
+    /*
+     * If the IRS_SPI_SELR value specifies an SPI that can be managed in
+     * this domain, return a pointer to its GICv5SPIState; otherwise
+     * return NULL.
+     */
+    uint32_t id = FIELD_EX32(cs->irs_spi_selr[domain], IRS_SPI_SELR, ID);
+    GICv5SPIState *spi = gicv5_raw_spi_state(cs, id);
+
+    if (spi && (domain == GICV5_ID_EL3 || domain == spi->domain)) {
+        return spi;
+    }
+    return NULL;
+}
+
 static MemTxAttrs irs_txattrs(GICv5Common *cs, GICv5Domain domain)
 {
     /*
@@ -1010,6 +1026,38 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_IST_CFGR:
         *data = cs->irs_ist_cfgr[domain];
         return true;
+
+    case A_IRS_SPI_STATUSR:
+        /*
+         * QEMU writes to IRS_SPI_{CFGR,DOMAINR,SELR,VMR} take effect
+         * instantaneously, so the guest can never see the IDLE bit as 0.
+         */
+        v = FIELD_DP32(v, IRS_SPI_STATUSR, V,
+                       spi_for_selr(cs, domain) != NULL);
+        v = FIELD_DP32(v, IRS_SPI_STATUSR, IDLE, 1);
+        *data = v;
+        return true;
+
+    case A_IRS_SPI_CFGR:
+    {
+        GICv5SPIState *spi = spi_for_selr(cs, domain);
+
+        if (spi) {
+            v = FIELD_DP32(v, IRS_SPI_CFGR, TM, spi->tm);
+        }
+        *data = v;
+        return true;
+    }
+    case A_IRS_SPI_DOMAINR:
+        if (domain == GICV5_ID_EL3) {
+            /* This is RAZ/WI except for the EL3 domain */
+            GICv5SPIState *spi = spi_for_selr(cs, domain);
+            if (spi) {
+                v = FIELD_DP32(v, IRS_SPI_DOMAINR, DOMAIN, spi->domain);
+            }
+        }
+        *data = v;
+        return true;
     }
 
     return false;
@@ -1041,6 +1089,26 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_MAP_L2_ISTR:
         irs_map_l2_istr_write(s, domain, data);
         return true;
+    case A_IRS_SPI_SELR:
+        cs->irs_spi_selr[domain] = data;
+        return true;
+    case A_IRS_SPI_CFGR:
+    {
+        GICv5SPIState *spi = spi_for_selr(cs, domain);
+        if (spi) {
+            spi->tm = FIELD_EX32(data, IRS_SPI_CFGR, TM);
+        }
+        return true;
+    }
+    case A_IRS_SPI_DOMAINR:
+        if (domain == GICV5_ID_EL3) {
+            /* this is RAZ/WI except for the EL3 domain */
+            GICv5SPIState *spi = spi_for_selr(cs, domain);
+            if (spi) {
+                spi->domain = FIELD_EX32(data, IRS_SPI_DOMAINR, DOMAIN);
+            }
+        }
+        return true;
     }
 
     return false;
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index aa5877ee05..607b99c2ac 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -92,6 +92,15 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
             cs->spi[i].domain = mp_domain;
         }
     }
+
+    for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
+        /*
+         * We reset irs_spi_selr to an invalid value so that our reset
+         * value for IRS_SPI_STATUSR.V is correctly 0. The guest can
+         * never read IRS_SPI_SELR directly.
+         */
+        cs->irs_spi_selr[i] = cs->spi_base + cs->spi_irs_range;
+    }
 }
 
 static void gicv5_common_init(Object *obj)
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 6897f94117..c5a64bf86d 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -85,6 +85,7 @@ struct GICv5Common {
 
     uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
     uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];
+    uint32_t irs_spi_selr[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.  Array
-- 
2.43.0


