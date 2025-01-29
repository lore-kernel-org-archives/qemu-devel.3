Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97707C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3O3-0007RQ-Vd; Wed, 29 Jan 2025 03:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1td3O1-0007R3-L7
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:25:25 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1td3Nz-0004v5-Gj
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:25:25 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso43424365e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 00:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738139121; x=1738743921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=doG+pZ5wMWmSy8NVpChfs0wXBXLtXNctbUqnTe24oQE=;
 b=qJVDpKRlYy/f304GuJgWFpoEx+53ti+pmQY9Q2i+D/UjhOXAGa6D9bXNdwWQ1Imj/4
 uz8sUaW6GTa1t1/bCA4nIYhjIsPKUc8JoAHbt6SxGBNmWETxwWqCcRAMBKWI/KamgXZs
 ExNvrM9xAPHn3s8tFVyxrmNp/6R8z+Z8WiBUF4e9jtI5a9dMkwhe2+sFluw5wIkPfFDl
 AdI7/g7etuio8Odd6Ey3bu07VdIZEDVrCp89XJyLnUtZ97uz2rMhZvQRbJ4DUC+OSc5D
 NuCDnxsGFUfHBJEfEqHxqXvX707VrUXweW3p/Q8NDPJ1DB///t3PxPw/kTxY+0suORWD
 KCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738139121; x=1738743921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=doG+pZ5wMWmSy8NVpChfs0wXBXLtXNctbUqnTe24oQE=;
 b=TSS9HMs9l92HXXbCaKB+9Qb8eBfIzJZOTxc/wcd/yicPCX/IiX0tto84UUWX8dJJky
 qkVKptrqW1hrL+jhZbZA+JWfDUBX49E1Q0srWARsFk0O9MeR+1FQc/Zf86cvE1TgXiM5
 /5XihEc6c9EM+JY4U8l2i86Dgf6dniHbCzrlt4kFwj5KA648T11wXnVwT7/GJJyLHods
 X8XOIrj4lLCrZrHKoc8rdC79RTZIcGhHMxJROwRGVH3GpZ/5E4sCNQfEf5/sjK4SXVnE
 GVpHJZPJF2Z1ZZZ3iixtu4WoLK0KfBS4rOu7BYa6deHht24LNiL1JP5iZYzZeBgPUzEA
 zjog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmXJ+HLr/o4PojHlDPOWi/0RKjDtZkMkdGWNnDeCyCwfrEdePFmRTxPbzGO1aABzrRW7DNUNDi3HEX@nongnu.org
X-Gm-Message-State: AOJu0YxFWzyA95lEmwWruT3pNX6nukWDLBAR9kjsBcAL/WkkQAienEQW
 wlI0ZePekMshQF5iA9DvXMaWiJmdzmjVmDMIyZs6DixUDCLkPeh2G2aK5x4VTPg=
X-Gm-Gg: ASbGncsqpiF7e1cOnNaqlWpKvbDx4XmRWMw4Ij3KIW5ZjUAOy7nlfLfpddJ44Ti4yF1
 aXvLWDAVKgrno7GOWVWq50haPiXCUFNGRoFA56Tti3xZtl/ibYmOwb6PSVPc7cqxAfpiW7XB58r
 Ih/6Mqe6hoEhGrRLNygOK03HmodUNAGnjGB1S2jvEu5T+Xb0tOtx4If+SM5WylLyl6T5GagDB/m
 MpqfrPI0DW+pJiQ9bvtzlEruedXjKyR4+aspGXsWmRP8LTi/ImWw7HnDd9AG2bZ7cytmAv3lR0K
 9JtDQ4TTOO2Jg93lVh00ib0rWnhSFGC1Wxp2NJ9ZKqwIfM9CrUus4t7f3oE=
X-Google-Smtp-Source: AGHT+IH9pAme+8XipOgToNGotWVKDpDZX1TrXk/KGFG9dGK/TT/Wtcx9W+jbDg84p0LFKl5pxIZrow==
X-Received: by 2002:a05:600c:3556:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-438dc40d30dmr14888645e9.24.1738139121467; 
 Wed, 29 Jan 2025 00:25:21 -0800 (PST)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2e384sm14056855e9.19.2025.01.29.00.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 00:25:20 -0800 (PST)
Message-ID: <0c7e5fb5-726d-4f65-9944-a24b738c542c@linaro.org>
Date: Wed, 29 Jan 2025 09:25:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
To: "Matthew R. Ochs" <mochs@nvidia.com>, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, nathanc@nvidia.com
Cc: ddutile@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 ankita@nvidia.com
References: <20250128160237.3379569-1-mochs@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128160237.3379569-1-mochs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Matthew,

On 28/1/25 17:02, Matthew R. Ochs wrote:
> The MMIO region size required to support virtualized environments with
> large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
> For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed through
> requires more MMIO memory than the amount provided by VIRT_HIGH_PCIE_MMIO
> (currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
> new parameter, highmem-mmio-size, that specifies the MMIO size required
> to support the VM configuration.
> 
> Example usage with 1TB MMIO region size:
> 	-machine virt,gic-version=3,highmem-mmio-size=1099511627776
> 
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
>   docs/system/arm/virt.rst |  4 ++++
>   hw/arm/virt.c            | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)


> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 49eb0355ef0c..43d47ffedd9a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2773,6 +2773,35 @@ static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
>       vms->highmem_mmio = value;
>   }
>   
> +static void virt_get_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    uint64_t size = extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
> +
> +    visit_type_size(v, name, &size, errp);

Since you correctly use visit_type_size(), maybe use in commit
description example "highmem-mmio-size=1TB" rather than 1099511627776?

> +}

