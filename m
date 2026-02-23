Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB87EC1114
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKc-0002JL-SU; Mon, 23 Feb 2026 12:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKa-0002Eu-Mv
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:48 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKY-0000DH-4W
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:47 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso36859255e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866165; x=1772470965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5UcrJtBZzxsU4kxR85chi5yChlMOw/kzpqfr9OMvMYc=;
 b=IWn4zxidW0Zi9zkCxbCXMnQv6mJKkMhv/XiZ12Jc303OlpvH+vGysuVudRJ9nAy+ex
 S2FduW6m/lkLT3+C881MbfLRzXcN8QfX50NJy1UyvK4qj8XhullnC1BrhBw2ThiW5aLd
 QUJO0ik5v3GUEdZJz+7LAP+Vn5+cn9qQApkWswnTkME3lEyxaOLWhm/lDhON7IvfLPZj
 39rK1J5egUFWaTuFEBDuOHIOKzgx763840zz4aVu8imUFLWbHcM9Z4Oy8/OehYqP9A6/
 0UpnwDGsOpglFAJZKCyKdQZ1Tw9XwCKu7jmeSTDS0fszoaUsy0C4X9b68X6b2dZBhTuh
 zb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866165; x=1772470965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5UcrJtBZzxsU4kxR85chi5yChlMOw/kzpqfr9OMvMYc=;
 b=norg+MYp2jH3y2OV1bt7D4CsGnNIoKU5Btv36hrm3rwlHood3dnULf36vBbYwRCd3S
 PgwJHhH/lCDnAvnEV4e/LdBBxMtZACeKfO+pwEC8bzPrYMMqNtklWtTQpx+00jGRZKJA
 urHb2hNMkAg7kLhw4yO9Qo9HY/r1C1tFvK7Vn2D+Yicqepx6OaMl8LAhA6q4b/WHVRUX
 Ihhc/0WxzCgj0nTXZHc0yKd4VmXw5SLtDqH5/x+EomsPPit9ZNE1hM0Rj02xZjmUj8tD
 6BA06ll/KKkdqREhiGLGYmlOdEZIN5kekDk0k2s9NeqWw/mnpYSnqhT5dqqtNfa80tpn
 7dsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzhI84QijVuof7Gy39IHKSZmRA0tZQqx+CaH9dCZ7o3Y8lRQPxLN1oSSL/wcR8Rk6R5zidjv1gz5vN@nongnu.org
X-Gm-Message-State: AOJu0YxjXAqdF9wzxvYCGMmjfHVW/nKvMiacMcYU/LRZOh45WetiQt33
 qcEedqCrwg5px/hmLn3ze2dx2OiLr1FhsLNcNlSUGppPv+D+fLVQTI4xZQLRecNGVfkDhQWOwG+
 A5uf5
X-Gm-Gg: AZuq6aJw1ZA0hGortp5lB23ikvn/LeMxI4dpZ0lqFzfc0TZ+d0vvy3VmRWEUCXmcSjk
 L8WRno8q55w3LqjxWg00/EAMAgndezIlumuR26HVWrchkttLDNDKETEzwvhbGJSq+hNxyNpzWyF
 ElYPVIyxgizViRdtLWyS9vEalvzHcpIZQdCLMRouxQ87JOM01eGUUrO3XXxhZbFQKiBtzM4VLWK
 0rbRl4b69qWnWjLA8VAf9ko9Yq2zX13+/hYrxIB1+s+hDWYY7r5UTndyJTKMJR8LWweBgZg/+ZR
 GXO0R4fQ0MYzDR4VTxBNSX7x/0SrSQ3GA8eq2lKuOd2VA5mu/IqDFdy9Nwf5cKpTI8nDaWQNefY
 7XG1D8kqgxSMetromcYnF/gndTZuVTA6tn01IMDjgkkArJOyoXmUlEzjOaoqT63qS4C06yGC4nP
 kkuLRAJSKhW211rc0WsIrY4MZ9rtdUGELwc3UnpPRgosqlZcPkC/6mEZUNulZg5jz3aizUangQf
 jb2zre9KETwwgcv2ao2fhiNmJ7tw70=
X-Received: by 2002:a05:600c:6206:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-483a95b71b5mr170727465e9.13.1771866164379; 
 Mon, 23 Feb 2026 09:02:44 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 26/65] hw/intc/arm_gicv5: Implement IRS_SPI_{SELR, STATUSR,
 CFGR, DOMAINR}
Date: Mon, 23 Feb 2026 17:01:33 +0000
Message-ID: <20260223170212.441276-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
---
 hw/intc/arm_gicv5.c                | 68 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  9 ++++
 include/hw/intc/arm_gicv5_common.h |  1 +
 3 files changed, 78 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 51b25775c4..9f4d44f975 100644
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
@@ -970,6 +986,38 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
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
 }
@@ -1000,6 +1048,26 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
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
 }
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 8cca3a9764..e0d954f3c6 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -94,6 +94,15 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
             cs->spi[i].domain = mp_domain;
         }
     }
+
+    for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
+        /*
+         * We reset irs_spi_selr to an invalid value so that our reset
+         * value for IRS_SPI_STATUSR.V is correctly 0. The guest
+         * can never read IRS_SPI_SELR directly.
+         */
+        cs->irs_spi_selr[i] = cs->spi_base + cs->spi_irs_range;
+    }
 }
 
 static void gicv5_common_init(Object *obj)
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 1a1d360c68..5490fdaf8b 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -84,6 +84,7 @@ struct GICv5Common {
 
     uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
     uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];
+    uint32_t irs_spi_selr[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.
-- 
2.43.0


