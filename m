Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14885C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulQzC-000398-97; Mon, 11 Aug 2025 07:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulQyk-0002rL-Uj
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulQye-0008WI-T9
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754912765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ghpfQOD90LopC48BrfJjbKLSoAckBMk1ACuQychEkbE=;
 b=Yrsgk3xPBc6z7wVXOrkexBJ/tsr7nMj+SSZ51t/D6CqpsakpjOLhKV2uxQPJ0zLxk1aqZP
 0/h8Ct3ueCsvT2MiWatETyaQ02C+yKMFDcl7lJk3wTtJ2tS+HmjBbAFfK3Cd0raemZMpUt
 d/4j/Zd/j2vkRm8wSzxcEnhZ+jlr0xs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-dlpq5XkWPAKjCimk9wIbrQ-1; Mon, 11 Aug 2025 07:46:03 -0400
X-MC-Unique: dlpq5XkWPAKjCimk9wIbrQ-1
X-Mimecast-MFC-AGG-ID: dlpq5XkWPAKjCimk9wIbrQ_1754912763
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b08898f776so108769361cf.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 04:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754912763; x=1755517563;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ghpfQOD90LopC48BrfJjbKLSoAckBMk1ACuQychEkbE=;
 b=C2NRrTLvToz1obiioLKNr+GNpoC8VRSFnomcDZFCySd5eB58sxE543jT+oFF1EYOPI
 Furi1JvYyGv262LCQsxp03vSb7HPQR4kvO2Pf0wNxHQiahzp+flci6nQLORj3cA7qmsn
 i+HxHX5GerEbaZwGmiVFkPlkIjxQjZ6kvjW/c+/+CSde26e4GKCPZ8k+IbHC0ii4xF+0
 t91wKoLpt7yiknm/D5foox8LjJEWHsTTRahyA3eqlf13c8KEUjFzqHvFVZTl3Cg4Ysa5
 3YyCI4vWfPi5KM8k7X9ajDMggwosJ09jjV6yK5Z/WRwa1xVSLgxZpK1+9HvcjZNSuxY3
 CXBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrSimuJviQlWuz3351wjivLO7Nh5P8AGzN0MnMR0JgJqPBfACGC5GQ9yhJP9zMCuaLqJcNgr8hN4FN@nongnu.org
X-Gm-Message-State: AOJu0YyMqNlaIU3UDEqAH6otp9TeY3ax1dtxfHp+mgVxwRerMSUnf5Cv
 lYEpp2hcsBc9xJPMSlH4X++yrFZN8P9SNaJYUICCf2g86GUNDy/peZMAleyZq5hPEjYLdOp8wQG
 XLF18Xhin9Oyp+lDnyn35vtbsYkWCfqkdL/NK+1VMW9SsUIyw2DpTLVkPjd+lkUmH
X-Gm-Gg: ASbGncuyulQ4pPyqowV3XJ4Gs966PvYMJhcjB0VjvyDTiwP21ZnWPMnHtMVddwE2Liq
 /6rAjPlAjLoiX2uPN1hbZODsD1x2UzmIgbni47RynrzV4C35wM1SkuBgmsJlB+s3/6zmoLlLJH0
 V0O3jtSCf6g3WW3zZX/50MLdxe8at2c0fwssEaJpWtqC/j7m24sNmuKizmgyteQCXcWrgi3HPP2
 VfJnZJkDwvhyGgDA4m8Z22XQf2JHe6P1tu7YJiOSLgxuss7iuQMJAI1wNAtny9J9qBS/snbhyPY
 5QR6tHL7xTf8xC8QoRPaRAWjC/uydEkTXMDX/UckmxOHlU8srr3WcxVEH3CmXdY27omvF6FzzoD
 6JA==
X-Received: by 2002:a05:622a:a953:10b0:4b0:cf35:fd5c with SMTP id
 d75a77b69052e-4b0cfd12bd5mr34284441cf.3.1754912762654; 
 Mon, 11 Aug 2025 04:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzuKVDnSc64oTvxiKQd1V77Zdymi+QWBcoq3esqyUedUFCkw9/Wh7QiSk9icOLudWdDZ7tOw==
X-Received: by 2002:a05:622a:a953:10b0:4b0:cf35:fd5c with SMTP id
 d75a77b69052e-4b0cfd12bd5mr34284141cf.3.1754912762231; 
 Mon, 11 Aug 2025 04:46:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b0733088e1sm98085571cf.61.2025.08.11.04.45.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 04:46:01 -0700 (PDT)
Message-ID: <c0536aa4-68d5-452d-bc6b-ea74035fb682@redhat.com>
Date: Mon, 11 Aug 2025 13:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] hw/vfio/cpr-legacy.c: use QOM casts where
 appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-4-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-4-mark.caveayland@nutanix.com>
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
>   hw/vfio/cpr-legacy.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 553b203e9b..8f437194fa 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -41,8 +41,8 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
>                                      hwaddr iova, ram_addr_t size, void *vaddr,
>                                      bool readonly, MemoryRegion *mr)
>   {
> -    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                                  bcontainer);
> +    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
> +
>       struct vfio_iommu_type1_dma_map map = {
>           .argsz = sizeof(map),
>           .flags = VFIO_DMA_MAP_FLAG_VADDR,
> @@ -65,7 +65,7 @@ static void vfio_region_remap(MemoryListener *listener,
>   {
>       VFIOContainer *container = container_of(listener, VFIOContainer,
>                                               cpr.remap_listener);
> -    vfio_container_region_add(&container->bcontainer, section, true);
> +    vfio_container_region_add(VFIO_IOMMU(container), section, true);
>   }
>   
>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
> @@ -98,7 +98,7 @@ static int vfio_container_pre_save(void *opaque)
>   static int vfio_container_post_load(void *opaque, int version_id)
>   {
>       VFIOContainer *container = opaque;
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>       dma_map_fn saved_dma_map = vioc->dma_map;
>       Error *local_err = NULL;
> @@ -135,7 +135,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>   {
>       VFIOContainer *container =
>           container_of(notifier, VFIOContainer, cpr.transfer_notifier);
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>   
>       if (e->type != MIG_EVENT_PRECOPY_FAILED) {
>           return 0;
> @@ -167,7 +167,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>   
>   bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   {
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>       Error **cpr_blocker = &container->cpr.blocker;
>   
>       migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
> @@ -191,7 +191,7 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   
>   void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>   {
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>   
>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>       migrate_del_blocker(&container->cpr.blocker);


