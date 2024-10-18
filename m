Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4CBD3C537
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 04:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1eck-00030c-Q2; Fri, 18 Oct 2024 00:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1eci-0002zs-VM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 00:30:00 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1ece-0000oL-Cn
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 00:30:00 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e2cc47f1d7so1195178a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 21:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729225792; x=1729830592;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cIGaw1+OTOpnEK5u+MlLMD3PtDbT7o2kPJYFgslAwVs=;
 b=k77y9v8wV//0/CbrURLqnyLVSwjFrphxcA2G9wuFDzL6OHFSLdq7gLoVHQq+hpvPqq
 do8L26CV3meJ+/if1Ca+7f/54JTKHCx5BYOgx3zbByHj/N0t7N64OE6lu9X2bF4wRQou
 oq7NlLikLSgK1Ts40f/A0yRBisyAjlU6JGWYS4uDDa29kEV5D86R6stRkmFgWJzG+UA9
 MoYvXEJGK9MRZFy6iUB4Kk4cSYqPusFtT6mdD5k9P8pqgEEpMdbMLN4E0NqPBJKz1P92
 wW2JvITWWb/iJJfAiFltAreuFQNOTm7SQbM6L3zWTlCt/fAPmPWJOagtjlifwhxe08np
 bYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729225792; x=1729830592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cIGaw1+OTOpnEK5u+MlLMD3PtDbT7o2kPJYFgslAwVs=;
 b=SLoFPOSY5rDp5TD6/mXuHUAYEk79A147HJ/lSdBVXk+814yNrxXIZIyevRdnZn8Kb2
 Dob001wkvlJmaiZAaAO5erddYnRYK/jpFQbHaxDhcL6kBUtGEqvVxhf39ElreMzemmFD
 GD7UFmDyuvv12Gq8qimccHSV3tuiy22K/fEAuMsN7PdbizHMAu5xYorygcSRfGsH59Yl
 3HZeLreR3rvsXGf96FGV6UyzTI8dr1GMjtBcCzL9lae/2/j5IUYCpzEQpIM9WPSrLgJr
 yax8FY04KJZdzijF1Oiiv8gPm3O7XEk1HAPZsTcJeKgmn4VEOcgZ89cOXJLx4gxt7T9p
 YyQw==
X-Gm-Message-State: AOJu0YwszikW2Y3injgSlVsWbrx3uNUbvrNJoHHpd44WihjNKHrqGbua
 9yQrY3L/kGS069Mzm1qIn+Oq6au7cIcXs7v8iM2ng88208qyEpfaSyR4GiEl/6c=
X-Google-Smtp-Source: AGHT+IFqG8ct6knzVJ4ZZebERvnQ6vPCMnrDp/VNOUVb6MTIPdUVp/Tk7UrnGkBcrLjQH37sdcKaeg==
X-Received: by 2002:a17:90a:fa8c:b0:2e2:ada8:2986 with SMTP id
 98e67ed59e1d1-2e565063b06mr1616121a91.16.1729225792302; 
 Thu, 17 Oct 2024 21:29:52 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e55d7bf9a8sm830316a91.13.2024.10.17.21.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 21:29:51 -0700 (PDT)
Message-ID: <37418ed0-71e0-4c8c-98ce-051d91ee4336@daynix.com>
Date: Fri, 18 Oct 2024 13:29:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/13] s390x/pci: Avoid creating zpci for VFs
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
 <20240913-reuse-v16-4-d016b4b4f616@daynix.com>
 <4048f295-1073-432d-9c89-dac1b6b30da5@redhat.com>
 <9e11e7b2-48f5-4b5e-8962-e7879016f04d@daynix.com>
 <d427ffc7-1d3d-476f-8ed8-4246e60e6da1@redhat.com>
 <16774f97-9d42-41ee-b0be-43835c0a04f5@daynix.com>
 <2ac4365e-1866-4387-9d0d-e94277859fd5@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <2ac4365e-1866-4387-9d0d-e94277859fd5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/10/14 17:43, Cédric Le Goater wrote:
> Hello Akihiko,
> 
> On 10/12/24 13:05, Akihiko Odaki wrote:
>> On 2024/10/11 0:44, Cédric Le Goater wrote:
>>> Hello Akihiko,
>>>
>>> Sorry for the late reply.
>>>
>>> On 9/18/24 17:32, Akihiko Odaki wrote:
>>>> On 2024/09/18 17:02, Cédric Le Goater wrote:
>>>>> Hello,
>>>>>
>>>>> On 9/13/24 05:44, Akihiko Odaki wrote:
>>>>>> VFs are automatically created by PF, and creating zpci for them will
>>>>>> result in unexpected usage of fids. Currently QEMU does not support
>>>>>> multifunction for s390x so we don't need zpci for VFs anyway.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> ---
>>>>>>   hw/s390x/s390-pci-bus.c | 19 +++++++++++++++++--
>>>>>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>>>> index 3e57d5faca18..1a620f5b2a04 100644
>>>>>> --- a/hw/s390x/s390-pci-bus.c
>>>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>>>> @@ -1080,6 +1080,16 @@ static void 
>>>>>> s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>>>>           pbdev = s390_pci_find_dev_by_target(s, dev->id);
>>>>>>           if (!pbdev) {
>>>>>> +            /*
>>>>>> +             * VFs are automatically created by PF, and creating 
>>>>>> zpci for them
>>>>>> +             * will result in unexpected usage of fids. Currently 
>>>>>> QEMU does not
>>>>>> +             * support multifunction for s390x so we don't need 
>>>>>> zpci for VFs
>>>>>> +             * anyway.
>>>>>> +             */
>>>>>> +            if (pci_is_vf(pdev)) {
>>>>>> +                return;
>>>>>> +            }
>>>>>> +
>>>>>>               pbdev = s390_pci_device_new(s, dev->id, errp);
>>>>>>               if (!pbdev) {
>>>>>>                   return;
>>>>>> @@ -1167,7 +1177,9 @@ static void 
>>>>>> s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>>>>           int32_t devfn;
>>>>>>           pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
>>>>>> -        g_assert(pbdev);
>>>>>> +        if (!pbdev) {
>>>>>> +            return;
>>>>>> +        }
>>>>>
>>>>>
>>>>> I don't understand this change. Could you please explain ?
>>>>
>>>> We need to tolerate that pbdev being NULL because VFs do no longer 
>>>> have zpci and pbdev will be NULL for them.
>>>
>>> Then, I think we should extend the assert with a check on 
>>> pci_is_vf(pdev)
>>> to be symmetric with the plug handler and also, use the 'Error**' 
>>> parameter
>>> to report an error.
>>
>> This should never happen unless there is a programming error so plain 
>> g_assert() without error reporting should be fine. We don't need to 
>> report an error when it is VF; we just don't have a work to do and 
>> nothing wrong happens here.
> 
> unplugging a VF is still an invalid thing to do, reporting an error is 
> preferable IMO.

Unplugging a VF will happen if you unplug igb, and it is a valid operation.

Regards,
Akihiko Odaki

