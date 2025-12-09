Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A3BD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 10:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSv0s-0006RO-CA; Tue, 09 Dec 2025 05:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSv0l-0006Pz-Q6
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSv0j-0003w7-9x
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765276320;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3r2Gn+GyRvWzhqDaIrIdZaO1hd9SIPPLg7tXHz6VxaI=;
 b=TWcL/R+gyPfQJ1Xsp+Exbl1jHBAnk37T2p+wfh15aLIXGrhpYeDMfx82Kvi5bwGnxELVRO
 2BVaNY6QuKy8dX3VOSnHoHDsornZD+IEc3wEF56QVup7NHQ0zzIyecFAEqJeSBZJ0TLjiX
 kszQIPYbS7vRq2k5DfPgKlp2K5/w950=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-YrP4GgJyPu-8tcCY_PMDTg-1; Tue, 09 Dec 2025 05:31:59 -0500
X-MC-Unique: YrP4GgJyPu-8tcCY_PMDTg-1
X-Mimecast-MFC-AGG-ID: YrP4GgJyPu-8tcCY_PMDTg_1765276318
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b99763210e5so10892930a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 02:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765276318; x=1765881118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3r2Gn+GyRvWzhqDaIrIdZaO1hd9SIPPLg7tXHz6VxaI=;
 b=jhdRpXdUVbO/ihwGD1EUXIrqHQ8Wt3eflpbIlk+hTtbHUxNCM0Z0SCc/Ev6T6r9BgU
 OqQuHmQkuQJcRq6ffUnvCyn4opPTvt9m0FOOXnPxEqa4LcV6RFZqL4+cQVE/jE67Y3tS
 TI8LXdMYolFBDoA8KWu6klkcLB4HqbqQtQEcQ+VHkGSTtmDbjV6KV/0FeMleGrtoaaXd
 QAPSIhDz+bNsvmjl4Fzz1Tr0IefHwv+okEyiBG+FxH/P9k0d+ZbCqLSAOv/Oe+JkJnhj
 2c0tDzn8Tf+jmdEi7mw/8PXcaYISDEVKetyzLCmFGNlQbS1QsY2pmsKczUxvVnbA9wbE
 KwPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPkeIWHcNq7A7RvcOqfkyj9O+I1ZvI9LNx1gLGiOYyFOC4pNcHdJ4e4LPaHn1ljMGimj4w6Fntbzei@nongnu.org
X-Gm-Message-State: AOJu0Ywzicoa/HFhIs0hYTnGSmDZXB+ALZ0QH6UHrBUQNLKbjhEk5epB
 fpyD4JSVmjUI3YiaS2RjhWhjRVIitTDQc1YUZuHFCX66DVJdfdMMih3xWCWuXNh0ToXpJ6FzFI+
 EonoSMYmNM54g6TG4l+rdRgSjKkaTz/fZf6bEUqeG7Fd6QKJniFIcZTnF
X-Gm-Gg: ASbGncuIANN2y4CBwmF76z7ghwzKKkbucFafnOC7ZtVua2SurMb/1eOH7ltPDyogxoe
 V8c+Emt57qF59+fwBFS3DkWdZiYXuB+jbGXYGRjSALw8KbFYVPInnEpGScfFRhhqDKE9VzOjtdi
 QvT3PqiVTbz8KnwJun2eVBkpi17RR6vdqRJVSmVchCmbnyPfd+OJDNXhEH4O/SHqX++6aCdDUQw
 UoXleRBt+1IaJfRQcCjDjsCTMhoT18tgKFXML2dgQlNrw5XaR40VROopUUAsnrnARxvyQnkewdp
 Acv0HF/1ak0YthT5RnZTcsUVUSzCTThxLjM1MgcN4v1c2oe0uuIUNZedAv2ho3F8V9yWmCMv9L8
 mYvWjp9im4X+b+3Luc8IxGvunRzvmmotaB6eyDlpEn5DVnBLGz3iXow7ATw==
