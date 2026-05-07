Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3222CCD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11K-0003UR-Eo; Thu, 07 May 2026 11:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11H-0003SO-Ay
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11E-0003oX-It
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so12018175e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169127; x=1778773927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RGheXXRC6x0QXSLragqGnkW/MkrRzCgdH8x0picNC+0=;
 b=Y0mWod6Rv0D9eUEQcsbwG5RGKMtmJyAUSshsxZW+8W2zdMKw75YK89lnwCuoOIlfm9
 AdtDmFrq+F2fqd1yOTU6n1avJnUFsyneN14JIWbrgBaOp7hCjdudoUePaZvx9pJnFSZl
 DniWtnsoYBkb+94zpuHpmbJR4G+Ojv0za1euwm2td0TgzioB2thn4gZUHfYh0XsFoDy/
 13EPr/v0UVf0w/IoW6Vyhx87UdK9P3EZ0oUIhTV1caVSXgYzfZHL4N6UEChqudrdQxJN
 10WrUXAtHUbcoDNamqD0MbQhKQNWC0Jt9btgNSo3mtTCLFGoZDXfb1TaXNDIBTy630bP
 KYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169127; x=1778773927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RGheXXRC6x0QXSLragqGnkW/MkrRzCgdH8x0picNC+0=;
 b=V6/8B5aXe3sJpSX1iRe0bD+8a/Vh+73rawDW3LOtdw+BkpinEOyklOj+jFBk/eZnWh
 +FlGq+4z8ffzQXLL22gGPKxQYzVBrs+Nepciv0JzkuLgdoQLpDePavWIKmtsQg6EusuZ
 nY+xUU5JwF12iotZZPRy6jjzlelDXTu+XOHFYYwB61Jw9hwnGt74MPtm6EidulEfZZOe
 G9GONxkeFf0J4obsdpBQW2ButaP4a54afgdK2ngCy8gRaE+yaOowCm6pV5pkMj/y/NaO
 cT4A4kdEayFetMdjsqSB8ro6zbcRf1QGPwrGoVK3pXCsu5iuY0Q02808BkidRLvCAxOI
 426Q==
X-Gm-Message-State: AOJu0YxHH1BGvyjqABKOaBAiuvACtWO/ZHiAJXH0Rq9nqSfeCZVn6OHX
 P+qVD/eSIffuEv08F9tPOhP0TULQq/yO7KjadZL6C5/aP8/h7ESuDT5uLLqt9NHoTZBYoQYwa1n
 ZntNT
X-Gm-Gg: AeBDievj4vVdzBQQJJVSYqmWhGR/vnGGgrzlT1Zfk5gTps6Vv0Nff4hJDSZ2nKb0PH/
 xOIQTT2zBUS4NDy3CykbaBjyrKIOceMg0CMPmigWGC7uyiG/pDSTzPRBui5fBi7gPuJKBabhVTl
 D95sVXNPh7zfB8T+9JynFOa3p9PlwDCoi3D0Tc769TtsovLbhf6gH4+bDLMroWn2bgDvHhKCLDs
 CjRc1BpohutbtNQ4LO6FDKXHJhcmZyy0GqzZ8wYVnSSgS+qH5e12fP83TC3ixIFjDR3dD5jC82d
 bEYGUnFbUeHOkP2IUI4JldLOmwoSrJFMWwvyRv2Q0HtGiPRe8GlVt7IAi1F0vyy60HIZXjyhzJP
 T8sfdTEfDau4qZq/DRMRRYcOdd7i4IisP2yAyB6mNSufR6cZTLl30tttrNYr3HmZgQwPEwiZCMr
 UIjqqIujrUFrPkCWQoE+FPTl9TfD4wdWpHhgEcv9gPydh7cGXnkz7FaMysC8XErHigsdecE4s5c
 ZlVIYDiISVV5kKw
X-Received: by 2002:a05:600c:a118:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-48e51f37363mr110562675e9.17.1778169126630; 
 Thu, 07 May 2026 08:52:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/67] hw/intc/arm_gicv5: Implement gicv5_class_name()
Date: Thu,  7 May 2026 16:50:59 +0100
Message-ID: <20260507155154.1886557-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Implement a gicv5_class_name() function that does the same job as
gicv3_class_name(): allows board code to get the correct QOM type for
the GIC at runtime depending on whether KVM is enabled or not.

For the GICv5, we don't yet implement KVM support, so the KVM-enabled
codepath is always an error.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-13-peter.maydell@linaro.org
---
 include/hw/intc/arm_gicv5_common.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 233233bc3e..e7220b9dc7 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -13,6 +13,8 @@
 #include "hw/core/sysbus.h"
 #include "hw/intc/arm_gicv5_types.h"
 #include "target/arm/cpu-qom.h"
+#include "qemu/error-report.h"
+#include "system/kvm.h"
 
 /*
  * QEMU interface:
@@ -150,4 +152,22 @@ static inline bool gicv5_domain_implemented(GICv5Common *cs, GICv5Domain domain)
     return cs->implemented_domains & (1 << domain);
 }
 
+/**
+ * gicv5_class_name
+ *
+ * Return name of GICv5 class to use depending on whether KVM acceleration is
+ * in use. May throw an error if the chosen implementation is not available.
+ *
+ * Returns: class name to use
+ */
+static inline const char *gicv5_class_name(void)
+{
+    /* When we implement KVM GICv5 we might return "kvm-arm-gicv5" here. */
+    if (kvm_enabled()) {
+        error_report("Userspace GICv5 is not supported with KVM");
+        exit(1);
+    }
+    return "arm-gicv5";
+}
+
 #endif
-- 
2.43.0


