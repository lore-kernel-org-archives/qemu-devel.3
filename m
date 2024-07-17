Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85068C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 03:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTvjr-0003Yk-TV; Tue, 16 Jul 2024 23:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sTvjq-0003YB-8M
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 23:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sTvjn-0006C9-Mq
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 23:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721188434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3m91/PjmL+GysdKQOC9Of6/06DxbyuPhS9+kRWA0BdY=;
 b=Vz/dzUMOhUuxYRmT0mxx5aRLBTF1KW3IKFpj0CXWCNCmYKd849ia0kvPvMy0dK1xtCLRlS
 dPYYQHPumEDF2HJZZxK+blN4l6wYX4Q18y+IGQq1kIP0NSBRniC0N2L1WsQ5LPJ6cgeBRa
 cNBG3kHDo7joVo1y2lqv6an+dWaiMKs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-7f03VUIfMpOdepwie4jXUw-1; Tue, 16 Jul 2024 23:53:51 -0400
X-MC-Unique: 7f03VUIfMpOdepwie4jXUw-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-70445cdc3f5so5378954a34.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 20:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721188431; x=1721793231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3m91/PjmL+GysdKQOC9Of6/06DxbyuPhS9+kRWA0BdY=;
 b=KA9vT0GmCuukPulR11E1LAIYGGmCQqGmXoI3t02EX1nzkyjQMBxbLZ5xtdZdCf5ZtD
 V5IOCnnijza3hz+RKeXfwnhgfP+E/B9aH9c4JYk1KJnYFKfmiaBmL0t4r2Voi0753w5g
 ooiB/1DJbFJpXYmTHulxb3/GcW4PsFzfwty9zuTdDa3HVbn3thSVcXFtbAtzM+3SAlEC
 +ogxfbiDbf8p6YxbVQheWu5JCFl86ntVyVnVU4FesBV+T7Droa8nzxc8cUviEa3U75Rl
 efHJ2p+EAhEC4Huzp1qJcK97hRFahTLa1dfr9gdkAxn+q2j32KBKNdRSbmlNO0kTjUCK
 MPdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw7IeWlXI4jjVdd9Bg5C8JjsDt6V7voBtbg0ndsLlVKc6UikRuDvyXEHV8E7MSVv0EQ5BZ5koSTGdUrJNlPuzgz/dOPqg=
X-Gm-Message-State: AOJu0YwiVF8B7TwPQukkDRYz8deA5rwCzBoeEtF4/v8NU2o/sA8fh4s3
 zvBDAHoLGM0hKh9TknDC6HbYVto1R8HcW70PFqOYjSkPUHiUWCShcr5xwyaVu9vxtNa3alFIb6z
 ne+4cI1BIBzRaKUgeowChEURJ85XOxbbK6nIPRAfnp+lA3FRK2jt7S7NiTGp5ntiraUO89jh3MN
 cDAufikHcZcSz06ukA8O6QLHzEcss=
X-Received: by 2002:a05:6830:6683:b0:704:467a:3ef0 with SMTP id
 46e09a7af769-708e377533amr576718a34.9.1721188430886; 
 Tue, 16 Jul 2024 20:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUwyAXWrDLAZ5kR59GRyN7eVJP4e/jYCpshMIDFs/RyTHZfQhsZ6ea6axPtP1q1LDeNCek2y1SJeNo4+SjNa0=
X-Received: by 2002:a05:6830:6683:b0:704:467a:3ef0 with SMTP id
 46e09a7af769-708e377533amr576699a34.9.1721188430556; Tue, 16 Jul 2024
 20:53:50 -0700 (PDT)
MIME-Version: 1.0
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
 <20240527025023-mutt-send-email-mst@kernel.org>
 <CACGkMEuCqCNhVvXYN6jT5CDHbnt8sEHUk2UfwVaaOVLXfSfv3w@mail.gmail.com>
 <a791e442-f5b5-4670-9394-876b041cfd62@intel.com>
 <SJ0PR11MB6744F95EB6B6182D90DE8D8392A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744F95EB6B6182D90DE8D8392A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Jul 2024 11:53:38 +0800
Message-ID: <CACGkMEtizR-vPEPCoAJoJKK28Z7w6eqM1ZighLHgk56PX_TYKQ@mail.gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng,
 Chao P" <chao.p.peng@intel.com>, 
 Yu Zhang <yu.c.zhang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
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

On Wed, Jul 17, 2024 at 11:30=E2=80=AFAM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
> Hi Michael, Jason,
>
> Based on Yi's analysis, is keeping current VERSION value acceptable for y=
ou?

Fine with me.

> Look forward to your comments, currently this open blocks us from sending=
 the next version.
>
> Thanks
> Zhenzhong

Thanks

