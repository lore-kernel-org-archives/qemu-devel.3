Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C06DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEm37-0001up-VH; Tue, 13 May 2025 05:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEm36-0001uC-GZ
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEm33-0004M4-Tz
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747128940;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2sEFkNhHYZ7GGQUEXzmazTwyDBnc/lAYLVVyCnVFpc=;
 b=TYt78D+E9H+6mntBmMeT9yFcMZX8N1dev+BerviX5IPaNDSfSCD5JCFPMhemx/ORfIvzTN
 hmzlKqqrYdVi3rh5x9bIPZvnxFpbpKj5Cz6lIaMgAkGSR9+v2qhLDupa2g+MCN9o1EzKSn
 AtveR2iNq4KpmU197YsdV4nWuZq4NRE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-BskttH6MOpSzqU9K_OwySQ-1; Tue, 13 May 2025 05:35:39 -0400
X-MC-Unique: BskttH6MOpSzqU9K_OwySQ-1
X-Mimecast-MFC-AGG-ID: BskttH6MOpSzqU9K_OwySQ_1747128938
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso25863905e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 02:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747128938; x=1747733738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x2sEFkNhHYZ7GGQUEXzmazTwyDBnc/lAYLVVyCnVFpc=;
 b=o6hRUr7TPC35aV17LkasywulJlI2U9+YB4aXF/7nMQCPgn7Dtn2bJ2Bz9PIeSTjWpM
 o3DW4qwOuWhffNFKpfjtrakFHeh8cajzXLYfQRYMDPXB81C7Gu+kUul9zN7q98M9bLS6
 Lp0qUQvxZgNJpRgowjwCgjp3XlRiUYpECVp06Km00Siwi1SKQu0+9Ze1G1fRGPpquY6m
 L0dqkC3CknJ3FlEAPnOQZ02igxxRgwXTHnMhqAi9Ogf9XBxbq1veTeftUB8p86g9w0w3
 9xiyl+nWGVcm6MaN87EizUK3BY3OEdhgw8bgWEnTsVMLhagSrX1EkRAHxMAqsNa/DsZ6
 5QDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeIFQzT9yBbzGuZ7qK9KTRxvzB7Dp4P+hTX8riMmj47WLpLntG4+AdOpzLsXalCanxUgv8x5wQm8iZ@nongnu.org
X-Gm-Message-State: AOJu0Ywihqbk2eUs8nfpRQtb5i3B9GDfTqSbnMXYbP42fhf6ryec8JR0
 Hxpau1hwN1TZlIQ4ZvKO+jstCnb4rdI7Wyh22WMFnnKc70wYlRn5VlIpbkP+gSK0q7ugRW2xp6F
 mdRiuQPELLUXvl+weuPe7qTlZ4SypFAdOBASGPMZtlIY/zWeGrCAf
X-Gm-Gg: ASbGncswEgAp957XtSiY5lZ6ejUiS3C/C3bnXyjMeEcrrUW9g5W9EHsdHyu47zN6ccl
 7vagPOIFwJUO3yU04AUGn32a7h8wzQ2l1oggNucrLcvzj+MUiKbxheIL5w/TpYE907gNen946cW
 msJJ4McHkOtONQ/XQU4yBZhIL2y3FA9bM3GCxrGDzlzB59is2clkuisKkiAIIBsgBJr1G6FdOwP
 ms4zDRpHNjOY0ZI49lm8pfXcyJA3KJcE13wEmPNwj4zhFqB4WLPz9JiejVthh2hSX+YwA5eamYw
 r70P9zglDoQpeU7MtFK26rTCXL4zCnLucYMUXsRNOjVFq9LP+YjTztow3ok=
X-Received: by 2002:a05:600c:3e8c:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-442d6ddf4d7mr118849385e9.32.1747128937782; 
 Tue, 13 May 2025 02:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCI4rgD0A88V6XQZo6DtnOn6uXQ6p6jHrD+3b6d48dahq9xWQ6xtY85o20G9s32vk3lb7GpQ==
X-Received: by 2002:a05:600c:3e8c:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-442d6ddf4d7mr118849015e9.32.1747128937420; 
 Tue, 13 May 2025 02:35:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d687bdd6sm158275685e9.38.2025.05.13.02.35.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 02:35:36 -0700 (PDT)
Message-ID: <df944d74-335a-4131-a58b-3bf4dd6fc1b7@redhat.com>
Date: Tue, 13 May 2025 11:35:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/14] arm/kvm: use fd instead of fdarray[2]
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250506085234.855779-1-cohuck@redhat.com>
 <20250506085234.855779-15-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250506085234.855779-15-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Connie,

On 5/6/25 10:52 AM, Cornelia Huck wrote:
> We have fd, so might as well neaten things up.
>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Cheers

Eric
> ---
>  target/arm/kvm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index abb63b7f617f..1ffd67a39056 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -387,11 +387,11 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          err |= get_host_cpu_reg(fd, ahcf, ID_ISAR6_EL1_IDX);
>          err |= get_host_cpu_reg(fd, ahcf, ID_MMFR4_EL1_IDX);
>  
> -        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
> +        err |= read_sys_reg32(fd, &ahcf->isar.mvfr0,
>                                ARM64_SYS_REG(3, 0, 0, 3, 0));
> -        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr1,
> +        err |= read_sys_reg32(fd, &ahcf->isar.mvfr1,
>                                ARM64_SYS_REG(3, 0, 0, 3, 1));
> -        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr2,
> +        err |= read_sys_reg32(fd, &ahcf->isar.mvfr2,
>                                ARM64_SYS_REG(3, 0, 0, 3, 2));
>          err |= get_host_cpu_reg(fd, ahcf, ID_PFR2_EL1_IDX);
>          err |= get_host_cpu_reg(fd, ahcf, ID_DFR1_EL1_IDX);
> @@ -429,7 +429,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>  
>          if (pmu_supported) {
>              /* PMCR_EL0 is only accessible if the vCPU has feature PMU_V3 */
> -            err |= read_sys_reg64(fdarray[2], &ahcf->isar.reset_pmcr_el0,
> +            err |= read_sys_reg64(fd, &ahcf->isar.reset_pmcr_el0,
>                                    ARM64_SYS_REG(3, 3, 9, 12, 0));
>          }
>  


