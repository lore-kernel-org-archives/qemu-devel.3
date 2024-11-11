Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ED7D12D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 01:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAJAW-0003yB-BC; Sun, 10 Nov 2024 20:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tAJAV-0003y3-54
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 20:24:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tAJAS-0008GH-CL
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 20:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731288272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZkj/hk2X9Ew5NcTU48B3xPtx4DtGzFjnve/+ekXsFs=;
 b=Sbp+DcjwKLQB9O4FuYBRDfpKlwr53AKPVjusYbEXC6hTTV58XH4Yjf8zWRyy672ARC1feB
 fSaJ7E2TMn83dQmmOLCX295oRD/GvJ82sMp71l4DrhF5qAqWUFBZpuSOcL3S1UcMZE1ggF
 3QikbpPqKtNzERizEsumMa+WriXs8Cw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-w_-oiJe7M8uqIEXIa4bcQA-1; Sun, 10 Nov 2024 20:24:30 -0500
X-MC-Unique: w_-oiJe7M8uqIEXIa4bcQA-1
X-Mimecast-MFC-AGG-ID: w_-oiJe7M8uqIEXIa4bcQA
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7ed98536f95so2639905a12.1
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 17:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731288269; x=1731893069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZkj/hk2X9Ew5NcTU48B3xPtx4DtGzFjnve/+ekXsFs=;
 b=XhTM+qnyzDCN6BroHOx+TJ0eTmm2e1taxX28X7Hg3tWeDMTVM24TRf5FI6wfZIANJ+
 i9bqSEWwGexmOdSY2YYqYpoSHgBqJkPIfSTyUv98bkYxJNZSUnNSDYyfv3Pt17ejMtat
 lnbXOUyAVRm1EyEtD5hVLQ86EOuld2tTfOIIFYbS9mzOfwKmItqLts6hZNcyXzpwtIlq
 9lOmaz/7Ha16EHSg+uok12Oo34FniYhZoziefuq7b0o0vNRoKPShLC1o4VLW4eZwi4U8
 J0SLI7LgXNfn3JymkQOFKFA6YUmqk99Bdb2HryAeNi9XiaIwoo9dcmoP1VO3sKG+McsN
 daAg==
X-Gm-Message-State: AOJu0YyT0oj8nuZNZOg/hkpC7reEhheWYq6Q8t1MayP9xIMRy40sWvze
 lN4bD2Sg2yl1RuZXqqnJ98YKdb6cEB6OAhw6opAWk1mCd61CYz435Rfh2fX5vsnUsIBqsfReEGo
 LdelYZzw7ad8OGdCAMk6n/akB8tHhyWrN73RvX68SZv0HA/IsMOvgw9Q0+izMXYmU2pQ7MzT00x
 WuKXx5Lu8StB1B9sY0EHcvKrz/FDs=
X-Received: by 2002:a17:90b:1805:b0:2e9:3056:71dd with SMTP id
 98e67ed59e1d1-2e9b0a31d44mr15855094a91.7.1731288269549; 
 Sun, 10 Nov 2024 17:24:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6NG73fO1MpzTSbLtMEdPTQ7p0QmT//LLjREVjoUjdgnMVhF5G5ObIPR5NmUlU5UdHcoNE6Qd4P5H+mS2Yonc=
X-Received: by 2002:a17:90b:1805:b0:2e9:3056:71dd with SMTP id
 98e67ed59e1d1-2e9b0a31d44mr15855056a91.7.1731288268979; Sun, 10 Nov 2024
 17:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-15-zhenzhong.duan@intel.com>
 <CACGkMEsq+VrxjGMf_ma=6xumwWgb2109XB4+86zH0ZXrce5Kdg@mail.gmail.com>
 <SJ0PR11MB6744B13E0A9C352E4E6EF74D925D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744B13E0A9C352E4E6EF74D925D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:24:17 +0800
