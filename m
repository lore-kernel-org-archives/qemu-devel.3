Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2E9C369C9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 20:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5sQX-0006Ma-Kf; Fri, 18 Apr 2025 16:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1u5sQV-0006Lw-DY
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 16:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1u5sQS-0006h4-Rx
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 16:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745008502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kk3cV3UijaEe7EB236qxyo+vcuIpCMpVi5mj4bditmw=;
 b=byu2INFcrbeFKi35F5AGn/sy6cBHrxk3GHi/tDsDActHBUYFWKoR4czUcQix4igizVDHRR
 v83vyhUSzyHNS5mbay2/0T4Fy+EZArMVOXtli2oDM+ogvVFHG6YzFWkLAOC+1z1uiYEL3t
 FY6xCL0Rrd5NYHFZQuSY92RLEj04DcU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-8ka4ohPUM_SJMvFvyFmUDg-1; Fri, 18 Apr 2025 16:35:01 -0400
X-MC-Unique: 8ka4ohPUM_SJMvFvyFmUDg-1
X-Mimecast-MFC-AGG-ID: 8ka4ohPUM_SJMvFvyFmUDg_1745008500
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4766c80d57eso38338421cf.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 13:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745008500; x=1745613300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kk3cV3UijaEe7EB236qxyo+vcuIpCMpVi5mj4bditmw=;
 b=IZRSIELxEmvpfuv4uAzGMPxaBUQSWQVi9+8iIqPr60bm/mC08WTjR3ahJ54ZnAqpMw
 8Iu1jIx6dXwadPXwBVnuag5muOPfiF48UI9LWS0oOwqo6kTFRFGWwKfyg46Lh7KgKcKC
 JLmk1sA+/toR3Yb9GeS2KuDV2t+bGPiIQeKZ9haTPeCiJSUljmL9/AkB69bdMq2WOUqI
 vEOidu5cWwvNeeMlEUFNRiU73RspY+WBtq81Jk3kaQpyFD1vKOKBcq3KSiQv4659u8Rh
 WbQftejMpedEfw1R3X2aYfFLNsb6T4aMOFmQ1MkCPYTAWj71Mo2F+0vIVYTqOEfzzkPD
 nRSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgVPNZN+23czUX+I2qX6igUd9LqmPsLE93F89uDJ85RXBnCIBlwcP+shVfIdEhTB9i4xruEas9DY6G@nongnu.org
X-Gm-Message-State: AOJu0YxBsALK09fXRXBlpOBwI9sakplQUWZDXOmlsVDv6NgxwX4kKNaP
 dwbi0LBAyyZJkSma3+BImmsVDzWDD0XxFh5wrTcJ1PROxuRqENsbPmdb0l57XwstxJSpFSDVVoy
 /82JNrwMWadA4iB+o231qbaB6Jg5eAWCNlbSI07lMqdRpF9D8WIPi
X-Gm-Gg: ASbGnctJKgdkE3GtAjDGIv9f05Pz+nCpWZqNnQL3kyXIcbi+X7xdnYlCcFAPtYtlGAw
 eLTS/sGFRYajMyALeflyUvyR6gEpfneEktedxlXv295ecBTzAwwNxLNocrZmc+r8mjD97Qjxue/
 jB8Zhixwvigvpf9eOIiMoOVlQPC2ZaoR8WPB5dVok006vj5O3LeoslGkPl6r3lsvqXORmUaCqnZ
 YhH4qVyFu2rEFYI6VxJZbrnX+f1sRq/nA9OIFS0dUuWiHM9ILJGlFtCWAJrWl5V1df+NX37GrmT
 2t4kbX6+LW+j
X-Received: by 2002:a05:622a:2d2:b0:476:977c:2eb0 with SMTP id
 d75a77b69052e-47aec3cc14bmr73588111cf.30.1745008500475; 
 Fri, 18 Apr 2025 13:35:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErGnBzyS3PHUHD7NiNVEUqWSIJFhM+E77pT7qyRYrw6IIrboClsgnEIA1s8XhEC1kWnVn6Yg==
X-Received: by 2002:a05:622a:2d2:b0:476:977c:2eb0 with SMTP id
 d75a77b69052e-47aec3cc14bmr73587741cf.30.1745008500164; 
 Fri, 18 Apr 2025 13:35:00 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ae9c188a8sm14007101cf.8.2025.04.18.13.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 13:34:59 -0700 (PDT)
