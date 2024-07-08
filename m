Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAF7C3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 17:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQsCd-0007CL-UD; Mon, 08 Jul 2024 13:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQsCN-00072F-Dt
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQsCL-0007C7-7R
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720459843;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2txuk2XNhyybrBBr01RrWc5nhtnzLAivH5SNn80jT8=;
 b=bq6PEiaiy/ssGzcr9vW8S2jVTgrm72AcZj/dzH5T2ACziS4+Ji0CpIxocizgSRgfWyNOZM
 Ysfwm5BZjymQXvi2eL7BcbfSnXNjikJ+LtnH3Yw7l/7jQRQcy7cALUe6jCVkB/bO8WfEjY
 MXil4L9xu10MrLp/TEVNWaJwI6KpaqM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-5XUzouTDP9iM0FNoF22ZrQ-1; Mon, 08 Jul 2024 13:30:41 -0400
X-MC-Unique: 5XUzouTDP9iM0FNoF22ZrQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b5de421bc6so68469976d6.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 10:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720459841; x=1721064641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X2txuk2XNhyybrBBr01RrWc5nhtnzLAivH5SNn80jT8=;
 b=hHFj/e43EtTKWdqUW4m1Nfe3vQEQmOHM6r82eYfPTvPUds8x5xoNCh8P+Wh2lGsowu
 zlwXc3e5aEmfQ7Jt8dMt34+AvyIdrOvVsfqrvN0fplvayM6ZoIMmDI/l2yNWbyLNLCoe
 JkkjN1UwFw5htjel4N6pL5O3vzoTcq5f0a6rqQlf7HD8mQd/DSWqO04lVU4PWqzGGjW+
 cQ9qEKBv9p3s4RZCEGub6LOWxwyLzcCatSj9jFrvxlCSVtIWkItXW7wRUX55mJasjmd3
 pVHXK7FrC9f2amEnO5eC+9c+bIxt+KLZK//jqFif1HW31zqSTdHh5kfuizDVfdAmYFpr
 9dHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYR1vrVIACQy400bwExYLPMMbzJsgYNaYtqWRCGroHzLz2Y5jkIl0zRuOzSnhUHiE2VjE9OJgKItIr3fEbJqGMDN/3PVg=
X-Gm-Message-State: AOJu0YxXyz0red2oo6IBl6PEk17VumfpdDamNBM7D8S7gGwUtrpDpPlU
 wPv2TeOlFoNx02+25ibkYOQxsB4dGD5TAjeMwWF0qwe3dkisbG2k8TxtOr1iycYZljjgeXGmE6b
 Gt0pMh0z8n3nKFTE6rljEH9iSyLO/HI+TFne0Adl6BXOpee4rmpSG
X-Received: by 2002:ad4:5761:0:b0:6b5:53a7:74b3 with SMTP id
 6a1803df08f44-6b61bca02aamr5379136d6.15.1720459841181; 
 Mon, 08 Jul 2024 10:30:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzRnoKgU/jU5olpncvF3tDzXSzjPMsFWDXcXsFtRj6qwV53Kbiu7cU1AVsbF6S1a8pK1yb3A==
X-Received: by 2002:ad4:5761:0:b0:6b5:53a7:74b3 with SMTP id
 6a1803df08f44-6b61bca02aamr5378886d6.15.1720459840756; 
 Mon, 08 Jul 2024 10:30:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b61ba8d875sm1281716d6.127.2024.07.08.10.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 10:30:40 -0700 (PDT)
Message-ID: <85f20c7e-72f8-4784-9d81-8e6f2d394112@redhat.com>
Date: Mon, 8 Jul 2024 19:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] SMMUv3 nested translation support
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240701110241.2005222-1-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 7/1/24 13:02, Mostafa Saleh wrote:
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

If you respin quickly you may have a chance to get this in 9.1 (as a
reminder the soft freeze is on 2024-07-23). Is it your target?

Thanks

Eric
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
>    granule in key, this is taken into account for lookup.
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
>   This series doesn’t implement that, but reworks OAS to make it easier
>   to configure in the future.
>
> - For nested configuration, IOVA notifier only notifies for stage-1
>   invalidations (as far as I understand this is the intended
>   behaviour as it notifies for IOVA).
>
> - Stop ignoring VMID for stage-1 if stage-2 is also supported.
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
> Overall I tested the following configurations
> (S1 = 4k, S2 =4k):
> - S1 level = 1 and S2 level = 1
> - S1 level = 1 and S2 level = 2
> - S1 level = 1 and S2 level = 3
> - S1 level = 2 and S2 level = 1
> - S1 level = 2 and S2 level = 2
> - S1 level = 2 and S2 level = 3
> - S1 level = 3 and S2 level = 2
> - S1 level = 3 and S2 level = 3
> Also did some testing with
> (S1 = 16k, S2= 4k)
> (S1 = 4K, S2= 16k)
>
>
> hw/arm/smmuv3: Split smmuv3_translate() better viewed with --color-moved
>
> The first 3 patches are fixes.
>
> Changes in v4:
> v3: https://lore.kernel.org/qemu-devel/20240429032403.74910-1-smostafa@google.com/
> - Collected Eric and Alex Rbs
> - Rebased on master
> - Dropped RFC tag
> - Dropped last 2 patches about oas changes to avoid blocking this series
>   and I will post them after as RFC
> - Split patch 7, and introduce CACHED_ENTRY_TO_ADDR in a separate patch
> - Reorder patch 8 and 9 (combine tlb and tlb lookup)
> - Split patch 12, and introduce smmu_iotlb_inv_asid_vmid in a separate patch
> - Split patch 14, to have fault changes in a separate patch
> - Update commit messages and include Fixes sha
> - Minor updates, renames and a lot of comments based on review
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
>
> Mostafa Saleh (19):
>   hw/arm/smmu-common: Add missing size check for stage-1
>   hw/arm/smmu: Fix IPA for stage-2 events
>   hw/arm/smmuv3: Fix encoding of CLASS in events
>   hw/arm/smmu: Use enum for SMMU stage
>   hw/arm/smmu: Split smmuv3_translate()
>   hw/arm/smmu: Consolidate ASID and VMID types
>   hw/arm/smmu: Introduce CACHED_ENTRY_TO_ADDR
>   hw/arm/smmuv3: Translate CD and TT using stage-2 table
>   hw/arm/smmu-common: Rework TLB lookup for nesting
>   hw/arm/smmu-common: Add support for nested TLB
>   hw/arm/smmu-common: Support nested translation
>   hw/arm/smmu: Support nesting in smmuv3_range_inval()
>   hw/arm/smmu: Introduce smmu_iotlb_inv_asid_vmid
>   hw/arm/smmu: Support nesting in the rest of commands
>   hw/arm/smmuv3: Support nested SMMUs in smmuv3_notify_iova()
>   hw/arm/smmuv3: Handle translation faults according to SMMUPTWEventInfo
>   hw/arm/smmuv3: Support and advertise nesting
>   hw/arm/smmuv3: Advertise S2FWB
>   hw/arm/smmu: Refactor SMMU OAS
>
>  hw/arm/smmu-common.c         | 320 +++++++++++++++++++++++---
>  hw/arm/smmuv3-internal.h     |  19 +-
>  hw/arm/smmuv3.c              | 432 ++++++++++++++++++++++-------------
>  hw/arm/trace-events          |  26 ++-
>  include/hw/arm/smmu-common.h |  43 +++-
>  5 files changed, 617 insertions(+), 223 deletions(-)
>


