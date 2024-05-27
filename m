Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E07C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUCE-00052m-V4; Mon, 27 May 2024 02:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sBUBy-0004ty-P4
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sBUBw-0000Pf-Os
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716792643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dDa4bMpvWiEHMuR82qvXVDrrC/FsJOmBeWPGv2pbl8=;
 b=SHyvLcVj+MXCeK0ZEVWexcDCu9vgXdNLx/L3GG8cq79uJiNS64/YjKBN8FJ1f3qA74kZrt
 lUZfpWsMiuRnZHLn8cxffEaxDiFvbFXyesuiHSruo8RtQdlw5MjeTKy3g3HPymTbJMKyvx
 Gs2U8/cXfUWjXk97RXspaDFZvr3f/Do=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-X48lnwmiOkiqo8Of7UMhlg-1; Mon, 27 May 2024 02:50:42 -0400
X-MC-Unique: X48lnwmiOkiqo8Of7UMhlg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57851ae6090so1366677a12.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 23:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716792641; x=1717397441;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3dDa4bMpvWiEHMuR82qvXVDrrC/FsJOmBeWPGv2pbl8=;
 b=p+e/ksR45VAB6Sm6tHsccP8mCQvOVEbCzV44Rbj4qoCd9LXoowgp8qJ9kt5wGKGEA8
 J3QiVxmhVNdHqZOCEAR5jl9YnWf2ZJrwYp79ffTItvuDM5/gu8Ni7Kfo916WDeiOuaBd
 C2MVMkNbwPdzuyE8f9kBTdRHmdc7MiENiBJDhkRb0PPjVKpSQYoCI8p/lsnnJfsXefvT
 HH8w9mKFjXnDDnDqSonR2J5CYBI0qZL5N3KD7EC9M01JYB/13iqZtARyWIa2dhSDpFRk
 1KcbpA/wnyEOQQTK10+bHKBnujlW4bMjzINszQbMJOByODtdpCLTwY+Dm3Sj83jk9rtV
 +VCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+uFhYOKS3VriWc4Ezu2+DW3JRsGEqQnbn77EROF+2GlvrYqfWwgUZEwebqeTPJBfxYkEqgR2QJJusU1SZN5bl8NvCs0s=
X-Gm-Message-State: AOJu0Yzr0u/d/9PEdZcnbw0pDOJLVaufi74Fq6T3xceFUjzdaoRtHJ7l
 r8LRWzBrIO6Glogr87o4nCCRG0C2IRkphr5NYwLb42JBqVJ3W3bj2rMdHDArqdynlqBNMr5izZa
 wj2Up3vJcmOCTK89HP5Mpqd2ndp0+pAZx+8w4bhfYUewLdD+TYsfJ
X-Received: by 2002:a05:600c:314c:b0:41c:5eb:4f8f with SMTP id
 5b1f17b1804b1-421089d7c33mr65293545e9.15.1716792640684; 
 Sun, 26 May 2024 23:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo/R5mU/xbZ3i3YkGTW3rRVx3+vTjHiG8Cvdnx2sIRL4LjYYnKj+W2aq9W/1YmpipZN4h6Iw==
X-Received: by 2002:a05:600c:314c:b0:41c:5eb:4f8f with SMTP id
 5b1f17b1804b1-421089d7c33mr65293365e9.15.1716792640060; 
 Sun, 26 May 2024 23:50:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:cd82:9c62:7faf:9d73:ba3f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089cc504sm98164625e9.40.2024.05.26.23.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 23:50:39 -0700 (PDT)
Date: Mon, 27 May 2024 02:50:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Yu Zhang <yu.c.zhang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Message-ID: <20240527025023-mutt-send-email-mst@kernel.org>
References: <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
 <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB67448F0D3CE487F125D274AF92F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB67448F0D3CE487F125D274AF92F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 06:44:58AM +0000, Duan, Zhenzhong wrote:
