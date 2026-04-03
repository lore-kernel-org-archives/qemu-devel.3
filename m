Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C7DE7E35C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8avp-00017T-Gb; Fri, 03 Apr 2026 05:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8avm-0000wI-PC
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8avj-00014u-QZ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775208901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IeRLDPiTClc78EfTQbw+Zj4UU+J9GsP8qS7u3cxNpbo=;
 b=PVtHHEBaeshPBnkph0j91TWmtxXadAs5DG41qtEArZps+d24vkQi+JvBubU/xryc00YLEK
 lG8KXtQlh0dFWIsnwVSJM/unRf/7MEUPf78izR/AyTIM8ZHVyErcLnkv8AZdxHVrljelMS
 Hv4dylX0YETvCixKRhQP+NTtESUuqQ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-dh2tCCfVP0SY8IHPv8zZ4A-1; Fri, 03 Apr 2026 05:34:59 -0400
X-MC-Unique: dh2tCCfVP0SY8IHPv8zZ4A-1
X-Mimecast-MFC-AGG-ID: dh2tCCfVP0SY8IHPv8zZ4A_1775208899
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b99add7f3so1233598f8f.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775208898; x=1775813698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=IeRLDPiTClc78EfTQbw+Zj4UU+J9GsP8qS7u3cxNpbo=;
 b=lJT7vn1CcM0lbwg4acByg4ilMKMEzW+oQlZ+kiPDMTveHfABjV1PYawnY0ABL151rw
 0ZxaSNCyXbr3Dza6TZJfT5Cjw0Pnl9/lzD+guWDNkjD9gs+RIyhL0K+gwOKOTosygFM7
 13wnN0lchHM5WW2c2fD59sy3v9H7/eiEDXKkRSVELmtaqi4yK/BSsw1n7z5YL6G6TIn1
 TJSJzGH8vZa8XwGjtcKRg5OyH36maHxXUse7tQh07kBdF5lZh2JEWpHYZRrQLAcqRuv0
 sWUsilHic7CYQnM9/EcWO1i7j9rA3h+mBfFNVxqmMaMtpaC14QZfFuoYwz2228nvJ8u0
 qLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775208898; x=1775813698;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeRLDPiTClc78EfTQbw+Zj4UU+J9GsP8qS7u3cxNpbo=;
 b=cLHrJV0WQaGz426ZnbAlD5O6jOabD5tgHexgDiXoa94o0SH/owFymDvPjFhfRikEBN
 DU0h4uDqBWaSlh6N4ActDLL+kbWDulU7d406qa/3JbpRTs5RoQ146o1KICDmJqClj3r2
 oqJPo2o+E5ErCeNxi87ym2q1schafLgwa4/1NHGcqntKltPazPxYsXhasvtoeBZkRbgy
 tMW1brKEahGNiV//9CKMABnEqERgGY+SQhDP+yQCd91B+8m/VtAB7D4Q/Wk/lWK4PuNL
 1YL6SPj4LxfgZ2WVJrnsOY9B0xqd0K4oFvCQFr+Ktk2o2dY7uyQ+XTz6m+7E/FNugapZ
 Np2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCycpVrHoOqkz0KYSOYdCXYU18FFfPNtLkApIyZpmPl2PY2JwPT6xFbfznCctGlHZTqKaa4gN1hWoE@nongnu.org
X-Gm-Message-State: AOJu0YzO8WwpawEKilbWc6B9pAaxFdRIDORtLMjpmb9Kci/IFTlC/00I
 PquJ9ttxwa9W8j/30fhAfK7Jm85cjyLga+vhYsp9zdjo30Yv16SSb6pb+ScDklRcC9yAkKcU+cY
 SQbs80YVcdZhxhjCw5f4y3n4GnYcC80ngN5/JRYqITvkYDJjA9FjzPIyv
