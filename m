Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D14DC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 09:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdW2-0000cD-2Q; Mon, 23 Jun 2025 05:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTdVw-0000bP-Ow
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTdVp-00010T-SP
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750671042;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixe3fQb92kcqWxPKr3ic8TuDwAYKf8lYZZGAh4MaH1s=;
 b=GDz85gCHm1XlbuOuKZNKn7NhyHrcWsNh2NWQ7B3rcDPx6g4l6MtX+2kV5ziv65IW1RauE6
 ukZWFoFQ8xE1kBiEhzXesAy4FhCn6KVpvbImRJlHons6c6vh5qy3KtW6OL57gEIAvLhZnx
 LXXTMk3uWGIeZfzNx71aP33J3jXlK1E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-wNAua-6xN0WUiwfPQwW4pQ-1; Mon, 23 Jun 2025 05:30:40 -0400
X-MC-Unique: wNAua-6xN0WUiwfPQwW4pQ-1
X-Mimecast-MFC-AGG-ID: wNAua-6xN0WUiwfPQwW4pQ_1750671039
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so1451973f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 02:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750671039; x=1751275839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ixe3fQb92kcqWxPKr3ic8TuDwAYKf8lYZZGAh4MaH1s=;
 b=XuJcy1s5PUeNPcKxL3+8vH1ZuH0PxpqmuWDodTgX4/VCL9cZrncwmUzkm3xYabtlGY
 lRnQVx8ACeFH94sTfDU4m2/DRprpelHhfSF9f6RgMgdj6CXCmc2l91TkkUx5xYsu888b
 EhKrc3Y+pLfOEfgMMprONu2CaNyUkrU2XKbJsNtWQehITqmzbncwDK1tHS/zxwGTvtyZ
 W5E9cMrAdlSrvUYrO13B5YJcH/Lwd4HHD6VMCIokfYDF3Tm+UYk/ylK0yOkI4SmhwFxM
 5TdgMT05Lmp32fFMEs3QfjD2XyzAH65UbinqzLtLp0dS7NhF08uaUnhvc2EJT+6RZxq5
 IgOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSgcGcLKn7onjBWUWwFI6iHc3uxBdaBNAQjJIDbDPf2h0ops+QzUxB4GjAGntNN0XLLWKJIdfZyvq6@nongnu.org
X-Gm-Message-State: AOJu0Yzb6LtkHnFFDD9UX1IDJkhd/7e2MyvXLlgOT1kdZxO/n4cb7Rk6
 ICuUvFbD8xAPFs52BOzn7S6Q/FZ1XeYIE1QxkEEpUt5ZCFZFlxPl83mOPuwmg3Ad6GiF48a4PPB
 9dOSYP1OP3BUf3ZlOscsV41NUIpAL0WZ127YkVGCBW1ma1tPF0cRGShUk
X-Gm-Gg: ASbGnctfRC8vQBkakZkfqkWuTBiq9yBCvItk6sPcochyc2NOinv0NHnjcZq5ksZsQkF
 SUtnppRo86mvOrULWjTaRkMeia42V1koUo2/3VEZtSIUQHdV8txhqIVqYojLtTUKRAGqjlU/RyZ
 34+RyR8E1NrG6kfTNL5Kj9c/M62O1rVGS0YDbqU5PFXqHqdwi2nXiB8QS6f+5gSZdkihHc2bIQr
 E+m37rjXxbpL07OW6TzhdrXJN+mO5tgAu0T9JFsyYI9vTGso0Wd4l7O6CFRFp0mW+qtRxVQ58XS
 Pg0vqi0BjEv4AxpTb4IW0WiIAD4pSj1nlQFiFlCa96s65EYuhUcodUAGJML0NG1ofU56mg==
X-Received: by 2002:a05:6000:3109:b0:3a5:2c18:b181 with SMTP id
 ffacd0b85a97d-3a6d1317ed0mr9882232f8f.53.1750671039091; 
 Mon, 23 Jun 2025 02:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWZxoHf24eR+LdIiywHyBlgK72ngahr9aynr+4eWSL0ndwPLSdLdXAe2PjOIBWk2cLk/36SA==
X-Received: by 2002:a05:6000:3109:b0:3a5:2c18:b181 with SMTP id
 ffacd0b85a97d-3a6d1317ed0mr9882206f8f.53.1750671038685; 
 Mon, 23 Jun 2025 02:30:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d2236452sm8805107f8f.59.2025.06.23.02.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 02:30:37 -0700 (PDT)
Message-ID: <be95aa46-03c6-4fe2-a0bb-fa9bb02fb690@redhat.com>
Date: Mon, 23 Jun 2025 11:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-3-zhenzhong.duan@intel.com>
 <15fa4c74-347f-4374-b225-d97f340d045b@redhat.com>
 <IA3PR11MB91366E9CE94069B41DF4C43D9279A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB91366E9CE94069B41DF4C43D9279A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Zhenzhong,

On 6/23/25 4:20 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v2 02/19] hw/pci: Introduce pci_device_get_viommu_cap()
>>
>> Hi Zhenzhong,
>>
>> On 6/20/25 9:17 AM, Zhenzhong Duan wrote:
>>> pci_device_get_viommu_cap() call pci_device_get_iommu_bus_devfn()
>>> to get iommu_bus->iommu_ops and call get_viommu_cap() callback to
>>> get a bitmap with each bit represents a vIOMMU exposed capability.
>>>
>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/hw/pci/pci.h | 22 ++++++++++++++++++++++
>>>  hw/pci/pci.c         | 11 +++++++++++
>>>  2 files changed, 33 insertions(+)
>>>
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index df3cc7b875..829757b2c2 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -453,6 +453,18 @@ typedef struct PCIIOMMUOps {
>>>       * @devfn: device and function number of the PCI device.
>>>       */
>>>      void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
>>> +    /**
>>> +     * @get_viommu_cap: get vIOMMU capabilities
>>> +     *
>>> +     * Optional callback, if not implemented, then vIOMMU doesn't
>>> +     * support exposing capabilities to other subsystem, e.g., VFIO.
>>> +     * vIOMMU can choose which capabilities to expose.
>>> +     *
>>> +     * @opaque: the data passed to pci_setup_iommu().
>>> +     *
>>> +     * Returns: 64bit bitmap with each bit represents a capability.
>> I think we need to clarify what this bitmap contains as capability bits
>> (enum type)
> Sure, will be like:
>
>      * Returns: 64bit bitmap with each bit represents a capability emulated
>      * by VIOMMU_CAP_* in include/hw/iommu.h
>
> enum {
>     VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table supported */
> };
looks good to me

Eric
>
> Thanks
> Zhenzhong
>


