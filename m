Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4D9C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 12:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lMh-0005v5-5P; Wed, 22 May 2024 08:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9lMe-0005rJ-En
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9lMc-0000Wf-I5
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716381997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XTKwF7tP/DwA8w2G7mrRPzhW9h4xzIxNvAXMutx8Goo=;
 b=GOuM0vbD/d+a0sG2iaxi8sEs9wmh0dpQFUpAw4VDoeI8UQD8H1G37A/nLNFhXqTpoCQDDV
 6ivlZ0i3eSwybhtTJTacC89dh8E+17ASJHNViMh12gVsF1Q3GXfY2bdygQH7Y6quETrxRl
 D32NPS8FLlB4Z1JhVzj4kdKmnqt/8Vs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638--pRgzCVlPSCNjUkFvlO7xw-1; Wed, 22 May 2024 08:46:36 -0400
X-MC-Unique: -pRgzCVlPSCNjUkFvlO7xw-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c9ad64e35bso62070b6e.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 05:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716381995; x=1716986795;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTKwF7tP/DwA8w2G7mrRPzhW9h4xzIxNvAXMutx8Goo=;
 b=oQ9lTlxck1Wn7GUide9GSsXKYCwwwn1dnhMh72Ac9fPXJlML8Iz9GL5j6H/t/Ng9l8
 aItxVXd3qd3GxiyD5GE07HHsGJtl22XHCPusuQAGoDgG3WzVCnjRDLsUgSejILIoIVgU
 SaajCRtgyoQwanTWSfy5j8YIM/+LH/Urp7oR94Mqv2noxUb8dVvgCWzPlNXqZdys1mNL
 SX3BPOwB+JgslSnpUDJosVZc/bb6Re3qmM8ICHvQXHhWc8H7g7X3UmpVkvnan7m8okFi
 KTp19j0bVIXreL+LkeUfQFKnuJjxR3q+A2fHU5S5H+5Y7vJj+X8hvDlO+zjsO5zpsIIR
 GQAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDc9GhPngqR7rUDkqLJLxpkDK+DAHRc0n8nE4BH+FO2PxoPeSzJ1TOIJABV40apUWqAw+MEUYuf4ae6FgM23VSZ8j2LPk=
X-Gm-Message-State: AOJu0Yx9gya9FtGafs08GRgXkwkbdUVs0dGOsrlHYvfEmmaYFCgb4MZM
 f4ye1l4lSGFCISW4V9Wn7PFSr/mAu8H20KdSdaN+p9j5CCUMg1DMFMRgTzP9VcvsU0FHkmA7WGP
 JeLWNQ3ZPA+11jjs8hoeJOVOw3c1jcSSjVKUqDrBFwPGG864p3Azq
X-Received: by 2002:aca:231a:0:b0:3c8:4d79:3c5d with SMTP id
 5614622812f47-3cdba016e1dmr1865053b6e.47.1716381995505; 
 Wed, 22 May 2024 05:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEICjmkhP6pDtwie1lf2dTJ6u53mjn/PYn24UFbkM/mfrxJWyRstdijjksckEi8Hyb+aNurvw==
X-Received: by 2002:aca:231a:0:b0:3c8:4d79:3c5d with SMTP id
 5614622812f47-3cdba016e1dmr1864966b6e.47.1716381993742; 
 Wed, 22 May 2024 05:46:33 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-179-90.web.vodafone.de.
 [109.43.179.90]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a4290sm1385740485a.65.2024.05.22.05.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 05:46:33 -0700 (PDT)
Message-ID: <74401a75-3c07-4370-88df-50e325f8930b@redhat.com>
Date: Wed, 22 May 2024 14:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 17/17] tests/qtest: Add intel-iommu test
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
 <20240522062313.453317-18-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240522062313.453317-18-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22/05/2024 08.23, Zhenzhong Duan wrote:
> Add the framework to test the intel-iommu device.
> 
> Currently only tested cap/ecap bits correctness in scalable
> modern mode. Also tested cap/ecap bits consistency before
> and after system reset.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   MAINTAINERS                    |  1 +
>   tests/qtest/intel-iommu-test.c | 63 ++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build        |  1 +
>   3 files changed, 65 insertions(+)
>   create mode 100644 tests/qtest/intel-iommu-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5dab60bd04..f1ef6128c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3656,6 +3656,7 @@ S: Supported
>   F: hw/i386/intel_iommu.c
>   F: hw/i386/intel_iommu_internal.h
>   F: include/hw/i386/intel_iommu.h
> +F: tests/qtest/intel-iommu-test.c
>   
>   AMD-Vi Emulation
>   S: Orphan
> diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
> new file mode 100644
> index 0000000000..e1273bce14
> --- /dev/null
> +++ b/tests/qtest/intel-iommu-test.c
> @@ -0,0 +1,63 @@
> +/*
> + * QTest testcase for intel-iommu
> + *
> + * Copyright (c) 2024 Intel, Inc.
> + *
> + * Author: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"

It's a little bit nicer to write new tests without libqtest-single.h (e.g. 
in case you ever add migration tests later, you must not use anything that 
uses a global state), so I'd recommend to use "qts = qtest_init(...)" 
instead of qtest_start(...) and then to use the functions with the "qtest_" 
prefix instead of the other functions from libqtest-single.h ... but it's 
only a recommendation, up to you whether you want to respin your patch with 
it or not.

Anyway:
Acked-by: Thomas Huth <thuth@redhat.com>

Do you want me to pick this up through the qtest tree, or shall this go 
through some x86-related tree instead?

  Thomas


