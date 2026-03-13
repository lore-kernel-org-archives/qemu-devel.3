Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B62107BCC6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15D1-0007Wm-4A; Fri, 13 Mar 2026 12:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Cx-0007WL-UW
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:17:51 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Cw-0006Eb-ES
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:17:51 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-359f35dfef6so1332011a91.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773418669; x=1774023469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kXjMv/TqhfYh0WblpgOzdU1hY1cA19DKhUAMMrZHey0=;
 b=JdUUdN8QbAHOb1pW4UZVHkFpS6kxAsBe8qc2xf7UZfghTwTrfs5Bm34FWlTaCLths+
 ceJIV65l4EiB/7EAatzJ38qaNsPa5MlHCvxK+2xBa1Zj0wen42iZmc2SjDQ14GrsYzAm
 dIcRcfdcCDfzu3S+kEJcmMuD8XeNImaK2MFqvw0kDkk+CDcyXSiNv5UXGpIGjNvJdkg1
 S0rfqaS/ghOlDlO0akKmrpnIHE3kKVi9SQcsXhn0/5rWQw8iyt/s/znCRCjjBdTebZcY
 Bb0TVMR+kgVWvCOM3us1UFJL8/k7bzgDUpU8iGSjTBlpJRtCzaAymCCYK38mTLii8L/9
 RdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773418669; x=1774023469;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kXjMv/TqhfYh0WblpgOzdU1hY1cA19DKhUAMMrZHey0=;
 b=J7dGnRWmxeC5NtsgQ8ndpv79h+3P6qZsJDTgNpeBPW1JIMddsxkIbbV8otKZrCraTf
 nfa27gfirAt+EQqVpYqT9SpYmyFH81lxjI9rMKzl3a5HYVeg2OiA7exnx/v9FBnaPKfj
 YSY6tc6ThEux1NPDH1Pv1NqYeHQ12afffiVzhFVZUvUpMOHwZ9WD/ROsDytBvEs0jELm
 2SA31jHD3Xby9Zu3LgzFZbFFt1XxuAB8YgHMgN2N1U2NfKx7qUGieSebzBFNYvJX0IyI
 ZJ/AndFwkGnwh8p3FG7xz7l+NpKDM0HNoZWDeRmNb4qYtVqoLmP9q4C5nXMDfc8C13tC
 CR0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaxKuU/gnHOSJulLNo1R0lWt/epS/aPWxkRVU/D47b8pPWcsmnT1tokAhhu7n7dFG9r7ryWcNmuC2X@nongnu.org
X-Gm-Message-State: AOJu0Yz6mcKlpNSM70HZ6FGHgpiO1JQ4qbLwUpQAhZIrggpQ7waGTs4A
 215p/tjvgoGm1lOr7feLiGvUpboLuiX5ybVsyp401LCcLcBXSNj9R1bzEfVbBy/qp8Y=
X-Gm-Gg: ATEYQzxHzcJ+iGoTyM0BlJQ7T/8Jr1JOwD0+wv4z4QerpDZXY2pQS3u6FII2O/rbKxx
 lcRWLpfub0PxgsObHFFT7ZikqE3tgBY3xVRze3c6hcEZYctUxyvrSNRLHZoM/4/q/ke5OXU2pbY
 Wpe597VVCsEQMYM1kGSLGOEU+btf1s7V8RWUDvW5HGEbVf4YPzAgV+GwOxW8uNcfIcTGIXFScxu
 yWhS0I7PGPFkkzivdzIjnn60BEEiXklG86/u/nHVOt9aknD1BfxmgBfncL/ZZQQneIDYfcNETqd
 gFPNF7d8QT9SU+LQYOVWX6ugk6KthHUOJExvvFc0sKlph9FJdAHo2eolWRyxY6qqNLsgf5ofNOW
 Ix8Y8t0t6wO1+zgf5mVYuCNrY1VZTM9Y2MNjty/lP1gSSHMr+97KVjWjXv+75OXFX9IVPBt/NhV
 JCNz/lGaCXiflENodkWDE5vRCn/fWTC9abz7DwqSktPk+JQyyJ93bqLi29ESXx+Bueribs
X-Received: by 2002:a17:90a:e7d1:b0:359:fecd:1cd3 with SMTP id
 98e67ed59e1d1-35a2205551fmr3261902a91.23.1773418668808; 
 Fri, 13 Mar 2026 09:17:48 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e18e46sm9292913a91.4.2026.03.13.09.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:17:48 -0700 (PDT)
Message-ID: <67a6cd68-34c2-4dc9-9e44-ca3f66f0e103@linaro.org>
Date: Fri, 13 Mar 2026 09:17:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-4-pierrick.bouvier@linaro.org>
 <6492850c-12b6-4687-a07a-99530e2553ae@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <6492850c-12b6-4687-a07a-99530e2553ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/26 8:20 PM, Philippe Mathieu-Daudé wrote:
> On 12/3/26 23:44, Pierrick Bouvier wrote:
>> Add stubs for needed functions.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
>>    hw/vfio/pci-quirks.c |  5 -----
>>    hw/vfio/meson.build  |  3 ++-
>>    3 files changed, 22 insertions(+), 6 deletions(-)
>>    create mode 100644 hw/vfio/igd-stubs.c
> 
> 
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index f32d8573600..562ba79d1c0 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -16,7 +16,8 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>>    ))
>>    vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
>>    vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
>> -vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
>> +vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'),
>> +                                     if_false: files('igd-stubs.c'))
> 
> Directly add to global stubs source set, otherwise:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Will do it too, thanks.

