Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F63DC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 12:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Kyp-0002yI-2o; Fri, 26 Apr 2024 08:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0Kyg-0002vy-3X
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:47:05 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0Kyc-0002qN-7x
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:46:57 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a557044f2ddso263145166b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714135612; x=1714740412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9lrTY4Nr9jGNC6AFsCt/hzu1RHEYbNWHMSByUm/lhys=;
 b=yrYbW9hlp602M9KBRmmN9QOgzNPMuW35DvZRq7qVHtsGI4P2Zpt358mdCPIiz5cLt8
 tULC3D1sMtlS+EB559F4/vnWOc1xRV6cugr2VHviBaBpzDCC+BXFixVT+wl547Bgpbbn
 zNsB8R4jgBSY30pLub4Nv5eRBSFmZ8eIW1cK9SKrFmWweF4er9wq2sng7bYS2eIzFOo/
 3r/DemCku+eKMjhY16LQl7/IfX3F6kLSswyKgVpSNUV/opCV87a2tcs9mTGSvdaawbi5
 wgca5aX8iqDcO4fkGCNszGgdvrgmgCqKRtRjpyzqpGo8VsDAA0C0lOsMr6GX06EfSdbF
 IlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714135612; x=1714740412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9lrTY4Nr9jGNC6AFsCt/hzu1RHEYbNWHMSByUm/lhys=;
 b=nfdyezkUsdkYPb60E1+Owpl9xPhNqmIMJUBM9iwvUewIB23M/rtOL9pt2V3RWMYJkr
 ypxbyRzzrkcLTvEgUQ8a4OATj3uBG785wyhGuzAQ76+Jx2NzP8NRixqf6BJbyXOIv6kX
 d2Bs1jpTD6UWaHwmKibd5XQ3K5Q+eB1oDyjzHhM+XpMGxBdcF2m0FkbrshIsdkyInKQk
 hlzIY837qINKuTJjLZ1HSen/0MWLWLBhaqO/2kYSDI62NIWe2SYzH08TBTgMMMyajYHg
 AepQ6HuGeRkw8hw0KweGJKgnLFVyMQf4J7EE2pf18HB+C0ZCwCdBwMcMRxFR+HfSq7kp
 Y4gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfPA1To+0HzLbuStOmxhUG2x9sUmCJ+o+jG/ZrEljYaMgIntoft1Zk4E04QzqcmcNYzNMKWs9nDhEjZBla13XKJ30LOfU=
X-Gm-Message-State: AOJu0YxdGOf45KaoTXGOC85Pv6NaRVND9ewD/5z3TgggceYpy1mEneb/
 McDPcAJqsdByLGh5plSpERWiownqPYU38gcKt5gd0q9JQDbrpiifbL+USpbYUL4=
X-Google-Smtp-Source: AGHT+IGhFcnqY5ZvaiURfBdOevEEwXfh4qKLFkFna4WYApjLnbuWTOA3Fe9IDDu+xE1PqkmZxhEerA==
X-Received: by 2002:a17:906:4144:b0:a58:c0e2:9792 with SMTP id
 l4-20020a170906414400b00a58c0e29792mr2186578ejk.61.1714135612416; 
 Fri, 26 Apr 2024 05:46:52 -0700 (PDT)
Received: from [192.168.69.100] (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 dk18-20020a170907941200b00a58ca98bbfbsm762915ejc.30.2024.04.26.05.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 05:46:52 -0700 (PDT)
Message-ID: <36b9a714-44ff-4b60-a23d-89672a98f46e@linaro.org>
Date: Fri, 26 Apr 2024 14:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/watchdog/sbsa_gwdt: Make watchdog timer
 frequency a QOM property
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240426122913.3427983-1-peter.maydell@linaro.org>
 <20240426122913.3427983-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240426122913.3427983-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Hi Peter,

On 26/4/24 14:29, Peter Maydell wrote:
> Currently the sbsa_gdwt watchdog device hardcodes its frequency at
> 62.5MHz. In real hardware, this watchdog is supposed to be driven
> from the system counter, which also drives the CPU generic timers.
> Newer CPU types (in particular from Armv8.6) should have a CPU
> generic timer frequency of 1GHz, so we can't leave the watchdog
> on the old QEMU default of 62.5GHz.
> 
> Make the frequency a QOM property so it can be set by the board,
> and have our only board that uses this device set that frequency
> to the same value it sets the CPU frequency.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/watchdog/sbsa_gwdt.h |  3 +--
>   hw/arm/sbsa-ref.c               |  1 +
>   hw/watchdog/sbsa_gwdt.c         | 15 ++++++++++++++-
>   3 files changed, 16 insertions(+), 3 deletions(-)


> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 36f6f717b4b..57c337fd92a 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -543,6 +543,7 @@ static void create_wdt(const SBSAMachineState *sms)
>       SysBusDevice *s = SYS_BUS_DEVICE(dev);
>       int irq = sbsa_ref_irqmap[SBSA_GWDT_WS0];
>   
> +    qdev_prop_set_uint64(dev, "clock-frequency", SBSA_GTIMER_HZ);

Since we have access to the CPU and its generic timer, what about
just keep the wdg in sync, as smth like:

   qdev_prop_set_uint64(dev, "clock-frequency",
                        object_property_get_uint(OBJECT(some_cpu),
                                                 "cntfrq", errp));

>       sysbus_realize_and_unref(s, &error_fatal);
>       sysbus_mmio_map(s, 0, rbase);
>       sysbus_mmio_map(s, 1, cbase);



