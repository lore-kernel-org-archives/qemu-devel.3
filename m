Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424F4C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 07:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS9tn-0001g9-Ej; Thu, 19 Jun 2025 03:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uS9tg-0001fd-OH
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 03:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uS9te-0005UI-4K
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 03:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750318876;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RXw5WAipzgSzJAGJtmmeerI5f0Igq6B+23qbh53Zcg=;
 b=P5fS9THWTRw6IDm31QxvWnwKbmNd0XU2jLtRfPRncE6MvxM8AUXtBoQbHyPbo2cWfSZXAh
 wh0fbOnEUg4Bbqv7C+UFVUPj+luC3tYzykahOK5MyVBJkuVade7Ha79Vaq5gvqrelkV2++
 Kq+RtcKegHjKew9vl+zLJ2k4gK57sTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-kIGEkSF_OJKB4Agx1pevDQ-1; Thu, 19 Jun 2025 03:41:13 -0400
X-MC-Unique: kIGEkSF_OJKB4Agx1pevDQ-1
X-Mimecast-MFC-AGG-ID: kIGEkSF_OJKB4Agx1pevDQ_1750318873
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453080e4741so3728885e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 00:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750318872; x=1750923672;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1RXw5WAipzgSzJAGJtmmeerI5f0Igq6B+23qbh53Zcg=;
 b=sxPJA+2DWNHyqW4KpQE6/sSOlz+3gXIgBMFCjOJVyye1XdG7vFtId0Y5ykHDT11jYa
 4CyyE0isuIEIfgBnbXnGpoZoHIo6pjY435niH7D9BhRg6Pxpj6l3WJxdXeqClZVF6870
 xGS2+wfyeIhZH3q+NRYj48IstbxdKhDGnaP+aKnV2pWqk44K7zoxVfj0KYo/te/WwjDk
 O1gKJAvAqjDmQqJA8SWdRC+pOXDiWob0aFe/xab8Bo9Lx5J6mGPrzYdKB0bSvr7Zg8wS
 vYc4wJlHPIo9QLAnf4xxf2+0pN23Wxq4t1CByELvLdluPe0hRq00x6XRWDJ1VzHEQ0tm
 CNhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWmVKAo+z37B/F86KzwPyFHrGULE9TXWxVoOxLQ/F+3Q+vDCw/7taz3F7a12IOMDfFU9R6WEHazEv+@nongnu.org
X-Gm-Message-State: AOJu0YyuBFspvGvmb+gx3gBx6OSv2xCeEYIMbtZen8M/dCo1g3yCsNtZ
 FgJxc7AO5pjOxqU8p7M2zOZewBZdp5E1VzHKlheQZcPIWoxCXoHjTTu416BKD57hRaVs07uCotW
 0/zICUm7tX/rwBLjbqe+P33fJe5r4AGdd2/HX1BIW6fGnn3sqVosoigUw
X-Gm-Gg: ASbGnctMR7TtPwR/9YfMRv+Kjw17mm/zZN8Q7hRGtpeUvMnLgCdOV0k4mzQSJ9v9gpH
 mw3qdgSKw/h+2O8wPSr8/vHQP7ok8jwcuhle7YvVbkELy2V6+K6CIxZBsS3toTuUe0FnXVeHCaY
 j9Zw69zsJOIBeiWT+FoGoYKKCRuR6FuhywPoAN8P19mj1914YLzuGf+mZmBlzrYIXaEvHfI2Y8o
 BywtlxVSpRogxuAJwhcmPouGXxdPSNLoNVsnWACB85FLkDMr2vCGGtDrJCoxakEDiDmPXjTqof5
 jkuQ3b4yQsAM4YWNJ5oqQxwRkGefTXtvnx0Q5oB+VBFRidOL+Z7u6+ViUp+d33O8KWhpWA==
X-Received: by 2002:a05:600c:444f:b0:43c:fe5e:f03b with SMTP id
 5b1f17b1804b1-45345f1cf67mr165850025e9.30.1750318872528; 
 Thu, 19 Jun 2025 00:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyJXLG6kx2NV304tPRB3ZAHdretu6v55kXL/sb/EoHqcwGQcxyenfn/3eLFY4IW6/5DKcZig==
