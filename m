Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E87C2BA1B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPfN-0001ND-1g; Wed, 12 Mar 2025 13:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsPfL-0001MS-1p
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsPfI-00021A-UK
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741799682;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMu5WP+Jm2M4zMwL8RkNJmwJJU+7iZ2+WKJxbWSqfiU=;
 b=I+2iy3YgX9gi/Sc2cbor+tL/zQ/hC9IhQ/6ss89XDEvKpi/TQHCpBvldeTTHRJqqh2z3qK
 l/nKX1R1yGO37fWjJA6v60gyEa6pWqDWq0vfQiK+meVT6de1ePR50FCWBQlCbSSaC/1lVu
 BXXbtni/j1wQNuORCo6NqhRb6AwtJ+4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-6rHJDM2oO8Ck0Cn6d18tmA-1; Wed, 12 Mar 2025 13:14:34 -0400
X-MC-Unique: 6rHJDM2oO8Ck0Cn6d18tmA-1
X-Mimecast-MFC-AGG-ID: 6rHJDM2oO8Ck0Cn6d18tmA_1741799673
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4766e03b92bso20111cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 10:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741799673; x=1742404473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LMu5WP+Jm2M4zMwL8RkNJmwJJU+7iZ2+WKJxbWSqfiU=;
 b=jtNcxCTyIK0RmdOWZlnYN2vwYp8IRp5tfMsPTjmslKKv5eYwL7nCFEP4HrzgsPVO5a
 1iCe7FbuC0hqLxWb7Nj3wHsKyPiQWV+H6Iwwgb/T2LYISBhrN5Pk1yXkhS1YJCDn85Pa
 YIg9NNHRDkErlZ5NZiCvbWzqGlFVlpy2pA7dWNzoLKdqu9wwVZsm6RWfZBh7gGysYtV5
 QcrnOa/bSAtnf/BB+Q5EXASSv2jzBUvUDD9Kt9hxV1xMxlZKJmpxLbxkm/hpltRiBuN8
 lvJFSKUGx4X39qrVPUo7vubEYHqJn+NhLwPObiyEwGKlxKRYU9q1dTBgr4sUrToJ2bEO
 NfLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQrS8tZCStpfmwNJoQCyU9Jix2ImL1n9mpTQzkxrPrO6qCGkURnAfYPnEHrcrWAxeCQaiH8rzEAbCp@nongnu.org
X-Gm-Message-State: AOJu0Yy/5CtLm3Ny+HqpC3M6KiZ9XR5OCs42dbqUfqPCl1Lb7t5CCuP9
 M2E5kOhLqGhnMlTIpJYBUvSCOV9L4xL3aQXN0S97Pr0oDsAa1DIBPr4eiKCDII9TN0RJ5UTBEj7
 ESxH58279FCkBYbEVJPFEvskCJhmslJQiclNGz5zcAE4DfLVYo1yw
X-Gm-Gg: ASbGnctnWTrM1lpkHiPSWdexN/rJQ8EMtHaLujdN7tP1IsLP4Vs6rCTh6xXGXJNqbgI
 Vc5wiLVxDeIvlVr8NxnPalHj73+6459WLhkEcitFnavoyj/5ZtS6834gjPJr1gW1wk7+ItEmsSe
 u2+R4tJJ0589Dopvrl0wFTIqfrw9Owd69FsLOFfUMoVDcBwz/wlGLpaw2kxqaeNCt5hiYL7Yk5m
 tQRAOFWvcdlX31qgwGlm3csWx56gsW7p6O9DHVirqw5AQrwQF7dj+W0Z1SS2s2i4L0lWD2YE705
 xKNXlpexBUeUm3RiaYW69GX0wg+3pO/2jvWWBquH4MBnFPci/vMChbsaFt93URI=
