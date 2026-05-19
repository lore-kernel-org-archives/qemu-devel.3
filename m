Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B83CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOZ0-0004oc-Hl; Tue, 19 May 2026 13:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <williamdapinho@gmail.com>)
 id 1wPOYq-0004gg-Lu
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:48:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <williamdapinho@gmail.com>)
 id 1wPOYn-0008NX-Cl
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:48:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso39510735e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779212931; x=1779817731; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8tv8sNGOP2+gDDuYmPlVIIy5gfvrfarZbTKlONa7k1M=;
 b=H9RfVX5dwOMK6qfM/Cz+GJ7QXybnr8K3CmaUtKuPDH7HJ1n2leFBwo8WyQ6SgiD9Eb
 oazd6uhuUS4w7dqS07EkKTMLlvKg3maV1z3a4nTShlGXi1aXFpmd+clFDybQRdBfwlxM
 1V1m79Z5Z9EFbXfCiIoCe9q+uAfDA/kvcBKJ+oxYJCNGTPgyJ7G5r+nzDldtMC0WDnGJ
 61CiQRTfTTgnJ2CR9ub4CtUC1UmKVFVzvGNkPg74IPKILtaIsDdbV2Oy2Rg8nbFfTLyY
 F2jT25+NCfu+xsk5Rb2Ps2aI14y2e8IpHRd/B4A0SiqVrkz1CdrMuYlgftfFITQnEcI5
 d/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779212931; x=1779817731;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8tv8sNGOP2+gDDuYmPlVIIy5gfvrfarZbTKlONa7k1M=;
 b=p2oNUvi4Pn/7196SHQMn9gVNd2CJ7opJTa1tDJGon7epjojorhIQEmugXXLQy2iElk
 hkf8e4srZ9xiybjyd3xvM/mMvK2/U/GqJ+RN8vyoZyFBkP4CCeS1Gt45spAVvtcvYoQn
 cIgniCKINuvXkOduwj5MwgQreOLeHjmkOrPj1J2X6e2nrHM3UtXMPcZJyBOdnEgvjdSV
 37GR6j68qPXtIPLOn7dLDHy4k0B3AOV1RK5ChJgGY+AaY1slwnIQn0R7+OnAtGTbv9sD
 MBIuCFwx9PAFn0IPcciDk+0ka/hqho4MFKedG2b5oCvzlNBY6NSq3PqQRVrx1wYDc2hV
 bjVQ==
X-Gm-Message-State: AOJu0Yyrk7wM9FtVYEEGLPrFtRO9KLsZc4BZXsWCWefkDsNrh1l+ImkP
 8xjC+zcLrTQXpKMF0AEIZmrWJRPaF4NUw1ti4yf5BH3oQa3gU4nc5FAb
X-Gm-Gg: Acq92OExYCLKDoHoaw8+7rIlE55+NAMU5y7YXVd6wBn4MyrlLAptRaBNy2ZG507H+iZ
 C2U3HVQDY/4/JOUs662JYOUDku06xKb8pADuiV/9XBxns5IgOL45OO55phS84SC5yrmvpI618Kq
 38vr+bMhbtNbmHdAtXqzAoSjqY78UvbTNSxjjroKKu51Z2jh9CSurfFOGwuNViCO1DgeSJdUa+N
 KymFVR2a5/Pdkw3EKNO4keU9/IdQomb+/jwk1Zsc0+Rsicq/uSwaenN4IwRqveN3Hpa+dXm4DAt
 Jxbagf5yiN4+ZzvBD3O4La32qWItiCUTA+YuoruKYtCPiohIzDyPd4Yw3aUOGF5mQTaIsgQnFZr
 XaTQE8ejK4qoAiIsuxaNElO+IixTxl2vh1xrJWHm3RE4UMqsLHFyNajBWyd0yH2myvfbh5EpPc0
 4SoatXv/LVky4HGvv+xvGlb/ComVKOC1WX
