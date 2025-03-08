Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DBDC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 07:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqov1-0003Za-B4; Sat, 08 Mar 2025 02:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqov0-0003ZK-6N
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:48:22 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqouy-0001NC-Le
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:48:21 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so1489796f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 23:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741420099; x=1742024899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lqx0imBMWohBZGuxO2RdS5AX1BDydHw1hjAs9+7NNsY=;
 b=CE1AZdBZIWssnzmEjRp9mem4CTzeKF84D5RETxozdZ2pCJ+zSe5wEmGOoxCJWaWVkA
 L6rvM9CWB+y+t0rPCNmGmYNeADfznyR30rjhUTd2bOVTNBiFhK8g6otAZbfZcMhUchFg
 zVT1AHN9Z1AWBxxUh6p5FxAtCNbJlo0UhnCXwa1nX8rKtT6WJAosoMhOJ3ZzgcEGvnlU
 Nh3ZNBJ30uwTtRFCrrker3gSeE1YJ1uh0xl5kZHWBqLwQXjEKMbpdI1ONyxqaCKXxExU
 TMUbVtiI4pEvAJ/0uS5nJzXj/GXXWLuv1kpHyufxf2CpsjqkAQLLTCC0nkGIA/JGI+qp
 1Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741420099; x=1742024899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lqx0imBMWohBZGuxO2RdS5AX1BDydHw1hjAs9+7NNsY=;
 b=LBF3Gm8u6UxeLfWAu08q0hq0S+dp/JdOxcN+cHNmocMdHj5GE2zVQBiLxlPq83+R0/
 mt2KbblkcMX1XJ5bGWOwE2u3atEavCvUdv+2h0/yAL3kuj41cXTeOwjdtRbcTgm7KfDr
 FF5Hud3dpElf1EQqf59S4U6MOY+Cfm/gJaE7cWuPyUR0MJOzoe0DkZ5J3C8soQYBSrcq
 nfgQYIGX6UbDNN+jjRkwrE7oqoWY/g/XoOqckv5U2hKLi2Q0o+PhfNium2Hw8/GiCIQv
 OzEtmbkrWJK+vCmQ4fe4DEIcfvvgNDZqw2NJ9p5IWcV28DWx9AwBlwQIuZTy91a7IRJO
 Grhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXrzQ8ntOApP1BP+LmFcLAoZXeME8McdR6Q0Nhxgu96PRcFU6/ZZD2mUE1TUZA4M1K00WVG93+CG1r@nongnu.org
X-Gm-Message-State: AOJu0YyPveHJTb6jZqB52DgPpyv8TtYvhbF6kWGdVr1cqRQmiZ3abvO5
 Ks/FJZHJtqvinLxLaMSMueJsbzfpAaK5l6nfaTAR1DLRhijJUnrSWXrjknfXPWk=
X-Gm-Gg: ASbGnct+Sr04HxeID68NXCziuRDMkdWFfFgbeDKuvsM86fhxHkBBvaTKd3RhHQRh1oc
 7W2TPljUo9EMxQXyRL5flZtn41QhigipjNSjLHGbRT9g9j0EyM1akX+neJjbDaxkSqAN9b/a9g2
 rLr8j4HRWwr8eSTSNCTys6LTR5O0Uays6tiWhV4/TEYeCQRZRE24IpN7Ydj/Wf/FlyI84tuUkrr
 2EhIRkfPtGtmO43EMVSn3v48U+5cwc0ImVZfmusVEGGUwq8fThY4WuW4K9UHAPZ/6CYPp+NxjRz
 ZtxYfP5zlls9ZhE1AKzvZSuul7kCYjWY8pqCbRtqIXAlwHHctPfgHt0ju2YLaLASes6ZwMZmd0D
 3JrIRnYfpfMhK
X-Google-Smtp-Source: AGHT+IEcpnIkhJDtx3SNzJPp3leVjUbdE+DYyRH37FqyYFijTB+usumWCcHW/pbsJviyflNxffyJ3Q==
X-Received: by 2002:a5d:47cc:0:b0:38d:bccf:f342 with SMTP id
 ffacd0b85a97d-39132db8b3cmr4961580f8f.43.1741420098735; 
 Fri, 07 Mar 2025 23:48:18 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd9471b7sm74584175e9.34.2025.03.07.23.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 23:48:18 -0800 (PST)
Message-ID: <85901dab-29a5-4d50-b122-29333f7ebcd9@linaro.org>
Date: Sat, 8 Mar 2025 08:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] system/iommufd: Introduce iommufd_builtin() helper
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-11-philmd@linaro.org>
 <1e7b5507-e226-44bd-afec-0261ee3549ce@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1e7b5507-e226-44bd-afec-0261ee3549ce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 7/3/25 21:33, Richard Henderson wrote:
> On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
>> iommufd_builtin() can be used to check at runtime whether
>> the IOMMUFD feature is built in a qemu-system binary.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/devel/vfio-iommufd.rst | 2 +-
>>   include/system/iommufd.h    | 8 ++++++++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
>> index 3d1c11f175e..08882094eee 100644
>> --- a/docs/devel/vfio-iommufd.rst
>> +++ b/docs/devel/vfio-iommufd.rst
>> @@ -88,7 +88,7 @@ Step 2: configure QEMU
>>   ----------------------
>>   Interactions with the ``/dev/iommu`` are abstracted by a new iommufd
>> -object (compiled in with the ``CONFIG_IOMMUFD`` option).
>> +object (which availability can be checked at runtime using 
>> ``iommufd_builtin()``).
>>   Any QEMU device (e.g. VFIO device) wishing to use ``/dev/iommu`` must
>>   be linked with an iommufd object. It gets a new optional property
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index cbab75bfbf6..ce459254025 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -63,4 +63,12 @@ bool 
>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>                                         Error **errp);
>>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "- 
>> iommufd"
>> +
>> +static inline bool iommufd_builtin(void)
>> +{
>> +    bool ambig = false;
>> +
>> +    return object_resolve_path_type("", TYPE_IOMMUFD_BACKEND, &ambig) 
>> || ambig;
>> +}
>> +
>>   #endif
> 
> Interesting solution.

Actually this isn't appropriate as this checks for an *instance*, while
we only want the *class*.

I'll respin a different approach.

