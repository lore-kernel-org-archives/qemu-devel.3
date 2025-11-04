Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250E0CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 11:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGErD-00082r-B0; Tue, 04 Nov 2025 06:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGEr9-00082V-G0
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGEr6-0003PM-5N
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762254339;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7GjGt6L+B5t4neiSwCTkQBTpy3wFSKYPXCWBla0q8U=;
 b=U1JmfE6bW5XeLj16f+iTW/N6PgbXlgXf0KgoTl+ClznwcbIHO/XVsZ+VQzAZj3XCmBi4Sb
 kTOC5M4SSwaZKYqttTaXrH5UHq3bukgeXOBSQ8oPbZoIRlH5CYtr6C64rMg4/9+P3Danb+
 LbXRn+Qex1tW+/255MZWVj2XGNCPKoQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-9p8MgxspODm7kDH5zDl89w-1; Tue, 04 Nov 2025 06:05:38 -0500
X-MC-Unique: 9p8MgxspODm7kDH5zDl89w-1
X-Mimecast-MFC-AGG-ID: 9p8MgxspODm7kDH5zDl89w_1762254337
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477563e531cso4964085e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 03:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762254337; x=1762859137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E7GjGt6L+B5t4neiSwCTkQBTpy3wFSKYPXCWBla0q8U=;
 b=dicxeKTICQUenMKfRNl9AFfvMBbbY5eIOJ7+0aThH+83CWA/cxo/DqWZ/DmrUEsuok
 fZy968XWrA8RyUqcWRMNnrLYtQH/vHJZmSDwaSIEFQ3dcjDkaVKuM+gtlpOkbVq5qXRv
 k6yltD5P4sfPB1zVaQfDKe9OwVF3CX9YS3Pn+dLHltuu8olR/bYmA8SI8TBr+gisRc3W
 ZAodrLbHN5uN4XBjqFGmAzaqo1jBKF9o6lX/XC/Ew+qmjzGEzo+KGagIOy655I11Rbuv
 KAMJy7iE+Mna8IkaI7jDvrmeMBt28+1snDEF3uMtfTMSXBSgexF4LWMJosUQgfePDglJ
 rqHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbk50TifDp4NIEeumGpctolutIz/ejYfFLTf0L/lTMywBZZe49UFw/EaUrZLvxuSJKt6yndoxVSjb2@nongnu.org
X-Gm-Message-State: AOJu0Yyf+K46m/zqMH7ovJHgDXqgfCFGtwgKtfjEqLODUgcqrVK/s0zh
 6l6agYsnaSURd88iDtDyLOJrXPEPDefne1xYUUXdeKQMgEy8PrpsD/WxLNall0IjjylSxdHzotF
 mPnlmsNV0pbusII2AiIF9Cl+5NbN9QMI5f46RflsGhGctHV0Fk33rs1Bg
X-Gm-Gg: ASbGncv5KPDL8eKTIJ7qWzd72FgBzZLT4sEX1OeBxlzJmdtf3rjbHOITZoi45tF26Zs
 mTlHIQ2ngPaPyLkIb0yL32teZpCOd4Cssprq22O/xb9vGcl9sGOb/ZodS/9Ymio4UEOb9uwezoU
 ie9la9QBxLk7DappXB4tdgmMLZ+OlBLvY50R4/kP6kzJ8ezXn8opSItGlspEG01eD8StS0adsdi
 V+sy6u0JIIhf4Ow3jxcDKqUEu+W/7zqP/41r18YQeZAU7+R0qTQDNid2aKkomTd+DZzxA4ffm/R
 fHbZTUI5dXMwVVteUzT2XUCaUsF1Q7Qr1bKgcL03Cr7yUpBlCTl+9ae2nbm7ohKeq6MpGLTLnU+
 t2tOtjaXQYfCwa1zHCAfNT+XnQv8XsHH22tqCkiLRyByU5A==
X-Received: by 2002:a05:600c:4ece:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-4773087b2dbmr136719155e9.24.1762254336582; 
 Tue, 04 Nov 2025 03:05:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9UFDNwNgiRpYBVWhh17JDsY3zMuRSW4YoXaJbAdGlDr2U5HdOWTziROmkW+zfZeybAcsecQ==
X-Received: by 2002:a05:600c:4ece:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-4773087b2dbmr136718765e9.24.1762254336032; 
 Tue, 04 Nov 2025 03:05:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1f5bc0sm4109155f8f.29.2025.11.04.03.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 03:05:35 -0800 (PST)
Message-ID: <987614d8-de6b-4cb5-b5a8-1723e24502f3@redhat.com>
Date: Tue, 4 Nov 2025 12:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/32] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-14-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-14-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Shameer,

