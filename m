Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FBF606A32A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iY8KY+di
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUryQ-0004R5-53; Sat, 21 Nov 2026 15:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xUryO-0004Qn-Jd
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 15:46:12 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xUryM-0005yn-8T
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 15:46:12 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso17318195e9.1
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 12:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795293968; x=1795898768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5CEcBG3blFgFIs0HQDqojA8cBNelrZOI2gSACkV84r0=;
 b=iY8KY+diuwaUD/A1X+TlaS14svjcxQ/20s0vVr19hHTokQBYTjWq/LyhI6KwkJPwC0
 x1hx54OtUh3EGCfkhhfmj/AmDDxr8PypZm1JcIFCjiaw/3hmetreRcZIHvZMLbv2xcKA
 O/HryrZKqUBqSB2bSe8XxMfu+HWRkiWl81b1AJh+eIK3tLD7x3luYAwihk8Izcn+b8xP
 iwYzxq/puxUxxUg6LDe3Xmpx9R6hdb2CQ1i9hQ4xFJ3J8SDoo5/uwI7i2r8QTAvbTCeg
 Txs6TA/KJ47/x4Ew/pcOuqzxGgDGq7IFVQad5IanWnnbwSxsWqS06Ss5AjsR3NjN5+Mg
 JLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795293968; x=1795898768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5CEcBG3blFgFIs0HQDqojA8cBNelrZOI2gSACkV84r0=;
 b=KE39PGzvdZzI2UHvsy3Mg25ALmN+WENbyOoDA95xokOR96qy1+OvwnwwC3lUDG+xCZ
 n0dMd6l5BIwsBJAb2PxCUXteI679dRvelFAuuPgaghxCIZwX6CUrvbxh2ow9UvNVjUBV
 MXp0iwcB0QmESGIupdfk8BcVgW6QUZyIJtEnspWikfqlEFTWVTRfh8usBZcgA2eqtTxr
 IDSSZTdBBvKxk3y3AkRBLBhyVDIcCpdoSWNInMJUsT1b+aACVnzQojSHDbgj9GLwxUzY
 57XaMkcw4Q1x3BWa7/0HAVRq10WuhYHuMtbk+obHa09bj/j2yXwyPZDsLpa88uPe4rkK
 Mo8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEDuRJd3vOHpKfQWJVKvCjG/vrYlvXTPG7rD+EkgT+54+01EzJGwU7EsZm5c/UPvismRhtnrv5SIOrk@nongnu.org
X-Gm-Message-State: APuU4Z/qwjeqMz+MUmHGq9kmQ6lrrgFqGJFLUy9FRs3awnMszET6PHjF
 6mzGV/jOtnCMm4kleGS7y0WMSNlbUiPEzw8s7uDhgd+PUPpjgm9yvu/z
X-Gm-Gg: AZFdTZcoTsNJ5XDyh+aLI4dYdkpw1FZ4OCz4bxPfoqWrVkqphla8X6NM2kyGvzzcaXm
 HWwMfwu+8flu9HaGJDH+seA1iv4w4DZsqEN9xfrq+OLI/X+2060SGtH35mwtjaTuU1C3Mw4Ljup
 56dziqkNNmhPlp+ysrw+v6vDlgORBNdWx3E7k9dqub9n9T/BA0ZOZ9UVwe69hp2lU3nIsSU0UqB
 rVEKxBCYE8cF4hPfjKB1CxDH1rfJXxNzgTWz0g8FeDmbIAorZJP7uqnZbwBdVeqsk+0i/hFTq08
 udl8sQLFM3JrAt7zEeHWDy416kcGCqN2df0sU2S46WlNHRIHErEJMe4ie9CyTSse/RbXcI0A0dC
 uylL36ByAWJiVdJz6t8PEsgMzxHVlNnj/Sh+WwEurrA6Pf4G12W9hNsezXIv1LG8wKWnf8PS3g2
 gim/rPL+4y7b3mdQ7OIcWi57ggAOFuIoVGfdRnj7AJeDe0n88qXx6EIVMG8vXPJHw1jmD3aawPu
 WPal22mvUnvMVIgRrUmP6J9Hd99vXoafeheg5H2ZCURx0EOWsME028PMcCizAioC95jJjBTqL80
 5ZG0/3sTaP2l6IGyrOj8KWDdPu3nydZhd7cud9J8NMwjsfZ5XbSEjxDRkRy2NxakA5TpSGmL0M5
 SEIXlIWXVeVeRu/WFjdd57jo=
