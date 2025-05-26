Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E255C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 16:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJb9Q-0002SH-8F; Mon, 26 May 2025 12:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJb91-0002MH-WB
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJb8w-0003hT-GF
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748278661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JR9F0RLANhUU3B0457Fy2cAHZn42wAbaxqAsjyjXvyE=;
 b=frwKejMBhiQbylLEEfa4q6EtbjBI1g7ccZcSIzJoba9m1H6X/5zgaRWC7i+ProDh9gLFxZ
 8MN0y83jxGYqG1x4ankVEvQO7xI2Dl3VTZyI5I7uf5aTcGU06WD/4ae2aJltiAvTDldRDq
 7+eLe5P2NUNENf/6L9RHjsqUCA20GOQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-zOQiTUdPOoqil2x_pmUqng-1; Mon, 26 May 2025 12:57:39 -0400
X-MC-Unique: zOQiTUdPOoqil2x_pmUqng-1
X-Mimecast-MFC-AGG-ID: zOQiTUdPOoqil2x_pmUqng_1748278659
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442cdf07ad9so13569075e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 09:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748278659; x=1748883459;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JR9F0RLANhUU3B0457Fy2cAHZn42wAbaxqAsjyjXvyE=;
 b=fbsDH5w22EVpUDLwTdc+0fYjpigybcoz6ugqV/Xms9rta/iObGX3CCi/N2JiKOUExT
 bj0ZICG588akOJlL9g8luidD2ozkb6HOmNYud6O4KAAu3f8kCC/QUyXr7BjJWijqJRAW
 7krBvWFRsASXsDrTprcmskOHu/F8MFG0hJqBhbh47RGMjs4sve1GS/lDse8KVp+TowV0
 es8NQsasegcR1dwHDSzZjSi3JrGyJp3YrMezGNlJhTQGKX/WSonqHdtB+bUyMWMh9Lgl
 S0FzgTXnVKCl5kl/YoBE2ypDtvyjeTu+RlLSFnNe6BJkdPlGnFxBglOeyUOPJkClmrap
 VTIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDbKmMOK/c8roNEJXJMN5f5vIfLOakVoMT+9sLA2paP4A72q54kY50FDXLrpO+K4G2vwtSlPzBGCxp@nongnu.org
X-Gm-Message-State: AOJu0YxGZDID9XpGLJrFMHaWiCzc16pfUnqc3cfuP24CH/U/qK8ouft2
 mD92wTTt+pybwr9QH/g17fX+GxyuFuH/GLSGEweXKed3VZIxzri0yP72rRCsccRrfDGZwLhkps6
 ngRNhocR0Ao6+O/P14mWrTrrzdJvvEUE1iCN4mV9L8qNCWFkY07KxqMJX
X-Gm-Gg: ASbGncvJmvB3g6+riOZftt9I6ftf9HpExyU8aGvBMoXluzEcA+u6MXJM4QIIlY8Bc43
 WXC3OE4GvpYp07jddVq5jbOiWOL5kzpEdd4uZsvbxt8CNXIZstpLkctIejOVZ8WxVXZUEsMu+K8
 rS5ESggnNTaA9iHS9SV41lBSkZqD+kygty5Ej6j81JBOIwv2wiWc8IqEDubn1dginrULZhOht5z
 tW6qEYhyjYJelOyzNiE0XDM1xvpmYD3Nf7un1h1Cvrs++vB1yTUGEFO/o40epHQKw3NyqKY0nDT
 lki3Yvixgt0ggeoh1tOBxPWhtWkKDmPGbbOVRzR2OHTaJWmYMg==
X-Received: by 2002:a05:600c:348d:b0:43c:e7a7:1e76 with SMTP id
 5b1f17b1804b1-44c930164e9mr76539735e9.1.1748278658681; 
 Mon, 26 May 2025 09:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH43/CrFWixO43wtGANC1mYitfxPj4ZwWg/2VfDs4CfGY49HCZb+wpQhBdxCP/nTwRzaxnafw==
X-Received: by 2002:a05:600c:348d:b0:43c:e7a7:1e76 with SMTP id
 5b1f17b1804b1-44c930164e9mr76539575e9.1.1748278658290; 
 Mon, 26 May 2025 09:57:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d2a7a317sm5733117f8f.24.2025.05.26.09.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 09:57:37 -0700 (PDT)
Message-ID: <ff64dd4c-3437-4570-9fec-408c65339b8c@redhat.com>
Date: Mon, 26 May 2025 18:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] vfio: return mr from vfio_get_xlat_addr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
References: <1747661203-136490-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
In-Reply-To: <1747661203-136490-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/19/25 15:26, Steve Sistare wrote:
> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
> region that the translated address is found in.  This will be needed by
> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
> 
> Also return the xlat offset, so we can simplify the interface by removing
> the out parameters that can be trivially derived from mr and xlat.
> 
> Lastly, rename the functions to  to memory_translate_iotlb() and
> vfio_translate_iotlb().
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Applied to vfio-next.

Thanks,

C.


