Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A218FCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWet-0004CW-RK; Fri, 06 Mar 2026 10:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWes-0004Az-IL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:06 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeq-0002WP-Sn
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:06 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso121936085e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809203; x=1773414003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=URmUpxDAKxkZF/tpctzfZNZZvCGQY0Hg4ZEcA6KURzU=;
 b=bX2uHWddwPw+QZGpFhbSuxbjazNCIQiVupdW+cB8Fi8EtYAtK9GajKcrDepXAaIrAR
 AafCONbR605HtH5zaWwQsLNxxPhc2lM4EnHyokgOHxAKd3Qpm0hSwqbYvYb9CqRbLdYt
 CYVNb01hdq7XYAU+bVhJig/co7tCya2R9v4I0UBWfYByP2nQ2pNb8SZeMzPe5FUmlTb1
 DqrZx2FciO5a6oGTbVg65AKnPU9dydiCTkh4nJWzhiQyGl4oe8yz/5xiMPMdMXsUo4xy
 PU4rP5iOj1gWnQc0/ErjVhL+HG1d/fwL20IArfUwX0r1ADNZqvdwnJVVu5GbdtI4Oosm
 rPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809203; x=1773414003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=URmUpxDAKxkZF/tpctzfZNZZvCGQY0Hg4ZEcA6KURzU=;
 b=Rif761tipWr/AWCQF1biTyDU2fZnce0fjZPit7Ug16PhqnipR2C94Im58DqKUnyS3+
 hbXh7PQPaz4NouvytV5rhvszN/fo7PPR0G5b7GgwsmhLntxvx5EMvVaNZQA7C7Oz6kC6
 jtmCaRSmjM/qoEEfp4oZSNgJE0hKHr0r7lKhHoQ8/4HWRkYwDXsTd7M8kbqr9xZfvIdZ
 YGIapUorPjUguP6kA5MpXAQ5SOuZ3/poNV/9uOartELcrqO3Jx0UFMTnGFONnLeZupQk
 cnX4OeWiDa7QpkIpf+xj0Wu8JKMcCcHI4EqxHuORUasowOTDwkhBr2K13nMd0WAHnmom
 7e8Q==
X-Gm-Message-State: AOJu0YyJVaZq68ommaix9YEOuMgJDwDIUI1L3rBNQv/XsajgVqbIBBiG
 PWV8M7XSEPr5xP4NXSIrljWqaFWB4AmO0l/AlCOm1h8VoTy7djvnRATm67x+RRtJqAVuDtRbrTb
 /3sjt
X-Gm-Gg: ATEYQzzwODXhzbizj875ZVMw9c0/9+7fSELhRZSXr5nbKzoHgKgQgzW9X+IKh38Yg5E
 qcEWCu5KRZ3Xa744t00UTdO4SOUY9QjSxDgd44Qx35RzHK/BVpFsIVGC/V4xtcu91tQvgwYlyST
 gRANPnXeR/ld5JjDRGzYwvySnuTszqPXZzwqe/plgubDO87ybCiTfglLBmFHrzLNjvYUHo0xila
 kcztcvAEQaHC05rqNCo5ZZAodrWJtjecEwAu5xnpuTwsI2/nwbunTTtj1yEw1ICzOLt9PFRrlA/
 LdEXo6bvxCPcAQwqr/lj/aXTRxn3+i+pr1W2EM6gujRMhAYxK7N2KvyZz8/6fsywVAe/d4yt5hv
 BhXjyNBf3e+MPUc10VaFvqXWqrxNTJotT8hwkmIFYv9kCE/7h5bWiZTFRVy6g8CXl7GYGJVIuNP
 lvaTiG+lFnyzyJJ67doPtTYB39X49PUOCZp8uhMcZxiM38k5e+DJcmzOWuaO8tmD85Sh4Bh/mdB
 Sem9c9e+qGgypIwT7SJ4x9whDAZLQY=
X-Received: by 2002:a05:600c:1e86:b0:483:5310:dc67 with SMTP id
 5b1f17b1804b1-4852695b81cmr36947285e9.20.1772809203096; 
 Fri, 06 Mar 2026 07:00:03 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/49] hw/arm/aspeed_gpio: Don't leak string in
 aspeed_gpio_init()
Date: Fri,  6 Mar 2026 14:59:13 +0000
Message-ID: <20260306145939.2162189-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

We allocate the string for the GPIO property name, but never free it.
Use g_autofree to avoid this.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260302092225.4088227-4-peter.maydell@linaro.org
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


