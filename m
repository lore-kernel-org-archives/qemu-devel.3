Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B4AC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv55-0000uu-2j; Tue, 13 Feb 2024 10:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZv53-0000nV-94
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:52:21 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZv51-0005hP-Cs
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:52:21 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-411c2f76308so4879415e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707839537; x=1708444337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xSsYQg4U6OTgmMC3iEdz8zOlXRVYqFoVVBPQrIMDRro=;
 b=tUNaMDNPZsIbcjKrGQqO5Y1qFPeVBf83uqj4zRrjgaCX/gaJun0a3IPduwUcrxAFcn
 bcQuBowVLOxEbxYHycuP1AHlgLE/UQ7FkmVVgaYGle+nN4rQxNRKtnS2k659XbqZ6sYM
 L/uloQjoW96XKmZyCu2BidNLUPWjRCybgu8jCZow8A6F53Nxs8mGfJmFhCa8vSBef/0k
 Nk2GD45PrnlrJSbVFNDgShr/E86nzecPG1eDfGC+57L9cy/0N/P7yXauY8K7pOEZjpDx
 PltIkFAnOQBzS8judj9RgUWDoJbktM24OSqNRUUCbzMVq9K2jqcvbgJIz04TrOtl58Vv
 R/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839537; x=1708444337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xSsYQg4U6OTgmMC3iEdz8zOlXRVYqFoVVBPQrIMDRro=;
 b=BzS6Jr8uOXrXaZ47QlKnQqWy+dDe3FzBonzcUiG8wOeTZUarmD41hXsDXf9AGY9TW5
 ZD8J7YbtT8imrkkXpCHfEj/cI1pB20uhv2MDAz8EWy+8gGgoM5Oj13lhWmvmjv+M8URt
 BAyIBD3JtBWfW12c8l8fvj6YkaxaHYcHvaQWsFjbYe2+3gxQwj15qPQrgRucAJQd8hHD
 RMQhaHEP+fZ3Dx11qmV4YkkZyeQbaTEwJqtJ8nIsUppI/6OWTpQsRYP5MGFGBBvMxkCk
 1jRvD5PrdH38SDOW4xH5BvqbdCiRxmsduQUZJUkCP7uQNy8KLIVhTW+iEmXllOfVtgwO
 yP9g==
X-Gm-Message-State: AOJu0YxQqfEN7rNuswucsllQyfynrX12DwwMjeBOrNOtCWMyLyEx6QuX
 73pmM7ARpS+tqD4RxbS/2lafIb3uLqf9+ZlrgODGH2NYbaoP+LoY6J78NO38yc/+LBc3jNBvlrr
 z
X-Google-Smtp-Source: AGHT+IFOE/362rT3tFPkAEif8VQ8x448o5mjliuJFm1o2cKSv0iocQHM2FhKSctOhWPrlTM3n0X6qw==
X-Received: by 2002:a5d:5988:0:b0:33a:f689:1bf7 with SMTP id
 n8-20020a5d5988000000b0033af6891bf7mr9251095wri.48.1707839537468; 
 Tue, 13 Feb 2024 07:52:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXAG/VlkQjB9+ZR9V8U5bDEGjdaOL4GoCAFLfu+3iPA2uZzEGKuBIyg+8+VglZmEfUv6NrBWekiuT9/KOwV/DsugwlbGYOhCUELH5zmHRPlacdt9jfVrLUBpgdXxMdNipxE6iUdpRlTee/kfQapznE61A==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 m41-20020a05600c3b2900b00411d0b58056sm766181wms.5.2024.02.13.07.52.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 07:52:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] hw/arm/stellaris: QOM/QDev cleanups
Date: Tue, 13 Feb 2024 16:52:10 +0100
Message-ID: <20240213155214.13619-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v1:
- Rebased
- Split I2C reset as enter/hold/exit (Peter)
- Added R-b tags

Gustavo wants to access the QOM path of an input IRQ line
from the NVIC, but since the device is orphan he ends up
with this nasty path [*]:

  -device ivshmem-flat,chardev=ivshmem_flat,x-irq-qompath='/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]',x-bus-qompath='/sysbus'

Add the missing parent so the tree is now:

(qemu) info qom-tree
/machine (lm3s6965evb-machine)
  /gamepad (stellaris-gamepad)
  /oled (ssd0323)
  /peripheral (container)
  /peripheral-anon (container)
  /soc (container)
    /v7m (armv7m)
      /cpu (cortex-m3-arm-cpu)
        /unnamed-gpio-in[0] (irq)
        /unnamed-gpio-in[1] (irq)
        /unnamed-gpio-in[2] (irq)
        /unnamed-gpio-in[3] (irq)
      /cpuclk (clock)
      /nvic (armv7m_nvic)
        /NMI[0] (irq)
        /nvic_sysregs[0] (memory-region)
        /systick-trigger[0] (irq)
        /systick-trigger[1] (irq)
        /unnamed-gpio-in[0] (irq)
        ...

[*] https://lore.kernel.org/qemu-devel/20231127052024.435743-1-gustavo.romero@linaro.org/

Philippe Mathieu-Daudé (4):
  hw/arm/stellaris: Convert ADC controller to Resettable interface
  hw/arm/stellaris: Convert I2C controller to Resettable interface
  hw/arm/stellaris: Add missing QOM 'machine' parent
  hw/arm/stellaris: Add missing QOM 'SoC' parent

 hw/arm/stellaris.c | 47 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

-- 
2.41.0