Message-ID: <CACGkMEvxK_+foQ1WV6ykJyRxzAPZc80wBfw0c-j-D56jsrTvXA@mail.gmail.com>
Subject: Re: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.743,
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

On Fri, Nov 8, 2024 at 1:30=E2=80=AFPM Duan, Zhenzhong <zhenzhong.duan@inte=
l.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Jason Wang <jasowang@redhat.com>
> >Sent: Friday, November 8, 2024 12:42 PM
> >Subject: Re: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in =
scalable
> >modern mode
> >
> >On Mon, Sep 30, 2024 at 5:30=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@i=
ntel.com>
> >wrote:
> >>
> >> According to VTD spec, stage-1 page table could support 4-level and
> >> 5-level paging.
> >>
> >> However, 5-level paging translation emulation is unsupported yet.
> >> That means the only supported value for aw_bits is 48.
> >>
> >> So default aw_bits to 48 in scalable modern mode. In other cases,
> >> it is still default to 39 for backward compatibility.
> >>
> >> Add a check to ensure user specified value is 48 in modern mode
> >> for now.
> >>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.c=
om>
> >> ---
> >>  include/hw/i386/intel_iommu.h |  2 +-
> >>  hw/i386/intel_iommu.c         | 10 +++++++++-
> >>  2 files changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iom=
mu.h
> >> index b843d069cc..48134bda11 100644
> >> --- a/include/hw/i386/intel_iommu.h
> >> +++ b/include/hw/i386/intel_iommu.h
> >> @@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState,
> >INTEL_IOMMU_DEVICE)
> >>  #define DMAR_REG_SIZE               0x230
> >>  #define VTD_HOST_AW_39BIT           39
> >>  #define VTD_HOST_AW_48BIT           48
> >> -#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
> >> +#define VTD_HOST_AW_AUTO            0xff
> >>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
> >>
> >>  #define DMAR_REPORT_F_INTR          (1)
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index 91d7b1abfa..068a08f522 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -3776,7 +3776,7 @@ static Property vtd_properties[] =3D {
> >>                              ON_OFF_AUTO_AUTO),
> >>      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false=
),
> >>      DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
> >> -                      VTD_HOST_ADDRESS_WIDTH),
> >> +                      VTD_HOST_AW_AUTO),
> >>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode,
> >FALSE),
> >>      DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mod=
e,
> >FALSE),
> >>      DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control,
> >false),
> >> @@ -4683,6 +4683,14 @@ static bool vtd_decide_config(IntelIOMMUState *=
s,
> >Error **errp)
> >>          }
> >>      }
> >>
> >> +    if (s->aw_bits =3D=3D VTD_HOST_AW_AUTO) {
> >> +        if (s->scalable_modern) {
> >> +            s->aw_bits =3D VTD_HOST_AW_48BIT;
> >> +        } else {
> >> +            s->aw_bits =3D VTD_HOST_AW_39BIT;
> >> +        }
> >
> >I don't see how we maintain migration compatibility here.
>
> Imagine this cmdline: "-device intel-iommu,x-scalable-mode=3Don" which hi=
nts
> scalable legacy mode(a.k.a, stage-2 page table mode),
>
> without this patch, initial s->aw_bits value is VTD_HOST_ADDRESS_WIDTH(39=
).
>
> after this patch, initial s->aw_bit value is VTD_HOST_AW_AUTO(0xff),
> vtd_decide_config() is called by vtd_realize() to set s->aw_bit to VTD_HO=
ST_AW_39BIT(39).
>
> So as long as the QEMU cmdline is same, s->aw_bit is same with or without=
 this patch.

Ok, I guess the point is that the scalabe-modern mode is introduced in
this series so we won't bother.

But I see this:

+    if (s->scalable_modern && s->aw_bits !=3D VTD_HOST_AW_48BIT) {

In previous patches. So I wonder instead of mandating management to
set AUTO which seems like a burden. How about just increase the
default AW to 48bit and do the compatibility work here?

Thanks

>
> Thanks
> Zhenzhong


