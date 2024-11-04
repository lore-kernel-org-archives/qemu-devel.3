Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B489ED132D8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7yLt-0003zF-Jz; Mon, 04 Nov 2024 09:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7yLs-0003z6-H4
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:46:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7yLq-0004h9-Pr
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730731602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YDTy8XA3OstqsVTtIijI3rplLwNPGH2uRI8ow9w5L9w=;
 b=i8tU/gEcuQMA/4VHmT+myVq5kctg6mw1qxKRRVNkxAkSUQj2FZpa8KIbYL3/I6kJp2p/jn
 qXZFrRh4ifm4UjW6AjhHKF++njbJqWKtrP9UJGTOB0IwF4cW+uaTL1tI8LwdWd8DDpTyor
 hR9K+AwV6GamXUdQneu3n2ai4juYo+o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-AqVLIRIqNOi1bzIICl33Uw-1; Mon, 04 Nov 2024 09:46:41 -0500
X-MC-Unique: AqVLIRIqNOi1bzIICl33Uw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315b7b0c16so29774885e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730731599; x=1731336399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDTy8XA3OstqsVTtIijI3rplLwNPGH2uRI8ow9w5L9w=;
 b=c8GNB6fOvishtlGD0y7YABHPWeOmnfBgLvDAz+zljv9Vo+TImphHRHvFHEY0IjVF/Z
 oP9WMm0eJhFl93QRUSjgpZbmE9VBJrAzF9k8zRouzDja5qfrg/InD5Tl420+mzQrGYp8
 34ytIz7uzwwONxkZv5fbMSOlwYwZPjnoaKkCxE6IEo6lp29Ix6KPhI5WKZ3U3zKDLkM9
 eP/+QUy33fDDCwHQE7PopkZY7fjoBEPGsODxfT4dpvo2W36RzsKGcL2r4t288aOV905i
 2NQdYPE7QlmCF9Zdh++zrJ/nPHaY4ue6+RYBTQUc0lyaqjONzrBi8QAPqaDx3r9ndrJT
 yYbA==
X-Gm-Message-State: AOJu0Yzyih87o5Iuj6P4MvIoSbRJfiH0od5GeKeXCP5+b+JJ+8G4tsVt
 x9JFAlyvH0Va+vHpTNjmUyoSKrtIV7HvKBWqdJ8N3oY+9zQt6YqDrkcfzx+7v5SyinOsTCSFTkI
 V7ghdN5rzftryI3EAA+5q2IlSasQx8gL3312EQy8RtuPgQK3aUbcKdybL5Yuo
X-Received: by 2002:a5d:514c:0:b0:37e:d92f:c14a with SMTP id
 ffacd0b85a97d-380611e4a96mr22727959f8f.42.1730731599503; 
 Mon, 04 Nov 2024 06:46:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdtsH1SxuTNm9WR3r6su3dY0TgVlQ3BXEgbk7U8Q93J4P1LkUTk4vG2Cd08fv6HXX67f0Fyw==
X-Received: by 2002:a5d:514c:0:b0:37e:d92f:c14a with SMTP id
 ffacd0b85a97d-380611e4a96mr22727925f8f.42.1730731599040; 
 Mon, 04 Nov 2024 06:46:39 -0800 (PST)
