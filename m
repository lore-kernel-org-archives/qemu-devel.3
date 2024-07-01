Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F6FC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOF3l-0003R7-Sz; Mon, 01 Jul 2024 07:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOF3T-0003Q5-Dd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:18:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOF3K-00046N-Jz
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:18:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-424a3ccd0c0so21164135e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719832711; x=1720437511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tfYzTVRd5G+y0Fh03CzuWJKfiglB2mLXODH1pEM2Rts=;
 b=TihGMUxzsChgX6VlBwESDnDxGOY0x3NVODr9hYhjutlnv0CseBlHDLI9CCVmpMR6jI
 9NQxj9q7rRpjniglLzIwICPaJU3lXLLYm//yAWthhbkf6/mT+1eH8qQI2ESCahGC9kk0
 TiTMZrMvwCWuKnB/Mv8VVHAtk4J32otHGGzkL0+T2+u9v7EsA7NI7UJXymrJPhHhWipB
 uPcx6YrGn/fTfmw9bptMAPrSOyxz/VkKfMfFQKUCv8FrJM+SZkiDpksYszlLtJ6CXHI1
 SGxFX9j2tvMlsMIB8Xo3wlFwV2IxtuNVXa6XMPCqMAlh29J47rkTESu2wp51bXTE4MFy
 2uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719832711; x=1720437511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tfYzTVRd5G+y0Fh03CzuWJKfiglB2mLXODH1pEM2Rts=;
 b=JCG41xSNc3m6DOx8wIqpFIcRDqgufNoct/9mKC2D/zxS+kba6+dQJ68L91V3nLxylt
 XcF+M3lV5Z7Fq381DYrJR1ltxUkzsrhdg45Xw0SiMDxsCtDhmQCw0u7rpRoe9YSIbCbl
 1EqCORDnHeue8jt50tf9dGkyrJQa1hIY2zEWI5QOEfTNCb+jTxNZTPGs14SMVCN/boOa
 NnOwgyR8uaPsOvhEOvocWvm3skwCY5nYsG61vplX79Kz8tN46sqx5qNyx2y6t+t/UFVz
 UsFnPZMsQeFzJJrUeFIg8RW64z2BSY6JMF8EiiE8w2xNpftubAro3cOn54HPTpMIwUfT
 caMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9U+kf/LKiw+oBuoV8v1uo/CvpLxeEnin9qBBzbNHYV1/A+aYLYo7qRqPt8WWhnHtNnnFlrXkOnhROM6K5/BoIHZi2N9g=
X-Gm-Message-State: AOJu0YwUL+rx5ooTjPOXGcS+wDrG+oA/7ShRNKvs/sD8JTccGN7impfF
 xfjEMwIS6cS9BAkQzrgmhuFpCiMl0IEZ4kmlcMgzLSOvcM042iTEi4n0Uymmezg=
X-Google-Smtp-Source: AGHT+IENmLlajmgq0PygegoxKMCLwig8ls1Zqp0h+hCa+RnskTkcHuJPZyPFshyfDFZQfptMLEI0ww==
X-Received: by 2002:a05:600c:1989:b0:425:69b7:3361 with SMTP id
 5b1f17b1804b1-4257a03a497mr34127425e9.18.1719832711512; 
 Mon, 01 Jul 2024 04:18:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42577a0dda2sm61350605e9.0.2024.07.01.04.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 04:18:30 -0700 (PDT)
Message-ID: <edf25494-1fd0-4a8c-959b-c4547da0ab23@linaro.org>
Date: Mon, 1 Jul 2024 13:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/bcm2835_thermal: Handle invalid address accesses
 gracefully
To: Zheyu Ma <zheyuma97@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>
References: <20240630151414.2969772-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240630151414.2969772-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Zheyu,

On 30/6/24 17:14, Zheyu Ma wrote:
> This commit handles invalid address accesses gracefully in both read and write
> functions. Instead of asserting and aborting, it logs an error message and returns
> a neutral value for read operations and does nothing for write operations.
> 
> Error log:
> ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should not be reached
> Bail out! ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should not be reached
> Aborted
> 
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display \
> none -machine accel=qtest, -m 512M -machine raspi3b -m 1G -qtest stdio
> readw 0x3f212003

Thanks for this very interesting bug report (and reproducer).

> EOF
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   hw/misc/bcm2835_thermal.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
> index ee7816b8a5..5c2a429d58 100644
> --- a/hw/misc/bcm2835_thermal.c
> +++ b/hw/misc/bcm2835_thermal.c
> @@ -51,8 +51,10 @@ static uint64_t bcm2835_thermal_read(void *opaque, hwaddr addr, unsigned size)
>           val = FIELD_DP32(bcm2835_thermal_temp2adc(25), STAT, VALID, true);
>           break;
>       default:
> -        /* MemoryRegionOps are aligned, so this can not happen. */
> -        g_assert_not_reached();

Like Xingtao Yao mentioned, I believe the current code is correct
and shouldn't be reached.

Why is it reached? You might have uncovered a core memory bug.

Likely around access_with_adjusted_size() in system/memory.c.

I'll keep investigating, but so far it reminds me a previous
patch from Andrew, but it isn't the fix:
https://patchwork.ozlabs.org/project/qemu-devel/patch/20170630030058.28943-1-andrew@aj.id.au/

> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "bcm2835_thermal_read: invalid address 0x%"
> +                      HWADDR_PRIx "\n", addr);
> +        val = 0;
>       }
>       return val;
>   }


