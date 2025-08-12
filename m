Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07D9CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 15:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulrMM-0003am-8I; Tue, 12 Aug 2025 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ulrMG-0003aT-HB
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:56:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ulrM7-0007VQ-Cz
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:56:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2430926b53eso3181615ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755014161; x=1755618961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lu6vYlvzgZcFmF9V/g3X2T+BLyYHi3bpCviyyFwy4Tc=;
 b=hfIT+7jmGarAQ5FXquFUBtxQRtl+nR+y3wWWlVOlXHqfqL7BAWnK43JDsQNMBQ7Btz
 XRDtY4w3HM3cw7kb8TjYZWvGb53D/TKvnYeWIjaWO6K6zRGD/Bj9VhUOhN2n9Ih8bv2r
 AboybYeAL/2jL3BtUxD8+iL16WU9fNGX/51UMpXtu18pdv9DgIV09QtJHLPyVXEiXaQM
 3y0X3R0CVNjZK00LAOTon2d2NO9D/8Yt8ztxanbCoBbQvzXfbwHeRq7rAg6NLssjqZuC
 2Tx/Bt7C9c0cKMf/Z04jNNKldQctLdqZkaB1uKohcaWjxNiAqBaqWBG/DXTeJ2cJoeY7
 vHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755014161; x=1755618961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lu6vYlvzgZcFmF9V/g3X2T+BLyYHi3bpCviyyFwy4Tc=;
 b=un5E5+E7bz08AG9cY0lCcy0werQYoYyObr2Mhw1VYyxFlBRA4OodiAPquqcGi4OSO3
 44tGgwHL00BRmLtGBu+DCrSXr9Z/0sqNIMKCRE9kF5cEoMEAxq00pbbEq6IivnuSELKp
 V3XEBX5T+mXm0EfAxbnal5vDxTTPx+4SlpI4yjiyi5CWOyL83pXn8YxuXuu3zVqnUOVe
 mTRt+7u7HtvOhi/uHglRfRFqYF7LBs7QBOxGxQb8Flr7Vz17S29sbKSNjOJNUmqcOoRp
 wmCqCbgYKsFL0qzvdf6kU+n9Tzxx7/vRoumeC93Zpub/f5Vi0S5vpJDPccqDZx21KuzQ
 kaJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkCH7T0V080JArFgoyVihILtod/C4rbs30hhLLcjVZigMgugJf/uNcMUNUhd5OAOAeAhRcmd2KBw/i@nongnu.org
X-Gm-Message-State: AOJu0YwoEzf69A059Ln4DTxZqbiEOTMW9n+TNAA7gXUuniAUURV8Ch9R
 t92dSl9Fj1tid0EtqTXjLwHxkpV1WTWbyqz3G/sk3I2F8Phx65fAlSacHXSOUiAf3oW2brlO+01
 2IS0BGqc=
X-Gm-Gg: ASbGnctefXE+JAGnL7C86GnJkCAADR5RFYpfYeGb1EX9sGm6hQpMQ6g5DZIwosSP7NY
 zM7UfXbhrjjZyXGnKzmBSae0fhfePuJyHZTLAImZFLVn1je+0Ywm7GEl10gHyV7EAWlXsIBRgEY
 fFPa8Rgi801DKTx5UdX3G3QFcwpazYRJOPbDerJKsKW6p4Dy11/h4vzPQ63jDATPi1kshr4//P7
 a01NISrZ/lzgiGoG2lf2sGMV6Kp78sR26YjCzmIlBtKgYJp5j2Yxyg/n94da2EQXfrjRsEVZXKA
 Xi2YGcA71xQ9rSYjkc/EmrW3INS/vY7D1XxfCqLHl/4yeW8TZvY1i7YzUtprX7+WosSCTgSy/lo
 gCXundGQc1EzscOq3TyUWEmiBwpBoM5Z2lP0ymFolwEhSiw==
X-Google-Smtp-Source: AGHT+IG5DYLefrzZeEL434MS8l+fE6D9WJhpiFNdWClxXJTynd+0wwxZdA+jvxLU/rpFR9PvbFUwtQ==
X-Received: by 2002:a17:903:32cc:b0:240:a53:dd37 with SMTP id
 d9443c01a7336-2430c050be4mr3382545ad.21.1755014161483; 
 Tue, 12 Aug 2025 08:56:01 -0700 (PDT)
Received: from [192.168.0.102] ([152.250.234.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6e45sm301947105ad.22.2025.08.12.08.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 08:56:00 -0700 (PDT)
Message-ID: <88492bf4-f690-4429-98d7-c3293459db5b@linaro.org>
Date: Tue, 12 Aug 2025 12:57:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 RESEND RESEND v2 1/3] hw/sd/ssi-sd: Return noise
 (dummy byte) when no card connected
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
References: <20250812140415.70153-1-philmd@linaro.org>
 <20250812140415.70153-2-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250812140415.70153-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Phil,

On 8/12/25 11:04, Philippe Mathieu-Daudé wrote:
> Commit 1585ab9f1ba ("hw/sd/sdcard: Fill SPI response bits in card
> code") exposed a bug in the SPI adapter: if no SD card is plugged,
> we are returning "there is a card with an error". This is wrong,
> we shouldn't return any particular packet response, but the noise
> shifted on the MISO line. Return the dummy byte, otherwise we get:
> 
>    qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: Assertion `s->arglen > 0' failed.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/sd/ssi-sd.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 594dead19ee..3aacbd03871 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -89,6 +89,10 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
>       SDRequest request;
>       uint8_t longresp[5];
>   
> +    if (!sdbus_get_inserted(&s->sdbus)) {
> +        return SSI_DUMMY;
> +    }
> +
>       /*
>        * Special case: allow CMD12 (STOP TRANSMISSION) while reading data.
>        *

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

