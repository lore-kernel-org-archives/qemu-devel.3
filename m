Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D85C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 18:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxWED-0006eo-Lf; Thu, 18 Apr 2024 14:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxWE9-0006cV-Ty
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 14:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxWE6-0002t6-I5
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 14:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713463872;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27eefg414On2YawNE62Pu8XoXMQ46Ze1X2uuQSi8kn4=;
 b=YBMKAtXBmhFuOtm62aAYqbakwokodLqFwdxFKa+P3F9nhStgaYNTt2jP6TS78LPchw4T4Q
 6s6KBqs5LCwDT/C+30NRReT6P+XtlvZlgmvtQiGEojh2tenXVD0UWYNDdI9tkPvmqu40zP
 zR91T/+Ot8beEAgszdfYw+XcE/Ndmzg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-6kN9GQlRPeysIXTYs-wLLQ-1; Thu, 18 Apr 2024 14:11:11 -0400
X-MC-Unique: 6kN9GQlRPeysIXTYs-wLLQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69b31b7df0dso17050246d6.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 11:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713463871; x=1714068671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=27eefg414On2YawNE62Pu8XoXMQ46Ze1X2uuQSi8kn4=;
 b=IP846YNmZPlICgfirV+jI0z9OLTlSyO0AiTd5ULGPCPtpbpxQKUihKa62QmozM8yHw
 Rd7YB/OlKvWOrUbw3I0enLQNdsfZzKNOYraXuFZBotW4PljzpJKlQQN782o2Cu8eefTr
 QJwGAzOqOb6b7jTRreswqKxZLfzpYNMvLiw8xYziQrsJZ4Z3MBKgqZO+RW93eBDE1cvx
 1QRomkilynGKTQR7VvgYCHG8zl3udW9EBtxI29GpV3uCEe7PInWhunsGZ44LzLXH3BLi
 AWqfvmX1vHQPWXcatpJKX7VUKomdecfCvE9RaDzlue8ouqw6MONT5tdZ7svlNcsh3llN
 t0NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDRMGy9wK5xvmUE5v/Y86p6tacnUCMWqZYOHg29F74acj4yyrhhfqTJnmNtvZ09nMJ2mgKo4+oC3dS6rkknuEKKTEIu18=
X-Gm-Message-State: AOJu0YzQXE9zLKyCLOdRHpg9U3p0gUw4APxip2LOmMnY6IyF3hAZPXGL
 F9lazPEW9WkYYv7r45LQ4U1qFuHKl0Pg70RPTZnt26EnqoyiFYMB9YDABJushQ4wANVg1/9Stus
 amxV/a3urDxFh9+XtKkZlyDR8ujlBUs7X60DqlPhIJLxsZxMdA8M6
X-Received: by 2002:ad4:4482:0:b0:69b:6fb4:f0d1 with SMTP id
 m2-20020ad44482000000b0069b6fb4f0d1mr3965684qvt.62.1713463870675; 
 Thu, 18 Apr 2024 11:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX/ldINzN2k368Ig1Fz+BtRu1Hoq4G0BNNSTxALVbLp8cnRbLK55fB+BPJHDnxhc3TP7UtdA==
X-Received: by 2002:ad4:4482:0:b0:69b:6fb4:f0d1 with SMTP id
 m2-20020ad44482000000b0069b6fb4f0d1mr3965648qvt.62.1713463870250; 
 Thu, 18 Apr 2024 11:11:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a0ce406000000b0069b534fb8b0sm845480qvl.59.2024.04.18.11.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 11:11:09 -0700 (PDT)
Message-ID: <14a6fbf1-4f05-42a7-a59b-7195e95aed6f@redhat.com>
Date: Thu, 18 Apr 2024 20:11:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/13] SMMUv3 nested translation support
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240408140818.3799590-1-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240408140818.3799590-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

On 4/8/24 16:08, Mostafa Saleh wrote:
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
is that a correct understanding that with the current implementation, in
nested mode, you end up with combined S1 + S2 entries (IOVA -> PA) and
S2 entries (IPA -> PA)?
Out of cusiosity, how did you end up with that choice? Have you made
some perf assessment compared to separate S1 and S2 entries? I guess it
is a complex topic and choice.

Thanks

Eric
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
>
>
> Future improvements:
> =====================
> 1) One small improvement, that I don’t think it’s worth the extra
>    complexity, is in case of Stage-1 TLB miss for nested translation,
>    we can do stage-1 walk and lookup for stage-2 TLBs, instead of
>    doing the full walk.
>
> 2) Patch 0006 (hw/arm/smmuv3: Translate CD and TT using stage-2 table)
>    introduces a macro to use functions that rely on cfg for stage-2,
>    I don’t like it. However, I didn’t find a simple way around it,
>    either we change many functions to have a separate stage argument,
>    or add another arg in config, which is probably more code.
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
> Mostafa Saleh (13):
>   hw/arm/smmu: Use enum for SMMU stage
>   hw/arm/smmu: Split smmuv3_translate()
>   hw/arm/smmu: Consolidate ASID and VMID types
>   hw/arm/smmuv3: Translate CD and TT using stage-2 table
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
>  hw/arm/smmu-common.c         | 306 +++++++++++++++++++++----
>  hw/arm/smmuv3-internal.h     |  16 +-
>  hw/arm/smmuv3.c              | 418 ++++++++++++++++++++++-------------
>  hw/arm/trace-events          |  18 +-
>  hw/arm/virt.c                |  14 +-
>  include/hw/arm/smmu-common.h |  57 ++++-
>  include/hw/arm/smmuv3.h      |   1 +
>  target/arm/cpu.h             |   2 +
>  target/arm/cpu64.c           |   5 +
>  9 files changed, 608 insertions(+), 229 deletions(-)
>


