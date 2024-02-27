Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB575C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret0s-0006Kc-GF; Tue, 27 Feb 2024 03:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret0q-0006Gz-Lk
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:32 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret0m-0007m2-Lj
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:32 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412a390347dso15440125e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023226; x=1709628026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsQjpNWm982u5XBOq7wYo0dWEjdVwmwHsexBrMcBwNc=;
 b=Rvjr6+DU3dQC41Ae7eoHfoWyzEnJRjAp/YYZ3SbM/fUnZ3nyCG4GO/L4JiRL/XzM/S
 JG5mC4wmdYCGc8sm8j2GOAzY7q8Jz6DzA/8bjSaDyhM8g78K8q6KWNfs5ojgsJAImMNN
 65HCK3pdkmoE6PcZVPOPgJRR5wGGWJJyu51VhUmHhbve6FGq2XCL7dajqFRPmXrTLlT3
 7ub+AP3Gv50xYZPnWVL+Q0SBQaS/YsjxxhXpmmJTgmzlUuI/EcqYtJfA/qJ7/uVXeEl/
 RRZmKkbYKGjDWpoVqecc4of/VFgcQ9qVA3kXHCX0H5EjXtCoev+jScNsjIvgPlJFGoEJ
 nRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023227; x=1709628027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsQjpNWm982u5XBOq7wYo0dWEjdVwmwHsexBrMcBwNc=;
 b=muDhs35AO7fQB7ersMjzrI+A/3RSC/oxaoqKMXb7mEyYzo1rNZ2hzxQCkxJHnMDvO+
 1kfNfKiO5+Kw7BS7OmsxDQk3OULbxP51WJ3bT5GfaH7v273yRSSg4nX9/lzIKH9LE9Kw
 RehFizC9rlXF6kyeRnlGJXPxFFdnUSwMEaEjHuS2AB7jd8k4RISz2SYhfwwbdQ8zFiBl
 nvdrNPwmrAiIlzTD8a/DtdtdzUd7m2UACOGwl0ODEiDK6/zJDLmkxp22SH1XFR3LL5hO
 INYGLSlQWoOTUcwkKhTmmH1vQpRVntxD1i5TROR+8+rNUEmSLscG6+7PXIbQJTFYe6sP
 3c/g==
X-Gm-Message-State: AOJu0Yx53OmLz3vUeezLBN482UCt14T2MoHRvpEXUZPh7DxWT5UKuz1T
 kSd/wnLSr4DUTs4Ph48Oayi2HXSS98xW3BhrptS6q8Zax+yv7YMLQGaAPama7/LZunnojFdPutO
 Z
X-Google-Smtp-Source: AGHT+IErJBBmx4zjFABE1Uqqw2nQRDhjrWUBL+1wOBFLgxhyGfVsFze/IcvH0x++arNzbU4bYe99Zw==
X-Received: by 2002:a05:600c:1546:b0:412:a2c7:9d13 with SMTP id
 f6-20020a05600c154600b00412a2c79d13mr4064489wmg.6.1709023226656; 
 Tue, 27 Feb 2024 00:40:26 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c444d00b0041294d015fbsm10703245wmn.40.2024.02.27.00.40.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:40:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 06/30] hw/sysbus: Remove now unused sysbus_address_space()
Date: Tue, 27 Feb 2024 09:39:22 +0100
Message-ID: <20240227083948.5427-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

sysbus_address_space() is not more used, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240216153517.49422-7-philmd@linaro.org>
---
 include/hw/sysbus.h | 1 -
 hw/core/sysbus.c    | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 14dbc22d0c..3cb29a480e 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -83,7 +83,6 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority);
 void sysbus_mmio_unmap(SysBusDevice *dev, int n);
-MemoryRegion *sysbus_address_space(SysBusDevice *dev);
 
 bool sysbus_realize(SysBusDevice *dev, Error **errp);
 bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp);
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 9f1d5b2d6d..ad34fb7344 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -298,11 +298,6 @@ static char *sysbus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(qdev_fw_name(dev));
 }
 
-MemoryRegion *sysbus_address_space(SysBusDevice *dev)
-{
-    return get_system_memory();
-}
-
 static void sysbus_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-- 
2.41.0


