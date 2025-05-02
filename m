Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C49C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAus1-0003uN-Hs; Fri, 02 May 2025 14:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uAurt-0003tA-4v
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uAurq-0003eb-16
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746209526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lcyWJgX6KhwhEcmIjoCl+j1dVQGsMJsV8mYGlMqhk0=;
 b=Aez86Z1dUPmL6b/fGRiaoU6ZSXJocT3GPNp6PkRG5yK6ELT81egjGDkHQmNXv2K3+Nczap
 D5p12xSf+092KsAn37l5uOmEmmjmOl9wgB9kU6YtdP6ouAvtcOKW8GPLw6ZyuMNHCotNgY
 gRC1fCR6sgASE2YNfEHhjwAcCqIzLIA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-E20NLaAyMZaIkPJMw021cg-1; Fri, 02 May 2025 14:12:05 -0400
X-MC-Unique: E20NLaAyMZaIkPJMw021cg-1
X-Mimecast-MFC-AGG-ID: E20NLaAyMZaIkPJMw021cg_1746209525
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5750ca8b2so349848185a.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746209525; x=1746814325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2lcyWJgX6KhwhEcmIjoCl+j1dVQGsMJsV8mYGlMqhk0=;
 b=DUdBv8zS6VxkJqG8tS/8oJMlFd9DauiftgT1JLeBfyTz7EqjRjiZlcQ7NVWljDvQxB
 AaRjDpVG6YwoCrfPu4Uzj/yohNpMO4seFzRm0PPqNvICH4HcXKlxo2Tj2pNsxQnAbpMe
 cMMTGTFsuDKbu2xvRu/hL07pJeX7e7SNKP3JmvImbIrDE/9WfqhkBz6jg/vvl/R6c/Q/
 UwneZpZkU/taC/wVbmYWnAItpQOBOyrZ7IcepLI0ISEmhxo9D65MDwNQRMpHIdhqcned
 L9CAzoy5zVU+KRh8VM/r7U9tJYFHyJh4JkdT7YOqtQJMwhoh3Adl278lAcMql5ixTPdY
 H/tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO7bwx+jg16jAh8PFz3rXMm0OpuKGf+lJ9lAlP5CtcjQuoo+zuFaIfReeYVgWvR3uC8fi2x3GuKHXp@nongnu.org
X-Gm-Message-State: AOJu0YxBgfQyAh/raBslLv7gAPpUCsNz28jv34p91UzznzPGQymOhgbV
 Nou50Npz814isN0hIqdb2PIg1941V+I4MUdo+r4kf3tzVmeIX9FIj5bVnGGsT8dlOPbjxc/eV67
 Qap1iwUztzh/54s0zLrLdsoClFtv+ZQDG3iP2ds/G9D/l71KsAP2Q
X-Gm-Gg: ASbGncthkK5m7SCpX6i8d++oOCC0QwgLQDp4NF5Hc/Y+1GomV0mici3PoVrK5YpuwRD
 /2bvYhT6IJHMgzytB1AvQ2EuSvHaM7vs2ltdS5lJ6Djn0mXZADZ8ZcA0mSHx37ElDUtyHZpHnKW
 AnFIlUqaL3G3LmQ1xvfBXKSh9/AkZK6rtTMCPlSXAkVHCZw95dayENimLa8rnLpUL0FlxVpdb1e
 nTA2Iy7uCPh96TuCyx0MunODdx7WTHm2kfeCohzXPbKJL6G00XKaFW5NY4gU8noDdPaAQJh0p85
 3R1CLz4i7OyV
X-Received: by 2002:ac8:7f45:0:b0:476:884e:52f4 with SMTP id
 d75a77b69052e-48d5bf6e0a4mr1225301cf.12.1746209525073; 
 Fri, 02 May 2025 11:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzBds/R1iKGEWb4Vz1XzGA1IIdodCP9L87BaOdHn/rSUNRYqm05cXbAN207va439v4UPK8RQ==
