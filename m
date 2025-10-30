Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C107CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 22:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEaqv-0004Lz-8v; Thu, 30 Oct 2025 18:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEaqm-0004LX-6N
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:10:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEaqb-0004s1-MK
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:10:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47719ad0c7dso14497875e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761862213; x=1762467013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AHLTkeCEMJrzCgm8P1N++DChHm24pX+s+Mn4vHOYSvQ=;
 b=HSWVpQQ/hHpVl5KbfH9zuO8TmXyvYqWcSWSVv9SP2SS5wVmy+/gm2ZS9cwDDE7dfn0
 ogPnG+PxtJ7weJefjdAxgFGWADeU2cEgnLVQuvhuURPsZ6JxKvKyqwCID44enLEoGQgS
 DyfpJD0yveuz4Db0xdNhWPTaSi5wWwV+vjZdmWqbMW0/Nf3wlPdGgnVygmzVVBqqhPYR
 nI+zTi0IJD2In0FwUjRsK23MC7T92I/xSovVKOH2v+muEZBqL2LokfZr8CAJD92b31is
 Mif3UwElvmvy9JwajxXX60jbNeGZozYhhceoZ8R3SzBPnq/zcYDQ+Tti0yQI95cHWjwk
 WGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761862213; x=1762467013;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AHLTkeCEMJrzCgm8P1N++DChHm24pX+s+Mn4vHOYSvQ=;
 b=MnwT5NudTocOd51fIEW2XqAOAsDZLv5sPv9cxppRaDjAt2hmUsg/gwoTfAzQPxWyiK
 0hguhT1FUouTKMel4DXlVjZlBHszYOOIUm/5YS5qwTxObkWsS6152jO8kK9Mo1w1K09J
 btQTFjfp0uOKd4dGdV8586P/4KaOuulcKPzw2wE3NjgD9eDpQCaPgS6SddtZtlLd/lyH
 hJC+t61s6jK4FmDXPzsRayS+0rt7MDjgt8GthHFh3SvSt0jpe0WTU+qxoyC3QKIR2cXh
 ECDQFTeQdcenFeMv6MDYO6FNlyLsuCuUI5uHbmTSjqphcs4htI026YDdlJQ2yXJmlbBy
 2IMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6XAK6idO6eaM38pmmT6o/D0cvOz0xGA7EV6sqmXWnqdGo2+dq+XJRfu8q+25j/L6D6WbLFeZ3FUQE@nongnu.org
X-Gm-Message-State: AOJu0YxjHd4N9zRkaz1YWS4GSEF5XryCYbHc15nVqgrryit2oEppKetU
 xX7VCuDntaWULmMzX0OWSBb+Q6BkbP5wKa+VdKfQDcQyJucdEF594KTKSlBiSXcqREc=
X-Gm-Gg: ASbGncvPewCT2vAZbphbmW/xZAHS2kOQW8N2msnFXc+Nn+XHq62K2TSeWZUH/D++bJA
 wj2ql4h1LnVV4Cj/wqfxlPWvp3TVV7KmbtVb1fcoG2sz5P0uYlO8xpux5K2/5wAUFhoTE6CHD8c
 5VM4sI67VYqmKJ+9b8d5WF5FCKcKBoG2rAAW9QLVIFBNhX5BkUak9ykwZYs0824GOjfDVlgtxl3
 LpaHn05ZJvq6QViOMHme5CYd6gyBAsEHeJ817YpE/ayHD2/0jV+fZEZ5C6JnO7CllltCncS9Fmj
 cT9h5p7ixyhI9+6nMSiUcrig4D1CZF825YbTchIpHVtc+LvoFQpXNKdZ6NISKhIkHNS0b94lp6E
 0fkIk8qFk/4BNFXjfYEZOaDe44bXpvRrSIFUgqM73BzpK8FJnDQowij73BFtZoEEztsu0RYqzmm
 /eiBMARADBsPswB2zc77hMlHEdL38YVzu8E9NPmv+u+uSdlIvpe9mqf10=
X-Google-Smtp-Source: AGHT+IEpgKvxCbx9YoQS/QRXg8TlwOxvq0e9I0jerLC7xZqNZoUP5k7C/taJDGg+G8rK2wFzE5IZbQ==
X-Received: by 2002:a05:600c:3b8b:b0:471:989:9d7b with SMTP id
 5b1f17b1804b1-4773086d53amr10916955e9.21.1761862212572; 
 Thu, 30 Oct 2025 15:10:12 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732ff7fdbsm651425e9.16.2025.10.30.15.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 15:10:11 -0700 (PDT)