Message-ID: <84870c74-f078-48c5-bead-96db1d582987@redhat.com>
Date: Fri, 18 Apr 2025 16:34:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for user creatable SMMUv3 device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Shameer,
Hi!

First off, like the partitioning of these pieces.

On 4/15/25 4:10 AM, Shameer Kolothum wrote:
> Hi All,
> 
> This patch series introduces support for a user-creatable SMMUv3 device
> (-device arm-smmuv3-dev) in QEMU.
> 
Can we drop the '-dev', as 'arm-smmu' is sufficient, as is '-device'?

I know, internal to QEMU, there's already an ARM_SMMU, but as suggested later,
if it uses the same struct, the qemu cmdline syntax is a bit less redundant.

> The implementation is based on feedback received from the RFCv2[0]:
> "hw/arm/virt: Add support for user-creatable accelerated SMMUv3"
> 
> Currently, QEMU's SMMUv3 emulation (iommu=smmuv3) is tied to the machine
> and does not support instantiating multiple SMMUv3 devices—each associated
> with a separate PCIe root complex. In contrast, real-world ARM systems
> often include multiple SMMUv3 instances, each bound to a different PCIe
> root complex.
> 
> This also lays the groundwork for supporting accelerated SMMUv3, as
> proposed in the aforementioned RFC. Please note, the accelerated SMMUv3
> support is not part of this series and will be sent out as a separate
> series later on top of this one.
> 
> Summary of changes:
> 
>   -Introduces support for multiple -device arm-smmuv3-dev,bus=pcie.x
>    instances.
> 
>    Example usage:
> 
>    -device arm-smmuv3-dev,bus=pcie.0
>    -device virtio-net-pci,bus=pcie.0
>    -device pxb-pcie,id=pcie.1,bus_nr=2
>    -device arm-smmuv3-dev,bus=pcie.1
>    -device pcie-root-port,id=pcie.port1,bus=pcie.1
>    -device virtio-net-pci,bus=pcie.port1
> 
>    -Supports either the legacy iommu=smmuv3 option or the new
>    "-device arm-smmuv3-dev" model.
> 
nice! :)
Can it support both? i.e., some devices using a system-wide, legacy smmuv3,
and some pcie devices using the -device arm-smmuv3 ?

If not, then add a check to min-warn or max-fail, that config.
I can see old machines being converted/upgraded to new machines,
and they will want to switch from legacy->device smmuv3, and catching
an edit/update to a machine change (or enabling automated conversion) would be helpful.

>    -Adds device tree bindings for the new SMMUv3 device on the arm/virt
>     machine only, and only for the default pcie.0 root complex.
>     (Note: pxb-pcie root complexes are currently not supported with the
>      device tree due to known limitations[1].)
>    -Restricts usage of the new SMMUv3 device to virt machine versions > 9.2.
>     This is to avoid creating new smmuv3 device for old virt machine versions
>     and accidently breaking the migration support.
> 
> Please take a look and let me know your feedback.
> 
> Thanks,
> Shameer
> [0]:https://lore.kernel.org/qemu-devel/20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com/
> [1]:https://lore.kernel.org/qemu-devel/20230421165037.2506-1-Jonathan.Cameron@huawei.com/
> 
> Shameer Kolothum (5):
>    hw/arm/smmuv3: Introduce SMMUv3 device
>    hw/arm/virt-acpi-build: Update IORT for multiple smmuv3 devices
>    hw/arm/virt: Factor out common SMMUV3 dt bindings code
>    hw/arm/virt: Add support for smmuv3 device
>    hw/arm/smmuv3: Enable smmuv3 device creation
> 
>   hw/arm/smmuv3.c          |  55 ++++++++++++++++++
>   hw/arm/virt-acpi-build.c | 119 +++++++++++++++++++++++++++++++++++----
>   hw/arm/virt.c            | 109 ++++++++++++++++++++++++++---------
>   hw/core/sysbus-fdt.c     |   3 +
>   include/hw/arm/smmuv3.h  |  16 ++++++
>   include/hw/arm/virt.h    |   2 +
>   6 files changed, 266 insertions(+), 38 deletions(-)
> 


