Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA112C87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRVu-0007n6-7Q; Mon, 11 Aug 2025 08:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRVs-0007jR-AG
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRVn-0006Ex-Uj
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754914822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OABkDX/B/nJ4F8u+LUAvZtrLRd/t0gPeOfA5m6it2cs=;
 b=Wm9yJpquvKHS+smO1hUXRcJUj1iQSe/WUloxUdzYMRrwBlURQbH+y+mlXRNCw6kAgtv6y7
 tna8Fy56M55wbR8Yfk8qlbC+/dpLCYaiYGzSFzs251naOqDPbC80WeDuOjtyLN1rTU1JVL
 BWj+bHM3LZg+dSWdKD/QQyFYo5xn7HY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-EqF4wZbYO7W0BP-6tas6Uw-1; Mon, 11 Aug 2025 08:20:20 -0400
X-MC-Unique: EqF4wZbYO7W0BP-6tas6Uw-1
X-Mimecast-MFC-AGG-ID: EqF4wZbYO7W0BP-6tas6Uw_1754914820
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e69c14e992so846927785a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754914820; x=1755519620;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OABkDX/B/nJ4F8u+LUAvZtrLRd/t0gPeOfA5m6it2cs=;
 b=Pc83D5j0/8PLp6hSK6w8KAVkm4JaKawT5qwfuWeiXy80sAlV/x+Ai5N9RSNHEgObTY
 sJrpDNnTnyTJ+9eYwrLnAq/jUzNI9adJlawUztjQQPHJGSpMDRk/IJOEjB2me2tyUWYv
 7bW1EOzG0tLH2nzyFPIrEfBBFJo/dNc7SRziol6ic2ADLXkEDizvn4PNZAAc9rJ9q81Y
 b/UT3k7JgRd9cbAq5ErIRZKA+EbmkiMotY8VKCm4fKXA/uz10Cxu10w7thpq5Ideh54G
 b370ckdZt4VB8zbbdiwJOMLxix0+lJwbZtjfOkalChqnG7Nx9TQrEAeZwSmZgcwnnRuI
 MH8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2gRzfnFbIaqhnKqh+lbmqZJTleZQBVVS9LnuAxbTK5tKZ8ipqPq2IzQdhQmRUFY51fiImWpCPQSmJ@nongnu.org
X-Gm-Message-State: AOJu0YzmUMueHiTjGHlNeRCvjGvLMzrDBO5r616HZDvLzEOepuWxhUZB
 t+J5RqhUS6UoMRSWahH6VKBAtHEmItQkV/Peh7xe94gZoCntGACS7ZHi723VehGRAxvfdYZnxoC
 2BEWIRmns4ZW+6xp9lu3LwSk2OpSwo8Z1iMkjtJkKMxDIEB19pFGxFreT
X-Gm-Gg: ASbGncs/cwSPRV3cq049lHOQNFtXe+bOr7IFDGbIQqYbLWlMClaYTp/V4n2VEF+YBhs
 vPfjQrajwWLN08x7510grZP+tsRu0+sGX3QK5MQmYTI/uajMvG942yftIzKgZmUo2COhhdrbx57
 oXeqjzBSGLYTGY/lUW+mk0Nx2JzKn2wn+t+urR0ZPDWfyiU5htItqMepPQ8PPX6yPx6hzyMSJ7Z
 2WnGRo8bIpkkw4fKq5KrhSAGb/UzxcTzgPOqxoJHz4N3SIyCnRIJuTD4VnUnSRjrvsRACwNrlvA
 irAJ9kgoy7lpCIR0Mbb+puEkZ4ZMOEf6rpIDGcbHBCdcdIJvFcU12JfATico0EcPn1yzYLtBoii
 oEQ==
X-Received: by 2002:a05:6214:19c6:b0:707:2472:dc3b with SMTP id
 6a1803df08f44-7099a351fc5mr185697626d6.42.1754914820253; 
 Mon, 11 Aug 2025 05:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMziybW0yYKN9+bPtmdxs+xNdVn2+ufpPX4cHPr1V2OyVUji5Gcu06woUszk+2lp3xm94KKQ==
X-Received: by 2002:a05:6214:19c6:b0:707:2472:dc3b with SMTP id
 6a1803df08f44-7099a351fc5mr185696926d6.42.1754914819636; 
 Mon, 11 Aug 2025 05:20:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-709a0d74acfsm45992896d6.58.2025.08.11.05.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 05:20:19 -0700 (PDT)
Message-ID: <67cf5108-c2f7-49bd-a81e-266c7c93631e@redhat.com>
Date: Mon, 11 Aug 2025 14:20:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] vfio/spapr.c: use QOM casts where appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-7-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-7-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/15/25 11:25, Mark Cave-Ayland wrote:
> Use QOM casts to convert between VFIOContainer and VFIOContainerBase instead
> of accessing bcontainer directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/spapr.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 564b70ef97..c41e4588d6 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -62,7 +62,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
>       VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
>                                                     prereg_listener);
>       VFIOContainer *container = &scontainer->container;
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>       const hwaddr gpa = section->offset_within_address_space;
>       hwaddr end;
>       int ret;
> @@ -244,7 +244,7 @@ static bool vfio_spapr_create_window(VFIOContainer *container,
>                                       hwaddr *pgsize, Error **errp)
>   {
>       int ret = 0;
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>       VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
>                                                     container);
>       IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> @@ -352,8 +352,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>                                           MemoryRegionSection *section,
>                                           Error **errp)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
>                                                     container);
>       VFIOHostDMAWindow *hostwin;
> @@ -443,8 +442,7 @@ static void
>   vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
>                                           MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
>                                                     container);
>   
> @@ -465,8 +463,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
>   
>   static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
>                                                     container);
>       VFIOHostDMAWindow *hostwin, *next;
> @@ -484,8 +481,7 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
>   static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
>                                          Error **errp)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
>                                                     container);
>       struct vfio_iommu_spapr_tce_info info;


