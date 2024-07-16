Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4EBC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiMY-0001l0-Rj; Tue, 16 Jul 2024 09:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTiMM-00014I-Oh
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTiMJ-0005ni-Ev
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721137004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PQS67yb2p+iDG1xlm1ssI9cGEhRrPcmsYof73n10AA=;
 b=O3QT08dlnrS6oWPV9MqZr+X82APelo7BzQOkHX5IorGs7a7qiW8+OoBfYDpyHhoVJ0cAIY
 Wbn0ISE+b76LpnyWmOvsW6ZYh1TUmZbnSyjdlBe8vke6/lTXyWYR1REWujKXQW5ujm7m5c
 XqfBRYSk9beIWiUvXkKSL2nVTn0TUKw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-YB9dD_23PBq9_s9iGdcWPA-1; Tue, 16 Jul 2024 09:36:42 -0400
X-MC-Unique: YB9dD_23PBq9_s9iGdcWPA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ee8e0dab26so50207031fa.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721137001; x=1721741801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5PQS67yb2p+iDG1xlm1ssI9cGEhRrPcmsYof73n10AA=;
 b=vCkGS/orlZZ6VBBXz7y4Mma9gRTEQ1Qq/oimAyfnCD6Ep6j0+jOn3yhW6TxRj06Hbq
 aLYWyG9WyLWlLapuZi6XV8SqP3y+NSkMv6Q/my06YJ2HHrJC71+xs0gHlWcz2jLmLeZQ
 FWAG6UHdeyNpCKkB7J4po7clLUxEU2xGtbH1pTDq4dHPHiaTfbqbpaeC15QbmodaZFJb
 uC0+AEGaj3l4yfcwHeNFjdAyXg0kOoKY9gLkTAwYLH6bpKkdNn6GMNsIzyTqNin3iG5j
 nBGRsjnfw0l8dpOrLofMZX0ObB0gV8Fgr1iEOASbJQl4xEnMlf90OGDVy1HrAoGEH59G
 VLgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpILHKXF5Oo8tG8FI47mLhiy0RR1bDicWSrtjkIf15kzgjlEQu+MPFIYqv1gAj+6U2NnmucBdpAA3O1BvUs/5cSAt1CT4=
X-Gm-Message-State: AOJu0YzuEvpmOtEJAQyEgddcu2BaXBfZcHCOuyXRl/AWkkd2L8JFhAo+
 5ckyYMNG9utqGpCGD4FF5ZUPVMgxG1rRH7ctPJZpvL8oYSSHW/4fTSy9mukn+2qBbravr7c7b5l
 bfRzA4CBrW6TeI1CPGweU4xraN0IErxW1FV5ZfZ0sdYIbrWAVhP9Z
X-Received: by 2002:a2e:9d86:0:b0:2ee:5b1c:f0eb with SMTP id
 38308e7fff4ca-2eef415b6dcmr15350631fa.9.1721137001182; 
 Tue, 16 Jul 2024 06:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWM1lPqHr1oAtgrxawr1VjJ8+kP6M+2q8wTrX52s9wPjg8ZN5eYvo8V3FwwIPcSAxifXU2Gg==
X-Received: by 2002:a2e:9d86:0:b0:2ee:5b1c:f0eb with SMTP id
 38308e7fff4ca-2eef415b6dcmr15350461fa.9.1721137000828; 
 Tue, 16 Jul 2024 06:36:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbf29sm9140258f8f.70.2024.07.16.06.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:36:40 -0700 (PDT)
Message-ID: <0f910af8-923c-40a0-b3ce-7d4fa0a3dcbb@redhat.com>
Date: Tue, 16 Jul 2024 15:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] virtio-iommu: Add trace point on
 virtio_iommu_detach_endpoint_from_domain
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
References: <20240716094619.1713905-1-eric.auger@redhat.com>
 <20240716094619.1713905-7-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240716094619.1713905-7-eric.auger@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/16/24 11:45, Eric Auger wrote:
> Add a trace point on virtio_iommu_detach_endpoint_from_domain().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/virtio/virtio-iommu.c | 1 +
>   hw/virtio/trace-events   | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 440dfa6e92..59ef4fb217 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -308,6 +308,7 @@ static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
>       if (!ep->domain) {
>           return;
>       }
> +    trace_virtio_iommu_detach_endpoint_from_domain(domain->id, ep->id);
>       g_tree_foreach(domain->mappings, virtio_iommu_notify_unmap_cb,
>                      ep->iommu_mr);
>       QLIST_REMOVE(ep, next);
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index b7c04f0856..04e36ae047 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -116,6 +116,7 @@ virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t end, u
>   virtio_iommu_set_config(uint8_t bypass) "bypass=0x%x"
>   virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
>   virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
> +virtio_iommu_detach_endpoint_from_domain(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
>   virtio_iommu_map(uint32_t domain_id, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "domain=%d virt_start=0x%"PRIx64" virt_end=0x%"PRIx64 " phys_start=0x%"PRIx64" flags=%d"
>   virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_start, uint64_t virt_end) "domain=%d virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
>   virtio_iommu_unmap_done(uint32_t domain_id, uint64_t virt_start, uint64_t virt_end) "domain=%d virt_start=0x%"PRIx64" virt_end=0x%"PRIx64


