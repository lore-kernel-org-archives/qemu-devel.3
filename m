Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D730C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 09:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9M5k-00053x-TJ; Tue, 21 May 2024 05:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s9M5i-00053P-Md
 for qemu-devel@nongnu.org; Tue, 21 May 2024 05:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s9M5g-0003Wi-HW
 for qemu-devel@nongnu.org; Tue, 21 May 2024 05:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716284846;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQiYc5TNr7Xv5NJxsOqNGLmBnAfTvbdg+Jiy9BpALIQ=;
 b=QiFtbRvtWwoChi3n/wID52Pe/7fy7n2D9OqkyYej5QZo63fQP0g9cE5BCr3pfqnEGyJCpl
 M5qjeYa8V8QNHNTwAETHZGmC02DPJkuUVpKhNNjgIcYH+7rzIRZQZiISpLYf7PTV5aPQOi
 7MFkjPmudajLwoGZ2RuWJ0qAKv7gFTs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-DXSfWwUzOAyXUSjqf5Mm3w-1; Tue, 21 May 2024 05:47:25 -0400
X-MC-Unique: DXSfWwUzOAyXUSjqf5Mm3w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-574f411ac2cso4095960a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 02:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716284844; x=1716889644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HQiYc5TNr7Xv5NJxsOqNGLmBnAfTvbdg+Jiy9BpALIQ=;
 b=mVv7QQ/ngdAh5zlrSOCDCbsct4NawmK6eo9S8GLrjJAit/G1hG+neudJC8U9FfzkCS
 D/dQGhbSH/GqvE2t84z3QBez9Eyuq5d02ebdGmdoXd1rGMrQ4Wjph+gaFYwIYqYDdFam
 V5zO8jVhDDsZEIDgsYk7zXY9zXzeunT63TWRCalMpweIJkkVeyeFS7DyNMBOD6pKxDre
 Td9a1KJNhrOlPAVqBl4Psm1SKcUTVJToSTIWEHowVW0WTvfv7ObzkBVZDmLies/wc7va
 iMHZMdC4af53F8J5sWal+spfz3sslj7q96afNBhBL2GgSGejysXkNcmPqwpnxZKtEo0W
 gMfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBeNMYso5Sx9c+7+DiFcRMwaEha0EqyluKafjyZ67XDuIuDlSLtgajREFrA9V8aD+U1HbLP/+w6JxFtmuXcw2RPz58oiA=
X-Gm-Message-State: AOJu0YydUKIiKmvdmA5NoaFNAch7TiT03nTsIkztksQNeWjpG2uXOPLY
 WXXsxSE1XF+Sdate9ibfCI5dpy2Bs5LlD/f8t9HIU+YBch6k/97pRsvpd2J8YxuSNuZo58Hsq3e
 L8ByKCcAk76Z5VPefCl2CinKKUYK4obTHlK6INqSQCZB7ksFkjepj
X-Received: by 2002:a05:6402:1746:b0:573:50a6:d3b0 with SMTP id
 4fb4d7f45d1cf-57350a6d402mr20540118a12.3.1716284843761; 
 Tue, 21 May 2024 02:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF50QJH326buy8wIYaaOxJPflDqEDEzIgf906UomvBDVzeH0QZaYqD15KBopzaOTL+jH1TBvg==
X-Received: by 2002:a05:6402:1746:b0:573:50a6:d3b0 with SMTP id
 4fb4d7f45d1cf-57350a6d402mr20540106a12.3.1716284843231; 
 Tue, 21 May 2024 02:47:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733beb89e7sm16808087a12.21.2024.05.21.02.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 02:47:22 -0700 (PDT)
Message-ID: <7a30b326-df0e-4907-8ca0-6289665c4708@redhat.com>
Date: Tue, 21 May 2024 11:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/18] SMMUv3 nested translation support
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Mostafa,

