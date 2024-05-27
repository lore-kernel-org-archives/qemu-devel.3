Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCD1C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 03:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQvx-00048l-JI; Sun, 26 May 2024 23:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sBQvv-00046x-F6
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sBQvt-0005WZ-OB
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716780115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/dnm8N3diEOuN7i2diwW/1b4MoZ1ZDBNBlb+MkEwR8=;
 b=Rl1+SbhHghREJ/095R1SCAIzE0fmbJ7fIRCAd6MUhdT7lo1QArmlGUMBoDJ8nY1CwREzrd
 rAdP/zVMZnrsDCz7+78X1vdhgU78z96J0wieY2G2RFMNHyEogNl/wJug0otBkbXU78ZswE
 /dQ/V9L/ohgBA5rP9OmcJCtYm+xNAmA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-lSd3cgZSOpyC4rFBOUbQvw-1; Sun, 26 May 2024 23:21:54 -0400
X-MC-Unique: lSd3cgZSOpyC4rFBOUbQvw-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6818f651293so2742628a12.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 20:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716780113; x=1717384913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/dnm8N3diEOuN7i2diwW/1b4MoZ1ZDBNBlb+MkEwR8=;
 b=D0ePExcynjLtT/W2M65F4Wv+WHiVx2gF9s1qMcgDi3ec/juiocKMCGF3kAjVCC5RkE
 +Cal8kp8ze6W5wjjkZerLJMBxLjZGjFZxIPOIPsn4ONm63d9huszqZsYuKVPop+akSf+
 TffXli1jBjk/ySw7N0FMfjfwbvZkpng10AEH5VGdgElMmiGgT339RfAAc0hjT/pLXkMK
 rYddmKAUyaMmWh9GQFh/vSiMIq8rLedcJ9ENkG0h044aM7y9rkQBdRBSpvqYnWqDlR8w
 4lHUlnfROAW1ov7etgmPC9kW0uh6SPxa0W0uThOwI14MbcCMWH5OHWu1nxkuouC/UlZt
 smEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVemRd8OfGvnAi+qdGg6/Pf5WRDKTBBTQz7MZG5r3jtJmKiIQhDd0mb7m4isTuE//OiFMmYDBF8W1tro/tHjYTNYF60Df8=
X-Gm-Message-State: AOJu0YxTM/UL7Yp0dkXSRFfVvhSEQ4sGod90FTnHNPElgbRYrbroaWaX
 JG9TGYHNmux+dOWa1+q4ZuvHrTLWFKfMhL9DkBbPPjDIKlpyl9ipYrkbI5TsV18N8dyc9A/CH/g
 KKeEl27wn1ZM1rOHAXkGGF1cnZ18Hzp3b030DW0qz4m4KUT2xQrvUuGC/m6SET4MmQP8F4fpCtG
 SJvD2QMj5Y11e+9iBnq3aQb5V+UTY=
X-Received: by 2002:a05:6a21:9991:b0:1b1:cce2:51d3 with SMTP id
 adf61e73a8af0-1b212f63a2dmr8867602637.54.1716780112916; 
 Sun, 26 May 2024 20:21:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoZQO9OLI5XezbqN9OV9dLYImMYM/XLNPaDhBSoPjPoFy2P1h6BM6JrxgH+ONsIBwQeMDk1gctH8cKzwBWoDQ=
X-Received: by 2002:a05:6a21:9991:b0:1b1:cce2:51d3 with SMTP id
 adf61e73a8af0-1b212f63a2dmr8867588637.54.1716780112530; Sun, 26 May 2024
 20:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 May 2024 11:21:41 +0800
