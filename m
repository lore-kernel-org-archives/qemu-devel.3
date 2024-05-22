Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1196AC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9f7j-0000iP-QT; Wed, 22 May 2024 02:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9f7h-0000he-HT
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9f7f-0002wv-U9
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716358007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNKkvyQBUzGg9aGBYCHVor3vKsyE6Iebq1jiHp1mfOE=;
 b=iTRfHAJvUr4Dfx4vBNwFql1LmrUlMTYvOZIcXJlbrtSQp1KkqO7U8ltq2DSCFn71CQjBQ9
 i92QdDn/fyZ1akZdSpXYQnGQfPFji52htKMUDWUSHHVHN/dDv840iOlCBRc0FYJQKa/W5d
 IGbY8IwYj/awT+/u3a97261YFco5Vgw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-uMwdmzi_PIKMmqG9b5GYjw-1; Wed, 22 May 2024 02:06:46 -0400
X-MC-Unique: uMwdmzi_PIKMmqG9b5GYjw-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3c9a062825bso12761004b6e.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 23:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716358005; x=1716962805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WNKkvyQBUzGg9aGBYCHVor3vKsyE6Iebq1jiHp1mfOE=;
 b=POHS7GQNexfOlXwO1Ja/0qyXJMHYXWv0NYVGZnmWq7E6RYI/dZJPvjEQhMRXsdDCRT
 ZHC67UKviP+1fecPY+BsnPiuFvhO7ZCCq+T4oTfxOAlLVbRosSr4I4+FubewNnkS4/W6
 etSiIDoe2UzFh80gsQKFDUZ4O2K8cl2qvQTuWsvPWrJOpSa6uczskCMGXKXrRroSYs1P
 IyqpwNodUu1HrPci+LQ1qqIR82BPR8bhtzXNqq66lIPmYp/zVK0DaAsbPZCpnPjlgSGN
 5TQ0kHrEd6Txf62CUIxMrIOw0EEifab+5l6BjTJHuNhJawXOSpjjCCF3JYV674uHuIvK
 NcJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhz/gwgxMD4Ca4+S52TNxjJ7wf92eXa2Tr+mv618XyoQ5de2XcLncdUVaI5Xb29yu99IUzWmHtAplRZOQ0k39uH+pbkU8=
X-Gm-Message-State: AOJu0Yz154WT/qT8F/gnbnUucd5KNuY3KuQFWbvXpuuwLOCe0cd3Qaw5
 gWEPcUAEs28xu6Id4h3xf2EAAGXsAKZK738QzmjUtTwNApqtxH7M917CSkLSz11k4uaBTtGPCZR
 Fa40hf3V3M0pLa70kyeVJ3NBrO55F1ybXqpgMUlDgKHik6HGfGc6Ik5AZ+I/l
X-Received: by 2002:a05:6808:ecd:b0:3c9:6f4b:f825 with SMTP id
 5614622812f47-3cdb9d3a1abmr1283316b6e.39.1716358004891; 
 Tue, 21 May 2024 23:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsPKy08LnmxWpFSQgeC8HI2lAMOJ3+aHMDQ1u/wH9jVe+6pTV8lfCEXnWO/ZeZULs7L822Vw==
X-Received: by 2002:a05:6808:ecd:b0:3c9:6f4b:f825 with SMTP id
 5614622812f47-3cdb9d3a1abmr1283308b6e.39.1716358004590; 
 Tue, 21 May 2024 23:06:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7949b862cc0sm13393185a.118.2024.05.21.23.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 23:06:44 -0700 (PDT)
Message-ID: <cdc51332-2e15-4a3e-9841-efe3c8ab6da0@redhat.com>
Date: Wed, 22 May 2024 08:06:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/20] vfio/pci: Make vfio_populate_device() return a
 bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
 <20240522044015.412951-11-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240522044015.412951-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 5/22/24 06:40, Zhenzhong Duan wrote:
> Since vfio_populate_device() takes an 'Error **' argument,
> best practices suggest to return a bool. See the qapi/error.h
> Rules section.
> 
> By this chance, pass errp directly to vfio_populate_device() to
> avoid calling error_propagate().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4fb5fd0c9f..46d3c61859 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2740,7 +2740,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>       return 0;
>   }
>   
> -static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info;
> @@ -2750,18 +2750,18 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>       /* Sanity check device */
>       if (!(vbasedev->flags & VFIO_DEVICE_FLAGS_PCI)) {
>           error_setg(errp, "this isn't a PCI device");
> -        return;
> +        return false;
>       }
>   
>       if (vbasedev->num_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
>           error_setg(errp, "unexpected number of io regions %u",
>                      vbasedev->num_regions);
> -        return;
> +        return false;
>       }
>   
>       if (vbasedev->num_irqs < VFIO_PCI_MSIX_IRQ_INDEX + 1) {
>           error_setg(errp, "unexpected number of irqs %u", vbasedev->num_irqs);
> -        return;
> +        return false;
>       }
>   
>       for (i = VFIO_PCI_BAR0_REGION_INDEX; i < VFIO_PCI_ROM_REGION_INDEX; i++) {
> @@ -2773,7 +2773,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   
>           if (ret) {
>               error_setg_errno(errp, -ret, "failed to get region %d info", i);
> -            return;
> +            return false;
>           }
>   
>           QLIST_INIT(&vdev->bars[i].quirks);
> @@ -2783,7 +2783,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>                                  VFIO_PCI_CONFIG_REGION_INDEX, &reg_info);
>       if (ret) {
>           error_setg_errno(errp, -ret, "failed to get config info");
> -        return;
> +        return false;
>       }
>   
>       trace_vfio_populate_device_config(vdev->vbasedev.name,
> @@ -2804,7 +2804,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>           if (ret) {
>               error_append_hint(errp, "device does not support "
>                                 "requested feature x-vga\n");
> -            return;
> +            return false;
>           }
>       }
>   
> @@ -2821,6 +2821,8 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>                       "Could not enable error recovery for the device",
>                       vbasedev->name);
>       }
> +
> +    return true;
>   }
>   
>   static void vfio_pci_put_device(VFIOPCIDevice *vdev)
> @@ -2977,7 +2979,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       char *subsys;
> -    Error *err = NULL;
>       int i, ret;
>       bool is_mdev;
>       char uuid[UUID_STR_LEN];
> @@ -3036,9 +3037,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           goto error;
>       }
>   
> -    vfio_populate_device(vdev, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> +    if (!vfio_populate_device(vdev, errp)) {
>           goto error;
>       }
>   


