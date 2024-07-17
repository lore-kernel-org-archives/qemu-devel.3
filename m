Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC38C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxmp-0008QF-7m; Wed, 17 Jul 2024 02:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTxmm-0008IL-Vt
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:05:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTxmj-0001vC-8h
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721196302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+H1GvKx983QaePpsNkoOb/6NKN1jQYpbi86GZ41aOY=;
 b=U0lEaqRnhV2Ko0aCie7VAT1G5CE1qANolOGz88R729pMfpd5Cwc3LZMOcDOHiFIczP8Gee
 XdFvlR//e6PbW+fin+UMLOeErxZqDbYzeMuDnUr4yFHoA/HtKolfQwODfE1Tgl6W4DUMsG
 Sa3VlUEjJ+L9MKm9h1gAENke6a0TJSk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-rSUuU8JBOt2VhYihjehHuA-1; Wed, 17 Jul 2024 02:04:59 -0400
X-MC-Unique: rSUuU8JBOt2VhYihjehHuA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4265464ddc9so2123305e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196298; x=1721801098;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7+H1GvKx983QaePpsNkoOb/6NKN1jQYpbi86GZ41aOY=;
 b=upaZgfsO5mGK1mczaixQKNakYWNmcWVPvjQz40Iz2hiNlVEPGFBZyta/zN5fNwh2Q1
 ds3QTRK9Q59IwI/xm42hDWRCQMzxBSvIc1jttl9u4traPq6qfe9nYrTn/28qt0zrHLS4
 WkN4O5bY/MM5D/OG9/s7iV39EERtiqVEFZLCweuFcGuJX5I6a3ZLqEvlvG53URsuGGv+
 iknAWlNaoKcp8euG7isPuNpbf9gvfKYIhuoNf5xM39oAT2I7Bp3RngAPGvB0TcbBpnCQ
 D49VqRezqOuAdPEZzikLJBh9onDrBKTjMlxuImsjUCXy5+UVltdDYBokCdAkUSfJ2geH
 zWiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7+TeXvgAt1VVJ9R1X0A+2JrFY7Q5AGaDpvL/o7xyO3LqLAcpLiDBnWYfkt40qJz4x0vKdrkkUrqQX7b+ONBYwUA99Qho=
X-Gm-Message-State: AOJu0YxDMFaDoUwBcWZ/66W/71q2CHyP366suS62RZPARq9FsIRf/Uyd
 SV7zGgjPwwR3FMeL2mrPOhdsAeNwSTu2ROB3u+ofg9/+M78ckIOrm9hBMxnTrG6Rg0f/MW6Dl+C
 9CvfMwpzomD2gFXMwD+GrFsQXR9oSGN94ucj0UmiShg02JM+5JUJA
X-Received: by 2002:a05:600c:4e8f:b0:427:aab7:976b with SMTP id
 5b1f17b1804b1-427bb687b1emr31739295e9.5.1721196298189; 
 Tue, 16 Jul 2024 23:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6vVoyAC7/Og1YQSeBoilgle3lAzOpLxSzgPvmQ/2bZRcw7GfqUMRQwYiJYoXrg/f1ZnZQAQ==
X-Received: by 2002:a05:600c:4e8f:b0:427:aab7:976b with SMTP id
 5b1f17b1804b1-427bb687b1emr31739015e9.5.1721196297555; 
 Tue, 16 Jul 2024 23:04:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:360d:da73:bbf7:ba86:37fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f276b8dsm192287415e9.21.2024.07.16.23.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:04:56 -0700 (PDT)
Date: Wed, 17 Jul 2024 02:04:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Yu Zhang <yu.c.zhang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Message-ID: <20240717020445-mutt-send-email-mst@kernel.org>
References: <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
 <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB67448F0D3CE487F125D274AF92F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240527025023-mutt-send-email-mst@kernel.org>
 <CACGkMEuCqCNhVvXYN6jT5CDHbnt8sEHUk2UfwVaaOVLXfSfv3w@mail.gmail.com>
 <a791e442-f5b5-4670-9394-876b041cfd62@intel.com>
 <SJ0PR11MB6744F95EB6B6182D90DE8D8392A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB6744F95EB6B6182D90DE8D8392A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Jul 17, 2024 at 03:30:03AM +0000, Duan, Zhenzhong wrote:
> Hi Michael, Jason,
> 
> Based on Yi's analysis, is keeping current VERSION value acceptable for you?

I think it's fine.

