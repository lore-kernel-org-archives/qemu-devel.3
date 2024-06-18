Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C094C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 13:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJZJe-00087I-Lo; Tue, 18 Jun 2024 09:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJZJd-00085b-4c; Tue, 18 Jun 2024 09:56:05 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJZJa-00022k-MR; Tue, 18 Jun 2024 09:56:04 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso642046466b.0; 
 Tue, 18 Jun 2024 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718718960; x=1719323760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u1cyBezRJri5KnZVsR+MFjuxJYCacR58JRUFpBBdC3g=;
 b=jNVFQnzrXOUt46rr/64ueaAxGBsKV81SwjuCZB7svoE+Tb1CyFWW3Ds6rp6eVLwuou
 v57DNbLUkOL/NL7l2eAS61xU97FHH54FKvkSidINA6HE56hqUVgDu3A4cdwyzftyEJf2
 T15+3lBUutL6jE2bM6bYewkFJNX6B/QIVT9RMrrl4+74qcYu3MdBTQMB8t/20tT6JYdU
 QAT9AGTil6yBqDLBm39IaLzSVySc/1FboRXW89giczqJjG38LCznHei+/LYZ+uR+iP1G
 8qdRyPt+NaTcT/NAoPoXvVBv2eyJZhvO5m/MRj9Ue+XmkyJZ3kDUA4lh33CqmYsYqdiJ
 bedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718718960; x=1719323760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u1cyBezRJri5KnZVsR+MFjuxJYCacR58JRUFpBBdC3g=;
 b=UWinD22m+nYOYQ58ScJwzztpv4v+a9XFHFtN5mqzdcfJSmvzFsVp08mD8mRF2yBDqW
 42VCgaUXV6bv0pfoislL+0trsVKn4Va+GjNrXEaox/oweB1CNsx3bfFPDMjHdWWnszFc
 N2Ebka4+MwIoFIACW4M3GYs2AR1OJL1ZMfOrUlncXmthvQm41otyTOu1bob1SNNHShk4
 BqbCEcZCWCRhdeFMJtf9x0LiTv6n0SnOlKIMTmIUOP3rgw3FlzeyMgjNLxvNB9uUqT4I
 hB8zVfin3g9PfhTFb5W4ntzdDlMLkgx9XDcciiggOqECUpqbkQjPyh7st+kgiC0w0HEJ
 +9WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB7umEBP9NGCamER/b+Fxp9RibgfTIQfZ8n0Pm0atLawRcIjDT3C7i/uJtXYAqYa8tsT6oEmgewh4uiO/DP/dkoI1+j1oZXoWRmmJdHfT+fM5NAJdIHmibELU=
X-Gm-Message-State: AOJu0YzWqQr46DFrPv/QBGhGB4u8Q/4e7d3crDzfTROhZYM+71Lhw0kL
 SUk6+57+iPoJA7IowNQTMhbD+Te1SSmSiwj1M0AkrHEZGp92IXI=
X-Google-Smtp-Source: AGHT+IECf99R/+pOY6WJuMaK3pMgr4IYX8PJie/hHXLP5R3+uWQSlXUPMCbUsQgU/8bAz5Pix8X1Fw==
X-Received: by 2002:a17:907:874e:b0:a6f:8e42:b794 with SMTP id
 a640c23a62f3a-a6f8e42ca00mr273324166b.26.1718718960238; 
 Tue, 18 Jun 2024 06:56:00 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f9c858sm617015966b.206.2024.06.18.06.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 06:56:00 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/misc/stm32l4x5_rcc: Add validation for MCOPRE and MCOSEL
 values
Date: Tue, 18 Jun 2024 15:55:50 +0200
Message-Id: <20240618135550.3108739-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit adds validation checks for the MCOPRE and MCOSEL values in
the rcc_update_cfgr_register function. If the MCOPRE value exceeds
0b100 or the MCOSEL value exceeds 0b111, an error is logged and the
corresponding clock mux is disabled. This helps in identifying and
handling invalid configurations in the RCC registers.

Reproducer:
cat << EOF | qemu-system-aarch64 -display \
none -machine accel=qtest, -m 512M -machine b-l475e-iot01a -qtest \
stdio
writeq 0x40021008 0xffffffff
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/misc/stm32l4x5_rcc.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 417bd5e85f..59d428fa66 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -543,19 +543,31 @@ static void rcc_update_cfgr_register(Stm32l4x5RccState *s)
     uint32_t val;
     /* MCOPRE */
     val = FIELD_EX32(s->cfgr, CFGR, MCOPRE);
-    assert(val <= 0b100);
-    clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
-                         1, 1 << val);
+    if (val > 0b100) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid MCOPRE value: 0x%"PRIx32"\n",
+                      __func__, val);
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], false);
+    } else {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
+                             1, 1 << val);
+    }
 
     /* MCOSEL */
     val = FIELD_EX32(s->cfgr, CFGR, MCOSEL);
-    assert(val <= 0b111);
-    if (val == 0) {
+    if (val > 0b111) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid MCOSEL value: 0x%"PRIx32"\n",
+                      __func__, val);
         clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], false);
     } else {
-        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], true);
-        clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
-                             val - 1);
+        if (val == 0) {
+            clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], false);
+        } else {
+            clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], true);
+            clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
+                                 val - 1);
+        }
     }
 
     /* STOPWUCK */
-- 
2.34.1


