Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298B3C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 08:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9h5z-0004qy-D8; Wed, 22 May 2024 04:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s9h5x-0004qi-Mr
 for qemu-devel@nongnu.org; Wed, 22 May 2024 04:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s9h5v-0000rB-H3
 for qemu-devel@nongnu.org; Wed, 22 May 2024 04:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716365586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDzuOkB9ikSOxYzt+GfFvlOkKo4pcN9AiF+EeVMA0e0=;
 b=gmp/LBo/+eUEh3d7dX7fHGM57nGj+rq+uzmSLGfJDkER4lIXubgSbQCpfvyTYvDf51tCu5
 sjFXGRqjlDxHusH83co+uQVvBQH1/aI7STNtNTQ164Dy0hyXdsT5V/M3ZARJXcT4s833Dj
 x1M8odryD0GtC1dRNJvf2cEyxKpr86g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-dtqQc-bhPg209zWqwqxmKQ-1; Wed, 22 May 2024 04:13:04 -0400
X-MC-Unique: dtqQc-bhPg209zWqwqxmKQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2bd92c35e65so1616462a91.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 01:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716365583; x=1716970383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDzuOkB9ikSOxYzt+GfFvlOkKo4pcN9AiF+EeVMA0e0=;
 b=KXekThSYLHtXyNYZnYH18vxnUQHoOgBFatpd4mJG2aYAS7JqDT+mv4EDuikc8kPMLI
 VWtV6ELa5bjjUn1jlqpSEpZYC6cIq5zo3bJ/zxUR2vJ53jaa9znGuGntGbiRCxZFfo1W
 ugo1H0Jyn2vhiW5klWQcSzd0qtFEj+Y0PPrRs+MMUZAmSgpsZlGgObVpXHvzUcZl6pNf
 4vI3tMou0G307CtKJUpp1UrmC3NsoT0YZz+HJDsgt3cGf5wT3ZIgMt3UyfPttUG8KDG0
 NiF7uaAtRmfUgeZUKrOm/ynUK9ni5ySoFp2f7joJ9V+QNwaGNbtoJ1CIMybmK50/9AwV
 otTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7gAkgvLN1KLy4KT3treHZu1Wi1JmXpZuK7/BtZh0sb838b6HsWqftlkF/HkpE/AkTCD7WcdTYM1BXpsGmtITgbJYq3dE=
X-Gm-Message-State: AOJu0Yz5d8ayo1NVgR6avDtn/ncYrudnPOtLinmDhAC8iSOthZfiS9pi
 tPGKoVKizGzepBTYsswNbUK0LFJ5Xn5bWeaTJalgtCGmkN4On5jEMs4KO9nSAHUoeGdHM7UdW/L
 TvW+aELXTAmXOnOuf9tB8NAad2DVpfA/0QvJGCHeYFd10hrUANwzcdjcoUIre0OJhqwfRw+IDOS
 AJ6PuFgoa3VZa2pvfZaxuqctc1ias=
X-Received: by 2002:a17:90a:5215:b0:2bd:9256:8ce0 with SMTP id
 98e67ed59e1d1-2bd9f461ecemr1461617a91.14.1716365583248; 
 Wed, 22 May 2024 01:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR537pZTH1/XAaC/CchRxpYcCsxrFJd/4X3sjG2hu1ZNSqVfhXLyDH1fN1hSJ6PQv8t5qV9Q8irg95CM0WkIM=
X-Received: by 2002:a17:90a:5215:b0:2bd:9256:8ce0 with SMTP id
 98e67ed59e1d1-2bd9f461ecemr1461594a91.14.1716365582815; Wed, 22 May 2024
 01:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 May 2024 16:12:51 +0800