> ---
>   hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
>   hw/virtio/vhost-vdpa.c  |  9 +++++++--
>   include/system/memory.h | 19 +++++++++----------
>   system/memory.c         | 32 +++++++-------------------------
>   4 files changed, 45 insertions(+), 48 deletions(-)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index bfacb3d..0afafe3 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>              section->offset_within_address_space & (1ULL << 63);
>   }
>   
> -/* Called with rcu_read_lock held.  */
> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                               ram_addr_t *ram_addr, bool *read_only,
> -                               Error **errp)
> +/*
> + * Called with rcu_read_lock held.
> + * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
> + */
> +static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
> +                                          Error **errp)
>   {
> -    bool ret, mr_has_discard_manager;
> +    MemoryRegion *mr;
>   
> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> -                               &mr_has_discard_manager, errp);
> -    if (ret && mr_has_discard_manager) {
> +    mr = memory_translate_iotlb(iotlb, xlat_p, errp);
> +    if (mr && memory_region_has_ram_discard_manager(mr)) {
>           /*
>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
>            * pages will remain pinned inside vfio until unmapped, resulting in a
> @@ -118,7 +119,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                            " intended via an IOMMU. It's possible to mitigate "
>                            " by setting/adjusting RLIMIT_MEMLOCK.");
>       }
> -    return ret;
> +    return mr;
>   }
>   
>   static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> @@ -126,6 +127,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
> +    MemoryRegion *mr;
> +    hwaddr xlat;
>       void *vaddr;
>       int ret;
>       Error *local_err = NULL;
> @@ -150,10 +153,14 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +        mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
> +        if (!mr) {
>               error_report_err(local_err);
>               goto out;
>           }
> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
> +
>           /*
>            * vaddr is only valid until rcu_read_unlock(). But after
>            * vfio_dma_map has set up the mapping the pages will be
> @@ -1010,6 +1017,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       ram_addr_t translated_addr;
>       Error *local_err = NULL;
>       int ret = -EINVAL;
> +    MemoryRegion *mr;
> +    ram_addr_t xlat;
>   
>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>   
> @@ -1021,9 +1030,11 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>   
>       rcu_read_lock();
> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> +    mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
> +    if (!mr) {
>           goto out_unlock;
>       }
> +    translated_addr = memory_region_get_ram_addr(mr) + xlat;
>   
>       ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>                                   translated_addr, &local_err);
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 1ab2c11..a1dd9e1 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       int ret;
>       Int128 llend;
>       Error *local_err = NULL;
> +    MemoryRegion *mr;
> +    hwaddr xlat;
>   
>       if (iotlb->target_as != &address_space_memory) {
>           error_report("Wrong target AS \"%s\", only system memory is allowed",
> @@ -228,11 +230,14 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> -                                  &local_err)) {
> +        mr = memory_translate_iotlb(iotlb, &xlat, &local_err);
> +        if (!mr) {
>               error_report_err(local_err);
>               return;
>           }
> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
> +
>           ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
>                                    iotlb->addr_mask + 1, vaddr, read_only);
>           if (ret) {
> diff --git a/include/system/memory.h b/include/system/memory.h
> index fbbf4cf..13416d7 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -738,21 +738,20 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>                                                RamDiscardListener *rdl);
>   
>   /**
> - * memory_get_xlat_addr: Extract addresses from a TLB entry
> + * memory_translate_iotlb: Extract addresses from a TLB entry.
> + *                         Called with rcu_read_lock held.
>    *
>    * @iotlb: pointer to an #IOMMUTLBEntry
> - * @vaddr: virtual address
> - * @ram_addr: RAM address
> - * @read_only: indicates if writes are allowed
> - * @mr_has_discard_manager: indicates memory is controlled by a
> - *                          RamDiscardManager
> + * @xlat_p: return the offset of the entry from the start of the returned
> + *          MemoryRegion.
>    * @errp: pointer to Error*, to store an error if it happens.
>    *
> - * Return: true on success, else false setting @errp with error.
> + * Return: On success, return the MemoryRegion containing the @iotlb translated
> + *         addr.  The MemoryRegion must not be accessed after rcu_read_unlock.
> + *         On failure, return NULL, setting @errp with error.
>    */
> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp);
> +MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
> +                                     Error **errp);
>   
>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
> diff --git a/system/memory.c b/system/memory.c
> index 63b983e..306e9ff 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2174,18 +2174,14 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   }
>   
>   /* Called with rcu_read_lock held.  */
> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp)
> +MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
> +                                     Error **errp)
>   {
>       MemoryRegion *mr;
>       hwaddr xlat;
>       hwaddr len = iotlb->addr_mask + 1;
>       bool writable = iotlb->perm & IOMMU_WO;
>   
> -    if (mr_has_discard_manager) {
> -        *mr_has_discard_manager = false;
> -    }
>       /*
>        * The IOMMU TLB entry we have just covers translation through
>        * this IOMMU to its immediate target.  We need to translate
> @@ -2195,7 +2191,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                                    &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
>       if (!memory_region_is_ram(mr)) {
>           error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
> -        return false;
> +        return NULL;
>       } else if (memory_region_has_ram_discard_manager(mr)) {
>           RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
>           MemoryRegionSection tmp = {
> @@ -2203,9 +2199,6 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>               .offset_within_region = xlat,
>               .size = int128_make64(len),
>           };
> -        if (mr_has_discard_manager) {
> -            *mr_has_discard_manager = true;
> -        }
>           /*
>            * Malicious VMs can map memory into the IOMMU, which is expected
>            * to remain discarded. vfio will pin all pages, populating memory.
> @@ -2216,7 +2209,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>               error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
>                            " via virtio-mem): %" HWADDR_PRIx "",
>                            iotlb->translated_addr);
> -            return false;
> +            return NULL;
>           }
>       }
>   
> @@ -2226,22 +2219,11 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>        */
>       if (len & iotlb->addr_mask) {
>           error_setg(errp, "iommu has granularity incompatible with target AS");
> -        return false;
> +        return NULL;
>       }
>   
> -    if (vaddr) {
> -        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> -    }
> -
> -    if (ram_addr) {
> -        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
> -    }
> -
> -    if (read_only) {
> -        *read_only = !writable || mr->readonly;
> -    }
> -
> -    return true;
> +    *xlat_p = xlat;
> +    return mr;
>   }
>   
>   void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)