X-Received: by 2002:a05:600c:444f:b0:43c:fe5e:f03b with SMTP id
 5b1f17b1804b1-45345f1cf67mr165849625e9.30.1750318872091; 
 Thu, 19 Jun 2025 00:41:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8edbsm19853075e9.24.2025.06.19.00.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 00:41:11 -0700 (PDT)
Message-ID: <6e180d39-b1eb-4935-98b0-3ac73766e8aa@redhat.com>
Date: Thu, 19 Jun 2025 09:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Linuxarm <linuxarm@huawei.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-2-shameerali.kolothum.thodi@huawei.com>
 <20250616112019.00003bce@huawei.com>
 <fcd05844-d2d9-450e-b962-59b0f3964185@redhat.com>
 <20250617175247.00007d43@huawei.com>
 <49d4c4b73e9a44a783332ddfe9a2fbdf@huawei.com>
 <327b5515-467c-4666-86d6-fb2a99925a8c@redhat.com>
 <e4879b1e26f941b5baa419824e4c928c@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e4879b1e26f941b5baa419824e4c928c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 6/19/25 9:24 AM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, June 18, 2025 6:00 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>
>> Cc: Linuxarm <linuxarm@huawei.com>; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
>> nicolinc@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
>> imammedo@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
>> smostafa@google.com; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe
>> Root Complex association
>>
>> Hi Shameer, Jonathan,
>>
>> On 6/18/25 10:35 AM, Shameerali Kolothum Thodi wrote:
>>>> -----Original Message-----
>>>> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>> Sent: Tuesday, June 17, 2025 5:53 PM
>>>> To: Eric Auger <eric.auger@redhat.com>
>>>> Cc: Shameerali Kolothum Thodi
>>>> <shameerali.kolothum.thodi@huawei.com>; Linuxarm
>>>> <linuxarm@huawei.com>; qemu-arm@nongnu.org; qemu-
>>>> devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
>>>> nicolinc@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
>>>> imammedo@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
>>>> smostafa@google.com; Wangzhou (B) <wangzhou1@hisilicon.com>;
>>>> jiangkunkun <jiangkunkun@huawei.com>; zhangfei.gao@linaro.org
>>>> Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has
>> PCIe
>>>> Root Complex association
>>>>
>>>> On Tue, 17 Jun 2025 09:49:54 +0200
>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>
>>>>> On 6/16/25 12:20 PM, Jonathan Cameron wrote:
>>>>>> On Fri, 13 Jun 2025 15:44:43 +0100
>>>>>> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>>>>>>
>>>>>>> Although this change does not affect functionality at present, it is
>>>>>> Patch title says PCIe.  This check is vs PCI host bridge.
>>>>>>
>>>>>> No idea which one you wanted, but if it is PCIe needs to be
>>>>>> TYPC_PCIE_HOST_BRIDGE from pcie_host.h not the pci_host.h one
>>>>>> I think.
>>>>> I think we need TYPE_PCI_HOST_BRIDGE as we want to check against
>> pxb
>>>>> pci-bridge/pci_expander_bridge.c:    .parent        =
>>>> TYPE_PCI_HOST_BRIDGE,
>> sorry but I still fail to understand why we can't just check against
>>
>> TYPE_PCI_HOST_BRIDGE for making sure the SMMU is attached to PXB or
>> GPEX. What does it fail to check? Why shall we care about PCI vs PCIe?
> I think the concern is  getting any other TYPE_PCI_HOST_BRIDGE types attached
> to SMMUv3 other than pxb-pcie or GPEX. For example you could do,
>
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> -device arm-smmuv3,primary-bus=cxl.1,id=smmuv3.1 \
>
> as pxb-cxl is of type TYPE_PCI_HOST_BRIDGE. I don't know if there are any other
> ones similar to this out there.
>
> So the aim is to make the checking more specific to PXB.

thank you for the clarification. Is it invalid to have the SMMU
protecting RIDs comming from the pxb-cxl hierarchy?

Eric
>
> Thanks,
> Shameer


