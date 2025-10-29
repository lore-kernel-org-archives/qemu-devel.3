Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0F1CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEEBx-0003Nu-K7; Wed, 29 Oct 2025 17:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEBv-0003Ma-O7
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:58:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEBp-0008R2-6D
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:58:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so184123f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761775117; x=1762379917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eEsVHqOoEuKegp85lNFkyrHkW4OqV5ZQ6TYlgOCxUk=;
 b=wk+7dI9AflIhul4ws4z+mQ/xvnsrzoiAvIaIPkCMaTjBL0K1pAv0Ryakxsd+wp2n20
 bycZjWRW6qK6Lt0bx01Mt3ljBcXYwbfC+w04n2LEawbPF9uqYfINRzohqVS/uxee/agx
 QsUXJAGgBwzfWrExmN6edDWpxgQiqqvGdRhYRtvC/hRWaDxqxEtV9WeQX/XC7bO6NYSb
 U7Zt4DUpJvtmYU3QY2l4wUmDz/b5C8WmH6xHD7vH0Y6Wtz8nUIX6Y+KV5bgLMphmPakQ
 yIVDrGQmOAbIXDs83kPvpCfcPuAr5SNJ6/TPnTm4CqRbZ7C5HdouZGd0+dIgweTSJVD+
 wjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761775117; x=1762379917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8eEsVHqOoEuKegp85lNFkyrHkW4OqV5ZQ6TYlgOCxUk=;
 b=ry/Vry0e7cR44RUCZmM97gxZmkQRs5wuElk2bspJIrFoJYIC/O7eUdo16CgzHatIrE
 8X0ZsKrGXAIICUDqcFW6bUZ7XU280xXObWDk/Xs7vyls1T7t9bRgefpsrr6ABNrWDtMg
 T0T8GPovLF7UsrmYOhoGUGywjMK9cxeqOzfot16sEsXJU+R/pM/hbuN1jsVhSrw3CXPE
 NgyeU/l0fchS9c98neWVS6uEPl9HafChRoZK7htrF1P0392JSZ4ZAstJSSpwBvUMgkdk
 F7fIH2WmU0mfNCDYJtlB7FciaN30U6gch9jCm8DY3XZkZB1btajULa1+LNWByRmISYFE
 Uhlw==
X-Gm-Message-State: AOJu0YzzortvDsKlTDqrysTLoESAJ5p6vl3KJs2CoSnatB4KJgIfdLCK
 hI0A6EzT84QLCEg0QlDZSp6IPVSgP2cDfm9caENJ6ScdCGXuoSjLgBZGJr2q0cKNXIob2Rv+UHQ
 ZAmlXd1s=
X-Gm-Gg: ASbGnctNZCiQL2nf4DtHmR1oRrcCNYdXPxvkOT3OHAj8GsXSsLa8e7XDp/g9H7UjveK
 ljy31AWbjz43/Y8OfOOhGVeFl8CJFfbLKHK7D5fH9GWIM7G7V55x6YEyj31Tmpe/vlvKnOVCIuF
 Db+gfi4wSqGDfNWGI4/Z5WiAehNBHT3sMesS6Bga1CREtfcBGz1TKblwsb/nUCNLtWcfkhT5AGx
 2RlWiPnu/xsV2hwm2t0kd84lAoF2ZpqE0Q2/H1H0869Q/M3bu21Uv7gN1S926v9GKrjnHgaJQgF
 yf43x3p9BXVEy3BNdl49cL+rddrtDsML/mxO61XI52xPkGRSaI6tNC/C+XOucork1uDCw/sPwty
 l05mseNnKljU6DdL4pAxw8gmH1+N1GMNcwSX9S8qX2TTVjm3+cPncBgzgbz4E8Myb4jmYboy8Jq
 8UhTL8wdJp5HS+oHRZJnEIvP157rSvJGNs7dHrPAYcs+q/HgMXUg==
X-Google-Smtp-Source: AGHT+IHvf5gvu7jx1uWaoX2MnBF4KCAmPXv641va880tko1rx7Oxwfevik5Rr3U1uF0aOyIOIF9BTg==
X-Received: by 2002:a05:6000:186d:b0:426:d57a:da9d with SMTP id
 ffacd0b85a97d-429aefda908mr3827502f8f.59.1761775117017; 
 Wed, 29 Oct 2025 14:58:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b43sm28667863f8f.6.2025.10.29.14.58.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:58:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 18/23] hw/arm/virt: Build only once
Date: Wed, 29 Oct 2025 22:39:55 +0100
Message-ID: <20251029214001.99824-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Previous commits removed the TARGET_AARCH64 uses in virt.c,
we can now move it to arm_common_ss[] and build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021210934.60483-1-philmd@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index df4c1be3b3b..9fbbbc9a6fe 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,6 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
-arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
-- 
2.51.0


