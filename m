Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A26C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 08:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzu9C-0003vr-0j; Thu, 25 Apr 2024 04:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzu8z-0003sj-Ih
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:07:50 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzu8x-0004G3-Jz
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:07:49 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2dac77cdf43so7861781fa.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714032465; x=1714637265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sjPz9avTFv1Uy4UpBNgzgydlZyWuUQcdHiASNJ6CxCI=;
 b=WoUIpaFfFBWJyb71dTGoF+guXweCbQ98H7RoznSJCsEYNqy6IdusgFJs5cgxfEYK4U
 lj0z8w+zMiAc/AOkOF1jW2t2dkIAOi2PMkcnvhgfop/K46/SPMkim+/c8/AsdApe4dPb
 0ZvQ+6vYy3TBdRtScshywwiHJxmomA9vytdhp+DjPH17ezymC4PoSRHOh94yuNoLC5Ek
 jv3nKaRQqyVbuuBkoNZ3EsLU2TLVP6TaRQvXeMUEi2aDPPJnhgby/InRI13VKaxLRvds
 kWwn2c4eN0sm+4GOKajfVUgscQooXd2PL9Z1qs08LYNfvSiLryd4VYohc3+k/E3Nqo1M
 wMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714032465; x=1714637265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sjPz9avTFv1Uy4UpBNgzgydlZyWuUQcdHiASNJ6CxCI=;
 b=pIm+HjKN/nSLW2dnsDjkiGKSd9LaiIiRF6FTv5GwrdugJhQxHgLJsgc/0VunZmPxCM
 T7nVj4FxcI/67PCkJDrfyxUqs06Y2Lut4725LKw3+UwvamTLa5qpGBwRHLKAtlfTWqhw
 8tztqu9N0dfZvSKicoy3oJ1VffkTQwvyG5MvUgVmOpdSGVQj6lOWxz2J0HPXgOTvIWOH
 w5ktUGFnGBH2phFaEpgNltywice7qMyfKLud4dvlAXX1J40mmExIqWHyg9EgETkMWZXn
 v/cTWyTO8dzvxRh8eEaluMWsaDqDSjqeygscuEATTkigMyW1gS7HbZ06w2/Ps4+0WWXJ
 Se9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf8TOHpt7uWM75SyKa6vhZzz1G068CAtwonbuBzJXgpS6vkR0SPBrju8Usi+tYM9NLeoxiHfIB0tDdH0AWUc6nuSGuiJI=
X-Gm-Message-State: AOJu0YwsKTCYqCDQnR64C7Yh6MMlSt3UdWpRqkPfhbfqYaxhYMwJ1R2u
 kJU5rc9sdws5RviNRIlHNALwTjJ/Fe4D3Lxr2Uxcslb/hjUaChPf2cJOWeJjszw=
X-Google-Smtp-Source: AGHT+IFGJwfxG+eqkHOVpLbjhb8Wpm6G7AZZm6LoycMdN/DIxTVq2BVKho9KwlqjmG918U3cB+krXw==
X-Received: by 2002:a2e:a692:0:b0:2dc:bd75:41ba with SMTP id
 q18-20020a2ea692000000b002dcbd7541bamr2942278lje.27.1714032465517; 
 Thu, 25 Apr 2024 01:07:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.201])
 by smtp.gmail.com with ESMTPSA id
 je1-20020a05600c1f8100b0041adf358058sm6683125wmb.27.2024.04.25.01.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 01:07:45 -0700 (PDT)
Message-ID: <4362d061-599a-49bd-aa52-1d440c0eb621@linaro.org>
Date: Thu, 25 Apr 2024 10:07:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] X86: Alias isa-bios area and clean up
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240422200625.2768-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422200625.2768-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 22/4/24 22:06, Bernhard Beschow wrote:
> This series changes the "isa-bios" MemoryRegion to be an alias rather than a
> copy in the pflash case. This fixes issuing pflash commands in the isa-bios
> region which matches real hardware and which some real-world legacy bioses I'm
> running rely on. Furthermore, aliasing in the isa-bios area is already the
> current behavior in the bios (a.k.a. ROM) case, so this series consolidates
> behavior.


> Bernhard Beschow (4):
>    hw/i386/pc_sysfw: Remove unused parameter from pc_isa_bios_init()

To reduce respin churn, I'm queuing the first patch via hw-misc.

