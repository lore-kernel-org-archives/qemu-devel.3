Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE610CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 10:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rry1T-0008Pn-DX; Wed, 03 Apr 2024 06:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rry1R-0008P7-Qt
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:39:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rry1P-0008Of-Fl
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:39:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-413f8c8192eso75635e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712140750; x=1712745550; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L5uRbfpn8rAyhg4/JlDV2ZnHGFfvZpSBfsFBPdWj1Is=;
 b=OMUVtLaCL8qXE8KNjjww5XbwRz2UW1aibl165bMjXgJgZc4SNqcRMO5SzpCOwpCpr4
 uAjD2XiUF+A4Diw9igXc3oz2D0NWaqHdCNqSXwdV8feF/tPo/8dng38oQP2Qy8qx+U/g
 8k8YQfA3EU9mY9IJy23Gqn5Biry9aBu4wzHDbGgVVGwoRp5unjgX9Y1dbII89HT8Ee7r
 VnCbv7MW+hEALR45daTrg1+dcUSDM0iRO7H/qDfX5IiTHuucGyoLy79DI5KULefQ0RZ+
 XcowB4vaxjZ6Jt3hOlaItxG6o8DhJQ3kIow+phrK5QZ5s2zGCw4LuP8pQZnHpV7vILsJ
 xKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712140750; x=1712745550;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L5uRbfpn8rAyhg4/JlDV2ZnHGFfvZpSBfsFBPdWj1Is=;
 b=Ag1cAkHITXyYS8am3Vf9soDhuIQW7o2oEPsp75edOWn+WylkeSO1Y36kQXvExAvGnc
 fSI6sMJprcFhb4WJJt8WAchM2hDhKkBoPYQCb4XIj5ZRV5p/GMZAEUgwvQ6s7xsWErk4
 w++s6d2/uMwj6GhIgiAxSUUGlYUKnVRtBIKIhrECuTc7GoFrn/0o87prn7VAmVD6nv+V
 SVzNmZX6bqb9NiLzlM7hJHHo7blGDjBbIMXfoVBP82l/I4Mk3IXZFc3kt3IWHSLEuucw
 OXeHclqTNtiHlNCivpXzmiSbU5cUojozeJmjD35zJ7AGJENghsAlE6b6hf5hjKUJHwye
 t03Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU/X71jMjMX94d5ap0PGJBzDKLitcUmHWQpElJu1ISMgzv8prjSjmwQ/bUmHfo2wqAy+q29dDv5O86oh/khsBin8RgN/8=
X-Gm-Message-State: AOJu0YzkH+DzJTuQu8eJxVRHXv8opAZWSNbVWR87ygtlNaiQSSrgz6sI
 tJ0ISIoa/8UxEQLDE4QyWTGeZXf9YSvn3YIcf8VzfR6+ZW9XeGC7IE7Sm4HQVQ==
X-Google-Smtp-Source: AGHT+IFWa18vylUEOkR9TfcCo5jVlnZR6BcGKxxSu6MazmSehuaRmUlF15MEdcJtsSOT3wVShkwiSA==
X-Received: by 2002:a05:600c:1c12:b0:415:615c:b98b with SMTP id
 j18-20020a05600c1c1200b00415615cb98bmr118907wms.5.1712140749689; 
 Wed, 03 Apr 2024 03:39:09 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 v13-20020a5d4b0d000000b0034356c434d0sm1913522wrq.117.2024.04.03.03.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 03:39:09 -0700 (PDT)
Date: Wed, 3 Apr 2024 10:39:05 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, jean-philippe@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, julien@xen.org
Subject: Re: [RFC PATCH 00/12] SMMUv3 nested translation support
Message-ID: <Zg0xyXBXGa8_Kx6k@google.com>
References: <20240325101442.1306300-1-smostafa@google.com>
 <ZgyGfMz7IktmwtP/@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgyGfMz7IktmwtP/@Asurada-Nvidia>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=smostafa@google.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Nicolin,

On Tue, Apr 02, 2024 at 03:28:12PM -0700, Nicolin Chen wrote:
> Hi Mostafa,
> 
> On Mon, Mar 25, 2024 at 10:13:56AM +0000, Mostafa Saleh wrote:
> > 
> > Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
> > but not nested instances.
> > This patch series adds support for nested translation in SMMUv3,
> > this is controlled by property “arm-smmuv3.stage=nested”, and
> > advertised to guests as (IDR0.S1P == 1 && IDR0.S2P == 2)
> 
> IIUIC, with this series, vSMMU will support a virtualized 2-stage
> translation in a guest VM, right? I wonder how it would interact

