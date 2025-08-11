Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A62C87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRVW-0007cE-Vd; Mon, 11 Aug 2025 08:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRVU-0007bU-Eb
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRVQ-0005zC-Tu
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754914797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N2iF3K9vbqI2DeY2rjL9F3Icnajd/CBvYoImHTEZ07M=;
 b=MWIYb2WUb5/w8AahmXPfOqa0NiZwc4doH7YzGfgTTGLFcePNLd0kGYvOPXcWQucLPUNUYp
 9JdT7nAzeC0wKZRWq60vyfuogTmp+QLRZC9uM6CJo8VRiRDba56C+Wh5SEgAVhLPnwu2Jg
 JeK5iR87ucITb2fpbezifxHr5MtqKLs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-VQMkpW-bPcGdYGehfDjINw-1; Mon, 11 Aug 2025 08:19:56 -0400
X-MC-Unique: VQMkpW-bPcGdYGehfDjINw-1
X-Mimecast-MFC-AGG-ID: VQMkpW-bPcGdYGehfDjINw_1754914796
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4af1a20cbcfso113769101cf.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754914796; x=1755519596;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2iF3K9vbqI2DeY2rjL9F3Icnajd/CBvYoImHTEZ07M=;
 b=xBXYo67sSdTd3GbtlEMkMVEX4HEJzp/tPdr8ee8CBkEnFXVPUAtWsTOaO5tFpk93kZ
 B0eSykAmNYBpgJ2f5Ne8I53RxLDiE30AuXsH+uckBgWiVtfY2mZ+qpsS0cHc9+woy9g+
 bLFJMb9iQI86e9N+zJNXcN2HO2yH7U42hnXBEyX8iWohi5ByjSqXQXpwjN4Q0eviWm5l
 otE7+t3otf7WyxT4bhRD2RbbSNKVzEZcTSViUWbKzHDK0y78diB86VuZOTHuuhJ3N00/
 vCPLk0gJxH5T7uI5f+opf10xYNa+HlPNIpxRcaIIzZeeihgJO4tvjyhkbOH+wlovprYc
 BuUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQQNhHrszI1atFFCBuaY1Zu2UJDS9WgtkAU+d4wWTzPcQ04/TY+h50OnZhWO9694S6Ncld2Igc6nmR@nongnu.org
X-Gm-Message-State: AOJu0YxQDZs/QMJHCZ1UyPOaNU/BdpaGNvtO154GgQyMUw9AMP8KhDoK
 y45LJ5ZHSvxH29dwPwGJFT2wyXmerQsUpQIMmj3n2Ey8C3tpcPFKQ5nuoQJ3936sbJewrF8bd8h
 Mb9ivC2BM71AsZcU5XaOjTnAhMd/eUEGW1bk2ycbVre9wCX8VBN8SfK6+
X-Gm-Gg: ASbGncv2TP5SlHo/zba1roLykaFjnv30Vzgmajjfl1VWB3carux3QxZOpBGWc1CxHzc
 i2aIMs/Ncwwyb34KTe29dQ3+aAvqPYj54o5K2zZ/hO/Tmai/FGMdBneBHkDTbi6ZsQrGh/tR9nM
 hWO2SP3Mpumi/xHeIuwaXjmjJHzTkGzJoP4shWl1P7Zat8KgMtixBoPj40fqd8Q6NpqDT4nbkd+
 9ZSUnztRmnwG5VwDG8cEa+oG87Eo7iujhOcaWXw7geIk/nLTn+05ETyMXJQTlUrmy0ZyTwZDkOd
 M25yx1TynokB3R7RT9c99FkQozm0npeOLxMEsXDPKjo+l9+azwfcIl+A1eKa/1P6v2+8dfpcxcH
 t4w==
X-Received: by 2002:ac8:5715:0:b0:4b0:61fa:19b4 with SMTP id
 d75a77b69052e-4b0aee19e7emr156578581cf.46.1754914795551; 
 Mon, 11 Aug 2025 05:19:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbR3+L+vQzuGcywJ3/Olrric5mC9tksRuRkRnFE9AhhUG8jjXr5ya3HokvJeylKh6qzN9mvg==
X-Received: by 2002:ac8:5715:0:b0:4b0:61fa:19b4 with SMTP id
 d75a77b69052e-4b0aee19e7emr156578161cf.46.1754914795055; 
 Mon, 11 Aug 2025 05:19:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b085ad7d08sm83932491cf.53.2025.08.11.05.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 05:19:54 -0700 (PDT)
