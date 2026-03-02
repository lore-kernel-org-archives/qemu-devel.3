Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1A0C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzU4-0001IT-NM; Mon, 02 Mar 2026 04:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzU1-0001G4-So
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzU0-0007fl-D9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:33 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so34038435e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 01:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772443351; x=1773048151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrSDkpRuA4wc4OTpcBM2xlfnE+hqoQxnobPtJeyezk4=;
 b=kBojzAfv68NBqTaHsmVq607+IaF90hj+cRZ9P5clKDbC7Nr9qyIGDUp8zQLygXrqLr
 LpSCzt36gBo6+tPCwfrYNrk1bMfyp7S1ciJzvJq2YwdP948HkQ52MlxiNi5Dviv+r1pA
 MGpM9ntclLrkJu+VD2QmuszdQlEXBZAhfLg4xO6R3JkW7fG8U3KA22m6gIcygvkCd22b
 EJES07VDDF88sAyOtJLrV2dL1fPvrwSPUim0ugLpmPNIaPBK+I+W0lTzFCx8qXlD+XU9
 RnhLdzIfyf+MWvfXX9OluJTthkQfho7kKeGcLPuh7C6UhNi3m8rp7HCLxoirZ6P0ZeD1
 mQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772443351; x=1773048151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JrSDkpRuA4wc4OTpcBM2xlfnE+hqoQxnobPtJeyezk4=;
 b=qUhCK/YKFjq1i7ds1bzCESpjGXMLuiAbRgo44+td+ZnlIFmrgc/vKiBo5F48e/blJM
 TiYBx4ETPhgEK84NSBi4jLiJDSk/xIWHU0zjEW1pxiQDKXrRI1yutwOFyQ8f4T2ngt5y
 iqvPFR5r1Sj3SbAbJwS0cMljP6VhADZIvDjadT+X22q+Gmo88pzkgJjH/vgboi1ZggFP
 CzToqKRcqoLeQUbCjvdp4dDu6kfrAroaTFe7Wb5HYvKUdThemW3tt9pB9JXS28aTKixk
 HsyAtybJ2ZHcLGb8MHRRAMvZEn2FTcomyI5rfKvvq+yYmlap2vlk7R+hMwkibC1FSeCE
 XDYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDO/E/mg14KqoLdUvQm9yy8/ctf/QnHJf/Gd/hwC+ho1aE5uRltnYIAQ/jQ2/Jn/uoNc1qerIceG2c@nongnu.org
X-Gm-Message-State: AOJu0Yw8snWfKYIwEHhub1ZTyBI0oEV6FDWlpCwk5SW18Dl9+tgMkiQz
 GR+ljBHpWWO++rS74jIrNkX2ae20ZaBd2xVWXianifVAQne8lUbsYFjYqu66hYMc5XA=
X-Gm-Gg: ATEYQzzgFPveA4hNL1F46HFldzGh1ZOZobFRSZjOqzzp8GJ00/koJocsC3vrlYSddKh
 2E8Ple6KK3evaeH3KzEfidpvXY9IGcIMJw5Ac4tLyyrfTPqXN5MovId88VPhLGPcaBWX5HI0oDK
 Vrcz5GUdGl3VCO0MHYMJ8aPAEJKFoEKj7UBa3xo4fC5WsdvSJR8UumcRGKwmNLi04OPAFN/GHAY
 NCTWB+PMBDNcl/RzQ7Uoi9sh+WaUr+rX9eK4bmGCMxvRRFbsZ+7FK0SfR/8f32xyZPy6alD3WcY
 kOz9GiimarOwUGp/eO1H0BOdSGcPwJ5J+UQnBipcF/HtaLVUwxph6QkjNFe2drUGzcKHOo8LEMy
 9K0nMEdld3lNzFibetoGUdQEvpX5cIAQ0kxAc1SNcilOOCJGQOlmlAEaiWGXbU2RDHrZrkA6AKb
 pwkcgib1K1MnMCFHuVCUxc1WELkmaNU5QtB5rAGRBcuT9Za9WSS/srjaUyOvTcgiubaMCmMFgH7
 bdlo7/4HEwmHj88DsgYqCn2JdmUZhByKNJGFBfyzg==
X-Received: by 2002:a05:600c:c174:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-483c9c0bcdamr202694715e9.35.1772443350535; 
 Mon, 02 Mar 2026 01:22:30 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb9d9c6sm129435305e9.14.2026.03.02.01.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 01:22:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 3/9] hw/arm/aspeed_gpio: Don't leak string in
 aspeed_gpio_init()
Date: Mon,  2 Mar 2026 09:22:19 +0000
Message-ID: <20260302092225.4088227-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302092225.4088227-1-peter.maydell@linaro.org>
References: <20260302092225.4088227-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We allocate the string for the GPIO property name, but never free it.
Use g_autofree to avoid this.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/aspeed_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index d9237d4360..7d0f87e90c 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -1488,7 +1488,7 @@ static void aspeed_gpio_init(Object *obj)
     }
 
     for (int i = 0; i < agc->nr_gpio_sets; i++) {
-        char *name = g_strdup_printf("gpio-set[%d]", i);
+        g_autofree char *name = g_strdup_printf("gpio-set[%d]", i);
         object_property_add(obj, name, "uint32", aspeed_gpio_get_set,
         aspeed_gpio_set_set, NULL, NULL);
     }
-- 
2.43.0