On 4/29/24 05:23, Mostafa Saleh wrote:
> Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
> but not nested instances.
> This patch series adds support for nested translation in SMMUv3,
> this is controlled by property “arm-smmuv3.stage=nested”, and
> advertised to guests as (IDR0.S1P == 1 && IDR0.S2P == 2)
>
> Main changes(architecture):
> ============================
> 1) CDs are considered IPA and translated with stage-2.
> 2) TTBx and tables for stage-1 are considered IPA and translated
>    with stage-2.
> 3) Translate the IPA address with stage-2.
>
> TLBs:
> ======
> TLBs are the most tricky part.
>
> 1) General design
>    Unified(Combined) design is used, where entries with ASID=-1 are
>    IPAs(cached from stage-2 config)
>
>    TLBs are also modified to cache 2 permissions, a new permission added
>    "parent_perm."
>
>    For non-nested configuration, perm == parent_perm and nothing
>    changes. This is used to know which stage to use in case there is
>    a permission fault from a TLB entry.
>
> 2) Caching in TLB
>    Stage-1 and stage-2 are inserted in the TLB as is.
>    For nested translation, both entries are combined into one TLB
>    entry. The size (level and granule) are chosen from the smallest entries.
>    That means that a stage-1 translation can be cached with sage-2
>    granule in key, this is take into account lookup.
>
> 3) TLB Lookup
>    TLB lookup already uses ASID in key, so it can distinguish between
>    stage-1 and stage-2.
>    And as mentioned above, the granule for stage-1 can be different,
>    If stage-1 lookup failed, we try again with the stage-2 granule.
>
> 4) TLB invalidation
>    - Address invalidation is split, for IOVA(CMD_TLBI_NH_VA
>      /CMD_TLBI_NH_VAA) and IPA(CMD_TLBI_S2_IPA) based on ASID value
>    - CMD_TLBI_NH_ASID/CMD_TLBI_NH_ALL: Consider VMID if stage-2 is
>      supported, and invalidate stage-1 only by VMIDs
>
> As far as I understand, this is compliant with the ARM architecture:
> - ARM ARM DDI 0487J.a: RLGSCG, RTVTYQ, RGNJPZ
> - ARM IHI 0070F.b: 16.2 Caching
>
> An alternative approach would be to instantiate 2 TLBs, one per each
> stage. I haven’t investigated that.
>
> Others
> =======
> - Advertise SMMUv3.2-S2FWB, it is NOP for QEMU as it doesn’t support
>   attributes.
>
> - OAS: A typical setup with nesting is to share CPU stage-2 with the
>   SMMU, and according to the user manual, SMMU OAS must match the
>   system physical address.
>
>   This was discussed before in
>   https://lore.kernel.org/all/20230226220650.1480786-11-smostafa@google.com/
>   The implementation here, follows the discussion, where migration is
>   added and oas is set up from the board (virt). However, the OAS is
>   chosen based on the CPU PARANGE as there is no fixed one.
>
> - For nested configuration, IOVA notifier only notifies for stage-1
>   invalidations (as far as I understand this is the intended
>   behaviour as it notifies for IOVA)
>
> - Stop ignoring VMID for stage-1 if stage-2 is also supported.

I completed the review pass on my end. I strongly encourage you to move
the series into a non RFC series to attract more reviewers. Migration
needs to be fixed and compat handling as well I think but overall the
nested support looks mostly OK for me. Some stuff are a bit hacky (like
config local patching to force S2 only) as I mentionned in my comments
but let see if other reviewers find some more elegant ways to handle things

