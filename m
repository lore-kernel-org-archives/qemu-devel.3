Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17809C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xHT-00070X-4E; Mon, 31 Aug 2026 04:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0xHR-0006zl-Bq
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0xHP-0007fY-3S
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788164529;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8Ldt1YBVISozb9qkOKpxIhlCDL59wdrai+nFgDmB7Q=;
 b=b9tSDFGwImw7ujPZ8YOS/6ayFeCVHC+CZx1yESMpDs2JPyP9ejhZCtGnMGM6G4evBwytRh
 4j2On6xOjHWb3tVvcvhrB7jonGZivkVMKxYSingYCULxiljcEbh2Rvdc+EXdLuavNCD4J4
 DbY++TGzOzvAFN+GAq+waobjQxavruU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-ovHz-0E3O7mcJ5saVJX-jA-1; Mon, 31 Aug 2026 04:22:08 -0400
X-MC-Unique: ovHz-0E3O7mcJ5saVJX-jA-1
X-Mimecast-MFC-AGG-ID: ovHz-0E3O7mcJ5saVJX-jA_1788164527
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so18043795e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 01:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164527; x=1788769327;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L8Ldt1YBVISozb9qkOKpxIhlCDL59wdrai+nFgDmB7Q=;
 b=NX5yEGsEOZA+31dNUdeegL541b61ysyENlSEqxKxS+GZ4WdhiuMrHMle6hJf3d5Rrq
 soW5dYHA+M8knoZLWo7xhkmjVwtj2AF1+OGK7hb26gGper1XFRDxAynsow/fBYEUUpLC
 dI04QI5Wfuxp/4yDDZZlBFkeMmZQGDN0j9FDHKOI44TEwRwk89btecU9WGIXhDOkz4Yz
 5wYTLItGEk8FSNmA4WZyb6un0gHq1EMj2T37Bs5o8ykHmpWuf4VQmr4OQ19nXoNYR5Qd
 OzUbeDHdStKrFK4qfr6Nl2Lq8PiUKUa/TdKNotlTEtXWZ4WBjsRkw0nRossJ5atE5Wx+
 eoMw==
X-Gm-Message-State: AFuF++nnRWW7y44y/b2WyBQrBdnjE77PjeZXdySh+4R72Xz8HkrZMnw0
 hh8ubfVr2eB5u+UDZCyDQXGlmRkoCvjSN/E2HA1lMRxrk29hQ+aBqQjb3CQfpeBYvg1AU8E/Bbe
 yIwOiKv3iyEFZixm+BJWE1KX1+YmXdcg8QzpsEE81yQk6PBwU1rKiZ/Y+
X-Gm-Gg: AR+sD12X07anPPBGiRotkwDnZHKLBjBlDqiQUBSE9RXoukDc4kvSBKomGS5TnXPSlLS
 of+FscbB0bHUGZJKQOCMwn0yjqZmp7bt0vI9TqHTLYdLRyFF6GXBDlOkM1QIPExTvQXOJmsJdEj
 5/w/wXDT+JsDkUTITwXPn8LGEkOPY39cneEBzS8nseQyFZBFOH3jsNXF7V1SOPR54ZrYvIf9ay2
 LZlOEsZ3ztKmct0h9gJfET9rVohdjjULF9VEkCyXdKIAu+FGYXSZlwzpDamyLyKcULqqT1YTVU2
 O9wbftzbTaUHiYsT3h3xdRtDfTVkTfQCKjglptpyrZdsToaBL+Vzd6F0zDhIVg3Jlh1osnHsEsQ
 iq7VOIYXrK12WqpvnIQu9/PEPZlXyWtzcgy3OPfOIRtw26MKY
X-Received: by 2002:a05:600c:4744:b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-49b91c2479amr364442875e9.4.1788164526603; 
 Mon, 31 Aug 2026 01:22:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4744:b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-49b91c2479amr364441805e9.4.1788164526116; 
 Mon, 31 Aug 2026 01:22:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbad08d2sm23127779f8f.16.2026.08.31.01.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 01:22:05 -0700 (PDT)
