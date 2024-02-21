Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DC4C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcojo-0008Um-Dg; Wed, 21 Feb 2024 10:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcojm-0008PL-L2
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:42:22 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcojk-0000dB-S3
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:42:22 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d2b354c72so3106064f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708530139; x=1709134939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pfvtcpdy2nrjGtQx3Hv+IDxJA8BcKmv7oaMjW4p3RA8=;
 b=gh5b8LjPFzvv3pBpo/kKbnFYwyaGQPDnACuQAdJ41yLYLgtyzpKNazi9ZY7KgcQc9s
 T9D+DJI1wOZ5aGvZ7YChJb5fMXydS1UtgT/ecXn5maX2rKPElwb2eE2K42oVeJz/2KxL
 IIvFXc+SdAMXjOR4ILs0CEpqOxlN+pJCjmx+IxToNU4KxzIJchQZXWdyH0aBVDPvi9gs
 iR1IzzYptUasOd8DU/9PmEuCqzonsaM6AjDZQ4VzuH0FjcXwl1rch9Pmvz+mHD+aCm5q
 OAoQK2ZZzCsp8OYoXLoYe51lMuU/JnksihtROCX53R40kuvR7tsuAfk+gsgth+AyKB7G
 knJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708530139; x=1709134939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pfvtcpdy2nrjGtQx3Hv+IDxJA8BcKmv7oaMjW4p3RA8=;
 b=iCzRFq+J1a2tnHAYvxIlnRozTb1BTJ4pZh+qodZkwJNjVCi7oycHisyrXM7vkLkGQs
 SM7ZOpaUzLpQaads5OGRZj7xg4Dis6FBoX0cZlnXSUHde1KA8+sYL5JIxoPboOnomgQP
 rIvgPFrAp2O/xzH0ZuG3+PzIK2XPwtqPu6rbklzm64MRSIuUnxzkQ8Ue+3MegQFD3hYv
 yMOX8llMHj1yFSxFWveC5homkBfSIXWUnbPiqdJ0WxmiZ5SP3bb+elVLZCgKmhtqmDS/
 1/nDTcochompwDG9w/W4QzeiPebko3+D9ZOe7vi+y97yDJvJfIJyBYemjuN17rOhCpXM
 iUCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB1djg7w+WhmeNx5bOPUFd/zz3ajB4Y5MYTVvJdIWd64esdIggB/EtJ5DupS2jhWFhNmhmFfnpY6fUrgi4eCOGlxZK+eA=
X-Gm-Message-State: AOJu0YxkF3T6QjUxQWYZGBKXTO21/cly3IrO518TzabldmutaL+uIez4
 eYjYGPGpMoJJgk3ED8FHfPE8OTR9PhOg1XRCC/yunCvECt9WnHDw/MAQloBmfGw=
X-Google-Smtp-Source: AGHT+IHT69Cl6S+GXsmPQymnu/r2azmGfsHMrf7am8uFXH5t61Lxz47KKb/JWSbi1g7tCFVuhx80/w==
X-Received: by 2002:a5d:4d8a:0:b0:33d:51ec:6d07 with SMTP id
 b10-20020a5d4d8a000000b0033d51ec6d07mr5670502wru.62.1708530138902; 
 Wed, 21 Feb 2024 07:42:18 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a056000136200b0033d12895cfdsm17435937wrz.61.2024.02.21.07.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 07:42:18 -0800 (PST)
Message-ID: <16ef6303-7527-4ab8-8a8c-62e6892963c1@linaro.org>
Date: Wed, 21 Feb 2024 16:42:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hw/core/machine: Use qemu_register_resettable for
 sysbus reset
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220160622.114437-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 20/2/24 17:06, Peter Maydell wrote:
> Move the reset of the sysbus (and thus all devices and buses anywhere
> on the qbus tree) from qemu_register_reset() to qemu_register_resettable().
> 
> This is a behaviour change: because qemu_register_resettable() is
> aware of three-phase reset, this now means that:
>   * 'enter' phase reset methods of devices and buses are called
>     before any legacy reset callbacks registered with qemu_register_reset()
>   * 'exit' phase reset methods of devices and buses are called
>     after any legacy qemu_register_reset() callbacks
> 
> Put another way, a qemu_register_reset() callback is now correctly
> ordered in the 'hold' phase along with any other 'hold' phase methods.
> 
> The motivation for doing this is that we will now be able to resolve
> some reset-ordering issues using the three-phase mechanism, because
> the 'exit' phase is always after the 'hold' phase, even when the
> 'hold' phase function was registered with qemu_register_reset().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I believe that given we don't make much use of enter/exit phases
> currently that this is unlikely to cause unexpected regressions due
> to an accidental reset-order dependency that is no longer satisfied,
> but it's always possible...
> ---
>   hw/core/machine.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index fb5afdcae4c..9ac5d5389a6 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1577,14 +1577,13 @@ void qdev_machine_creation_done(void)
>       /* TODO: once all bus devices are qdevified, this should be done
>        * when bus is created by qdev.c */
>       /*
> -     * TODO: If we had a main 'reset container' that the whole system
> -     * lived in, we could reset that using the multi-phase reset
> -     * APIs. For the moment, we just reset the sysbus, which will cause
> +     * This is where we arrange for the sysbus to be reset when the
> +     * whole simulation is reset. In turn, resetting the sysbus will cause
>        * all devices hanging off it (and all their child buses, recursively)
>        * to be reset. Note that this will *not* reset any Device objects
>        * which are not attached to some part of the qbus tree!
>        */
> -    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());
> +    qemu_register_resettable(OBJECT(sysbus_get_default()));

Correct, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

But I'd rather move that call to main_system_bus_create() in
hw/core/sysbus.c, as it doesn't seem to be related to the
machine creation phases anymore. Maybe clearer to do in a
separate patch although.

>       notifier_list_notify(&machine_init_done_notifiers, NULL);
>   