Message-ID: <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Peng, Chao P" <chao.p.peng@intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 21, 2024 at 6:25=E2=80=AFPM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Jason Wang <jasowang@redhat.com>
> >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined b=
y
> >spec
> >
> >On Mon, May 20, 2024 at 12:15=E2=80=AFPM Liu, Yi L <yi.l.liu@intel.com> =
wrote:
> >>
> >> > From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >> > Sent: Monday, May 20, 2024 11:41 AM
> >> >
> >> >
> >> >
> >> > >-----Original Message-----
> >> > >From: Jason Wang <jasowang@redhat.com>
> >> > >Sent: Monday, May 20, 2024 8:44 AM
> >> > >To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >> > >Cc: qemu-devel@nongnu.org; Liu, Yi L <yi.l.liu@intel.com>; Peng, Ch=
ao
> >P
> >> > ><chao.p.peng@intel.com>; Yu Zhang <yu.c.zhang@linux.intel.com>;
> >Michael
> >> > >S. Tsirkin <mst@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> >> > >Richard Henderson <richard.henderson@linaro.org>; Eduardo Habkost
> >> > ><eduardo@habkost.net>; Marcel Apfelbaum
> ><marcel.apfelbaum@gmail.com>
> >> > >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defi=
ned
> >by
> >> > >spec
> >> > >
> >> > >On Fri, May 17, 2024 at 6:26=E2=80=AFPM Zhenzhong Duan
> >> > ><zhenzhong.duan@intel.com> wrote:
> >> > >>
> >> > >> From: Yu Zhang <yu.c.zhang@linux.intel.com>
> >> > >>
> >> > >> Currently we use only VTD_FR_PASID_TABLE_INV as fault reason.
> >> > >> Update with more detailed fault reasons listed in VT-d spec 7.2.3=
.
> >> > >>
> >> > >> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> >> > >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> > >> ---
> >> > >
> >> > >I wonder if this could be noticed by the guest or not. If yes shoul=
d
> >> > >we consider starting to add thing like version to vtd emulation cod=
e?
> >> >
> >> > Kernel only dumps the reason like below:
> >> >
> >> > DMAR: [DMA Write NO_PASID] Request device [20:00.0] fault addr
> >0x1234600000
> >> > [fault reason 0x71] SM: Present bit in first-level paging entry is c=
lear
> >>
> >> Yes, guest kernel would notice it as the fault would be injected to vm=
.
> >>
> >> > Maybe bump 1.0 -> 1.1?
> >> > My understanding version number is only informational and is far fro=
m
> >> > accurate to mark if a feature supported. Driver should check cap/eca=
p
> >> > bits instead.
> >>
> >> Should the version ID here be aligned with VT-d spec?
> >
> >Probably, this might be something that could be noticed by the
> >management to migration compatibility.
>
> Could you elaborate what we need to do for migration compatibility?
> I see version is already exported so libvirt can query it, see:
>
>     DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),

It is the Qemu command line parameters not the version of the vmstate.

For example -device intel-iommu,version=3D3.0

Qemu then knows it should behave as 3.0.

Thanks

>
> Thanks
> Zhenzhong
>
> >
> >> If yes, it should
> >> be 3.0 as the scalable mode was introduced in spec 3.0. And the fault
> >> code was redefined together with the introduction of this translation
> >> mode. Below is the a snippet from the change log of VT-d spec.
> >>
> >> June 2018 3.0
> >> =E2=80=A2 Removed all text related to Extended-Mode.
> >> =E2=80=A2 Added support for scalable-mode translation for DMA Remappin=
g, that
> >enables PASIDgranular first-level, second-level, nested and pass-through
> >translation functions.
> >> =E2=80=A2 Widen invalidation queue descriptors and page request queue
> >descriptors from 128 bits
> >> to 256 bits and redefined page-request and page-response descriptors.
> >> =E2=80=A2 Listed all fault conditions in a unified table and described=
 DMA
> >Remapping hardware
> >> behavior under each condition. Assigned new code for each fault condit=
ion
> >in scalablemode operation.
> >> =E2=80=A2 Added support for Accessed/Dirty (A/D) bits in second-level =
translation.
> >> =E2=80=A2 Added support for submitting commands and receiving response=
 from
> >virtual DMA
> >> Remapping hardware.
> >> =E2=80=A2 Added a table on snooping behavior and memory type of hardwa=
re
> >access to various
> >> remapping structures as appendix.
> >> =E2=80=A2 Move Page Request Overflow (PRO) fault reporting from Fault =
Status
> >register
> >> (FSTS_REG) to Page Request Status register (PRS_REG).
> >>
> >> Regards.
> >> Yi Liu
> >
> >Thanks
>


