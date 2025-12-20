Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF7CD78797
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 12:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWwSq-000542-M3; Sat, 20 Dec 2025 07:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajaygargnsit@gmail.com>)
 id 1vWwSI-00053L-HD
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 07:53:08 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajaygargnsit@gmail.com>)
 id 1vWwSG-0003mE-N3
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 07:53:06 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-37b935df7bfso21639831fa.2
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766235182; x=1766839982; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2D/o029XJg6GKOLuV3uuch4kHBbvpaS8vrJbhVBDdVw=;
 b=WuV4rwhtCeUi5Mr+pmYz8ZXJlRTQ9Y5vrk7vDpGkZTXHwnMBuPh8Njiw0LwwzC7Ucl
 lXhKHXRgBdF2K6K+fv71iRE3qU+QNoHji5URzHPt0pNQtLaxUPU4cIn2b2f0OHU5TC+s
 2rrsNH6CgR02H3EF6ls6h+3Rzdb0glnZGfF+tZSCe5TKEEThs/AT4vZsgQbEDpwvVYqG
 Wq1DHeWPRdQYTR7V3h0xq/mCHxzHrlfnXWaMVSCcjilMg3mhvSd+undaA+i78TNDXJT5
 b0PxCenW2rg17PC84lpJNUuNF1MewpIILeyWFBypvJB5a6MgRebOX/RiwIPkfbTBXgQs
 wb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766235182; x=1766839982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2D/o029XJg6GKOLuV3uuch4kHBbvpaS8vrJbhVBDdVw=;
 b=dKKFAtmW6JTeefSUhtuotgAwp4SHSQ7cFNdAmNs0rdI3Kt6qIajQCaMX/k2DWYOg9+
 V1DNg2NOsk20PGeqE+0XjuOyJY2K7DWdhwV/TwA/0MTH9WlAEayVxy3uVG379hx+fJhD
 pU2WesUQyX8aCgNGy605gP6VBP3e121NSCL8bFUgj59akYcu/NpxapQnCcI5yaViN8q6
 K/GPModMd4w4lE8Lp8c6EBvccoBUkKdRMrth/Rki2YtIkYCd25nkVdTSBWhLriZb50kG
 ZnyILvgOjS08bKt74yXoNxc5y/aPISjFSEpHW46MRRmv55V+wImhg+NjJ0wmOZVy4OPB
 vEcg==
X-Gm-Message-State: AOJu0YxkBNKIKK/m2sjE2rIWLYaGcaiOc/fqnLfJb8qhM2vixWVOAPvA
 ntkANPT0GVJE3pvbRcTXiuA3o+KiNJys/1nZ73rLc7jNfvjQ7cu8WaunpQFYWRByZxVo4R1KHYi
 vfAUeObp/odUYbWTBiIdi2i1XFASXTg4=
X-Gm-Gg: AY/fxX5W316C3w3OVPUqKu+M+AbsQZP1GUGlYTNxZTvI1h7ID2XpNSN8OsQdX/l/9Po
 YVxGd2AAxOEjtG793jU71+HkMF23tKaGtrZBGrfNXDdDrJFo7ukaboJpEInFQKFGo7lBmNajYPH
 XJnmJnjkVBvoyFRC3x0lD5jEyUB5xVCFSa4qpEWaiYy1Sumh6iM+Z0FD+qZUWcXFAOKIK9xYjEV
 jEBO8AlyhULX+PTjcvSqlrrpTokd95IA8CVOFgN2HBK99TNFK/8iTjt9AnGf0YGt01Nbzh2
X-Google-Smtp-Source: AGHT+IHCxcL5gYfOSHzRRx8CVPImqoJt0QOor+vzDuvuPFXZ4Onm/sAyjrKEFkur+UpJml+SCx7vg2DUaaGHDsxBm5w=
X-Received: by 2002:a2e:be84:0:b0:37f:b6bc:e792 with SMTP id
 38308e7fff4ca-3812156a2b6mr21545441fa.7.1766235181716; Sat, 20 Dec 2025
 04:53:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
 <20251215045203.13d96d09.alex@shazbot.org>
 <CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
 <CAHP4M8X=e+dP-T_if5eA=gccdbxkkObYvcrwA3qUBONKWW3W_w@mail.gmail.com>
 <20251219170637.2c161b7b.alex@shazbot.org>
In-Reply-To: <20251219170637.2c161b7b.alex@shazbot.org>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Sat, 20 Dec 2025 18:22:49 +0530
X-Gm-Features: AQt7F2r-v-5pLlad59UuVktFvgC2k1L0bWuBPbaBXXchxJQseBIZnmHXFKcS8dw
Message-ID: <CAHP4M8Ud_tm+SPmZtnSi1--zf=MTsbvSqDYdAfPdAXUj+Ormkg@mail.gmail.com>
Subject: Re: A lingering doubt on PCI-MMIO region of PCI-passthrough-device
To: Alex Williamson <alex@shazbot.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, iommu@lists.linux-foundation.org, 
 linux-pci@vger.kernel.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=ajaygargnsit@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Thanks Alex.

