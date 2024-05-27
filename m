Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48251C25B7E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 16:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcy7-0006lZ-6s; Mon, 27 May 2024 12:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sBcy5-0006l1-MG
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:13:01 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sBcy2-00021N-TW
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:13:01 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-43e14f0bd75so507691cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1716826378; x=1717431178; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4eu7mtU1yIw30xnv4hGiBdkzIsN8Ou0azGVT2RvdL0=;
 b=xPa034dfXxmz+bc5sfVgvJcw1KtkbZUCMZ727bttA6tnttfL12EKFW/h3A84+jQujO
 rYZE1zqSPD7DxHGcIH4Arf8Y/VURmjr6LMJMtqp3a8oyb/AVvwDa4INDx4yAYmT/s0vs
 p7g9kGPbjJFMDKRIM+CfStpwU5W5zWIKIzhXyW6DRtduW0ZyUMVqgUp92FGBlTatMzOh
 lYBsw/msMNWaGqrwM0JNV0f53t5Z6W3/vYbOzLokje5JKBc57g2H9WlEw/3eQZPcv3xB
 RkdzWyBjLUyVOqhUgiNfl/rQ0/Z6hanqFWp0g6WAsjMX6eCnzk/qLKKk299+rJTg3xqI
 XP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716826378; x=1717431178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4eu7mtU1yIw30xnv4hGiBdkzIsN8Ou0azGVT2RvdL0=;
 b=AWVTe8XU6G0dxf3Xt6OitOagKKaU57CYyAjqUqZwYb8qXyOWmBqlDdI37UnrefveT1
 jBa7lhWm5ifFzGsKwzQgvxhQeahdrcwESVawFSuVblTDut8OHkbzExULGpQPPfYylSEd
 1VRI/fE2fUCfDlurbavEBLMnGUf00mMdfCQt2WbyWVCadeqCYBDqcF9PyVOWMNOBfqNK
 zdYF7PP83auHTn4ejLpgjYkA19GXxhghy0Y67IEOmwMYE8xWZXKxta+AHWoiTT5lHV9Z
 XusaCLeR7Mb9+Ykt5epeo/HydYrQ3Do9W96FTqAqoQRdqQIpIw8Wz/71iGVOErqIQuTW
 QIjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYWBEsR7cjpn22G+676Q9zGfzgbmZcf9MycPlp4EuGfjCLMlqg4UUyscxU8Lcigz+JtNQ1SBmTW8/NQvHMw2UuC3Xv5Os=
X-Gm-Message-State: AOJu0YyR9tQMIbLN9+cXaP8GiaWzWaQR8TnvipKxXWIXS+98Eg2hJwC1
 t4cCjlBENofGJnFSdaAvZLoOmWwb0fJ4N5Ze+Co0v18VJ4Mdag9dnTiMI42Jet7yxNg7V89jHGJ
 7WxqEILXdY5jQ8necCqy1OTAfVPBHtsYUdKaX
X-Google-Smtp-Source: AGHT+IG67vof6kzEmRNwjJwo+msAxjb8w/SDZBojX8XliziE6sx9rs5cd1qry+1eyHZyc7EtRYqN3STAIiiv8Q1FOnc=
X-Received: by 2002:a05:622a:5989:b0:43e:3d52:3e0b with SMTP id
 d75a77b69052e-43fb9f596ccmr4667851cf.16.1716826376797; Mon, 27 May 2024
 09:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
 <7a30b326-df0e-4907-8ca0-6289665c4708@redhat.com>
In-Reply-To: <7a30b326-df0e-4907-8ca0-6289665c4708@redhat.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 27 May 2024 17:12:37 +0100
Message-ID: <CAFgf54qyexuZjSt32UTAKPL2+sZv8uS5ecZyLAL00MLROGYUog@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/18] SMMUv3 nested translation support
To: eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=smostafa@google.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On Tue, May 21, 2024 at 10:47=E2=80=AFAM Eric Auger <eric.auger@redhat.com>=
 wrote:
