Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE77CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 02:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sujDY-0002Yh-Ua; Sat, 28 Sep 2024 21:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sujDX-0002Xe-1u
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 21:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sujDV-00023l-A0
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 21:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727575158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/ybY/ljIkDoTDre0UxPoTsPPHhnVmd2DigdSz38ooE=;
 b=eRkz5lrNkyP0KLFRBfPYKXkjIK8n3WIgQd+E8RO+u6kr+8mwZgdRkerFZmvC0/amnK53px
 VPvQAOIgmuO4TDI5KjFCn/HtNgXxd8WPK5u5r1JifJd8mkacTRV+QRxQ78lQQeZYMY0JAS
 iCSkPSivXPU24+zWRfPSj0rnamBrPl4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-6x2HFmMVNzSHmxnSQcn2Tw-1; Sat, 28 Sep 2024 21:59:17 -0400
X-MC-Unique: 6x2HFmMVNzSHmxnSQcn2Tw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e08517d5afso3096669a91.1
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 18:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727575156; x=1728179956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/ybY/ljIkDoTDre0UxPoTsPPHhnVmd2DigdSz38ooE=;
 b=Fm6rXAFmOCTzzppgkJO7xvYhzCvwMG3VQdgaCRr0wigO6T0H6PI54pjwP4wmyL9zgF
 oQtBQzEoYgVDi+PbFWMRxLsOv3/kT7kf32rvidSzcCM0X9QSwXKfRVVnBzmvR0a5LeNU
 D/CSY2pg90sMK4Rv2UlooejmoTGgeA5yC0jfmGg4TNf/ZuHTnB8jnqN0DRfZZPeomCFH
 CH2wQNMqFXclwP8EYyv0Ci0iepVO5DKKr1a5RcMZBym0f4gfvq5LRHFB7sUEfD5Fvc07
 2DC7X1pW79WwdSGzDEGeOGeY9U5iccI0dMttVsQ6XKCuOVqWrEzFOsTroacLrrfXEidf
 H6sw==
X-Gm-Message-State: AOJu0YwqD2GuJsznbIvu8F8LlQLKzhdFkGV7LM884EfpdkzJrkAuOp3i
 5EJ4J5Yuu0BFHDzYqQfInr0Oj8EdSsnN1emhg4PMg4eIyzaBxm936/goHmPz/6wBt4yz8g8kjcK
 lQx8ECsaoRQ0ZQxSk4WGAfqqXq5dINokjmEJngEy7cEDjb+fqS6tDVq5AxOPsaNJ0BOSXYG32gw
 x2ag/tzMKLm0wd3rdWRCP8Jjbgghc=
X-Received: by 2002:a17:90b:18e:b0:2d8:3f7a:edf2 with SMTP id
 98e67ed59e1d1-2e09113ca1cmr17780324a91.12.1727575155901; 
 Sat, 28 Sep 2024 18:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmiDatDkTfuBgssVCxY64Qr9XZZkrBMECEE0zc8zI4xGMl6TwOruoBInGsQTnPP12o9t6VfShzwnX9mZRT73A=
X-Received: by 2002:a17:90b:18e:b0:2d8:3f7a:edf2 with SMTP id
 98e67ed59e1d1-2e09113ca1cmr17780301a91.12.1727575155418; Sat, 28 Sep 2024
 18:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-13-zhenzhong.duan@intel.com>
 <CACGkMEscZB9f6toOcm_+3pQknDgnp3r6MvzbejB9BVEsKz7rjA@mail.gmail.com>
 <SJ0PR11MB67441D158F394CE1EA620CA9926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67441D158F394CE1EA620CA9926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Sep 2024 09:59:03 +0800
Message-ID: <CACGkMEuXX6UE0=dNjeNJ5rHxkJADUrTG0tU1Cd1n0cvik5NnKg@mail.gmail.com>
Subject: Re: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, 
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, 
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 27, 2024 at 3:18=E2=80=AFPM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Jason Wang <jasowang@redhat.com>
> >Subject: Re: [PATCH v3 12/17] intel_iommu: Add support for PASID-based
> >device IOTLB invalidation
> >
> >On Wed, Sep 11, 2024 at 1:27=E2=80=AFPM Zhenzhong Duan
> ><zhenzhong.duan@intel.com> wrote:
> >>
> >> From: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >>
> >> Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@evide=
n.com>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> ---
> >>  hw/i386/intel_iommu_internal.h | 11 ++++++++
> >>  hw/i386/intel_iommu.c          | 50
> >++++++++++++++++++++++++++++++++++
> >>  2 files changed, 61 insertions(+)
> >>
> >> diff --git a/hw/i386/intel_iommu_internal.h
> >b/hw/i386/intel_iommu_internal.h
> >> index 4f2c3a9350..52bdbf3bc5 100644
> >> --- a/hw/i386/intel_iommu_internal.h
> >> +++ b/hw/i386/intel_iommu_internal.h
> >> @@ -375,6 +375,7 @@ typedef union VTDInvDesc VTDInvDesc;
> >>  #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Desc=
riptor
> >*/
> >>  #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate=
 Desc
