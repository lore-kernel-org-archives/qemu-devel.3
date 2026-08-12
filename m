Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3152DC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBwe-0001o3-Ot; Wed, 12 Aug 2026 12:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuBwd-0001hG-MQ; Wed, 12 Aug 2026 12:36:47 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuBwb-0004iq-LO; Wed, 12 Aug 2026 12:36:47 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 60C51EC00AF;
 Wed, 12 Aug 2026 12:36:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 12:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786552604; x=1786639004; bh=y5IC2fVU/9n8r0WP/Sp0oYTjC3/Z6asO
 iEmUnext6Iw=; b=n4fF23+Tl+xwoY/i8m+eVAC/YaMUSM0QSqnpIoZvJRAJ48fz
 rSMSVK9DnMBoZxu6jTgLUBdtGfLfs6xo5ILd+OI8Syrn0t+yiKYK4pRd/UMxrC/q
 SotemEdrR52SmSxiuOJAwNtkHjJWvJjM0Xuuxdj4jCOXY4qznkWSDInXNxc1uMDE
 ztUQnQThBGL2H34xPv3uXpLv3q6vNa854HkGaQ8k1J6CKvh6ipRRaC0TiAZWw1O+
 vWMxPkO1WrHSbxQWtCc800VMF9cQim2IwPoGE3oxqU41qhuqimC/cS+8qvdJlJx6
 nlzqwBtGcQtXd6m3SlT4GPWSu+5rr2mT9F+hhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786552604; x=
 1786639004; bh=y5IC2fVU/9n8r0WP/Sp0oYTjC3/Z6asOiEmUnext6Iw=; b=T
 RluRJtudjrOwwfSnJgFiIuyaPQtocx/YhN2CZDH8mXnIkaNwwJ9if4rDEPnVvtKK
 LyF7j+nkGaiD110jXkkbsLxIQZJr/ecCjK+nQVXBNGZsxcBfv175exND+qRo+6xX
 Jap0ZBS3Yk7i2XwisTukPkO9Z4shE9/pWPdSLtXR8prhL0cTwHhneDmBzor7MfXJ
 4X5u5UOVz40DmbvKlWIAuvlxUF/Ze1y3XX4a2abLF5rm7AwzQr8hBxyg9kw64D4B
 L5gBZROZLmqZ6ZX5rK2cvV6nQ8+3SidDo9d2GrrXkwmK5B3txT8PeLDoBjEvuR9i
 vCb8PuSeJNTey0zikDWrA==
X-ME-Sender: <xms:G6F8ajFPOK_ajsdReQuGX2zuo0vKDprxdSRjo2bQUZYa4tdp5rNs2Q>
 <xme:G6F8ainCGbBcqC_wzL73FFzwdIaGawlSLyJhtlGo3sSMnJkOHSbwaeH4YM27iOLtb
 voORYqxswR73PbHdbOwdNmr7SG-GB14iIGsqY0GLocoRghRC7ir8sk>
X-ME-Received: <xmr:G6F8anZdeJZSsSbHycV1_J6b4Mxu0PHGe1rM0RxG1mM-hgmOCOi5N6X5mRQTO5Zl71Hlxg>
X-ME-Proxy-Cause: dmFkZTGMtFjU0zdUK3JgzUZIlA4x2okjR12GkZIlO05lEwnxzAqMFLm/X21V+UaUQRFNuo
 SpgU6XSxNfDybXKmnhHRwh6/b22u+Lh0aUNaP6vPOXv8ZeVEyGZVtkJxNZwUn+o+9XtO1e
 2ZimnX8eOxl3hY2sjhnuhRJTR0250kjCEkx+obc8UNtpcguCh3Lk9VjYJIhII05KgO/vn8
 ql5J1uSSeJMX6mIb7zAn5mXIVl8K/22zldnE8uHUaHwowKkgGzyee6wBxJHf8GTev4L1bK
 43mypmkHvtgDKGFJDACVOPJM5IeZ6GSJBnJ2jw6POEdDIu7rW4E1WjlCM8dxK7U5PDSHpl
 L3BVOIep6x2sf6pkPW0lAsPMGY3M3nEXNtox5hgvYH5tvSBm3Q9U9fYMhkgQkfRbTPZuCB
 6Zu2p1YeUlnMkI8PfkXWAKRD42SZhHPL3aIhFr70JnXq/8QV8YX+bYawTZWnqD6+loXGBm
 rQk/c5gSA8jlByVFDC4II76Gzp2+AXUs4t/GJpS7lexUkxJG44xOmiL4x09OBXPWbC/hb7
 k+uTIOJxxyI6Si3ARaoT6fjEQw9kOpv6Bd8/kL+N6Dnxq6WR0LXEbZNP1D5dR0AXgGsx6A
 uzDxQ3a9w2sFNxyDeSA15dgn0IwELcO2IX82F68KhB87EdikIRE5kpluUXqA
