Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D3EC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThv6-0000wI-T4; Mon, 23 Jun 2025 10:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uThv2-0000vo-UU
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:13:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uThv0-0000zX-Uu
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:13:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so49245555e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750687984; x=1751292784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EP9uRpz6KUo+Z470gstj5u4qCsKn29dYzbzqurzNUco=;
 b=ImmI6cU1CkbNrmqCKO3uWxAUx4FxidDF/3hBPszZI76h3X191dDK5vH2b6KEacl8h0
 Sk7Pym6PwkzM5TOYZy1hCVOt124UVqVm5WQYNkLNTS4GKWXK46g85TKxmntUFMFIsHiT
 dlsR5ap0LWyVxdM7nwOELL2DbFIXamVJajNg8QLUReSsD4Jh7OsY6yRf6l/NdAJj1FmJ
 paVMd7ElcKgc0aZvRziEauezjDhcOn71AeZb8sx3ou+rRt5B4fm5JMXppPedi/4YmRRR
 LFW6IpFMwfPUEWgu7P9DzBHQUxTn57TWRuOszGSfx07ewGqYdJsTPglKXgT3tXbwKuKe
 frLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687984; x=1751292784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EP9uRpz6KUo+Z470gstj5u4qCsKn29dYzbzqurzNUco=;
 b=sE8kjwMhP89/31mg8Ys8ShYiM8evx+2qHY8tMsmCJmmrzR5LNa8DQfa77+mxotXKiR
 InyzFmFNfAvjRmJqinMmoCl3pXHs+e3/Wl2vp3T54QH7AHx12SLXeZlXKZuic+a9L1mj
 aigZB+FDbDlapyyUAf1o54d06JtcYmAN5ti/z/5UIPH18lQo5J/SFLYnmJt4a2Vzgkig
 5d9HpOsbsnTpiJsIjTr2ECR4dwNcYAxQ8xIHwfRIjnupNN1KGJcgB1/SEOfbKnU3K/DF
 btllX8HQ5gS6Z1ITjvV4KI6AUbJ6J26WYcIqAMzXDb+rA3PCU9gXJr9nfC3MXK/gJEnj
 ijGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5YFDpDyohXWt+RPTFbSyKZlKZF9o2wPncHDm/wLoVzCzsFA7/4aOFH8Pu2OHkeKQ+gQd3vi7iL0Kb@nongnu.org
X-Gm-Message-State: AOJu0YwVSe773+ybEx8rVjDrxYsdbWUPtx6p4UF6/8b+JpDFwjREx5LM
 nJuaJvNga2vnMKCmcJC1mm6YK99nvygj6NJ/1LcoSdHrytOatfXx3eth1FVRClfUzVY=
X-Gm-Gg: ASbGnctKWt1LXZ0T1+gmsX2yhJUHDI8p4IiKlr0aaO9mEzsIxuMZdAa0zJ1ZiO6SwXF
 CUWILGCchwlE6dLBYK3uFQIr6lKsuedm3wbtL7uYQYgguZUmVoyftmCcdDmfJ0FT3BkNxUbqa/8
 5u0N1Kqq7VTf2uov986Iq3yQBoA/jP+fSNlpD0s4sx67p/y+c/aiy4myhnRXiIiKpgISu1pOCXl
 j1Zz/4wlF0g9KMnBUcax2eh6WVEsHphWe+RpkGPBuAS31LX98maPlF59yn11ogLHDpimRYCbs/O
 WhLZ+wHyLJUTk4Dh9jveXnQU95yAGyUIY+dRBwNl7KE3HH3moW/7DviLZm2tmbQGKwgDrMPgxi/
 DaG7AF2PSO4mY53p8fe2P0b6OAv731w==
X-Google-Smtp-Source: AGHT+IGi7SHzj52cHmVskgNHwYtw5MaFHqJ+Xxpl3ia0pJG/THko8dmnwwVUehWpW9VuPeIbuzWHtA==
X-Received: by 2002:a5d:5846:0:b0:3a4:e6e6:a026 with SMTP id
 ffacd0b85a97d-3a6d131708fmr11132940f8f.28.1750687984559; 
 Mon, 23 Jun 2025 07:13:04 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8edbsm146213955e9.24.2025.06.23.07.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 07:13:04 -0700 (PDT)
Message-ID: <17bdda1f-e8a7-4fdf-86d0-93401aa1316e@linaro.org>
Date: Mon, 23 Jun 2025 16:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 20/48] cpus: Rename 'vcpu_dirty' field as negated
 'hwaccel_synchronized'
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-21-philmd@linaro.org>
 <d3b975ac-c85a-449d-98e0-705313ac04c7@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d3b975ac-c85a-449d-98e0-705313ac04c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 22/6/25 03:35, Richard Henderson wrote:
> On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
>> Try to better describe which side is dirty (QEMU process or
>> hardware accelerator) by renaming as @hwaccel_synchronized.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/core/cpu.h |  4 ++--
>>   accel/kvm/kvm-all.c   | 20 ++++++++++----------
>>   target/mips/kvm.c     |  4 ++--
>>   3 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 69ea425c458..d5f82609943 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -441,7 +441,7 @@ struct qemu_work_item;
>>    * @opaque: User data.
>>    * @mem_io_pc: Host Program Counter at which the memory was accessed.
>>    * @accel: Pointer to accelerator specific state.
>> - * @vcpu_dirty: Hardware accelerator is not synchronized with QEMU state
>> + * @hwaccel_synchronized: Hardware accelerator is synchronized with 
>> QEMU state
> 
> Is this change really helpful?  It isn't to me...
> 
> If you want to change anything, this could be a tri-state enum:
> 
>    - qemu state is current
>    - hwaccel state is current
>    - qemu+hwaccel are synced

Good idea. I'll drop these patches for now.


