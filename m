Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867DFC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 06:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9Sm-0005ZQ-Sz; Tue, 23 Jul 2024 02:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sW9Sl-0005Ob-Jh
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sW9Sj-00085Y-FF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721717848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0aUpU3xrvouhl/K0KW0d0ej6TQw7twppr0p854P0ps=;
 b=SBMerXxxZE0IRHZ+GYtZp31Bmbda8GJ2JCnrvIyaqswB1r2pv6725oeJW3UfBmiBVOLrXX
 Eo/NC7NwDhbG8vAS4CRmCMpF2cPoPWeU8592DUT5dZQZ0Em/6Xa6U5U0Nd6iInfeoV8Cdp
 IG58IP+3EjQ+tb0Em++kDtQPm0ztFJE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352--Q52pCSSNsupKmVbC2R5wA-1; Tue, 23 Jul 2024 02:57:25 -0400
X-MC-Unique: -Q52pCSSNsupKmVbC2R5wA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ef31dbc770so15198961fa.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 23:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721717843; x=1722322643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s0aUpU3xrvouhl/K0KW0d0ej6TQw7twppr0p854P0ps=;
 b=KHB07+quVIVs4R/lJBbBvzwjtbxLEM8Irq5pIv84gpkHLDtDxMpclf0iccKimp6Dg6
 vAwW2RegwM1wbMi/98xC10KsxkOiSFLVaGCx9Dh+grDMWLxrql85G0YawkDIaO+3OF0A
 wczhLUA+AgKcDoCiaQ2PkHZ6MUSOOmPu6yGiB872YK+cVsVNuio3CvOjrFzuBFHUuObo
 liB1MRii56C0yJQgM9Yq0GVndJSW5HqAp+5uA5YOUJl9keNiYcPZQ6J4CnyExQvtdZqK
 g+15I5If7/kfBp4Wsl6OfVtXpndE3oB9gQMdQhLT9CfOqYCiSPPIOMHWXqBRs1KyVmlR
 9ngg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCL1c3QglmyUMfnh/f774Zhpwfs5NlhbxQ1GX+LfwZNovK2obcecuz2N14TxgFq09/7mxewAUXHJLdFeUlG77peeJQw7s=
X-Gm-Message-State: AOJu0YyN0X2A0+hQ0Y9Ootl7xhMK8xCs4SoQi5o3Mf5mqqkPujv8DFYq
 wP0ajfOiYBwMWP3yafMTvFcSOcpMujD5WJYuEWnoBpEJ9/WzEgFYCDuCO/QPHh9bqy7rthcpq6b
 nVXt1VriRwcpG1AKmJq+w5+qp7bIVROFME0RFSiJHXRO0CRul46ZE7d2Yo1VK
X-Received: by 2002:a2e:9b87:0:b0:2ee:847f:9e9b with SMTP id
 38308e7fff4ca-2ef16798d42mr64050611fa.28.1721717843208; 
 Mon, 22 Jul 2024 23:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfTyR28I0aSYIhuqrCwczBaW1Sd9yqZr5z3WmqBBiMYxAUrhxBXNX8LnkvIMzyKc+HVQNvMA==
X-Received: by 2002:a2e:9b87:0:b0:2ee:847f:9e9b with SMTP id
 38308e7fff4ca-2ef16798d42mr64050481fa.28.1721717842801; 
 Mon, 22 Jul 2024 23:57:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a947fasm184146295e9.43.2024.07.22.23.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 23:57:22 -0700 (PDT)
Message-ID: <0557ef54-475a-4512-b755-75610a2fcab9@redhat.com>
Date: Tue, 23 Jul 2024 08:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
To: Joao Martins <joao.m.martins@oracle.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-6-joao.m.martins@oracle.com>
 <SJ0PR11MB6744237AD1896B5EFA8E045B92A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <88eaa782-9221-4fce-90ad-353487cae649@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <88eaa782-9221-4fce-90ad-353487cae649@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/23/24 08:13, Joao Martins wrote:
> On 23/07/2024 06:11, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
>>> tracking capability
>>>
>>> In preparation to using the dirty tracking UAPI, probe whether the IOMMU
>>> supports dirty tracking. This is done via the data stored in
>>> hiod::caps::hw_caps initialized from GET_HW_INFO.
>>>
>>> Qemu doesn't know if VF dirty tracking is supported when allocating
>>> hardware pagetable in iommufd_cdev_autodomains_get(). This is because
>>> VFIODevice migration state hasn't been initialized *yet* hence it can't pick
>>> between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
>>> dirty tracking it always creates HWPTs with
>>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>>> even if later on VFIOMigration decides to use VF dirty tracking instead.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>> include/hw/vfio/vfio-common.h |  2 ++
>>> hw/vfio/iommufd.c             | 20 ++++++++++++++++++++
>>> 2 files changed, 22 insertions(+)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>>> common.h
>>> index 4e44b26d3c45..1e02c98b09ba 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>
>>> typedef struct VFIOIOASHwpt {
>>>      uint32_t hwpt_id;
>>> +    uint32_t hwpt_flags;
>>>      QLIST_HEAD(, VFIODevice) device_list;
>>>      QLIST_ENTRY(VFIOIOASHwpt) next;
>>> } VFIOIOASHwpt;
>>> @@ -139,6 +140,7 @@ typedef struct VFIODevice {
>>>      OnOffAuto pre_copy_dirty_page_tracking;
>>>      bool dirty_pages_supported;
>>>      bool dirty_tracking;
>>> +    bool iommu_dirty_tracking;
>>>      HostIOMMUDevice *hiod;
>>>      int devid;
>>>      IOMMUFDBackend *iommufd;
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 2324bf892c56..7afea0b041ed 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -110,6 +110,11 @@ static void
>>> iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>>      iommufd_backend_disconnect(vbasedev->iommufd);
>>> }
>>>
>>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>> +{
>>> +    return hwpt && hwpt->hwpt_flags &
>>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> +}
>>> +
>>> static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>> {
>>>      ERRP_GUARD();
>>> @@ -246,6 +251,17 @@ static bool
>>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>          }
>>>      }
>>>
>>> +    /*
>>> +     * This is quite early and VFIO Migration state isn't yet fully
>>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>>> +     * whether IOMMU dirty tracking is going to be requested. Later
>>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>>> +     * instead.
>>> +     */
>>> +    if (vbasedev->hiod->caps.hw_caps &
>>> IOMMU_HW_CAP_DIRTY_TRACKING) {
>>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> +    }
>>> +
>>>      if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>                                      container->ioas_id, flags,
>>>                                      IOMMU_HWPT_DATA_NONE, 0, NULL,
>>> @@ -255,6 +271,7 @@ static bool
>>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>
>>>      hwpt = g_malloc0(sizeof(*hwpt));
>>>      hwpt->hwpt_id = hwpt_id;
>>> +    hwpt->hwpt_flags = flags;
>>>      QLIST_INIT(&hwpt->device_list);
>>>
>>>      ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>>> @@ -265,8 +282,11 @@ static bool
>>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>      }
>>>
>>>      vbasedev->hwpt = hwpt;
>>> +    vbasedev->iommu_dirty_tracking =
>>> iommufd_hwpt_dirty_tracking(hwpt);
>>
>> Don't we need to do same if attach to existing hwpt?
>>
> 
> Nice catch!
> 
> Yes, we do need it e.g. we will need this fix up fo this patch


Fixed on vfio-9.1.

Thanks,

C.



> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 92b976464283..833a7400486c 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -305,6 +305,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           } else {
>               vbasedev->hwpt = hwpt;
>               QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> +            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>               return true;
>           }
>       }
> 