>
> Hi Mostafa,
>
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
> > but not nested instances.
> > This patch series adds support for nested translation in SMMUv3,
> > this is controlled by property =E2=80=9Carm-smmuv3.stage=3Dnested=E2=80=
=9D, and
> > advertised to guests as (IDR0.S1P =3D=3D 1 && IDR0.S2P =3D=3D 2)
> >
> > Main changes(architecture):
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > 1) CDs are considered IPA and translated with stage-2.
> > 2) TTBx and tables for stage-1 are considered IPA and translated
> >    with stage-2.
> > 3) Translate the IPA address with stage-2.
> >
> > TLBs:
> > =3D=3D=3D=3D=3D=3D
> > TLBs are the most tricky part.
> >
> > 1) General design
> >    Unified(Combined) design is used, where entries with ASID=3D-1 are
> >    IPAs(cached from stage-2 config)
> >
> >    TLBs are also modified to cache 2 permissions, a new permission adde=
d
> >    "parent_perm."
> >
> >    For non-nested configuration, perm =3D=3D parent_perm and nothing
> >    changes. This is used to know which stage to use in case there is
> >    a permission fault from a TLB entry.
> >
> > 2) Caching in TLB
> >    Stage-1 and stage-2 are inserted in the TLB as is.
> >    For nested translation, both entries are combined into one TLB
> >    entry. The size (level and granule) are chosen from the smallest ent=
ries.
> >    That means that a stage-1 translation can be cached with sage-2
> >    granule in key, this is take into account lookup.
> >
> > 3) TLB Lookup
> >    TLB lookup already uses ASID in key, so it can distinguish between
> >    stage-1 and stage-2.
> >    And as mentioned above, the granule for stage-1 can be different,
> >    If stage-1 lookup failed, we try again with the stage-2 granule.
> >
> > 4) TLB invalidation
> >    - Address invalidation is split, for IOVA(CMD_TLBI_NH_VA
> >      /CMD_TLBI_NH_VAA) and IPA(CMD_TLBI_S2_IPA) based on ASID value
> >    - CMD_TLBI_NH_ASID/CMD_TLBI_NH_ALL: Consider VMID if stage-2 is
> >      supported, and invalidate stage-1 only by VMIDs
> >
> > As far as I understand, this is compliant with the ARM architecture:
> > - ARM ARM DDI 0487J.a: RLGSCG, RTVTYQ, RGNJPZ
> > - ARM IHI 0070F.b: 16.2 Caching
> >
> > An alternative approach would be to instantiate 2 TLBs, one per each
> > stage. I haven=E2=80=99t investigated that.
> >
> > Others
> > =3D=3D=3D=3D=3D=3D=3D
> > - Advertise SMMUv3.2-S2FWB, it is NOP for QEMU as it doesn=E2=80=99t su=
pport
> >   attributes.
> >
> > - OAS: A typical setup with nesting is to share CPU stage-2 with the
> >   SMMU, and according to the user manual, SMMU OAS must match the
> >   system physical address.
> >
> >   This was discussed before in
> >   https://lore.kernel.org/all/20230226220650.1480786-11-smostafa@google=
.com/
> >   The implementation here, follows the discussion, where migration is
> >   added and oas is set up from the board (virt). However, the OAS is
> >   chosen based on the CPU PARANGE as there is no fixed one.
> >
> > - For nested configuration, IOVA notifier only notifies for stage-1
> >   invalidations (as far as I understand this is the intended
> >   behaviour as it notifies for IOVA)
> >
> > - Stop ignoring VMID for stage-1 if stage-2 is also supported.
>
> I completed the review pass on my end. I strongly encourage you to move
> the series into a non RFC series to attract more reviewers. Migration
> needs to be fixed and compat handling as well I think but overall the
> nested support looks mostly OK for me. Some stuff are a bit hacky (like
> config local patching to force S2 only) as I mentionned in my comments
> but let see if other reviewers find some more elegant ways to handle thin=
gs
>

Thanks a lot, I really appreciate your thorough review.
I will send a v4 without RFC in ~2 weeks as I am off for a while.
I will probably drop the OAS changes (again) to avoid the migration
hassle and this can be a separate series after this one,

Thanks,
Mostafa

> Eric
> >
> >
> > Future improvements:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1) One small improvement, that I don=E2=80=99t think it=E2=80=99s worth=
 the extra
