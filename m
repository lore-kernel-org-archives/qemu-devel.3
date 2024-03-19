Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF64C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 07:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmTjk-0008GM-S6; Tue, 19 Mar 2024 03:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmTji-0008Fj-B6
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 03:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmTjg-00062d-OT
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 03:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710832691;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4sdXSW45nBgWCZIyAJz6Z+o1J8/TMLZXWw4tTHORRI=;
 b=agM4Nu9z3p9pTKMWIUW0+4E0pJCxjroHQx1iKhhaUIN40pW35gWyBYSM3etE/b+BQQkcfo
 Unj9F8D3PSgxBm5I3KrzR82FWnpLRmCpeGJmFF6d3O/vP7qcyqN29vK+B7kz3gXftEIXZ1
 wNQTC3jn+BUOOA2TjF/8PqyPhFeRc38=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-6uID0N7MOomJetmI7Ir-nA-1; Tue, 19 Mar 2024 03:18:10 -0400
X-MC-Unique: 6uID0N7MOomJetmI7Ir-nA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-430bde4b347so38877381cf.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 00:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710832690; x=1711437490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U4sdXSW45nBgWCZIyAJz6Z+o1J8/TMLZXWw4tTHORRI=;
 b=ORO6zcoLD6UapZAXxKkUBO2DhFjpYeGSDHliQ+58363sjtGTu2chn+HcKw295K31KI
 BW4Lprv6b2cf0h+fl2xiX1KqmOLbpM2lnLSShQt455ZWffij7NrXXPtZxYJwEpVdBfcX
 bi1ucdfCjdUgCjUVMPKJo1kPPvP552SO1xRa+9WkWiuQzEAbsp0BBwXR9e5cWEhUDQbI
 lEwKT/zwGAhNqj1dqHTCEjZZPSJFdrOpI0qJI7zsuWFf9t4BGRLrBvh43BLqFyHwuptZ
 MHVrpIIMJuXGMvxa8eXKFfLhAo4wti/+JGiivNOELivLFx+eSL+U4aHQ0qF1HaowFBNk
 3FNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxeI4LfWyO7q4P9U2vlhmqgu028EEU/krIrD49E0P0QLJLfarBh65ChRm0OXcCCbwVvYowz4OSxHWiFi7wf/qOlm4kAfU=
X-Gm-Message-State: AOJu0YwXdfqtQ1G6BEb0Dvl6bIqQ2mha32nKy1oxFendS8KxjGZ2yR1Z
 pzOQevBhpN+GMtYXMQQay98xl7ywWziZOejGiCNnBR/zfeGOdq4f9FdAqQARfZa3SzrtokXjW75
 AFK7OGw4CH5manDXxt1Y4Wz3NZhd4XdBzkAhcg2vU7gifPXZMRgc/
X-Received: by 2002:a05:622a:1b8b:b0:42e:6dc1:baea with SMTP id
 bp11-20020a05622a1b8b00b0042e6dc1baeamr15411096qtb.67.1710832689877; 
 Tue, 19 Mar 2024 00:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEXyLxWpRbw2RFo1WAJqdNTS8VtkX1RzWRBSGTDfEzK6dm84HTk99rJKLOCWr9jMu5lV8sVg==
X-Received: by 2002:a05:622a:1b8b:b0:42e:6dc1:baea with SMTP id
 bp11-20020a05622a1b8b00b0042e6dc1baeamr15411081qtb.67.1710832689640; 
 Tue, 19 Mar 2024 00:18:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 fd6-20020a05622a4d0600b00430d8ca2a82sm1349318qtb.66.2024.03.19.00.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 00:18:08 -0700 (PDT)
Message-ID: <ac190a19-afb3-4cd9-a9f8-130567636ece@redhat.com>
Date: Tue, 19 Mar 2024 08:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/11] vfio/pci: Allocate and initialize
 HostIOMMUDevice after attachment
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-9-zhenzhong.duan@intel.com>
 <750d1d70-37cd-4e00-a092-204f0dbbe61c@redhat.com>
 <SJ0PR11MB6744FC5D025D73D474838F90922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744FC5D025D73D474838F90922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 3/19/24 04:46, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v1 08/11] vfio/pci: Allocate and initialize
>> HostIOMMUDevice after attachment
>>
>>
>>
>> On 2/28/24 04:58, Zhenzhong Duan wrote:
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  hw/vfio/pci.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 4fa387f043..6cc7de5d10 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3006,6 +3006,9 @@ static void vfio_realize(PCIDevice *pdev, Error
>> **errp)
>>>          goto error;
>>>      }
>>>
>>> +    /* Allocate and initialize HostIOMMUDevice after attachment succeed
>> */
>> after successful attachment?
>>> +    host_iommu_device_create(vbasedev);
>>> +
>> you shall free on error: as well
> I free it in vfio_instance_finalize().
> Vfio-pci's design is special, it didn't free all allocated resources in realize's error path,
> They are freed in _finalize(). e.g., vdev->emulated_config_bits, vdev->rom, devices and group resources(vfio_detach_device).
> I'm following the same way. I'm fine to free it as you suggested something like below:

Oh yes I remember now. I had exactly the same question some months ago
:-/ So that's fine then

Eric
>
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3246,6 +3246,7 @@ out_teardown:
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);
>  error:
> +    g_free(vdev->vbasedev.base_hdev);
>      error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>  }
>
> @@ -3288,6 +3289,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>      vfio_bars_exit(vdev);
>      vfio_migration_exit(vbasedev);
>      pci_device_unset_iommu_device(pdev);
> +    g_free(vdev->vbasedev.base_hdev);
>  }
>
>> Eric
>>>      vfio_populate_device(vdev, &err);
>>>      if (err) {
>>>          error_propagate(errp, err);
>>> @@ -3244,6 +3247,7 @@ static void vfio_instance_finalize(Object *obj)
>>>
>>>      vfio_display_finalize(vdev);
>>>      vfio_bars_finalize(vdev);
>>> +    g_free(vdev->vbasedev.base_hdev);
> I free it here.
>
> Thanks
> Zhenzhong
>
>>>      g_free(vdev->emulated_config_bits);
>>>      g_free(vdev->rom);
>>>      /*


