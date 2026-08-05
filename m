Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5490C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrh32-0008AS-Q7; Wed, 05 Aug 2026 15:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrh31-00089L-75
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:13:03 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrh2y-0005aF-P5
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:13:02 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso507462fac.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785957179; x=1786561979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DZuuOFaM+Flh2PqhtYCDF2VNf6v7ZlQ6shE5JZlpVCI=;
 b=X+CqrInprYpF/9AM24E9vlKPx5AYT1cKBM7A+snCky+1gOLlVS1g430Ks2Eiu3a1Of
 Vbd9OFld6yxZyymT1LD+8xUQp3tOwoIggTyD4J/loFzp+I2vBojj4Xp85L2I2WqIDhZk
 aATxEPWyRP7aVPZbAB5q1359qcc9nET3B2wnA1uVd7+7tlGRMDBnSDldP2QgH8/qhO/0
 cy0yqD7jL4L/0+Rl+xP+QYdY9bCTc2J01Z66Ga8SKI2isCVQktKnszRqxDqXGI38zf1d
 3iOgPsNU1g8JCvPlP1OU425vO4dx5UsmG/460iON4x3AA6PcJ5kWQlEEvuNV3uu3eLE/
 6lBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957179; x=1786561979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DZuuOFaM+Flh2PqhtYCDF2VNf6v7ZlQ6shE5JZlpVCI=;
 b=OQ+I97Idq9xXgnK0zeTdBB9Lsp2fWu4iytx0c1Sn/tkg8+4rN7YK3cY/v+ZAqa6Sjp
 Dwsh9rBERL+MrBNmXXk+djHKUeKzalFgB+Op7vmzVirJg9UAOL09hvJF8EdY8OoH1XZJ
 hfGw7M5SozEStUBnsOMBDVjFVk0ZAU6PYqUbJIS01JjLdPmQHUp1SBjTxzoi7gxfN3wv
 OGbrrHeGVv4Tj9TqcU81RiIhtJ5VIZj0GqIYizO5OWsNK7FE5lkJ7p7iIvF5UofOiplO
 7SMeD57AKI2YiT3id2u38jnROYqrx+QKVQAkP2F+WOMGVIbmauFsjp8QkJY+a9TNSfdd
 Ta3A==
X-Gm-Message-State: AOJu0YyDc8vf29eBEs3/jkh5rKajKdcaoUzskAR/NlWlEf62Vq3P+Pzs
 S6uZMFacf4r2nreTsusmAtvipr/Ch0NoOkWMuu5BMZEH57blRWNmcQGV5XznXeSr
X-Gm-Gg: AR+sD13ghgn/kVIvn8J1whqE/4F3QD/qQy0L9GIvRS3XfgfMJyCEHP+eI0O6SMftZUF
 V+yzkyClPUlRyWqp+tooaDg9+a/UMsdr9YzoJIowzVavDZ5I8lS1iMZFiR4Z2kvmrl7u5jQLodx
 xasrR78qA9chZElGNWT0WoQ/OT9f8WtRKQWuSACBMYF1nBtlly9i+p89KgxkxIeW0TjAZA7ucbU
 yab3W4oa78S9eKyTG4xyOMj4iVDUeTe7KLebW4hoY7ei+neipW8rU+JJ9xgfnMiDp5A7B/Egmzp
 au0V+noQIsvi1zvcLReQrdtgzkGBrK8Kooi6OkxinFhzTuV8xWMcQtnFJ/OeINBWaz2i4qMoSL/
 ICFQ571HNN0jR5Nt8B1Z8uHpgcJJ8Dz/k5ewJMDEEKI4M2sUO0eKurR3ePXVljRelmxvd3crPzk
 5i77VLJfdfHwFSB5UyfosBtNnlszAmJ4a1ERmepc4FVgWNnM301pCQTCn2vWUVnqFSzE7YcMSi3
 +lgUc8Oja1C+90=
X-Received: by 2002:a05:6871:b0f:b0:456:9b53:c6b5 with SMTP id
 586e51a60fabf-4599ef8fbcfmr4887284fac.13.1785957179399; 
 Wed, 05 Aug 2026 12:12:59 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.98.248])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4599dd615ecsm3494867fac.0.2026.08.05.12.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:12:58 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH 1/4] hw/arm/armsse.c: fix SSE-300 s32kwatchdog address
Date: Wed,  5 Aug 2026 14:12:54 -0500
Message-ID: <20260805191257.11303-2-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805191257.11303-1-simonxhy0404@gmail.com>
References: <20260805191257.11303-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The SSE-300 SLOWCLK Secure Watchdog Timer is only defined at address
0x5802e000 in the secure region.
Page 45 of the SSE-300 TRM specifies that "the watchdog is Secure
access only".

SSE-300 TRM: https://support.arm.com/documentation/101773/latest/

Fixes: 8901bb414a24 ("hw/arm/armsse: Add SSE-300 support")
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
 hw/arm/armsse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index ddb210c895..e99b491bd9 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -409,7 +409,7 @@ static const ARMSSEDeviceInfo sse300_devices[] = {
         .name = "s32kwatchdog",
         .type = TYPE_CMSDK_APB_WATCHDOG,
         .index = 0,
-        .addr = 0x4802e000,
+        .addr = 0x5802e000,
         .ppc = NO_PPC,
         .irq = NMI_0,
         .slowclk = true,
-- 
2.53.0


