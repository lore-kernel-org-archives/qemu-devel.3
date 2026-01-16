Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9D9C982D1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 16:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgmhw-0000bf-U5; Fri, 16 Jan 2026 11:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgmhn-0000aD-1y
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 11:29:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgmhl-00074w-6h
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 11:29:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so7795175e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 08:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768580982; x=1769185782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tjG4vIAWwuc+XtwynpzOFi2h/9DUenqkua/KON79W9E=;
 b=arDRPp07JDrTpHx60ijQmJPLtyt8PUL5e07ju0NWAZW7MxXAd9nT9+vrLqyBsfFszP
 exIdS57Cc36wfzqoUv1NCPcx7wDCjPIOX4aTT26kifbR6SzsPLXgdrgMBIoQLCbHC0sm
 bXa+gjEQRWTXsqYlmdcUucQitPKzplw6zEbwrdF9OQLHv7hZlhKk/Uak+pyfdrHzZI5Y
 J1sVyDhTBAbWWNLV10NvOFHXVVavh9LUW5If1GoC/a1Ha2sjYLFFrQuHNU4hTdNG0qNb
 ReLyLJpLQ/gbMADgcvLwWunooCmSdHgbzeHknXssC1uox90GVDp1sCoPh5Z83gCU5aRX
 jRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768580982; x=1769185782;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tjG4vIAWwuc+XtwynpzOFi2h/9DUenqkua/KON79W9E=;
 b=WaM3NqIrLCycDC+ILsXIEeuS9ttGHP6Qw7NVAY/XIIbljCbl9ImvsJrUY9y611amfB
 +hnrXwZMvKFfuPnhbjoB/lqgtMNKNsHCM9mxwiqhhJRs5S2xvEnE5GT1rMma0sx+Yx/a
 m9WonOEPCHru1i98kEFK3U0WRt370X1oYjR3cf8YNXBT/q5tdCb9Z9y+NH0awQcb3i+y
 IYNtBkC3JLWQuJ93WoRiLeHuVs6e3zb8gT3Mb8iBDRAyU+uhnTrNOtzoRtgg/O43HSk1
 Avxkz4cf8ndCsiLkZHVYx2ainqTqLZf3fsHExxW2CxGklB12KIu1jJvBkpKATnVQ47EO
 kNvA==
X-Gm-Message-State: AOJu0Yy9jEVkYWTJaKTuU74wEyGID5vIq9v+zqVPxsZYDaNXgSpHQdwO
 HsdOMrIkCsDgDymQE41Ne/LAa2IFeIeTnAq1HRk8eIyxCTgj6EHODBF1PyPmXagQZT0=
X-Gm-Gg: AY/fxX4wlrieEaYw/YGsfdF0xYgiYNc6rFJ8EmOnBLATZ5THAPQyK+3Z2TXP3SBGTKf
 S6J7K0kVmMnnqH5fg3tmDB+cGjUDXxB9SNOgh1ZRqHky+zBpg/w/GB56USYC1hde3Ze/Hk/yRHc
 wzhCK+4WBchvSstG8gECxmZQXXjiI9HHmI8Vy897+UGLukj4U/uAc35qd0HXwQ3PbtuKMS3TZ/j
 SeAYyfkU6ObOEoQPfdP+/s2xcr4RYC1g+Ae/u5vC08cU5y9rLvBrEo3PBAeeNJn8muiKbJso5Wm
 HZvA3tEX37bhA4F+IRPj9gdbxDsQ4AmAYhRU83fJifYkEyrKEJ1nPhmu3yTYerggR9tskHV1Ivb
 TP5VdkCpJbKANNZZhrePljXBNwYh8/IWuVBg8U2DbPRaIoE2ukbIlC3swmQzdPQJmyUwp9oSaoY
 fuCAY7NCDzT9KelhNR2fF/YWlpl21CP6fVJdkkxMcy3DsvCPM1gt4i4w==
X-Received: by 2002:a05:600c:458c:b0:47d:6856:9bd9 with SMTP id
 5b1f17b1804b1-4801e3342bamr33031195e9.23.1768580981897; 
 Fri, 16 Jan 2026 08:29:41 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569927007sm5989271f8f.16.2026.01.16.08.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 08:29:41 -0800 (PST)
Message-ID: <9405870c-1278-43a7-9fdf-ba986e362ed2@linaro.org>
Date: Fri, 16 Jan 2026 17:29:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 15/26] whpx: add arm64 support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-16-mohamed@unpredictable.fr>
 <23800170-66aa-4e31-9e74-e256933c8a8b@linaro.org>
 <D57D8689-9535-41D8-9818-79E544E46DB1@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D57D8689-9535-41D8-9818-79E544E46DB1@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/1/26 15:58, Mohamed Mediouni wrote:
> 
> 
>> On 16. Jan 2026, at 15:21, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 16/1/26 14:52, Mohamed Mediouni wrote:
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   accel/whpx/whpx-common.c    |   1 +
>>>   target/arm/meson.build      |   1 +
>>>   target/arm/whpx/meson.build |   3 +
>>>   target/arm/whpx/whpx-all.c  | 810 ++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 815 insertions(+)
>>>   create mode 100644 target/arm/whpx/meson.build
>>>   create mode 100644 target/arm/whpx/whpx-all.c
>>
>>
>>> +void whpx_apply_breakpoints(
>>> +    struct whpx_breakpoint_collection *breakpoints,
>>> +    CPUState *cpu,
>>> +    bool resuming)
>>> +{
>>> +
>>
>>         g_assert_not_reached() ?
>>
>>> +}
>>> +void whpx_translate_cpu_breakpoints(
>>> +    struct whpx_breakpoints *breakpoints,
>>> +    CPUState *cpu,
>>> +    int cpu_breakpoint_count)
>>> +{
>>> +
>>
>>         g_assert_not_reached() ?
>>
>>> +}
>>
> Hello,
> 
> Called unconditionally today from the common code. But does nothing as breakpoints aren’t supported on the platform.
> 
> If trying to actually enable a breakpoint, common code will go through whpx_set_exception_exit_bitmap and error there.

Ah OK, then let's just add /* Breakpoints aren’t supported on this 
platform */ twice.


