Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE27606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtlg-0006gO-O0; Thu, 05 Nov 2026 04:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtlV-0006du-Ee
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:15 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtlS-0006v4-Lz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:12 -0500
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3adac5c10e3so1054017a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870884; x=1794475684;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xROCpkWUYC71TnBZuGFxVWBBqmZSEffjxEv7jnCU0Jc=;
 b=aRdolb06urkNAn4PBwiumBt1vj4TGE9AQmXw+ToQTb63O6MqnYSaqn6fSNIFLHLg+N
 6rkXdCuotEhHhfV7/uqGRaybQRGEmmUr+KD3Gn9+Zxdzfu+klXqmG+hDCyXznIkQ8R/z
 3XXKkV1Ri0inWApsJR4A+2BfeicSHUvDQ2pYlFTiFLa36y587YQcvwKmAQjCOJKeNZU4
 Z7/s9dX5Ab23xUWU1u/0w5jI93c3C9Esv2bgZkd7UU6EoD++Sc4sTkgOS8oXe5SWcO1j
 F0A9U8uUOdp2AUNm0hT/x6RJslIqotpQw6t0ARtDAaG7z0shVzReRRNrYYQQXc0IF327
 NLIA==
X-Gm-Message-State: APuU4Z+2whxk2Y83XTEpPVreuR3t1sUV77S2IWnVw9Yw5KKyOqJKBxci
 R6Dca9II3f6Ey5rzgM8edmd58XADlqVqgTQuH1FdogZqlOQlkjKydjboE+p3M2QTttc=
X-Gm-Gg: AYBFou26OqiJhvKbHbcqWoczdlvHjy9B2169jpUHOFwncb35XNGQ5Os6VGOloyAbokh
 gV7czb6jQePlvxLuOIdYXpUntbajiaJp9GqaFLTXxRreFP1oK9UvshySrSgVX7cQvwrkAPZ7/hB
 o5g3p+nlne92PsBB36yXGf0eyBF2gmoQNWfN2iIdieXMhea7d97yAELYJJxfMKnYfRzc3kXBITL
 1t35dsp9bYi5sSOdkLeEjfBb6iUJiJ2l00VNcqQ96i7xyB5NvQ1H4k3SDHpyii8dyNZxWrt3zHE
 j+MZYNSj58qUM4GOxqw/l+bj+bBmrGfwGDytskBoaF3SZxFWbq3yS7YVfFS9TPv3aV2hDYmblLp
 pDFgM5H5VO1rL7UAM2nWNnEzcnGt1QQwBXGoVhLdzaxMirrtEa1/k2jyEFge1BEmlvGlIwaF6QK
 Aw+RSzitz/kfuCldetuyYWIIWD4ijdFtvpILCbzhkGZ9nop1NiGN8k1FU5YTpHyUBO/XmwQCVR4
 rtb/hpggf/ibK9qXuzdicmXXSBis1mguySfqjHoZM6olSVUt8Rs+fRQkN3DgvZlJUFwDKvIgmme
 yrZNV94OCBf06z2jB7pesQeq5aH3c8ntX3BIzqhsSaTb8Mk4UWg/uxAjf1wfMgp9SU9R2XtH+n3
 s
X-Received: by 2002:a17:90b:28c7:b0:3a0:a912:e759 with SMTP id
 98e67ed59e1d1-3ae897ee62amr15881143a91.25.1793870884072; 
 Thu, 05 Nov 2026 01:28:04 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b90def97sm2554833a91.7.2026.11.05.01.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:28:03 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:41 +0800
Subject: [PATCH 02/16] hw/sensor: tmp421: name the parent object field
 parent_obj
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-2-c46853f5e1f0@free.fr>
References: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
In-Reply-To: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870742; l=1266;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=LKRPZEbS+SgjV2hPOICiQGuvSWwSj93umhoLaBNzCtE=;
 b=x3tqdVLnIyF3m70IKnZE6uQ5qNKI7Xb7kTy/lCMZBC54TqGMDRLW5VOh4Q6/Zc41p5fGLjrz/
 uoWD2wPsGnvCHsPdxs7sIUnlxa/OzbcaNiY+u3TzyMUsc7qxuyGTeG+
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.50; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f50.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Follow the QOM convention for the embedded I2CSlave, matching the other
hw/sensor I2C devices. No functional change.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 84c6ebec41..55e261a090 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -52,7 +52,7 @@ static const DeviceInfo devices[] = {
 
 struct TMP421State {
     /*< private >*/
-    I2CSlave i2c;
+    I2CSlave parent_obj;
     /*< public >*/
 
     int16_t temperature[4];
@@ -299,7 +299,7 @@ static const VMStateDescription vmstate_tmp421 = {
         VMSTATE_UINT8(status, TMP421State),
         VMSTATE_UINT8(rate, TMP421State),
         VMSTATE_INT16_ARRAY(temperature, TMP421State, 4),
-        VMSTATE_I2C_SLAVE(i2c, TMP421State),
+        VMSTATE_I2C_SLAVE(parent_obj, TMP421State),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -335,7 +335,7 @@ static void tmp421_realize(DeviceState *dev, Error **errp)
 {
     TMP421State *s = TMP421(dev);
 
-    tmp421_reset(&s->i2c);
+    tmp421_reset(&s->parent_obj);
 }
 
 static void tmp421_class_init(ObjectClass *klass, const void *data)

-- 
2.53.0-Meta


