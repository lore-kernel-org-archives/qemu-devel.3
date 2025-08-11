Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D4BC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRZJ-0001rj-ML; Mon, 11 Aug 2025 08:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRZG-0001r1-G1
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRZ8-0006rV-UX
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754915028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EgAnCxOHEmFVO+Xq53AOrvQuoK5Fn8Mzsm1xshXkqPA=;
 b=UB94f3uBec5Dp+Ys+DD8s5mpy6W+Tr2WsgjvKAYlSxbK3ihYox64pqlIKMB1g7DC0LJDEd
 pAOoR9IJ9CgrVHmD9fziwcwlftk2JOO9y1u+ArVUVQyl+Cxw4TQvju2AciB1JeRHy9MXzE
 QTbjiEgz/NKXf1EJB1CbJBMXYrKno4E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377--Kks487bPEKsj5FvmzhVPw-1; Mon, 11 Aug 2025 08:23:47 -0400
X-MC-Unique: -Kks487bPEKsj5FvmzhVPw-1
X-Mimecast-MFC-AGG-ID: -Kks487bPEKsj5FvmzhVPw_1754915027
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-7074cb63bccso87376566d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754915027; x=1755519827;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EgAnCxOHEmFVO+Xq53AOrvQuoK5Fn8Mzsm1xshXkqPA=;
 b=rAcCQJBiOmAHBiOhjsSqYAf+BXsKVjmOWlRyDj8LBlryhWEvBus2pg2qzXz6SRZg3k
 lHEV8r2VgnhZlGZX1fWfvepaBGAeeyf5yhUl+I8GMaxvJeTrpBAUg+8ShsCqwRzgRYqm
 q+wgn8EtXAMb4w2mH1cTms2XEmixgkflupODgEDLUr6Ie8cdVOJX0oh3ybJuQzLFDk3l
 hUYlYZzONYQHImqJ14GgvJIisHaFZSIyrGeVgtazYQ1Yn2O7ZGGD5WdH2bq0G7sHWamZ
 BJEOoUFi6OmQbXQ6ICy7hMRg2KpmlFHcT+zH8I9HdSfDqFeUP81Xe7yM9ZplnZfaDLLD
 si3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcPGKrkywAHp/OHz7IebcmCrbW5k48XZd5+QMOCvCp2LkANVmT68GHySeCWgpxCsb7rW1uLA1VIDgM@nongnu.org
X-Gm-Message-State: AOJu0YyGd/wM3Zkcw21i4u6EAbwTQNjhT1mEieSeXkwnursRK0b0SmGB
 +EKyz7zM9eUANNoyFv0q5by4VQODGjbcLNaKIH4vqnqZ/pUaFtLqKHSQYuPn6AMLNX/ZWArQtzQ
 BLoviS6Ca6OIQRKkuzbeo4pIVkJb/K7FxiQopNXmgti4+3486Kt18XARQ
X-Gm-Gg: ASbGncvOVmpnPDVDGzsA1+UyiL+olwEsNK+l1z/WiPUw1dIs/VzZ+ksDejHuObD5MMu
 2iVFayIEotE67wf8TtKLKQQtVg1xk7Jm3nF9vS6rZ7bHIglmBIPQva/HjPnz01WPkxfTVZIENMr
 Jy3R6reRY0NGfDCNZEcFsOEXvPSTZUUtDTeyGhnNMGNiJHfdU4nLW9SoChyrqK2fE8fUMPmYYqf
 3Nm1eqBZHooeB7aNPPP/U6MHuth8a6AbSZlSJu4AuL1nMZUStU4ui6ouIgOT4eDm30IeminKNgj
 rbgZ+5IyOxohIHee1pMUsaklF5xhXmZc9bEms0KeAW/Q/kym8PwPImHGKVk3FAwqwa5+usC5Hko
 64Q==
X-Received: by 2002:a05:6214:c23:b0:707:39f7:c607 with SMTP id
 6a1803df08f44-7099a199157mr186129276d6.7.1754915026759; 
 Mon, 11 Aug 2025 05:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbERKcHXnIcJF9rrzGrejaAhZholx+f6gZxdO7QToqtTjJHN41gzTtOg3Zcgjhiv9Qmu+gwg==
X-Received: by 2002:a05:6214:c23:b0:707:39f7:c607 with SMTP id
 6a1803df08f44-7099a199157mr186128516d6.7.1754915025852; 
 Mon, 11 Aug 2025 05:23:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077cdf4831sm153759036d6.75.2025.08.11.05.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 05:23:45 -0700 (PDT)
Message-ID: <9431a6c6-71fe-49bf-9ab5-08d6053d59a4@redhat.com>
Date: Mon, 11 Aug 2025 14:23:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] vfio/container.c: use QOM casts where appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-10-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-10-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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
> Use QOM casts to convert between VFIOUserContainer and VFIOContainerBase instead
> of accessing bcontainer directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio-user/container.c | 26 +++++++++++---------------
>   1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> index d318e6a339..025db93ff3 100644
> --- a/hw/vfio-user/container.c
> +++ b/hw/vfio-user/container.c
> @@ -24,16 +24,14 @@
>    */
>   static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
>   {
> -    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
> -                                                 bcontainer);
> +    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
>   
>       container->proxy->async_ops = true;
>   }
>   
>   static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
>   {
> -    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
> -                                            bcontainer);
> +    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
>   
>       /* wait here for any async requests sent during the transaction */
>       container->proxy->async_ops = false;
> @@ -44,8 +42,8 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
>                                  hwaddr iova, ram_addr_t size,
>                                  IOMMUTLBEntry *iotlb, bool unmap_all)
>   {
> -    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
> -                                            bcontainer);
> +    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
> +
>       Error *local_err = NULL;
>       int ret = 0;
>   
> @@ -88,8 +86,8 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                ram_addr_t size, void *vaddr, bool readonly,
>                                MemoryRegion *mrp)
>   {
> -    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
> -                                                bcontainer);
> +    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
> +
>       int fd = memory_region_get_fd(mrp);
>       Error *local_err = NULL;
>       int ret;
> @@ -177,8 +175,7 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>   
>   static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
>   {
> -    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
> -                                                bcontainer);
> +    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
>   
>       assert(container->proxy->dma_pgsizes != 0);
>       bcontainer->pgsizes = container->proxy->dma_pgsizes;
> @@ -222,7 +219,7 @@ vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
>           goto put_space_exit;
>       }
>   
> -    bcontainer = &container->bcontainer;
> +    bcontainer = VFIO_IOMMU(container);
>   
>       ret = ram_block_uncoordinated_discard_disable(true);
>       if (ret) {
> @@ -267,7 +264,7 @@ put_space_exit:
>   
>   static void vfio_user_container_disconnect(VFIOUserContainer *container)
>   {
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>       VFIOAddressSpace *space = bcontainer->space;
>   
> @@ -295,7 +292,7 @@ static bool vfio_user_device_get(VFIOUserContainer *container,
>   
>       vbasedev->fd = -1;
>   
> -    vfio_device_prepare(vbasedev, &container->bcontainer, &info);
> +    vfio_device_prepare(vbasedev, VFIO_IOMMU(container), &info);
>   
>       return true;
>   }
> @@ -319,8 +316,7 @@ static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
>   
>   static void vfio_user_device_detach(VFIODevice *vbasedev)
>   {
> -    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
> -                                                VFIOUserContainer, bcontainer);
> +    VFIOUserContainer *container = VFIO_IOMMU_USER(vbasedev->bcontainer);
>   
>       vfio_device_unprepare(vbasedev);
>   


