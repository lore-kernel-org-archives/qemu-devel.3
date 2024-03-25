Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D669FCD11DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohME-0004FB-UK; Mon, 25 Mar 2024 06:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qE4BZggKCoExrtxyfkflttlqj.htrvjrz-ij0jqstslsz.twl@flex--smostafa.bounces.google.com>)
 id 1rohMD-0004Et-4w
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:09 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qE4BZggKCoExrtxyfkflttlqj.htrvjrz-ij0jqstslsz.twl@flex--smostafa.bounces.google.com>)
 id 1rohMA-0004Va-UP
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:08 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-414105984aeso23072155e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711361704; x=1711966504; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yIAujX6vE8NrFA61OIsCbO+ax3TuT+vIQCEUptoSr1g=;
 b=i1yP49HxzVwJY7lZnoTprghzC5hgz1lhx8c80kqUcdFzonTN+KhgXwECDY0EtZyElX
 iTGAKAwWFyObaTPWXa9+kkZB5Njq6Dai7VP9v/y4pTiCjdvI2/iUzr3Na4T173Iz1fiX
 AL+GkDyLGi2sySRkKuTgT/57L2Qju8mnl6lwPL+nGN3k26lojrdNhXWQssjgeuZ9UFXk
 5N7vxF3ZRbglc04xQPl6cjy8J/3dMo1i/rYrtZ/GHaoj8YJG77jQ5q2cg8Yh53qGxTPr
 rYj/heSEskYxoxkH4JuRq7wDd/phwbJNexLi+DBR8CTCVuWU+frhxT2qBx2JM8Qh+GFM
 IyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361704; x=1711966504;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIAujX6vE8NrFA61OIsCbO+ax3TuT+vIQCEUptoSr1g=;
 b=QjfO/40mMHJntp8V3PdRzVx8vtqX5nVJ1o9uuBqMnQE0aE7zX4R4p0FvCj81ChwOY1
 tVt9lTLeQoUGuUF4H1t8xJ8017aWbbxzghep7o30stJ1Bw+5GVog4QDzP6x0+DV/dATU
 lyFVjtN8vn+xZActcnDlo7+TiNNIAoQ5S9K8BN95ZrS97DmOqmcp+bQuUpZfKo+KAUYr
 Iplj4PHHmPv5uMLnQ1RFUJCUqRh0WTBpDRGyaEwCGcOH1lUQ88kbvyTJxJSwkM3/wC+7
 xV6svQZqwVK+bjviHzxR7y6mpYgViVhiawZXOdALX699451F/OBmMHyF5He9rFcKDt/1
 /tNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdtYtYgif8FHrQtzpduA4mZVWLMVvX0lRWUJcRn2uYaus50zZDELV4Q3jqDWegNgwAhAz1SQnZfbruv6JfYNZ8coFbJK8=
X-Gm-Message-State: AOJu0Yy3GrKMxW6RNg+khSUYcg/NFX4Zjwcwx9eQviGkBpU+D7BqryTk
 XZi9Cpkl+vtlidb8mD3VvJMuFV9+6UQctF/h6BYM1EbcVDbnTVKIGYHUthYocG4EbpvI/U7e3wN
 UJLSI2xRtpw==
X-Google-Smtp-Source: AGHT+IGmhancH3CG9GhCHZk00lSfF57Yr53DtdrD97Wv+G3iDuAm2S+VbVI0SMO7uBJmYPI7idA+cFlBd4UyIQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:470a:b0:414:7dfb:8500 with SMTP
 id v10-20020a05600c470a00b004147dfb8500mr47747wmo.6.1711361704364; Mon, 25
 Mar 2024 03:15:04 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:13:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325101442.1306300-1-smostafa@google.com>