X-Gm-Gg: AeBDiet81Acqkm5LSdiJPqNGt5WvC3H/z+IBwroK14g3x2IbQmXTQCXB7ICL4aLwQCR
 3umjjmz/TJTCohZHWWuygwkcpR36I8R87iiVVKzzR6Tnh0g1PaiLV1UUMjFdzbNCzuFKLAWo5yT
 LIEhaT/VRVDMZDSOPRdTd7oOP8IDzO2AMmYHlRBnHkDD/mEuW9RUhyXxj0IZYP6B2pyLcB3dAbx
 IaZ2+QdcaMPyfbSgsfRn32Ga3qK6zMF9F7EWn/I9e7b8FVG7SNc8TbIwIh8EvL3QVeSvhA1pq05
 f4jXrArmCIc5i5qHkT1KWOI2I5qboLL9RFyFyFJcUokLGJjQjszEmgUvyAEso8TFkEi813HHIMx
 h9UKPOYXoc2K8ztNbChMVEwejwyXSfVhqYXdftINonHwy6oM4mlfOyRFKJNDz
X-Received: by 2002:adf:f482:0:b0:43d:2f10:511f with SMTP id
 ffacd0b85a97d-43d2f105374mr407672f8f.0.1775208898366; 
 Fri, 03 Apr 2026 02:34:58 -0700 (PDT)
X-Received: by 2002:adf:f482:0:b0:43d:2f10:511f with SMTP id
 ffacd0b85a97d-43d2f105374mr407619f8f.0.1775208897820; 
 Fri, 03 Apr 2026 02:34:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f843dsm13978627f8f.37.2026.04.03.02.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 02:34:57 -0700 (PDT)