X-Received: by 2002:a05:7022:4394:b0:119:e56b:958c with SMTP id
 a92af1059eb24-11e0325ef0fmr7939807c88.17.1765276318252; 
 Tue, 09 Dec 2025 02:31:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLPmiNGF8TBRnuHUE83sJD5OVTkWG7a/3mClSSRRWjj8Ry4RalpPAy9O0SlU08TxlCDzpIiA==
X-Received: by 2002:a05:7022:4394:b0:119:e56b:958c with SMTP id
 a92af1059eb24-11e0325ef0fmr7939785c88.17.1765276317708; 
 Tue, 09 Dec 2025 02:31:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11df7552defsm69293603c88.2.2025.12.09.02.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 02:31:57 -0800 (PST)
Message-ID: <bf00d499-cbe9-4e14-a79c-a601fd19a558@redhat.com>
Date: Tue, 9 Dec 2025 11:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
 <20251204092245.5157-2-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251204092245.5157-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/4/25 10:22 AM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add a new helper for IOMMU_VEVENTQ_ALLOC ioctl to allocate a virtual event
> queue (vEVENTQ) for a vIOMMU object.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  include/system/iommufd.h | 12 ++++++++++++
>  3 files changed, 44 insertions(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 718d63f5cf..633aecd525 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -503,6 +503,37 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
>      return true;
>  }
>  
> +bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
> +                                   uint32_t type, uint32_t depth,
> +                                   uint32_t *out_veventq_id,
> +                                   uint32_t *out_veventq_fd, Error **errp)
> +{
> +    int ret;
> +    struct iommu_veventq_alloc alloc_veventq = {
> +        .size = sizeof(alloc_veventq),
> +        .flags = 0,
> +        .type = type,
> +        .veventq_depth = depth,
> +        .viommu_id = viommu_id,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_VEVENTQ_ALLOC, &alloc_veventq);
> +
> +    trace_iommufd_viommu_alloc_eventq(be->fd, viommu_id, type,
> +                                      alloc_veventq.out_veventq_id,
> +                                      alloc_veventq.out_veventq_fd, ret);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_VEVENTQ_ALLOC failed");
> +        return false;
> +    }
> +
> +    g_assert(out_veventq_id);
> +    g_assert(out_veventq_fd);
can it happen if the ioctl succeeds?
> +    *out_veventq_id = alloc_veventq.out_veventq_id;
> +    *out_veventq_fd = alloc_veventq.out_veventq_fd;
> +    return true;
> +}
> +
>  bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>                                             uint32_t hwpt_id, Error **errp)
>  {
> diff --git a/backends/trace-events b/backends/trace-events
> index 8408dc8701..5afa7a40be 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -23,3 +23,4 @@ iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, u
>  iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
>  iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
>  iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
> +iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index aa78bf1e1d..9770ff1484 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -56,6 +56,13 @@ typedef struct IOMMUFDVdev {
>      uint32_t virt_id;  /* virtual device ID */
>  } IOMMUFDVdev;
>  
> +/* Virtual event queue interface for a vIOMMU */
> +typedef struct IOMMUFDVeventq {
> +    IOMMUFDViommu *viommu;
> +    uint32_t veventq_id;
> +    uint32_t veventq_fd;
> +} IOMMUFDVeventq;
> +
>  bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
>  void iommufd_backend_disconnect(IOMMUFDBackend *be);
>  
> @@ -86,6 +93,11 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
>                                  uint32_t viommu_id, uint64_t virt_id,
>                                  uint32_t *out_vdev_id, Error **errp);
>  
> +bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
> +                                   uint32_t type, uint32_t depth,
> +                                   uint32_t *out_veventq_id,
> +                                   uint32_t *out_veventq_fd, Error **errp);
> +
>  bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                          bool start, Error **errp);
>  bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
Eric


