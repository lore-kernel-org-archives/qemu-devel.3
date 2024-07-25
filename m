Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B848C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 03:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWpMq-0004Zd-EB; Wed, 24 Jul 2024 23:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sWpMo-0004Y4-Gv; Wed, 24 Jul 2024 23:42:10 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sWpMm-0005Na-MM; Wed, 24 Jul 2024 23:42:10 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-81f91171316so833047241.0; 
 Wed, 24 Jul 2024 20:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721878924; x=1722483724; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POTSvW4GB0oP/asXqx/ZLllbqkVmfufVLTDOC7y4eJM=;
 b=ZrMpBizJ9jqyd40eU20yHrzcdCNaVYLk1xBXpOh0ZE+LqaQKO5UCRZe5pERxUGuJT4
 r5+65cTeBV+hgzIMVcbzvGnoPMmFEoxLi0fjkO71+hX1dOMmUGRovSnK13QPl5QBnxCE
 +wkplg8cjf9tmd71bBWAL0L+MUhYywaamZvJr7/cfsUMWfDQf4aixNL1F+Mq56GqlJTd
 KG6I5A6VssqteUbWhp0In1tx+hfUFNFmFFqKnPbpoU/dKmX3oIndMj3ou508KScLxD1j
 loTzp+w3Bu6hR1ori8/IYr0e6JIXB3qDuP6vtY8lIlHGhEMuU6YE9rAze0YDAIrg605R
 X+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721878924; x=1722483724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=POTSvW4GB0oP/asXqx/ZLllbqkVmfufVLTDOC7y4eJM=;
 b=OVwNQjIDJTT8hCJZSA8zqd34UrT14w0/b5XmC0pizHbI8X3z9npnClBVnVVhxchlvk
 TZL/lq3qZIsKJiDuF75dIAnDZtWLfhcfQ0olBB/O3UjZGP9SMgvSo7YtS7HGeZ7Vlfvz
 In/jHYik9nrHCDgmTGLSB2cbc69ooT/8rUAfhAUDCex72FwlgHpRDlnOIaHRL1rnDq8d
 1ywF3Q+VNDF3Ac4B9e6r6DPz+2kSQJ3PhMB7sFC4feS23LMYbymBiKub5sr1e5V6cjRK
 eFrD1UtFmG4XBTdf0DeIHybzNTuuGeN+Y14rDacygCTgfKAvly8rwqHDPOl2SexN4OUG
 upAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu+FxmCH4sJTRdgwNYZZpULC4/YC+VwClAkk2TuzL2z68xoIlwzCFABBJJ1v2Rr+/grfpefQskQq7AHv3Jb94DXHxq1/s=
X-Gm-Message-State: AOJu0YwTJZuDqo6ZW5BGtxPy7rAPF/Yj82hXUtSBHX00JlUpBPDVrmt2
 qkOXcEdMZj51y/jatULOwJ5M/wrzN6PEVYMSV64LGl2xn20i1xE+MDn0ejNTknvryXm1r02xzIp
 gjmc9/PsGCKw44+sZljOk5NcrQjw=
X-Google-Smtp-Source: AGHT+IGZZm/l8CXY82JCSXncRoN8V+jFzOvkfI2HO9nBqJAAIR4Ult959DejUbcxtEgisHxzvLeQDdi3aRTT0jebHBI=
X-Received: by 2002:a05:6102:2b91:b0:492:98bf:75ef with SMTP id
 ada2fe7eead31-493d63bbd50mr1578395137.8.1721878924564; Wed, 24 Jul 2024
 20:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
 <20240708173501.426225-14-dbarboza@ventanamicro.com>
 <CAKmqyKOA8VHg=BDBfhZcf0eU=3ts0=PoLEdzdd0rhNOz000=Xg@mail.gmail.com>
 <ff35d3bb-b4d3-4a28-848c-1bd6668c35ec@ventanamicro.com>
In-Reply-To: <ff35d3bb-b4d3-4a28-848c-1bd6668c35ec@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jul 2024 13:41:38 +1000
Message-ID: <CAKmqyKNyYoV+Ny6N06cmDA3pVhbN=5x5DO9Cm93Zq+0N8onCZQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] docs/specs: add riscv-iommu
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, frank.chang@sifive.com, tjeznach@rivosinc.com, 
 jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Wed, Jul 24, 2024 at 10:56=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 7/19/24 6:34 AM, Alistair Francis wrote:
> > On Tue, Jul 9, 2024 at 3:37=E2=80=AFAM Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> >>
> >> Add a simple guideline to use the existing RISC-V IOMMU support we jus=
t
> >> added.
> >>
> >> This doc will be updated once we add the riscv-iommu-sys device.
> >>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> ---
> >>   docs/specs/index.rst       |  1 +
> >>   docs/specs/riscv-iommu.rst | 55 ++++++++++++++++++++++++++++++++++++=
++
> >>   docs/system/riscv/virt.rst | 13 +++++++++
> >>   3 files changed, 69 insertions(+)
> >>   create mode 100644 docs/specs/riscv-iommu.rst
> >>
> >> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> >> index 1484e3e760..c68cd9ae6c 100644
> >> --- a/docs/specs/index.rst
> >> +++ b/docs/specs/index.rst
> >> @@ -33,3 +33,4 @@ guest hardware that is specific to QEMU.
> >>      virt-ctlr
> >>      vmcoreinfo
> >>      vmgenid
> >> +   riscv-iommu
> >> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> >> new file mode 100644
> >> index 0000000000..fa38ff7667
> >> --- /dev/null
> >> +++ b/docs/specs/riscv-iommu.rst
> >> @@ -0,0 +1,55 @@
> >> +.. _riscv-iommu:
> >> +
> >> +RISC-V IOMMU support for RISC-V machines
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU sp=
ec
> >> +version 1.0 [1].
> >> +
> >> +The emulation includes a PCI reference device, riscv-iommu-pci, that =
QEMU
> >> +RISC-V boards can use.  The 'virt' RISC-V machine is compatible with =
this
> >> +device.
> >> +
> >> +A platform device that implements the RISC-V IOMMU will be added in t=
he
> >> +future.
> >> +
> >> +
> >> +riscv-iommu-pci reference device
> >> +--------------------------------
> >> +
> >> +This device implements the RISC-V IOMMU emulation as recommended by t=
he section
> >> +"Integrating an IOMMU as a PCIe device" of [1]: a PCI device with bas=
e class 08h,
> >> +sub-class 06h and programming interface 00h.
> >> +
> >> +As a reference device it doesn't implement anything outside of the sp=
ecification,
> >> +so it uses a generic default PCI ID given by QEMU: 1b36:0014.
> >> +
> >> +To include the device in the 'virt' machine:
> >> +
> >> +.. code-block:: bash
> >> +
> >> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
> >
> > We should add a sentence saying what this does. As in what should a
> > user expect after they have done this
>
> I suppose we can add a boilerplate sentence about what an IOMMU does, but=
 aside
> from that I'm not sure what to say about user expectation. If you're addi=
ng an
> IOMMU (or any device in QEMU) it's expected that the user has some idea o=
f what
> the device is supposed to do in the board and so on hehe

That's fair and I don't think we need to describe what an IOMMU does,
I more meant the fact it's attached via PCI.

We specifically say a "platform device will be added later" so I think
we should just be clear on what a PCI IOMMU is

Alistair