Message-ID: <51644344-1805-4809-831d-77663d181d83@redhat.com>
Date: Fri, 3 Apr 2026 11:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, qemu-arm@nongnu.org
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-3-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260403035541.18355-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/3/26 05:55, Zhenzhong Duan wrote:
> Same for the two wrappers and their call sites.
> 
> Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   include/system/iommufd.h    | 16 +++++++++++-----
>   backends/iommufd.c          |  9 +++++----
>   hw/arm/smmuv3-accel.c       | 12 ++++++++----
>   hw/i386/intel_iommu_accel.c | 19 ++++++++++---------
>   hw/vfio/iommufd.c           | 10 +++++-----
>   5 files changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 2925d116ac..da98e79439 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
>        *
>        * @hiodi: host IOMMU device backed by IOMMUFD backend.
>        *
> +     * @pasid: target pasid of the device to be attached.
> +     *
>        * @hwpt_id: ID of IOMMUFD hardware page table.
>        *
>        * @errp: pass an Error out when attachment fails.
>        *
>        * Returns: true on success, false on failure.
>        */
> -    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, uint32_t hwpt_id,
> -                        Error **errp);
> +    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, uint32_t pasid,
> +                        uint32_t hwpt_id, Error **errp);
>       /**
>        * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
>        * VFIO and VDPA device can have different implementation.
> @@ -154,15 +156,19 @@ struct HostIOMMUDeviceIOMMUFDClass {
>        *
>        * @hiodi: host IOMMU device backed by IOMMUFD backend.
>        *
> +     * @pasid: target pasid of the device to be detached.
> +     *
>        * @errp: pass an Error out when attachment fails.
>        *
>        * Returns: true on success, false on failure.
>        */
> -    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, Error **errp);
> +    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, uint32_t pasid,
> +                        Error **errp);
>   };
>   
>   bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
> -                                           uint32_t hwpt_id, Error **errp);
> -bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
> +                                           uint32_t pasid, uint32_t hwpt_id,
>                                              Error **errp);
> +bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
> +                                           uint32_t pasid, Error **errp);
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 410b044370..cfde6f2b2c 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -539,23 +539,24 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
>   }
>   
>   bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
> -                                           uint32_t hwpt_id, Error **errp)
> +                                           uint32_t pasid, uint32_t hwpt_id,
> +                                           Error **errp)
>   {
>       HostIOMMUDeviceIOMMUFDClass *hiodic =
>           HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(hiodi);
>   
>       g_assert(hiodic->attach_hwpt);
> -    return hiodic->attach_hwpt(hiodi, hwpt_id, errp);
> +    return hiodic->attach_hwpt(hiodi, pasid, hwpt_id, errp);
>   }
>   
>   bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
> -                                           Error **errp)
> +                                           uint32_t pasid, Error **errp)
>   {
>       HostIOMMUDeviceIOMMUFDClass *hiodic =
>           HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(hiodi);
>   
>       g_assert(hiodic->detach_hwpt);
> -    return hiodic->detach_hwpt(hiodi, errp);
> +    return hiodic->detach_hwpt(hiodi, pasid, errp);
>   }
>   
>   static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 3630078751..3201bb25af 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -300,7 +300,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>           return false;
>       }
>   
> -    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp)) {
> +    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID, hwpt_id,
> +                                               errp)) {
>           if (s1_hwpt) {
>               iommufd_backend_free_id(hiodi->iommufd, s1_hwpt->hwpt_id);
>               g_free(s1_hwpt);
> @@ -575,7 +576,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
>   
>       /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
>       hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
> -    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp)) {
> +    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID, hwpt_id,
> +                                               errp)) {
>           goto free_veventq;
>       }
>       return true;
> @@ -665,7 +667,8 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>       hiodi = accel_dev->hiodi;
>       accel = accel_dev->s_accel;
>       /* Re-attach the default s2 hwpt id */
> -    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hiodi->hwpt_id, NULL)) {
> +    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID,
> +                                               hiodi->hwpt_id, NULL)) {
>           error_report("Unable to attach the default HW pagetable: hiodi devid "
>                        "0x%x", hiodi->devid);
>       }
> @@ -879,7 +882,8 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
>   
>       hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
>       QLIST_FOREACH(accel_dev, &accel->device_list, next) {
> -        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->hiodi, hwpt_id,
> +        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->hiodi,
> +                                                   IOMMU_NO_PASID, hwpt_id,
>                                                      &local_err)) {
>               error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
>                                 "hiodi devid %u", hwpt_id,
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index ed3793602b..3217a2afac 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -121,8 +121,9 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>           }
>       }
>   
> -    ret = host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp);
> -    trace_vtd_device_attach_hwpt(hiodi->devid, vtd_as->pasid, hwpt_id, ret);
> +    ret = host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID, hwpt_id,
> +                                                errp);
> +    trace_vtd_device_attach_hwpt(hiodi->devid, IOMMU_NO_PASID, hwpt_id, ret);
>       if (ret) {
>           /* Destroy old fs_hwpt if it's a replacement */
>           vtd_destroy_old_fs_hwpt(hiodi, vtd_as);
> @@ -141,22 +142,22 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>   {
>       HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       IntelIOMMUState *s = vtd_as->iommu_state;
> -    uint32_t pasid = vtd_as->pasid;
>       bool ret;
>   
>       if (s->dmar_enabled && s->root_scalable) {
> -        ret = host_iommu_device_iommufd_detach_hwpt(hiodi, errp);
> -        trace_vtd_device_detach_hwpt(hiodi->devid, pasid, ret);
> +        ret = host_iommu_device_iommufd_detach_hwpt(hiodi, IOMMU_NO_PASID,
> +                                                    errp);
> +        trace_vtd_device_detach_hwpt(hiodi->devid, IOMMU_NO_PASID, ret);
>       } else {
>           /*
>            * If DMAR remapping is disabled or guest switches to legacy mode,
>            * we fallback to the default HWPT which contains shadow page table.
>            * So guest DMA could still work.
>            */
> -        ret = host_iommu_device_iommufd_attach_hwpt(hiodi, hiodi->hwpt_id,
> -                                                    errp);
> -        trace_vtd_device_reattach_def_hwpt(hiodi->devid, pasid, hiodi->hwpt_id,
> -                                           ret);
> +        ret = host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID,
> +                                                    hiodi->hwpt_id, errp);
> +        trace_vtd_device_reattach_def_hwpt(hiodi->devid, IOMMU_NO_PASID,
> +                                           hiodi->hwpt_id, ret);
>       }
>   
>       if (ret) {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index f020b56208..ecabc33064 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -927,21 +927,21 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
>   
>   static bool
>   host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
> -                                           uint32_t hwpt_id, Error **errp)
> +                                           uint32_t pasid, uint32_t hwpt_id,
> +                                           Error **errp)
>   {
>       VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
>   
> -    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
> -                                                hwpt_id, errp);
> +    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, pasid, hwpt_id, errp);
>   }
>   
>   static bool
>   host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
> -                                           Error **errp)
> +                                           uint32_t pasid, Error **errp)
>   {
>       VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
>   
> -    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, errp);
> +    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, pasid, errp);
>   }
>   
>   static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,


