Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E09BC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAUO-0003eh-0E; Tue, 23 Jul 2024 04:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAUL-0003UD-Sd
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAUJ-0004aU-Dm
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721721789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95kn+6Xa2Z8xowQRGn96Je79i4b9z+wJYumzYSSYZ0s=;
 b=LobiGbtCjG9mvTbdtZAoEc9UxMuTuNu8bYvtq0gV+c+5GzIhnLHNSW9K6kWWUqJ7im1+Ks
 WzxBWSaiNsMOCpcZQ47fmtoQXnqqIsKQRlU011oukVoDueSl2ih6+BniWk+cPjCWMoRh4A
 VBQlx+8/dAYLgt5IKUR+8rydYeO36ZA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-Pps7kfifNnqzLSlsbQHOiQ-1; Tue, 23 Jul 2024 04:03:08 -0400
X-MC-Unique: Pps7kfifNnqzLSlsbQHOiQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-79efd11a9faso603013585a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721721788; x=1722326588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=95kn+6Xa2Z8xowQRGn96Je79i4b9z+wJYumzYSSYZ0s=;
 b=lNLWl3+T+9yGvsBHd27cEQhqLDKlpaV0d6FgEr9/inVsCikoJUgM0W/5Aw7c1BUwCz
 GB9ZlfTEw+S7K/wWvfDsDRNhCFpQLymLROhL3nKZCOG3JpJeR6FbGl6C0dY3/xUApUwm
 FhaW230sUTEi9fu6kxbYYz+aAnmxeBmDGjAyNVFitiUWBdi6pAInlX84LbNbjfPznta+
 zBJ4QdMT3DP4CbhsoCz+kBEHH+mdffG7+6rdCh1pSj07r2CiEAuVF25VZVSBoEDJbIkf
 sX6zQO1vqrTS4rs2GI2OlOZIF/tSv6L7uEBJ4yKmyUVp/VQhRQsZYuSqD2El/57aVFdR
 CuHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM1CkQAgnAW5EMsIT9I9jIK23+p/afoXpswteyRGxDPnU0zfK8e9JFT5TdZg+1EYfUvdL2hMFmpYNszWpdAC9uVAVhJQc=
X-Gm-Message-State: AOJu0YwzQckbGldQXnh6ausLmIER0rrlo0yKemhm8sHh7KWFl7JzXnwj
 N2j/326CoC99JtIuLBoGRh2S9QE9kmlCGwNt067tRq+xzwoaaRCnil8CJWtN3FX1YIJCx7caWLq
 Rd8LASmX2MBkoBQSGJ19PJizgvM41jKWLIcWLJKNJoKZku4IoDKUm
X-Received: by 2002:a05:620a:400b:b0:79d:57b3:71f7 with SMTP id
 af79cd13be357-7a1a65fc3e1mr1152389185a.47.1721721787680; 
 Tue, 23 Jul 2024 01:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7UNQ8QcODw5sj0ytALBjY/ucqFf0P6bnUPmA8QaysX9pMyCAafqeWe/iCIrGy/zUOL5xZFA==
X-Received: by 2002:a05:620a:400b:b0:79d:57b3:71f7 with SMTP id
 af79cd13be357-7a1a65fc3e1mr1152385485a.47.1721721787291; 
 Tue, 23 Jul 2024 01:03:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a198fcfb74sm447945885a.51.2024.07.23.01.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:03:06 -0700 (PDT)
Message-ID: <0a1aada1-ad2f-4e4b-b690-b78ef55c849c@redhat.com>
Date: Tue, 23 Jul 2024 10:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-7-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240722211326.70162-7-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Joao,

On 7/22/24 23:13, Joao Martins wrote:
> ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
> enables or disables dirty page tracking. The ioctl is used if the hwpt
> has been created with dirty tracking supported domain (stored in
> hwpt::flags) and it is called on the whole list of iommu domains.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/sysemu/iommufd.h |  2 ++
>  backends/iommufd.c       | 23 +++++++++++++++++++++++
>  hw/vfio/iommufd.c        | 32 ++++++++++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  4 files changed, 58 insertions(+)
>
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index e917e7591d05..6fb412f61144 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -55,6 +55,8 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                  uint32_t data_type, uint32_t data_len,
>                                  void *data_ptr, uint32_t *out_hwpt,
>                                  Error **errp);
> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                        bool start, Error **errp);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 06b135111f30..b97883503884 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -238,6 +238,29 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>      return true;
>  }
>  
> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
> +                                        uint32_t hwpt_id, bool start,
> +                                        Error **errp)
> +{
> +    int ret;
> +    struct iommu_hwpt_set_dirty_tracking set_dirty = {
> +            .size = sizeof(set_dirty),
> +            .hwpt_id = hwpt_id,
> +            .flags = start ? IOMMU_HWPT_DIRTY_TRACKING_ENABLE : 0,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
> +    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret ? errno : 0);
> +    if (ret) {
> +        error_setg_errno(errp, errno,
> +                         "IOMMU_HWPT_SET_DIRTY_TRACKING(hwpt_id %u) failed",
> +                         hwpt_id);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       uint32_t *type, void *data, uint32_t len,
>                                       uint64_t *caps, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 7afea0b041ed..b882a3f59a6e 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -115,6 +115,37 @@ static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>      return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>  }
>  
> +static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
> +                                           bool start, Error **errp)
> +{
> +    const VFIOIOMMUFDContainer *container =
> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> +    VFIOIOASHwpt *hwpt;
> +
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
> +            continue;
> +        }
so here I see you handle the case where we have hwpts with and without
support for dirty tracking within the same container so I guess this
answers my previous question. So do you want to tag a container as
dirty_pages_supported = true as soon as one device is backed up with a
dirty tracking hwpt within that container? I think I miss the high level
view of when this case may happen and why the devices do not end up in
different containers/ioas. But maybe I completely mix up things &
objects. Eric
> +
> +        if (!iommufd_backend_set_dirty_tracking(container->be,
> +                                                hwpt->hwpt_id, start, errp)) {
> +            goto err;
> +        }
> +    }
> +
> +    return 0;
> +
> +err:
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
> +            continue;
> +        }
> +        iommufd_backend_set_dirty_tracking(container->be,
> +                                           hwpt->hwpt_id, !start, NULL);
> +    }
> +    return -EINVAL;
> +}
> +
>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -725,6 +756,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>      vioc->attach_device = iommufd_cdev_attach;
>      vioc->detach_device = iommufd_cdev_detach;
>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
> +    vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
>  };
>  
>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> diff --git a/backends/trace-events b/backends/trace-events
> index 4d8ac02fe7d6..28aca3b859d4 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t si
>  iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>  iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
> +iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"


