Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46CFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEoV-00022U-GZ; Mon, 01 Jul 2024 07:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36YyCZggKCkg2wy23kpkqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--smostafa.bounces.google.com>)
 id 1sOEoU-000223-0t
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:14 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36YyCZggKCkg2wy23kpkqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--smostafa.bounces.google.com>)
 id 1sOEoR-00050G-Il
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:13 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-4256849a9f4so20801165e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831786; x=1720436586; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lTVNVXBV9KLJ4PUuDHt2IQwPs5xTGzgLeTty17Q2smI=;
 b=CGBBEgvoYjcnuHZ7W4Z035JgMjvTBac3Ydmb7aNIZxTA04Nu1rZ5W416tgPy+2ZFRc
 wXW7FkgS/J3aWBsX7GwS95uKvFPaG75+U7NcgjsulLv4PaA1c4MXfoAIoHwJA6y2qDVq
 zGqHaARMq57Yqqqp/LK54XCMtFXQ/WhVNmfTcXyoEWiZVMgAjMyTrLIxTwfqmPXbo1Mt
 oFubvonCy3/dHEpB7NeBuIPzcEF5bL3X/jVc8sIYY2jmhkt6eR3FuuP7KZA6zTnQUx8s
 hVSivsWnMnLmyzHvsIO+oAy9oRaGOuL2dYQTef2oIgmKa0T4ixs8OS/wya0CxDxcufoQ
 mQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831786; x=1720436586;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTVNVXBV9KLJ4PUuDHt2IQwPs5xTGzgLeTty17Q2smI=;
 b=M09ovcrPgpqf5/f6hfl4d3Fhbi4+4aBFg+7JtwupVFSLodhn/zBFUqBypsuqOwvWhl
 EtfWrsV96baKIn0b4Cc8pTMIRXTTdHFKpGfQGuRrS1psvd1hxdfTsqd+xmuQ8b6LgpTY
 /5sGC5iB/pO5Qg2QMsbh7dbVVpuGYB9zjYOwN95G4j6VHliB8JHtt/jY+1fl+K/ChIsf
 0SqGuq3zlEmttVQQQjPPyR+OlpMw5IgV8rkSS3l8uejAazJ3pjkzNmFtrIOJ+H6hG699
 +W03L46vNNDh608g6gmOhYHRMQAAqAvbXvZDFaDOUK0vgssFBtadBjkkwg4bHonMHUNK
 W2yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMJAQdT1DO5XoX3U/Jyql1coAZ9svTZXCfwnB94Pay5Q6F96jhSkS1K5zFc6KXlyJt512jwSxKTssd0IFJbXYoS+K38is=
X-Gm-Message-State: AOJu0YzLkNNZFDN330qlmLwdwVfz8SB4R7QWZJkA0ttUbu/uhMoFUgfy
 J58BkfP28DIJcmfkIVC6DBNwCURqQQXVNZk3o9XJEHspWxJERCE8itmH9c9j7poK1XhtP/6P1Oe
 vKRAygUbFvA==
X-Google-Smtp-Source: AGHT+IGbhVPOnXef+VfdxmDzV4KWdRky9O8mrxVF2tfwG7H3hzkjddQiE7Jvl5QegsVuI5gmd6dUqsxhrNq3lA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:1c17:b0:425:6d66:e44f with SMTP
 id 5b1f17b1804b1-4257a08f48dmr218835e9.8.1719831785522; Mon, 01 Jul 2024
 04:03:05 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-1-smostafa@google.com>
Subject: [PATCH v4 00/19] SMMUv3 nested translation support
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=36YyCZggKCkg2wy23kpkqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x34a.google.com
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
   granule in key, this is taken into account for lookup.

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
  This series doesn=E2=80=99t implement that, but reworks OAS to make it ea=
sier
  to configure in the future.

- For nested configuration, IOVA notifier only notifies for stage-1
  invalidations (as far as I understand this is the intended
  behaviour as it notifies for IOVA).

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

Overall I tested the following configurations
(S1 =3D 4k, S2 =3D4k):
- S1 level =3D 1 and S2 level =3D 1
- S1 level =3D 1 and S2 level =3D 2
- S1 level =3D 1 and S2 level =3D 3
- S1 level =3D 2 and S2 level =3D 1
- S1 level =3D 2 and S2 level =3D 2
- S1 level =3D 2 and S2 level =3D 3
- S1 level =3D 3 and S2 level =3D 2
- S1 level =3D 3 and S2 level =3D 3
Also did some testing with
(S1 =3D 16k, S2=3D 4k)
(S1 =3D 4K, S2=3D 16k)


hw/arm/smmuv3: Split smmuv3_translate() better viewed with --color-moved

The first 3 patches are fixes.

Changes in v4:
v3: https://lore.kernel.org/qemu-devel/20240429032403.74910-1-smostafa@goog=
le.com/
- Collected Eric and Alex Rbs
- Rebased on master
- Dropped RFC tag
- Dropped last 2 patches about oas changes to avoid blocking this series
  and I will post them after as RFC
- Split patch 7, and introduce CACHED_ENTRY_TO_ADDR in a separate patch
- Reorder patch 8 and 9 (combine tlb and tlb lookup)
- Split patch 12, and introduce smmu_iotlb_inv_asid_vmid in a separate patc=
h
- Split patch 14, to have fault changes in a separate patch
- Update commit messages and include Fixes sha
- Minor updates, renames and a lot of comments based on review

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


Mostafa Saleh (19):
  hw/arm/smmu-common: Add missing size check for stage-1
  hw/arm/smmu: Fix IPA for stage-2 events
  hw/arm/smmuv3: Fix encoding of CLASS in events
  hw/arm/smmu: Use enum for SMMU stage
  hw/arm/smmu: Split smmuv3_translate()
  hw/arm/smmu: Consolidate ASID and VMID types
  hw/arm/smmu: Introduce CACHED_ENTRY_TO_ADDR
  hw/arm/smmuv3: Translate CD and TT using stage-2 table
  hw/arm/smmu-common: Rework TLB lookup for nesting
  hw/arm/smmu-common: Add support for nested TLB
  hw/arm/smmu-common: Support nested translation
  hw/arm/smmu: Support nesting in smmuv3_range_inval()
  hw/arm/smmu: Introduce smmu_iotlb_inv_asid_vmid
  hw/arm/smmu: Support nesting in the rest of commands
  hw/arm/smmuv3: Support nested SMMUs in smmuv3_notify_iova()
  hw/arm/smmuv3: Handle translation faults according to SMMUPTWEventInfo
  hw/arm/smmuv3: Support and advertise nesting
  hw/arm/smmuv3: Advertise S2FWB
  hw/arm/smmu: Refactor SMMU OAS

 hw/arm/smmu-common.c         | 320 +++++++++++++++++++++++---
 hw/arm/smmuv3-internal.h     |  19 +-
 hw/arm/smmuv3.c              | 432 ++++++++++++++++++++++-------------
 hw/arm/trace-events          |  26 ++-
 include/hw/arm/smmu-common.h |  43 +++-
 5 files changed, 617 insertions(+), 223 deletions(-)

--=20
2.45.2.803.g4e1b14247a-goog