> >*/
> >>  #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate=
 Desc */
> >> +#define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB
> >inv_desc*/
> >>  #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Desc=
riptor
> >*/
> >>
> >>  /* Masks for Invalidation Wait Descriptor*/
> >> @@ -413,6 +414,16 @@ typedef union VTDInvDesc VTDInvDesc;
> >>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
> >>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
> >>
> >> +/* Mask for PASID Device IOTLB Invalidate Descriptor */
> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(val) ((val) & \
> >> +                                                   0xfffffffffffff000=
ULL)
> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(val) ((val >> 11) & 0x1)
> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(val) ((val) & 0x1)
> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(val) (((val) >> 16) &
> >0xffffULL)
> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(val) ((val >> 32) &
> >0xfffffULL)
> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_HI 0x7feULL
> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_LO
> >0xfff000000000f000ULL
> >> +
> >>  /* Rsvd field masks for spte */
> >>  #define VTD_SPTE_SNP 0x800ULL
> >>
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index d28c862598..4cf56924e1 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -3017,6 +3017,49 @@ static void
> >do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
> >>      memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
> >>  }
> >>
> >> +static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
> >> +                                           VTDInvDesc *inv_desc)
> >> +{
> >> +    uint16_t sid;
> >> +    VTDAddressSpace *vtd_dev_as;
> >> +    bool size;
> >> +    bool global;
> >> +    hwaddr addr;
> >> +    uint32_t pasid;
> >> +
> >> +    if ((inv_desc->hi & VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_HI) ||
> >> +         (inv_desc->lo & VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_LO)) {
> >> +        error_report_once("%s: invalid pasid-based dev iotlb inv desc=
:"
> >> +                          "hi=3D%"PRIx64 "(reserved nonzero)",
> >> +                          __func__, inv_desc->hi);
> >> +        return false;
> >> +    }
> >> +
> >> +    global =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(inv_desc->hi);
> >> +    size =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(inv_desc->hi);
> >> +    addr =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(inv_desc->hi);
> >> +    sid =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(inv_desc->lo);
> >> +    if (global) {
> >> +        QLIST_FOREACH(vtd_dev_as, &s->vtd_as_with_notifiers, next) {
> >> +            if ((vtd_dev_as->pasid !=3D PCI_NO_PASID) &&
> >> +                (PCI_BUILD_BDF(pci_bus_num(vtd_dev_as->bus),
> >> +                                           vtd_dev_as->devfn) =3D=3D =
sid)) {
> >> +                do_invalidate_device_tlb(vtd_dev_as, size, addr);
> >> +            }
> >> +        }
> >> +    } else {
> >> +        pasid =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(inv_desc->lo)=
;
> >> +        vtd_dev_as =3D vtd_get_as_by_sid_and_pasid(s, sid, pasid);
> >> +        if (!vtd_dev_as) {
> >> +            return true;
> >> +        }
> >> +
> >> +        do_invalidate_device_tlb(vtd_dev_as, size, addr);
> >
> >Question:
> >
> >I wonder if current vhost (which has a device IOTLB abstraction via
> >virtio-pci) can work with this (PASID based IOTLB invalidation)
>
> Currently, it depends on if caching-mode is on. If it's off, vhost works.=
 E.g.:
>
> -device intel-iommu,caching-mode=3Doff,dma-drain=3Don,device-iotlb=3Don,x=
-scalable-mode=3Don
> -netdev tap,id=3Dtap0,vhost=3Don,script=3D/etc/qemu-ifup
> -device virtio-net-pci,netdev=3Dtap0,bus=3Droot0,iommu_platform=3Don,ats=
=3Don
>
> It doesn't work currently when caching-mode is on.
> Reason is linux kernel has an optimization to send only piotlb invalidati=
on,
> no device-piotlb invalidation is sent. But I heard from Yi the optimizati=
on
> will be dropped, then it will work too when caching-mode is on.

Great, if possible please copy me when sending those fixes.

Thanks

>
> Thanks
> Zhenzhong


