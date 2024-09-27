Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35298CEBF76
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 03:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su1wv-00011f-Pq; Thu, 26 Sep 2024 23:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su1wu-000115-F0
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 23:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su1wr-00042s-J2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 23:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727408835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHpoqrSHlAW1UW1WM9SCHzBO1vr2nbJP7x2rvcRI5kg=;
 b=Q5PKPzzLnMSb0xbCsSiLl44nxltoWVBe7o4TkZmKplpuT69bnK5LEtMy0A0gNloDZ3NJ6+
 blLUvaA1ateg9DcuxqlddH9k589bh3tYnttpZsXJoUcQj8+RiMbb1GBEMck1h7JV+TBAuv
 6eSNR4+WJ+vXhi5VX/SoV37KsXLDAwc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-XuCDtJ7sOu229_a_nfKLsg-1; Thu, 26 Sep 2024 23:47:13 -0400
X-MC-Unique: XuCDtJ7sOu229_a_nfKLsg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7db9418552fso1531603a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 20:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727408832; x=1728013632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHpoqrSHlAW1UW1WM9SCHzBO1vr2nbJP7x2rvcRI5kg=;
 b=M24EGfmfb+x4xEzCcMIYh34/EctU/qKqpZ4/aT7bFtHReYi64mA3imNFtvneiutv07
 aAAjl1pKyPfyyor6PC6g5O7V12PtmRgvGy+XLrSYx4LAMtjBxaLZvcWxJtHV17Hm26Za
 L1Q4BXkcRAI222bwjZTm4isvB2R+Lstuu4sHjQErrV7b6mhdZSF2UTCYZJw//07BOIZd
 G0f2RREv0STsgfiLZWKdTA0BGka1q1y28+jbdUbmN95QOLUsACXV89r2y3xvdc0hnUau
 ONEdvEsTA9aDb3U/ezDdwIUm/JaZxKxxYSTleDRwATNP4U97SFuLjueuuvzQK7qZiOe4
 D/HA==
X-Gm-Message-State: AOJu0YxPS5yrRQL20N+6Cw1ZdLblpOgwFUnPBfQXFidlr92ss6rIVKcv
 gP721sO+gyHr4DiICexmGIJ8L52ZU5+m7ecVSOy7Il9jnjL4QQtTntwwZGHlXvyE7kFqqYZpSk3
 6OUh4KEpORwFJhWsWvKUF8uUJCf9He5NQIuQDbFDX3zB7RwKJ4ovWU3/HUX/Ox95t3zXaPH3jTv
 P++jqtEE7UcZNyfpaOgtbdMwa8ujU=
X-Received: by 2002:a17:90a:68cb:b0:2e0:7b35:31ce with SMTP id
 98e67ed59e1d1-2e0b8ec7060mr2100446a91.34.1727408832559; 
 Thu, 26 Sep 2024 20:47:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG54ObqxpvrtI4po1zLvybo++u+p55kL2CLeqC9HY7EKy0YOBWAjRW4YS+ACOP0Jp+Z3Q3RzUht1TYnJ1YJmVk=
X-Received: by 2002:a17:90a:68cb:b0:2e0:7b35:31ce with SMTP id
 98e67ed59e1d1-2e0b8ec7060mr2100410a91.34.1727408832026; Thu, 26 Sep 2024
 20:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-5-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-5-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 11:47:00 +0800
Message-ID: <CACGkMEvvmY=k=Op56A0RP4sm8u_8CmDckmiQX+QF_NtWEHtefw@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 11, 2024 at 1:26=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation will
> flush stage-2 iotlb entries with matching domain id and pasid.
>
> With scalable modern mode introduced, guest could send PASID-selective
> PASID-based iotlb invalidation to flush both stage-1 and stage-2 entries.
>
> By this chance, remove old IOTLB related definition.

Nit: if there's a respin we'd better say those definitions is unused.

