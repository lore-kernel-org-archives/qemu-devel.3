Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A05C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 15:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLQd-0006mi-6x; Thu, 03 Jul 2025 11:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uXLQM-0006cw-C6
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 11:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uXLQI-0000zl-LO
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 11:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751554822;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GjKalUHkcSEGgjVYtCtFZXHZ3EjBfG+ibM+BRZYo7H8=;
 b=bTD9tMX6XQXsf30/7dxPoYKeO5Uiqf4e/epf8D0y7G0VmVELsQ6BVOkm6HweaOnUjVhlxL
 hO0djPzdXCxduRG/yctBWcoA8kbsoSjgR86MWjPMUJ6wuCIRasED4kPCF9dOapVgnU6Hdm
 ApJpcO5MS+lKhv/YF789WXrMaX9z2Jo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-gOYWfp5VMO6aXaAAZUNL6g-1; Thu, 03 Jul 2025 11:00:21 -0400
X-MC-Unique: gOYWfp5VMO6aXaAAZUNL6g-1
X-Mimecast-MFC-AGG-ID: gOYWfp5VMO6aXaAAZUNL6g_1751554820
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso2840068f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 08:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751554820; x=1752159620;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GjKalUHkcSEGgjVYtCtFZXHZ3EjBfG+ibM+BRZYo7H8=;
 b=wE+JSV1+yTP/S7QUvz5wSkPUgGaPjLyKVFq+hjo5Zew/YI8WG3AK4xVFSDdHiUm0KD
 nDUUCmwoTrv4Dk2qyqYMYrqcnZKYTg4Ds+eLyMTkoxdz7Tgliq2BcGu0ZJ3CFrj66mai
 IDKTlX40fEz8gwqSGhb8KdzOueS/h1IDHni44xhZppSB/ei5A0f8XUDWYVp58BCreEMN
 xnF2E6+TMO0oWDit/Wo9TWE64p+2/2SCAaygd04GCNhiAlsmWvSRlDca/09IOxDHKsaT
 YPtSHCQNHcQhn7So4ZlNM+7fF09igRJVmpmcrDQK2Gjgko4KE4RaapvuQElZpH4EvwXn
 OdQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFSKlPn0ZWk1Z4Ys5TPb4iivgchTVyGT3WqclwjLmth/bOEF8H7GDcVDvfHkNn1Jl9+e/fd1FP3eTI@nongnu.org
X-Gm-Message-State: AOJu0YwYzTZRzNuDjHHqfDiSKW12FMFxb9xgzVwxNp/RBPGH/emrJpAz
 jHGqWz8HzJpV5q4Q17rvil92118YhSyRJhY1tczeQIvAWsU6kh7uEBY9oP8f+KixZqO7Lkl9FzC
 /lcueCDgPtqJbOuAOzOuMgt2NT4aMm958caXyDPn1cy8OtdbUICTrYlZg
X-Gm-Gg: ASbGnculjH9AuSf7d/TVcMD6Wuy7UlMnpb+YW+TC2djkfyCy9H9eM6HUwtO8SHZV66K
 sT3A+euh76iszAKcGB9K9Vy4Mg7KZCfMQEoZxAu1ZOC97GkSg6+bcstkxIUKqcEmjdOAYE4aVlY
 M16Y42a0988kiGd9dKumnL1Pq0tRddsMKZIpDtQMAFTUL60O0vyONis7Tjv4HXBVBrp70Z5Xfyn
 zxZbhlxQGMezKkQQFOeTsAGihf/p5NukWgTuuG9scv8WPtal0YB70cMaEhC+sh7JGvbXcBzN8Xl
 ubZs8PQocI9jOxUL2jJUelsuewWT4e8/22aCe1BkWWhqxWkVHG3arA+oK67ZgTN/H/I1uA==
X-Received: by 2002:a5d:64e2:0:b0:3a4:fefb:c8d3 with SMTP id
 ffacd0b85a97d-3b20101681emr5752264f8f.40.1751554820036; 
 Thu, 03 Jul 2025 08:00:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeILUvZjP70Q+Vz/zxgZpY8FITJoPudIVl7E0VYTx4tJEdoAosmJVBuyN4mu0HsK4vKmMcog==
X-Received: by 2002:a5d:64e2:0:b0:3a4:fefb:c8d3 with SMTP id
 ffacd0b85a97d-3b20101681emr5752228f8f.40.1751554819597; 
 Thu, 03 Jul 2025 08:00:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997af9esm28852685e9.14.2025.07.03.08.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 08:00:18 -0700 (PDT)
Message-ID: <6b53bfc3-4ff9-4aca-af90-664cd2e959df@redhat.com>
Date: Thu, 3 Jul 2025 17:00:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/12] hw/arm/virt-acpi-build: Don't create ITS id
 mappings by default
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
 <20250703084643.85740-2-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250703084643.85740-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/3/25 10:46 AM, Shameer Kolothum wrote:
> Commit d6afe18b7242 ("hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables
> when its=off") moved ITS group node generation under the its=on condition.
> However, it still creates rc_its_idmaps unconditionally, which results in
> duplicate ID mappings in the IORT table.
>
> Fixes:d6afe18b7242 ("hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables when its=off")
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/virt-acpi-build.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index cd90c47976..724fad5ffa 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -329,12 +329,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* Sort the smmu idmap by input_base */
>          g_array_sort(rc_smmu_idmaps, iort_idmap_compare);
>  
> -        /*
> -         * Knowing the ID ranges from the RC to the SMMU, it's possible to
> -         * determine the ID ranges from RC that are directed to the ITS.
> -         */
> -        create_rc_its_idmaps(rc_its_idmaps, rc_smmu_idmaps);
> -
>          nb_nodes = 2; /* RC and SMMUv3 */
>          rc_mapping_count = rc_smmu_idmaps->len;
>  


