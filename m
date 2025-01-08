Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAB4E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVaWQ-0005hl-Kk; Wed, 08 Jan 2025 13:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVaWO-0005hZ-Rd
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:11:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVaWN-0003jk-7i
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736359867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNWudEl395pTSAcJEXvWCSz589uTZDBEcgkVToTSIkY=;
 b=Rf8EaskgtW4wYfyrS0Y+NTJ9KMsGIIu3s3AviJyciBFB+KU5jbAecAen4MjAW0lufZ4icd
 1J6XD8siy7kDG7oolWpQfGXOyRPIu0vgKR9KPJ9nyipMkEb/P8gIHJf/zvhCoY1Xb1bQlm
 9pKXlKV92iC6g++N+W2CKok7acFhh90=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-7slZCrGpOmu-8uON0nKqsw-1; Wed, 08 Jan 2025 13:11:05 -0500
X-MC-Unique: 7slZCrGpOmu-8uON0nKqsw-1
X-Mimecast-MFC-AGG-ID: 7slZCrGpOmu-8uON0nKqsw
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d3fe991854so5018a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 10:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736359864; x=1736964664;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KNWudEl395pTSAcJEXvWCSz589uTZDBEcgkVToTSIkY=;
 b=kNjgfvyKC4ti6xmk/bKvqx1nqUeOvHa6oYgcjbgtFlGPDxuBlmcakp6ISbqPw4lTT3
 CShKdpRlx57wAr4N9W9am7M0d76YPG1OnDktq1d/nTkI3uuos5rpXoqxMuBFlRv5Cz5c
 1dVTLmw70BTxqfs5hQeHs+lXBaz0I9cLgawMg46dnQluE12W+vkrD5jcSommnuVVxZAS
 N+DMZXS87DaBYpR1NR6EzxNGr/evbSsMU+X2VN7DK9fqRQ5/7//YyAqza51BWFlTeebF
 VfC73Qek1HArqHu8oL8gvTYTGbDOC8lVndMjwSiHmtklOwEZBq1N8fMFOk36u3rJlIkc
 GrOw==
X-Gm-Message-State: AOJu0Ywpy7ka254AbM3Wx0ZLtAGCO95NmSioBW19fUNHNf/IZgWRoob2
 oyzHv1++iE7tY3Lv6x47sHtGOgNXZeS5DhMbhITBYAQkl+XLshye6yfrk2y4fNtxV+e+vF46T7G
 5W4Cvevr/aF5Uj+V9JP4IFM62vALPO1pbiLUuAv6bY9tI+HgY7xPR
X-Gm-Gg: ASbGncuv2pJ6RXVS14bikfHLbzGWrYE4XlHWJ/E7C6+bTiIevo35OD+bXqxVHm5VS+h
 naNaMPEwdS6vMQQo8vH3UI8mXveFyboeon95FK8CcW9eTK8BluwMo7Aa70CgZKWvtANyOc/CGfQ
 DALRUM+JdXtx5kG4BQ3XQR47a4kYX0fahQf5prY/i1k3wlHueKylo5/HH/X/4EzrnTwTEJEQDxT
 dU1gRfcrdwvQ3dDgR9pslTUtjYlYryy/0x6hBkTgrN93xrtj7U=
X-Received: by 2002:a05:6402:354c:b0:5cf:e71c:ff88 with SMTP id
 4fb4d7f45d1cf-5d972dfeb8bmr3665104a12.4.1736359863888; 
 Wed, 08 Jan 2025 10:11:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO/LHXjhXvKugSa60iDkb/Gsbb1+Gi0/mNIfAxuNmwWmnxQ1ayS6VfRyNU/Fdxexk0tZtNtw==
X-Received: by 2002:a05:6402:354c:b0:5cf:e71c:ff88 with SMTP id
 4fb4d7f45d1cf-5d972dfeb8bmr3665061a12.4.1736359863468; 
 Wed, 08 Jan 2025 10:11:03 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80701c9d7sm25440683a12.87.2025.01.08.10.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:11:01 -0800 (PST)
