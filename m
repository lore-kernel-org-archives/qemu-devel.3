Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65263FCC9CA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzqBC-0001FW-NG; Tue, 10 Mar 2026 02:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzqBA-0001FK-7b
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:02:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzqB8-000727-GR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:02:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso24130015e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773122568; x=1773727368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P2jrb3phoOWZv7Z1ZfCO+9z0ZPQw7qaLUVxB38YJjt8=;
 b=YcTm7Kcxy1cPo+L2IS/WYk5o0Bq90PXjJlmbcG3811pHSPhhOl3JCCHIcXLLkBZMs8
 qy0z7ShU3T/tMy0/Nqnu7c8DdtuNMJstwZ6cegQRZPISt8pZ+jebukZH3O1y2oKfQ5fi
 olvI95Mhh4Wj+Whyvj62LRFLcMlH3zGHb8W0DQN9YoLFRFqRWEKF6Pe0MUxPHJnnqp+I
 YSFCPjKmAoI7nz3V0JKwUzCi8W4QLQ1On6qD7HA1gaygCFJX1oVJBtUWg9YIZ9vWR8xV
 pEwkqNriWsPX+nCBFRbadjplsrBF+QA2vRATpKvxotHel++jjBuOkJoFrSRfmiRBDX3h
 6X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773122568; x=1773727368;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P2jrb3phoOWZv7Z1ZfCO+9z0ZPQw7qaLUVxB38YJjt8=;
 b=NlUJGkQZ6nDkL0LygdTq7rPdsbzAvofHX2W5oNNjRszVbxB8zK6atH60HGV9eKfDrJ
 3K+rm4Xy1ZDKQLNwJxXZ97uvIKoohSolrpWfsejfSdlKtHbjGXIXzMSXYHXa3zbLB024
 k83fBsLtpFEnOUrzE4FEAiv5McNiyBx1WD8eBTORs1PezrB+HZ319V1A7lfiUYn4a7mG
 IfYvS76S4CVtaIgWC/IM5UlNVEfL4LV5hF9lXp7odSC0uhbOwzULU9YbcbldBtVmbv/y
 WEvertKIY3ulgEE8DZa8RSKyp/NNMh819YrQ8nMj3kcKl4wFCu0ap2NhpKInC0M27hWM
 yB1g==
X-Gm-Message-State: AOJu0YyDiAPRGEYudjOtpqq/7YcnHqOD3sEA7FwWJZ2MireN4Qd5CB0U
 wmzWUZECFb0pgXiP3EiMLwyDHxhBNJ0wjGBnDmXnSide9VtY5kbD76EvNlrCMRcH4uI=
X-Gm-Gg: ATEYQzx4LHvOW/Sn7AYHnfF7+rb4UGzK+IJGrNhiWz32eYMol3m6lrihqev711cvJau
 puYJ4G+QnrxZ77DeC1VUQQtWivbdIMFQpH7/XqqZCy/gIVbHYcCn3FZ4P4F/BBL2eW3f+FUAcJ3
 e/QgialMXSoMHoICB2bxOV0lcK3ZNAuAC4rMTb8txohmuCe/6TwrdRRgp4RsjfwwXcOcinN3UAA
 4ZrSuo85ITADzsqFWlr6AHwu5TKUZ6CvEqf5d3oE7zInALPgngzEXkP1nbX8ozLnHMhi3PgtLac
 Fmnid5Hae46gUfC6iv51lP7iScZZYzGVMWEe7Z49qqtfSjT4h0u1STzwNLQOZdhY+HZG5TigzCL
 zVMqqZdsXjFuSZCMKdJ3XhWgmQ1CPxtICFngsh8LVzh1+m3HOokCX4GlYKXde/kdsXahZM5qS7w
 MAItreIRNu9bU4SdcR0ttClpg18rW8Lzi5CVJOEqjm24K7YP/usyq1FjfBTQXmXHr85Q==
X-Received: by 2002:a05:600c:a00a:b0:485:2fc5:39e with SMTP id
 5b1f17b1804b1-4852fc50624mr161017095e9.27.1773122568423; 
 Mon, 09 Mar 2026 23:02:48 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae46353sm38044536f8f.33.2026.03.09.23.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 23:02:47 -0700 (PDT)
