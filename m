Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B64C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 07:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZR3n-00047O-OJ; Mon, 12 Feb 2024 02:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZR3l-000477-QG
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 02:49:01 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZR3k-0004q5-9u
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 02:49:01 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so347886666b.0
 for <qemu-devel@nongnu.org>; Sun, 11 Feb 2024 23:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707724138; x=1708328938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wQDKhwTfEXGghPsjlGwrqJ58pnK88T+nOwAAHbKGaU8=;
 b=ggyNTO8rWqmjTq8yATxRMl4N9EVzfKZkpCqBfApLMSUnI+2qFjAT/6c+mHM2qcMNoW
 z0sEH/dCj4ncO7JhXRxFhnZoJ69YQE/O/C7YGy/Rr5GWquOBMPz43N+mHnUYXv5cdHzS
 gTiGAt1JSEH67WBpUZekS8ozhXclqcVgO2kaOjDw3goh+szV9TbO1FBqFZOrT0rEZ4Ah
 La3aDWZs3qAjyhFALE/wP+o8AyiqYiyYr3BaIhEtpkKR4XraexS2ub2bHslhyTSnY2ZA
 YG9rACFZbqKgYP/LKO8JxrqyNxIl7RrU/QSFuEOgl052OWNcqyikWg77U7k9YbyUK7qq
 dP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707724138; x=1708328938;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wQDKhwTfEXGghPsjlGwrqJ58pnK88T+nOwAAHbKGaU8=;
 b=Yvt4Vs3fiQ7Ywn8de4aMCpR31D78lWT+cHl8xN+Pob5a4XBloescL4nHoceikUdR1D
 IULLbWzPMWjP12rTI6coAef5oOdF3HgZFcWR+CvkBzeqz2m9fuET5J7+87j+HbuhTWui
 A5krf4AZtQhBlCubSFmBDYf/R/iICKg20iIuzxW2SxxUmtG4Hc7YxXAzb7PlR4nuM5Cd
 dgA7FkeC8o7ujwAPDOzMWtg3Skkc9vI1WEfIpenffDISAPZIMjGamvVQMLCD9UqFuVO9
 jJHvZaK4NQKA0DXrpZl0ldLqFDCK+JxXR+e4CAc/G8vPo5OTVnBKzGraW440cuKdhD70
 XRcg==
X-Gm-Message-State: AOJu0Yx+RHbAMycRO8lGN94TvjMNKctYURh+Z6Xq+dkm9wrtBvmeCbWz
 T2RDbwy5EFWTmQmUKxSzcHTxb6im8BdJq7EdsmvFlrD/TBko1nQMVeI0rKkt85U=
X-Google-Smtp-Source: AGHT+IFY2nG9mdmQn311CCtFcaEeYtAodptyeR9YEHZHADLZLK9Xu4PNdDHBs0BxVo0l6NrTiX1HmA==
X-Received: by 2002:a17:906:1b03:b0:a3c:87e4:f021 with SMTP id
 o3-20020a1709061b0300b00a3c87e4f021mr1796248ejg.58.1707724138105; 
 Sun, 11 Feb 2024 23:48:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVFQ0w8dmNTSZcI5dbZTwgF7ce2jimiGngod2Xslzb/+M1wxEpVPv6de2t4bKYu/xwDuKjayQk3QU/1Bn3emn4EUscZJhOZX3HJ+XJlKek3vL9dJMT5S4yX4kLNE3SZIiilaHtmfShGQ44xJpWFfzFAiLvEIru4jROc4iBeQ2OZYBBOO+UWwcixhDRLy1TYPPVx5oVpf4VDO3DjkeMG6AF3/W58JXhKE58fw0aGH+c1AobbuRyimTKnbbr13Vk+5292iWQaZC7um8zpBS5cCbjGw35NO3c=
Received: from [192.168.69.100] (vau06-h02-176-184-43-97.dsl.sta.abo.bbox.fr.
 [176.184.43.97]) by smtp.gmail.com with ESMTPSA id
 hw13-20020a170907a0cd00b00a3820ec721csm3591960ejc.8.2024.02.11.23.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Feb 2024 23:48:57 -0800 (PST)
Message-ID: <319c11de-6e4b-4775-92ee-78c30daff12e@linaro.org>
Date: Mon, 12 Feb 2024 08:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/kvm/ioapic: Replace magic '24' value by proper
 definition
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20240209190110.27413-1-philmd@linaro.org>
 <97f46e08-de06-42fc-9031-07e5eff4fbfb@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <97f46e08-de06-42fc-9031-07e5eff4fbfb@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 10/2/24 09:54, Michael Tokarev wrote:
> 09.02.2024 22:01, Philippe Mathieu-Daudé:
>> Replace '24' -> KVM_IOAPIC_NUM_PINS.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/i386/kvm/ioapic.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
>> index 409d0c8c76..b96fe84eed 100644
>> --- a/hw/i386/kvm/ioapic.c
>> +++ b/hw/i386/kvm/ioapic.c
>> @@ -35,7 +35,7 @@ void kvm_pc_setup_irq_routing(bool pci_enabled)
>>           kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_PIC_SLAVE, i - 8);
>>       }
>>       if (pci_enabled) {
>> -        for (i = 0; i < 24; ++i) {
>> +        for (i = 0; i < KVM_IOAPIC_NUM_PINS; ++i) {
>>               if (i == 0) {
>>                   kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_IOAPIC, 2);
>>               } else if (i != 2) {
> 
> There seems to be some confusion here about
> KVM_IOAPIC_NUM_PINS vs IOAPIC_NUM_PINS (and
> vs ICH9_LPC_IOAPIC_NUM_PINS).

Well this is what I'm trying to clear, isn't it?

KVM irqchip has a hard limit. ICH9_LPC_IOAPIC_NUM_PINS is
specified in the ICH9 datasheet. It is unclear to me what
IOAPIC_NUM_PINS represents, I suppose it emerged from the
evolution of the Frankenstein PC machine to Q35.


