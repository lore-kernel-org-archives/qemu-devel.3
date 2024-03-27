Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EE5C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQVG-0008Jh-AT; Wed, 27 Mar 2024 06:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rpQUD-0007OE-J4
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rpQU9-0007aZ-Tz
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711535161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vdf2NhBV6eT786BOJkf8ciP+Je7U9gv671V5ix95coY=;
 b=ONEW9jVGaf88NB9CVNKiIlhbUiy9D5S7+rX7FXByuwSVSafGXs68/KywnwAUyd6BSb6N6z
 O5O1gYiPtAqT0TMOl1HAWHnWyCNRf9YYuC6kMhCCSyCjSP28w7catglCLJxw1k3rJgMdZi
 XYnQtIV5ZqLFEnlf4z4HeqOGYVGxM3A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-TrrWn6awPni7jEVpNX5C1A-1; Wed, 27 Mar 2024 06:25:59 -0400
X-MC-Unique: TrrWn6awPni7jEVpNX5C1A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-430a74cc3d5so65799731cf.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 03:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711535159; x=1712139959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vdf2NhBV6eT786BOJkf8ciP+Je7U9gv671V5ix95coY=;
 b=HhHX2Soooiqi7MhjmpXrC4JuyEMhz9MFeSAKInRC1Ji2MBadxEMRKAcv7zsMDAVJo2
 8fwMgMmS5AwyCL+Lc7ndC769pi6EoWIDly6ChZwyfewmzx1fvXlIAzTtsuXzzRnG2tKT
 F7hbrG50BNnamrKGJGmqIFaRe+LL9jI6wTVRHb7b+3w5SZB2Xtm0aPltPPCrGYw1QjD+
 JtRJD2kwJAW6eEOg+xeIdk+GXhiDc9FsnAd7u3zjK0XNIgE3HsLKQw6wBy89GozBV1ij
 Ibbzsd0TOrndhRKBSy+jJDju57NTBcbE5G3ARjlVolCDvZCcvjwMwcf02I7QARfPpZFU
 r9NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUcEyCGnW4Nz9THuuKyArb1XH4hiy9MhFRsGcCfpXSmtdzI8rFEBwucbi1UpOF2LKRi0lkdFOt4VedlLopBQVqOkI54g8=
X-Gm-Message-State: AOJu0YyFhtNBIc/hE8b/zYS3su75fxpHzvwaXlVkfpTCzowrvNQELljQ
 +qSgm0IdeT6QhvdacVOCedk8joyjU+GmNIir9285X6LAA/+o+VrLPVAcza8KmUtk4uhmeqM5+Bb
 Q+yNGA/YvxCme5Wh5xjtLemHIUi7V5WiSBt2niBbXgr0N1Uj1ZUo9
X-Received: by 2002:ac8:578b:0:b0:430:d794:5a96 with SMTP id
 v11-20020ac8578b000000b00430d7945a96mr3574722qta.67.1711535158855; 
 Wed, 27 Mar 2024 03:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+Sqn7GLZAW9TLbu5hoNywsOrvaT3TsMjLhPjYUGL+trxJH2IgDY+xs7hDnIZ8d7tModSwFg==
X-Received: by 2002:ac8:578b:0:b0:430:d794:5a96 with SMTP id
 v11-20020ac8578b000000b00430d7945a96mr3574705qta.67.1711535158551; 
 Wed, 27 Mar 2024 03:25:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ge11-20020a05622a5c8b00b004309754810fsm4622687qtb.89.2024.03.27.03.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 03:25:58 -0700 (PDT)
Message-ID: <41d50645-9f81-40b1-9ca5-7bb2e73d90de@redhat.com>
Date: Wed, 27 Mar 2024 11:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-2-zhenzhong.duan@intel.com>
 <e6af68f4-f38d-413f-a63c-d1ae7254d802@redhat.com>
 <SJ0PR11MB674439E1DDE3DDE285571AEE922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB674439E1DDE3DDE285571AEE922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Zhenzhong,

