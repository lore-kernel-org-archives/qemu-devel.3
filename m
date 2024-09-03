Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78C6CD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZr6-0006CS-HA; Tue, 03 Sep 2024 16:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slZr2-00062H-RO
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:10:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slZr0-0003wV-Mz
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:10:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42c7a49152aso38598765e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725394216; x=1725999016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P6w4YfBM6YE9xAeyRZQM9Yc/nX+5msBtBVnE+RRjgEc=;
 b=KqvQPiK3b3ZlGuLsGKWf+lJYzAywa4CbdkEOTnTQ092f+dhHLvKx3EtIdLKOX1G5Jc
 Ayyz839qYSWPVTwa6frwZ7zU/JdNPUyVTYp6Pi61fSR7EBv5DGAy3spkcpV5r6viGd0H
 IYvYsSf6DAGh8LlqyT5mILopw5Ex02MwqSCfo1nNejnwRX4FXIepfMS161Hv31A/RkfV
 UcCMUMyqt4ApjfnFpa2wA57U/EzsxBIULHR1EyXQLAmlI9qxlEvpF4DYspj/fuXgK7pF
 lenZuI7NSLfDxGm4UhITQoPa4wKOqsATMFoHaICfUSNxG4wKB/t8PFPz4AhdJEdlVZ+a
 dKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725394216; x=1725999016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P6w4YfBM6YE9xAeyRZQM9Yc/nX+5msBtBVnE+RRjgEc=;
 b=f/VP1OIeHngOgMcBoBlyTeHn7E0ssvQuGViFWAc1K2IAynrc+RaTMfBF2qY00gbRLb
 akXfZzFYv/wjiPXASGK3gNVYO6+EZl1hMNOYqwR15tXQdZciLm1iRV052a+x8Wttnh89
 JkOCmpCQWfncVNKwvCFztrqRW4Ps/2jWT9P/KgNMQainXZFFqMaf3v83YXIgOdiPEXv0
 WfW6qa8mmWpGp8DTjGB1KkXQxN2Ehv2v1hPTmFKJbe91CxHfpfDVj+n0+B/pVmHWW2Uz
 VGjjBZtCFXTmne3WrZzkQvRvmxnJI4h+muXm9DI481JKlnfqLNfF5/TAJPzMISNFroZP
 L0NA==
X-Gm-Message-State: AOJu0Yyyzze7PlNHo2AWNZRtxMKxFugRb9j6oBdU/n+nyU2QkXReGfnq
 eebZfwSVDTzHD0hHgp2SV+JvEOavhJ8UqQRNWlKT+r9yE6N/1BJ8yeay8Ik4vpbEV8Mw2G8ueak
 z
X-Google-Smtp-Source: AGHT+IE3JwfvQoqUdvlsrp3gnoATWh4YPCI8i2MvBVG91NIkwDCFdJ5RcUSkL06cFjrWz7Ow4PWJpA==
X-Received: by 2002:a05:600c:4fd3:b0:426:5e1c:1ac2 with SMTP id
 5b1f17b1804b1-42bb01ad75dmr170999375e9.8.1725394215496; 
 Tue, 03 Sep 2024 13:10:15 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba641dad0sm217097245e9.30.2024.09.03.13.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 13:10:14 -0700 (PDT)
Message-ID: <4965aeea-4e19-47a3-b330-6caa5994f40c@linaro.org>
Date: Tue, 3 Sep 2024 22:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/sd: Remove legacy sd_set_cb()
To: qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>
References: <20240903200446.25921-1-philmd@linaro.org>
 <20240903200446.25921-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903200446.25921-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

(Cc'ing Guenter who asked to keep the SX1 machine)

On 3/9/24 22:04, Philippe Mathieu-Daudé wrote:
> sd_set_cb() was only used by omap2_mmc_init() which
> got recently removed. Time to remove it. For historical
> background on the me_no_qdev_me_kill_mammoth_with_rocks
> kludge, see commit 007d1dbf72 ("sd: Hide the qdev-but-not-quite
> thing created by sd_init()").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/sd/sdcard_legacy.h |  1 -
>   hw/sd/sd.c                    | 30 ++++--------------------------
>   2 files changed, 4 insertions(+), 27 deletions(-)
> 
> diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy.h
> index 0dc3889555..a121232560 100644
> --- a/include/hw/sd/sdcard_legacy.h
> +++ b/include/hw/sd/sdcard_legacy.h
> @@ -36,7 +36,6 @@ SDState *sd_init(BlockBackend *blk, bool is_spi);
>   int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
>   void sd_write_byte(SDState *card, uint8_t value);
>   uint8_t sd_read_byte(SDState *card);
> -void sd_set_cb(SDState *card, qemu_irq readonly, qemu_irq insert);
>   
>   /* sd_enable should not be used -- it is only used on the nseries boards,
>    * where it is part of a broken implementation of the MMC card slot switch
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a140a32ccd..8a30c61ce0 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -112,10 +112,6 @@ typedef struct SDProto {
>   struct SDState {
>       DeviceState parent_obj;
>   
> -    /* If true, created by sd_init() for a non-qdevified caller */
> -    /* TODO purge them with fire */
> -    bool me_no_qdev_me_kill_mammoth_with_rocks;
> -
>       /* SD Memory Card Registers */
>       uint32_t ocr;
>       uint8_t scr[8];
> @@ -169,8 +165,6 @@ struct SDState {
>       uint32_t data_offset;
>       size_t data_size;
>       uint8_t data[512];
> -    qemu_irq readonly_cb;
> -    qemu_irq inserted_cb;
>       QEMUTimer *ocr_power_timer;
>       bool enable;
>       uint8_t dat_lines;
> @@ -889,17 +883,10 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
>           trace_sdcard_ejected();
>       }
>   
> -    if (sd->me_no_qdev_me_kill_mammoth_with_rocks) {
> -        qemu_set_irq(sd->inserted_cb, inserted);
> -        if (inserted) {
> -            qemu_set_irq(sd->readonly_cb, readonly);
> -        }
> -    } else {
> -        sdbus = SD_BUS(qdev_get_parent_bus(dev));
> -        sdbus_set_inserted(sdbus, inserted);
> -        if (inserted) {
> -            sdbus_set_readonly(sdbus, readonly);
> -        }
> +    sdbus = SD_BUS(qdev_get_parent_bus(dev));

Guenter, we don't have SX1 tests. I wonder if this call could
fire an assertion. Do you have test images I can use? I'd need
to eject/reinsert a card to get there.

> +    sdbus_set_inserted(sdbus, inserted);
> +    if (inserted) {
> +        sdbus_set_readonly(sdbus, readonly);
>       }
>   }
>   
> @@ -1027,18 +1014,9 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
>       }
>   
>       sd = SD_CARD(dev);
> -    sd->me_no_qdev_me_kill_mammoth_with_rocks = true;
>       return sd;
>   }
>   
> -void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
> -{
> -    sd->readonly_cb = readonly;
> -    sd->inserted_cb = insert;
> -    qemu_set_irq(readonly, sd->blk ? !blk_is_writable(sd->blk) : 0);
> -    qemu_set_irq(insert, sd->blk ? blk_is_inserted(sd->blk) : 0);
> -}
> -
>   static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
>   {
>       trace_sdcard_read_block(addr, len);