X-Received: by 2002:a05:600c:8485:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48fe537fb70mr34065765e9.9.1779212930592; 
 Tue, 19 May 2026 10:48:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe6afe7sm107422405e9.24.2026.05.19.10.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 10:48:50 -0700 (PDT)
From: William de Abreu Pinho <williamdapinho@gmail.com>
Date: Tue, 19 May 2026 10:48:40 -0700
Subject: [PATCH v3 3/3] hw/arm/aspeed: anacapa: add FRU EEPROM data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-add-anacapa-machine-v3-3-56c23993a20a@gmail.com>
References: <20260519-add-anacapa-machine-v3-0-56c23993a20a@gmail.com>
In-Reply-To: <20260519-add-anacapa-machine-v3-0-56c23993a20a@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 William de Abreu Pinho <williamdapinho@gmail.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=williamdapinho@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use frugen to generate FRU data for the following components: HPM MB,
R-PDB, L-PDB, SCM, BSM, R Bridge Board, L Bridge Board, and HPM board
ID.

Signed-off-by: William de Abreu Pinho <williamdapinho@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_anacapa.c | 225 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 217 insertions(+), 8 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index c24f00d44c..a1c8111a93 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -20,6 +20,207 @@
 #define ANACAPA_BMC_HW_STRAP2 0x00000000
 #define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
 
