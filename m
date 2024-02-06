Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75E3C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLWD-0000f2-1E; Tue, 06 Feb 2024 08:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW9-0000Rb-BE
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:41 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW4-0008EG-Np
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:40 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40fdc63f4feso16545405e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707226175; x=1707830975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EMtxt4f4Pe35Y41NOxdIdqkHjaw4kvMUbL17jcA12tk=;
 b=bT2+ZVlD5CAsctR3I0n7HIvROAxYZaraclQpnKol+KczY2+5FGCUzrdVvhAkruBIah
 /vkhoGMqco5GyFEkA3d7ULz8bxQAb3VHtKSF2rhIJtb87uth9kgBw7h/BwP7iyo5qB2d
 HPjrOD9d5fAduzw06bGazrn2DtPfvP6WvRCx6FQoQwDhXL+lDigfJW1YMC+7TMvEDPKl
 n0611NNyDWQ64U4DLB+AcNXd75dYujVL1N75MKSEfLPnNOFzdxcbC6sSmLGXnpaG0UkL
 dC03o1Qt+uxGn+T5BqaPJLe7oQfKNyIdbLxOvAwvqozP8O8amDwVSWjhWQqV6QTP8sRP
 Nu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226175; x=1707830975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMtxt4f4Pe35Y41NOxdIdqkHjaw4kvMUbL17jcA12tk=;
 b=VZpl3Nof68987QOnNlMcLvYqqVTWk6YcPQJxMa6tT86PDvSFFPXimW7BMlGDqELnLv
 Nkd1eCRVDsGmRUNXGK1LAYWj3fVOZiapFSGEhRFWhAxFO0WWNFOsC6vIhZAJHBf8E7g0
 fi2RshADH1IH1l63biczOw3aMoiycAZ1osjlW7v50//sJTFO19YttD0dWJOFTY+4YYNM
 dF49oowBjDP9rILHpkHsvWt8566VQsZDvgnxqGqqKwI0oNd81u/izInrJ3t5H3/6wQgW
 xHAp9ZpLHygKEHvkGN6AgsyDcb4Xk2nGTXaVx+jNgaBSg4Qa+mRgM3tge1b8a2A/B6lp
 PJkw==
X-Gm-Message-State: AOJu0Yxi/v5eRJ6jBfDdR2CGlBkooxVapusHGQg8JZ3bZTd3M74BMktR
 ubGghfqTiy0MV/2wiMF75/lDErEEAJV3KZZXs3bxoYfdi+r2HMMAvwEnzUy1ZfM=
X-Google-Smtp-Source: AGHT+IGdt9rl+fgak9USCnEUHAEQqb80qMbMZy811pXWnMh+J7g6tGiSdUhtYmk7T41c7+/Uly52XA==
X-Received: by 2002:a05:600c:1c83:b0:40f:de06:fcee with SMTP id
 k3-20020a05600c1c8300b0040fde06fceemr1985249wms.7.1707226175333; 
 Tue, 06 Feb 2024 05:29:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCULJhTN8UK1lKExvZU9CAgCvkM0dShiAaArMWSUIZtML0eKmpYmpaIZG8kG4YFcUyuWkyA1sE/zPv2tv349hAKAst+0Brs=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056000108700b0033b470a137esm1492932wrw.79.2024.02.06.05.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:29:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/13] hw/misc/mps2-scc: Factor out which-board conditionals
Date: Tue,  6 Feb 2024 13:29:24 +0000
Message-Id: <20240206132931.38376-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206132931.38376-1-peter.maydell@linaro.org>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The MPS SCC device has a lot of different flavours for the various
different MPS FPGA images, which look mostly similar but have
differences in how particular registers are handled.  Currently we
deal with this with a lot of open-coded checks on scc_partno(), but
as we add more board types this is getting a bit hard to read.

Factor out the conditions into some functions which we can
give more descriptive names to.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/mps2-scc.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 6c1b1cd3795..02a80bacd71 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -59,6 +59,30 @@ static int scc_partno(MPS2SCC *s)
     return extract32(s->id, 4, 8);
 }
 
+/* Is CFG_REG2 present? */
+static bool have_cfg2(MPS2SCC *s)
+{
+    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547;
+}
+
+/* Is CFG_REG3 present? */
+static bool have_cfg3(MPS2SCC *s)
+{
+    return scc_partno(s) != 0x524 && scc_partno(s) != 0x547;
+}
+
+/* Is CFG_REG5 present? */
+static bool have_cfg5(MPS2SCC *s)
+{
+    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547;
+}
+
+/* Is CFG_REG6 present? */
+static bool have_cfg6(MPS2SCC *s)
+{
+    return scc_partno(s) == 0x524;
+}
+
 /* Handle a write via the SYS_CFG channel to the specified function/device.
  * Return false on error (reported to guest via SYS_CFGCTRL ERROR bit).
  */
@@ -111,15 +135,13 @@ static uint64_t mps2_scc_read(void *opaque, hwaddr offset, unsigned size)
         r = s->cfg1;
         break;
     case A_CFG2:
-        if (scc_partno(s) != 0x524 && scc_partno(s) != 0x547) {
-            /* CFG2 reserved on other boards */
+        if (!have_cfg2(s)) {
             goto bad_offset;
         }
         r = s->cfg2;
         break;
     case A_CFG3:
-        if (scc_partno(s) == 0x524 || scc_partno(s) == 0x547) {
-            /* CFG3 reserved on AN524 */
+        if (!have_cfg3(s)) {
             goto bad_offset;
         }
         /* These are user-settable DIP switches on the board. We don't
@@ -131,15 +153,13 @@ static uint64_t mps2_scc_read(void *opaque, hwaddr offset, unsigned size)
         r = s->cfg4;
         break;
     case A_CFG5:
-        if (scc_partno(s) != 0x524 && scc_partno(s) != 0x547) {
-            /* CFG5 reserved on other boards */
+        if (!have_cfg5(s)) {
             goto bad_offset;
         }
         r = s->cfg5;
         break;
     case A_CFG6:
-        if (scc_partno(s) != 0x524) {
-            /* CFG6 reserved on other boards */
+        if (!have_cfg6(s)) {
             goto bad_offset;
         }
         r = s->cfg6;
@@ -202,24 +222,21 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case A_CFG2:
-        if (scc_partno(s) != 0x524 && scc_partno(s) != 0x547) {
-            /* CFG2 reserved on other boards */
+        if (!have_cfg2(s)) {
             goto bad_offset;
         }
         /* AN524: QSPI Select signal */
         s->cfg2 = value;
         break;
     case A_CFG5:
-        if (scc_partno(s) != 0x524 && scc_partno(s) != 0x547) {
-            /* CFG5 reserved on other boards */
+        if (!have_cfg5(s)) {
             goto bad_offset;
         }
         /* AN524: ACLK frequency in Hz */
         s->cfg5 = value;
         break;
     case A_CFG6:
-        if (scc_partno(s) != 0x524) {
-            /* CFG6 reserved on other boards */
+        if (!have_cfg6(s)) {
             goto bad_offset;
         }
         /* AN524: Clock divider for BRAM */
-- 
2.34.1


