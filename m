Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D23C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlSTR-0005u4-2r; Fri, 21 Feb 2025 07:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlSTP-0005tp-49
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlSTL-00022b-Fk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740142176;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sPRjVPKGU4AcbmlCu20jogDHiHQ5dUn6Y88FClfZTYU=;
 b=M5v2YJ+f1ulDQx/BojNYPMb5uW9TbFH/SGlxPATHD5YZf2tllW6PSUToEqfOzmZXaF4eZH
 QFiNLcbDaIfv5C0Qyz4lvZ0IUIyp52f0KuUHibI8s/ginQOYKT6wW1+IyfKeSKJE8uGQkG
 gJCHvb6pqH6QPH7Nla+hlaE8eRsfT6A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-N4hEljdMPryadp9aDA5SJg-1; Fri, 21 Feb 2025 07:49:35 -0500
X-MC-Unique: N4hEljdMPryadp9aDA5SJg-1
X-Mimecast-MFC-AGG-ID: N4hEljdMPryadp9aDA5SJg_1740142174
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4394c489babso11116415e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740142174; x=1740746974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sPRjVPKGU4AcbmlCu20jogDHiHQ5dUn6Y88FClfZTYU=;
 b=H2VbwBLpvx0rfaydbO+z+stmhwT7XZqC8q8u4KjzKObhaD/39ckjZ319xKN0uxm7HN
 0kHtZPI1N26Cbu0zQe69F3Tqe4qPneTwEd8GnXOzFZyzwLqfdx/4p/MX+luke881JzoI
 ThF4d/N4Q60dtPRBT6phEEo1/59tevFFtcnYfawlvljmDzeUb0MxolCcds1/vIgXG8bd
 Yty81cLYIncViVm+1wwZWodXYIUG0Udmd/EYrP3PeQcl/qF5lVP2uW0XJllzgJbdGaGR
 /1bWUhhFWKqdP8gZ7GuUmW6ANVAsrgOClnchZ/dBRG+EqW3fW/BFxjzlHDWi+4tz6x5S
 B3Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSHCW2+CMjMObCqYgmuIwOqTjOttjieUFegpuCWGqJfIkGaymsPtI1Zw7NjQZCS1UGZiLLSDJBRLV4@nongnu.org
X-Gm-Message-State: AOJu0YyTDfRh88v0REg4bh/u9FJhIlQPVMsOP+lqMQ5C/c/xMIy0GzLl
 WPd8h1uAZbXoZg2sgOScQqEx/ognyy1kXQY9/o1KCNtAWSFfyuhJqWGCFnE8UJuaBN84Iqu5QJ8
 NeaBHQQk4qDhlpwFKO/xe/VlRgfUW9delPHb1/VlFPddt7We0RN+x
X-Gm-Gg: ASbGncsjIB/9AnNnYgsij4yGL/OtP3AdRkROTuKfvF7lRNtEYECuehOVEF2mxAtnTVx
 j7rnJrc52pKVLkRkv9r3cgJvr8xngtZA8PG5JsRNrsv0ZMJPVoOlOIr/Oo0ECmIYrQS6MPq9N5L
 364HhAHhSrWJvc4NedjFYhGfkSmL4f2TVpZ2sX3yPqWLQKCiyGQP9IGJAre4b6fEoWFL6urhr8q
 NL5+/Fw7MWjq2kg5pLOMXqssChwi69igtyzC/bx5zg71gW1F+46CYvx2e0LVCvzoXbiW3dg70M4
 3VFyKf2yXpBhPNk0gpYkhWcJ5HYdlErwDRDMtWHsNgn4cgRFw65o89uoRReb6Kw=
X-Received: by 2002:a05:600c:3b1f:b0:439:98ef:5d6 with SMTP id
 5b1f17b1804b1-439ae2128a5mr22539515e9.22.1740142174450; 
 Fri, 21 Feb 2025 04:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGkNFW6dHZ6//3aml3CK3oTKR1k+qvco7ktksD9HYlQSs3GtFDHD7+pbvqeiKDnB4nr9vByw==
X-Received: by 2002:a05:600c:3b1f:b0:439:98ef:5d6 with SMTP id
 5b1f17b1804b1-439ae2128a5mr22539295e9.22.1740142174064; 
 Fri, 21 Feb 2025 04:49:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b030b347sm16440165e9.26.2025.02.21.04.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 04:49:32 -0800 (PST)
Message-ID: <ba276dfd-fe0a-43ab-90bf-163e1ad76d06@redhat.com>
Date: Fri, 21 Feb 2025 13:49:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 11/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-12-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Zhenzhong,


On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
> is passed to host to construct nested page table. We need to check
> compatibility of some critical IOMMU capabilities between vIOMMU and
> host IOMMU to ensure guest stage-1 page table could be used by host.
>
> For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
> does not, then this IOMMUFD backed device should be failed.
is this 1GB huge page mapping a requiring for SIOV?
>
> Declare an enum type host_iommu_device_iommu_hw_info_type aliased to
> iommu_hw_info_type which come from iommufd header file. This can avoid
s/come/comes
> build failure on windows which doesn't support iommufd.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/system/host_iommu_device.h | 13 ++++++++++++
>  hw/i386/intel_iommu.c              | 34 ++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index 250600fc1d..aa3885d7ee 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -133,5 +133,18 @@ struct HostIOMMUDeviceClass {
>  #define HOST_IOMMU_DEVICE_CAP_FS1GP             3
>  #define HOST_IOMMU_DEVICE_CAP_ERRATA            4
>  
> +/**
> + * enum host_iommu_device_iommu_hw_info_type - IOMMU Hardware Info Types
> + * @HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not
> + *                                             report hardware info
> + * @HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
> + *
> + * This is alias to enum iommu_hw_info_type but for general purpose.
> + */
> +enum host_iommu_device_iommu_hw_info_type {
> +    HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_NONE,
> +    HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD,
> +};
> +
>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
>  #endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 7709f55be5..9de60e607d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -39,6 +39,7 @@
>  #include "kvm/kvm_i386.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> +#include "system/iommufd.h"
>  
>  /* context entry operations */
>  #define VTD_CE_GET_RID2PASID(ce) \
> @@ -4346,6 +4347,39 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          return true;
>      }
>  
> +    /* Remaining checks are all stage-1 translation specific */
> +    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
> +        return false;
> +    }
> +
> +    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE, errp);
> +    if (ret < 0) {
> +        return false;
Can't you simply rely on the check below?
> +    }
> +    if (ret != HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD) {
> +        error_setg(errp, "Incompatible host platform IOMMU type %d", ret);
> +        return false;
> +    }
> +
> +    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_NESTING, errp);
> +    if (ret < 0) {
> +        return false;
> +    }
same heere
> +    if (ret != 1) {
> +        error_setg(errp, "Host IOMMU doesn't support nested translation");
> +        return false;
> +    }
> +
> +    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_FS1GP, errp);
> +    if (ret < 0) {
> +        return false;
> +    }
> +    if (s->fs1gp && ret != 1) {
looking in the vtd spec I don't find FS1GP. Is it the same as FL1GP?
Maybe I am not looking the correct spec though. Why do you need to check
both ret and fs1gp
Even why do you need a member to store the cap? Looks FL1GP can only
take 0 or 1 value?
> +        error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
> +        return false;
> +    }
> +
>      error_setg(errp, "host device is uncompatible with stage-1 translation");
>      return false;
>  }
Eric


