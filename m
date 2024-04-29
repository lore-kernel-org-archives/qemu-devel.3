Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F13EC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hd9-0000G7-0a; Sun, 28 Apr 2024 23:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <37xIvZggKCgo2wy23kpkqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--smostafa.bounces.google.com>)
 id 1s1Hd6-0000FD-NB
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:36 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <37xIvZggKCgo2wy23kpkqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--smostafa.bounces.google.com>)
 id 1s1Hd4-0003vn-LV
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:36 -0400
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-3455cbdea2cso2056449f8f.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361072; x=1714965872; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kg8JpJQnN0c+odVldJkdd5igagDXLYeYuPdlRPmdra4=;
 b=Ah637Rva0CsWgZO7zYWiLWhKF3cyZuXK1VQ6166BuuBY0Cmu+Bki1EjPczGzG5qVXA
 12XNteThhCNgoE+j3DtlQbgZHZ1WY2uAchAXS7qCUhRp7aK0r4GMXUwK+J18kZoXZnEW
 b40PJgTlkNOSJk1nACYXJqt8Cho+HR2kGzit9Cv5/b5NLOCFBzD46vkYklGDBRyEgP8U
 Vtz7F1OAmQpQnBoHtCywsfkAsKFf/OdNyCEl2l3Pw25zSdQNqK0sdl03uN7OiPs3NdPV
 UlLFTq6ChMXfy5iXKfuXPcj+XNDFpge7nbhSgWGf5vNtnp5obQNLbBbSb1pzNMUHgdFB
 qGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361072; x=1714965872;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kg8JpJQnN0c+odVldJkdd5igagDXLYeYuPdlRPmdra4=;
 b=KzsuLy3YoevDNM7nj3IYpTt+8y/4Il/Mc5uzSR8ametgrGDaqejTuxedkbIrxkL9jD
 d4LLx+wARGsL31i6AQqvIT/7MT/harfFwaMlwp4TmeHuMPuqWStEVHsdEVLGawoCnjci
 qtyfzoEVuwK/U/4muFXoux8gPK92KoPTfJAYnD+RuFNHZ06SbbJ9KIeH7gcZ+QYWxc9K
 PNU896hj0bBKMNfVYXCC/Af2TUQ74LMiUjbcR6XLK83QcYUfVLBywtkvGAsL32mMTb1m
 cX8lllPcZBmIfRRj6v6a74iyQ5GdFS+oGprOM1rimaJ8uwjVac72FGelB5aqS8Le5uHh
 9jmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+QAhn9KYv9Dk7X7oFTjsxnMD6+b5QunGYcdh2shNqbyTjUXMi+/ZMollMhVA5cMf6diuJRmvwA43sUs2ni8bfqHgAfcM=
X-Gm-Message-State: AOJu0YzDux8xRJX01Hr0wG1Y+UfjXhLpLxQ3fjBLPdt0Soj/SkXU9pHL
 F0SjrtbJq7twmw7a2Ph7iVn5irOwD5zGRi76sto0IwPXPHaie1tZVARNwL29l/48UEplcglJg+q
 3ZYLkk5lCpg==
X-Google-Smtp-Source: AGHT+IFFMoZxCmdcZ9viCuoZ7HR9UBuoRJGpvhXYisk1H9DuJOc38FkpxhxVQu8A+JzHVNHkrg49NHdFcemrpw==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6000:100e:b0:34a:122d:a749 with SMTP
 id a14-20020a056000100e00b0034a122da749mr15663wrx.6.1714361071772; Sun, 28
 Apr 2024 20:24:31 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-1-smostafa@google.com>
Subject: [RFC PATCH v3 00/18] SMMUv3 nested translation support
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=37xIvZggKCgo2wy23kpkqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
but not nested instances.
This patch series adds support for nested translation in SMMUv3,
this is controlled by property =E2=80=9Carm-smmuv3.stage=3Dnested=E2=80=9D,=
 and
advertised to guests as (IDR0.S1P =3D=3D 1 && IDR0.S2P =3D=3D 2)

Main changes(architecture):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
1) CDs are considered IPA and translated with stage-2.
2) TTBx and tables for stage-1 are considered IPA and translated
   with stage-2.
3) Translate the IPA address with stage-2.

TLBs:
=3D=3D=3D=3D=3D=3D
TLBs are the most tricky part.

1) General design
   Unified(Combined) design is used, where entries with ASID=3D-1 are
   IPAs(cached from stage-2 config)

   TLBs are also modified to cache 2 permissions, a new permission added
   "parent_perm."

   For non-nested configuration, perm =3D=3D parent_perm and nothing
   changes. This is used to know which stage to use in case there is
   a permission fault from a TLB entry.

2) Caching in TLB
   Stage-1 and stage-2 are inserted in the TLB as is.
   For nested translation, both entries are combined into one TLB
   entry. The size (level and granule) are chosen from the smallest entries=
.
   That means that a stage-1 translation can be cached with sage-2
   granule in key, this is take into account lookup.

3) TLB Lookup
   TLB lookup already uses ASID in key, so it can distinguish between
   stage-1 and stage-2.
   And as mentioned above, the granule for stage-1 can be different,
   If stage-1 lookup failed, we try again with the stage-2 granule.

4) TLB invalidation
   - Address invalidation is split, for IOVA(CMD_TLBI_NH_VA
     /CMD_TLBI_NH_VAA) and IPA(CMD_TLBI_S2_IPA) based on ASID value
   - CMD_TLBI_NH_ASID/CMD_TLBI_NH_ALL: Consider VMID if stage-2 is
     supported, and invalidate stage-1 only by VMIDs