Message-ID: <cf0a4fb8-de01-45df-b828-150b7ff64f86@redhat.com>
Date: Mon, 11 Aug 2025 14:19:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] hw/vfio/container.c: use QOM casts where appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-5-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-5-mark.caveayland@nutanix.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
>   hw/vfio/container.c | 31 +++++++++++++------------------
>   1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 3e13feaa74..f4337741b3 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -71,7 +71,7 @@ static int vfio_dma_unmap_bitmap(const VFIOContainer *container,
>                                    hwaddr iova, ram_addr_t size,
>                                    IOMMUTLBEntry *iotlb)
>   {
> -    const VFIOContainerBase *bcontainer = &container->bcontainer;
> +    const VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>       struct vfio_iommu_type1_dma_unmap *unmap;
>       struct vfio_bitmap *bitmap;
>       VFIOBitmap vbmap;
> @@ -124,8 +124,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
>                                        hwaddr iova, ram_addr_t size,
>                                        IOMMUTLBEntry *iotlb)
>   {
> -    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                                  bcontainer);
> +    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       struct vfio_iommu_type1_dma_unmap unmap = {
>           .argsz = sizeof(unmap),
>           .flags = 0,
> @@ -213,8 +212,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                  ram_addr_t size, void *vaddr, bool readonly,
>                                  MemoryRegion *mr)
>   {
> -    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                                  bcontainer);
> +    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       struct vfio_iommu_type1_dma_map map = {
>           .argsz = sizeof(map),
>           .flags = VFIO_DMA_MAP_FLAG_READ,
> @@ -246,8 +244,7 @@ static int
>   vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>                                       bool start, Error **errp)
>   {
> -    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                                  bcontainer);
> +    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       int ret;
>       struct vfio_iommu_type1_dirty_bitmap dirty = {
>           .argsz = sizeof(dirty),
> @@ -272,8 +269,7 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>   static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                         VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>   {
> -    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                                  bcontainer);
> +    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       struct vfio_iommu_type1_dirty_bitmap *dbitmap;
>       struct vfio_iommu_type1_dirty_bitmap_get *range;
>       int ret;
> @@ -495,7 +491,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>   {
>       struct vfio_info_cap_header *hdr;
>       struct vfio_iommu_type1_info_cap_migration *cap_mig;
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>   
>       hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
>       if (!hdr) {
> @@ -518,8 +514,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>   
>   static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       g_autofree struct vfio_iommu_type1_info *info = NULL;
>       int ret;
>   
> @@ -634,7 +629,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>   
>       if (!cpr_is_incoming()) {
>           QLIST_FOREACH(bcontainer, &space->containers, next) {
> -            container = container_of(bcontainer, VFIOContainer, bcontainer);
> +            container = VFIO_IOMMU_LEGACY(bcontainer);
>               if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>                   return vfio_container_group_add(container, group, errp);
>               }
> @@ -652,7 +647,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>            * create the container struct and group list.
>            */
>           QLIST_FOREACH(bcontainer, &space->containers, next) {
> -            container = container_of(bcontainer, VFIOContainer, bcontainer);
> +            container = VFIO_IOMMU_LEGACY(bcontainer);
>   
>               if (vfio_cpr_container_match(container, group, fd)) {
>                   return vfio_container_group_add(container, group, errp);
> @@ -672,7 +667,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>           goto fail;
>       }
>       new_container = true;
> -    bcontainer = &container->bcontainer;
> +    bcontainer = VFIO_IOMMU(container);
>   
>       if (!vfio_legacy_cpr_register_container(container, errp)) {
>           goto fail;
> @@ -735,7 +730,7 @@ fail:
>   static void vfio_container_disconnect(VFIOGroup *group)
>   {
>       VFIOContainer *container = group->container;
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>   
>       QLIST_REMOVE(group, container_next);
> @@ -781,7 +776,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>       QLIST_FOREACH(group, &vfio_group_list, next) {
>           if (group->groupid == groupid) {
>               /* Found it.  Now is it already in the right context? */
> -            if (group->container->bcontainer.space->as == as) {
> +            if (VFIO_IOMMU(group->container)->space->as == as) {
>                   return group;
>               } else {
>                   error_setg(errp, "group %d used in multiple address spaces",
> @@ -895,7 +890,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>           }
>       }
>   
> -    vfio_device_prepare(vbasedev, &group->container->bcontainer, info);
> +    vfio_device_prepare(vbasedev, VFIO_IOMMU(group->container), info);
>   
>       vbasedev->fd = fd;
>       vbasedev->group = group;