+/*
+ * "Anacapa HPM (MB)" FRU data. Generated with frugen.
+ *
+ *    {
+ *      "board": { "mfg": "Inventec", "pname": "Anacapa QEMU MB EVT2",
+ *                 "pn": "00000000000", "serial": "00000000000000" },
+ *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
+ *                   "pn": "10000000001", "ver": "MP",
+ *                   "serial": "10000000000000", "atag": "QEMU" }
+ *    }
+ */
+static const uint8_t hpm_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0xb4,
+    0xa4, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd4,
+    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x51, 0x45, 0x4d, 0x55,
+    0x20, 0x4d, 0x42, 0x20, 0x45, 0x56, 0x54, 0x32, 0x47, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0xc0,
+    0xc1, 0x00, 0x00, 0xb8, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
+    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
+    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
+    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
+    0xd6, 0xc0, 0xc1, 0x0e
+};
+static const size_t hpm_eeprom_len = sizeof(hpm_eeprom);
+
+/*
+ * "Anacapa R-PDB" FRU data. Generated with frugen.
+ *
+ *    {
+ *      "board": { "mfg": "Inventec", "pname": "Anacapa QEMU RPDB",
+ *                 "pn": "00000000000", "serial": "00000000000000" },
+ *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
+ *                   "pn": "10000000001", "ver": "MP",
+ *                   "serial": "10000000000000", "atag": "QEMU" }
+ *    }
+ */
+static const uint8_t rpdb_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0x41,
+    0x2d, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd1,
+    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x51, 0x45, 0x4d, 0x55,
+    0x20, 0x52, 0x50, 0x44, 0x42, 0x47, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0xc0, 0xc1, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x4d, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
+    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
+    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
+    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
+    0xd6, 0xc0, 0xc1, 0x0e
+};
+static const size_t rpdb_eeprom_len = sizeof(rpdb_eeprom);
+
+/*
+ * "Anacapa L-PDB" FRU data. Generated with frugen.
+ *
+ *    {
+ *      "board": { "mfg": "Inventec", "pname": "Anacapa QEMU LPDB",
+ *                 "pn": "00000000000", "serial": "00000000000000" },
+ *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
+ *                   "pn": "10000000001", "ver": "MP",
+ *                   "serial": "10000000000000", "atag": "QEMU" }
+ *    }
+ */
+static const uint8_t lpdb_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0x41,
+    0x2d, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd1,
+    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x51, 0x45, 0x4d, 0x55,
+    0x20, 0x4c, 0x50, 0x44, 0x42, 0x47, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0xc0, 0xc1, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x53, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
+    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
+    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
+    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
+    0xd6, 0xc0, 0xc1, 0x0e
+};
+static const size_t lpdb_eeprom_len = sizeof(lpdb_eeprom);
+
+/*
+ * "Anacapa SCM" FRU data. Generated with frugen.
+ *
+ *    {
+ *      "board": { "mfg": "Quanta", "pname": "Anacapa SCM",
+ *                 "pn": "00000000000", "serial": "00000000000000" },
+ *      "product": { "mfg": "Quanta", "pname": "CI-Anacapa",
+ *                   "pn": "10000000001", "ver": "MP",
+ *                   "serial": "10000000000000", "atag": "QEMU" }
+ *    }
+ */
+static const uint8_t scm_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x07, 0x00, 0x00, 0xf7, 0x01, 0x06, 0x19, 0x41,
+    0x2d, 0xf2, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xcb, 0x41, 0x6e,
+    0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x53, 0x43, 0x4d, 0x47, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a,
+    0xc0, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc5, 0x01, 0x06, 0x19, 0xc6,
+    0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e,
+    0x61, 0x63, 0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a,
+    0x82, 0x2d, 0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83,
+    0x71, 0xd9, 0xd6, 0xc0, 0xc1, 0x00, 0x00, 0xe2
+};
+static const size_t scm_eeprom_len = sizeof(scm_eeprom);
+
+/*
+ * "Anacapa BMC Storage Module" FRU data. Generated with frugen.
+ *
+ *    {
+ *      "board": { "mfg": "Quanta", "pname": "Anacapa BMC Storage Module",
+ *                 "pn": "00000000000", "serial": "00000000000000" },
+ *      "product": { "mfg": "Quanta", "pname": "CI-Anacapa",
+ *                   "pn": "10000000001", "ver": "MP",
+ *                   "serial": "10000000000000", "atag": "QEMU" }
+ *    }
+ */
+static const uint8_t bsm_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x00, 0x00,
+    0x00, 0x00, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xda, 0x41, 0x6e,
+    0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x42, 0x4d, 0x43, 0x20, 0x53, 0x74,
+    0x6f, 0x72, 0x61, 0x67, 0x65, 0x20, 0x4d, 0x6f, 0x64, 0x75, 0x6c, 0x65,
+    0xce, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+    0x30, 0x30, 0x30, 0xcb, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+    0x30, 0x30, 0x30, 0xc0, 0xc1, 0x00, 0x00, 0x10, 0x01, 0x08, 0x00, 0xc6,
+    0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e,
+    0x61, 0x63, 0x61, 0x70, 0x61, 0xcb, 0x31, 0x30, 0x30, 0x30, 0x30, 0x30,
+    0x30, 0x30, 0x30, 0x30, 0x31, 0xc2, 0x4d, 0x50, 0xce, 0x31, 0x30, 0x30,
+    0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0xc4,
+    0x51, 0x45, 0x4d, 0x55, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x77,
+};
+static const size_t bsm_eeprom_len = sizeof(bsm_eeprom);
+
+/*
+ * "Anacapa R Bridge Board" FRU data. Generated with frugen.
+ *
+ *    {
+ *      "board": { "mfg": "Inventec", "pname": "Anacapa QEMU RBB EVT2",
+ *                 "pn": "00000000000", "serial": "00000000000000" },
+ *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
+ *                   "pn": "10000000001", "ver": "MP",
+ *                   "serial": "10000000000000", "atag": "QEMU" }
+ *    }
+ */
+static const uint8_t rbb_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0xb4,
+    0xa4, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd5,
+    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x51, 0x45, 0x4d, 0x55,
+    0x20, 0x52, 0x42, 0x42, 0x20, 0x45, 0x56, 0x54, 0x32, 0x47, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a,
+    0xc0, 0xc1, 0x00, 0x70, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
+    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
+    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
+    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
+    0xd6, 0xc0, 0xc1, 0x0e
+};
+static const size_t rbb_eeprom_len = sizeof(rbb_eeprom);
+
+/*
+ * "Anacapa L Bridge Board" FRU data. Generated with frugen.
+ *
+ *    {
+ *      "board": { "mfg": "Inventec", "pname": "Anacapa QEMU LBB EVT2",
+ *                 "pn": "00000000000", "serial": "00000000000000" },
+ *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
+ *                   "pn": "10000000001", "ver": "MP",
+ *                   "serial": "10000000000000", "atag": "QEMU" }
+ *    }
+ */
+static const uint8_t lbb_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0xb4,
+    0xa4, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd5,
+    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x51, 0x45, 0x4d, 0x55,
+    0x20, 0x4c, 0x42, 0x42, 0x20, 0x45, 0x56, 0x54, 0x32, 0x47, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a,
+    0xc0, 0xc1, 0x00, 0x76, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
+    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
+    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
+    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
+    0xd6, 0xc0, 0xc1, 0x0e
+};
+static const size_t lbb_eeprom_len = sizeof(lbb_eeprom);
+
+/*
+ * "Anacapa HPM BRD ID" FRU data. Generated with frugen.
+ *
+ *    {
+ *      "board": { "mfg": "Inventec", "pname": "Anacapa HPM BRD ID",
+ *                 "pn": "00000000000", "serial": "00000000000000" },
+ *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
+ *                   "pn": "10000000001", "ver": "MP",
+ *                   "serial": "10000000000000", "atag": "QEMU" }
+ *    }
+ */
+static const uint8_t hpm_brd_id_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0x41,
+    0x2d, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd2,
+    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x48, 0x50, 0x4d, 0x20,
+    0x42, 0x52, 0x44, 0x20, 0x49, 0x44, 0x47, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0xc0, 0xc1, 0x00,
+    0x00, 0x00, 0x00, 0x42, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
+    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
+    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
+    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
+    0xd6, 0xc0, 0xc1, 0x0e
+};
+static const size_t hpm_brd_id_eeprom_len = sizeof(hpm_brd_id_eeprom);
+
 static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference: aspeed-bmc-facebook-anacapa.dts */