Message-ID: <fae99013-5fe8-4820-b38c-69545c3e77a9@linaro.org>
Date: Tue, 10 Mar 2026 07:02:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260309092027.404489-1-zhenzhong.duan@intel.com>
 <02d2312f-99a8-44b2-b55a-b9cbc72feb60@linaro.org>
 <aa7Dw5PBcqLpG5HC@redhat.com>
 <IA3PR11MB9136B00F46D18E977140FFDF9246A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <IA3PR11MB9136B00F46D18E977140FFDF9246A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 10/3/26 04:16, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Daniel P. Berrangé <berrange@redhat.com>
>> Subject: Re: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode' and
>> 'x-flts' properties
>>
>> On Mon, Mar 09, 2026 at 01:44:15PM +0100, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> On 9/3/26 10:20, Zhenzhong Duan wrote:
>>>> We had 'x-scalable-mode' for more than 5 years and 'x-flts' for more than 1
>>>> year, it's fine to remove 'x-' now.
>>>>
>>>> This is a prerequisite to enable intel_iommu's scalable mode and first stage
>>>> translation support in libvirt.
>>>>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>    docs/devel/vfio-iommufd.rst    | 10 +++++-----
>>>>    hw/i386/intel_iommu.c          |  8 ++++----
>>>>    hw/i386/intel_iommu_accel.c    |  4 ++--
>>>>    tests/qtest/intel-iommu-test.c |  2 +-
>>>>    4 files changed, 12 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
>>>> index 78bcdffac7..5755532443 100644
>>>> --- a/docs/devel/vfio-iommufd.rst
>>>> +++ b/docs/devel/vfio-iommufd.rst
>>>> @@ -153,22 +153,22 @@ RAM discarding for mdev.
>>>>    ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
>>>>    devices are always mdev and RAM discarding is force enabled.
>>>> -Usage with intel_iommu featuring x-flts=on
>>>> +Usage with intel_iommu featuring flts=on
>>>>    ------------------------------------------
>>>>    Only IOMMUFD backed VFIO device is supported when intel_iommu is
>> configured
>>>> -with x-flts=on, for legacy container backed VFIO device, below error shows:
>>>> +with flts=on, for legacy container backed VFIO device, below error shows:
>>>>    .. code-block:: none
>>>> -    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio
>> 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when x-flts=on
>>>> +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio
>> 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when flts=on
>>>>    VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
>>>>    otherwise below error shows:
>>>>    .. code-block:: none
>>>> -    qemu-system-x86_64: -device vfio-
>> pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed
>> to set vIOMMU: Host device downstream to a PCI bridge is unsupported when x-
>> flts=on
>>>> +    qemu-system-x86_64: -device vfio-
>> pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed
>> to set vIOMMU: Host device downstream to a PCI bridge is unsupported when
>> flts=on
>>>>    If host IOMMU has ERRATA_772415_SPR17, running guest with
>> "intel_iommu=on,sm_off"
>>>>    is unsupported, kexec or reboot guest from "intel_iommu=on,sm_on" to
>>>> @@ -177,4 +177,4 @@ below if it's not needed by guest:
>>>>    .. code-block:: bash
>>>> -    -device intel-iommu,x-scalable-mode=off
>>>> +    -device intel-iommu,scalable-mode=off
>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>> index d24ba989bf..001847ad37 100644
>>>> --- a/hw/i386/intel_iommu.c
>>>> +++ b/hw/i386/intel_iommu.c
>>>> @@ -4200,8 +4200,8 @@ static const Property vtd_properties[] = {
>>>>        DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
>>>>                          VTD_HOST_ADDRESS_WIDTH),
>>>>        DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode,
>> FALSE),
>>>> -    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState,
>> scalable_mode, FALSE),
>>>> -    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
>>>
>>> IMHO safer would be to officially deprecate these in
>>> docs/about/deprecated.rst and keeping them aliased until deprecation
>>> period expires. Other changes LGTM.
>>
>> The purpose of using an 'x-' prefix for properties in QEMU is to declare
>> that they are subject to change with no warning, so we are free to change
>> them without any deprecation IMHO.
> 
> Does that mean I can add another patch to s/flts/fsts opportunistically?
> flts(first level translation support) is a naming based on old version vtd spec,
> in new spec, it changed to use fsts(first stage translation support) naming.

Apparently :) You should post a v2 with that change included.