> >    complexity, is in case of Stage-1 TLB miss for nested translation,
> >    we can do stage-1 walk and lookup for stage-2 TLBs, instead of
> >    doing the full walk.
> >
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > 1) IOMMUFD + VFIO
> >    Kernel: https://lore.kernel.org/all/cover.1683688960.git.nicolinc@nv=
idia.com/
> >    VMM: https://qemu-devel.nongnu.narkive.com/o815DqpI/rfc-v5-0-8-arm-s=
mmuv3-emulation-support
> >
> >    By assigning =E2=80=9Cvirtio-net-pci,netdev=3Dnet0,disable-legacy=3D=
on,iommu_platform=3Don,ats=3Don=E2=80=9D,
> >    to a guest VM (on top of QEMU guest) with VIFO and IOMMUFD.
> >
> > 2) Work in progress prototype I am hacking on for nesting on KVM
> >    (this is nowhere near complete, and misses many stuff but it
> >    doesn't require VMs/VFIO) also with virtio-net-pci and git
> >    cloning a bunch of stuff and also observing traces.
> >    https://android-kvm.googlesource.com/linux/+log/refs/heads/smostafa/=
android15-6.6-smmu-nesting-wip
> >
> > I also modified the Linux driver to test with mixed granules/levels.
> >
> > hw/arm/smmuv3: Split smmuv3_translate() better viewed with --color-move=
d
> >
> > The first 3 patches are fixes.
> >
> > Changes in v3
> > v2: https://lore.kernel.org/qemu-devel/20240408140818.3799590-1-smostaf=
a@google.com/
> > - Collected Eric Rbs.
> > - Rebased on master.
> > - Fix an existing bug in class encoding.
> > - Fix an existing bug in S2 events missing IPA.
> > - Fix nesting event population (missing class and wrong events)
> > - Remove CALL_FUNC_CFG_S2.
> > - Rework TLB combination logic to cache the largest possible entries.
> > - Refactor nested translation code to be more clear.
> > - Split patch 05 to 4 patches.
> > - Convert asid/vmid in trace events to int also.
> > - Remove some extra traces as it was not needed.
> > - Improve commit messages.
> >
> > Changes in v2:
> > v1: https://lore.kernel.org/qemu-devel/20240325101442.1306300-1-smostaf=
a@google.com/
> > - Collected Eric Rbs
> > - Rework TLB to rely on VMID/ASID instead of an extra key.
> > - Fixed TLB issue with large stage-1 reported by Julian.
> > - Cap the OAS to 48 bits as PTW doesn=E2=80=99t support 52 bits.
> > - Fix ASID/VMID representation in some contexts as 16 bits while
> >   they can be -1
> > - Increase visibility in trace points
> >
> > Mostafa Saleh (18):
> >   hw/arm/smmu-common: Add missing size check for stage-1
> >   hw/arm/smmu: Fix IPA for stage-2 events
> >   hw/arm/smmuv3: Fix encoding of CLASS in events
> >   hw/arm/smmu: Use enum for SMMU stage
> >   hw/arm/smmu: Split smmuv3_translate()
> >   hw/arm/smmu: Consolidate ASID and VMID types
> >   hw/arm/smmuv3: Translate CD and TT using stage-2 table
> >   hw/arm/smmu-common: Add support for nested TLB
> >   hw/arm/smmu-common: Rework TLB lookup for nesting
> >   hw/arm/smmu-common: Support nested translation
> >   hw/arm/smmu: Support nesting in smmuv3_range_inval()
> >   hw/arm/smmu: Support nesting in the rest of commands
> >   hw/arm/smmuv3: Support nested SMMUs in smmuv3_notify_iova()
> >   hw/arm/smmuv3: Support and advertise nesting
> >   hw/arm/smmuv3: Advertise S2FWB
> >   hw/arm/smmu: Refactor SMMU OAS
> >   hw/arm/smmuv3: Add property for OAS
> >   hw/arm/virt: Set SMMU OAS based on CPU PARANGE
> >
> >  hw/arm/smmu-common.c         | 298 ++++++++++++++++++++---
> >  hw/arm/smmuv3-internal.h     |  22 +-
> >  hw/arm/smmuv3.c              | 441 +++++++++++++++++++++++------------
> >  hw/arm/trace-events          |  26 ++-
> >  hw/arm/virt.c                |  14 +-
> >  include/hw/arm/smmu-common.h |  43 +++-
> >  include/hw/arm/smmuv3.h      |   1 +
> >  target/arm/cpu.h             |   2 +
> >  target/arm/cpu64.c           |   5 +
> >  9 files changed, 625 insertions(+), 227 deletions(-)
> >
>