Message-ID: <33586975-6707-42d9-8744-d3cc70a38fb2@redhat.com>
Date: Mon, 31 Aug 2026 10:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 24/28] hw/arm/smmuv3: Select sec-sid from PCI property
 and validate SECURE_IMPL
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162624.2809349-3-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162624.2809349-3-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 8/13/26 6:26 PM, Tao Tang wrote:
> Parse each PCI device's sec-sid property during SMMU device initialization
> and cache it in SMMUDevice::sec_sid. Support "non-secure" and "secure",
> default to non-secure when unspecified, and reject invalid values with an
> explicit error. Use sdev->sec_sid in smmuv3_translate() to select the
> register bank instead of hardcoding the non-secure context.
>
> Keep sec-sid parsing in smmu-common, and add a SMMUv3-specific validation
> hook to enforce architectural constraints: fail fast when sec-sid=secure
> while SMMU_S_IDR1.SECURE_IMPL is 0 or secure AS is not available.
>
> Typically, SEC_SID is a system-defined attribute (e.g. sideband or tied-off)
> rather than something a PCIe endpoint can freely toggle in pre-RME scenario.
> So this PCI sec-sid property is used as a static platform/testing knob to
> drive the SMMU bank selection.
>
> For future RME-DA and TDISP support, this static property will need to be
> replaced by runtime platform plumbing that derives the effective SEC_SID
> from the device security assignment.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmu-common.c         | 37 ++++++++++++++++++++++
>  hw/arm/smmuv3.c              | 61 +++++++++++++++++++++++++++++++++++-
>  include/hw/arm/smmu-common.h |  2 ++
>  3 files changed, 99 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index e8a1ed65c19..4a94799fb0d 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -21,6 +21,7 @@
>  #include "exec/target_page.h"
>  #include "hw/core/cpu.h"
>  #include "hw/pci/pci_bridge.h"
> +#include "hw/pci/pci_device.h"
>  #include "hw/core/qdev-properties.h"
>  #include "qapi/error.h"
>  #include "qemu/jhash.h"
> @@ -1100,14 +1101,50 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
>      return NULL;
>  }
>  
> +static SMMUSecSID smmu_parse_pci_sec_sid(PCIDevice *pdev, int bus_num,
> +                                         int devfn)
> +{
> +    const char *sec_sid;
> +
> +    if (!pdev || !pdev->sec_sid) {
> +        return SMMU_SEC_SID_NS;
> +    }
> +
> +    sec_sid = pdev->sec_sid;
> +    if (!strcmp(sec_sid, "non-secure")) {
> +        return SMMU_SEC_SID_NS;
> +    }
else if?
> +    if (!strcmp(sec_sid, "secure")) {
> +        return SMMU_SEC_SID_S;
> +    }
> +
> +    error_report("Invalid sec-sid value '%s' for PCI device %02x:%02x.%x; "
> +                 "allowed values: non-secure or secure (case-sensitive)",
To me this is not the place where pci property validation should happen.
This should happen in the pcie device instead, on property setting.
> +                 sec_sid, bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn));
> +    exit(EXIT_FAILURE);
> +}
> +
>  void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn)
>  {
>      static unsigned int index;
>      g_autofree char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn,
>                                              index++);
> +    SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(s);
> +    PCIDevice *pdev;
> +    int bus_num;
> +
>      sdev->smmu = s;
>      sdev->bus = bus;
>      sdev->devfn = devfn;
> +    sdev->sec_sid = SMMU_SEC_SID_NS;
do we need this init? smmu_parse_pci_sec_sid() already implements the
default.
> +
> +    bus_num = pci_bus_num(bus);
> +    pdev = pci_find_device(bus, bus_num, devfn);
> +    sdev->sec_sid = smmu_parse_pci_sec_sid(pdev, bus_num, devfn);
> +    if (sbc->validate_sec_sid &&
> +        !sbc->validate_sec_sid(s, sdev, bus_num)) {
> +        exit(EXIT_FAILURE);
The problem is any attempt to hotplu a secure device will exit QEMU.
I wonder if we shouldn't implement a PCIIOMMUOps that detects the
incompatibility.
Maybe supports_address_space() could do that. At the moment it is used
to check accel mode only but another implementation could check secure
compatibility I think. The advantage is this callback passes an errp.
> +    }
>  
>      memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
>                               s->mrtypename, OBJECT(s), name, UINT64_MAX);
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e5f0bc18415..a755f1ebd69 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -43,6 +43,12 @@
>                                          ((ptw_info).stage == SMMU_STAGE_2 && \
>                                          (cfg)->s2cfg.record_faults))
>  
> +enum {
> +    SMMU_IOMMU_IDX_NS,
> +    SMMU_IOMMU_IDX_S,
> +    SMMU_IOMMU_IDX_NUM,
> +};
why do we need another enum, can't we reuse SMMUSecSID? 
> +
>  /**
>   * smmuv3_trigger_irq - pulse @irq if enabled and update
>   * GERROR register in case of GERROR interrupt
> @@ -1157,6 +1163,33 @@ static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
>      }
>  }
>  
> +static int smmuv3_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs)
> +{
> +    if (attrs.unspecified) {
> +        return SMMU_IOMMU_IDX_NS;
> +    }
> +    return attrs.secure ? SMMU_IOMMU_IDX_S : SMMU_IOMMU_IDX_NS;
> +}
> +
> +static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
> +{
> +    return SMMU_IOMMU_IDX_NUM;
> +}
> +
> +static AddressSpace *smmuv3_bypass_target_as(SMMUv3State *s,
> +                                             SMMUSecSID sec_sid,
> +                                             int iommu_idx)
> +{
> +    g_assert(iommu_idx >= SMMU_IOMMU_IDX_NS &&
> +             iommu_idx < SMMU_IOMMU_IDX_NUM);
> +
> +    if (smmu_sec_sid_is_secure(sec_sid) &&
> +        iommu_idx == SMMU_IOMMU_IDX_S) {
> +        return smmu_get_address_space(&s->smmu_state, SMMU_SEC_SID_S);
> +    }
> +    return smmu_get_address_space(&s->smmu_state, SMMU_SEC_SID_NS);
> +}
> +
>  /* Entry point to SMMU, does everything. */
>  static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                                        IOMMUAccessFlags flag, int iommu_idx)
> @@ -1164,7 +1197,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>      SMMUv3State *s = sdev->smmu;
>      uint32_t sid = smmu_get_sid(sdev);
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
> +    SMMUSecSID sec_sid = sdev->sec_sid;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      SMMUEventInfo event = {.type = SMMU_EVT_NONE,
>                             .sid = sid,
> @@ -1181,6 +1214,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      };
>      SMMUTLBEntry *cached_entry = NULL;
>  
> +    entry.target_as = smmuv3_bypass_target_as(s, sec_sid, iommu_idx);
> +
>      qemu_mutex_lock(&s->mutex);
>  
>      if (!smmu_enabled(s, sec_sid)) {
> @@ -1611,6 +1646,26 @@ static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
>      return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SECURE_IMPL);
>  }
>  
> +static bool smmuv3_validate_sec_sid(SMMUState *bs, SMMUDevice *sdev,
> +                                    int bus_num)
> +{
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +
> +    if (sdev->sec_sid != SMMU_SEC_SID_S) {
> +        return true;
> +    }
> +
> +    if (!smmu_hw_secure_implemented(s)) {
> +        error_report("Invalid sec-sid value 'secure' for PCI device "
> +                     "%02x:%02x.%x: S_IDR1.SECURE_IMPL is 0, so only "
> +                     "non-secure is allowed",
> +                     bus_num, PCI_SLOT(sdev->devfn), PCI_FUNC(sdev->devfn));
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -2823,6 +2878,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
>      SMMUv3Class *c = ARM_SMMUV3_CLASS(klass);
> +    SMMUBaseClass *sbc = ARM_SMMU_CLASS(klass);
>  
>      dc->vmsd = &vmstate_smmuv3;
>      resettable_class_set_parent_phases(rc, NULL, NULL, smmu_reset_exit,
> @@ -2832,6 +2888,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>      device_class_set_props(dc, smmuv3_properties);
>      dc->hotpluggable = false;
>      dc->user_creatable = true;
> +    sbc->validate_sec_sid = smmuv3_validate_sec_sid;
>  
>      object_class_property_set_description(klass, "accel",
>          "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
> @@ -2905,6 +2962,8 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>  
>      imrc->translate = smmuv3_translate;
>      imrc->notify_flag_changed = smmuv3_notify_flag_changed;
> +    imrc->attrs_to_index = smmuv3_attrs_to_index;
> +    imrc->num_indexes = smmuv3_num_indexes;
Why do we need the above ops? Isn't it generic enough to stay in smmu
base code?
>  }
>  
>  static const TypeInfo smmuv3_type_info = {
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index a21c6061808..9da54221f20 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -134,6 +134,7 @@ typedef struct SMMUDevice {
>      void               *smmu;
>      PCIBus             *bus;
>      int                devfn;
> +    SMMUSecSID         sec_sid;
>      IOMMUMemoryRegion  iommu;
>      AddressSpace       as;
>      uint32_t           cfg_cache_hits;
> @@ -204,6 +205,7 @@ struct SMMUBaseClass {
>      /*< public >*/
>  
>      DeviceRealize parent_realize;
> +    bool (*validate_sec_sid)(struct SMMUState *s, SMMUDevice *sdev, int bus_num);
>  
>  };
>  
Thanks

Eric


