Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3D3C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru81o-0007Km-3D; Tue, 09 Apr 2024 05:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru81l-0007KJ-Rf
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:44:29 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru81k-0007Bz-1K
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:44:29 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a51fc011e8fso42978366b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 02:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712655865; x=1713260665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ONk2ACysYoOUtOHX8ADC/l99dOcxUlQsrwtm1giLSQ=;
 b=aGvWtyZeOmKsZp+Wg9YkYD4MnXwbl1zYsEjAll/O+QeQATwH66SH/5419eLwIYTNVu
 0Fks7v6sXYucm++G85EKX5TWmTZ5U3wBkGGNp79ReL7PrzKj7tP2pXyP+DoAzwh7AuaA
 Yl89MmfErgUelwRgmbPJhRFgEEQICqRRJZK/4QQSLr61fQLu0Y2Xz5IA0na/LaiQRjcl
 TzIR2ySOmOCxaF6qiGa31yN8s+f4Ns6LzN7UUGK1I8kpsnKkAGTFwEZo46Yd7Jdfhbcd
 +4QsU1Gs5bgLYrTX1aFOmoOk8fXXEPPge6R+avMd8WPX15xW68bRy4M7o6M7bfXalcCh
 RjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712655865; x=1713260665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ONk2ACysYoOUtOHX8ADC/l99dOcxUlQsrwtm1giLSQ=;
 b=CT7/Qa3VUT+zd8qj3u0erKVyQW5ioagNuTjsKTeo6SucGPWNQqHGY6Ht++S1yBRirj
 3TdygMCsKn0xjlxKpTzFexmWD3wQ933kBzEr7yxiMbo+vGlCTmlB0lUQuL934VcJuYLv
 ZvEJkULySkw3jYeAoNaT+Re65rIGzDEfy2aJwSXqG+uj4a10dVcgP67y9Tq5qrUsHLqq
 Erxm21CZc676F5m+i+cdyPsuXLHMC2jS3thze1/yvD3YNbemAFFQeGRpUA3eM05TQ7MI
 59xBLtyA2HxjyBGl1Zo892nZNn1nOlc24pYa3MFsxC6AxPC1rGDjfS8OHAfW5OiIR7nA
 v2Xw==
X-Gm-Message-State: AOJu0Yzkbdimm14y6dTjB7RagVEbJe8dc+Fqc1NTUCzEPqbanc0HeVRN
 0LrOIQtzRd/pZu/hJzFMlhKMnkq23FgVEt+PY5wSS+A+DSPWufGPOWhwBLSteF4=
X-Google-Smtp-Source: AGHT+IGZfPvlPJRZlagZSOTs/xF7lV9XQAQsy4QE6TI+wQ0gNwVB4rs05cinSYkwKQjn4dD5/4aaKQ==
X-Received: by 2002:a17:907:970e:b0:a4f:c80c:1b69 with SMTP id
 jg14-20020a170907970e00b00a4fc80c1b69mr9958733ejc.8.1712655865310; 
 Tue, 09 Apr 2024 02:44:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a1709063c4300b00a51fa9f6d92sm465380ejg.38.2024.04.09.02.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 02:44:24 -0700 (PDT)
Message-ID: <384195db-6aab-4da0-80ea-d1c925904d14@linaro.org>
Date: Tue, 9 Apr 2024 11:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1 3/4] hw/i2c: Convert to spec v7 terminology
 (automatically)
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240408213339.83149-1-philmd@linaro.org>
 <20240408213339.83149-4-philmd@linaro.org>
 <CABgObfaRtv3WwhYzUKSCpee3UQFuwAzUEstX0uFGdRFOV6j4_Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfaRtv3WwhYzUKSCpee3UQFuwAzUEstX0uFGdRFOV6j4_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 9/4/24 10:58, Paolo Bonzini wrote:
> 
> 
> Il lun 8 apr 2024, 23:34 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     Note, the QOM type definition is not modified, TYPE_I2C_TARGET
>     remains defined as "i2c-slave".
> 
> 
> Is this actually necessary? The only thing that could break is -global 
> but I don't think it matters really.

I remembered some discussion with Gerd where he mentioned we can not
rename a QOM type because it is a stable interface (-device TYPE),
but here I missed the type is abstract, so not user-creatable, thus
it is safe to rename.