X-Received: by 2002:a05:622a:13cb:b0:476:8588:ceae with SMTP id
 d75a77b69052e-47699648afdmr105963701cf.45.1741799673627; 
 Wed, 12 Mar 2025 10:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMrXnzTXSDJfcELJrFX7b8tvSW2aJShUk8TkCKmIPJWlyc2JhTb+fVxRieGzykd0wXqVpPKg==
X-Received: by 2002:a05:622a:13cb:b0:476:8588:ceae with SMTP id
 d75a77b69052e-47699648afdmr105963471cf.45.1741799673314; 
 Wed, 12 Mar 2025 10:14:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47669169887sm60772431cf.43.2025.03.12.10.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 10:14:32 -0700 (PDT)
Message-ID: <9c30ecfe-4d1b-4d09-9787-aab936217e12@redhat.com>
Date: Wed, 12 Mar 2025 18:14:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/20] hw/arm/smmuv3-accel: Provide
 get_address_space callback
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-9-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-9-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Shameer,

On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> Also introduce a struct SMMUv3AccelDevice to hold accelerator specific
> device info. This will be populated accordingly in subsequent patches.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c         | 36 +++++++++++++++++++++++++++++++++++
>  include/hw/arm/smmuv3-accel.h |  4 ++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 1471b65374..6610ebe4be 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -11,6 +11,40 @@
>  #include "hw/arm/smmuv3-accel.h"
>  #include "hw/pci/pci_bridge.h"
>  
> +static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
> +                                                PCIBus *bus, int devfn)
> +{
> +    SMMUDevice *sdev = sbus->pbdev[devfn];
> +    SMMUv3AccelDevice *accel_dev;
> +
> +    if (sdev) {
> +        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    } else {
> +        accel_dev = g_new0(SMMUv3AccelDevice, 1);
> +        sdev = &accel_dev->sdev;
> +
> +        sbus->pbdev[devfn] = sdev;
> +        smmu_init_sdev(s, sdev, bus, devfn);
> +    }
> +
> +    return accel_dev;
> +}
> +
> +static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
> +                                              int devfn)
If you reimplement the ops for the accelerated smmu why did you need to
add:

+++ b/hw/arm/smmu-common.c
@@ -865,6 +865,10 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
     SMMUState *s = opaque;
     SMMUPciBus *sbus = smmu_get_sbus(s, bus);
 
+    if (s->accel && s->get_address_space) {
+        return s->get_address_space(bus, opaque, devfn);
+    }

in 7/20?

Eric

> +{
> +    SMMUState *s = opaque;
> +    SMMUPciBus *sbus;
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUDevice *sdev;
> +
> +    sbus = smmu_get_sbus(s, bus);
> +    accel_dev = smmuv3_accel_get_dev(s, sbus, bus, devfn);
> +    sdev = &accel_dev->sdev;
> +
> +    return &sdev->as;
> +}
> +
>  static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
>  {
>      DeviceState *d = opaque;
> @@ -30,6 +64,7 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
>      SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(d);
>      SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_GET_CLASS(s_accel);
>      SysBusDevice *dev = SYS_BUS_DEVICE(d);
> +    SMMUState *bs = ARM_SMMU(d);
>      Error *local_err = NULL;
>  
>      object_child_foreach_recursive(object_get_root(),
> @@ -41,6 +76,7 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> +    bs->get_address_space = smmuv3_accel_find_add_as;
>  }
>  
>  static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
> index 56fe376bf4..86c0523063 100644
> --- a/include/hw/arm/smmuv3-accel.h
> +++ b/include/hw/arm/smmuv3-accel.h
> @@ -16,6 +16,10 @@
>  #define TYPE_ARM_SMMUV3_ACCEL   "arm-smmuv3-accel"
>  OBJECT_DECLARE_TYPE(SMMUv3AccelState, SMMUv3AccelClass, ARM_SMMUV3_ACCEL)
>  
> +typedef struct SMMUv3AccelDevice {
> +    SMMUDevice  sdev;
> +} SMMUv3AccelDevice;
> +
>  struct SMMUv3AccelState {
>      SMMUv3State smmuv3_state;
>  };