X-Received: by 2002:ac8:7f45:0:b0:476:884e:52f4 with SMTP id
 d75a77b69052e-48d5bf6e0a4mr1224881cf.12.1746209524632; 
 Fri, 02 May 2025 11:12:04 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b98c1a459sm20940611cf.69.2025.05.02.11.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 11:12:04 -0700 (PDT)
Message-ID: <9cdb3f09-0925-4e10-b607-8fe1028b2ce0@redhat.com>
Date: Fri, 2 May 2025 14:11:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add support for user creatable SMMUv3 device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 5/2/25 6:27 AM, Shameer Kolothum wrote:
> Hi All,
> 
> Changes from v1:
> https://lore.kernel.org/qemu-devel/20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com/
> 
> Addressed feedback on v1. Thanks to all.
> 1. Retained the same name as the legacy SMMUv3(arm-smmuv3) for new
>     device type as well (instead of arm-smmuv3-dev type usage in v1).
> 2. Changes to ACPI IORT to use the same struct SMMUv3Device for both
>     legacy SMMUv3 and the new SMMUV3 device
> 3. Removed the restriction of creating SMMUv3 dev if virt ver > 9.2.
> 
> Cover letter from v1:
> 
> This patch series introduces support for a user-creatable SMMUv3 device
> (-device arm-smmuv3) in QEMU.
> 
> The implementation is based on feedback received from the RFCv2[0]:
> "hw/arm/virt: Add support for user-creatable accelerated SMMUv3"
> 
> Currently, QEMU's SMMUv3 emulation (iommu=smmuv3) is tied to the machine
should it be clarified as 'to the machine's sysbus' ?
> and does not support instantiating multiple SMMUv3 devices—each associated
> with a separate PCIe root complex. In contrast, real-world ARM systems
> often include multiple SMMUv3 instances, each bound to a different PCIe
> root complex.
> 
> This also lays the groundwork for supporting accelerated SMMUv3, as
> proposed in the aforementioned RFC. Please note, the accelerated SMMUv3
> support is not part of this series and will be sent out as a separate
> series later on top of this one.
> 
> Summary of changes:
> 
>   -Introduces support for multiple -device arm-smmuv3-dev,bus=pcie.x
Drop, as you've done elsewhere.........................^^^^

>    instances.
> 
>    Example usage:
> 
>    -device arm-smmuv3,bus=pcie.0
>    -device virtio-net-pci,bus=pcie.0
>    -device pxb-pcie,id=pcie.1,bus_nr=2
>    -device arm-smmuv3,bus=pcie.1
>    -device pcie-root-port,id=pcie.port1,bus=pcie.1
>    -device virtio-net-pci,bus=pcie.port1
> 
>    -Supports either the legacy iommu=smmuv3 option or the new
>    "-device arm-smmuv3" model.> 
>    -Adds device tree bindings for the new SMMUv3 device on the arm/virt
>     machine only, and only for the default pcie.0 root complex.
>     (Note: pxb-pcie root complexes are currently not supported with the
>      device tree due to known limitations[1].)
> 
> Please take a look and let me know your feedback.
> 
> Thanks,
> Shameer
> [0]:https://lore.kernel.org/qemu-devel/20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com/
> [1]:https://lore.kernel.org/qemu-devel/20230421165037.2506-1-Jonathan.Cameron@huawei.com/
> 
> Nicolin Chen (1):
>    hw/arm/virt: Add an SMMU_IO_LEN macro
> 
> Shameer Kolothum (5):
>    hw/arm/smmuv3: Add support to associate a PCIe RC
>    hw/arm/virt-acpi-build: Update IORT for multiple smmuv3 devices
>    hw/arm/virt: Factor out common SMMUV3 dt bindings code
>    hw/arm/virt: Add support for smmuv3 device
>    hw/arm/smmuv3: Enable smmuv3 device creation
> 
>   hw/arm/smmuv3.c          |  27 +++++++
>   hw/arm/virt-acpi-build.c | 162 +++++++++++++++++++++++++++++++--------
>   hw/arm/virt.c            | 112 ++++++++++++++++++++-------
>   hw/core/sysbus-fdt.c     |   3 +
>   include/hw/arm/virt.h    |   1 +
>   5 files changed, 244 insertions(+), 61 deletions(-)
> 


