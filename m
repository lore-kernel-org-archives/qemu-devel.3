Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796A4C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 21:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMCMD-0007uj-Dv; Mon, 02 Jun 2025 17:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uMCMB-0007u5-St
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 17:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uMCMA-0003qF-AO
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 17:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748898364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPAOzMw4ShRFf2PjoWUiz74Bhb/cLQB/tGLlUw7Kpr8=;
 b=K+Vv2C/gv/nqN1bVZa/fZvN6rgg0lqG9upJqbIxX3dNpL7jZtGAOTlWTGLVUr3ItT6X/N6
 y3W42hWh7exMxqO2oDoFx4BJJJ0Ljl8dYnnSpvHWciOOLGDcIem1yocHNr97s12+yX4FHa
 /RdCx1mgonxe9V02jrdR9BfgpvxKdZ4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-i9wvQYc3NBGsnBzt0GESIQ-1; Mon, 02 Jun 2025 17:06:03 -0400
X-MC-Unique: i9wvQYc3NBGsnBzt0GESIQ-1
X-Mimecast-MFC-AGG-ID: i9wvQYc3NBGsnBzt0GESIQ_1748898362
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c793d573b2so842271785a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 14:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748898362; x=1749503162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TPAOzMw4ShRFf2PjoWUiz74Bhb/cLQB/tGLlUw7Kpr8=;
 b=Li+HhaP+bIX/2Oqus6cRwwsZfuL93739qEHtdycBW+iQHv15kqOCTKOI6LjnMTY0rB
 YQQPwTzF/wGgmnqhRRqlPPtD2VzvGyvY0uTh09eJ89j9MEDkXeSUPS3Asa3GxxRlB6SR
 vs8U1FtyFEuTTPCs1QAMOS8VClIeOBJZFyVSVIZ+6eP7v8Vi6oDtuBAvnzZFpcT2iVte
 7xEzy9BjAno3iuq0H9l9CZDSwlFSba8HPBSVXmfsqBbRDclZ5FPwdldfXblK+x/SVwMA
 dy+TA1q1hCIhnA8/hgh7I5O+aw3B48pOiXBxRAW6csLG6JZ2blBTyhxc3iATWEzr3zWo
 bKNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8x2/rqWzB855XzfAy/SjYmt3uucEv3WqmG3eGsDmtlJXvqFZz11trRY+AlJes6xlVe+q2GikGceh+@nongnu.org
X-Gm-Message-State: AOJu0YwF/X0yaOjh5rkcaqKvnIolLuQqgV028BNXys0PKzmtkaK9pmsF
 LCYFCotAxQiIyCWFkTsPznVpMHBi/bnaj3VnkJDHE8gDHcyLOGZpuKNTXuBiSYSskf7l/PtM7AW
 Je03gMtMA6uE2t6KETxglTJuSX46Z0hTFng5HzxHImTMsNPKglkj/BnQK
X-Gm-Gg: ASbGnctzUtVd2jv7KHe1HkUdTvTdDBOnauXxPr7o7hla3rIe3+iqPPfEiE+/Fc5+W8X
 H+sOcO7oysqBXdyoZnwAe1lPPifAkk0+syX6NXrpm0L/q+JI6Kr7OagGxKb7CXoKEE2BrbaiadM
 /uZ5CxdxIewGrQuLpsexstRyUZMgFUK/6JvhMV2Xi4zHffuDp2a/eq7PKIICfues52/1g63DVl0
 sK5RA+Y5ck5V3Vd31B9l8Jf8t2R/ypGHaAFZYmhBQd9Ee2mj7+0Z5ZR8RXjWAtUjeeKA76cgdHY
 HOFNpb82gK2R
X-Received: by 2002:a05:620a:1a26:b0:7c5:a29e:3477 with SMTP id
 af79cd13be357-7d0a20343e0mr2405040985a.53.1748898362575; 
 Mon, 02 Jun 2025 14:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgGBo7BdJHpAD9PkHwc7C63wadtGTIX2f117lkD2V/ZCSjrqXHk3P3H28OmkvH11/6V3I0EA==
X-Received: by 2002:a05:620a:1a26:b0:7c5:a29e:3477 with SMTP id
 af79cd13be357-7d0a20343e0mr2405037985a.53.1748898362300; 
 Mon, 02 Jun 2025 14:06:02 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d09a1bb27fsm689205185a.116.2025.06.02.14.06.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 14:06:01 -0700 (PDT)
Message-ID: <30b4030e-fb0b-4254-9b43-8f89fe66bfe0@redhat.com>
Date: Mon, 2 Jun 2025 17:05:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt: Check bypass iommu is not set for iommu-map
 DT property
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, nicolinc@nvidia.com,
 linuxarm@huawei.com
References: <20250602114655.42920-1-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250602114655.42920-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/2/25 7:46 AM, Shameer Kolothum wrote:
> default_bus_bypass_iommu tells us whether the bypass_iommu is set
> for the default PCIe root bus. Make sure we check that before adding
> the "iommu-map" DT property.
> 
> Fixes: 6d7a85483a06 ("hw/arm/virt: Add default_bus_bypass_iommu machine option")
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   hw/arm/virt.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9a6cd085a3..99fde5836c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1487,9 +1487,12 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
>       qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
>       g_free(node);
>   
> -    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
> -                           0x0, vms->iommu_phandle, 0x0, bdf,
> -                           bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
> +    if (!vms->default_bus_bypass_iommu) {
> +        qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
> +                               0x0, vms->iommu_phandle, 0x0, bdf,
> +                               bdf + 1, vms->iommu_phandle, bdf + 1,
> +                               0xffff - bdf);
> +    }
>   }
>   
>   static void create_pcie(VirtMachineState *vms)
> @@ -1612,8 +1615,10 @@ static void create_pcie(VirtMachineState *vms)
>           switch (vms->iommu) {
>           case VIRT_IOMMU_SMMUV3:
>               create_smmu(vms, vms->bus);
> -            qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
> -                                   0x0, vms->iommu_phandle, 0x0, 0x10000);
> +            if (!vms->default_bus_bypass_iommu) {
> +                qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
> +                                       0x0, vms->iommu_phandle, 0x0, 0x10000);
> +            }
>               break;
>           default:
>               g_assert_not_reached();

Reviewed-by: Donald Dutile <ddutile@redhat.com>