X-ME-Proxy: <xmx:G6F8anE9r0Cu2lL1UIRrgTD5RB1qf3fh6sY2q_jSmaIFbZmGA5E-2g>
 <xmx:G6F8aoKDseV7_pyfZWN74MMS7NMQH4jdimpNOKQvh5kvlSsm1BsHGw>
 <xmx:G6F8aiMq4ZKjq3nWrvcNG0KnkBvKD4q-xHUsNd55rDDh-qDiBRFTbA>
 <xmx:G6F8aom-2Hu4sXL4eaal4XMriTCJy3xd9riyVq-RUkhVqsJRcXbk0A>
 <xmx:HKF8arWmuZ0RD9SJEbYsNKIlybOi30KL1ggjh381hQ5OEdxbkjqwRPUo>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:36:43 -0400 (EDT)
Message-ID: <9e606a9e83adafb2f58ea2c5386f7fb6d5fbf6c1.camel@alistair23.me>
Subject: Re: [RFC PATCH v1 00/17] target/riscv: Add KVM CoVE confidential VM
 support
From: Alistair <alistair@alistair23.me>
To: Baolong Duan <blduan@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com, 
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com
Date: Thu, 13 Aug 2026 02:36:43 +1000
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.146;
 envelope-from=alistair@alistair23.me; helo=fout-a3-smtp.messagingengine.com
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

On Fri, 2026-07-31 at 11:49 +0800, Baolong Duan wrote:
> This series adds RISC-V CoVE (Confidential VM Extension) support to
> the
> virt machine when running with KVM acceleration.
>=20
> CoVE is the RISC-V equivalent of AMD SEV / Intel TDX, defined by the
> RISC-V AP-TEE specification [1].=C2=A0 A CoVE guest is a TEE VM (TVM)

Cool!

> whose
> memory and vCPU state are owned by the TEE Security Manager (TSM),
> making them inaccessible to the host.
>=20
> The series adds a "cove-vm" machine property to the virt board and
> adapts
> the boot flow, interrupt routing, memory registration and device
> model to
> the constraints of a confidential guest:

Awesome! I'm excited to see RISC-V CC coming along.

Thanks for the RFC. When it comes time to send patches make sure you
check against
https://wiki.qemu.org/Documentation/Platforms/RISCV#RISC-V_Foundation_Exten=
sions.

Notably:
 - You need to be clear about which exact spec release you are using
 - You will need to add tests
 - The support needs to be experimental for a draft spec
 - You will need to link to kernel patches to support CoVE

>=20
> =C2=A0 - kernel, initrd and device tree are measured before the guest
> starts
> =C2=A0 - interrupts are MSI-only (IMSIC mandatory, APLIC emulated by QEMU=
)
> =C2=A0 - virtio uses modern PCI transport with VIRTIO_F_ACCESS_PLATFORM
> =C2=A0 - vhost is disabled (host kernel has no access to guest memory)
> =C2=A0 - vCPU threads are pinned (TSM binds vCPUs to harts)

What firmware are you using? OpenSBI? You must need a fair few changes
for this to work right?

>=20
> The KVM interface used here (KVM_VM_TYPE_RISCV_COVE and
> KVM_RISCV_COVE_MEASURE_REGION) is not yet part of an upstream Linux
> release.=C2=A0 The definitions are kept locally and will be replaced by a
> linux-headers update once the kernel side has been merged.
>=20
> Patches 15 and 17 contain known workarounds and explicitly ask for
> design
> guidance:
>=20
> =C2=A0 - Patch 15 pins vCPU threads and adds a yield after KVM_RUN to
> avoid
> =C2=A0=C2=A0=C2=A0 host RCU stalls.=C2=A0 Thread placement should be left=
 to the user or