As far as I understand, this is compliant with the ARM architecture:
- ARM ARM DDI 0487J.a: RLGSCG, RTVTYQ, RGNJPZ
- ARM IHI 0070F.b: 16.2 Caching

An alternative approach would be to instantiate 2 TLBs, one per each
stage. I haven=E2=80=99t investigated that.

Others
=3D=3D=3D=3D=3D=3D=3D
- Advertise SMMUv3.2-S2FWB, it is NOP for QEMU as it doesn=E2=80=99t suppor=
t
  attributes.

- OAS: A typical setup with nesting is to share CPU stage-2 with the
  SMMU, and according to the user manual, SMMU OAS must match the
  system physical address.

  This was discussed before in
  https://lore.kernel.org/all/20230226220650.1480786-11-smostafa@google.com=
/
  The implementation here, follows the discussion, where migration is
  added and oas is set up from the board (virt). However, the OAS is
  chosen based on the CPU PARANGE as there is no fixed one.

- For nested configuration, IOVA notifier only notifies for stage-1
  invalidations (as far as I understand this is the intended
  behaviour as it notifies for IOVA)

- Stop ignoring VMID for stage-1 if stage-2 is also supported.


Future improvements:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1) One small improvement, that I don=E2=80=99t think it=E2=80=99s worth the=
 extra
   complexity, is in case of Stage-1 TLB miss for nested translation,
   we can do stage-1 walk and lookup for stage-2 TLBs, instead of
   doing the full walk.

Testing
=3D=3D=3D=3D=3D=3D=3D=3D
1) IOMMUFD + VFIO
   Kernel: https://lore.kernel.org/all/cover.1683688960.git.nicolinc@nvidia=
.com/
   VMM: https://qemu-devel.nongnu.narkive.com/o815DqpI/rfc-v5-0-8-arm-smmuv=
3-emulation-support

   By assigning =E2=80=9Cvirtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,i=
ommu_platform=3Don,ats=3Don=E2=80=9D,
   to a guest VM (on top of QEMU guest) with VIFO and IOMMUFD.

2) Work in progress prototype I am hacking on for nesting on KVM
   (this is nowhere near complete, and misses many stuff but it
   doesn't require VMs/VFIO) also with virtio-net-pci and git
   cloning a bunch of stuff and also observing traces.
   https://android-kvm.googlesource.com/linux/+log/refs/heads/smostafa/andr=
oid15-6.6-smmu-nesting-wip

I also modified the Linux driver to test with mixed granules/levels.

hw/arm/smmuv3: Split smmuv3_translate() better viewed with --color-moved

The first 3 patches are fixes.

Changes in v3
v2: https://lore.kernel.org/qemu-devel/20240408140818.3799590-1-smostafa@go=
ogle.com/
- Collected Eric Rbs.
- Rebased on master.
- Fix an existing bug in class encoding.
- Fix an existing bug in S2 events missing IPA.
- Fix nesting event population (missing class and wrong events)
- Remove CALL_FUNC_CFG_S2.
- Rework TLB combination logic to cache the largest possible entries.
- Refactor nested translation code to be more clear.
- Split patch 05 to 4 patches.
- Convert asid/vmid in trace events to int also.
- Remove some extra traces as it was not needed.
- Improve commit messages.

Changes in v2:
v1: https://lore.kernel.org/qemu-devel/20240325101442.1306300-1-smostafa@go=
ogle.com/
- Collected Eric Rbs
- Rework TLB to rely on VMID/ASID instead of an extra key.
- Fixed TLB issue with large stage-1 reported by Julian.
- Cap the OAS to 48 bits as PTW doesn=E2=80=99t support 52 bits.
- Fix ASID/VMID representation in some contexts as 16 bits while
  they can be -1
- Increase visibility in trace points

Mostafa Saleh (18):
  hw/arm/smmu-common: Add missing size check for stage-1
  hw/arm/smmu: Fix IPA for stage-2 events
  hw/arm/smmuv3: Fix encoding of CLASS in events
  hw/arm/smmu: Use enum for SMMU stage
  hw/arm/smmu: Split smmuv3_translate()
  hw/arm/smmu: Consolidate ASID and VMID types
  hw/arm/smmuv3: Translate CD and TT using stage-2 table
  hw/arm/smmu-common: Add support for nested TLB
  hw/arm/smmu-common: Rework TLB lookup for nesting
  hw/arm/smmu-common: Support nested translation
  hw/arm/smmu: Support nesting in smmuv3_range_inval()
  hw/arm/smmu: Support nesting in the rest of commands
  hw/arm/smmuv3: Support nested SMMUs in smmuv3_notify_iova()
  hw/arm/smmuv3: Support and advertise nesting
  hw/arm/smmuv3: Advertise S2FWB
  hw/arm/smmu: Refactor SMMU OAS
  hw/arm/smmuv3: Add property for OAS
  hw/arm/virt: Set SMMU OAS based on CPU PARANGE

 hw/arm/smmu-common.c         | 298 ++++++++++++++++++++---
 hw/arm/smmuv3-internal.h     |  22 +-
 hw/arm/smmuv3.c              | 441 +++++++++++++++++++++++------------
 hw/arm/trace-events          |  26 ++-
 hw/arm/virt.c                |  14 +-
 include/hw/arm/smmu-common.h |  43 +++-
 include/hw/arm/smmuv3.h      |   1 +
 target/arm/cpu.h             |   2 +
 target/arm/cpu64.c           |   5 +
 9 files changed, 625 insertions(+), 227 deletions(-)

--=20
2.44.0.769.g3c40516874-goog


