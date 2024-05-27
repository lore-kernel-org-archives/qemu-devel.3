Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DEBC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcjr-0005S0-5x; Mon, 27 May 2024 11:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBcjp-0005Re-SI
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:58:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBcjo-0007T2-8h
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:58:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4202ca70287so33370965e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716825494; x=1717430294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3y+qiQqx+Yu806+NVMklywnrg25mrY4P+ljDt/5rfZ8=;
 b=ETMNydH1BCLmuu/nHZ4wnU/6gFfgUakBRjHn807q0UELhvCWPotWZuoGr84A8V5cnh
 eH6YpmFjDGaB956DILvjuIlqeAUBTgtJgQHHLcBNDkVtFk5dkTogsDcpTW9rk+/cSuuu
 AIvKDOFoTb6W/+/GRYwTA194O38LFPH4Ef0PDHgPa5J2lRZPamf+cpflzK8yT58aX9jo
 W/i8ZS3wHE5TVKKoC3YISnoWAUP/opVKSr3ALYAnItyv7O2xkmOMjOppm3CJrExjuF6G
 /dD7rJ4fYVTlL86jWcir5lVyigRpPjk8A7DdxfaTSkmhMiPtjvp7grPqDhxPQbf2M+s3
 q+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716825494; x=1717430294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3y+qiQqx+Yu806+NVMklywnrg25mrY4P+ljDt/5rfZ8=;
 b=q4YqqTLSa6ytd+E3VUmvO/dq19IssMakkfSiRZmdrXULfBMDc6cRxHXsxIuxonNqZ1
 cuti8r4tTXORwCwWOlfhXeb9Gas9i/SUkmmJzcxYit3ZfM73m28MjtP9vs7uSiJNtqpI
 x7ACLtcBS9FuNNVcbjA+1Y+me9ry6xZ5tTQMi4vSKS1xHJNGxTUqI6Navp+kylfTk+HB
 oouukFIJhaDmjilHuNOD8Euq5qwNu2wC8jfdkUn37GM+uOeC4mNdwsH5D4wvLSom6xcp
 vsVT6n3ZF0r+l4C5mROP4vq/OmAP704WuDwJM9f+Y4nSjBDYmievv2xX0R7KESKMAenk
 G3Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhvuLQ3dGtCJ4/8zFxfLkGqmeWe+PSisiyRD/BLKSQU+pgQJ9E8dGwjRdG8Ayv0QH5Wxc1lwVViW8F07MRUgCBLQprFB8=
X-Gm-Message-State: AOJu0YyuxHDs1mdfC6rzahJPh/A8lN/17T5PrVG3c3KCuM0GcHa3QLVA
 7a9PS1IuNdJsrQD9t20i9wG27bM+QuokjuX6xBQwULaZLdRok+FZqatR440eMF8=
X-Google-Smtp-Source: AGHT+IHl9u0grYbXXZoYIe0MXsQBnQjW/aX79WyNoPV+4WHwTX67ZSImbYi9/WpiN1V66ygqlCij9A==
X-Received: by 2002:a05:600c:4589:b0:420:29dd:84e3 with SMTP id
 5b1f17b1804b1-42108a0d355mr94825445e9.26.1716825494386; 
 Mon, 27 May 2024 08:58:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fbb140sm146356945e9.44.2024.05.27.08.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 08:58:13 -0700 (PDT)
Message-ID: <b641018c-e906-452b-8072-1b46f141808b@linaro.org>
Date: Mon, 27 May 2024 17:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/16] aspeed/smc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-10-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527080231.1576609-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi,

On 27/5/24 10:02, Jamin Lin wrote:
> AST2700 fmc/spi controller's address decoding unit is 64KB
> and only bits [31:16] are used for decoding. Introduce seg_to_reg
> and reg_to_seg handlers for ast2700 fmc/spi controller.
> In addition, adds ast2700 fmc, spi0, spi1, and spi2 class init handler.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ssi/aspeed_smc.c | 222 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 220 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index df0c63469c..b4006c8339 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -185,7 +185,7 @@
>    *   0: 4 bytes
>    *   0x1FFFFFC: 32M bytes
>    *
> - * DMA length is from 1 byte to 32MB (AST2600, AST10x0)
> + * DMA length is from 1 byte to 32MB (AST2600, AST10x0 and AST2700)
>    *   0: 1 byte
>    *   0x1FFFFFF: 32M bytes
>    */
> @@ -670,7 +670,7 @@ static const MemoryRegionOps aspeed_smc_flash_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid = {
>           .min_access_size = 1,
> -        .max_access_size = 4,
> +        .max_access_size = 8,

Is this a bugfix? If so, please use a separate patch. Otherwise
please mention why it is OK to widen access for AST2600 & AST10x0.

Thanks,

Phil.

>       },
>   };


