Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323A5CEBF69
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 04:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2HC-0002sg-GY; Fri, 27 Sep 2024 00:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HA-0002n6-EH
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2H8-0006Fg-Rt
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fSjcuf2A4tZhydVx74HM8zPFGxn0M+wqrW++mwXPhc=;
 b=NeaFMWaT+fpSDvqVeHMMUnA+L1k2GtcKe4n5LV7+Mn+uyCMqFx3p6cs+6OoqxnsG5sGhzL
 ejuOiJa8WT7ErM6OyRwxMpWmVofQnTsFidAWriNSOVP25CxbkNwIsVlnQldOFQSpPzTv7d
 Y4CfbZ0o/xJUvar04Bdk9CmGetJA+aI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-r_PKX0SlNLaaCRFCYwF4RQ-1; Fri, 27 Sep 2024 00:08:11 -0400
X-MC-Unique: r_PKX0SlNLaaCRFCYwF4RQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e08c75943cso2127384a91.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410090; x=1728014890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fSjcuf2A4tZhydVx74HM8zPFGxn0M+wqrW++mwXPhc=;
 b=LV12UY+qJl0vense4NQgWwKxu9Yr/QQAm/Mbnl5AGKZgsSC6FQvSrJxKm7FVWEkCU5
 ISDMGwJZrbJr1p8x8VCteT/xZCKllowERgBAtDxi5x9Icr1MRdERAqMax5vY+hAbhy+v
 XXawdXRnPwKjg6gXpEYb6T1tkY3s7PP87/6elIU7TUowvJU/6P5t2JLdGgZOJ15v+YOD
 elfyF7dpXrzLa8OZNrFCtIRhesj/hgi4tzoDzspNjFdAjSVj+3ew0lqIfATKZu0yETjx
 7zMdjKntOH0cSl3M59+hxKhrPtgKmZ+ph/uUuXUddZVJmvEKrjAiP/pfybfe2GgDukPW
 dvNg==
X-Gm-Message-State: AOJu0YyJ6AOKlep1mqCjfcPkcgdmjJB+mq9RQ1EzitDh9ewT5Avnl0S6
 5ceCAKoAipZzx5uNPW2keE+lIl/t4QTQXMTbfoNVJ4k36hidzB97vJ41c/lh4mznlsLWJbv9i5w
 +n9msgzlch5KkFIGmZq7ptV+oZV+1oxDqRj7xaD4exN1K+C5vCb98tfP20ZdQp2SgpptJCMJOMH
 FfedInOIwfhNG8Yv72i04I9IF/3bk=
X-Received: by 2002:a17:90a:688b:b0:2d3:d09a:630e with SMTP id
 98e67ed59e1d1-2e0b876dfacmr2484596a91.1.1727410090140; 
 Thu, 26 Sep 2024 21:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8uSC48o3XTO1RmRJ5o62Vu1CawauAVGzFNQhq39BC0ZERr+lFgsdCNxNHKTfLlCaYC/O8OHxK5gJ303zeubA=
X-Received: by 2002:a17:90a:688b:b0:2d3:d09a:630e with SMTP id
 98e67ed59e1d1-2e0b876dfacmr2484559a91.1.1727410089607; Thu, 26 Sep 2024
 21:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-9-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-9-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:07:56 +0800
Message-ID: <CACGkMEsQHL=+s65UH0mM6ukv5UyLs0ZFiMHB-G58_T1qvsOvvg@mail.gmail.com>
Subject: Re: [PATCH v3 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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
> From: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
>
> Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.c=
om>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  3 +++
>  hw/i386/intel_iommu.c          | 25 ++++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 668583aeca..7786ef7624 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -324,6 +324,7 @@ typedef enum VTDFaultReason {
>
>      /* Output address in the interrupt address range for scalable mode *=
/
>      VTD_FR_SM_INTERRUPT_ADDR =3D 0x87,
> +    VTD_FR_FS_BIT_UPDATE_FAILED =3D 0x91, /* SFS.10 */
>      VTD_FR_MAX,                 /* Guard */
>  } VTDFaultReason;
>
> @@ -549,6 +550,8 @@ typedef struct VTDRootEntry VTDRootEntry;
>  /* Masks for First Level Paging Entry */
>  #define VTD_FL_P                    1ULL
>  #define VTD_FL_RW_MASK              (1ULL << 1)
> +#define VTD_FL_A                    0x20
> +#define VTD_FL_D                    0x40

Nit: let's use _MASK suffix to all or not.

>
>  /* Second Level Page Translation Pointer*/
>  #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index be73366a64..180505423d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1822,6 +1822,7 @@ static const bool vtd_qualified_faults[] =3D {
>      [VTD_FR_PASID_TABLE_ENTRY_INV] =3D true,
>      [VTD_FR_SM_INTERRUPT_ADDR] =3D true,
>      [VTD_FR_FS_NON_CANONICAL] =3D true,
> +    [VTD_FR_FS_BIT_UPDATE_FAILED] =3D true,
>      [VTD_FR_MAX] =3D false,
>  };
>
> @@ -1941,6 +1942,20 @@ static bool vtd_iova_fl_check_canonical(IntelIOMMU=
State *s, uint64_t iova,
>      }
>  }
>
> +static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t in=
dex,
> +                                       uint64_t pte, uint64_t flag)
> +{
> +    if (pte & flag) {
> +        return MEMTX_OK;
> +    }
> +    pte |=3D flag;
> +    pte =3D cpu_to_le64(pte);
> +    return dma_memory_write(&address_space_memory,
> +                            base_addr + index * sizeof(pte),
> +                            &pte, sizeof(pte),
> +                            MEMTXATTRS_UNSPECIFIED);
> +}
> +
>  /*
>   * Given the @iova, get relevant @flptep. @flpte_level will be the last =
level
>   * of the translation, can be used for deciding the size of large page.
> @@ -1954,7 +1969,7 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
>      dma_addr_t addr =3D vtd_get_iova_pgtbl_base(s, ce, pasid);
>      uint32_t level =3D vtd_get_iova_level(s, ce, pasid);
>      uint32_t offset;
> -    uint64_t flpte;
> +    uint64_t flpte, flag_ad =3D VTD_FL_A;
>
>      if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
>          error_report_once("%s: detected non canonical IOVA (iova=3D0x%" =
PRIx64 ","
> @@ -1992,6 +2007,14 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, V=
TDContextEntry *ce,
>              return -VTD_FR_PAGING_ENTRY_RSVD;
>          }
>
> +        if (vtd_is_last_pte(flpte, level) && is_write) {
> +            flag_ad |=3D VTD_FL_D;
> +        }
> +
> +        if (vtd_set_flag_in_pte(addr, offset, flpte, flag_ad) !=3D MEMTX=
_OK) {
> +            return -VTD_FR_FS_BIT_UPDATE_FAILED;
> +        }
> +
>          if (vtd_is_last_pte(flpte, level)) {
>              *flptep =3D flpte;
>              *flpte_level =3D level;
> --
> 2.34.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


