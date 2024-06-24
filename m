Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C6AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLr4X-0000lF-C2; Mon, 24 Jun 2024 17:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLr4W-0000kj-2D
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLr4U-0005We-F6
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719263873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZhqAksgscfA1U0w97JPmo3WQj4iKdtgPOt+pAzWfrc=;
 b=O4ikOwrvqhaPtrSZgoxVGbAhx2xUA0uPnBRDFrcZ23AxvlwSGp+UmbdkKqPMcAvXtjPiGH
 n8LOyYmICk6cdaAiHnVkwbFbB25PBq4wYBAZ3OaxoqYuOThC4QSRnPj2vE7JNisVRF5eVC
 8WFzF5WRSO1agnsQsznJxvBdMv1R6aE=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-wiZJ9jV6Ofal8vjiVrfrPw-1; Mon, 24 Jun 2024 17:17:52 -0400
X-MC-Unique: wiZJ9jV6Ofal8vjiVrfrPw-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-2500b8a716fso6176312fac.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 14:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263871; x=1719868671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VZhqAksgscfA1U0w97JPmo3WQj4iKdtgPOt+pAzWfrc=;
 b=knPy9YKA8InxJe+ugMasly/qxV0eeXhe3+RthocOkc8Rp7iC4mGJrldweOCjheU384
 dqmTVWwcTeeYju7hLiGRTy+YshZsaLFLeBueIEfsCWuplx+djvMJOTctlYnoD2lxfQEy
 x1Ujc0o3cJrv9H/9Vd/4mdZjq+pLp3XfRbtUzffl8++dv4ODzZr30rMIy6vKmkWwMnWG
 Hbc4HPDE/v7t5JcRYQ4fZtlBRTnl+4MEGWnPuvaUM9zrZlyTu9s4uTr20VDGuX5oUQB8
 YFjbgCqiNXp9MagXY5UqZqy01Mt4BTC08sHhZ8Mxlj/3z9Y+4K/tJ18xKs6UAVK3AwX7
 kEzg==
X-Gm-Message-State: AOJu0Yzj9fal/qDhKpUSVXtUOnTtqyHj324beD6io/wRyU4bkaEgxUlg
 apTDD3xuKYaqg2iaJBqj/df9eT7UvgwVWLBn5jfQ0XC8MOK/hFrUhWxlJzFMja1U+icNVPRGRCA
 3zDcQIQ5PWtThJIZOK4vcgTUwM/ZXNW9fcgxHaKZvVCWttGnZ559Lm32y8LuRs0H9m1nzYH4hfi
 IPJqKJ3jLcrTGFlTSq0CwKfpXBcshCCw==
X-Received: by 2002:a05:6871:8a7:b0:24f:d873:9f32 with SMTP id
 586e51a60fabf-25d06c51287mr6840631fac.26.1719263871288; 
 Mon, 24 Jun 2024 14:17:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdFt6p7ooWakyzQe9Bo2nXRkU7mO10iY0YNjFcpUK1F+lMGLcyYrZzVkEajEqeOSxVcoJdlQ==
X-Received: by 2002:a05:6871:8a7:b0:24f:d873:9f32 with SMTP id
 586e51a60fabf-25d06c51287mr6840607fac.26.1719263870839; 
 Mon, 24 Jun 2024 14:17:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79bce8b0d64sm348957885a.28.2024.06.24.14.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 14:17:50 -0700 (PDT)
Message-ID: <6fdd6e84-b2db-4279-8cae-93bf7fbe4124@redhat.com>
Date: Mon, 24 Jun 2024 23:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] vfio: QOMify VFIOContainer
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240617063409.34393-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

On 6/17/24 8:33 AM, Cédric Le Goater wrote:
> Hello,
> 
> The series starts with simple changes (patch 1-4). Two of which were
> initially sent by Joao in a series adding VFIO migration support with
> vIOMMU [1].
> 
> The changes following prepare VFIOContainer for QOMification, switch
> the container models to QOM when ready and add some final cleanups.
> 
> Applies on top of :
> 
>   * [v7] Add a host IOMMU device abstraction to check with vIOMMU
>     https://lore.kernel.org/all/20240605083043.317831-1-zhenzhong.duan@intel.com
>   * [v4] VIRTIO-IOMMU/VFIO: Fix host iommu geometry
>     https://lore.kernel.org/all/20240614095402.904691-1-eric.auger@redhat.com
> 
> Thanks,
> 
> C.
> 
> [1] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
> 
> 
> Changes in v2:
>   - Used OBJECT_DECLARE_SIMPLE_TYPE
>   - Introduced a instance_finalize() handler
> 
> Avihai Horon (1):
>    vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
> 
> Cédric Le Goater (15):
>    vfio: Make vfio_devices_dma_logging_start() return bool
>    vfio: Remove unused declarations from vfio-common.h
>    vfio/container: Introduce vfio_address_space_insert()
>    vfio/container: Simplify vfio_container_init()
>    vfio/container: Modify vfio_get_iommu_type() to use a container fd
>    vfio/container: Introduce vfio_get_iommu_class_name()
>    vfio/container: Introduce vfio_create_container()
>    vfio/container: Discover IOMMU type before creating the container
>    vfio/container: Change VFIOContainerBase to use QOM
>    vfio/container: Switch to QOM
>    vfio/container: Introduce an instance_init() handler
>    vfio/container: Remove VFIOContainerBase::ops
>    vfio/container: Remove vfio_container_init()
>    vfio/container: Introduce vfio_iommu_legacy_instance_init()
>    vfio/container: Move vfio_container_destroy() to an
>      instance_finalize() handler
> 
> Joao Martins (1):
>    vfio/common: Move dirty tracking ranges update to helper
> 
>   include/hw/vfio/vfio-common.h         |  10 ++-
>   include/hw/vfio/vfio-container-base.h |  19 +---
>   hw/vfio/common.c                      | 124 ++++++++++++++++----------
>   hw/vfio/container-base.c              |  70 +++++++++------
>   hw/vfio/container.c                   | 106 ++++++++++++----------
>   hw/vfio/iommufd.c                     |  13 ++-
>   hw/vfio/pci.c                         |   4 +-
>   hw/vfio/spapr.c                       |   3 +
>   8 files changed, 196 insertions(+), 153 deletions(-)
> 

Applied to vfio-next.

Thanks,

C.




