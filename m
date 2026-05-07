Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81539CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11b-0003yF-SP; Thu, 07 May 2026 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11Z-0003rG-23
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:29 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11X-0003ud-K1
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so12021625e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169146; x=1778773946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UfDVcv98jyHK8QZf2yirTNDFGYOzCBs5DRGWgCmfPs8=;
 b=j5wbIOHLXqr1mCtwZEp1gjnYyX5MxH4ZjEtrchYDhsmEuJq0uQGxyu0zALVjrDfiBZ
 3RogtJ+pBC5xUer25r1KZke8MeFjcbjO+PX5zx2+Q/EOa+gLbhvad+UNs0AUrOdbl4TP
 AQ1AZGZSjZE/P4hI7uMS7JrscRIibNJIBrYftjsUEuF6mfZ6zcyaN1vpB3LD5k1YcY5l
 7vokUZlJhKnObUq1bLdSL7zm5LZAuJ9nHUSG17fG9n6sr3jApHAgyglDbtXati9zbH9m
 IwcTnTA+m0IKmW4caclaI4AlFYxCFj2T6uFMOdXC1yANkg+ilZEQbadMzheml+Mqirzh
 bvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169146; x=1778773946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UfDVcv98jyHK8QZf2yirTNDFGYOzCBs5DRGWgCmfPs8=;
 b=dY84N6m7ze5Ygp9w3cQMuZmWJEBFvnVEFjUZ3uixKvYrDDiCrYkGQJzdK6Ys4uSgoZ
 tsI/rWWA35JDBA0DEucv9ntMzicfpdGSSC5Atzt9SseVZsf9c4qPC7odSKAlF1J40gTc
 UwtjWchiihEPmxegp4lNsxtFptsp53I+xqlkJpDaEGyA3CctOMkxzDwAJzAePMA9xZPA
 pAAYkvSLJXWmnpoDpXfTAv6OihMjdkQcQTjYFibTmC3vW2ioLUiSgqsOcP+Lkd47V+pO
 dK2cvPM5os1tF/FZHTVOEWKNAfL5bNNHmIJNQw+GJ4SY0cTsMThAzbuj5U4SdUvvlOrp
 lWYg==
X-Gm-Message-State: AOJu0YxxtvAaVx8OOnScMY3xDL26ttVKaYiZiBxn236K9PeBPMVbiqCo
 a85va7T1kAH4412H1oy6NXuE+AleiXdpYC4oko4CZcnesZr32QGAXDdX8eFN8yvUJ4r0N4ovi+r
 EPZwW
X-Gm-Gg: AeBDiesgbecQSdjnEZi5xDLtVre7OtH34X2330F5KREQSxL/d2vtgNY4tP+zmFZGoCB
 6QgVsX6y9AjIhAukfV+TgA/lfyngEl8I9/0kkph3yzAJdnP773wIUlcGWZNGVxyKI6JDbcfx1N4
 vlycPs9uJJbg8y3iofMMGRVREhJy5rDloSAuvPq+S8LOVEFtY0+XSDGpM03uIEp5oIb58TVLO2Y
 rjstUwHriny61Md7d5+NfK+GcKqXxF+r3u6VDqgpv4BundU/1HM6jCvFbjvIoDonkaUiu18EtIy
 8VMvaBariGfOCvfa0l/535yhXBZMjbC0rY0WfrEibImJHQkDrRhmLELH2YShzYdDvewUqNNCz3v
 uxGAKL1p3M1Ubc+w2Sm6/An9X1aBlf2XZ1O+/Jxna/0xnSUQIu0SqmpOpyg8vTKIDq1tRM/1nyv
 nJMGWLe739+DgdD/dyH92J4FZ4uURxm37l9zGbzbzNludyCuGMxHwUT7DrB87ufO0plHEgPJywH
 nVCmqSZmzvihTTdg0uXLaetQxN9fR8=
X-Received: by 2002:a05:600c:4755:b0:48a:7b55:12a6 with SMTP id
 5b1f17b1804b1-48e51dd5ef5mr138999165e9.0.1778169145995; 
 Thu, 07 May 2026 08:52:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/67] hw/intc/arm_gicv5: Implement IRS_SYNCR and
 IRS_SYNC_STATUSR
Date: Thu,  7 May 2026 16:51:17 +0100
Message-ID: <20260507155154.1886557-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The IRS_SYNCR register is used by software to request synchronization
of interrupt events.  This means that in-flight interrupt events are
guaranteed to have been delivered.

Since QEMU's implementation is entirely synchronous, syncs are a
no-op for us.  This means we can ignore writes to IRS_SYNCR and
always report "sync complete" via the IDLE bit in IRS_SYNC_STATUSR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-31-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 3f397d9115..7b0d9e16c4 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1087,6 +1087,10 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_CR1:
         *data = cs->irs_cr1[domain];
         return true;
+    case A_IRS_SYNC_STATUSR:
+        /* Sync is a no-op for QEMU: we are always IDLE */
+        *data = R_IRS_SYNC_STATUSR_IDLE_MASK;
+        return true;
     }
 
     return false;
@@ -1172,6 +1176,9 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_CR1:
         cs->irs_cr1[domain] = data;
         return true;
+    case A_IRS_SYNCR:
+        /* Sync is a no-op for QEMU: ignore write */
+        return true;
     }
 
     return false;
-- 
2.43.0


