Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D72C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutcJ-0003S6-HU; Fri, 14 Aug 2026 11:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wutcI-0003Ru-PM; Fri, 14 Aug 2026 11:14:42 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wutcG-00025u-E1; Fri, 14 Aug 2026 11:14:42 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 61B99EC01DD;
 Fri, 14 Aug 2026 11:14:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Fri, 14 Aug 2026 11:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786720479; x=1786806879; bh=naTs+bdBCz/5xVv2l2/vQ6xhQ6CCcFqr
 Z60UeySpEeg=; b=ZvtFjXrkGBS1r+JEF3Ein95J8rGJwtMq0Pea1/JXa7ZUUNP+
 xq5tl2KGeliunrSRmaWXLQQo7ustltlh5+qa4lJ7V/AZBYE+q1GHijdhQEwBj4y4
 chL6Xt31rOx1rmz9u5MNXZhnspyIgVNjw6/jnBAYrfHDVW9xCEJghrBL1MGTLq+S
 SPiT48Oyz5RzLe/qv4C9s3a7hZzOycPBmnj05BXv03PPCNXPnfXcOPzRy0xt4uuX
 g/8B6MFfqS2eyi1++GawKLghEu4qKhLu0hMZ6geaMbfv1c/jKn1cicmHbWgvo/l8
 eAlJlaYZQZoSQrYZ4sBDtCvf50jbVNIiZs337A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786720479; x=
 1786806879; bh=naTs+bdBCz/5xVv2l2/vQ6xhQ6CCcFqrZ60UeySpEeg=; b=i
 HbTgew7vmu0l/isDkcUR3XvI7MZC/WYgB4LCYJSR7QupeFR8ySWfUvJI0miMJQNQ
 foolcZLUwdtK+3zja2piR3Ud2KD62D9nZOxp1ykcOJwjtNwfH6Ubnd2JORNNh0kS
 88Fp2RA+LhiNS/xxJN0IwfKKyPCD6b7kxJ22ccR7QPembe52r8lvLDE9Wec7Ww44
 78Y5fBriup48HJF7SfQmfvRy/Ww+amoxqB4ty2logAMsqm5jikmJOA5mVO3DO7X/
 uGQqn3ovgGJmT5My9dtr78xrnEFkf76ejqvClp8iAid0j1aLjiTmCOttRwlF2jyG
 /AxENkTzrQs9uVuDzyRAA==
X-ME-Sender: <xms:3jB_apsakPhw7_GbepBDPbY9Bhded5CZyTIFsR6SQ6C2XVQwKB38wQ>
 <xme:3jB_akua9DwKs_HA1xcAG22kfOQejpVzmGI-7Lsli_ku8l_sw71HWPaLz3RdYuQBG
 EiydfYqttyp8P0MhJiQ-b1w96SB0H1sxZsUlV43dE1X1UtDwbuh_O0>
X-ME-Received: <xmr:3jB_avDvLOkJtzKXOOIYFx3AMGy0p-WZwDCn-ywSkLdVeq-RM4M5IsotV-X2zSliw7yhtw>
X-ME-Proxy-Cause: dmFkZTFpvmmDfbqKco3jPHkGR7+ykrliUBFBG1keBBjoCbLjXflxTNdl3HAqLJsh9zF1hD
 dqkWJVDSJgji/QKCs6kkwWlexiJ790lZNTMfudje/3Fdvm96MSGvydvCltRiYK4YJaSV+t
 YPmhFn5c9XvIocn3e5Qm8NHkKDF7RM5jGhW78JG8Q8xBFiE6C0pDUUhzumGE5EAhFZdtI4
 FBZXOIYaaGC4tzfJc1vBTEJyXjMGr4hImAlrKIuiW4AZIS95aXelN5aTs1VZCuDQg2QwUh
 nKBuUWvKQM//ClTY4ZVRk0hE2SU+SlSFoNT1wDbCApwMf2ThI1tCxyfs/BDvk3qsoMD9Gh
 fNPZgUyZmXDYNY61b7YUOYWDw37N/Q1NcBCfDOufxhSPg8vEA6Lu0uApBT6yYwWxlYVTGT
 0BglHyKGePLHvKXM9511rHc3ggWbvGYK4+lYk76iM/VsoGQDzfelsh3aQPNf/5tInhpvUj
 9crQUvxERS6GNh3lNza3xfp8RTzpZ65XoJkjc24JYqfLDKWO2czjX8iPTTSrmvnL8yzGOp
 4uJ7vJnJewf9aemtaFanTMDwGk6ODMNc/JzN77ixkYJKnH+CGk71nxMFTdWc0ohKdLjGkU
 AR4vEZAnwvRTWlRBhVDWUuCvnrJrYFk9v2gcL0UpqD4as1OWCwuqpVwtIzNg
