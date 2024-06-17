Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8672C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJCuf-0005xt-VQ; Mon, 17 Jun 2024 10:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJCuQ-0005xH-V0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJCuP-0007Yy-BQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718632832;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xL9wG7XSDjPcH4nmlxGq0Q9pePyBWLa34hUS9Ngbu1M=;
 b=gKav5c3qW0268XM8DuF6kH+3YuWgkJ2uvynng9RHPNMIlETTorqDww7aObStbLYN4yxYNE
 bFxWrEY+a3PIaBpaifGyLLMlW9n+6kWXPbAZ9xzv6MRwuSpagp2FTMgjOGuohZSKRJgPtZ
 Wirf6b6zq4U529CUBM3bAZtYdebyFMc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-fIV_S6ffPl2vR6HvITL9IA-1; Mon, 17 Jun 2024 10:00:30 -0400
X-MC-Unique: fIV_S6ffPl2vR6HvITL9IA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-421811b92bcso26764865e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718632828; x=1719237628;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xL9wG7XSDjPcH4nmlxGq0Q9pePyBWLa34hUS9Ngbu1M=;
 b=i6OL9954tA3TImJijVDmT5PJ9tjf4Lmy5p+y2mrmXhCE84ykkiYJV10Jy3fVwCI/RY
 Im1IMAu2tpiJaCEmEFqpEu/mZTk7zodToURHkpd89vJX/+jiQVcT5fH6dHlhu/sDYZkK
 lJWry87WUDPe77hrodhOqIj75DfOK6SdQkqzrL4yZEBpY1bpbKqH2sNaD0PS3FoQ2TqQ
 tX0JLwE8oulzejLfexTgpJ/yy97TZYqMt0ireJ1H6C22cPhOpti50wx8R7R59inYN5RH
 s0pOS4OoVzIYOqQ/yBS1SQP43wmfcqA283ZgIoll898xXvVG8W2gp+KQSzganOEYxPgi
 XydA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb+BEE+U1/He+T0sEEYkTUS+w61bTe83T986y10/+60hskovSeoR+SOtykbww3dDLGl3PtqRTEcMtbgGnOUoV7oPlFN+s=
X-Gm-Message-State: AOJu0YzIs1r6x87Q0oBvd4UIIDaqUkjmUQ7+0AKwhdx06qxK1ExnhrUr
 +j44XPfw3bG8LJDlFtdYhGjht44dYIPyGEfMj0A92Q77VGVU76PM3a6jxhqHvBImdAsIQ1a63xp
 Wz1gUnOJCVcbVPIEZLuMRSZdUujGp8UESG9Myf67IL0xWTRy5I9GX
X-Received: by 2002:adf:f48d:0:b0:360:71a8:695f with SMTP id
 ffacd0b85a97d-3607a78390emr8803867f8f.62.1718632828705; 
 Mon, 17 Jun 2024 07:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7H2tk9APjBTcnF3Jp4Fj/f2yBzLBnmBxcypJ5j+b4pVkhjxDL+labDWM/cb3Kp/62FHjz8Q==
X-Received: by 2002:adf:f48d:0:b0:360:71a8:695f with SMTP id
 ffacd0b85a97d-3607a78390emr8803846f8f.62.1718632828332; 
 Mon, 17 Jun 2024 07:00:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c8cdsm11860760f8f.35.2024.06.17.07.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 07:00:27 -0700 (PDT)
Message-ID: <b02d50c5-7cb8-4903-9c12-f7ec9c29151e@redhat.com>
Date: Mon, 17 Jun 2024 16:00:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/17] vfio/common: Extract vIOMMU code from
 vfio_sync_dirty_bitmap()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-5-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Cédric,

On 6/17/24 08:33, Cédric Le Goater wrote:
> From: Avihai Horon <avihaih@nvidia.com>
>
> Extract vIOMMU code from vfio_sync_dirty_bitmap() to a new function and
> restructure the code.
>
> This is done in preparation for optimizing vIOMMU deviice dirty page
device
> tracking. No functional changes intended.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> [ clg: - Rebased on upstream ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c | 63 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 25 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index fe215918bdf66ddbe3c5db803e10ce1aa9756b90..f28641bad5cf4b71fcdc0a6c9d42b24c8d786248 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1302,37 +1302,50 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
>                                                  &vrdl);
>  }
>  
> +static int vfio_sync_iommu_dirty_bitmap(VFIOContainerBase *bcontainer,
> +                                        MemoryRegionSection *section)
> +{
> +    VFIOGuestIOMMU *giommu;
> +    bool found = false;
> +    Int128 llend;
> +    vfio_giommu_dirty_notifier gdn;
> +    int idx;
> +
> +    QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
> +        if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
> +            giommu->n.start == section->offset_within_region) {
> +            found = true;
> +            break;
> +        }
> +    }
> +
> +    if (!found) {
> +        return 0;
> +    }
> +
> +    gdn.giommu = giommu;
> +    idx = memory_region_iommu_attrs_to_index(giommu->iommu_mr,
> +                                             MEMTXATTRS_UNSPECIFIED);
> +
> +    llend = int128_add(int128_make64(section->offset_within_region),
> +                       section->size);
> +    llend = int128_sub(llend, int128_one());
> +
> +    iommu_notifier_init(&gdn.n, vfio_iommu_map_dirty_notify, IOMMU_NOTIFIER_MAP,
> +                        section->offset_within_region, int128_get64(llend),
> +                        idx);
> +    memory_region_iommu_replay(giommu->iommu_mr, &gdn.n);
> +
> +    return 0;
if this does not return anything else than 0, shouldn't it be void?

Thanks

Eric
> +}
> +
>  static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>                                    MemoryRegionSection *section, Error **errp)
>  {
>      ram_addr_t ram_addr;
>  
>      if (memory_region_is_iommu(section->mr)) {
> -        VFIOGuestIOMMU *giommu;
> -
> -        QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
> -            if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
> -                giommu->n.start == section->offset_within_region) {
> -                Int128 llend;
> -                vfio_giommu_dirty_notifier gdn = { .giommu = giommu };
> -                int idx = memory_region_iommu_attrs_to_index(giommu->iommu_mr,
> -                                                       MEMTXATTRS_UNSPECIFIED);
> -
> -                llend = int128_add(int128_make64(section->offset_within_region),
> -                                   section->size);
> -                llend = int128_sub(llend, int128_one());
> -
> -                iommu_notifier_init(&gdn.n,
> -                                    vfio_iommu_map_dirty_notify,
> -                                    IOMMU_NOTIFIER_MAP,
> -                                    section->offset_within_region,
> -                                    int128_get64(llend),
> -                                    idx);
> -                memory_region_iommu_replay(giommu->iommu_mr, &gdn.n);
> -                break;
> -            }
> -        }
> -        return 0;
> +        return vfio_sync_iommu_dirty_bitmap(bcontainer, section);
>      } else if (memory_region_has_ram_discard_manager(section->mr)) {
>          int ret;
>  


