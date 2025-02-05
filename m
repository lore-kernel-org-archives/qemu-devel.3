Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58B8C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjIY-0004XR-HI; Wed, 05 Feb 2025 12:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfjIV-0004Ve-Qh
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfjIU-00017r-59
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738776885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2z+QDbza/zemEHlUoZOnO47xB498d6xLtERISx1T970=;
 b=hU9F2IYefDbTBaq3th6TWUwjqrfcbtMpeo9RQx2B+nrqFBJNbbGG8gb1vk2i2L2vrihR8G
 nTsBf02Hn8vhmZ/IHhRFLE5f4lxsGAOaxWDxURTZJ/QZRvpmg+MwIazvLGjgBxe6QuBJPJ
 EPR+pELrV7SXI+yiu/z9CFKE1gaytwM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-tnQ2KmRFPBWz8prtBYA40w-1; Wed, 05 Feb 2025 12:34:42 -0500
X-MC-Unique: tnQ2KmRFPBWz8prtBYA40w-1
X-Mimecast-MFC-AGG-ID: tnQ2KmRFPBWz8prtBYA40w
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e19e09cc20so500566d6.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 09:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776882; x=1739381682;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z+QDbza/zemEHlUoZOnO47xB498d6xLtERISx1T970=;
 b=EbrLQ1o7yrsCd6k3g6QPXs5REvn9TksbxSoyUvFHtkJ/yl1ABHUBhlyMLG94nQRtkX
 LKfKhgLrsOO8odMcq2vgszN0LdhzJjStMDMjyIjhHSIPypxVf5hSF2s/yWW2XAtIO0Lj
 YV5YGXPDH1koT/5tLxxoov3FOeNOi+2VgbzGktR49Rma9MjeXo+UFUai6D6EDPpXBTvl
 zdaB2tfo6/TAXXkPVomjOJ0oOBwn7+oenGzFXM1i0i6QJxIFevrHAkfwgxzskmo0XW0K
 cNYnDB+Xx6/LJsmwCBDvrKhJitUrwzxbNMCdnFvCw6a5mpLZtGjmwCfPKL2sJa44gsqb
 A8bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDsaL7nAj79mW0zKDX/gxS6A762yWLWk8NsAAkctTq3rmh9aOX3CCfXbXQjWnYMGn7ecu4/piIXGOX@nongnu.org
X-Gm-Message-State: AOJu0YwkZm+2tg+l/g6X1qHJIQ0vdaHDgUbF15F0v5m2kPpOcp/ADXlT
 1JTZ6/HORWn/5sGwrNAtfHvjOcwvbMkYpKTv3APQ4e6OUlYCfz0rLRi+VHUoQ1WedoeuHE3ZGsD
 CGoYxNQ8znADSptKqJJPubpoNGb788ILkCrdYdQbI8B5nvZ6GAJH1
X-Gm-Gg: ASbGncv/+Fs6RNCL2q1ga4gJlDaG6oe4863Re5m/8KmJmeRImpKAisa+Q5SIGlA95oG
 F+IpyqTmw2Ivh98qmjOitHyVEqrIEk1Bda5VsnQr5mJZxIWArTlhWX7KaR7TQ75dmuGL00QLg74
 7JHj1u4NTrsC4ZWXit9iZUhuHT+LsdJ2j58VMm/W31ZVjot4EzoNQP1MxkRUHeog3Z5sfuDZHtj
 ZFwJsMPtz7LwG4WBCrd9p4Layird7+Cg4Rr08Pc0a1+0gtZdXeC6NZLLaSjLXgV5NAV9Bu1Tjz5
 StRRdxa08CzlNhjFiCchve0IdhaInM2/eR7vYqC9X30=
X-Received: by 2002:a05:620a:1925:b0:7b6:785e:ce1a with SMTP id
 af79cd13be357-7c039f95b75mr532350685a.4.1738776882166; 
 Wed, 05 Feb 2025 09:34:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuPyrl7BEFBJZnH4s7jqUWHTFTOZuSDZXVW+ZRnsPRO+UBxetxQBkEGzgGKqwNljQsY1f1fQ==
X-Received: by 2002:a05:620a:1925:b0:7b6:785e:ce1a with SMTP id
 af79cd13be357-7c039f95b75mr532347585a.4.1738776881771; 
 Wed, 05 Feb 2025 09:34:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8c8fdesm774133785a.27.2025.02.05.09.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 09:34:41 -0800 (PST)
Message-ID: <6371885e-4dd3-401c-8fb1-c675f9ac4c72@redhat.com>
Date: Wed, 5 Feb 2025 18:34:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 21/26] iommufd: change process ioctl
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-22-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-22-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 1/29/25 15:43, Steve Sistare wrote:
> Define the change process ioctl
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   backends/iommufd.c       | 20 ++++++++++++++++++++
>   backends/trace-events    |  1 +
>   include/system/iommufd.h |  2 ++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 6d29221..be5f6a3 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -73,6 +73,26 @@ static void iommufd_backend_class_init(ObjectClass *oc, void *data)
>       object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
>   }
>   
> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
> +{
> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
> +
> +    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
> +}
> +
> +int iommufd_change_process(IOMMUFDBackend *be)
> +{
> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
> +    int ret = ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
> +
> +    if (ret) {
> +        ret = -errno;
> +        error_report("IOMMU_IOAS_CHANGE_PROCESS fd %d failed: %m", be->fd);

please add  an 'Error **errp' parameter.


Thanks,

C.



> +    }
> +    trace_iommufd_change_process(be->fd, ret);
> +    return ret;
> +}
> +
>   bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>   {
>       int fd;
> diff --git a/backends/trace-events b/backends/trace-events
> index f478e18..9b33dc3 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -7,6 +7,7 @@ dbus_vmstate_loading(const char *id) "id: %s"
>   dbus_vmstate_saving(const char *id) "id: %s"
>   
>   # iommufd.c
> +iommufd_change_process(int fd, int ret) "fd=%d (%d)"
>   iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d users=%d"
>   iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
>   iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index ac700b8..4e9c037 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -64,6 +64,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                         uint64_t iova, ram_addr_t size,
>                                         uint64_t page_size, uint64_t *data,
>                                         Error **errp);
> +bool iommufd_change_process_capable(IOMMUFDBackend *be);
> +int iommufd_change_process(IOMMUFDBackend *be);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   #endif