Date: Wed, 8 Jan 2025 13:10:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>
Subject: Re: [PATCH v1 15/19] memory: Add an API for ATS support
Message-ID: <20250108131034-mutt-send-email-mst@kernel.org>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
 <20241129074332.87535-16-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241129074332.87535-16-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 29, 2024 at 07:44:00AM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> IOMMU have to implement iommu_ats_request_translation to support ATS.
> 
> Devices can use IOMMU_TLB_ENTRY_TRANSLATION_ERROR to check the tlb
> entries returned by a translation request.
> 
> We decided not to use the existing translation operation for 2 reasons.
> First, ATS is designed to translate ranges and not isolated addresses.
> Second, we need ATS-specific parameters.
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>  include/exec/memory.h | 26 ++++++++++++++++++++++++++
>  system/memory.c       | 20 ++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index c0d064dbd8..14166e2874 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -148,6 +148,10 @@ struct IOMMUTLBEntry {
>      uint32_t         pasid;
>  };
>  
> +/* Check if an IOMMU TLB entry indicates a translation error */
> +#define IOMMU_TLB_ENTRY_TRANSLATION_ERROR(entry) ((((entry)->perm) & IOMMU_RW) \
> +                                                    == IOMMU_NONE)
> +
>  /*
>   * Bitmap for different IOMMUNotifier capabilities. Each notifier can
>   * register with one or multiple IOMMU Notifier capability bit(s).
> @@ -525,6 +529,20 @@ struct IOMMUMemoryRegionClass {
>       * @iommu: the IOMMUMemoryRegion
>       */
>      int (*num_indexes)(IOMMUMemoryRegion *iommu);
> +
> +    /**
> +     * @iommu_ats_request_translation:
> +     * This method must be implemented if the IOMMU has ATS enabled
> +     *
> +     * @see pci_ats_request_translation_pasid
> +     */
> +    ssize_t (*iommu_ats_request_translation)(IOMMUMemoryRegion *iommu,
> +                                             bool priv_req, bool exec_req,
> +                                             hwaddr addr, size_t length,
> +                                             bool no_write,
> +                                             IOMMUTLBEntry *result,
> +                                             size_t result_length,
> +                                             uint32_t *err_count);
>  };
>  
>  typedef struct RamDiscardListener RamDiscardListener;
> @@ -1883,6 +1901,14 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n);
>  void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>                                               IOMMUNotifier *n);
>  
> +ssize_t memory_region_iommu_ats_request_translation(IOMMUMemoryRegion *iommu_mr,
> +                                                bool priv_req, bool exec_req,
> +                                                hwaddr addr, size_t length,
> +                                                bool no_write,
> +                                                IOMMUTLBEntry *result,
> +                                                size_t result_length,
> +                                                uint32_t *err_count);
> +
>  /**
>   * memory_region_iommu_get_attr: return an IOMMU attr if get_attr() is
>   * defined on the IOMMU.
> diff --git a/system/memory.c b/system/memory.c
> index 85f6834cb3..7f6f3798e6 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2011,6 +2011,26 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>      memory_region_update_iommu_notify_flags(iommu_mr, NULL);
>  }
>  
> +ssize_t memory_region_iommu_ats_request_translation(IOMMUMemoryRegion *iommu_mr,
> +                                                    bool priv_req,
> +                                                    bool exec_req,
> +                                                    hwaddr addr, size_t length,
> +                                                    bool no_write,
> +                                                    IOMMUTLBEntry *result,
> +                                                    size_t result_length,
> +                                                    uint32_t *err_count)
> +{
> +    IOMMUMemoryRegionClass *imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
> +


line too long - just call the variable mr.

> +    if (!imrc->iommu_ats_request_translation) {
> +        return -ENODEV;
> +    }
> +
> +    return imrc->iommu_ats_request_translation(iommu_mr, priv_req, exec_req,
> +                                               addr, length, no_write, result,
> +                                               result_length, err_count);
> +}
> +
>  void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
>                                      const IOMMUTLBEvent *event)
>  {
> -- 
> 2.47.0


