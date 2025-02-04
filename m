Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79029C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfL96-00047K-Bm; Tue, 04 Feb 2025 10:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfL94-00046m-L2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfL92-00086p-Vb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738684044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0m7T97cxCPvB5UH8DT58Rro0z178ZUmwQRKea+dJ4TI=;
 b=eeXypiJZwMpGMFcoDwf2dMxaLBMMrEyc9KM4QPiVsUN4vhgsk5aDDnvIZApcksAvcRzJcS
 xFHrHbzTTIjBtKu29mrJJKOMX2ImBJZ61afE3SQ4qGceLxZecOuor0F7nI13DdcXvOGmar
 +tt7NF2Q8RKHV9KCsRIoJD/T31wi7wA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-7HRmaYmcPCqfjNCsa-cnOg-1; Tue, 04 Feb 2025 10:47:21 -0500
X-MC-Unique: 7HRmaYmcPCqfjNCsa-cnOg-1
X-Mimecast-MFC-AGG-ID: 7HRmaYmcPCqfjNCsa-cnOg
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e7f0735aso942754485a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684041; x=1739288841;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0m7T97cxCPvB5UH8DT58Rro0z178ZUmwQRKea+dJ4TI=;
 b=jFT9iE99tD3p4lp3NO4gfk86rFkkrcy7es2SSKbujpPGNWOjtmqaRqJn9EFaMUjZZ8
 Kd+q+RPdMihXRhpB36tFfazSGHtgP6TxPMbC+btJAUvOqkYnTJNQHdOkTLbWmbtg8RIu
 9YWQ8zSo81gknIUY0fJaDNyzLic18zym/mzLNWrDTJ5Cw5uzjZKRXXYo0LVaYyyPL7WU
 77Z/FH/K/b9ATKVcWSQbgsl5OvMm3B3x9BceYVnK92f8xkc4ztNpNkSfy/az7V9JX0/X
 jhKaoeJN554u4nMNEJ4ZIxYOm+mUulwZbYGcdstTQxbIZqRBX6uDJH6cLtJEVeP2uI3f
 poWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvkJnVBhKGoM07J1OYnnoqjaYN1Afe+qZ00BcYrB3YrG8mdEZtSNTkUug0ucbd/w6YKDcrzRq06upn@nongnu.org
X-Gm-Message-State: AOJu0YxnOeKwZlX7Hm62+l48rZnMFailhm5iFNf3r2a7vxMUZ5rW9rDi
 uywh8kjOOtyjtgiL46vAgR4X8AIY/g4TWz8ejae77mnG4WjaE4QbEhrN5fOYHtPHWIllpwRQr7x
 Gw3LjxixWtYnYtL7wg5Dc/zo6LUgdWmh+CgWaDfdAL9bmio0i4Hbj
X-Gm-Gg: ASbGncssVzObOgVtUrrtnyYnLCdKm1051ddhzIxs9m809/6/mm/hvBr3fc9TOaK9NAE
 Bc0iR6+7Gw28opJHjTa6cUsPGYlY4CtGmmAKzrv4abZnCap/aa6l2BCvK+GXNaLXoim6LiDYdoe
 Avrqq9QSA6wQ1+Yrg7S2iwFXsCsXdeBQvbMrNtycAN1O2heF0JQmk6PivFnfLobBHjvLw5AcwGS
 JND4yYDv8aqbVTCnd2imKClR1lgd0lt6d57+zqhMTfuTTgrvoTDlD6+1DdSwtvgreRgYqXEiuj1
 FEHJU2fBHItd1lyshD09jtPvSlbaUqCipwISJvRoUTM=
X-Received: by 2002:a05:620a:450e:b0:7be:8304:f24b with SMTP id
 af79cd13be357-7bffcd9d55cmr4407200285a.56.1738684041262; 
 Tue, 04 Feb 2025 07:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGymnmBWUaDZS1SrXhCQTkUS+lhZr5bgaX4jPrjHPZEQlGhqCWVGyKIhx7G80xTfHsxoeuUA==
X-Received: by 2002:a05:620a:450e:b0:7be:8304:f24b with SMTP id
 af79cd13be357-7bffcd9d55cmr4407194785a.56.1738684040883; 
 Tue, 04 Feb 2025 07:47:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8bba53sm648467785a.12.2025.02.04.07.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 07:47:20 -0800 (PST)
Message-ID: <e8e6eb45-a308-479a-bd14-ad9bf4cc509f@redhat.com>
Date: Tue, 4 Feb 2025 16:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 16/26] vfio: return mr from vfio_get_xlat_addr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Levon <john.levon@nutanix.com>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-17-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-17-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

+ John (for vfio-user)

On 1/29/25 15:43, Steve Sistare wrote:
> Return the memory region that the translated address is found in, for
> use in a subsequent patch.  No functional change.

Keeping a reference on this memory region could be risky. What for ?

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/common.c       | 9 ++++++---
>   hw/virtio/vhost-vdpa.c | 2 +-
>   include/exec/memory.h  | 5 ++++-
>   system/memory.c        | 8 +++++++-
>   4 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index db0498e..4bbc29f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -248,12 +248,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>   /* Called with rcu_read_lock held.  */
>   static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                                  ram_addr_t *ram_addr, bool *read_only,
> +                               MemoryRegion **mr_p,
>                                  Error **errp)
>   {
>       bool ret, mr_has_discard_manager;
>   
>       ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> -                               &mr_has_discard_manager, errp);
> +                               &mr_has_discard_manager, mr_p, errp);
>       if (ret && mr_has_discard_manager) {
>           /*
>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
> @@ -300,7 +301,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> +                                &local_err)) {
>               error_report_err(local_err);
>               goto out;
>           }
> @@ -1279,7 +1281,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>   
>       rcu_read_lock();
> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, NULL,
> +                            &local_err)) {
>           error_report_err(local_err);
>           goto out_unlock;
>       }
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12..a1866bb 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -228,7 +228,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> +        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL, NULL,
>                                     &local_err)) {
>               error_report_err(local_err);
>               return;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index ea5d33a..a2f1229 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -747,13 +747,16 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>    * @read_only: indicates if writes are allowed
>    * @mr_has_discard_manager: indicates memory is controlled by a
>    *                          RamDiscardManager
> + * @mr_p: return the MemoryRegion containing the @iotlb translated addr
>    * @errp: pointer to Error*, to store an error if it happens.
>    *
>    * Return: true on success, else false setting @errp with error.
>    */
>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                             ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp);
> +                          bool *mr_has_discard_manager,
> +                          MemoryRegion **mr_p,

There is a risk that the life cycle of the returned MemoryRegion
doesn't match VFIO expectations.

Also, it seems that memory_get_xlat_addr() has reached a point
where the callers need refactoring. 'mr_p' would be the 5th out
parameter and 3 of these already depend on the MemoryRegion
returned by flatview_translate().


Thanks,

C.



> +                          Error **errp);
>   
>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
> diff --git a/system/memory.c b/system/memory.c
> index 4c82979..4ec2b8f 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2185,7 +2185,9 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   /* Called with rcu_read_lock held.  */
>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                             ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp)
> +                          bool *mr_has_discard_manager,
> +                          MemoryRegion **mr_p,
> +                          Error **errp)
>   {
>       MemoryRegion *mr;
>       hwaddr xlat;
> @@ -2250,6 +2252,10 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>           *read_only = !writable || mr->readonly;
>       }
>   
> +    if (mr_p) {
> +        *mr_p = mr;
> +    }
> +
>       return true;
>   }
>   


