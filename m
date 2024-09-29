Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254E5CF6491
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 02:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sujH6-0002g1-Jt; Sat, 28 Sep 2024 22:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sujGz-0002fG-Un
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 22:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sujGy-0002sZ-6z
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 22:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727575373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7I58yPD+Tqp89SrpZY+YC/NbKDlMoBqgWao2IpkQpY0=;
 b=PZvP43PWu0WYMVXMXLfltkktAvY1uitPNWPsjabvD6nV6AAj4GBe468YUN/usbeDigVlWk
 5WWGZAOwpDdspX4kCMYVW2hxJxNGtqMUNrkvEGkCE88axb5wmCMS9hcEhy2yYqS2qGW6Yc
 6I3gW+1mqQXYobl2Sgp7Mc1Q5uHbSV4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-7shg1rfLNMiNrZBe5mDiJA-1; Sat, 28 Sep 2024 22:02:52 -0400
X-MC-Unique: 7shg1rfLNMiNrZBe5mDiJA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2db5d285f7cso3348354a91.1
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 19:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727575371; x=1728180171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7I58yPD+Tqp89SrpZY+YC/NbKDlMoBqgWao2IpkQpY0=;
 b=hcJ5sC1FwURZxtsyVN+a0Bc0mJGX8MqIy+PCpAKhTwH0DBOoNEXZxKTq//TRR3pzQx
 OevHOmPB9moEJ3ASl0M9uetFO7fQOW4K5I8sERquIPYcPa1TkGNZLeu7wZPBwtQK2MdF
 to3hnSZBanS4xTmfBPJkGKskF6asWUx0TjXbB/rwuX6IrhO0VKrGURvogVL0NhzxPUL8
 EFxbNfEsPUbDE3QABV/IUULodAv5QVwKTFReUx+cWymbu9IEKc7ZBslS0nKnjj7ptbLD
 q3ITezKVrZMkvpTDFluAYTND7hn/S6rZJF3Cdb2dPu0KLJkroawfoNYD+qkfLkzhcKvh
 DtcA==
X-Gm-Message-State: AOJu0YyZS3jXbDGx/FzVUGZxvx58zFgm6uxfaymiVDZ7Y+9gld9wqOqY
 cMxmW55uz89A6UcOr6Iy/KvVG/17Z6DFfktZS6A4CDNDBX4+2sebXY54XwcPI4mq9Rx/VL1N8uR
 xh4iBT61MbcmL3+DaJ3u5bCIn1kGwx0QKamssXVonzWcUytq8zF9Hlu1sOjQTacJ4E+R+/c+9t7
 b+YuvgzVaMpCY371/zL60sb3WeayQ=
X-Received: by 2002:a17:90a:77c4:b0:2d8:8430:8a91 with SMTP id
 98e67ed59e1d1-2e0b89d4ccbmr9757967a91.10.1727575371299; 
 Sat, 28 Sep 2024 19:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJG28BIVrJSVnfu4e5nIOWL8f/vzmozKuoFmg6ksb4MjwMTtGldAUTjx9CLSn8havWjXVaFwLsSawHMZdxk/Y=
X-Received: by 2002:a17:90a:77c4:b0:2d8:8430:8a91 with SMTP id
 98e67ed59e1d1-2e0b89d4ccbmr9757932a91.10.1727575370828; Sat, 28 Sep 2024
 19:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-15-zhenzhong.duan@intel.com>
 <CACGkMEuV=ZdnGE7N=YehCxpNiVPXai=WUdgJjnxVxwzBnTMEOQ@mail.gmail.com>
 <SJ0PR11MB6744CF33309D78D902DD052E926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744CF33309D78D902DD052E926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Sep 2024 10:02:39 +0800
Message-ID: <CACGkMEvn3HUwhmHE0dvg+g-o0jpH2g-xHciZ_u8CH75qm7KdkQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/17] intel_iommu: Set default aw_bits to 48 in
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

On Fri, Sep 27, 2024 at 2:39=E2=80=AFPM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Jason Wang <jasowang@redhat.com>
> >Subject: Re: [PATCH v3 14/17] intel_iommu: Set default aw_bits to 48 in
> >scalable modern mode
> >
> >On Wed, Sep 11, 2024 at 1:27=E2=80=AFPM Zhenzhong Duan
> ><zhenzhong.duan@intel.com> wrote:
> >>
> >> According to VTD spec, stage-1 page table could support 4-level and
> >> 5-level paging.
> >>
> >> However, 5-level paging translation emulation is unsupported yet.
> >> That means the only supported value for aw_bits is 48.
> >>
> >> So default aw_bits to 48 in scalable modern mode. In other cases,
> >> it is still default to 39 for compatibility.
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
> >> diff --git a/include/hw/i386/intel_iommu.h
> >b/include/hw/i386/intel_iommu.h
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
> >> index c25211ddaf..949f120456 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -3771,7 +3771,7 @@ static Property vtd_properties[] =3D {
> >>                              ON_OFF_AUTO_AUTO),
> >>      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim,
> >false),
> >>      DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
> >> -                      VTD_HOST_ADDRESS_WIDTH),
> >> +                      VTD_HOST_AW_AUTO),
> >
> >Such command line API seems to be wired.
> >
> >I think we can stick the current default and when scalable modern is
> >enabled by aw is not specified, we can change aw to 48?
>
> Current default is 39. I use VTD_HOST_AW_AUTO to initialize aw as not spe=
cified.

If I read the code correctly, aw=3D0xff means "auto". This seems a
little bit wried.

And even if we change it to auto, we need deal with the migration
compatibility that stick 39 for old machine types.

> Do we have other way to catch the update if we stick to 39?

I meant I don't understand if there will be any issue if we keep use
39 as default. Or I may not get the point of this question.

Thanks

>
> Thanks
> Zhenzhong
>
> >
> >>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode,
> >FALSE),
> >>      DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState,
> >scalable_mode, FALSE),
> >>      DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control,
> >false),
> >> @@ -4686,6 +4686,14 @@ static bool
> >vtd_decide_config(IntelIOMMUState *s, Error **errp)
> >>          }
> >>      }
> >>
> >> +    if (s->aw_bits =3D=3D VTD_HOST_AW_AUTO) {
> >> +        if (s->scalable_modern) {
> >> +            s->aw_bits =3D VTD_HOST_AW_48BIT;
> >> +        } else {
> >> +            s->aw_bits =3D VTD_HOST_AW_39BIT;
> >> +        }
> >> +    }
> >> +
> >>      if ((s->aw_bits !=3D VTD_HOST_AW_39BIT) &&
> >>          (s->aw_bits !=3D VTD_HOST_AW_48BIT) &&
> >>          !s->scalable_modern) {
> >> --
> >> 2.34.1
> >>
> >
> >Thanks
>


