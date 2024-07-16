Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB915C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThso-0008Se-8K; Tue, 16 Jul 2024 09:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sThsm-0008Lw-7i
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sThsj-0008Pe-Cr
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721135172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=maWtgPkxeR1w3aAEhYdFJHtq3Lxdss5BtOE4/8g2HWo=;
 b=MYMfXoozHuYePadJ1qMCI2bBTwpLkF2u8iJfso0YTgF2cUK2hvBVdk4RLj0aeC2FsKXLlY
 bhf3di9Y4V5FW9fmwnFaN9P37myMYhih3f/FlJfqCddrx56Z9DtgLoYb8PHnbFI/iQNVNy
 r8yObvHQXH6jDBzuOsM2r2QoMPaVncE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-XSS24S_TMEyhVaJo1xOP8Q-1; Tue, 16 Jul 2024 09:06:11 -0400
X-MC-Unique: XSS24S_TMEyhVaJo1xOP8Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426624f4ce3so35546695e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721135170; x=1721739970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=maWtgPkxeR1w3aAEhYdFJHtq3Lxdss5BtOE4/8g2HWo=;
 b=ILN2lZj5aUWPW+Sb1P1GVorp/45ICZZLoQfYuZS6XL3ynkrq+//tbTN+cPxN6qWHY5
 xiw6qN1L/CIGmzKxQvRxFu1MOqp7LQ03jE7zKYzi2FF++nJumuByzDiAkay1G2jQzoKH
 I1Lj6jZJjLuQZoeutJ8fP97xfjssmnQ46IlQfnWXL+i0h6WFMz7m8WCMh5ZCPoERiq5c
 vr6h29S5fsolMTwogW96IM4lqh3UgOZ+x4kCEE9Omggu5OfC7B/8L49csCMZJQy93o8j
 Y7LmE3qntFgGNLfmLRjsyZfKV9tgejax7TnlHZBTMtoP0tH+vJH1SJ9xn3p+bB8+dR8C
 HMrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzjiumGFADPsxE3uRd9sFsULpul/gzCe1DfPGuy/VPKGeJrKJ2wOqmlC8XShBbdE1LjhmJFDBm0aXcWaRPH1DNPh5ITeU=
X-Gm-Message-State: AOJu0YxXTKgeRIdmRZaBlli/rk8xSuTaRBQrT/NNTB2wRnznYMyBP5gT
 4laf6dNNysCUnn7owA1RhW8NHQmNh8bIrrd0iNtQW62RJJGOolLQAXOjelQ6WGCSInQIy7iXf9n
 ZO2FXVJrirr1Kz2SbvW72by2clQMak04t0Uylntrzk8Rhu/ROR6ZD
X-Received: by 2002:a05:600c:4f41:b0:426:5de3:2ae5 with SMTP id
 5b1f17b1804b1-427ba67f609mr13822735e9.10.1721135169860; 
 Tue, 16 Jul 2024 06:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp9/OjHdfduIr5SMQVjsDPGd4UATXyqtQ288eAT0qo8wDCS773NgqvWpn3nCRFCVi+JSjcvw==
X-Received: by 2002:a05:600c:4f41:b0:426:5de3:2ae5 with SMTP id
 5b1f17b1804b1-427ba67f609mr13822595e9.10.1721135169550; 
 Tue, 16 Jul 2024 06:06:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27846bsm160945185e9.25.2024.07.16.06.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:06:09 -0700 (PDT)
Message-ID: <ee956f5d-676c-404e-a07c-8bc3330cdbcd@redhat.com>
Date: Tue, 16 Jul 2024 15:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] virtio-iommu: Remove probe_done
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
References: <20240716094619.1713905-1-eric.auger@redhat.com>
 <20240716094619.1713905-3-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240716094619.1713905-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 7/16/24 11:45, Eric Auger wrote:
> Now we have switched to PCIIOMMUOps to convey host IOMMU information,
> the host reserved regions are transmitted when the PCIe topology is
> built. This happens way before the virtio-iommu driver calls the probe
> request. So let's remove the probe_done flag that allowed to check
> the probe was not done before the IOMMU MR got enabled. Besides this
> probe_done flag had a flaw wrt migration since it was not saved/restored.
> 
> The only case at risk is if 2 devices were plugged to a
> PCIe to PCI bridge and thus aliased. First of all we
> discovered in the past this case was not properly supported for
> neither SMMU nor virtio-iommu on guest kernel side: see
> 
> [RFC] virtio-iommu: Take into account possible aliasing in virtio_iommu_mr()
> https://lore.kernel.org/all/20230116124709.793084-1-eric.auger@redhat.com/
> 
> If this were supported by the guest kernel, it is unclear what the call
> sequence would be from a virtio-iommu driver point of view.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/virtio/virtio-iommu.h | 1 -
>   hw/virtio/virtio-iommu.c         | 3 ---
>   2 files changed, 4 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index bdb3da72d0..7db4210b16 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -43,7 +43,6 @@ typedef struct IOMMUDevice {
>       MemoryRegion bypass_mr;     /* The alias of shared memory MR */
>       GList *resv_regions;
>       GList *host_resv_ranges;
> -    bool probe_done;
>   } IOMMUDevice;
>   
>   typedef struct IOMMUPciBus {
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 4e34dacd6e..2c54c0d976 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -555,8 +555,6 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
>   
>       current_ranges = sdev->host_resv_ranges;
>   
> -    g_assert(!sdev->probe_done);
> -
>       /* check that each new resv region is included in an existing one */
>       if (sdev->host_resv_ranges) {
>           range_inverse_array(iova_ranges,
> @@ -956,7 +954,6 @@ static int virtio_iommu_probe(VirtIOIOMMU *s,
>       }
>       buf += count;
>       free -= count;
> -    sdev->probe_done = true;
>   
>       return VIRTIO_IOMMU_S_OK;
>   }