Consider the following hunk squashed:

-- >8 --
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index abefee78fd..8908267c17 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -24 +24 @@ typedef struct I2CNodeList I2CNodeList;
-#define TYPE_I2C_TARGET "i2c-slave"
+#define TYPE_I2C_TARGET "i2c-target"
---

> 
> Paolo
> 
> 
>     [*]
>     https://github.com/conscious-lang/conscious-lang-docs/blob/main/faq.md <https://github.com/conscious-lang/conscious-lang-docs/blob/main/faq.md>
> 
>     Inspired-by: Wolfram Sang <wsa+renesas@sang-engineering.com
>     <mailto:wsa%2Brenesas@sang-engineering.com>>
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
>     ---
>       include/hw/display/i2c-ddc.h     |   2 +-
>       include/hw/gpio/pca9552.h        |   2 +-
>       include/hw/gpio/pca9554.h        |   2 +-
>       include/hw/i2c/aspeed_i2c.h      |   4 +-
>       include/hw/i2c/i2c.h             |  66 ++++-----
>       include/hw/i2c/i2c_mux_pca954x.h |   2 +-
>       include/hw/i2c/smbus_slave.h     |   4 +-
>       include/hw/nvram/eeprom_at24c.h  |   4 +-
>       include/hw/sensor/tmp105.h       |   2 +-
>       hw/arm/aspeed.c                  | 232 +++++++++++++++----------------
>       hw/arm/bananapi_m2u.c            |   2 +-
>       hw/arm/cubieboard.c              |   2 +-
>       hw/arm/musicpal.c                |   6 +-
>       hw/arm/npcm7xx_boards.c          |  44 +++---
>       hw/arm/nseries.c                 |   6 +-
>       hw/arm/pxa2xx.c                  |  36 ++---
>       hw/arm/realview.c                |   2 +-
>       hw/arm/spitz.c                   |  12 +-
>       hw/arm/stellaris.c               |   2 +-
>       hw/arm/tosa.c                    |  14 +-
>       hw/arm/versatilepb.c             |   2 +-
>       hw/arm/vexpress.c                |   2 +-
>       hw/arm/z2.c                      |  20 +--
>       hw/audio/wm8750.c                |  18 +--
>       hw/display/ati.c                 |   4 +-
>       hw/display/i2c-ddc.c             |  10 +-
>       hw/display/sii9022.c             |  16 +--
>       hw/display/sm501.c               |   2 +-
>       hw/display/ssd0303.c             |  14 +-
>       hw/display/xlnx_dp.c             |   2 +-
>       hw/gpio/max7310.c                |  14 +-
>       hw/gpio/pca9552.c                |  14 +-
>       hw/gpio/pca9554.c                |  14 +-
>       hw/gpio/pcf8574.c                |  12 +-
>       hw/i2c/aspeed_i2c.c              |  16 +--
>       hw/i2c/core.c                    |  88 ++++++------
>       hw/i2c/i2c_mux_pca954x.c         |   6 +-
>       hw/i2c/imx_i2c.c                 |   2 +-
>       hw/i2c/smbus_slave.c             |  12 +-
>       hw/input/lm832x.c                |  14 +-
>       hw/misc/axp2xx.c                 |  14 +-
>       hw/misc/i2c-echo.c               |  14 +-
>       hw/nvram/eeprom_at24c.c          |  22 +--
>       hw/ppc/e500.c                    |   2 +-
>       hw/ppc/pnv.c                     |   4 +-
>       hw/ppc/sam460ex.c                |   2 +-
>       hw/rtc/ds1338.c                  |  14 +-
>       hw/rtc/m41t80.c                  |  12 +-
>       hw/rtc/twl92230.c                |  16 +--
>       hw/sensor/dps310.c               |  14 +-
>       hw/sensor/emc141x.c              |  16 +--
>       hw/sensor/lsm303dlhc_mag.c       |  16 +--
>       hw/sensor/tmp105.c               |  16 +--
>       hw/sensor/tmp421.c               |  20 +--
>       hw/tpm/tpm_tis_i2c.c             |  12 +-
>       55 files changed, 461 insertions(+), 461 deletions(-)