Subject: [RFC PATCH 00/12] SMMUv3 nested translation support
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3qE4BZggKCoExrtxyfkflttlqj.htrvjrz-ij0jqstslsz.twl@flex--smostafa.bounces.google.com;
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
   Unified(Combined) design is used, where a new tag is added "stage"
   which has 2 valid values:
   - STAGE_1: Meaning this entry translates VA to PADDR, it can be
     cached from fully nested configuration or from stage-1 only.
     It doesn't support separate cached entries (VA to IPA).

   - STAGE_2: Meaning this translates IPA to PADDR, cached from
     stage-2  only configuration.

   TLBs are also modified to cache 2 permissions, a new permission added
   "parent_perm."

   For non-nested configuration, perm =3D=3D parent_perm and nothing
   changes. This is used to know which stage to use in case there is
   a permission fault from a TLB entry.

2) Caching in TLB
   Stage-1 and stage-2 are inserted in the TLB as is.
   For nested translation, both entries are combined into one TLB
   entry. Everything is used from stage-1, except:
   - transatled_addr from stage-2.
   - parent_perm is from stage-2.
   - addr_mask: is the minimum of both.

3) TLB Lookup
   For stage-1 and nested translations, it look for STAGE_1 entries.
   For stage-2 it look for STAGE_2 TLB entries.

4) TLB invalidation
   - Stage-1 commands (CMD_TLBI_NH_VAA, SMMU_CMD_TLBI_NH_VA,
     SMMU_CMD_TLBI_NH_ALL): Invalidate TLBs tagged with SMMU_STAGE_1.
   - Stage-2 commands (CMD_TLBI_S2_IPA): Invalidate TLBs tagged with
     SMMU_STAGE_2.
   - All (SMMU_CMD_TLBI_S12_VMALL): Will invalidate both, this is
     communicated to the TLB as SMMU_NESTED which is (SMMU_STAGE_1 |
     SMMU_STAGE_2) which uses it as a mask.

   As far as I understand, this is compliant with the ARM
   architecture, based on:
   - ARM ARM DDI 0487J.a: RLGSCG, RTVTYQ, RGNJPZ
   - ARM IHI 0070F.b: 16.2 Caching

   An alternative approach would be to instantiate 2 TLBs, one per
   each stage. I haven=E2=80=99t investigated that.

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

2) Patch 0006 (hw/arm/smmuv3: Translate CD and TT using stage-2 table)
   introduces a macro to use functions that rely on cfg for stage-2,
   I don=E2=80=99t like it. However, I didn=E2=80=99t find a simple way aro=
und it,
   either we change many functions to have a separate stage argument,
   or add another arg in config, which is probably more code.

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

hw/arm/smmuv3: Split smmuv3_translate() better viewed with --color-moved


Mostafa Saleh (12):
  hw/arm/smmu: Use enum for SMMU stage
  hw/arm/smmu: Split smmuv3_translate()
  hw/arm/smmu: Add stage to TLB
  hw/arm/smmu: Support nesting in commands
  hw/arm/smmuv3: Support nested SMMUs in smmuv3_notify_iova()
  hw/arm/smmuv3: Translate CD and TT using stage-2 table
  hw/arm/smmu-common: Support nested translation
  hw/arm/smmuv3: Support and advertise nesting
  hw/arm/smmuv3: Advertise S2FWB
  hw/arm/smmu: Refactor SMMU OAS
  hw/arm/smmuv3: Add property for OAS
  hw/arm/virt: Set SMMU OAS based on CPU PARANGE

 hw/arm/smmu-common.c         | 256 ++++++++++++++++++----
 hw/arm/smmu-internal.h       |   2 +
 hw/arm/smmuv3-internal.h     |  17 +-
 hw/arm/smmuv3.c              | 405 ++++++++++++++++++++++-------------
 hw/arm/trace-events          |  14 +-
 hw/arm/virt.c                |  14 +-
 include/hw/arm/smmu-common.h |  46 +++-
 include/hw/arm/smmuv3.h      |   1 +
 target/arm/cpu.h             |   2 +
 target/arm/cpu64.c           |   5 +
 10 files changed, 533 insertions(+), 229 deletions(-)

--=20
2.44.0.396.g6e790dbe36-goog