Other than this

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h | 14 +++---
>  hw/i386/intel_iommu.c          | 81 ++++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 8fa27c7f3b..19e4ed52ca 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -402,11 +402,6 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
>  #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
>  #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
> -#define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
> -#define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
> -#define VTD_INV_DESC_IOTLB_PASID(val)   (((val) >> 32) & VTD_PASID_ID_MA=
SK)
> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_LO      0xfff00000000001c0ULL
> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI      0xf80ULL
>
>  /* Mask for Device IOTLB Invalidate Descriptor */
>  #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) & 0xfffffffffffff000U=
LL)
> @@ -438,6 +433,15 @@ typedef union VTDInvDesc VTDInvDesc;
>          (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM=
)) : \
>          (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>
> +/* Masks for PIOTLB Invalidate Descriptor */
> +#define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
> +#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID=
_MASK)
> +#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
> +
>  /* Information about page-selective IOTLB invalidate */
>  struct VTDIOTLBPageInvInfo {
>      uint16_t domain_id;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 57c24f67b4..be30caef31 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2656,6 +2656,83 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState=
 *s, VTDInvDesc *inv_desc)
>      return true;
>  }
>
> +static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
> +                                         gpointer user_data)
> +{
> +    VTDIOTLBEntry *entry =3D (VTDIOTLBEntry *)value;
> +    VTDIOTLBPageInvInfo *info =3D (VTDIOTLBPageInvInfo *)user_data;
> +
> +    return ((entry->domain_id =3D=3D info->domain_id) &&
> +            (entry->pasid =3D=3D info->pasid));
> +}
> +
> +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
> +                                        uint16_t domain_id, uint32_t pas=
id)
> +{
> +    VTDIOTLBPageInvInfo info;
> +    VTDAddressSpace *vtd_as;
> +    VTDContextEntry ce;
> +
> +    info.domain_id =3D domain_id;
> +    info.pasid =3D pasid;
> +
> +    vtd_iommu_lock(s);
> +    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
> +                                &info);
> +    vtd_iommu_unlock(s);
> +
> +    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> +        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> +                                      vtd_as->devfn, &ce) &&
> +            domain_id =3D=3D vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> +            uint32_t rid2pasid =3D VTD_CE_GET_RID2PASID(&ce);
> +
> +            if ((vtd_as->pasid !=3D PCI_NO_PASID || pasid !=3D rid2pasid=
) &&
> +                vtd_as->pasid !=3D pasid) {
> +                continue;
> +            }
> +
> +            if (!s->scalable_modern) {
> +                vtd_address_space_sync(vtd_as);
> +            }
> +        }
> +    }
> +}
> +
> +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
> +                                    VTDInvDesc *inv_desc)
> +{
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +
> +    if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
> +        (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1)) {
> +        error_report_once("%s: invalid piotlb inv desc hi=3D0x%"PRIx64
> +                          " lo=3D0x%"PRIx64" (reserved bits unzero)",
> +                          __func__, inv_desc->val[1], inv_desc->val[0]);
> +        return false;
> +    }
> +
> +    domain_id =3D VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
> +    pasid =3D VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
> +    switch (inv_desc->val[0] & VTD_INV_DESC_PIOTLB_G) {
> +    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
> +        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
> +        break;
> +
> +    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
> +        break;
> +
> +    default:
> +        error_report_once("%s: invalid piotlb inv desc: hi=3D0x%"PRIx64
> +                          ", lo=3D0x%"PRIx64" (type mismatch: 0x%llx)",
> +                          __func__, inv_desc->val[1], inv_desc->val[0],
> +                          inv_desc->val[0] & VTD_INV_DESC_IOTLB_G);
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>                                       VTDInvDesc *inv_desc)
>  {
> @@ -2775,6 +2852,10 @@ static bool vtd_process_inv_desc(IntelIOMMUState *=
s)
>          break;
>
>      case VTD_INV_DESC_PIOTLB:
> +        trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
> +        if (!vtd_process_piotlb_desc(s, &inv_desc)) {
> +            return false;
> +        }
>          break;
>
>      case VTD_INV_DESC_WAIT:
> --
> 2.34.1
>