Message-ID: <fb5dee7c-c7c7-4a18-9282-f990f17a32c1@linaro.org>
Date: Thu, 30 Oct 2025 23:10:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] hw/sd/sdcard: Fix size check for backing block
 image
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Warner Losh
 <imp@bsdimp.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <484a8687e5cd44d94597512502180ba1aba57572.1760702638.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <484a8687e5cd44d94597512502180ba1aba57572.1760702638.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 17/10/25 14:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Alignment rules apply the the individual partitions (user, boot, later
> on also RPMB) and depend both on the size of the image and the type of
> the device. Up to and including 2GB, the power-of-2 rule applies to the
> user data area. For larger images, multiples of 512 sectors must be used
> for eMMC and multiples of 512K for SD-cards. Fix the check accordingly
> and also detect if the image is too small to even hold the boot
> partitions.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> CC: Warner Losh <imp@bsdimp.com>
> CC: Cédric Le Goater <clg@kaod.org>
> CC: Joel Stanley <joel@jms.id.au>
> CC: Alistair Francis <alistair@alistair23.me>
> CC: Alexander Bulekov <alxndr@bu.edu>
> ---
>   hw/sd/sd.c | 65 +++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d7a496d77c..d1e1bb4f0e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2759,9 +2759,32 @@ static void sd_instance_finalize(Object *obj)
>       timer_free(sd->ocr_power_timer);
>   }
>   
> +static void sd_blk_size_error(SDState *sd, int64_t blk_size,
> +                              int64_t blk_size_aligned, const char *rule,
> +                              Error **errp)
> +{
> +    const char *dev_type = sd_is_emmc(sd) ? "eMMC" : "SD card";
> +    char *blk_size_str;
> +
> +    blk_size_str = size_to_str(blk_size);
> +    error_setg(errp, "Invalid %s size: %s", dev_type, blk_size_str);
> +    g_free(blk_size_str);
> +
> +    blk_size_str = size_to_str(blk_size_aligned);
> +    error_append_hint(errp,
> +                      "%s size has to be %s, e.g. %s.\n"
> +                      "You can resize disk images with"
> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
> +                      "(note that this will lose data if you make the"
> +                      " image smaller than it currently is).\n",
> +                      dev_type, rule, blk_size_str);
> +    g_free(blk_size_str);
> +}
> +
>   static void sd_realize(DeviceState *dev, Error **errp)
>   {
>       SDState *sd = SDMMC_COMMON(dev);
> +    int64_t blk_size = -ENOMEDIUM;
>       int ret;
>   
>       switch (sd->spec_version) {
> @@ -2774,32 +2797,34 @@ static void sd_realize(DeviceState *dev, Error **errp)
>       }
>   
>       if (sd->blk) {
> -        int64_t blk_size;
> -
>           if (!blk_supports_write_perm(sd->blk)) {
>               error_setg(errp, "Cannot use read-only drive as SD card");
>               return;
>           }
>   
>           blk_size = blk_getlength(sd->blk);
> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> -            int64_t blk_size_aligned = pow2ceil(blk_size);
> -            char *blk_size_str;
> -
> -            blk_size_str = size_to_str(blk_size);
> -            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
> -            g_free(blk_size_str);
> -
> -            blk_size_str = size_to_str(blk_size_aligned);
> -            error_append_hint(errp,
> -                              "SD card size has to be a power of 2, e.g. %s.\n"
> -                              "You can resize disk images with"
> -                              " 'qemu-img resize <imagefile> <new-size>'\n"
> -                              "(note that this will lose data if you make the"
> -                              " image smaller than it currently is).\n",
> -                              blk_size_str);
> -            g_free(blk_size_str);
> -
> +    }
> +    if (blk_size >= 0) {
> +        blk_size -= sd->boot_part_size * 2;
> +        if (blk_size > SDSC_MAX_CAPACITY) {
> +            if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) != 0) {

I'll replace by:

     !QEMU_IS_ALIGNED(blk_size, 1 << HWBLOCK_SHIFT)

> +                int64_t blk_size_aligned =
> +                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
> +                                  "multiples of 512", errp);
> +                return;
> +            } else if (!sd_is_emmc(sd) && blk_size % (512 * KiB)) {

and:

    !QEMU_IS_ALIGNED(blk_size, 512 * KiB)

> +                int64_t blk_size_aligned = ((blk_size >> 19) + 1) << 19;
> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
> +                                  "multiples of 512K", errp);
> +                return;
> +            }
> +        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
> +            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a power of 2",
> +                              errp);
> +            return;
> +        } else if (blk_size < 0) {
> +            error_setg(errp, "eMMC image smaller than boot partitions");
>               return;
>           }
>   

Long due cleanup, thank you very much!!!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


