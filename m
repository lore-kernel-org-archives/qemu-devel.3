Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701BEC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrKh-0001Ez-1i; Wed, 21 Feb 2024 13:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrKf-00019w-EW
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:28:37 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcrKd-0004Ss-Ra
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:28:37 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5643ae47cd3so5685674a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708540114; x=1709144914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MJM+r+s0wTNV2HO0+cw7G08B7u+MlVStAvZBZDGHhnc=;
 b=ZpMBZrpDpnHtWy1g6mfr95Uw86oKJMz2gsHRCnFPAaISbeAuUWfo1Gf1pSUkNW6vGR
 7c09E/gx8Xtr0fxVzzPPCCnC8NlSV+AzQdHMs6XOnJ4SGhDWC/FXf6diXzLMdEgihozA
 d6lfPXIO824TNzz6+8mpZNesPrbBDzL9HWs22keb1px1oRRCcWyt39JqERYCFbOZyju5
 yD4mS1WuWMvO/VQhRjePHpurW9sBd5Z8LysKDxFs5LonGrVDjen8keE5xx5Q+Ikygj8g
 +3WmI/XXYidi7IreyPgdr8FMM5GJjxhF9ImS7KaDqJ4uxO0+EkWnMVj2hwnSuhFPwK3X
 Alww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708540114; x=1709144914;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MJM+r+s0wTNV2HO0+cw7G08B7u+MlVStAvZBZDGHhnc=;
 b=plo9rAF2wYTydba3B71vHlbQ4YaLmyEy1lSPeF7sGdelbokWvBQZeaQqZJlB9Zp+vx
 ufvHCMRetDzYOE27HKfSdU7GP1ME2EakWlLeMPFC8nSz9mngOvpw4Ht2ogzyBp+Qh0NN
 aMAfZ/iowaMDQ5rrGAmvZpjXTQX82ns3IfwJFog+22s25/HJo5VAcJ3DyzC466vtdmSf
 7Z1ZFn6Lf2ASGTwO7oGCiJqJo1JxhqZF5Hd2cLEdHLlu9CqfknEY+f+oFTUKdP8Y8ryR
 UPGCTBQG8OQBX8go3wszhLKLk0psCX5WYJcV25+5keCbzJD8YHwtXVixH2aYdP5OwUH1
 OvJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGuZ3vFRlI5MfhzmevLjTMbHDDyP1wrDDl2glkhG4ZeMzPrEKpKgamLO2/IMHIeuQzwUN/TvHpq6lsTY/nIXV2whFaDoQ=
X-Gm-Message-State: AOJu0YxCnL+68lH89aSBGSr/F0ntMAiYBpxHXvBFT2Zp4EFZg4IlqHpf
 dEoNPF23kDqGFXz2se1/Mij6wn8A3aGP2QwAZ3ld6teASvRxY1BCL5bL+nfC39s=
X-Google-Smtp-Source: AGHT+IE39WmWmoSCw39MHK3dn4uEcN/pSQWWQVxXdEjfdDuOnwRQtQRTsL8npiLE5IqzWwDoAENH1Q==
X-Received: by 2002:a17:906:6b0f:b0:a3e:cefe:722f with SMTP id
 q15-20020a1709066b0f00b00a3ecefe722fmr5906108ejr.54.1708540114365; 
 Wed, 21 Feb 2024 10:28:34 -0800 (PST)
Received: from [192.168.221.175] ([93.23.14.172])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a1709063c5200b00a3d5d8ff745sm5228635ejg.144.2024.02.21.10.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 10:28:33 -0800 (PST)
Message-ID: <d042e9e4-081a-4761-9332-f22ab2cf1376@linaro.org>
Date: Wed, 21 Feb 2024 19:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] hw/i2c/smbus_slave: Add object path on error prints
Content-Language: en-US
To: Joe Komlodi <komlodi@google.com>, qemu-devel@nongnu.org
Cc: venture@google.com, minyard@acm.org, peter.maydell@linaro.org
References: <20240220211123.2664977-1-komlodi@google.com>
 <20240220211123.2664977-3-komlodi@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220211123.2664977-3-komlodi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 20/2/24 22:11, Joe Komlodi wrote:
> The current logging doesn't tell us which specific smbus device is an
> error state.
> 
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i2c/smbus_slave.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
> index 1300c9ec72..9f9afc25a4 100644
> --- a/hw/i2c/smbus_slave.c
> +++ b/hw/i2c/smbus_slave.c
> @@ -25,11 +25,15 @@
>   #define DPRINTF(fmt, ...) \
>   do { printf("smbus(%02x): " fmt , dev->i2c.address, ## __VA_ARGS__); } while (0)
>   #define BADF(fmt, ...) \
> -do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); exit(1);} while (0)
> +do { g_autofree char *qom_path = object_get_canonical_path(OBJECT(dev));  \
> +    fprintf(stderr, "%s: smbus: error: " fmt , qom_path, ## __VA_ARGS__); \
> +            exit(1); } while (0)
>   #else
>   #define DPRINTF(fmt, ...) do {} while(0)
>   #define BADF(fmt, ...) \
> -do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
> +do { g_autofree char *qom_path = object_get_canonical_path(OBJECT(dev));  \
> +    fprintf(stderr, "%s: smbus: error: " fmt , qom_path, ## __VA_ARGS__); \
> +             } while (0)
>   #endif
>   
>   enum {

Better convert to trace events, so we can enable tracing at runtime.

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