Eric
>
>
> Future improvements:
> =====================
> 1) One small improvement, that I don’t think it’s worth the extra
>    complexity, is in case of Stage-1 TLB miss for nested translation,
>    we can do stage-1 walk and lookup for stage-2 TLBs, instead of
>    doing the full walk.
>
> Testing
> ========
> 1) IOMMUFD + VFIO
>    Kernel: https://lore.kernel.org/all/cover.1683688960.git.nicolinc@nvidia.com/
>    VMM: https://qemu-devel.nongnu.narkive.com/o815DqpI/rfc-v5-0-8-arm-smmuv3-emulation-support
>
>    By assigning “virtio-net-pci,netdev=net0,disable-legacy=on,iommu_platform=on,ats=on”,
>    to a guest VM (on top of QEMU guest) with VIFO and IOMMUFD.
>
> 2) Work in progress prototype I am hacking on for nesting on KVM
>    (this is nowhere near complete, and misses many stuff but it
>    doesn't require VMs/VFIO) also with virtio-net-pci and git
>    cloning a bunch of stuff and also observing traces.
>    https://android-kvm.googlesource.com/linux/+log/refs/heads/smostafa/android15-6.6-smmu-nesting-wip
>
> I also modified the Linux driver to test with mixed granules/levels.
>
> hw/arm/smmuv3: Split smmuv3_translate() better viewed with --color-moved
>
> The first 3 patches are fixes.
>
> Changes in v3
> v2: https://lore.kernel.org/qemu-devel/20240408140818.3799590-1-smostafa@google.com/
> - Collected Eric Rbs.
> - Rebased on master.
> - Fix an existing bug in class encoding.
> - Fix an existing bug in S2 events missing IPA.
> - Fix nesting event population (missing class and wrong events)
> - Remove CALL_FUNC_CFG_S2.
> - Rework TLB combination logic to cache the largest possible entries.
> - Refactor nested translation code to be more clear.
> - Split patch 05 to 4 patches.
> - Convert asid/vmid in trace events to int also.
> - Remove some extra traces as it was not needed.
> - Improve commit messages.
>
> Changes in v2:
> v1: https://lore.kernel.org/qemu-devel/20240325101442.1306300-1-smostafa@google.com/
> - Collected Eric Rbs
> - Rework TLB to rely on VMID/ASID instead of an extra key.
> - Fixed TLB issue with large stage-1 reported by Julian.
> - Cap the OAS to 48 bits as PTW doesn’t support 52 bits.
> - Fix ASID/VMID representation in some contexts as 16 bits while
>   they can be -1
> - Increase visibility in trace points
>
> Mostafa Saleh (18):
>   hw/arm/smmu-common: Add missing size check for stage-1
>   hw/arm/smmu: Fix IPA for stage-2 events
>   hw/arm/smmuv3: Fix encoding of CLASS in events
>   hw/arm/smmu: Use enum for SMMU stage
>   hw/arm/smmu: Split smmuv3_translate()
>   hw/arm/smmu: Consolidate ASID and VMID types
>   hw/arm/smmuv3: Translate CD and TT using stage-2 table
>   hw/arm/smmu-common: Add support for nested TLB
>   hw/arm/smmu-common: Rework TLB lookup for nesting
>   hw/arm/smmu-common: Support nested translation
>   hw/arm/smmu: Support nesting in smmuv3_range_inval()
>   hw/arm/smmu: Support nesting in the rest of commands
>   hw/arm/smmuv3: Support nested SMMUs in smmuv3_notify_iova()
>   hw/arm/smmuv3: Support and advertise nesting
>   hw/arm/smmuv3: Advertise S2FWB
>   hw/arm/smmu: Refactor SMMU OAS
>   hw/arm/smmuv3: Add property for OAS
>   hw/arm/virt: Set SMMU OAS based on CPU PARANGE
>
>  hw/arm/smmu-common.c         | 298 ++++++++++++++++++++---
>  hw/arm/smmuv3-internal.h     |  22 +-
>  hw/arm/smmuv3.c              | 441 +++++++++++++++++++++++------------
>  hw/arm/trace-events          |  26 ++-
>  hw/arm/virt.c                |  14 +-
>  include/hw/arm/smmu-common.h |  43 +++-
>  include/hw/arm/smmuv3.h      |   1 +
>  target/arm/cpu.h             |   2 +
>  target/arm/cpu64.c           |   5 +
>  9 files changed, 625 insertions(+), 227 deletions(-)
>


