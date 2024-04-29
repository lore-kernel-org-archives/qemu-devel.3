Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E43C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 09:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1NfM-0000uR-Ni; Mon, 29 Apr 2024 05:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NfI-0000sd-Gu
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:51:16 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NfD-0001Pa-MC
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:51:14 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2dd6c160eaaso52101381fa.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714384269; x=1714989069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hWGNrlmqtJhlRyvEDH9CFli0qBjeZVbn433NJ/EgQSs=;
 b=FAQWkVJ/7DujBhCwqcAxahIm4gCimGQ6cEExNHtq3ZHymV7GHdV8fGr26ZM8TfEpjL
 BHuf8IX0FZtfNpF7xbJqo/cU6EnpheO1C127RlKk9D2qRo9SPcZhP4lUkJtKlCgDk/Bx
 EI0fNnPZFqXCtckr38IOfG602zO/EtV9fIqNwsqsePVQ9Z2bh4mzz/wL+fXSTCJBE6Jh
 E7ntctUZ3NoWKYUpj2Lle00YEIGM3r8UdM+JsxftwZGG0/+/GSc1jKB8Nq2v5h1ztoRf
 ZWJfm4cQ7LA39dc95C913bHX4xBh05WiPJWkvmWDBzub5MqDznqVndug0pevtFM1/7JH
 ICTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714384269; x=1714989069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hWGNrlmqtJhlRyvEDH9CFli0qBjeZVbn433NJ/EgQSs=;
 b=KhXjACXxP5QBpXRzPOYvncnc11mU05x/31bYzffWyX8huiiu1uat9eO0viMRap3I8J
 hYtmzj3Kr0VXm7oOTwPM9j219lW0leXwkomsvwE/I3tZnVFU2uprsTyWjZXkB0I4huWO
 ZSPcNlb5d67iMCV2rlCPvMBoHBSZEi28i3l1ZuK0bzvlpRzbrEXkBcY+ermwu8/17WFN
 eyGTONK0X6Ch60uM5wfFRDqCIM1KZ+i1roWT61ubXd2bqrYPKxRHlviauZSX74vBJFv7
 sYpDbMR0z4UzSxD1UFbz70GaGDNswNbNrxL6C6iq3kd05jndazU+MHB+MJzEMpOfAqO3
 cEzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDkKZ8whVKVI2C+Hzr5yRFyk7TDx5ptyliJVUANZwIQJqw1wMO0Euhlg20mlRNRrvYiBI76czW7F1enMWIwLaIS+Aezgs=
X-Gm-Message-State: AOJu0Yw89YmLbQnFsfGo375y+t/uKdTHZyKsO9+bh/QzesUyLdKzphSj
 cfjyPNsSNwRuMXCAZuaC8qPS9LeMFdJYYj0rk3HggBtjqUSyP3EFrMwe/fNtQY8=
X-Google-Smtp-Source: AGHT+IF5hb+qpsSkCWYcWS3VsEOYqXsK4284krtmzvASACIvq7TDM9xCih7i3y9Ntu8LrhCpsHbZFA==
X-Received: by 2002:a2e:3c05:0:b0:2d9:fb60:9afa with SMTP id
 j5-20020a2e3c05000000b002d9fb609afamr7288529lja.40.1714384269310; 
 Mon, 29 Apr 2024 02:51:09 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a5d4dcf000000b0034ccf959d6asm4127989wru.74.2024.04.29.02.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 02:51:08 -0700 (PDT)
Message-ID: <8f93b3e3-dc20-4989-940c-20f87a7e3cfd@linaro.org>
Date: Mon, 29 Apr 2024 11:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20240429094159.514096-1-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240429094159.514096-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

On 29/4/24 11:41, Daniil Tatianin wrote:
> This can be used to force-synchronize the time in guest after a long
> stop-cont pause, which can be useful for serverless-type workload.
> 
> Also add a comment to highlight the fact that this (and one other QMP
> command) only works for the MC146818 RTC controller.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
> 
> Changes since v0:
> - Rename to rtc-inject-irq to match other similar API
> - Add a comment to highlight that this only works for the I386 RTC
> 
> Changes since v1:
> - Added a description below the QMP command to explain how it can be
>    used and what it does.
> 
> ---
>   hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>   include/hw/rtc/mc146818rtc.h |  1 +
>   qapi/misc-target.json        | 18 ++++++++++++++++++
>   3 files changed, 39 insertions(+)
> 
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index f4c1869232..8501b55cbd 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -107,6 +107,11 @@ static void rtc_coalesced_timer_update(MC146818RtcState *s)
>   static QLIST_HEAD(, MC146818RtcState) rtc_devices =
>       QLIST_HEAD_INITIALIZER(rtc_devices);
>   
> +/*
> + * NOTE:
> + * The two QMP functions below are _only_ implemented for the MC146818.
> + * All other RTC devices ignore this.
> + */
>   void qmp_rtc_reset_reinjection(Error **errp)
>   {
>       MC146818RtcState *s;
> @@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>       }
>   }
>   
> +void qmp_rtc_inject_irq(Error **errp)
> +{
> +    MC146818RtcState *s;
> +
> +    /*
> +     * See:
> +     * https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
> +     */
> +    QLIST_FOREACH(s, &rtc_devices, link) {
> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
> +        qemu_irq_raise(s->irq);
> +    }
> +}
> +
>   static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>   {
>       kvm_reset_irq_delivered();
> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
> index 97cec0b3e8..6cd9761d80 100644
> --- a/include/hw/rtc/mc146818rtc.h
> +++ b/include/hw/rtc/mc146818rtc.h
> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
>   void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
>   int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>   void qmp_rtc_reset_reinjection(Error **errp);
> +void qmp_rtc_inject_irq(Error **errp);
>   
>   #endif /* HW_RTC_MC146818RTC_H */
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index 4e0a6492a9..0f2479f8f4 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -19,6 +19,24 @@
>   { 'command': 'rtc-reset-reinjection',
>     'if': 'TARGET_I386' }
>   
> +##
> +# @rtc-inject-irq:
> +#
> +# Inject an RTC interrupt. This command forces the guest to synchornize
> +# the time with RTC. This is useful after a long stop-cont pause, which
> +# is common for serverless-type workload.
> +#
> +# Since: 9.1
> +#
> +# Example:
> +#
> +#     -> { "execute": "rtc-inject-irq" }
> +#     <- { "return": {} }
> +#
> +##
> +{ 'command': 'rtc-inject-irq',
> +  'if': 'TARGET_I386' }

Why is that restricted to x86? Ah, this is specific to the MC146818
RTC... Other machines use hw accelerators and the MC146818, aren't
we interested in synchronizing them the same way?

Personally I'd name this command 'mc146818rtc-raise-irq-broadcast',
KISS.