X-ME-Proxy: <xmx:3jB_amM3o4e9VJxybzLn58YtBLZwEUxpQY5hr_WPToipL6dSnXwoeQ>
 <xmx:3jB_aoxbOpV81h_ZazMF59hqaA-5m8EpdBNBX38-lfNQ_lNpWf1s8g>
 <xmx:3jB_amUidhdMxFfJKTMD9CXucAB26ql81V6FK5c1jbinGz5IgZWviQ>
 <xmx:3jB_aqO-Kd--TxtuI076NeHpIk7M6xLwt1NRdLx8pq0KcV_kXEYJrg>
 <xmx:3zB_auevfBaT6_KWdHbv3r8RitgddEeuE9erCuy2KygW4Dj5IJKDgH82>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 11:14:36 -0400 (EDT)
Message-ID: <899163cdf2fe47a08ca57770cc1be6c8eb6443d0.camel@alistair23.me>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A=5BRFC?= PATCH v1 00/17]
 target/riscv: Add KVM CoVE confidential VM support
From: Alistair <alistair@alistair23.me>
To: blduan <blduan@linux.alibaba.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-riscv <qemu-riscv@nongnu.org>, alistair23 <alistair23@gmail.com>, 
 dbarboza <dbarboza@ventanamicro.com>, cxx194832
 <cxx194832@alibaba-inc.com>, "zengxiangyi.zxy"	
 <zengxiangyi.zxy@alibaba-inc.com>
Date: Sat, 15 Aug 2026 01:14:36 +1000
In-Reply-To: <14dcd084-b9ab-4ce1-80cd-3ba91038a4b4.blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
 ,<9e606a9e83adafb2f58ea2c5386f7fb6d5fbf6c1.camel@alistair23.me>
 <14dcd084-b9ab-4ce1-80cd-3ba91038a4b4.blduan@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=alistair@alistair23.me; helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 2026-08-14 at 14:24 +0800, blduan wrote:
> Hi Alistair,
>=20
> Thanks for the review and the encouraging words!
>=20
> > Thanks for the RFC. When it comes time to send patches make sure
> > you
> > check against
> > https://wiki.qemu.org/Documentation/Platforms/RISCV#RISC-V_Foundation_E=
xtensions
> > .
> >=20
> > Notably:
> > =C2=A0 - You need to be clear about which exact spec release you are
> > using
>=20
> Will specify the exact spec version and tag in v2 cover letter.
> We are based on CoVE v0.7:
> https://github.com/riscv-non-isa/riscv-ap-tee
>=20
> > =C2=A0 - You will need to add tests
>=20
> Understood. Will add qtest cases for v2.
>=20
> > =C2=A0 - The support needs to be experimental for a draft spec
>=20
> Acknowledged. In v2 we plan to migrate to the
> ConfidentialGuestSupport
> framework (as noted in my reply to patch 11), so the user interface
> will become:
> =C2=A0 -object riscv-cove-guest,id=3Dcove0 \
> =C2=A0 -machine confidential-guest-support=3Dcove0
>=20
> We will mark it experimental following the wiki guidelines.
>=20
> > =C2=A0 - You will need to link to kernel patches to support CoVE
>=20
> Acknowledged. The KVM CoVE kernel support is currently developed
> against a vendor tree. We are working on rebasing the relevant KVM
> interface patches onto mainline Linux and will provide a public
> branch or patches for review before sending v2.
>=20
> > What firmware are you using? OpenSBI? You must need a fair few
> > changes
> > for this to work right?
>=20
> We follow CoVE Deployment Model 1 (DP1). The firmware stack is:
> =C2=A0 - M-mode: OpenSBI extended with RDSM (Root Domain Security Manager=
)
> =C2=A0 - HS-mode Confidential Supervisor Domain: TSM (TEE Security
> Manager)
> =C2=A0 - HS-mode Hosting Supervisor Domain: Host OS / VMM
>=20
> The RDSM patches are being prepared for contribution to the OpenSBI
> community. The TSM is developed in-house and we are working toward
> open-sourcing it. Our colleague Vincent Cui will present the full
> CoVE DP1 PoC at the next AP-TEE meeting, covering the end-to-end
> firmware and software stack.
>=20
> > Are we able to access and test this setup?
>=20
> We will provide reproduction instructions as part of Vincent's
> presentation. Happy to follow up on that after the meeting.

