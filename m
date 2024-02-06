Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5291BC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNod-0001w9-B8; Tue, 06 Feb 2024 10:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXNoZ-0001v7-NY
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:56:52 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXNoW-0003gD-Pw
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:56:50 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40fe00cb134so10815415e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707235007; x=1707839807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AdpGxxbH1BNEhhBiyvOxUNJk6JBxU7UVP5Cm8W0Vpnc=;
 b=QukGw5R9Via9HjA1F2MI1ec4h/fQqcn8dneEdmi/9ySQRPVOjFXkGcatTlK1BRJkMz
 zl4isU9b+j85GfJCXi2tBWXG2SlGU2yzDUYYo3tzLJ3D3gIRlC2axUAGAt2kSG6VqhaE
 9+9aqlZ5D0jS0tcYrEwY0rdYIVCXA6L39P43LBaxOkq/f5vOXLeqbhlDB8UHuicWtGG3
 D1t4HJjK+z4qHumhAmQnbwPARjmpWyXnShEGLV4eoaM8ZESX9mzMe4w5oBPKO+Mc1Fyp
 xHTyUEVWgGmZ1ayBsLrhocFL0627/nv+Rp7rCRKuOWyHneFK0/K4obOhFm+v/JeXy8eq
 Sy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707235007; x=1707839807;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AdpGxxbH1BNEhhBiyvOxUNJk6JBxU7UVP5Cm8W0Vpnc=;
 b=W9SzHshXZ/siIMbAvnyweLmOm6Noy6KU/RXOKgEgt4K/dknA/Lm+Nj1GiXghPpoYks
 uOG+0B1YjClfjEG8+Q364j/ZBw6Zfj/1WC0Biqu1DtISYL6LIE9I0zeDHKbGSnKcSdJF
 urLCWqi/j0F2SzrtWd/RacDtheJ8wXnXhQ7WeJslNgpaBOKxdOVo5L4D+dATJZfCNhxP
 7QtxTX92Bd5p8XaSN+qV/DVZ2PxqkpOEcmg+UQ2A/KaFfh1RUN+Yzxqtgn1lBIrmGZvY
 FwUp+BT5ohNHHZsXkWGqsIJgMjYq+E4uzJQkflDDaM/PXf1H7HWciqKjAZZRjfgq4y39
 2z9Q==
X-Gm-Message-State: AOJu0Yyjurq9F+XBO4dIO1TenRHcFhNECGd7cCvOsLfhJw28Lf4juegf
 /MLkASF9g0FIuZngqZDoTcsOlX8+DPRc8GHRcNbgyZxR5m5JL8nNemX1cnMcwWYlasgfqig9z0p
 U
X-Google-Smtp-Source: AGHT+IGyDKU7BbeyZzNG+WMQ5raE+q+HeFBpBJqitw7hB66+OL5a7t/4U8O0JWT4+XCEdTJUSoliKA==
X-Received: by 2002:a05:600c:4ed1:b0:40f:c36f:3ce5 with SMTP id
 g17-20020a05600c4ed100b0040fc36f3ce5mr2620109wmq.16.1707235007188; 
 Tue, 06 Feb 2024 07:56:47 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXetE4H6NefEs+dw8fzuy6yX4tQtQlhANA1aigjXrfFHLP+SqEWGvW0lXAwjncTZt85DGIpNZ8vjPfTKQn0WycIUzwm5lxNLV1pfrvqwkahNMeCgkHOMmJPjZ8=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a5d4523000000b0033b17880eacsm2414652wra.56.2024.02.06.07.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:56:46 -0800 (PST)
Message-ID: <df137d9c-f369-42d3-9a15-3da747f38229@linaro.org>
Date: Tue, 6 Feb 2024 16:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] hw/misc/mps2-scc: Factor out which-board
 conditionals
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206132931.38376-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Peter,

On 6/2/24 14:29, Peter Maydell wrote:
> The MPS SCC device has a lot of different flavours for the various
> different MPS FPGA images, which look mostly similar but have
> differences in how particular registers are handled.  Currently we
> deal with this with a lot of open-coded checks on scc_partno(), but
> as we add more board types this is getting a bit hard to read.
> 
> Factor out the conditions into some functions which we can
> give more descriptive names to.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/mps2-scc.c | 45 +++++++++++++++++++++++++++++++--------------
>   1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
> index 6c1b1cd3795..02a80bacd71 100644
> --- a/hw/misc/mps2-scc.c
> +++ b/hw/misc/mps2-scc.c
> @@ -59,6 +59,30 @@ static int scc_partno(MPS2SCC *s)
>       return extract32(s->id, 4, 8);
>   }
>   
> +/* Is CFG_REG2 present? */
> +static bool have_cfg2(MPS2SCC *s)
> +{
> +    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547;
> +}
> +
> +/* Is CFG_REG3 present? */
> +static bool have_cfg3(MPS2SCC *s)
> +{
> +    return scc_partno(s) != 0x524 && scc_partno(s) != 0x547;
> +}
> +
> +/* Is CFG_REG5 present? */
> +static bool have_cfg5(MPS2SCC *s)
> +{
> +    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547;
> +}
> +
> +/* Is CFG_REG6 present? */
> +static bool have_cfg6(MPS2SCC *s)
> +{
> +    return scc_partno(s) == 0x524;
> +}

I'd rather QOM-decline TYPE_MPS2_SCC per board and have
MPS2SCCClass::have_cfgX fields set in each class_init.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


