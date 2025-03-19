Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADACC35FF1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 07:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tunTC-0004jI-K9; Wed, 19 Mar 2025 03:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunT9-0004io-1v
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:04:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunT7-0002Ll-E7
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:04:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso271777f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742367838; x=1742972638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7fzQMjdihmdHdTMPhZwn9J/dZihgq/4Rbt5LNPXzbk8=;
 b=AYt9uWDngTOcG8wwI2sjI1bLHwqC/hU+nzflU8f0/+z9Qzcy2SHzoMWYZqEzeF16Oz
 nPEgUOwemJgFaEZacy6sbjXxFa90xzITNgaYRWhdHGlpvgeTmdxGWr8JI+SHoa+oaENf
 nIZlHAapCuhUg6cBkRslggCDnaHGV85wID/rKXPYDfQXQK8jXSTLP8mGRLk/7zKQtDYj
 qME3Pkq25kPpWdDCq01R7RICUVyJCIY5WGaPxQLxfEUxT6JOHl2AZe4x0UDFt8kYX6bC
 lzQkFPVdaw6KBMCUXJl9BJVZZE2GQSOS+mVhHOZjFjZP1k8N/B8+Eo9wqCKJA78rhMCw
 SBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742367838; x=1742972638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7fzQMjdihmdHdTMPhZwn9J/dZihgq/4Rbt5LNPXzbk8=;
 b=WJi49F9BvaenISza/lWC3LE6EENc4pGcOcWXI5ZXLXgzXbD3aY6T2bWiAHaU8ZjloX
 8bIbYa1XDI9Aiw1l6EHVRqGM9zH4egCAES/Q8qd2gqYU5sJ1duAPadSBUuRjJmCvn1zY
 eEO0W2HefNkz1VrQfIJ5FLmxHCpuIS4bFR4CkIf8Cck4MI4WQvaM053O/CBDMojxp/SA
 lCU5eoFi6caRroK2x1XOg75GorRhaRxrtvadPmlyMpFsmxpTByunkV8hiXT3GRZy7JLW
 9skHkqF3T0u+AnRsUx5FJ85kIOVs6bqk0Zkt2G3axR8a1UepMtSplTY5hfaCWkdL2l7p
 t50w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcB/OfLdhTUDksDMW+tA7w2tlVrWdVFIAFoJRIpkNvnSMD96YwaRXHntyqT7M8bs2kfjaiBc/9o15H@nongnu.org
X-Gm-Message-State: AOJu0YxyQ3YHGXe0SR48XFrbMqbUCo9cAc6R1Tze4BAo+ja5kBP71y56
 TF+e04Acb4GCW9UjU4vAfOvoE4Mi+JOjrHCB/zaYB9njplqdcwwZvVBQfdwi0XM=
X-Gm-Gg: ASbGncsCHw+Zepy5m1ZNge65Pwcs8lxlsWVKg0r/1AVAg0OAcjNxgWRXAfHlD7Tv7LB
 zbZY536WPhUG2fjEHfaMSfvoKo64SuIo/tt+++l1ZRGxOfnaQ9jVJXIfn5PDkh+4kjbGExpwOTY
 KHTOLpTLQSpquYUBftKSrBZWBR9U6HTN2BDA4HTlim6vwXC8DFigzEUK2TyL+g0B8Jz1w/r2eut
 8cqvHn0mhEtb94N7GUdpzvy+L7cz6qS+QV7j4kdugiTjHPtRIW+OPjHYPbc4uwvuqrBpHULDDWB
 /uGdeEokXcxwhM1l3hMB028GyZ5fhuqh5T1JQnfiITHYEQaLDp5SE7pgLqiC6TF+5v8BNwObPd9
 NzcJE7KBvjXP2
X-Google-Smtp-Source: AGHT+IGZ1OYYU+hacx0hWCwMirBGV2FRtf+/lifMq6+bgxTMfGuPKE3k3/xaTQ/8RTztiUkGX9yLLg==
X-Received: by 2002:a5d:5f93:0:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-3996bb51f57mr5507704f8f.15.1742367837893; 
 Wed, 19 Mar 2025 00:03:57 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888167bsm20067597f8f.45.2025.03.19.00.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 00:03:57 -0700 (PDT)
Message-ID: <52c8b6dc-048c-49d2-b535-4855b9f3d26b@linaro.org>
Date: Wed, 19 Mar 2025 08:03:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/arm/cpu: define ARM_MAX_VQ once for aarch32
 and aarch64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-10-pierrick.bouvier@linaro.org>
 <a88f54cb-73be-4947-b3be-aa12b120f07e@linaro.org>
 <52000c3d-827f-4e21-afa3-f191c6636b9d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <52000c3d-827f-4e21-afa3-f191c6636b9d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 18/3/25 23:02, Pierrick Bouvier wrote:
> On 3/18/25 11:50, Philippe Mathieu-Daudé wrote:
>> On 18/3/25 05:51, Pierrick Bouvier wrote:
>>> This will affect zregs field for aarch32.
>>> This field is used for MVE and SVE implementations. MVE implementation
>>> is clipping index value to 0 or 1 for zregs[*].d[],
>>> so we should not touch the rest of data in this case anyway.
>>
>> We should describe why it is safe for migration.
>>
>> I.e. vmstate_za depends on za_needed() -> SME, not included in 32-bit
>> cpus, etc.
>>
>> Should we update target/arm/machine.c in this same patch, or a
>> preliminary one?
>>
> 
> vmstate_za definition and inclusion in vmstate_arm_cpu is under #ifdef 
> TARGET_AARCH64. In this case (TARGET_AARCH64), ARM_MAX_VQ was already 
> defined as 16, so there should not be any change.

I'm not saying this is invalid, I'm trying to say we need to document
why it is safe.

> Other values depending on ARM_MAX_VQ, for migration, are as well under 
> TARGET_AARCH64 ifdefs (vmstate_zreg_hi_reg, vmstate_preg_reg, 
> vmstate_vreg).
> 
> And for vmstate_vfp, which is present for aarch32 as well, the size of 
> data under each register is specifically set to 2.
> VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[0].d, ARMCPU, 0, 2)
> 
> So even if storage has more space, it should not impact any usage of it.
> 
> Even though this change is trivial, I didn't do it blindly to "make it 
> compile" and I checked the various usages of ARM_MAX_VQ and zregs, and I 
> didn't see anything that seems to be a problem.

You did the analysis once, let's add it in the commit description so
other developers looking at this commit won't have to do it again.

> 
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    target/arm/cpu.h | 6 +-----
>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index 27a0d4550f2..00f78d64bd8 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -169,11 +169,7 @@ typedef struct ARMGenericTimer {
>>>     * Align the data for use with TCG host vector operations.
>>>     */
>>> -#ifdef TARGET_AARCH64
>>> -# define ARM_MAX_VQ    16
>>> -#else
>>> -# define ARM_MAX_VQ    1
>>> -#endif
>>> +#define ARM_MAX_VQ    16
>>>    typedef struct ARMVectorReg {
>>>        uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
>>
> 


