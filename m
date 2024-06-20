Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE83C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHVc-0006Nt-Pw; Thu, 20 Jun 2024 09:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sKHVb-0006NL-7V
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sKHVZ-0007At-C5
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718888839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1ikVN6OTq3lBBgDbZD19s+d07/tvnfOkmUdi8S583g=;
 b=RKZZ1zmIGZGJ7nvfKOtmoU29Ud0uUcL8PGhuTsh8ZrO9Yx2ZX1RnfxHb+BbevWP6J1y6NL
 t5sowdOnSn79uz77BWrPf3fz8adn4d/qEKxhE1yW3RxRE6eJQAfNClvszi4Z0IeK4t9SMQ
 P/eQ1SV7q09Jr04Ycg/bCDs8wbs1Lg4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-9sZeVjlRP3ykoOtCWwxOuA-1; Thu, 20 Jun 2024 09:07:17 -0400
X-MC-Unique: 9sZeVjlRP3ykoOtCWwxOuA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b22e2dfa6cso11486686d6.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718888837; x=1719493637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l1ikVN6OTq3lBBgDbZD19s+d07/tvnfOkmUdi8S583g=;
 b=XpWGMFK9rPxaTvtiaycnA250e0Ubxt1Pc3GqCIjXNd5R1UczZT6t0QN82/FsAcaaQy
 F2W2YkbE83NkXcEjUGLmw0hwA/0R1bkCfzOENkuJHRwc7ghcv826xNY5BGDOx7R7x6hv
 lVUE4vHpPoj3XQymKUDDyTKrN47nXhpMGtLOmaLu0Xfb7weUmbzriTTxhxgP64b93xuP
 gxAjL3IcTntDAwiYNIrwei+Ws4weLPD33Fudh42gQe8fiRJHlgHH8zec46Njon+8UGDN
 hUmlstRIp7VxyAHcZjfrcsbMhCPzhI9A1WQVc5OyawsFYMd30nh10ONUcSVG3VEYJF5y
 XJ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJTs/CCiE+aslRNutYD9Wr5EVNp3z3RjOBXbsVsPlyJbpdAONIkdY05YFpPzUf0w+vaFIPiwQ6XvrdZeuyE7QXAUMs98g=
X-Gm-Message-State: AOJu0Yw1g34pEHE3GUjrI89hFdI/aXDuzJJCKjAWzAhrrYAYYfQA0ZYt
 eMGVImr3rg67E96F5L++vqAWjX0ib84tdiSgbyZS1+SaViRL9ig0PbGEeIG4VMHVZYjKeqMwUz1
 lAawNUWdKuseMSPscrLUaZlZRLDaPOXFu4ZeJLvMsj/flbvHHTGuT
X-Received: by 2002:a0c:f9c4:0:b0:6b2:b3cd:c329 with SMTP id
 6a1803df08f44-6b501ea9b39mr61214406d6.46.1718888837145; 
 Thu, 20 Jun 2024 06:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXk/+lm2Ya6ZhigAUu8KBz3Rqlk+4bRsLPSYWzOP1+EyK7RH83GUdZ2WPSgk6sQ0ZD0CIJmQ==
X-Received: by 2002:a0c:f9c4:0:b0:6b2:b3cd:c329 with SMTP id
 6a1803df08f44-6b501ea9b39mr61214176d6.46.1718888836843; 
 Thu, 20 Jun 2024 06:07:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5ee04fdsm87800046d6.117.2024.06.20.06.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 06:07:16 -0700 (PDT)
Message-ID: <11578ca8-2bb3-4504-b7b9-022c1df65942@redhat.com>
Date: Thu, 20 Jun 2024 15:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, harshpb@linux.ibm.com,
 npiggin@gmail.com
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org, zhenzhong.duan@intel.com,
 qemu-devel@nongnu.org
References: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Shivaprasad,

On 5/9/24 9:14 PM, Shivaprasad G Bhat wrote:
> The commit 6ad359ec29 "(vfio/spapr: Move prereg_listener into
> spapr container)" began to use the newly introduced VFIOSpaprContainer
> structure.
> 
> After several refactors, today the container_of(container,
> VFIOSpaprContainer, ABC) is used when VFIOSpaprContainer is actually
> not allocated. On PPC64 systems, this dereference is leading to corruption
> showing up as glibc malloc assertion during guest start when using vfio.
> 
> Patch adds the missing allocation while also making the structure movement
> to vfio common header file.
> 
> Fixes: 6ad359ec29 "(vfio/spapr: Move prereg_listener into spapr container)"
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Could you please give vfio-9.1 a try ? Thanks,

C.

https://github.com/legoater/qemu/commits/vfio-9.1

> ---
>   hw/vfio/container.c           |    6 ++++--
>   hw/vfio/spapr.c               |    6 ------
>   include/hw/vfio/vfio-common.h |    6 ++++++
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 77bdec276e..ecaf5786d9 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -539,6 +539,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>   {
>       VFIOContainer *container;
>       VFIOContainerBase *bcontainer;
> +    VFIOSpaprContainer *scontainer;
>       int ret, fd;
>       VFIOAddressSpace *space;
> 
> @@ -611,7 +612,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           goto close_fd_exit;
>       }
> 
> -    container = g_malloc0(sizeof(*container));
> +    scontainer = g_malloc0(sizeof(*scontainer));
> +    container = &scontainer->container;
>       container->fd = fd;
>       bcontainer = &container->bcontainer;
> 
> @@ -675,7 +677,7 @@ unregister_container_exit:
>       vfio_cpr_unregister_container(bcontainer);
> 
>   free_container_exit:
> -    g_free(container);
> +    g_free(scontainer);
> 
>   close_fd_exit:
>       close(fd);
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 0d949bb728..78d218b7e7 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -24,12 +24,6 @@
>   #include "qapi/error.h"
>   #include "trace.h"
> 
> -typedef struct VFIOSpaprContainer {
> -    VFIOContainer container;
> -    MemoryListener prereg_listener;
> -    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
> -} VFIOSpaprContainer;
> -
>   static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
>   {
>       if (memory_region_is_iommu(section->mr)) {
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef..010fa68ac6 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -82,6 +82,12 @@ typedef struct VFIOContainer {
>       QLIST_HEAD(, VFIOGroup) group_list;
>   } VFIOContainer;
> 
> +typedef struct VFIOSpaprContainer {
> +    VFIOContainer container;
> +    MemoryListener prereg_listener;
> +    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
> +} VFIOSpaprContainer;
> +
>   typedef struct VFIOHostDMAWindow {
>       hwaddr min_iova;
>       hwaddr max_iova;
> 
> 
> 


