Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89934C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9vL-00041t-S1; Tue, 23 Jul 2024 03:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sW9vC-0003W6-Uz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sW9vA-0005Ub-8g
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721719611;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Eo3ItrBv+ffp+TKl1ktwtJEC4nL6HVB0tJuhOGoTAA=;
 b=IFV0nqvdrZoq9JAnD/k7n7HS63Y6s4kPvIefFhFdQJ/vhGiwRf7JGDd/8+/0vHWcqHuq7M
 u2QQY867rDLpPiPAhCJZnTV2UCtNRlOr+BwCEFOM9EeznjDZoXA4HlkuCx36zQIQ6ae2Xc
 LmQAPQS/0ts7myVTwTUa1efJHvWjxgw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-WXAMZrs1OlSDph1yCNPVNA-1; Tue, 23 Jul 2024 03:26:45 -0400
X-MC-Unique: WXAMZrs1OlSDph1yCNPVNA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42725d3ae3eso38149855e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 00:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721719604; x=1722324404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Eo3ItrBv+ffp+TKl1ktwtJEC4nL6HVB0tJuhOGoTAA=;
 b=s4SbJxZ8uwSH0eov9zq5wuRF9w30zAifO/tF14ueuO8NjNYPG2d00oDEUB2JySYZ01
 kvJd0Dgs9U+QmX/A91raAe6p5yjY13AsXY7qbA0lHuaGPM8X6hOfodYM3YuoWGFqsffd
 WEm2Kx9KBPHYs1Ck4ODfAsaKGS18p3vrs60TKub+iU7fHr4PDMrKaXb3ld3dVYkPm+FA
 IN7cFIVKmnfLM680oJY4ikkFXr7+sUH7r9Xx5W5UoBFqTmFa0GbVXPemjZcBxflqHxPI
 pufk4fs7xSRTajoqMoJVhDXjzfoYQdjOA/t9Aomo/z5U1PBbHFJder+lftLFBn19bvfO
 g0yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxJMm6tJcYQPdeoGR9MrCNbLtCMZRoSlsRy9hKhfAOqPb6rVv2/zqkFpKBQyOyf6w5gMP6aZN1ZFNG7BBM2yHVP0C3ZmE=
X-Gm-Message-State: AOJu0YzqUeGJxXjeRLMuti7GRBn5/mNpfMAvW0kyGC7iBYUOGcPK8PHJ
 jBy1WEiQ65p9SXd3IPJLKFbpqS7QKGz9lxhl1Tp0j0ynSijfp3gKyOoSEAAyuDmRPwYiily3e0Z
 oFxrc7jpapkinFmkKzaQ2XdIUnru6n0Fr5TD17hWXS5YuZ5y8k1cT
X-Received: by 2002:a05:600c:4747:b0:427:d8f2:479 with SMTP id
 5b1f17b1804b1-427df7aabf9mr45770525e9.14.1721719604051; 
 Tue, 23 Jul 2024 00:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHEZ+xEZOBJre3AJi8DgvYu7P4HfRfcjFKvEj06484CzdfB73ms6CkA6QqnEkILOFvv5kdtg==
X-Received: by 2002:a05:600c:4747:b0:427:d8f2:479 with SMTP id
 5b1f17b1804b1-427df7aabf9mr45770445e9.14.1721719603625; 
 Tue, 23 Jul 2024 00:26:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6936e1esm159077745e9.44.2024.07.23.00.26.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 00:26:43 -0700 (PDT)
Message-ID: <b85a445b-44e9-44f3-bed9-316ef318f67d@redhat.com>
Date: Tue, 23 Jul 2024 09:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] vfio/iommufd: Add hw_caps field to
 HostIOMMUDeviceCaps
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-4-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240722211326.70162-4-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 7/22/24 23:13, Joao Martins wrote:
> Store the value of @caps returned by iommufd_backend_get_device_info()
> in a new field HostIOMMUDeviceCaps::hw_caps. Right now the only value is
> whether device IOMMU supports dirty tracking (IOMMU_HW_CAP_DIRTY_TRACKING).
>
> This is in preparation for HostIOMMUDevice::realize() being called early
> during attach_device().
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/sysemu/host_iommu_device.h | 4 ++++
>  hw/vfio/iommufd.c                  | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index d1c10ff7c239..809cced4ba5c 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -19,9 +19,13 @@
>   * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
>   *
>   * @type: host platform IOMMU type.
> + *
> + * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
> + *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
>   */
>  typedef struct HostIOMMUDeviceCaps {
>      uint32_t type;
> +    uint64_t hw_caps;
>  } HostIOMMUDeviceCaps;
>  
>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 5bb623879abe..5e2fc1ce089d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -724,6 +724,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>  
>      hiod->name = g_strdup(vdev->name);
>      caps->type = type;
> +    caps->hw_caps = hw_caps;
>  
>      return true;
>  }