> =C2=A0=C2=A0=C2=A0 management layer.
>=20
> =C2=A0 - Patch 17 converts system_reset into a shutdown because a TVM
> cannot be
> =C2=A0=C2=A0=C2=A0 recreated.=C2=A0 The proper approach may be to impleme=
nt
> =C2=A0=C2=A0=C2=A0 ConfidentialGuestSupport and use the existing can_rebu=
ild_state()
> =C2=A0=C2=A0=C2=A0 machinery.
>=20
> Tested with QEMU TCG emulating a CoVE-capable Xuantie C930 platform.

Are we able to access and test this setup?

>=20
> [1] https://github.com/riscv-non-isa/riscv-ap-tee
>=20
> Baolong Duan (17):
> =C2=A0 docs/system/riscv/virt: document the cove-vm machine option

Add the docs after adding the feature

> =C2=A0 hw/riscv/virt: add the cove-vm machine property

This is in the wrong order. We want to add the feature then expose it
to users, not the other way around.

Alistair

> =C2=A0 target/riscv/kvm: create and measure a CoVE TEE VM
> =C2=A0 accel/kvm: add kvm_gpa_to_userspace_addr()
> =C2=A0 hw/riscv/boot: load and measure the images of a CoVE guest
> =C2=A0 hw/riscv/virt: measure the device tree of a CoVE guest
> =C2=A0 hw/riscv: adapt the device tree of a CoVE guest
> =C2=A0 hw/riscv/virt: use MSIs only for a CoVE guest
> =C2=A0 hw/intc/riscv_aplic: emulate the APLIC for a CoVE guest
> =C2=A0 target/riscv/kvm: skip unsupported KVM requests for a CoVE guest
> =C2=A0 hw/virtio: force modern virtio for a CoVE guest
> =C2=A0 hw/net/virtio-net: do not use vhost for a CoVE guest
> =C2=A0 accel/kvm: only register the DRAM slot of a CoVE guest
> =C2=A0 accel/kvm: skip MSI route updates for a CoVE guest
> =C2=A0 accel/kvm: pin the vCPU threads of a CoVE guest
> =C2=A0 accel/kvm: terminate on a system event of a CoVE guest
> =C2=A0 hw/core/machine-qmp-cmds: shut down a CoVE guest on reset
>=20
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 ++
> =C2=A0accel/kvm/kvm-accel-ops.c=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +++++
> =C2=A0accel/kvm/kvm-all.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 60 +++++++++++++++++
> =C2=A0docs/system/riscv/virt.rst=C2=A0=C2=A0 |=C2=A0 39 +++++++++++
> =C2=A0hw/core/machine-qmp-cmds.c=C2=A0=C2=A0 |=C2=A0 10 +++
> =C2=A0hw/core/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +++++
> =C2=A0hw/intc/riscv_aplic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 9 +++
> =C2=A0hw/net/virtio-net.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 9 +++
> =C2=A0hw/riscv/boot.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 91 +++++++++++++++++++++++++
> =C2=A0hw/riscv/fdt-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 +-
> =C2=A0hw/riscv/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 ++
> =C2=A0hw/riscv/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 125 +++++++++++++++++++++++++++++----
> --
> =C2=A0hw/virtio/virtio-bus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
12 ++++
> =C2=A0hw/virtio/virtio-pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 9 ++-
> =C2=A0include/hw/riscv/cove.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 24 ++=
+++++
> =C2=A0include/hw/riscv/virt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 1 +
> =C2=A0include/system/kvm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 18 +++++
> =C2=A0target/riscv/kvm/kvm-cpu.c=C2=A0=C2=A0 |=C2=A0 67 +++++++++++++++++=
+-
> =C2=A0target/riscv/kvm/kvm_riscv.h |=C2=A0 10 +++
> =C2=A019 files changed, 508 insertions(+), 24 deletions(-)
> =C2=A0create mode 100644 include/hw/riscv/cove.h