I always get confused with terminologies when dealing with QEMU;
as the host can mean the actual host (which is x86_64 in my case)
and the guest would aarch64 Linux fully emulated by QEMU, and the
emulated guest can be considered a host and launch it’s guests wit
KVM for example. This also will be more fun with guests supporting
nested virtualization :)

For simplicity, I will consider:
- HOST: the fully emulated QEMU guest (aarch64) running on my machine.
- GUEST: Any guest launched by the HOST (through KVM for example)
- QEMU: Is the instance of QEMU emulating the HOST (built for x86)
- QEMU-VMM: Is the instance of QEMU running on the HOST (built for
  aarch64) which launches VMs(GUESTs).

With that, AFAIU, vSMMU is the SMMUv3 emulation used for GUESTs with
QEMU-VMM, where it has hooks in CMDQ and then the QEMU-VMM will issue
IOCTLs to the HOST to do the actual SMMU work (through iommufd or IIRC
there was previous patches from Eric that does that also), also the
vSMMU is out of tree AFAICT.

In that case, this work is orthogonal to that, the nested SMMUv3
emulation in this series mainly targets QEMU which is advertised
to the HOST, which then allows it to use iommufd with GUESts.

In theory, that work can be extended to QEMU-VMM with vSMMU, but
I guess that would be a lot of work as the VMM needs to collapse
both stages as the kernel provides only one address space for the VMM.

Mainly, I use this patches to test nesting patches I am hacking for
KVM, also they can be used with your patches to test iommufd with
needing hardware. (See testing section in the cover letter)

> with the ongoing 2-stage nesting support with host and guest. Or
> is it supposed to be just a total orthogonal feature without any
> interaction with the host system?

Are you referring to the iommufd work on Linux to support nesting?


