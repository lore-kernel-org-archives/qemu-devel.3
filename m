Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56A6CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syRzc-0003TN-PD; Wed, 09 Oct 2024 04:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syRza-0003Sv-Ul
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syRzY-0007qS-Ra
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728462258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6gkl7mDwkqFiYrVoNRjfzEn2Pl0T4oFjZDBkmHGEKgE=;
 b=FH2pTa5extm7umTLC8Hz5rAR6xsyItaQ1qGZAt7ETq64pArVMXf3CcxOmeh7KYaVujWKdt
 6LGwpoGGsa+e8O+9MvSPGUbiPrFkKDFaf3G2an3l/iN1kWwBg6fusqCBp4Sqop90x+fXWt
 c5+bezaKm7GfvmYdlQz7F/gmL3sQRTk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-kdCiDvcfMia7_KpLX3XwRA-1; Wed, 09 Oct 2024 04:24:16 -0400
X-MC-Unique: kdCiDvcfMia7_KpLX3XwRA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e294096a90so1461268a91.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 01:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462250; x=1729067050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6gkl7mDwkqFiYrVoNRjfzEn2Pl0T4oFjZDBkmHGEKgE=;
 b=r3Nqq9AVhejNZn49z8R+k0MK2c67NL9vdJPsybHifwFUmttwwhQp15HWgr4Jviu/UG
 sVXYMqD6bTSOOlGwQVKPFJjf3jl4HM2QgBOnj7nCx9x2KZj0ZvnmAYhr02i3/haz2OZr
 DztWjjfx4S35Mr/8vvI0LfsSzNnnodtDfbVYQDXvqjQRZ1hnpP+68o+3Mk9DoIKBIN7h
 S23bdIwF1I/tzgssgAcUKotoHQvvvWgqYM40uZlv/3C/6Yz11pbIWlHT3gijgNOjC7mC
 N+ltSK+Ju+zEFIjnYUVNtKd5spmQ+qepsSz8q4+Nr6sRJkdVYHhBcMnnGwVJmWGcKa1+
 bsug==
X-Gm-Message-State: AOJu0YzUeXy3pgjKBN86AB1B/ORueZ8yXj8KFu8l6KqsPypg3FpCViBu
 fZp9OkRyEztiZDmsKhkYqhmz/T6VNJJVkCEm21rk+4EqiZbTKXgr3Y9k5QWaZgdRs/IwZI1/xkO
 kCupsOzmH+ZAiLSvCallGFaIQdBXC2jdyIsYUw6xUkAUPb0U6HJJxM8yMdBtAT7fvhYcMrSy4hN
 gr4A9D1p/iGVb0akFVZCl2YUWTkvY=
X-Received: by 2002:a17:90a:f013:b0:2e2:a029:3b4b with SMTP id
 98e67ed59e1d1-2e2a2525133mr2283310a91.28.1728462250035; 
 Wed, 09 Oct 2024 01:24:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgECB22MegdoBixY79pLyhqVK45VQjLn5UwVnMWfpHzEKQ0TcfukyGdZ74vinY7/+/dZWxFX1kGRIIC8ulKw8=
X-Received: by 2002:a17:90a:f013:b0:2e2:a029:3b4b with SMTP id
 98e67ed59e1d1-2e2a2525133mr2283281a91.28.1728462249529; Wed, 09 Oct 2024
 01:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240930065245.2993767-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240930065245.2993767-1-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:23:58 +0800
Message-ID: <CACGkMEuN0A8i1N2S8j+m1vx+Noy9Yxvt5TxHD3NYL2hHQKcRKA@mail.gmail.com>
Subject: Re: [PATCH] intel_iommu: Remove Transient Mapping (TM) field from
 second-level page-tables
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, chao.p.peng@intel.com, Yi Liu <yi.l.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 30, 2024 at 2:56=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> VT-d spec removed Transient Mapping (TM) field from second-level page-tab=
les
> and treat the field as Reserved(0) since revision 3.2. Update code to mat=
ch
> spec.

Some questions:

1) Is there a version register for vtd so driver can know? Otherwise
we may break migration compatibility silently.
2) Is there any user for that field in the past? If yes, we probably
need a new parameter for this.

Thanks

>
> This doesn't impact function of vIOMMU as there was no logic to emulate
> Transient Mapping.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h | 13 +++----------
>  hw/i386/intel_iommu.c          | 11 +++--------
>  2 files changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 13d5d129ae..c818c819fe 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -412,9 +412,7 @@ typedef union VTDInvDesc VTDInvDesc;
>  /* Rsvd field masks for spte */
>  #define VTD_SPTE_SNP 0x800ULL
>
> -#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
> -        dt_supported ? \
> -        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : =
\
> +#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw) \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> @@ -423,13 +421,9 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
>          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>
> -#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
> -        dt_supported ? \
> -        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM))=
 : \
> +#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
>          (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
> -        dt_supported ? \
> -        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM=
)) : \
> +#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
>          (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>
>  /* Information about page-selective IOTLB invalidate */
> @@ -536,6 +530,5 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SL_W                    (1ULL << 1)
>  #define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MAS=
K(aw))
>  #define VTD_SL_IGN_COM              0xbff0000000000000ULL
> -#define VTD_SL_TM                   (1ULL << 62)
>
>  #endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 08fe218935..eb5aa2b2d5 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4111,8 +4111,6 @@ static void vtd_cap_init(IntelIOMMUState *s)
>   */
>  static void vtd_init(IntelIOMMUState *s)
>  {
> -    X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
> -
>      memset(s->csr, 0, DMAR_REG_SIZE);
>      memset(s->wmask, 0, DMAR_REG_SIZE);
>      memset(s->w1cmask, 0, DMAR_REG_SIZE);
> @@ -4137,16 +4135,13 @@ static void vtd_init(IntelIOMMUState *s)
>       * Rsvd field masks for spte
>       */
>      vtd_spte_rsvd[0] =3D ~0ULL;
> -    vtd_spte_rsvd[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
> -                                                  x86_iommu->dt_supporte=
d);
> +    vtd_spte_rsvd[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
>      vtd_spte_rsvd[2] =3D VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
>      vtd_spte_rsvd[3] =3D VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
>      vtd_spte_rsvd[4] =3D VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
>
> -    vtd_spte_rsvd_large[2] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
> -                                                    x86_iommu->dt_suppor=
ted);
> -    vtd_spte_rsvd_large[3] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
> -                                                    x86_iommu->dt_suppor=
ted);
> +    vtd_spte_rsvd_large[2] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd_large[3] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
>
>      if (s->scalable_mode || s->snoop_control) {
>          vtd_spte_rsvd[1] &=3D ~VTD_SPTE_SNP;
> --
> 2.34.1
>