@@ -50,7 +251,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c6 */
     /* eeprom@50 */
-    at24c_eeprom_init(i2c[6], 0x50, 32 * KiB);
+    at24c_eeprom_init_rom(i2c[6], 0x50, 32 * KiB,
+                          hpm_eeprom, hpm_eeprom_len);
 
     /* &i2c8 */
     /* i2c-mux@72 (PCA9546) */
@@ -65,7 +267,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x24);
     /* eeprom@50 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB,
+                          rpdb_eeprom, rpdb_eeprom_len);
 
     /* i2c8mux ch1 */
     /* pca9555@22 */
@@ -75,13 +278,16 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9552, 0x24);
     /* eeprom@50 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB,
+                          lpdb_eeprom, lpdb_eeprom_len);
 
     /* &i2c9 */
     /* eeprom@50 */
-    at24c_eeprom_init(i2c[9], 0x50, 16 * KiB);
+    at24c_eeprom_init_rom(i2c[9], 0x50, 16 * KiB,
+                          scm_eeprom, scm_eeprom_len);
     /* eeprom@56 */
-    at24c_eeprom_init(i2c[9], 0x56, 8 * KiB);
+    at24c_eeprom_init_rom(i2c[9], 0x56, 8 * KiB,
+                          bsm_eeprom, bsm_eeprom_len);
 
     /* &i2c10 */
     /* i2c-mux@71 (PCA9548) */
@@ -92,7 +298,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
                             TYPE_PCA9552, 0x22);
     /* eeprom@52 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
+                          rbb_eeprom, rbb_eeprom_len);
 
     /* &i2c11 */
     /* i2c-mux@71 (PCA9548) */
@@ -105,7 +312,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
                             TYPE_PCA9552, 0x22);
     /* eeprom@52 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
+                          lbb_eeprom, lbb_eeprom_len);
 
     /* &i2c13 */
     /* i2c-mux@70 (PCA9548) */
@@ -116,7 +324,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* i2c13mux ch4 */
     /* eeprom@51 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 4), 0x51, 32 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 4), 0x51, 32 * KiB,
+                          hpm_brd_id_eeprom, hpm_brd_id_eeprom_len);
 
     /* i2c13mux ch7 */
     /* nfc@28 — no model */

-- 
2.53.0-Meta


