Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAB2C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcXm-0003ai-4S; Thu, 29 Feb 2024 04:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfcXh-0003a0-Pi
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:17:29 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfcXg-00080e-61
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:17:29 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412b246b386so4769925e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709198246; x=1709803046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GHrh/nNkQh7TYgndSEQQ8I9OPrs3wS3MtBzdmWGvMMo=;
 b=Wu/ikibpyvX33VWk1OyFjoAmTFDs+1qQtRTm0ifSNzlbWbtlGa1HP+y1I/fikfsbcE
 OuZmJdBBdbZ5hRQU6WhJXQq9M9d9Isx5r4vD5xW8GQfk81E1QBfqxNxUjEWfGgBh77O7
 6VzrKSOVbE9GTmHJIRNxEX9+OfK7a+477xCQGI7ya8GpgkyvnY8SJtlzMWUvTpTnNYGR
 iVWQgfLCyv2bIjeQshnuwdd1hGFLlF9zkBC5ZHpMs+pVa474yB3op8Qh5ux+IOHZX/m2
 /fouvkQr0sInv2HH0wI4k98juj/RtT8niB4JWx0hqIPV01OhJM5RTNy6t4qNH/dHkY4J
 N0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709198246; x=1709803046;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GHrh/nNkQh7TYgndSEQQ8I9OPrs3wS3MtBzdmWGvMMo=;
 b=bzvXNy34SEqvAIfLEAX35a/t9M9TGh2hHUQDU8QngyWJhvQdvtMmyMaqKHSceDrriA
 K184oWp8VA2lH+ZkBuwPoJRjZ9TinaA5+3/fEaP28Xl6LcoHrojQ8oNCb8AbkU184Nwc
 kJO/TuptSpfhAI763fGqv5Tk9qaTM+FB4snMKapje4qDX9Vol7Mt0Jaf1s4777zJ4BTh
 x3dzO5sqNMXAVydjCwrTxiEOUT6S6LPVqfcjwWwvkTPfppJkg+fmVXmMLqO3YZwq306q
 eTtETAs5GQvJj3RAMy3e/cUR0lRQY+fMHwWY6oqgaBAtOnrkRoZ56feDgscGGfKBPp5a
 F13w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo+QiY3Ve3frcuvvMEzpNMV5TqDxKtkYbbyEiUzDs7mX+q2CcuosV1SG1cek7AyxnJM3k2bLNlAOYGfdv7i9almRgRgWA=
X-Gm-Message-State: AOJu0YwO/LF/MkWE0u6bB+myApK317ucM+OIal9ewZ1NhoNJPzyyFP1o
 MXrzB8oEbZHRBr+3SLv6Isya4ndtrQcQMwQ7Ga36KoQSsvaYq+r9T6F+XSQ0apI=
X-Google-Smtp-Source: AGHT+IHqjIlZFHAyjKIfXSEvvnn1Aa32YT3S8QKB0HWD6he/3oh/yvixyh4Maqc19Qf6KOaXGJkUaQ==
X-Received: by 2002:a05:600c:4e91:b0:412:b6c4:ac21 with SMTP id
 f17-20020a05600c4e9100b00412b6c4ac21mr1441657wmq.41.1709198245978; 
 Thu, 29 Feb 2024 01:17:25 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a05600c4fc300b0041297d7e181sm1455306wmq.6.2024.02.29.01.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 01:17:24 -0800 (PST)
Message-ID: <06696a4e-ae61-4fa0-984b-481e680f9989@linaro.org>
Date: Thu, 29 Feb 2024 10:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] aspeed/sdmc: Add AST2700 support
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240229072315.743963-1-jamin_lin@aspeedtech.com>
 <20240229072315.743963-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240229072315.743963-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Jamin,

On 29/2/24 08:23, Jamin Lin via wrote:
> The SDRAM memory controller(DRAMC) controls the access to external
> DDR4 and DDR5 SDRAM and power up to DDR4 and DDR5 PHY.
> 
> The DRAM memory controller of AST2700 is not backward compatible
> to previous chips such AST2600, AST2500 and AST2400.
> 
> Max memory is now 8GiB on the AST2700. Introduce new
> aspeed_2700_sdmc and class with read/write operation and
> reset handlers.
> 
> Define DRAMC necessary protected registers and
> unprotected registers for AST2700 and increase
> the register set to 0x1000.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/misc/aspeed_sdmc.c         | 215 ++++++++++++++++++++++++++++++----
>   include/hw/misc/aspeed_sdmc.h |   4 +-
>   2 files changed, 198 insertions(+), 21 deletions(-)


> @@ -231,7 +270,10 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
>       AspeedSDMCState *s = ASPEED_SDMC(dev);
>       AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
>   
> -    assert(asc->max_ram_size < 4 * GiB); /* 32-bit address bus */
> +    if (!asc->is_aarch64) {

Maybe name it 'bus64bit'? Because this isn't really related
to Aarch64.

> +        assert(asc->max_ram_size < 4 * GiB); /* 32-bit address bus */
> +    }


> +static void aspeed_2700_sdmc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 SDRAM Memory Controller";
> +    dc->reset = aspeed_2700_sdmc_reset;
> +
> +    asc->is_aarch64 = true;
> +    asc->max_ram_size = 8 * GiB;
> +    asc->compute_conf = aspeed_2700_sdmc_compute_conf;
> +    asc->write = aspeed_2700_sdmc_write;
> +    asc->valid_ram_sizes = aspeed_2700_ram_sizes;
> +}


> @@ -51,6 +52,7 @@ struct AspeedSDMCClass {
>       const uint64_t *valid_ram_sizes;
>       uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
>       void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
> +    uint32_t is_aarch64;

bool.

>   };
>   
>   #endif /* ASPEED_SDMC_H */