Thanks,
Mostafa
> Thanks
> Nicolin
> 
> > Main changes(architecture):
> > ============================
> > 1) CDs are considered IPA and translated with stage-2.
> > 2) TTBx and tables for stage-1 are considered IPA and translated
> >    with stage-2.
> > 3) Translate the IPA address with stage-2.
> > 
> > TLBs:
> > ======
> > TLBs are the most tricky part.
> > 
> > 1) General design
> >    Unified(Combined) design is used, where a new tag is added "stage"
> >    which has 2 valid values:
> >    - STAGE_1: Meaning this entry translates VA to PADDR, it can be
> >      cached from fully nested configuration or from stage-1 only.
> >      It doesn't support separate cached entries (VA to IPA).
> > 
> >    - STAGE_2: Meaning this translates IPA to PADDR, cached from
> >      stage-2  only configuration.
> > 
> >    TLBs are also modified to cache 2 permissions, a new permission added
> >    "parent_perm."
> > 
> >    For non-nested configuration, perm == parent_perm and nothing
> >    changes. This is used to know which stage to use in case there is
> >    a permission fault from a TLB entry.
> > 
> > 2) Caching in TLB
> >    Stage-1 and stage-2 are inserted in the TLB as is.
> >    For nested translation, both entries are combined into one TLB
> >    entry. Everything is used from stage-1, except:
> >    - transatled_addr from stage-2.
> >    - parent_perm is from stage-2.
> >    - addr_mask: is the minimum of both.
> > 
> > 3) TLB Lookup
> >    For stage-1 and nested translations, it look for STAGE_1 entries.
> >    For stage-2 it look for STAGE_2 TLB entries.
> > 
> > 4) TLB invalidation
> >    - Stage-1 commands (CMD_TLBI_NH_VAA, SMMU_CMD_TLBI_NH_VA,
> >      SMMU_CMD_TLBI_NH_ALL): Invalidate TLBs tagged with SMMU_STAGE_1.
> >    - Stage-2 commands (CMD_TLBI_S2_IPA): Invalidate TLBs tagged with
> >      SMMU_STAGE_2.
> >    - All (SMMU_CMD_TLBI_S12_VMALL): Will invalidate both, this is
> >      communicated to the TLB as SMMU_NESTED which is (SMMU_STAGE_1 |
> >      SMMU_STAGE_2) which uses it as a mask.
> > 
> >    As far as I understand, this is compliant with the ARM
> >    architecture, based on:
> >    - ARM ARM DDI 0487J.a: RLGSCG, RTVTYQ, RGNJPZ
> >    - ARM IHI 0070F.b: 16.2 Caching
> > 
> >    An alternative approach would be to instantiate 2 TLBs, one per
> >    each stage. I haven’t investigated that.
> > 
> > Others
> > =======
> > - Advertise SMMUv3.2-S2FWB, it is NOP for QEMU as it doesn’t support
> >   attributes.
> > 
> > - OAS: A typical setup with nesting is to share CPU stage-2 with the
> >   SMMU, and according to the user manual, SMMU OAS must match the
> >   system physical address.
> > 
> >   This was discussed before in
> >   https://lore.kernel.org/all/20230226220650.1480786-11-smostafa@google.com/
> >   The implementation here, follows the discussion, where migration is
> >   added and oas is set up from the board (virt). However, the OAS is
> >   chosen based on the CPU PARANGE as there is no fixed one.
> > 
> > - For nested configuration, IOVA notifier only notifies for stage-1
> >   invalidations (as far as I understand this is the intended
> >   behaviour as it notifies for IOVA)
> > 
> > - Stop ignoring VMID for stage-1 if stage-2 is also supported.
> > 
> > 
> > Future improvements:
> > =====================
> > 1) One small improvement, that I don’t think it’s worth the extra
> >    complexity, is in case of Stage-1 TLB miss for nested translation,
> >    we can do stage-1 walk and lookup for stage-2 TLBs, instead of
> >    doing the full walk.
> > 
> > 2) Patch 0006 (hw/arm/smmuv3: Translate CD and TT using stage-2 table)
> >    introduces a macro to use functions that rely on cfg for stage-2,
> >    I don’t like it. However, I didn’t find a simple way around it,
> >    either we change many functions to have a separate stage argument,
> >    or add another arg in config, which is probably more code.
> > 
> > Testing
> > ========
> > 1) IOMMUFD + VFIO
> >    Kernel: https://lore.kernel.org/all/cover.1683688960.git.nicolinc@nvidia.com/
> >    VMM: https://qemu-devel.nongnu.narkive.com/o815DqpI/rfc-v5-0-8-arm-smmuv3-emulation-support
> > 
> >    By assigning “virtio-net-pci,netdev=net0,disable-legacy=on,iommu_platform=on,ats=on”,
> >    to a guest VM (on top of QEMU guest) with VIFO and IOMMUFD.
> > 
> > 2) Work in progress prototype I am hacking on for nesting on KVM
> >    (this is nowhere near complete, and misses many stuff but it
> >    doesn't require VMs/VFIO) also with virtio-net-pci and git
> >    cloning a bunch of stuff and also observing traces.
> >    https://android-kvm.googlesource.com/linux/+log/refs/heads/smostafa/android15-6.6-smmu-nesting-wip
> > 
> > hw/arm/smmuv3: Split smmuv3_translate() better viewed with --color-moved
> > 
> > 
> > Mostafa Saleh (12):
> >   hw/arm/smmu: Use enum for SMMU stage
> >   hw/arm/smmu: Split smmuv3_translate()
> >   hw/arm/smmu: Add stage to TLB
> >   hw/arm/smmu: Support nesting in commands
> >   hw/arm/smmuv3: Support nested SMMUs in smmuv3_notify_iova()
> >   hw/arm/smmuv3: Translate CD and TT using stage-2 table
> >   hw/arm/smmu-common: Support nested translation
> >   hw/arm/smmuv3: Support and advertise nesting
> >   hw/arm/smmuv3: Advertise S2FWB
> >   hw/arm/smmu: Refactor SMMU OAS
> >   hw/arm/smmuv3: Add property for OAS
> >   hw/arm/virt: Set SMMU OAS based on CPU PARANGE
> > 
> >  hw/arm/smmu-common.c         | 256 ++++++++++++++++++----
> >  hw/arm/smmu-internal.h       |   2 +
> >  hw/arm/smmuv3-internal.h     |  17 +-
> >  hw/arm/smmuv3.c              | 405 ++++++++++++++++++++++-------------
> >  hw/arm/trace-events          |  14 +-
> >  hw/arm/virt.c                |  14 +-
> >  include/hw/arm/smmu-common.h |  46 +++-
> >  include/hw/arm/smmuv3.h      |   1 +
> >  target/arm/cpu.h             |   2 +
> >  target/arm/cpu64.c           |   5 +
> >  10 files changed, 533 insertions(+), 229 deletions(-)
> > 
> > --
> > 2.44.0.396.g6e790dbe36-goog
> > 