> Look forward to your comments, currently this open blocks us from sending the next version.
> 
> Thanks
> Zhenzhong
> 
> >-----Original Message-----
> >From: Liu, Yi L <yi.l.liu@intel.com>
> >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by
> >spec
> >
> >Hi Michael, Jason,
> >
> >On 2024/5/28 11:03, Jason Wang wrote:
> >> On Mon, May 27, 2024 at 2:50 PM Michael S. Tsirkin <mst@redhat.com>
> >wrote:
> >>>
> >>> On Mon, May 27, 2024 at 06:44:58AM +0000, Duan, Zhenzhong wrote:
> >>>> Hi Jason,
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Duan, Zhenzhong
> >>>>> Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined
> >by
> >>>>> spec
> >>>>>
> >>>>>
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Jason Wang <jasowang@redhat.com>
> >>>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons
> >defined by
> >>>>>> spec
> >>>>>>
> >>>>>> On Fri, May 24, 2024 at 4:41 PM Duan, Zhenzhong
> >>>>>> <zhenzhong.duan@intel.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>> -----Original Message-----
> >>>>>>>> From: Jason Wang <jasowang@redhat.com>
> >>>>>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons
> >defined
> >>>>> by
> >>>>>>>> spec
> >>>>>>>>
> >>>>>>>> On Tue, May 21, 2024 at 6:25 PM Duan, Zhenzhong
> >>>>>>>> <zhenzhong.duan@intel.com> wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> -----Original Message-----
> >>>>>>>>>> From: Jason Wang <jasowang@redhat.com>
> >>>>>>>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons
> >>>>> defined
> >>>>>> by
> >>>>>>>>>> spec
> >>>>>>>>>>
> >>>>>>>>>> On Mon, May 20, 2024 at 12:15 PM Liu, Yi L <yi.l.liu@intel.com>
> >>>>>> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >>>>>>>>>>>> Sent: Monday, May 20, 2024 11:41 AM
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>> -----Original Message-----
> >>>>>>>>>>>>> From: Jason Wang <jasowang@redhat.com>
> >>>>>>>>>>>>> Sent: Monday, May 20, 2024 8:44 AM
> >>>>>>>>>>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >>>>>>>>>>>>> Cc: qemu-devel@nongnu.org; Liu, Yi L <yi.l.liu@intel.com>;
> >Peng,
> >>>>>>>> Chao
> >>>>>>>>>> P
> >>>>>>>>>>>>> <chao.p.peng@intel.com>; Yu Zhang
> >>>>>> <yu.c.zhang@linux.intel.com>;
> >>>>>>>>>> Michael
> >>>>>>>>>>>>> S. Tsirkin <mst@redhat.com>; Paolo Bonzini
> >>>>>>>> <pbonzini@redhat.com>;
> >>>>>>>>>>>>> Richard Henderson <richard.henderson@linaro.org>;
> >Eduardo
> >>>>>>>> Habkost
> >>>>>>>>>>>>> <eduardo@habkost.net>; Marcel Apfelbaum
> >>>>>>>>>> <marcel.apfelbaum@gmail.com>
> >>>>>>>>>>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault
> >reasons
> >>>>>>>> defined
> >>>>>>>>>> by
> >>>>>>>>>>>>> spec
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On Fri, May 17, 2024 at 6:26 PM Zhenzhong Duan
> >>>>>>>>>>>>> <zhenzhong.duan@intel.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> From: Yu Zhang <yu.c.zhang@linux.intel.com>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Currently we use only VTD_FR_PASID_TABLE_INV as fault
> >>>>>> reason.
> >>>>>>>>>>>>>> Update with more detailed fault reasons listed in VT-d spec
> >>>>>> 7.2.3.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> >>>>>>>>>>>>>> Signed-off-by: Zhenzhong Duan
> ><zhenzhong.duan@intel.com>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I wonder if this could be noticed by the guest or not. If yes
> >>>>> should
> >>>>>>>>>>>>> we consider starting to add thing like version to vtd
> >emulation
> >>>>>> code?
> >>>>>>>>>>>>
> >>>>>>>>>>>> Kernel only dumps the reason like below:
> >>>>>>>>>>>>
> >>>>>>>>>>>> DMAR: [DMA Write NO_PASID] Request device [20:00.0] fault
> >>>>> addr
> >>>>>>>>>> 0x1234600000
> >>>>>>>>>>>> [fault reason 0x71] SM: Present bit in first-level paging entry
> >is
> >>>>>> clear
> >>>>>>>>>>>
> >>>>>>>>>>> Yes, guest kernel would notice it as the fault would be injected
> >to
> >>>>> vm.
> >>>>>>>>>>>
> >>>>>>>>>>>> Maybe bump 1.0 -> 1.1?
> >>>>>>>>>>>> My understanding version number is only informational and
> >is
> >>>>> far
> >>>>>>>> from
> >>>>>>>>>>>> accurate to mark if a feature supported. Driver should check
> >>>>>> cap/ecap
> >>>>>>>>>>>> bits instead.
> >>>>>>>>>>>
> >>>>>>>>>>> Should the version ID here be aligned with VT-d spec?
> >>>>>>>>>>
> >>>>>>>>>> Probably, this might be something that could be noticed by the
> >>>>>>>>>> management to migration compatibility.
> >>>>>>>>>
> >>>>>>>>> Could you elaborate what we need to do for migration
> >compatibility?
> >>>>>>>>> I see version is already exported so libvirt can query it, see:
> >>>>>>>>>
> >>>>>>>>>      DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
> >>>>>>>>
> >>>>>>>> It is the Qemu command line parameters not the version of the
> >vmstate.
> >>>>>>>>
> >>>>>>>> For example -device intel-iommu,version=3.0
> >>>>>>>>
> >>>>>>>> Qemu then knows it should behave as 3.0.
> >>>>>>>
> >>>>>>> So you want to bump vtd_vmstate.version?
> >>>>>>
> >>>>>> Well, as I said, it's not a direct bumping.
> >>>>>>
> >>>>>>>
> >>>>>>> In fact, this series change intel_iommu property from x-scalable-
> >>>>>> mode=["on"|"off"]"
> >>>>>>> to x-scalable-mode=["legacy"|"modern"|"off"]".
> >>>>>>>
> >>>>>>> My understanding management app should use same qemu cmdline
> >>>>>>> in source and destination, so compatibility is already guaranteed
> >even if
> >>>>>>> we don't bump vtd_vmstate.version.
> >>>>>>
> >>>>>> Exactly, so the point is to
> >>>>>>
> >>>>>> vtd=3.0, the device works exactly as vtd spec 3.0.
> >>>>>> vtd=3.3, the device works exactly as vtd spec 3.3.
> >>>>
> >>>> Yi just found version ID stored in VT-d VER_REG is not aligned with the
> >VT-d spec version.
> >>>> For example, we see a local hw with vtd version 6.0 which is beyond VT-
> >d spec version.
> >>>> We are asking VTD arch, will get back soon.
> >>>>
> >>>> Or will you plan qemu vVT-d having its own version policy?
> >>>>
> >>>> Thanks
> >>>> Zhenzhong
> >>>
> >>> Not unless there's a good reason to do this.
> >>
> >> +1
> >
> >Had more studying in the spec. Bumping up to 3.0 might not be trivial. :(
> >
> >The VT-d spec has some requirements based on the version number. Below
> >is a
> >list of it. Although they are defined for hardware, but vVT-d may need to
> >respect it as the same iommu driver runs for both the vVT-d and the hw
> >VT-d. Per 1), if bumping up the major value to be 6 or higher, the vVT-d
> >needs to ensure the register-based invalidation interface is not available.
> >Per 2), if bump up the major version to be 2 or higher, the vVT-d needs to
> >by default drain write and read requests no matter the software requests it
> >or not.
> >
> >1) Chapter 6.5 Invalidation of Translation Caches
> >
> >For software to invalidate the various caching structures, the architecture
> >supports the following two
> >types of invalidation interfaces:
> >• Register-based invalidation interface: A legacy invalidation interface
> >with limited capabilities.
> >This interface is supported by hardware implementations of this
> >architecture with Major Version 5
> >or lower (VER_REG). In all other hardware implementations, all requests are
> >treated as invalid
> >requests and will be ignored (for details see the CAIG field in the Context
> >Command Register and
> >the IAIG field in the IOTLB Invalidate Register).
> >
> >2) Chapter 6.5.2.3 IOTLB Invalidate
> >• Drain Reads (DR): Software sets this flag to indicate hardware must drain
> >read requests that are
> >already processed by the remapping hardware, but queued within the
> >Root-Complex to be
> >completed. When the value of this flag is 1, hardware must drain the
> >relevant reads before the
> >next Invalidation Wait Descriptor (see Section 6.5.2.8) is completed.
> >Section 6.5.4 describes
> >hardware support for draining. Hardware implementations with Major
> >Version
> >2 or higher
> >(VER_REG) will ignore this flag and always drain relevant reads before the
> >next Invalidation Wait
> >Descriptor is completed.
> >• Drain Writes (DW): Software sets this flag to indicate hardware must
> >drain relevant write
> >requests that are already processed by the remapping hardware, but queued
> >within the RootComplex to be completed. When the value of this flag is 1,
> >hardware must drain the relevant
> >writes before the next Invalidation Wait Descriptor is completed. Section
> >6.5.4 describes
> >hardware support for draining. Hardware implementations with Major
> >Version
> >2 or higher
> >(VER_REG) will ignore this flag and always drain relevant writes before the
> >next Invalidation Wait
> >Descriptor is completed.
> >
> >3) Chapter 11.4.2 Capability Register
> >Hardware implementations with Major Version 6 or higher
> >(VER_REG) reporting the second-stage translation support (SSTS)
> >field as Clear also report this field as 0.
> >
> >4) Chapter 11.4.8.1 Protected Memory Enable Register
> >• Hardware implementations with Major Version 2 or higher
> >(VER_REG) block all DMA requests accessing protected
> >memory regions whether or not DMA remapping is
> >enabled.
> >
> >Also, as replied in the prior email, the VT-d architecture reports
> >capability via the cap/ecap registers. The new fault reasons in this
> >patch is meaningful only when the ecap.SMTS bit is set. So bumping version
> >does not mean too much about the introduction of new capabilities. @Jason,
> >given the above statements, can we reconsider if it is necessary to bump
> >up the version number?
> >
> >--
> >Regards,
> >Yi Liu


