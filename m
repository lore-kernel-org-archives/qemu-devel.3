Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E59C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQ4R-0008DV-4r; Fri, 09 Feb 2024 07:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ45-00086K-CD
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:33:09 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ42-0001wg-SP
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:33:08 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4107ed0c536so766095e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 04:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707481984; x=1708086784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzmCAZqDnP2GixBxkCB+iCs3cLSrfN0BzrHq0xGFwRw=;
 b=O3StNvGaCW5pR50S+3/8bugspf+NpvrYo2inwabPaLaGhb1D0NR0E2UfPzXgRTKjQz
 C2jw26s7AMjngnf9v6Tmm73YiaxJHPZbzP58LFQS6Fut6ZqFn+yL8ie50h8Mywd2PN90
 FXPE5wCgPO7QUaSyNzE/Lg+ug4Mw+V+NnlJZCNwxDO9jmwJkwGrlrACgau0Vb7Bv8yn1
 2wO+cR0lIQJeoSriyfJj/HedoqdMBoR+lxtxppnjjsyKrbPEsjPtE9I8Ogyf1KJnVw3T
 NkdviWAf2qDHpTqzt5hy72fTnqJKuz4OSqxWvC8X1CrfRMIWyw7db9oBxzUD4WSIMZ3W
 D6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707481984; x=1708086784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EzmCAZqDnP2GixBxkCB+iCs3cLSrfN0BzrHq0xGFwRw=;
 b=HAmRrk+axQx65guHkqtV3RkLl8hVmfRFnZlMmX44R1duoNX6Ts8Gtdgis6uyKEugF0
 3cMc/fiaI3x97I65KRnzxPxjlRVp7hqPhk1e8ua0E0MFeiNjqjB2vM+VgQ1YySj09Qsm
 eUnYu3B/pBgdAhK0v9bp0vdnmlpJprhNG4SlRfnhhXgcLrqILJ8ZM/fwzvNBEomAG4oJ
 rXG6IQ1oYBeXuinJHkLekno3fxljKbHgl96V5e+AdW+qbpnUtc4Yy/FuKd/ifb13xqzX
 toU7+YG7EH1Bbw3oMw7PLcUDl/uGAGfD/bo2ZFSsfwKriQsmk5/76avb6giu8O/doJo1
 JOaA==
X-Gm-Message-State: AOJu0YwdC3IcOUE32uerljMpz281NPrBN8kNoi+yR/e76F/nwd/1/UhT
 R+hK8lZvgBDrK5pXeA6vWE4F0wo8ky0d65LxY414JsxKx840sG4egSUbOfRMv/42n+Z4yFNrzBM
 Z
X-Google-Smtp-Source: AGHT+IFFniHgzTURLnYglT2Uf75r2lJLrVzOD6Zm8Bv/u5mrekpnhWZ1KZ33dJ8yDe2BK21x7bT0Ug==
X-Received: by 2002:a05:600c:35cc:b0:40f:dc50:aea5 with SMTP id
 r12-20020a05600c35cc00b0040fdc50aea5mr1230765wmq.22.1707481984432; 
 Fri, 09 Feb 2024 04:33:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWXEEO6MR0jNSBaQ5p3sBdVfhNDOQv+N8rvHqTksw8HLNFUba8y0enrZEmMbRvtARpx8UGiGpZ9GoGHaQSXrLcMd78ZhvjzYc/2CmKvvVspbTDqsZEEiq+A8Xv6/Fi2PGsILNbSfLGVlU0KZzW3h/9SgoQ6X4h+W/9/rHyo8ix8162J5gbvi+Gj+xO7c8rCiIjvS7yH0BOOu50owsAcS83l0F2cO91lIt5B0wONiwUZyd8ZhZEL4kPDJZrrzkhoqhr1S1BpF2e5xmjUWAtm7p30SS4GZ6ZMkgZlzC/akWb53O6Wy1R85E8wi03gXRa6eEiqm49eRzWSPZY=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 jr6-20020a05600c560600b0041079d336c7sm484051wmb.39.2024.02.09.04.33.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 04:33:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 6/7] hw/intc/mips_gic: Initialize IRQ array once device is
 realized
Date: Fri,  9 Feb 2024 13:32:24 +0100
Message-ID: <20240209123226.32576-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209123226.32576-1-philmd@linaro.org>
References: <20240209123226.32576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We shouldn't call qdev_get_gpio_in() on unrealized devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/mips_gic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 77ba7348a3..05c8b8f4c4 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -419,7 +419,6 @@ static void mips_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
     s->vps = g_new(MIPSGICVPState, s->num_vps);
-    s->irq_state = g_new(MIPSGICIRQState, s->num_irq);
     /* Register the env for all VPs with the GIC */
     for (i = 0; i < s->num_vps; i++) {
         if (cs != NULL) {
@@ -433,7 +432,14 @@ static void mips_gic_realize(DeviceState *dev, Error **errp)
     }
     s->gic_timer = mips_gictimer_init(s, s->num_vps, gic_timer_expire_cb);
     qdev_init_gpio_in(dev, gic_set_irq, s->num_irq);
-    for (i = 0; i < s->num_irq; i++) {
+}
+
+static void mips_gic_wire(DeviceState *dev)
+{
+    MIPSGICState *s = MIPS_GIC(dev);
+
+    s->irq_state = g_new(MIPSGICIRQState, s->num_irq);
+    for (unsigned i = 0; i < s->num_irq; i++) {
         s->irq_state[i].irq = qdev_get_gpio_in(dev, i);
     }
 }
@@ -450,6 +456,7 @@ static void mips_gic_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, mips_gic_properties);
     dc->realize = mips_gic_realize;
+    dc->wire = mips_gic_wire;
 }
 
 static const TypeInfo mips_gic_info = {
-- 
2.41.0


