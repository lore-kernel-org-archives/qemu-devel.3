Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFC3F46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PI-0001Gs-Li; Mon, 16 Mar 2026 06:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PG-0001CI-Hl
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PE-0003en-Vx
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so24407235e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657759; x=1774262559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t2VAKlcXigTm+BUWZzwd5O/HUANdAEJt8p49Wmv76Ww=;
 b=jdkEqeW9aj8n/R5aycTfCQxmSGcTLXdYSL5JwB9QRTW/XS+EzWypCW+37M0pIZa+t+
 teYr7D5HAThKYErDj3F5a4nzV94L56k4bKalMnynWUN4P9rH5W7ZQGyw6s/apXWmOyw2
 J/o1ScjkFVTjImlfJ10BqrfkDPh/tCePG9f6UAJhc41/5HwrYdB8+I/JUlHm7aNTmDGp
 INBkKJrCqLpAl8/1mC2lN1zBM2FmMmgi0RnkR8Lo+/04730rToUdCjJKffEGS6oqYrmt
 h86wY21pZ8ZRMnlLs7ef6KsZE0m5BJX66g8uaugkPQLmYg7eQb07ulw0oUg3dUkeXkUx
 FbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657759; x=1774262559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t2VAKlcXigTm+BUWZzwd5O/HUANdAEJt8p49Wmv76Ww=;
 b=R4VfzzHahGoEs6RwESuDaxm6KFMQyDaBvcn4MSakm3vmYNwTtAtMV2LXjMocb7/F2p
 Wfg3gd+NkIAQmfeqXlQHOwhw0JiqupT/9FgLr3ky2gcn/aqz5M5pg1VLg4x64d+fyzXZ
 FBHTV5nEqFJWNRz5ztx10P+/ur9y5FFjbYY8RxUuLZleD4edjp+OMjq4ybSoWZhaxmAm
 IGYo1ZvhY37sM8Ein6g306TascKu7NUYov2JqWPQeS0ODkDqu/juKCLy+eiBh84z45K7
 BnPl3+nQK8ZAzGWTteiiEEvLE1C3SinlkBmpjDmpYsyT6e2mL5sZoXowknpnqOhGpLD4
 Cmmw==
X-Gm-Message-State: AOJu0Yy/T1rFWHVvvADyBs0i2vcO6SuGNG71JWDxuL5Ayvih9HbtR3mp
 u7pVYaYKKGQhZqIZBNlhEPbvdVVRxSoCjuQlpMTSS8uHXq1EAg2eWGT1C1/GCPJe6hzR+caYYiq
 Ui+lD
X-Gm-Gg: ATEYQzzcS8D1VsPsx4V4v32hskZoywAkXdnW5Nzm3PirJU2oEJ+Cofe89etWrGCWrPG
 NizwQi46IeNdRWeDx8RRpGEuwMlyTWh6+bc1H0O/lReemasb6G1c8gR9QIEbK+RlXEi3skzCxjG
 6YDkkgQnQz0LeIYrA5K/JtD1Wuv9th5troOBwl+wdybWvJdL+QRJGt3nIFbj51KfsOVWOPR26pT
 ejSykR/hB3VjqhvKSqG7LXJluBWyD6Zuk1/xEnSZ0tetsfBfjwsI/Nn+rXu46g/B3lsSnKV0/CL
 NooplVVHdpbpjR9/5l+b84tUR/4vI7bCIZx7SID2KkvK96xefh9byzcuQlXOSPb79Xdkww1DLKB
 Ey5Ncr/9b6BcRKHzaTVc+u/6boeJBOVc0Waq31/wMaQLaSx3VCKkveIJOcNU70hXXU1OwaK2u70
 x/pN/noicda2ezRFtsG+2foMmU0NettbDz1lz5Iz2DDg5zp9JrSczm54aKDX6JcMuuW3Kpa/P45
 w2lTIWxEJA=
X-Received: by 2002:a05:600c:1f8b:b0:485:3c66:e21d with SMTP id
 5b1f17b1804b1-485566d2fa1mr217252905e9.2.1773657759513; 
 Mon, 16 Mar 2026 03:42:39 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/17] hw/dma/pl080: Handle bogus swidth and dwidth in transfers
Date: Mon, 16 Mar 2026 10:42:18 +0000
Message-ID: <20260316104230.836962-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The PL080 TRM states that the DWidth and SWidth fields of the channel
control registers can only validly specify widths up to 32 bits (i.e.
values from 0 to 2) and all other values are reserved.

Currently we don't check this, so if the guest specifies an invalid
value we will transfer more data into our local 'buff[]' array than
it can hold.

Check the widths; since the TRM doesn't clearly specify any behaviour
for what to do on invalid values, we choose to log them and then
ignore the channel for transfers.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3203
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260306152140.2191653-1-peter.maydell@linaro.org
---
 hw/dma/pl080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 3f8acb03de..6262c3f3df 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -164,6 +164,21 @@ again:
                destination widths are different.  */
             swidth = 1 << ((ch->ctrl >> 18) & 7);
             dwidth = 1 << ((ch->ctrl >> 21) & 7);
+
+            /* Only widths of 1, 2 or 4 are valid */
+            if (swidth > 4) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "pl080: channel %d: invalid SWidth %d\n",
+                              c, extract32(ch->ctrl, 18, 3));
+                continue;
+            }
+            if (dwidth > 4) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "pl080: channel %d: invalid DWidth %d\n",
+                              c, extract32(ch->ctrl, 21, 3));
+                continue;
+            }
+
             for (n = 0; n < dwidth; n+= swidth) {
                 address_space_read(&s->downstream_as, ch->src,
                                    MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
-- 
2.43.0