Message-ID: <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
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
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, May 24, 2024 at 4:41=E2=80=AFPM Duan, Zhenzhong
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
> >On Tue, May 21, 2024 at 6:25=E2=80=AFPM Duan, Zhenzhong
> ><zhenzhong.duan@intel.com> wrote:
> >>
> >>
> >>
> >> >-----Original Message-----
> >> >From: Jason Wang <jasowang@redhat.com>
> >> >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons define=
d by
> >> >spec
> >> >
> >> >On Mon, May 20, 2024 at 12:15=E2=80=AFPM Liu, Yi L <yi.l.liu@intel.co=
m> wrote:
> >> >>
> >> >> > From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >> >> > Sent: Monday, May 20, 2024 11:41 AM
> >> >> >
> >> >> >
> >> >> >
> >> >> > >-----Original Message-----
> >> >> > >From: Jason Wang <jasowang@redhat.com>
> >> >> > >Sent: Monday, May 20, 2024 8:44 AM
> >> >> > >To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >> >> > >Cc: qemu-devel@nongnu.org; Liu, Yi L <yi.l.liu@intel.com>; Peng,
> >Chao
> >> >P
> >> >> > ><chao.p.peng@intel.com>; Yu Zhang <yu.c.zhang@linux.intel.com>;
> >> >Michael
> >> >> > >S. Tsirkin <mst@redhat.com>; Paolo Bonzini
> ><pbonzini@redhat.com>;
> >> >> > >Richard Henderson <richard.henderson@linaro.org>; Eduardo
> >Habkost
> >> >> > ><eduardo@habkost.net>; Marcel Apfelbaum
> >> ><marcel.apfelbaum@gmail.com>
> >> >> > >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons
> >defined
> >> >by
> >> >> > >spec
> >> >> > >
> >> >> > >On Fri, May 17, 2024 at 6:26=E2=80=AFPM Zhenzhong Duan
> >> >> > ><zhenzhong.duan@intel.com> wrote:
> >> >> > >>
> >> >> > >> From: Yu Zhang <yu.c.zhang@linux.intel.com>
> >> >> > >>
> >> >> > >> Currently we use only VTD_FR_PASID_TABLE_INV as fault reason.
> >> >> > >> Update with more detailed fault reasons listed in VT-d spec 7.=
2.3.
> >> >> > >>
> >> >> > >> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> >> >> > >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> >> > >> ---
> >> >> > >
> >> >> > >I wonder if this could be noticed by the guest or not. If yes sh=
ould
> >> >> > >we consider starting to add thing like version to vtd emulation =
code?
> >> >> >
> >> >> > Kernel only dumps the reason like below:
> >> >> >
> >> >> > DMAR: [DMA Write NO_PASID] Request device [20:00.0] fault addr
> >> >0x1234600000
> >> >> > [fault reason 0x71] SM: Present bit in first-level paging entry i=
s clear
> >> >>
> >> >> Yes, guest kernel would notice it as the fault would be injected to=
 vm.
> >> >>
> >> >> > Maybe bump 1.0 -> 1.1?
> >> >> > My understanding version number is only informational and is far
> >from
> >> >> > accurate to mark if a feature supported. Driver should check cap/=
ecap
> >> >> > bits instead.
> >> >>
> >> >> Should the version ID here be aligned with VT-d spec?
> >> >
> >> >Probably, this might be something that could be noticed by the
> >> >management to migration compatibility.
> >>
> >> Could you elaborate what we need to do for migration compatibility?
> >> I see version is already exported so libvirt can query it, see:
> >>
> >>     DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
> >
> >It is the Qemu command line parameters not the version of the vmstate.
> >
> >For example -device intel-iommu,version=3D3.0
> >
> >Qemu then knows it should behave as 3.0.
>
> So you want to bump vtd_vmstate.version?

Well, as I said, it's not a direct bumping.

>
> In fact, this series change intel_iommu property from x-scalable-mode=3D[=
"on"|"off"]"
> to x-scalable-mode=3D["legacy"|"modern"|"off"]".
>
> My understanding management app should use same qemu cmdline
> in source and destination, so compatibility is already guaranteed even if
> we don't bump vtd_vmstate.version.

Exactly, so the point is to

vtd=3D3.0, the device works exactly as vtd spec 3.0.
vtd=3D3.3, the device works exactly as vtd spec 3.3.

When migration to the old qemu, mgmt can specify e.g vtd=3D3.0 for
backward migration compatibility.

Thanks

>
> Thanks
> Zhenzhong