On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> A device placed behind a vSMMU instance must have corresponding vSTEs
> (bypass, abort, or translate) installed. The bypass and abort proxy nested
> HWPTs are pre-allocated.
>
> For translat HWPT, a vDEVICE object is allocated and associated with the
> vIOMMU for each guest device. This allows the host kernel to establish a
> virtual SID to physical SID mapping, which is required for handling
> invalidations and event reporting.
>
> An translate HWPT is allocated based on the guest STE configuration and
> attached to the device when the guest issues SMMU_CMD_CFGI_STE or
> SMMU_CMD_CFGI_STE_RANGE, provided the STE enables S1 translation.
>
> If the guest STE is invalid or S1 translation is disabled, the device is
> attached to one of the pre-allocated ABORT or BYPASS HWPTs instead.
>
> While at it, export both smmu_find_ste() and smmuv3_flush_config() for
> use here.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    | 193 +++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h    |  23 +++++
>  hw/arm/smmuv3-internal.h |  20 ++++
>  hw/arm/smmuv3.c          |  18 +++-
>  hw/arm/trace-events      |   2 +
>  5 files changed, 253 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index d4d65299a8..c74e95a0ea 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -28,6 +28,191 @@ MemoryRegion root;
>  MemoryRegion sysmem;
>  static AddressSpace *shared_as_sysmem;
>  
> +static bool
> +smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
> +{
> +    SMMUViommu *vsmmu = accel_dev->vsmmu;
> +    IOMMUFDVdev *vdev;
> +    uint32_t vdevice_id;
> +
> +    if (!accel_dev->idev || accel_dev->vdev) {
> +        return true;
> +    }
> +
> +    if (!iommufd_backend_alloc_vdev(vsmmu->iommufd, accel_dev->idev->devid,
> +                                    vsmmu->viommu.viommu_id, sid,
> +                                    &vdevice_id, errp)) {
> +            return false;
> +    }
> +    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> +                                               vsmmu->bypass_hwpt_id, errp)) {
> +        iommufd_backend_free_id(vsmmu->iommufd, vdevice_id);
> +        return false;
> +    }
> +
> +    vdev = g_new(IOMMUFDVdev, 1);
> +    vdev->vdevice_id = vdevice_id;
> +    vdev->virt_id = sid;
> +    accel_dev->vdev = vdev;
> +    return true;
> +}
> +
> +static bool
> +smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort,
> +                                      Error **errp)+{
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    uint32_t hwpt_id;
> +
> +    if (!s1_hwpt || !accel_dev->vsmmu) {
> +        return true;
> +    }
> +
> +    if (abort) {
> +        hwpt_id = accel_dev->vsmmu->abort_hwpt_id;
> +    } else {
> +        hwpt_id = accel_dev->vsmmu->bypass_hwpt_id;
> +    }
> +
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> +        return false;
> +    }
> +    trace_smmuv3_accel_uninstall_nested_ste(smmu_get_sid(&accel_dev->sdev),
> +                                            abort ? "abort" : "bypass",
> +                                            hwpt_id);
> +
> +    iommufd_backend_free_id(s1_hwpt->iommufd, s1_hwpt->hwpt_id);
> +    accel_dev->s1_hwpt = NULL;
> +    g_free(s1_hwpt);
> +    return true;
> +}
> +
> +static bool
> +smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
> +                                    uint32_t data_type, uint32_t data_len,
> +                                    void *data, Error **errp)
the name is very close to the caller function, ie.
smmuv3_accel_install_nested_ste which also takes a sdev.
I would rename to smmuv3_accel_install_hwpt() or something alike
> +{
> +    SMMUViommu *vsmmu = accel_dev->vsmmu;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    uint32_t flags = 0;
> +
> +    if (!idev || !vsmmu) {
> +        error_setg(errp, "Device 0x%x has no associated IOMMU dev or vIOMMU",
> +                   smmu_get_sid(&accel_dev->sdev));
> +        return false;
> +    }
> +
> +    if (s1_hwpt) {
> +        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev, true, errp)) {
> +            return false;
> +        }
> +    }
> +
> +    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
> +    s1_hwpt->iommufd = idev->iommufd;
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    vsmmu->viommu.viommu_id, flags,
> +                                    data_type, data_len, data,
> +                                    &s1_hwpt->hwpt_id, errp)) {
> +        return false;
> +    }
> +
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, s1_hwpt->hwpt_id, errp)) {
> +        iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
> +        return false;
> +    }
> +    accel_dev->s1_hwpt = s1_hwpt;
> +    return true;
> +}
> +
> +bool
> +smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> +                                Error **errp)
> +{
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
> +                           .inval_ste_allowed = true};
> +    struct iommu_hwpt_arm_smmuv3 nested_data = {};
> +    uint64_t ste_0, ste_1;
> +    uint32_t config;
> +    STE ste;
> +    int ret;
> +
> +    if (!s->accel) {
don't you want to check !s->vsmmu as well done in
smmuv3_accel_install_nested_ste_range()
> +        return true;
> +    }
> +
> +    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    if (!accel_dev->vsmmu) {
> +        return true;
> +    }
> +
> +    if (!smmuv3_accel_alloc_vdev(accel_dev, sid, errp)) {
> +        return false;
> +    }
> +
> +    ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
> +    if (ret) {
> +        error_setg(errp, "Failed to find STE for Device 0x%x", sid);
> +        return true;
returning true while setting errp looks wrong to me.
> +    }
> +
> +    config = STE_CONFIG(&ste);
> +    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
> +        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev,
> +                                                   STE_CFG_ABORT(config),
> +                                                   errp)) {
> +            return false;
> +        }
> +        smmuv3_flush_config(sdev);
> +        return true;
> +    }
> +
> +    ste_0 = (uint64_t)ste.word[0] | (uint64_t)ste.word[1] << 32;
> +    ste_1 = (uint64_t)ste.word[2] | (uint64_t)ste.word[3] << 32;
> +    nested_data.ste[0] = cpu_to_le64(ste_0 & STE0_MASK);
> +    nested_data.ste[1] = cpu_to_le64(ste_1 & STE1_MASK);
> +
> +    if (!smmuv3_accel_dev_install_nested_ste(accel_dev,
> +                                             IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                             sizeof(nested_data),
> +                                             &nested_data, errp)) {
> +        error_append_hint(errp, "Unable to install sid=0x%x nested STE="
> +                          "0x%"PRIx64":=0x%"PRIx64"", sid,
nit: why ":=" between both 64b?
> +                          (uint64_t)le64_to_cpu(nested_data.ste[1]),
> +                          (uint64_t)le64_to_cpu(nested_data.ste[0]));
> +        return false;
in case of various failure cases, do we need to free the vdev?
> +    }
> +    trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
> +                                          nested_data.ste[0]);
> +    return true;
> +}
> +
> +bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> +                                           Error **errp)
> +{
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    SMMUv3AccelDevice *accel_dev;
> +
> +    if (!s_accel || !s_accel->vsmmu) {
> +        return true;
> +    }
> +
> +    QLIST_FOREACH(accel_dev, &s_accel->vsmmu->device_list, next) {
> +        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
> +
> +        if (sid >= range->start && sid <= range->end) {
> +            if (!smmuv3_accel_install_nested_ste(s, &accel_dev->sdev,
> +                                                 sid, errp)) {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>                                                 PCIBus *bus, int devfn)
>  {
> @@ -154,6 +339,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      SMMUv3State *s = ARM_SMMUV3(bs);
>      SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
>      SMMUv3AccelDevice *accel_dev;
> +    IOMMUFDVdev *vdev;
>      SMMUViommu *vsmmu;
>      SMMUDevice *sdev;
>      uint16_t sid;
> @@ -182,6 +368,13 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      trace_smmuv3_accel_unset_iommu_device(devfn, sid);
>  
>      vsmmu = s->s_accel->vsmmu;
> +    vdev = accel_dev->vdev;
> +    if (vdev) {
> +        iommufd_backend_free_id(vsmmu->iommufd, vdev->vdevice_id);
> +        g_free(vdev);
> +        accel_dev->vdev = NULL;
> +    }
> +
>      if (QLIST_EMPTY(&vsmmu->device_list)) {
>          iommufd_backend_free_id(vsmmu->iommufd, vsmmu->bypass_hwpt_id);
>          iommufd_backend_free_id(vsmmu->iommufd, vsmmu->abort_hwpt_id);
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index d81f90c32c..73b44cd7be 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -27,9 +27,16 @@ typedef struct SMMUViommu {
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
>  } SMMUViommu;
>  
> +typedef struct SMMUS1Hwpt {
> +    IOMMUFDBackend *iommufd;
> +    uint32_t hwpt_id;
> +} SMMUS1Hwpt;
> +
>  typedef struct SMMUv3AccelDevice {
>      SMMUDevice sdev;
>      HostIOMMUDeviceIOMMUFD *idev;
> +    SMMUS1Hwpt *s1_hwpt;
> +    IOMMUFDVdev *vdev;
>      SMMUViommu *vsmmu;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
> @@ -40,10 +47,26 @@ typedef struct SMMUv3AccelState {
>  
>  #ifdef CONFIG_ARM_SMMUV3_ACCEL
>  void smmuv3_accel_init(SMMUv3State *s);
> +bool smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> +                                     Error **errp);
> +bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> +                                           Error **errp);
>  #else
>  static inline void smmuv3_accel_init(SMMUv3State *s)
>  {
>  }
> +static inline bool
> +smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> +                                Error **errp)
> +{
> +    return true;
> +}
> +static inline bool
> +smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> +                                      Error **errp)
> +{
> +    return true;
> +}
>  #endif
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 03d86cfc5c..5fd88b4257 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -547,6 +547,9 @@ typedef struct CD {
>      uint32_t word[16];
>  } CD;
>  
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
> +void smmuv3_flush_config(SMMUDevice *sdev);
> +
>  /* STE fields */
>  
>  #define STE_VALID(x)   extract32((x)->word[0], 0, 1)
> @@ -586,6 +589,23 @@ typedef struct CD {
>  #define SMMU_STE_VALID      (1ULL << 0)
>  #define SMMU_STE_CFG_BYPASS (1ULL << 3)
>  
> +#define STE0_V       MAKE_64BIT_MASK(0, 1)
> +#define STE0_CONFIG  MAKE_64BIT_MASK(1, 3)
> +#define STE0_S1FMT   MAKE_64BIT_MASK(4, 2)
> +#define STE0_CTXPTR  MAKE_64BIT_MASK(6, 50)
> +#define STE0_S1CDMAX MAKE_64BIT_MASK(59, 5)
> +#define STE0_MASK    (STE0_S1CDMAX | STE0_CTXPTR | STE0_S1FMT | STE0_CONFIG | \
> +                      STE0_V)
> +
> +#define STE1_S1DSS    MAKE_64BIT_MASK(0, 2)
> +#define STE1_S1CIR    MAKE_64BIT_MASK(2, 2)
> +#define STE1_S1COR    MAKE_64BIT_MASK(4, 2)
> +#define STE1_S1CSH    MAKE_64BIT_MASK(6, 2)
> +#define STE1_S1STALLD MAKE_64BIT_MASK(27, 1)
> +#define STE1_EATS     MAKE_64BIT_MASK(28, 2)
> +#define STE1_MASK     (STE1_EATS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
> +                       STE1_S1CIR | STE1_S1DSS)
> +
>  #define SMMU_GBPA_ABORT (1UL << 20)
>  
>  static inline int oas2bits(int oas_field)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ef991cb7d8..1fd8aaa0c7 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -630,8 +630,7 @@ bad_ste:
>   * Supports linear and 2-level stream table
>   * Return 0 on success, -EINVAL otherwise
>   */
> -static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> -                         SMMUEventInfo *event)
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
>  {
>      dma_addr_t addr, strtab_base;
>      uint32_t log2size;
> @@ -900,7 +899,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>      return cfg;
>  }
>  
> -static void smmuv3_flush_config(SMMUDevice *sdev)
> +void smmuv3_flush_config(SMMUDevice *sdev)
>  {
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
> @@ -1330,6 +1329,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          {
>              uint32_t sid = CMD_SID(&cmd);
>              SMMUDevice *sdev = smmu_find_sdev(bs, sid);
> +            Error *local_err = NULL;
>  
>              if (CMD_SSEC(&cmd)) {
>                  cmd_error = SMMU_CERROR_ILL;
> @@ -1341,6 +1341,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              }
>  
>              trace_smmuv3_cmdq_cfgi_ste(sid);
> +            if (!smmuv3_accel_install_nested_ste(s, sdev, sid, &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              smmuv3_flush_config(sdev);
>  
>              break;
> @@ -1350,6 +1355,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              uint32_t sid = CMD_SID(&cmd), mask;
>              uint8_t range = CMD_STE_RANGE(&cmd);
>              SMMUSIDRange sid_range;
> +            Error *local_err = NULL;
>  
>              if (CMD_SSEC(&cmd)) {
>                  cmd_error = SMMU_CERROR_ILL;
> @@ -1361,6 +1367,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              sid_range.end = sid_range.start + mask;
>  
>              trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
> +            if (!smmuv3_accel_install_nested_ste_range(s, &sid_range,
> +                                                       &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              smmu_configs_inv_sid_range(bs, sid_range);
>              break;
>          }
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 49c0460f30..2e0b1f8f6f 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -69,6 +69,8 @@ smmu_reset_exit(void) ""
>  #smmuv3-accel.c
>  smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (idev devid=0x%x)"
>  smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (idev devid=0x%x)"
> +smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
> +smmuv3_accel_uninstall_nested_ste(uint32_t sid, const char *ste_cfg, uint32_t hwpt_id) "sid=%d attached %s hwpt_id=%u"
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
Eric