Received: from redhat.com ([2a02:14f:177:aecb:5a54:cf63:d69d:19ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7e2dsm13372806f8f.11.2024.11.04.06.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 06:46:38 -0800 (PST)
Date: Mon, 4 Nov 2024 09:46:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Message-ID: <20241104094606-mutt-send-email-mst@kernel.org>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104125536.1236118-3-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 04, 2024 at 08:55:35PM +0800, Zhenzhong Duan wrote:
> According to VTD spec, a 256-bit descriptor will result in an invalid
> descriptor error if submitted in an IQ that is setup to provide hardware
> with 128-bit descriptors (IQA_REG.DW=0). Meanwhile, there are old inv desc
> types (e.g. iotlb_inv_desc) that can be either 128bits or 256bits. If a
> 128-bit version of this descriptor is submitted into an IQ that is setup
> to provide hardware with 256-bit descriptors will also result in an invalid
> descriptor error.
> 
> The 2nd will be captured by the tail register update. So we only need to
> focus on the 1st.
> 
> Because the reserved bit check between different types of invalidation desc
> are common, so introduce a common function vtd_inv_desc_reserved_check()
> to do all the checks and pass the differences as parameters.
> 
> With this change, need to replace error_report_once() call with error_report()
> to catch different call sites. This isn't an issue as error_report_once()
> here is mainly used to help debug guest error, but it only dumps once in
> qemu life cycle and doesn't help much, we need error_report() instead.
> 
> Fixes: c0c1d351849b ("intel_iommu: add 256 bits qi_desc support")
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  1 +
>  hw/i386/intel_iommu.c          | 80 ++++++++++++++++++++++++----------
>  2 files changed, 59 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 2f9bc0147d..75ccd501b0 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -356,6 +356,7 @@ union VTDInvDesc {
>  typedef union VTDInvDesc VTDInvDesc;
>  
>  /* Masks for struct VTDInvDesc */
> +#define VTD_INV_DESC_ALL_ONE            -1ULL
>  #define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
>                                           ((val) & 0xfULL))
>  #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalidate Desc */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1ecfe47963..2fc3866433 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2532,15 +2532,51 @@ static bool vtd_get_inv_desc(IntelIOMMUState *s,
>      return true;
>  }
>  
> +static bool vtd_inv_desc_reserved_check(IntelIOMMUState *s,
> +                                        VTDInvDesc *inv_desc,
> +                                        uint64_t mask[4], bool dw,
> +                                        const char *func_name,
> +                                        const char *desc_type)
> +{
> +    if (s->iq_dw) {
> +        if (inv_desc->val[0] & mask[0] || inv_desc->val[1] & mask[1] ||
> +            inv_desc->val[2] & mask[2] || inv_desc->val[3] & mask[3]) {
> +            error_report("%s: invalid %s desc val[3]: 0x%"PRIx64
> +                         " val[2]: 0x%"PRIx64" val[1]=0x%"PRIx64
> +                         " val[0]=0x%"PRIx64" (reserved nonzero)",
> +                         func_name, desc_type, inv_desc->val[3],
> +                         inv_desc->val[2], inv_desc->val[1],
> +                         inv_desc->val[0]);

Hmm.
But these are guest errors.
should all these actually be

qemu_log_mask(LOG_GUEST_ERROR, ...)


?


> +            return false;
> +        }
> +    } else {
> +        if (dw) {
> +            error_report("%s: 256-bit %s desc in 128-bit invalidation queue",
> +                         func_name, desc_type);
> +            return false;
> +        }
> +
> +        if (inv_desc->lo & mask[0] || inv_desc->hi & mask[1]) {
> +            error_report("%s: invalid %s desc: hi=%"PRIx64", lo=%"PRIx64
> +                         " (reserved nonzero)", func_name, desc_type,
> +                         inv_desc->hi, inv_desc->lo);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>  {
> -    if ((inv_desc->hi & VTD_INV_DESC_WAIT_RSVD_HI) ||
> -        (inv_desc->lo & VTD_INV_DESC_WAIT_RSVD_LO)) {
> -        error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
> -                          " (reserved nonzero)", __func__, inv_desc->hi,
> -                          inv_desc->lo);
> +    uint64_t mask[4] = {VTD_INV_DESC_WAIT_RSVD_LO, VTD_INV_DESC_WAIT_RSVD_HI,
> +                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
> +
> +    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
> +                                     __func__, "wait")) {
>          return false;
>      }
> +
>      if (inv_desc->lo & VTD_INV_DESC_WAIT_SW) {
>          /* Status Write */
>          uint32_t status_data = (uint32_t)(inv_desc->lo >>
> @@ -2574,13 +2610,14 @@ static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
>                                             VTDInvDesc *inv_desc)
>  {
>      uint16_t sid, fmask;
> +    uint64_t mask[4] = {VTD_INV_DESC_CC_RSVD, VTD_INV_DESC_ALL_ONE,
> +                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
>  
> -    if ((inv_desc->lo & VTD_INV_DESC_CC_RSVD) || inv_desc->hi) {
> -        error_report_once("%s: invalid cc inv desc: hi=%"PRIx64", lo=%"PRIx64
> -                          " (reserved nonzero)", __func__, inv_desc->hi,
> -                          inv_desc->lo);
> +    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
> +                                     __func__, "cc inv")) {
>          return false;
>      }
> +
>      switch (inv_desc->lo & VTD_INV_DESC_CC_G) {
>      case VTD_INV_DESC_CC_DOMAIN:
>          trace_vtd_inv_desc_cc_domain(
> @@ -2610,12 +2647,11 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>      uint16_t domain_id;
>      uint8_t am;
>      hwaddr addr;
> +    uint64_t mask[4] = {VTD_INV_DESC_IOTLB_RSVD_LO, VTD_INV_DESC_IOTLB_RSVD_HI,
> +                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
>  
> -    if ((inv_desc->lo & VTD_INV_DESC_IOTLB_RSVD_LO) ||
> -        (inv_desc->hi & VTD_INV_DESC_IOTLB_RSVD_HI)) {
> -        error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
> -                          ", lo=0x%"PRIx64" (reserved bits unzero)",
> -                          __func__, inv_desc->hi, inv_desc->lo);
> +    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
> +                                     __func__, "iotlb inv")) {
>          return false;
>      }
>  
> @@ -2705,19 +2741,19 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
>      hwaddr addr;
>      uint16_t sid;
>      bool size;
> +    uint64_t mask[4] = {VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO,
> +                        VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI,
> +                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
> +
> +    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
> +                                     __func__, "dev-iotlb inv")) {
> +        return false;
> +    }
>  
>      addr = VTD_INV_DESC_DEVICE_IOTLB_ADDR(inv_desc->hi);
>      sid = VTD_INV_DESC_DEVICE_IOTLB_SID(inv_desc->lo);
>      size = VTD_INV_DESC_DEVICE_IOTLB_SIZE(inv_desc->hi);
>  
> -    if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
> -        (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
> -        error_report_once("%s: invalid dev-iotlb inv desc: hi=%"PRIx64
> -                          ", lo=%"PRIx64" (reserved nonzero)", __func__,
> -                          inv_desc->hi, inv_desc->lo);
> -        return false;
> -    }
> -
>      /*
>       * Using sid is OK since the guest should have finished the
>       * initialization of both the bus and device.
> -- 
> 2.34.1


