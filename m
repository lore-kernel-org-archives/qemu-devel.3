Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC55CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpgL-0006w9-Dr; Mon, 08 Apr 2024 10:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3e_oTZggKCvYqkmqrYdYemmejc.amkocks-bctcjlmlels.mpe@flex--smostafa.bounces.google.com>)
 id 1rtpgJ-0006uK-GA
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:07 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3e_oTZggKCvYqkmqrYdYemmejc.amkocks-bctcjlmlels.mpe@flex--smostafa.bounces.google.com>)
 id 1rtpgE-0001J5-0c
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:07 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6150e36ca0dso65515907b3.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712585340; x=1713190140; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NLZ1DYSCUHy7vwgXmykXXQThwxqVk3hHzLk0I+Ol/to=;
 b=X8h+t7g6GH9WoJgSY0vRgu9fjPY3fl6ULmtIfEaqGVQNuwU4cF4mJXZ52zh+nV+r8j
 axRxqCd8RdPKO8JdpMeaFej0wEdomj+zNcPa+azTrmPi2EuD/mOnOKqcjeA8u7hTBoy4
 OdzBQ516O6xqqaQz2KdlTtqkoH60gJyif6FI0Y/Ylv2GU09OuKFoupurEZE399o8I6N3
 fqxZ7Tz3X8Xp6bP9bJskotRbCPUkh8cl0+W0Dv8OQbeI0znk/TiAtAvn1BJmWK6Jt4fR
 42LOL+xrj5qa1nB35GUXCaCe0pNGNGm3yf4ifQsJV2ndKjixLW4WUGZ+Bqf0940vInX6
 OyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585340; x=1713190140;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLZ1DYSCUHy7vwgXmykXXQThwxqVk3hHzLk0I+Ol/to=;
 b=s1fyWDq7UvYHcxCXVj00b4ZKMIs/F9oKRm+fRqQVvkgMlnjH7Dv1PtZ4EAHtDkzvi7
 qAV47t6NwLQYhNDBPvh77j02of8ZdqYPaokLSPdXS9Vab0Y4TUiuMKQ+8/j9XF0I8b8h
 kNpZIAu8IF5P4cKxWICaOwprRalkWFw0LG+6WjB7yVHeTptyQwTDhYF6Fa3FD8bPsKnV
 vJV+2bDx4TLkdG3WtAuoqErhl/Ih0M3KXFIypztPGme1HA4RrlUcqHBJP/FnVkmNI9hk
 1dRzDxx/7Pwn2ree8hXPQECjgurHuQWc8uaiKmpAV+RZlOq4WJQNTQeq1VX5qfCvVAtE
 woBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHhbSE1jCDGJsYIOjrFv6rq13qRrqKTrm7c9RQIVbFnJsjj6gEBMBcGWWUGVNYnoCCoj6qigz9LYEUrIsNKyvS5XvjUwc=
X-Gm-Message-State: AOJu0YzHu6lfzTQGyq8UiG9FS3NANrZaOls7LyRiB/70UgYV2OzAn16E
 cw6Fi/rE8ekjvQIRV1Vwb2QrdUtNP1eQRdHMbMI8tkjVxcogyF82fWFQvuxr6PDHH96uhpAPX05
 JLQ1n/0FXSg==
X-Google-Smtp-Source: AGHT+IE1Q1LdzTAE3ST+4+e5xy8cHcG2rBiP4XMSy4WwOu3sF80cKufjTrScDzf7KH+OiJ76fQL1tA2a0D1t0g==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a0d:d74c:0:b0:615:2597:7246 with SMTP id
 z73-20020a0dd74c000000b0061525977246mr2354981ywd.6.1712585339740; Mon, 08 Apr
 2024 07:08:59 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:08:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408140818.3799590-1-smostafa@google.com>
Subject: [RFC PATCH v2 00/13] SMMUv3 nested translation support
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3e_oTZggKCvYqkmqrYdYemmejc.amkocks-bctcjlmlels.mpe@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

I also modified the Linux driver to test with mixed granules/levels.

hw/arm/smmuv3: Split smmuv3_translate() better viewed with --color-moved

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


Mostafa Saleh (13):
  hw/arm/smmu: Use enum for SMMU stage
  hw/arm/smmu: Split smmuv3_translate()
  hw/arm/smmu: Consolidate ASID and VMID types
  hw/arm/smmuv3: Translate CD and TT using stage-2 table
  hw/arm/smmu-common: Support nested translation
  hw/arm/smmu: Support nesting in smmuv3_range_inval()
  hw/arm/smmu: Support nesting in the rest of commands
  hw/arm/smmuv3: Support nested SMMUs in smmuv3_notify_iova()
  hw/arm/smmuv3: Support and advertise nesting
  hw/arm/smmuv3: Advertise S2FWB
  hw/arm/smmu: Refactor SMMU OAS
  hw/arm/smmuv3: Add property for OAS
  hw/arm/virt: Set SMMU OAS based on CPU PARANGE

 hw/arm/smmu-common.c         | 306 +++++++++++++++++++++----
 hw/arm/smmuv3-internal.h     |  16 +-
 hw/arm/smmuv3.c              | 418 ++++++++++++++++++++++-------------
 hw/arm/trace-events          |  18 +-
 hw/arm/virt.c                |  14 +-
 include/hw/arm/smmu-common.h |  57 ++++-
 include/hw/arm/smmuv3.h      |   1 +
 target/arm/cpu.h             |   2 +
 target/arm/cpu64.c           |   5 +
 9 files changed, 608 insertions(+), 229 deletions(-)

--=20
2.44.0.478.gd926399ef9-goog


