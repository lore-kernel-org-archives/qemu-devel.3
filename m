Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FCAC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 13:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLjC6-0005o4-GR; Sun, 01 Jun 2025 09:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLjC2-0005nd-T6
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 09:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLjC0-00045X-QT
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 09:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748786253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+IrOa9IeXy4RWB2pyHPAj1XJ/V2M6023sYuU3O+8NKE=;
 b=BRkucYSJQhg9D6pB532s0p59KXrXLghbF5NUrl0NdLjUtF8U4kxIM2mogU4kquC8FQI0pD
 K/L8eKb2JPtu6X7NK9AG3LwEDQfBJBzPekBM3VazMksl0iQ03YlVhDk9aIOYkdBqP59BME
 TJC3DbeDEvtnhJh9PShwec0DJBO26rQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-rn4sOVHXNiWiZh-STf47YA-1; Sun, 01 Jun 2025 09:57:32 -0400
X-MC-Unique: rn4sOVHXNiWiZh-STf47YA-1
X-Mimecast-MFC-AGG-ID: rn4sOVHXNiWiZh-STf47YA_1748786251
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so5214835e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 06:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748786251; x=1749391051;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IrOa9IeXy4RWB2pyHPAj1XJ/V2M6023sYuU3O+8NKE=;
 b=lhIAVa51MDkisLGO4R4x+9qR4q3HzKcqKg9cGU7+OyapzI6FeCBW2HQxPUlesijrR4
 OnZRifiaJGwKqsoc6xuCxEnDcZnq7Bdf9e03QuhtoGaHjwoDrNTBJgliRGmHwqqHshM/
 Vii1X/92aWnsPglglj/wq33C8IBzNif6YutWh1WJpkrQB2bjP2lHFnRnJKAfKu2yhB/d
 kGQjX4R/8nFN6+WwnDPtzpo/aw61ZQbfVmxH41ceLce4TxGHtgz50JMpzQ8EW7Po+Uxe
 cBESzs/q3kBJ4V53k5YXVjoxtvoSoQzgLiBsO/HnDAz3dyyKvoxvjMUaDqJQJK5Jjvhy
 Ppwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKxuERJXtalE5iZ6V6vN9g0tW4okQR3GaG4H7Jltuav5KNZ/JpRmfR+pUKmRCOaVrPrE431yG1I+xm@nongnu.org
X-Gm-Message-State: AOJu0YxEYlt+8LDUeWihi221nUDAmNY95jLuDRLwDLuFXA71G5eUeAlh
 CHW0AhH4SUwt3YcFQ/TMKLELzWGuE0DTc7mhIFRSCWBA4rCmD0hms2JVxg+L427thE1FLbjIv2n
 X0N1hzKTKm6jGVZmT7iDWoDyLyHUFYohE5P1mWkkmgiMZE1FKjvMj7Del
X-Gm-Gg: ASbGncu7i0s5C32Nu/4lbjzrxTNvRhucaaA6soJC772qHiHU+IauISRJYv80SXqd1jX
 Qlc/tykI5kl6cboTJ9dvPQLkRCzgj7ciuA80KpO8v/r0pFUO3SJx5p6lqfyIXLLC8diCkl3A3Ej
 3GHjOlY7omEFLVkjEpnGPD7bYPlc0O+73LHMl4cAdaX53tXm5L5vqDeU4wswWNF6Pl11EvGcZ6f
 0+JS99ULo9PvLvYWjfImjvIDoSrCSTbJ7WSJPHDPqomVF7Gq8L/lXm8g4aHE/8DJgZSqS74UkSI
 MVUIqK45bT0vCuRpLa24zWZN+KbtWN6e0Oj6056WudrjIQTMdA==
X-Received: by 2002:a05:6000:220b:b0:3a4:d3ff:cef2 with SMTP id
 ffacd0b85a97d-3a4f89dddd5mr7100002f8f.27.1748786250907; 
 Sun, 01 Jun 2025 06:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+dOOfm0Ls8e1YlHjtmAKwmrHZWd3afozdAQspN/z+fNvkoswMgm9yfJF3BC/YKwFCg1b58g==
X-Received: by 2002:a05:6000:220b:b0:3a4:d3ff:cef2 with SMTP id
 ffacd0b85a97d-3a4f89dddd5mr7099984f8f.27.1748786250505; 
 Sun, 01 Jun 2025 06:57:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm11379471f8f.42.2025.06.01.06.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 06:57:29 -0700 (PDT)
Message-ID: <7104860b-a406-47df-b180-35ea9bf31b0d@redhat.com>
Date: Sun, 1 Jun 2025 15:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-2-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250530093512.3959484-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/30/25 11:35, Zhenzhong Duan wrote:
> This helper passes cache invalidation request from guest to invalidate
> stage-1 page table cache in host hardware.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/system/iommufd.h |  4 ++++
>   backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
>   backends/trace-events    |  1 +
>   3 files changed, 41 insertions(+)
> 
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75bfbf..83ab8e1e4c 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -61,6 +61,10 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                         uint64_t iova, ram_addr_t size,
>                                         uint64_t page_size, uint64_t *data,
>                                         Error **errp);
> +bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
> +                                      uint32_t data_type, uint32_t entry_len,
> +                                      uint32_t *entry_num, void *data,
> +                                      Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index b73f75cd0b..8bcdb60fe7 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -311,6 +311,42 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>       return true;
>   }
>   
> +bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
> +                                      uint32_t data_type, uint32_t entry_len,
> +                                      uint32_t *entry_num, void *data,
> +                                      Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    uint32_t total_entries = *entry_num;
> +    struct iommu_hwpt_invalidate cache = {
> +        .size = sizeof(cache),
> +        .hwpt_id = id,
> +        .data_type = data_type,
> +        .entry_len = entry_len,
> +        .entry_num = total_entries,
> +        .data_uptr = (uintptr_t)data,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cache);
> +    trace_iommufd_backend_invalidate_cache(fd, id, data_type, entry_len,
> +                                           total_entries, cache.entry_num,
> +                                           (uintptr_t)data, ret ? errno : 0);
> +    *entry_num = cache.entry_num;
> +
> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_HWPT_INVALIDATE failed:"
> +                         " total %d entries, processed %d entries",
> +                         total_entries, cache.entry_num);
> +    } else if (total_entries != cache.entry_num) {
> +        error_setg(errp, "IOMMU_HWPT_INVALIDATE succeed but with unprocessed"
> +                         " entries: total %d entries, processed %d entries."
> +                         " Kernel BUG?!", total_entries, cache.entry_num);
> +        return false;
> +    }
> +
> +    return !ret;
> +}
> +
>   static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>   {
>       HostIOMMUDeviceCaps *caps = &hiod->caps;
> diff --git a/backends/trace-events b/backends/trace-events
> index 40811a3162..7278214ea5 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -18,3 +18,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
>   iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
> +iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"