> Hi Jason,
> 
> >-----Original Message-----
> >From: Duan, Zhenzhong
> >Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by
> >spec
> >
> >
> >
> >>-----Original Message-----
> >>From: Jason Wang <jasowang@redhat.com>
> >>Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by
> >>spec
> >>
> >>On Fri, May 24, 2024 at 4:41 PM Duan, Zhenzhong
> >><zhenzhong.duan@intel.com> wrote:
> >>>
> >>>
> >>>
> >>> >-----Original Message-----
> >>> >From: Jason Wang <jasowang@redhat.com>
> >>> >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined
> >by
> >>> >spec
> >>> >
> >>> >On Tue, May 21, 2024 at 6:25 PM Duan, Zhenzhong
> >>> ><zhenzhong.duan@intel.com> wrote:
> >>> >>
> >>> >>
> >>> >>
> >>> >> >-----Original Message-----
> >>> >> >From: Jason Wang <jasowang@redhat.com>
> >>> >> >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons
> >defined
> >>by
> >>> >> >spec
> >>> >> >
> >>> >> >On Mon, May 20, 2024 at 12:15 PM Liu, Yi L <yi.l.liu@intel.com>
> >>wrote:
> >>> >> >>
> >>> >> >> > From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >>> >> >> > Sent: Monday, May 20, 2024 11:41 AM
> >>> >> >> >
> >>> >> >> >
> >>> >> >> >
> >>> >> >> > >-----Original Message-----
> >>> >> >> > >From: Jason Wang <jasowang@redhat.com>
> >>> >> >> > >Sent: Monday, May 20, 2024 8:44 AM
> >>> >> >> > >To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >>> >> >> > >Cc: qemu-devel@nongnu.org; Liu, Yi L <yi.l.liu@intel.com>; Peng,
> >>> >Chao
> >>> >> >P
> >>> >> >> > ><chao.p.peng@intel.com>; Yu Zhang
> >><yu.c.zhang@linux.intel.com>;
> >>> >> >Michael
> >>> >> >> > >S. Tsirkin <mst@redhat.com>; Paolo Bonzini
> >>> ><pbonzini@redhat.com>;
> >>> >> >> > >Richard Henderson <richard.henderson@linaro.org>; Eduardo
> >>> >Habkost
> >>> >> >> > ><eduardo@habkost.net>; Marcel Apfelbaum
> >>> >> ><marcel.apfelbaum@gmail.com>
> >>> >> >> > >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons
> >>> >defined
> >>> >> >by
> >>> >> >> > >spec
> >>> >> >> > >
> >>> >> >> > >On Fri, May 17, 2024 at 6:26 PM Zhenzhong Duan
> >>> >> >> > ><zhenzhong.duan@intel.com> wrote:
> >>> >> >> > >>
> >>> >> >> > >> From: Yu Zhang <yu.c.zhang@linux.intel.com>
> >>> >> >> > >>
> >>> >> >> > >> Currently we use only VTD_FR_PASID_TABLE_INV as fault
> >>reason.
> >>> >> >> > >> Update with more detailed fault reasons listed in VT-d spec
> >>7.2.3.
> >>> >> >> > >>
> >>> >> >> > >> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> >>> >> >> > >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >>> >> >> > >> ---
> >>> >> >> > >
> >>> >> >> > >I wonder if this could be noticed by the guest or not. If yes
> >should
> >>> >> >> > >we consider starting to add thing like version to vtd emulation
> >>code?
> >>> >> >> >
> >>> >> >> > Kernel only dumps the reason like below:
> >>> >> >> >
> >>> >> >> > DMAR: [DMA Write NO_PASID] Request device [20:00.0] fault
> >addr
> >>> >> >0x1234600000
> >>> >> >> > [fault reason 0x71] SM: Present bit in first-level paging entry is
> >>clear
> >>> >> >>
> >>> >> >> Yes, guest kernel would notice it as the fault would be injected to
> >vm.
> >>> >> >>
> >>> >> >> > Maybe bump 1.0 -> 1.1?
> >>> >> >> > My understanding version number is only informational and is
> >far
> >>> >from
> >>> >> >> > accurate to mark if a feature supported. Driver should check
> >>cap/ecap
> >>> >> >> > bits instead.
> >>> >> >>
> >>> >> >> Should the version ID here be aligned with VT-d spec?
> >>> >> >
> >>> >> >Probably, this might be something that could be noticed by the
> >>> >> >management to migration compatibility.
> >>> >>
> >>> >> Could you elaborate what we need to do for migration compatibility?
> >>> >> I see version is already exported so libvirt can query it, see:
> >>> >>
> >>> >>     DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
> >>> >
> >>> >It is the Qemu command line parameters not the version of the vmstate.
> >>> >
> >>> >For example -device intel-iommu,version=3.0
> >>> >
> >>> >Qemu then knows it should behave as 3.0.
> >>>
> >>> So you want to bump vtd_vmstate.version?
> >>
> >>Well, as I said, it's not a direct bumping.
> >>
> >>>
> >>> In fact, this series change intel_iommu property from x-scalable-
> >>mode=["on"|"off"]"
> >>> to x-scalable-mode=["legacy"|"modern"|"off"]".
> >>>
> >>> My understanding management app should use same qemu cmdline
> >>> in source and destination, so compatibility is already guaranteed even if
> >>> we don't bump vtd_vmstate.version.
> >>
> >>Exactly, so the point is to
> >>
> >>vtd=3.0, the device works exactly as vtd spec 3.0.
> >>vtd=3.3, the device works exactly as vtd spec 3.3.
> 
> Yi just found version ID stored in VT-d VER_REG is not aligned with the VT-d spec version.
> For example, we see a local hw with vtd version 6.0 which is beyond VT-d spec version.
> We are asking VTD arch, will get back soon.
> 
> Or will you plan qemu vVT-d having its own version policy?
> 
> Thanks
> Zhenzhong

Not unless there's a good reason to do this.

> >
> >Get your point. But I have some concerns about this:
> >1.Exact version matching will bring vast of version check in the code,
> >   especially when we support more versions.
> >2. There are some missed features before we can update version number to
> >3.0,
> >    i.e., nested translation, Accessed/Dirty (A/D) bits, 5 level page table, etc.
> >3. Some features are removed in future versions, but we still need to
> >   implement them for intermediate version,
> >   i.e., ExecuteRequested (ER), Advanced Fault Logging, etc.
> >
> >>
> >>When migration to the old qemu, mgmt can specify e.g vtd=3.0 for
> >>backward migration compatibility.
> >
> >Yes, that makes sense for such migration.
> >But I'm not sure if there is a real scenario migrating to old qemu,
> >why not just update qemu on destination?
> >
> >Thanks
> >Zhenzhong
> 