On 3/19/24 12:58, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Tuesday, March 19, 2024 4:17 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-
>> devel@nongnu.org
>> Cc: alex.williamson@redhat.com; eric.auger@redhat.com;
>> peterx@redhat.com; jasowang@redhat.com; mst@redhat.com;
>> jgg@nvidia.com; nicolinc@nvidia.com; joao.m.martins@oracle.com; Tian,
>> Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; Sun, Yi Y
>> <yi.y.sun@intel.com>; Peng, Chao P <chao.p.peng@intel.com>
>> Subject: Re: [PATCH v1 01/11] Introduce a common abstract struct
>> HostIOMMUDevice
>>
>> Hello Zhenzhong,
>>
>> On 2/28/24 04:58, Zhenzhong Duan wrote:
>>> HostIOMMUDevice will be inherited by two sub classes,
>>> legacy and iommufd currently.
>>>
>>> Introduce a helper function host_iommu_base_device_init to initialize it.
>>>
>>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/sysemu/host_iommu_device.h | 22 ++++++++++++++++++++++
>>>    1 file changed, 22 insertions(+)
>>>    create mode 100644 include/sysemu/host_iommu_device.h
>>>
>>> diff --git a/include/sysemu/host_iommu_device.h
>> b/include/sysemu/host_iommu_device.h
>>> new file mode 100644
>>> index 0000000000..fe80ab25fb
>>> --- /dev/null
>>> +++ b/include/sysemu/host_iommu_device.h
>>> @@ -0,0 +1,22 @@
>>> +#ifndef HOST_IOMMU_DEVICE_H
>>> +#define HOST_IOMMU_DEVICE_H
>>> +
>>> +typedef enum HostIOMMUDevice_Type {
>>> +    HID_LEGACY,
>>> +    HID_IOMMUFD,
>>> +    HID_MAX,
>>> +} HostIOMMUDevice_Type;
>>> +
>>> +typedef struct HostIOMMUDevice {
>>> +    HostIOMMUDevice_Type type;
>>
>> A type field is not a good sign and that's where QOM is useful.
> 
> Yes, agree.
> I didn't choose QOM because in iommufd-cdev series, VFIOContainer chooses not using QOM model.
> See the discussion: https://lore.kernel.org/all/YmuFv2s5TPuw7K%2Fu@yekko/
> I thought HostIOMMUDevice need to follow same rule.
> 
> But after further digging into this, I think it may be ok to use QOM model as long as we don't expose
> HostIOMMUDevice in qapi/qom.json and not use USER_CREATABLE interface. Your thoughts?

yes. Can we change a bit this series to use QOM ? something like :

     typedef struct HostIOMMUDevice {
         Object parent;
     } HostIOMMUDevice;
     
     #define TYPE_HOST_IOMMU "host.iommu"
     OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUClass, HOST_IOMMU)
     
     struct HostIOMMUClass {
         ObjectClass parent_class;
     
         int (*get_type)(HostIOMMUDevice *hiod, uint64_t *type, Error **errp);
         int (*get_cap)(HostIOMMUDevice *hiod, uint64_t *cap, Error **errp);
     };

Inherited objects would be TYPE_HOST_IOMMU_IOMMUFD and TYPE_HOST_IOMMU_LEGACY.
Each class implementing the handlers or not (legacy mode).

The class handlers are introduced for the intel-iommu helper vtd_check_hdev()
in order to avoid using iommufd routines directly. HostIOMMUDevice is supposed
to abstract the Host IOMMU device, so we need to abstract also all the
interfaces to this object.

The .host_iommu_device_create() handler could be merged in .attach_device()
possibly. Anyhow, please use now object_new() and object_unref() instead.
host_iommu_base_device_init() is useless IMHO.

> 
>>
>> Is vtd_check_hdev() the only use of this field ?
> 
> Currently yes. virtio-iommu may have similar usage.
> 
>> If so, can we simplify with a QOM interface in any way ?
> 
> QOM interface is a set of callbacks, guess you mean QOM class,
> saying HostIOMMUDevice class, IOMMULegacyDevice class and IOMMUFDDevice class?

See above proposal. it should work fine.

Also, I think it is better to use a IOMMUFDBackend* parameter for
iommufd_device_get_info() to be consistent with the other routines.

Then It would interesting to see how this applies to Eric's series.

Thanks,

C.