Great! Just to be clear, those meetings aren't open and I (and lots of
other people) don't have access to that.

This would need some open documentation of how to run this. Exciting to
see it coming along though. I would be interested in seeing the TSM
code as well when that's available.

Alistair

>=20
> > > docs/system/riscv/virt: document the cove-vm machine option
> >=20
> > Add the docs after adding the feature
> >=20
> > > hw/riscv/virt: add the cove-vm machine property
> >=20
> > This is in the wrong order. We want to add the feature then expose
> > it
> > to users, not the other way around.
>=20
> Agreed. Will reorder in v2: implementation patches first, user-facing
> interface last, docs at the end.
>=20
> Thanks,
> Baolong
>=20
>=20
> > ------------------------------------------------------------------
> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AAlistair <alistair@alistair23.me>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2026=E5=B9=B48=E6=9C=8813=
=E6=97=A5(=E5=91=A8=E5=9B=9B) 00:36
> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9ABaolong Duan<blduan@linux.alibaba.c=
om>; "qemu-
> > devel"<qemu-devel@nongnu.org>
> > =E6=8A=84=E3=80=80=E9=80=81=EF=BC=9A"qemu-riscv"<qemu-riscv@nongnu.org>=
;
> > alistair23<alistair23@gmail.com>;
> > dbarboza<dbarboza@ventanamicro.com>;
> > cxx194832<cxx194832@alibaba-inc.com>;
> > "zengxiangyi.zxy"<zengxiangyi.zxy@alibaba-inc.com>
> > =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [RFC PATCH v1 00/17] target/ris=
cv: Add KVM CoVE
> > confidential VM support
> >=20
> > On Fri, 2026-07-31 at 11:49 +0800, Baolong Duan wrote:
> > > This series adds RISC-V CoVE (Confidential VM Extension) support
> > > to
> > > the
> > > virt machine when running with KVM acceleration.
> > >=20
> > > CoVE is the RISC-V equivalent of AMD SEV / Intel TDX, defined by
> > > the
> > > RISC-V AP-TEE specification [1].=C2=A0 A CoVE guest is a TEE VM (TVM)
> >=20
> > Cool!
> >=20
> > > whose
> > > memory and vCPU state are owned by the TEE Security Manager
> > > (TSM),
> > > making them inaccessible to the host.
> > >=20
> > > The series adds a "cove-vm" machine property to the virt board
> > > and
> > > adapts
> > > the boot flow, interrupt routing, memory registration and device
> > > model to
> > > the constraints of a confidential guest:
> >=20
> > Awesome! I'm excited to see RISC-V CC coming along.
> >=20
> > Thanks for the RFC. When it comes time to send patches make sure
> > you
> > check against
> > https://wiki.qemu.org/Documentation/Platforms/RISCV#RISC-V_Foundation_E=
xtensions
> > .
> >=20
> > Notably:
> > =C2=A0- You need to be clear about which exact spec release you are
> > using
> > =C2=A0- You will need to add tests
> > =C2=A0- The support needs to be experimental for a draft spec
> > =C2=A0- You will need to link to kernel patches to support CoVE
> >=20
> > >=20
> > > =C2=A0 - kernel, initrd and device tree are measured before the guest
> > > starts
> > > =C2=A0 - interrupts are MSI-only (IMSIC mandatory, APLIC emulated by
> > > QEMU)
> > > =C2=A0 - virtio uses modern PCI transport with
> > > VIRTIO_F_ACCESS_PLATFORM
> > > =C2=A0 - vhost is disabled (host kernel has no access to guest memory=
)
> > > =C2=A0 - vCPU threads are pinned (TSM binds vCPUs to harts)
> >=20
> > What firmware are you using? OpenSBI? You must need a fair few
> > changes
> > for this to work right?
> >=20
> > >=20
> > > The KVM interface used here (KVM_VM_TYPE_RISCV_COVE and
> > > KVM_RISCV_COVE_MEASURE_REGION) is not yet part of an upstream
> > > Linux
> > > release.=C2=A0 The definitions are kept locally and will be replaced
> > > by a
> > > linux-headers update once the kernel side has been merged.
> > >=20
> > > Patches 15 and 17 contain known workarounds and explicitly ask
> > > for
> > > design
> > > guidance:
> > >=20
> > > =C2=A0 - Patch 15 pins vCPU threads and adds a yield after KVM_RUN to
> > > avoid
> > > =C2=A0 =C2=A0 host RCU stalls.=C2=A0 Thread placement should be left =
to the user
> > > or
> > > =C2=A0 =C2=A0 management layer.
> > >=20
> > > =C2=A0 - Patch 17 converts system_reset into a shutdown because a TVM
> > > cannot be
> > > =C2=A0 =C2=A0 recreated.=C2=A0 The proper approach may be to implemen=
t
> > > =C2=A0 =C2=A0 ConfidentialGuestSupport and use the existing
> > > can_rebuild_state()
> > > =C2=A0 =C2=A0 machinery.
> > >=20
> > > Tested with QEMU TCG emulating a CoVE-capable Xuantie C930
> > > platform.
> >=20
> > Are we able to access and test this setup?
> >=20
> > >=20
> > > [1] https://github.com/riscv-non-isa/riscv-ap-tee
> > >=20
> > > Baolong Duan (17):
> > > =C2=A0 docs/system/riscv/virt: document the cove-vm machine option
> >=20
> > Add the docs after adding the feature
> >=20
> > > =C2=A0 hw/riscv/virt: add the cove-vm machine property
> >=20
> > This is in the wrong order. We want to add the feature then expose
> > it
> > to users, not the other way around.
> >=20
> > Alistair
> >=20
> > > =C2=A0 target/riscv/kvm: create and measure a CoVE TEE VM
> > > =C2=A0 accel/kvm: add kvm_gpa_to_userspace_addr()
> > > =C2=A0 hw/riscv/boot: load and measure the images of a CoVE guest
> > > =C2=A0 hw/riscv/virt: measure the device tree of a CoVE guest
> > > =C2=A0 hw/riscv: adapt the device tree of a CoVE guest
> > > =C2=A0 hw/riscv/virt: use MSIs only for a CoVE guest
> > > =C2=A0 hw/intc/riscv_aplic: emulate the APLIC for a CoVE guest
> > > =C2=A0 target/riscv/kvm: skip unsupported KVM requests for a CoVE
> > > guest
> > > =C2=A0 hw/virtio: force modern virtio for a CoVE guest
> > > =C2=A0 hw/net/virtio-net: do not use vhost for a CoVE guest
> > > =C2=A0 accel/kvm: only register the DRAM slot of a CoVE guest
> > > =C2=A0 accel/kvm: skip MSI route updates for a CoVE guest
> > > =C2=A0 accel/kvm: pin the vCPU threads of a CoVE guest
> > > =C2=A0 accel/kvm: terminate on a system event of a CoVE guest
> > > =C2=A0 hw/core/machine-qmp-cmds: shut down a CoVE guest on reset
> > >=20
> > > =C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 6 ++
> > > =C2=A0 accel/kvm/kvm-accel-ops.c=C2=A0 =C2=A0 |=C2=A0 16 +++++
> > > =C2=A0 accel/kvm/kvm-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
60 +++++++++++++++++
> > > =C2=A0 docs/system/riscv/virt.rst =C2=A0 |=C2=A0 39 +++++++++++
> > > =C2=A0 hw/core/machine-qmp-cmds.c =C2=A0 |=C2=A0 10 +++
> > > =C2=A0 hw/core/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 18 +++++
> > > =C2=A0 hw/intc/riscv_aplic.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 9 ++=
+
> > > =C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 9 +++
> > > =C2=A0 hw/riscv/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 91 +++++++++++++++++++++++++
> > > =C2=A0 hw/riscv/fdt-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 4 +-
> > > =C2=A0 hw/riscv/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 4 ++
> > > =C2=A0 hw/riscv/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 125
> > > +++++++++++++++++++++++++++++----
> > > --
> > > =C2=A0 hw/virtio/virtio-bus.c =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 ++++
> > > =C2=A0 hw/virtio/virtio-pci.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 9 ++-
> > > =C2=A0 include/hw/riscv/cove.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 24 +++++++
> > > =C2=A0 include/hw/riscv/virt.h=C2=A0 =C2=A0 =C2=A0 | =C2=A0 1 +
> > > =C2=A0 include/system/kvm.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 ++=
+++
> > > =C2=A0 target/riscv/kvm/kvm-cpu.c =C2=A0 |=C2=A0 67 +++++++++++++++++=
+-
> > > =C2=A0 target/riscv/kvm/kvm_riscv.h |=C2=A0 10 +++
> > > =C2=A0 19 files changed, 508 insertions(+), 24 deletions(-)
> > > =C2=A0 create mode 100644 include/hw/riscv/cove.h

