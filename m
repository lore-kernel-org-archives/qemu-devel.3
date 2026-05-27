Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF70CCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBYV-0004Bb-7u; Wed, 27 May 2026 06:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYS-00040r-LS
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYQ-0000re-QZ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so39588115e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877921; x=1780482721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4FOlc9hiKzCXvW/hEdSAqPQWX+ikblJBIP13gYL3JC4=;
 b=dT3fmvzGAAe9bGLkaYIkocrheWCvSpJDR+aLTSKJRy9wM0x1zgXoGDaYDDjA5iw6bf
 BfcCQKobtI4M22q5qpwIKmI3rJpxUXUVgGaETHQwvoa3vjPlRiYbhqeZCywqFRV+3LuX
 HzPFYvHOgXAyYsljLzxmSK68adHPV2mICRBwjTpFbax9YxnbQJQLT+EGC0QBivw7+l6C
 XNTEL54TBkUzrvqmQ5Uy4APGvRccC64C6fcY9zd/qBkbIT1gmHKqzGlY4pwZjfdQK7nh
 zZNglYBT4YYHTs+Nv5nUHqCHLtRa7AYEovBUj8hWhMj7tW25+qj4V93FqrnDzPmLh44E
 E+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877921; x=1780482721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4FOlc9hiKzCXvW/hEdSAqPQWX+ikblJBIP13gYL3JC4=;
 b=Goz6bIiZFcJnuOXqMZbIBsLmEBsNXM8M3ECDYVUh8kFMyIgq9NdrFeBa4NmnR7djS3
 pVEIdJ8dkfWSLCEJAP+hwkfbgR/4Wn9kQg3GfKEAY/OezAJM5MUQou3HMBRGjVdvrQGQ
 DLyQtDd3mZ8otK/ikrAejBFqislKt+b0V1ELz6QvZyzYj/mRvmqZYtRZOdMzPohkf2bO
 X23Q2ey2teRP3EFlOciQ4OGSZGlPcBlprmNohyTuO0tmCSRi+oPoYVqb+cIzTPR6g+hj
 4mMXWllRUA+ITuyBXy58Pxf3uL5LpQNvn5qA/DAcGaFZBGEp3xrPvOH6wNhggyXUhQ5x
 ucjw==
X-Gm-Message-State: AOJu0YzYKCN6EfUiAh5IfJcfSwJp8wEeUspeiR5oSVoMiTr3p3xKxmEr
 49dFOtr7/rS1mmafBqNaoqsRKWOOlKauLmikNfg1xWogy+Niu8T4JJ8dQr58M3FgNW4zWLE30GP
 98yXMyK2OmQ==
X-Gm-Gg: Acq92OER/Ks8eUiljzyRJEff7ksDUntCbvwnR6tU2fktzSGm7F0g3YZhh7JFKxr+NhJ
 iwos6yU3MYlyMWxuhs4Q2I9c+6/PYrhEO9I+5q8/nyZT5rF4A0hKfT0tr8xqnekX3syB94W/gBF
 I89VKHKlk4dx/TPQww81lylMibc4EsrtFzq3hN6Ydn3q0g8gmCnRu676sZEtw1Una31tiOh+2ip
 FrtmpeeJXXmOVUYdrmObYk/7tVtDLkWdUoPRAqVALli+cwl8cldKhCmUFMhYZdYcALszrXrZF7J
 RfkRpBy4K5AeRMw13F7XTC7EMVb0eYdnErG2xBhQm9ZY0r6VwL6NktG3ToYvxRzj2CaX9cI/Y23
 2mmkzM2hxBE/XjrK+ieh5PWzF17/tDWO1WH2RU1b+IImnv6jXKrWaK16mZvAyltVv5AhvDquU4d
 WEUJb+NrTnEPmgWpYP0GOLW4eI0fxgIDJ1HwB2jvT+OuNkZAHRBpv/SJk=
X-Received: by 2002:a05:600d:6451:10b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-4904249d11amr272533435e9.7.1779877920960; 
 Wed, 27 May 2026 03:32:00 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454cfcaesm382045755e9.4.2026.05.27.03.32.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:32:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/32] hw/arm/raspi: Initialize 64-bit CPU types during
 DeviceRealize()
Date: Wed, 27 May 2026 12:30:16 +0200
Message-ID: <20260527103037.4461-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Message-Id: <20260526203722.79463-2-philmd@linaro.org>
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


