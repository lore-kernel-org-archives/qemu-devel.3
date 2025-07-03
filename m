Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC86C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMtB-0007CR-2f; Thu, 03 Jul 2025 12:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uXMt7-00077s-TY
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uXMt4-0001ix-CK
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751560450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaCcGqOSLi5xymHRgXk9oQXJi3fiaQ8iLUZzWw1Wc4g=;
 b=PRxSpKANq0nOq/Yq1Ot6pIAJgI1eekvImegQGGNomj5c8PxRpeyMJpSdNZ3Z6r1pLwwneF
 rIMpumSABbUeq279qNMIzoN9jVuogpVax21PokgTv/3n5ZlEBvdLZwhKt9sJUUAefL3Wnf
 37BPQuBhrfK81QaZNNPgh5IdjbauVoA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-gX4GQZcoO52mgB8QBoB9Bw-1; Thu, 03 Jul 2025 12:34:08 -0400
X-MC-Unique: gX4GQZcoO52mgB8QBoB9Bw-1
X-Mimecast-MFC-AGG-ID: gX4GQZcoO52mgB8QBoB9Bw_1751560447
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-610bf6f2c8bso123658eaf.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751560447; x=1752165247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eaCcGqOSLi5xymHRgXk9oQXJi3fiaQ8iLUZzWw1Wc4g=;
 b=w3ZDRABCop2i8vWa0Ik3h3kfrnok1Bebn2//9Q+3l3XBwpfJpinSceLBxJJz5fFQZ3
 KNh8T4SEuFDT//b+UZZymBhfgc+r89Q4PuOw1ckQL7qCAsXKIJ55gAVw09sRr5k6gvOc
 hSrChiP7WmgaxscQaeIlo52+rskKDhJn/YRxSE2FUzmGc5fEAzqtoOeC8i6cM6sJGMRM
 VTikYFFACnY4UPNRqfJvR8ZvOAKFxDL8fQo5RA//7HNLqh6LZIF9BfbRTNsvGR7RtArA
 yuW36qHA8Q9QtTKzoS7sv52Dnft/5gT3yKb4NXMXnjT424jPD915saQm9GzVw+Bg2oI6
 baEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2JWzFgD9NH08p/LhBIdRZebTGBxiiZ/yulC/fuI6LmrkxD6NuvgF3YjZn4pE1Wv+bBCbKIVMVUqOX@nongnu.org
X-Gm-Message-State: AOJu0YyESSTB85f5hJshn9+7iyEo24DPA9QpGpgGOiadFwSVIWgf9DxH
 QgTqBlUG+Aj26rVJtxjuAa2bs8j7xASaFiUMow8XBhl7zrPVGs6gQnV1QNHRtRwRdNKJtfenix8
 xe+0JREti4asbAg/FUcFFaD0J/i/QKUy0/Nu1PV+YrGGP6F+qz05nEWAw
X-Gm-Gg: ASbGncsnxVnwmnY4pYc8DrXUNUGZlxxnYwozRqJyyj6aw4O7CzcHBD9dDjz8iY9NhDy
 wMJg2YSv+Hwl0uYmDc11alwMhxYcemPNzpqExrtiOcXVidK4ika40TFk7B9MwPgxgvE+c7UELyw
 DJb0nKkhGOHHXNKY/ApzIvw/7Hn98n83jl1/B/X4ooS9C7V6IJMZKAkQ4joqE66gTcpLmWze5Hd
 VNo8zY9cMEyzS4XfQOykKHTv+K+c42Uvwj3bYvIA/tsSGF14f2WpJVx9DM9MJtLAzoEG50me/RO
 KcfjPG8Q4ie4uS7H5lx0vnw=
X-Received: by 2002:a05:6871:758a:b0:29e:1cd8:4a0f with SMTP id
 586e51a60fabf-2f76ed9763dmr2844160fac.17.1751560447628; 
 Thu, 03 Jul 2025 09:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLoLSViRCL48qhCfgGJUhva4AdGl3MDnYo9XuAOAg5bgATHS6OxkQwC3205eGWvhHxTfzHIg==
X-Received: by 2002:a05:6871:758a:b0:29e:1cd8:4a0f with SMTP id
 586e51a60fabf-2f76ed9763dmr2844133fac.17.1751560447228; 
 Thu, 03 Jul 2025 09:34:07 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd512dc69sm4515294fac.47.2025.07.03.09.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 09:34:06 -0700 (PDT)
Message-ID: <c3d7e59d-eda6-4bc4-913c-e23555c13bdd@redhat.com>
Date: Thu, 3 Jul 2025 12:32:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/12] hw/arm/virt-acpi-build: Don't create ITS id
 mappings by default
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
 <20250703084643.85740-2-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250703084643.85740-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/3/25 4:46 AM, Shameer Kolothum wrote:
> Commit d6afe18b7242 ("hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables
> when its=off") moved ITS group node generation under the its=on condition.
> However, it still creates rc_its_idmaps unconditionally, which results in
> duplicate ID mappings in the IORT table.
> 
> Fixes:d6afe18b7242 ("hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables when its=off")
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   hw/arm/virt-acpi-build.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index cd90c47976..724fad5ffa 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -329,12 +329,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>           /* Sort the smmu idmap by input_base */
>           g_array_sort(rc_smmu_idmaps, iort_idmap_compare);
>   
> -        /*
> -         * Knowing the ID ranges from the RC to the SMMU, it's possible to
> -         * determine the ID ranges from RC that are directed to the ITS.
> -         */
> -        create_rc_its_idmaps(rc_its_idmaps, rc_smmu_idmaps);
> -
>           nb_nodes = 2; /* RC and SMMUv3 */
>           rc_mapping_count = rc_smmu_idmaps->len;
>   
Reviewed-by: Donald Dutile <ddutile@redhat.com>


