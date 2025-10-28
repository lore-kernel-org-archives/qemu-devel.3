Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AB8CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeW3-0003mJ-Tb; Tue, 28 Oct 2025 03:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeVg-0003f6-MS
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:52:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeVc-0007fV-0D
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:52:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso3274582f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637963; x=1762242763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qetPs5lSPgCgvhVMykRD8ni1yPZazQy3tqwaS7dIqw=;
 b=oJuPf9MFIvyjeEAMaf4nFnReIQTtNSSkWQXYeSekcH5zBsUW/JH3RR6TzxsDsMAmUL
 1FiqNbRSLl9vk8s7BHNTmbZ3b7pkaRyrdobAIQEzXFapo/z1eOQhts2fOE2saxbwnCEE
 pdCtPZb7ju1bUPQKTEjNPJvnsmxbj8039hy9pQ+xgVvlSNEoN2wywkuBJ/YGEAkEndyv
 2xcgtvURvrp4w5o7cE1nUBlXBG93NzYC9rx/tQo1SstvgIkmVcBPCZOOO1V/WBy8U1g2
 3GGxg21xEv2qbxhdaLpw9wL23/Ewpq321HY+oK4RkaGN53xco3L/JlsSn3hlGkOeHdoa
 Rz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637963; x=1762242763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qetPs5lSPgCgvhVMykRD8ni1yPZazQy3tqwaS7dIqw=;
 b=QnDpNT9txYAKUjRjqzVLx5ySap5DgziWzEqbS/5B/nCQ8R8oWogUoutIxA6N/hxslm
 aY6+iMZGdUMW27lLHBNcmnnJoavcFCuwRXFxCHtsca32NXgyWwhupYrRDNvsELCPrORk
 +qyZuV6Tms3zGCgmlGfVdBS+frfdMrijsY1ehDMK3FsdZigFiYQ7SrfhG1TtShjoNfIG
 q3oa7vjUabLC7B8ielIy9fRiJyWvGEbzsYibhVoyB7cBgSWOYeEF5g0J/wvIcDqYwLq3
 +jLslpy0G3Mlmo1SDxY7BZcXUDrjubBd6qcw69PF/yB9kPN+fU8q0BDG8kdYbg/VGHHZ
 W5FQ==
X-Gm-Message-State: AOJu0Yx0OK5W+TULBli1yQZjSAGCdZKaemQbQdaUyRgdx85aTUOczUCQ
 z3kPeaoG+4ZbxLo9Kgz35VUBUnr+uMvJ781P3u7jkaLK88dH0WeLKCKwkxleMxrQRA2KgCfgZcm
 OyW/eJyc=
X-Gm-Gg: ASbGnctAYuWcgWf9TKq+gHz/Sjk3u7Q8LmTkiGTiVLehIoeiObY+HJiBQoD8Lr8bvpC
 gX0GNSK0URIBbAxryFx5Stbzeu/GwMDvnjXQp+MsvFsSN0b/wB0L9WwE5FPEMuPiWEOej3yESOw
 Dvcvi9NtAF+RbWxwb1bFRMpu/eLLZxGy2ed+I7yDk2fW0cpDXVfHe2pKL59OoRuZDDFWihhKJ5K
 DwCGPiD2V5my7bjsvdMOfqvCZuqUXCQ6DZ7/IIRZQrYM4SL8tqr08zpKGY4YiaJfbESXiddoW3G
 ZVt0n+A4yC/y/EZsesowUoEz2wKxjf8v7W0n6HtX5LwesxKaKZigmJ6Eix5EnWM4XFlnP+yYWvs
 FTywYXUS63NWTWb/vnMCjzjaieHdP/mth5AChSAQgzWzuYYU3yyeIIWMCEx3EysIYPQDu42AqXf
 3dqRAlA8X2CUnzRvahg8WNkLda62+zmT7YbwNYK151PgKCZkjIWj5URqg=
X-Google-Smtp-Source: AGHT+IHrZKKvda/FZnIVCQLcv0ZzZHA9d2UpJJYXqH7IE3Qy6/XvxddK236sfn2QVUIuwKcOrYf2LQ==
X-Received: by 2002:a05:600c:4686:b0:471:15bb:ad7b with SMTP id
 5b1f17b1804b1-47717deeb8cmr22743985e9.6.1761637962776; 
 Tue, 28 Oct 2025 00:52:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4cc596sm184295305e9.15.2025.10.28.00.52.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:52:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 10/23] hw/qdev: Have qdev_get_gpio_out_connector() take const
 DeviceState arg
Date: Tue, 28 Oct 2025 08:48:46 +0100
Message-ID: <20251028074901.22062-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

This getter doesn't update any DeviceState internal fields,
make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20251024190416.8803-2-philmd@linaro.org>
---
 include/hw/qdev-core.h | 3 ++-
 hw/core/gpio.c         | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a7bfb10dc70..2caa0cbd26f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -725,7 +725,8 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
  *
  * Return: qemu_irq associated with GPIO or NULL if un-wired.
  */
-qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n);
+qemu_irq qdev_get_gpio_out_connector(const DeviceState *dev,
+                                     const char *name, int n);
 
 /**
  * qdev_intercept_gpio_out: Intercept an existing GPIO connection
diff --git a/hw/core/gpio.c b/hw/core/gpio.c
index 6e32a8eec61..c7c2936fc55 100644
--- a/hw/core/gpio.c
+++ b/hw/core/gpio.c
@@ -129,7 +129,8 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
     g_free(propname);
 }
 
-qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n)
+qemu_irq qdev_get_gpio_out_connector(const DeviceState *dev,
+                                     const char *name, int n)
 {
     g_autofree char *propname = g_strdup_printf("%s[%d]",
                                      name ? name : "unnamed-gpio-out", n);
-- 
2.51.0


