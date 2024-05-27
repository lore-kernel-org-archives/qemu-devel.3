Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B189AC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 13:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBaFP-0000jV-OQ; Mon, 27 May 2024 09:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sBaFO-0000jC-KM
 for qemu-devel@nongnu.org; Mon, 27 May 2024 09:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sBaFN-0004hz-1c
 for qemu-devel@nongnu.org; Mon, 27 May 2024 09:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716815920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zU5UGfgbVFmNKgkjtfwwENgHppb1FOpNYw6AmcN6pDM=;
 b=IoQmAAuRBNk5mQRdv1Vq7jIFro0XFL1Wvvu0aenYZkgyWw+cicHWyzOXtpNsBjv5FLzj4y
 MefQLcwQphMeyowCdnYhnnnobFoTVzoMIbWE8uk/IzZRmWkspjlS8RV1Nnr//vFvWqPXpI
 1V8djXNdDg4kyQkbkbPvX0d3ggO9IwI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-0Bx1Kf4SNJ-4O69rcGe3ww-1; Mon, 27 May 2024 09:18:38 -0400
X-MC-Unique: 0Bx1Kf4SNJ-4O69rcGe3ww-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ab9903ed67so44934986d6.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 06:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716815918; x=1717420718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zU5UGfgbVFmNKgkjtfwwENgHppb1FOpNYw6AmcN6pDM=;
 b=vn+EHyOJOcGjlshVDXOj710TiqdcRuxM/12CmRLHBwt8uWQitQJ9L+9eXuPCpLZToZ
 5WSAym7wS13JxnBNRrH8aTEVlgGn6AkzirQ4oWYccguNrEwMJU715Iqp47Mm3uH4zP+7
 sWifX5ImZ8+BlvFNNE3SuPYK44BeSWZ01YdWgkxvx0+Bf0t1hUfXO8rZ813RxX2n/xtd
 yfEc7TbGuPDY+0hyO+NsWtjDu3JJkGVTKxMZYjkMSnzDSt5QqtdfNUIm53t9dvt4Tsl3
 hQO1KLCvnZxidTVtOYb0uubiu3/XU2e6w7YykQDoe56JN5i7CypSEeOYb4kmyUVPZdl0
 yorA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR02YT8h/5uQ5xUTC+oqg+53Ya0NzM9ix8/MqPM43uwXkk+SWch+QC7UeYQqEYksrlpH94xdLuLiRXS/XgP4sYthNQFBQ=
X-Gm-Message-State: AOJu0YzC41yctI4Me6byYpZwZ+ngFo9/vn+tlFkohTrUEfgrERR13gm8
 JrtNl68ERJddYknV+DBPLgvQ/YkUcZgqv/yf9clxF0H2Q0oj9SmUZPldQ4c5G80HNhor3WcqvMJ
 tbMaAE9KcVaNQcdkkAdCdGRAaF3rihwPqzOsIrpGVg+AjsAoiFRwR
X-Received: by 2002:a05:6214:3907:b0:6ab:8cbb:79f4 with SMTP id
 6a1803df08f44-6abcd13ba31mr102936566d6.56.1716815918154; 
 Mon, 27 May 2024 06:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk4oi3RblGLeSDc+Tgm0Lb6NXXLvMVXuRpLnEx4uTruo/NGdkDA0nSCXt/9I9ODhCsmAgQgA==
X-Received: by 2002:a05:6214:3907:b0:6ab:8cbb:79f4 with SMTP id
 6a1803df08f44-6abcd13ba31mr102936246d6.56.1716815917708; 
 Mon, 27 May 2024 06:18:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:151b:2482:8f7e:1f56?
 ([2a01:e0a:280:24f0:151b:2482:8f7e:1f56])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad77430c57sm16875036d6.38.2024.05.27.06.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 06:18:37 -0700 (PDT)
Message-ID: <ba1476d7-624a-41bf-bd73-8463c7460239@redhat.com>
Date: Mon, 27 May 2024 15:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/19] intel_iommu: Check compatibility with host IOMMU
 capabilities
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
 <20240508090354.1815561-20-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240508090354.1815561-20-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/8/24 11:03, Zhenzhong Duan wrote:
> If check fails, host device (either VFIO or VDPA device) is not
> compatible with current vIOMMU config and should not be passed to
> guest.
> 
> Only aw_bits is checked for now, we don't care other capabilities
> before scalable modern mode is introduced.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 747c988bc4..07bfd4f99e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -20,6 +20,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_HOST_IOMMU_DEVICE */
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
>   #include "qapi/error.h"
> @@ -3819,6 +3820,26 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>       return vtd_dev_as;
>   }
>   
> +static bool vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
> +                           Error **errp)
> +{
> +#ifdef CONFIG_HOST_IOMMU_DEVICE
> +    HostIOMMUDevice *hiod = vtd_hdev->dev;
> +    int ret;
> +
> +    /* Common checks */
> +    ret = host_iommu_device_get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, errp);

To avoid CONFIG_HOST_IOMMU_DEVICE, host_iommu_device_get_cap() could be
open coded.

> +    if (ret < 0) {
> +        return false;
> +    }
> +    if (s->aw_bits > ret) {
> +        error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
> +        return false;
> +    }
> +#endif
> +    return true;
> +}
> +
>   static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                        HostIOMMUDevice *hiod, Error **errp)
>   {
> @@ -3848,6 +3869,12 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>       vtd_hdev->iommu_state = s;
>       vtd_hdev->dev = hiod;
>   
> +    if (!vtd_check_hdev(s, vtd_hdev, errp)) {
> +        g_free(vtd_hdev);
> +        vtd_iommu_unlock(s);
> +        return false;
> +    }

This check could be first done before allocating vtd_hdev.


Thanks,

C.



>       new_key = g_malloc(sizeof(*new_key));
>       new_key->bus = bus;
>       new_key->devfn = devfn;


