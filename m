Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B5FD4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVy-0001rH-Ik; Thu, 15 Jan 2026 13:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVQ-0000jA-3V
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVN-0005wO-Tp
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801c314c84so5219345e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503329; x=1769108129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wlp0FvTGz1vaK6cfRoAC6PByfj8iN/GLtX8hRHZ8j8A=;
 b=tzQSP2mLbanGzsXgSM1wgteFNMVgGkxghxnrxyKscF7wwmRFKuY9RtrxMjG2tPd+Wv
 AL2iEUSPMU/Bv/WomVc5Tx2EWm6pASTKhNuzTFYgR7FhjHRAS5wFl90SdGmypDoV93Sb
 FJdQRWxOIPKRAXh8DhmHIokXqijy9si7BpqLgW3MT4Q4CprW7L112Dmz+7L8TCqem2ae
 c33j41a+ddtnR1LGmAtRu15fN5qk3Q73pZFC0F33XN7vIvSRw19KOx0+LxXOgoQNc2gh
 +iFQi0Yc38GnPPFPflLJLbnBaBBMEmg+ke/j7ohcBgGfKIjeRmAXI165cMUzEVRSUrTB
 1wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503329; x=1769108129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wlp0FvTGz1vaK6cfRoAC6PByfj8iN/GLtX8hRHZ8j8A=;
 b=ka+SMLhGiL3Sbv2R32HvB4fe0DRh5GZ6IOLrgAjilJ3waHovbMKNglpJb1etE5LFTc
 NCi1Iq63Sx9j5wdNH+PVTj436aafDICzipV2zB+eRzCiWvKCJPlgLGJQn1KpApAyetDo
 wUuXrFZLcQwv37EDnfV46Ugb3qjcsxDeTZTTU05g9lGKWHZAyHYUS3kaXaNSMDSmS5l+
 +zFSqE0/3XpGMekIak87pnNlUB5oUyYrKoq6FM57yFgCuXletTk4PcqPjh+K5gElQKZy
 1gkSPqvsZhdjbutpBv6RPrXsuda+77jLjdEK1g5g8OXoV4knv+BHt6ZaKiyRfneEdjXw
 45OA==
X-Gm-Message-State: AOJu0Yyzwh02HVhgjpCFAkOcQ2HtabSaTLbpuCZeqzSXSkReE3C0sSsh
 o6Fsnij475GLi1uqeDfrtgnogS3uac94k5QpJQ+i27VsSfVVU9TOKiGV5qBWhSq6835KeUZotiH
 yRfXE
X-Gm-Gg: AY/fxX7r25kCRHHGK1fwalSRkKgcA7eh1c7hfI4Ino+XF1oU3Hj0aUK4hBnsxDj436u
 rt5nEeFT5SsVECwUyt8GUZXha5qkppNT3xrq76fJ730tZOkuZdjScDmeXCm41e8oovGTVnc39N+
 nNGDL6cqSVw0TwQuDojIaD5SFjVJhdqqXj3WS8WTc78M7PFgOkHwYsiCv9KsuUKUkqzz6kuXTzv
 gqFH28pWwU/WrGmBWwlBOvGCan3t0tWfk/V2MHQ8T1AQpLKY6hbxBV/Q4IlJ8utTraEqVqzO4m/
 EfAm02zPufFrRSwItImLNzSa6wZ+JPlCygdtjWsBbSP3G7SQ0r6dlU9kWJVUk6+KVikMTIxDrAm
 lpMu7GZdgGx9c2FD/SdKBakABGGhp+MKAZrOKGtsLoFNMz/TJz97i1RXVuhsv4HzW2E+b+7nm9p
 208XvR6DQ55C0lVzaBstzbTFc6ArmMfjOmEkvJ+62bg8+TxWzx3xKa+qtLr8H3KQtRgLiwc9LDd
 6WQikRIN1+7M+bWw8jz8S+939aLnWmq4UXacCpbCxEBI13YhoU4ia4p
X-Received: by 2002:a05:600c:4ec7:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-4801e30a126mr8229695e9.5.1768503328855; 
 Thu, 15 Jan 2026 10:55:28 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/25] tests/functional: migrate aspeed_rainier image
Date: Thu, 15 Jan 2026 18:55:03 +0000
Message-ID: <20260115185508.786428-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Cedric has a host for the file which allows us to keep the name.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20260113135941.3361163-1-alex.bennee@linaro.org
Cc: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/arm/test_aspeed_rainier.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_rainier.py b/tests/functional/arm/test_aspeed_rainier.py
index 602d6194ac..30827beca3 100755
--- a/tests/functional/arm/test_aspeed_rainier.py
+++ b/tests/functional/arm/test_aspeed_rainier.py
@@ -9,10 +9,8 @@
 
 class RainierMachine(AspeedTest):
 
-    ASSET_RAINIER_EMMC = Asset(
-        ('https://fileserver.linaro.org/s/B6pJTwWEkzSDi36/download/'
-         'mmc-p10bmc-20240617.qcow2'),
-        'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
+    ASSET_RAINIER_EMMC = Asset('https://kaod.org/qemu/aspeed/rainier/mmc-p10bmc-20240617.qcow2',
+                               'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
 
     def test_arm_aspeed_emmc_boot(self):
         self.set_machine('rainier-bmc')
-- 
2.47.3