>
> >-----Original Message-----
> >From: Liu, Yi L <yi.l.liu@intel.com>
> >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined b=
y
> >spec
> >
> >Hi Michael, Jason,
> >
> >On 2024/5/28 11:03, Jason Wang wrote:
> >> On Mon, May 27, 2024 at 2:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com>
> >wrote:
> >>>
> >>> On Mon, May 27, 2024 at 06:44:58AM +0000, Duan, Zhenzhong wrote:
> >>>> Hi Jason,
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Duan, Zhenzhong
> >>>>> Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defi=
ned
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
> >>>>>> On Fri, May 24, 2024 at 4:41=E2=80=AFPM Duan, Zhenzhong
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
> >>>>>>>> On Tue, May 21, 2024 at 6:25=E2=80=AFPM Duan, Zhenzhong
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
> >>>>>>>>>> On Mon, May 20, 2024 at 12:15=E2=80=AFPM Liu, Yi L <yi.l.liu@i=
ntel.com>
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
> >>>>>>>>>>>>> On Fri, May 17, 2024 at 6:26=E2=80=AFPM Zhenzhong Duan
> >>>>>>>>>>>>> <zhenzhong.duan@intel.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> From: Yu Zhang <yu.c.zhang@linux.intel.com>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Currently we use only VTD_FR_PASID_TABLE_INV as fault
> >>>>>> reason.
> >>>>>>>>>>>>>> Update with more detailed fault reasons listed in VT-d spe=
c
> >>>>>> 7.2.3.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> >>>>>>>>>>>>>> Signed-off-by: Zhenzhong Duan
> ><zhenzhong.duan@intel.com>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I wonder if this could be noticed by the guest or not. If y=
es
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
> >>>>>>>>>>>> [fault reason 0x71] SM: Present bit in first-level paging en=
try
> >is
> >>>>>> clear
> >>>>>>>>>>>
> >>>>>>>>>>> Yes, guest kernel would notice it as the fault would be injec=
ted
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
> >>>>>>>>>      DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0)=
,
> >>>>>>>>
> >>>>>>>> It is the Qemu command line parameters not the version of the
> >vmstate.
> >>>>>>>>
> >>>>>>>> For example -device intel-iommu,version=3D3.0
> >>>>>>>>
> >>>>>>>> Qemu then knows it should behave as 3.0.
> >>>>>>>
> >>>>>>> So you want to bump vtd_vmstate.version?
> >>>>>>
> >>>>>> Well, as I said, it's not a direct bumping.
> >>>>>>
> >>>>>>>
> >>>>>>> In fact, this series change intel_iommu property from x-scalable-
> >>>>>> mode=3D["on"|"off"]"
> >>>>>>> to x-scalable-mode=3D["legacy"|"modern"|"off"]".
> >>>>>>>
> >>>>>>> My understanding management app should use same qemu cmdline
> >>>>>>> in source and destination, so compatibility is already guaranteed
> >even if
> >>>>>>> we don't bump vtd_vmstate.version.
> >>>>>>
> >>>>>> Exactly, so the point is to
> >>>>>>
> >>>>>> vtd=3D3.0, the device works exactly as vtd spec 3.0.
> >>>>>> vtd=3D3.3, the device works exactly as vtd spec 3.3.
> >>>>
> >>>> Yi just found version ID stored in VT-d VER_REG is not aligned with =
the
> >VT-d spec version.
> >>>> For example, we see a local hw with vtd version 6.0 which is beyond =
VT-
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
> >Had more studying in the spec. Bumping up to 3.0 might not be trivial. :=
(
> >
> >The VT-d spec has some requirements based on the version number. Below
> >is a
> >list of it. Although they are defined for hardware, but vVT-d may need t=
o
> >respect it as the same iommu driver runs for both the vVT-d and the hw
> >VT-d. Per 1), if bumping up the major value to be 6 or higher, the vVT-d
> >needs to ensure the register-based invalidation interface is not availab=
le.
> >Per 2), if bump up the major version to be 2 or higher, the vVT-d needs =
to
> >by default drain write and read requests no matter the software requests=
 it
> >or not.
> >
> >1) Chapter 6.5 Invalidation of Translation Caches
> >
> >For software to invalidate the various caching structures, the architect=
ure
> >supports the following two
> >types of invalidation interfaces:
> >=E2=80=A2 Register-based invalidation interface: A legacy invalidation i=
nterface
> >with limited capabilities.
> >This interface is supported by hardware implementations of this
> >architecture with Major Version 5
> >or lower (VER_REG). In all other hardware implementations, all requests =
are
> >treated as invalid
> >requests and will be ignored (for details see the CAIG field in the Cont=
ext
> >Command Register and
> >the IAIG field in the IOTLB Invalidate Register).
> >
> >2) Chapter 6.5.2.3 IOTLB Invalidate
> >=E2=80=A2 Drain Reads (DR): Software sets this flag to indicate hardware=
 must drain
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
> >(VER_REG) will ignore this flag and always drain relevant reads before t=
he
> >next Invalidation Wait
> >Descriptor is completed.
> >=E2=80=A2 Drain Writes (DW): Software sets this flag to indicate hardwar=
e must
> >drain relevant write
> >requests that are already processed by the remapping hardware, but queue=
d
> >within the RootComplex to be completed. When the value of this flag is 1=
,
> >hardware must drain the relevant
> >writes before the next Invalidation Wait Descriptor is completed. Sectio=
n
> >6.5.4 describes
> >hardware support for draining. Hardware implementations with Major
> >Version
> >2 or higher
> >(VER_REG) will ignore this flag and always drain relevant writes before =
the
> >next Invalidation Wait
> >Descriptor is completed.
> >
> >3) Chapter 11.4.2 Capability Register
> >Hardware implementations with Major Version 6 or higher
> >(VER_REG) reporting the second-stage translation support (SSTS)
> >field as Clear also report this field as 0.
> >
> >4) Chapter 11.4.8.1 Protected Memory Enable Register
> >=E2=80=A2 Hardware implementations with Major Version 2 or higher
> >(VER_REG) block all DMA requests accessing protected
> >memory regions whether or not DMA remapping is
> >enabled.
> >
> >Also, as replied in the prior email, the VT-d architecture reports
> >capability via the cap/ecap registers. The new fault reasons in this
> >patch is meaningful only when the ecap.SMTS bit is set. So bumping versi=
on
> >does not mean too much about the introduction of new capabilities. @Jaso=
n,
> >given the above statements, can we reconsider if it is necessary to bump
> >up the version number?
> >
> >--
> >Regards,
> >Yi Liu