I was/am aware of GPA-ranges backed by mmap'ed HVA-ranges.
On further thought, I think I have all the missing pieces (except one,
as mentioned at last in current email).

I'll list the steps below :

a)
There are three stages :

   * pre-configuration by host/qemu.
   * guest-vm bios.
   * guest-vm kernel.

b)
Host procures following memory-slots (amongst others) via mmap :

  * guest-ram
  * pci-config-space       : via vfio's ioctls' help.
  * pci-bar-mmio-space : via vfio's ioctls' help.

For the above memory-slots,

*
guest-ram physical-address is known (0), so ept-mappings for guest-ram
are set up even before guest-vm begins to boot up.

*
there is no concept of guest-physical-address for pci-config-space.

*
pci-bar-mmio-space physical address is not known yet, so ept-mappings
for pci-bar-mmio-space are not set up (yet).

c)
qemu starts the guest, and guest-vm-bios runs next.

This bios is "owned by qemu", and is "definitely different" from the
host-bios (qemu is an altogether different "hardware"). qemu-bios and
host-bios handle pci bus/enumeration "completely differently".

When the pci-enumeration runs during this guest-vm-bios stage, it
accesses the pci-device config-space (backed on the host by mmap'ed
mappings). Note that guest-kernel is still not in picture.

"OBVIOUSLY", all accesses (reads/writes) to pci-config space go to the
pci-config-space memory-slot (handled purely by qemu-bios code).

Once the guest-vm bios carves out guest-physical-addresses for the
pci-device-bars, it programs the bars by writing to bars-offsets in
the pci-config-space. qemu detects this, and does the following :

   * does not relay the actual-writes to physical bars on the host.
   * since the bar-guest-physical-addresses are now known, so now the
missing ept-mappings
     for pci-bar-mmio-space are now set up.

d)
Finally, guest-kernel takes over, and

   * all accesses to ram go through vanilla two-stages translation.
   * all accesses to pci-bars-mmio go through vanilla two-stages translatio=
n.


Requests :

i)
Alex / QEMU-experts : kindly correct me if I am wrong :) till now.

ii)
Once kernel boots up, how are accesses to pci-config-space handled? Is
again qemu-bios involved in pci-config-space accesses after
guest-kernel has booted up?


Once again, many thanks to everyone for their time and help.

Thanks and Regards,
Ajay


On Sat, Dec 20, 2025 at 5:36=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Fri, 19 Dec 2025 11:53:56 +0530
> Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> > Hi Alex.
> > Kindly help if the steps listed in the previous email are correct.
> >
> > (Have added qemu mailing-list too, as it might be a qemu thing too as
> > virtual-pci is in picture).
> >
> > On Mon, Dec 15, 2025 at 9:20=E2=80=AFAM Ajay Garg <ajaygargnsit@gmail.c=
om> wrote:
> > >
> > > Thanks Alex.
> > >
> > > So does something like the following happen :
> > >
> > > i)
> > > During bootup, guest starts pci-enumeration as usual.
> > >
> > > ii)
> > > Upon discovering the "passthrough-device", guest carves the physical
> > > MMIO regions (as usual) in the guest's physical-address-space, and
> > > starts-to/attempts to program the BARs with the
> > > guest-physical-base-addresses carved out.
> > >
> > > iii)
> > > These attempts to program the BARs (lying in the
> > > "passthrough-device"'s config-space), are intercepted by the
> > > hypervisor instead (causing a VM-exit in the interim).
> > >
> > > iv)
> > > The hypervisor uses the above info to update the EPT, to ensure GPA =
=3D>
> > > HPA conversions go fine when the guest tries to access the PCI-MMIO
> > > regions later (once gurst is fully booted up). Also, the hypervisor
> > > marks the operation as success (without "really" re-programming the
> > > BARs).
> > >
> > > v)
> > > The VM-entry is called, and the guest resumes with the "impression"
> > > that the BARs have been "programmed by guest".
> > >
> > > Is the above sequencing correct at a bird's view level?
>
> It's not far off.  The key is simply that we can create a host virtual
> mapping to the device BARs, ie. an mmap.  The guest enumerates emulated
> BARs, they're only used for sizing and locating the BARs in the guest
> physical address space.  When the guest BAR is programmed and memory
> enabled, the address space in QEMU is populated at the BAR indicated
> GPA using the mmap backing.  KVM memory slots are used to fill the
> mappings in the vCPU.  The same BAR mmap is also used to provide DMA
> mapping of the BAR through the IOMMU in the legacy type1 IOMMU backend
> case.  Barring a vIOMMU, the IOMMU IOVA space is the guest physical
> address space.  Thanks,
>
> Alex