X-Received: by 2002:a05:600c:19d4:b0:4a1:f377:5c6c with SMTP id
 5b1f17b1804b1-4bb8880ac6amr157380645e9.10.1795293967927; 
 Sat, 21 Nov 2026 12:46:07 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm180652385e9.12.2026.11.21.12.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 12:46:07 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [RFC PATCH v2 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
Date: Sun, 22 Nov 2026 01:45:58 +0500
Message-ID: <20261121204601.741616-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121095636.289814-1-haseebashraf091@gmail.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Hi,

KVM presents a VHE-only EL2 (HCR_EL2.E2H RES1) to a nested guest unless
KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at vCPU initialization.  Guest
hypervisors which only support nVHE, such as Xen, cannot run in that
mode.  This series lets the user select an nVHE-only EL2 with:

  -M virt,virtualization=on -accel kvm \
      -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=0

Following Marc's feedback on v1, this is built on Eric Auger's
SYSREG_<REG>_<FIELD> framework instead of a new machine or CPU
property.  It is an RFC because that framework is not merged yet.

Dependencies
------------

The series applies on top of the remaining patches of Eric's v11 [1],
which are on his arm-cpu-model-v11-rc branch [2], rebased on current
master.  On current master those patches need two mechanical build
fixes: object_property_add() now takes &uint64_type_info, and
kvm_feature_idx_to_idregs_idx() must sit after kvm_arm_sve_get_vls()
instead of inside it.  The fixes belong to Eric's series and are not
part of these three patches.

Questions
---------

 - KVM does not let userspace write ID_AA64MMFR1_EL1.VH, so the generic
   "writable fields only" rule would not create the property.  Patch 2
   treats VH as selected through a vCPU init feature and exposes it as
   an exception.  Is that acceptable, or would you prefer a generic
   representation of such fields in the framework?
 - Only VH is updated in QEMU's copy of the ID registers.  Other fields
   which KVM derives from E2H0, for example ID_AA64MMFR4_EL1, are not
   refreshed.  Is that acceptable, or should QEMU re-read the ID
   registers after vCPU initialization?

Scope
-----

TCG and HVF are unchanged by design.  The property is available for the
host (and max) CPU model with KVM, when the host kernel advertises
KVM_CAP_ARM_EL2_E2H0.  Xen and QNX already boot with TCG, where
HCR_EL2.E2H is under the control of the guest.

Changes since v1 [3]:

  - Removed the dedicated virt machine and ARM CPU "vhe" properties.
  - Switched to Eric's SYSREG ID-register framework and use
    SYSREG_ID_AA64MMFR1_EL1_VH to select an nVHE-only EL2.
  - Exposed the property only when KVM advertises
    KVM_CAP_ARM_EL2_E2H0.
  - Derived KVM_ARM_VCPU_HAS_EL2_E2H0 from VH and rejected VH=0 when
    virtualization is disabled.
  - Added documentation and a KVM functional selftest which verifies
    that the guest hypervisor initializes in nVHE mode.

Testing
-------

Validation was performed on an AmpereOne A192-32X (Ampere-1a) running
host kernel 6.18.29+3-arm64:

  - TCG-only, KVM-only and aarch64-linux-user builds succeeded.
  - TCG rejects SYSREG_ID_AA64MMFR1_EL1_VH because the property does not
    exist for that accelerator.
  - The existing AArch64 KVM nVHE and VHE selftests pass under TCG.
  - The arm-cpu-features qtest passes.
  - Linux 6.12.67 initialized KVM in nVHE mode with VH=0 and in VHE mode
    with VH=1; both boots reached login.
  - QNX Hypervisor 8.0.5 reached login with both values and reported the
    corresponding ID register state.
  - Xen dom0 reached login with VH=0.  With VH=1, Xen did not boot.
  - The complete AArch64 KVM functional suite passed, including the new
    nVHE-only selftest.

Not tested: live migration, and hosts other than AmpereOne.

[1] https://patchew.org/QEMU/20261030131406.461599-1-eric.auger@redhat.com/
[2] https://github.com/eauger/qemu/commits/arm-cpu-model-v11-rc
[3] https://patchew.org/QEMU/20261121095636.289814-1-haseebashraf091@gmail.com/

Thanks,
Haseeb

Haseeb Ashraf (3):
  target/arm/kvm: Add kvm_arm_el2_e2h0_supported()
  target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH select an nVHE EL2
  tests/functional: Add a KVM selftest for an nVHE-only EL2

 docs/system/arm/cpu-features.rst     | 22 ++++++++++++
 target/arm/cpu-idregs.h              | 31 +++++++++++++++++
 target/arm/cpu64.c                   | 51 ++++++++++++++++++++++------
 target/arm/kvm-stub.c                |  5 +++
 target/arm/kvm.c                     | 29 ++++++++++++++--
 target/arm/kvm_arm.h                 | 13 +++++++
 tests/functional/aarch64/test_kvm.py | 22 ++++++++++--
 7 files changed, 157 insertions(+), 16 deletions(-)

