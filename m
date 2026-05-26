Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B93CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyWu-0000Yk-92; Tue, 26 May 2026 16:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyWs-0000YF-Hx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:37:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyWq-0006md-QV
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:37:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso76010425e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827851; x=1780432651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4EkV7xjSh3pmx79WiPT/ksTz6qONDOK77sE793BSEIw=;
 b=vNDLbYi8VDkVQSWUMFgElvv54eqydTLHCTuoziCAKvQvRgb5vdxD1bYw+zz4cTA92F
 zk12Wm+pHZhHM4zMB9vfPeM5cqacZK8VRh+a8u4LsfanqLFQfQl4aJKgQ33xpns8G/xa
 WbXn9Rcmb2sLPwhBJaaRWNJpBXljEmE4BaPW1AqqzX47yFXU/3g8Du34jrLUf1/aw9rq
 sfCQOgPDCsXrNWoKpT2IOMNOESYWT8T5fiEhNxOGtL1oQHe8KxL5b8DWDjV/yDth/5Ti
 DN8AZHZS4PcT5T+ikW2nREp83i2qGvFefaWE66WfHml5QJANYbz/x6dw0W+xJabTS1ZE
 T8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827851; x=1780432651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4EkV7xjSh3pmx79WiPT/ksTz6qONDOK77sE793BSEIw=;
 b=jq6g9qUjVII/cvnwG1ayizVkjI9oma6+Jctho6GRq4g/CRDK8nRclh2YaBAREY3/wY
 xStQE4lXJKHar8XwU8s7FXJBdbQNnC7/CUlqEfq3U1IzeYac324eXQq2hrbpENWlfu2y
 t4SxtLHEKV8bcIbKeIVv46422LhGOcadGwOCvJZFCSfBLH8gEuy0M0aBIWCB0YXKQ73C
 AYUAgpho+eDXncHZ3ss3pYGNSV/xl9YhghOcp6OxaBjbBf5pl1SD8YaCdJzPKvpuBDlI
 3eQAXeSRKCDr/WLVSiQKGUjckWoxKJDiuqxgOk4Z8lhkcOG2CjU7d7lu+7Slwrk0Tgl9
 o+Eg==
X-Gm-Message-State: AOJu0YywO9AefHdj21jS5eKEEZznB0qX1UjBuIxO5HSMUK0WGXX1ti12
 +tYxUY8NN7f0L0Z/t/E64+1b1Y5xwsPC7rumpYPsuIA1VUh2zmYZySAtI826kOg6VTzgsoYlmwv
 cdhX2xqHT5w==
X-Gm-Gg: Acq92OEQyAN5Hya117vyDdU5V0zCIiv907HMPfpfD777l6omW1rpq6g83IKjHMepEnc
 3YGNY0pm7faANHTUCaXgB5CfxnVR+oCagCMGdfwOGVWedUQEy9KXpSsMbM02eUOMTooYvGta3fb
 P6wTQ0wGaDavgDpZCtjjOIXzqgsteRFOGlwEU5+hQ3PEVv790pTsSpym8NnpHIjra4Bo1rA/2q6
 C4TPAFCl/pF7YXpyxJqXFDim1HFC1TmoUiPFffYe/RXIViejoP3GLbpwJHaA2dvf3cmuOS9QkTz
 7iklB3JPQUUR6LyOCS1fSHACTUCXxiyxHudVPY/FGZqTACS+u5pBuI5vy5KqAqY/zBQZR5TO4nY
 XTZoh4AqeOq4q1w2OxmnN2dwPDgPyQ9/foZgOKLmIZx8JyJxK0l0xswpOxeNgvkvXd4l2jv8Ln1
 ++K+0I4XLfs49PC61SZIhPWmGEDX8rFQCNKVIFBKaiZXvCVVf8wn54B2SaZaZ5IpijVQ==
X-Received: by 2002:a05:600c:8681:b0:490:778:4fe8 with SMTP id
 5b1f17b1804b1-490428ce8c7mr238361895e9.25.1779827851164; 
 Tue, 26 May 2026 13:37:31 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557545sm884805f8f.12.2026.05.26.13.37.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:37:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 01/17] hw/arm/raspi: Initialize 64-bit CPU types during
 DeviceRealize()
Date: Tue, 26 May 2026 22:37:06 +0200
Message-ID: <20260526203722.79463-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

bcm2836.c models 3 similar SoC: BCM2835, BCM2836 and BCM2837.
The BCM2837 is a 64-bit only SoC (Cortex-A53), only available
in the 64-bit binary.

If we build this file as common object, all BCM SoCs become
available in both 32 and 64-bit binaries; however when running
the introspection test on the 32-bit binary, the BCM2837 init()
method tries to init the Cortex-A53 type -- although not
realizing it -- which is not available. This can be avoided by
deferring the CPU type initialization to the SoC DeviceRealize
step (this is safe because nothing uses the CPU type before,
only the GIC access them, just after their realization).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2836.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index ee2f44debd1..03825e69d06 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -25,12 +25,7 @@ static void bcm283x_base_init(Object *obj)
 {
     BCM283XBaseState *s = BCM283X_BASE(obj);
     BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(obj);
-    int n;
 
-    for (n = 0; n < bc->core_count; n++) {
-        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
-                                bc->cpu_type);
-    }
     if (bc->core_count > 1) {
         qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_property);
         qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
@@ -65,6 +60,11 @@ bool bcm283x_common_realize(DeviceState *dev, BCMSocPeripheralBaseState *ps,
     BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
     Object *obj;
 
+    for (int n = 0; n < bc->core_count; n++) {
+        object_initialize_child(OBJECT(dev), "cpu[*]", &s->cpu[n].core,
+                                bc->cpu_type);
+    }
+
     /* common peripherals from bcm2835 */
 
     obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
-- 
2.53.0


