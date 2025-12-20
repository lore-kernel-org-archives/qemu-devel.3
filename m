Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAE5D78797
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 13:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWwxW-0003p9-R0; Sat, 20 Dec 2025 08:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajaygargnsit@gmail.com>)
 id 1vWwxP-0003o4-1Q
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 08:25:15 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajaygargnsit@gmail.com>)
 id 1vWwxL-0001NY-0h
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 08:25:14 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-37bbb36c990so31043851fa.0
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 05:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766237109; x=1766841909; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3b0M4fusp4M8TwC+3lvPsPvDRWyNz+WF92fODAY27og=;
 b=dJTBpr5AI/71fHoSQoV5F2968Xc/wtryEdJqmO1Vt4rUy9u5CJTYqugd6c3bnZdFW/
 8eTomm5HcHNp7j5FtZJZ2TzcFGQGDBTaS040imGoaFvvZJu1Pyf4B0SNSOHWiEiOFyeM
 EVjFvlO5mIYHgeUu6CsTXj2fQdGmucmurjAnUNCnisjpL7Y80kvGBI/dzYAWh48OXLmQ
 oRfr6J9qBWnm9MeOAYzbru++8R+Dv4TJTkEgsqg+yT9QCBjL/2XY0fBdjyq22LE8Rdvb
 b0/Z/eYUD3tL1KH9F3nD6qp69FvqjCA7bv2oSRso959aJYOjuFQAiRNPBlO2ahfC/yDU
 8FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766237109; x=1766841909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3b0M4fusp4M8TwC+3lvPsPvDRWyNz+WF92fODAY27og=;
 b=Z2MyJrJhx9Xo6YFHnyigbIZDsnNRHESo+Yk2sx9dqOon6wdUAdJ24KM/gULNbmBVxO
 Kfi4UuNuGRydTb1t3WNRrrA1v4dQXKEv2+VCleTj1n7AnzmIY0h0nl+/WWmdLfKOWxY4
 c85/A0KLH4gw/UDvYviJQHZ4MCWzaMbKzlKRUlA4BZj+HR9UWyj1iHOaeMPIpNb12Odc
 oPqtSw/lpFV71X9eatPMWsNlbB8cDMHP4SMYWB57Hz2peqdkbcjBSnUvDMcxsljMTJy9
 3zwtlHkOnPjo2C1J4LTbbOnEiQoHmunKOM78p1s8DtFo/8e3ULa9pGNlT85qyn5FlyDM
 kLTw==
X-Gm-Message-State: AOJu0YwrGxmA44AjP3oqkNZWBUndP5JidcN0m8fWWf6UNpgEl10pLE4E
 huM9UWMsU8LV6bj5IT/UHIBay9/xu2uiO2SMmt6IQA5+O305Y50BX8DqstrI8QRm+8Mz7tM2hEK
 f1Sl8sqRck5XrpT/3TmYHuAd5nuIDtd8=
X-Gm-Gg: AY/fxX4RAvjpH6N5Np/0d2bb+/Xp4Xqt0nXnYnjxS6D6RUvLvUpnAW3OG6z/R1/K9Pa
 VAOKInTSvamW/Lvvj7/nS6K+eLfDlhTfXTq6mxNJGG5u6Z8n1jq6OdQE1de9VKJTVokm8pmgV+e
 cY9HIvop3CyfYHUYems/WrrNQnUIrh+Kpu5Czn771V6ecyjwTIgYCfSQqax1RIvPuP8BGFKWTsY
 mDiqto9Nkty7yVZDdAZTy+lQuk6PSzfFhibR8GVwDmYYZqTMYhgjNHm6QUKfuAjPFDJzle5zOuz
 DTpTFcs=
X-Google-Smtp-Source: AGHT+IGPcvp6fW/TUruAB977dCAs0N1AZzF3yRbKDGcbSmIfEy45oEg5nlHbJP3YYyMlqgMPqEvRU6R52LtRcG3Csv4=
X-Received: by 2002:a05:651c:1542:b0:37e:6dd5:2e3b with SMTP id
 38308e7fff4ca-381207761eamr22258141fa.5.1766237108703; Sat, 20 Dec 2025
 05:25:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
 <20251215045203.13d96d09.alex@shazbot.org>
 <CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
 <CAHP4M8X=e+dP-T_if5eA=gccdbxkkObYvcrwA3qUBONKWW3W_w@mail.gmail.com>
 <20251219170637.2c161b7b.alex@shazbot.org>
 <CAHP4M8Ud_tm+SPmZtnSi1--zf=MTsbvSqDYdAfPdAXUj+Ormkg@mail.gmail.com>
In-Reply-To: <CAHP4M8Ud_tm+SPmZtnSi1--zf=MTsbvSqDYdAfPdAXUj+Ormkg@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Sat, 20 Dec 2025 18:54:56 +0530
X-Gm-Features: AQt7F2ozfyOfOGjyPn74d-8hfCl7Xro1Z8pjLNJPv5fWJeElxisiOGYPXqkXKTY
Message-ID: <CAHP4M8WZULK3t8-hTSB7ANsUohyBD1tLqdPE+FgeR2h6-yfsww@mail.gmail.com>
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

Is guest-acpi-mcfg/mmconfig tables the answer to my last question? :)

i.e. qemu-bios setting up acpi mcfg / mmconfig addresses, which are
backed by mmap'ed pci-config-space mappings on the host (while also
setting up ept-mappings for pci-config-space too)?


On Sat, Dec 20, 2025 at 6:22=E2=80=AFPM Ajay Garg <ajaygargnsit@gmail.com> =
wrote:
>
> Thanks Alex.
>
> I was/am aware of GPA-ranges backed by mmap'ed HVA-ranges.
> On further thought, I think I have all the missing pieces (except one,
> as mentioned at last in current email).
>
> I'll list the steps below :
>
> a)
> There are three stages :
>
>    * pre-configuration by host/qemu.
>    * guest-vm bios.
>    * guest-vm kernel.
>
> b)
> Host procures following memory-slots (amongst others) via mmap :
>
>   * guest-ram
>   * pci-config-space       : via vfio's ioctls' help.
>   * pci-bar-mmio-space : via vfio's ioctls' help.
>
> For the above memory-slots,
>
> *
> guest-ram physical-address is known (0), so ept-mappings for guest-ram
> are set up even before guest-vm begins to boot up.
>
> *
> there is no concept of guest-physical-address for pci-config-space.
>
> *
> pci-bar-mmio-space physical address is not known yet, so ept-mappings
> for pci-bar-mmio-space are not set up (yet).
>
> c)
> qemu starts the guest, and guest-vm-bios runs next.
>
> This bios is "owned by qemu", and is "definitely different" from the
> host-bios (qemu is an altogether different "hardware"). qemu-bios and
> host-bios handle pci bus/enumeration "completely differently".
>
> When the pci-enumeration runs during this guest-vm-bios stage, it
> accesses the pci-device config-space (backed on the host by mmap'ed
> mappings). Note that guest-kernel is still not in picture.
>
> "OBVIOUSLY", all accesses (reads/writes) to pci-config space go to the
> pci-config-space memory-slot (handled purely by qemu-bios code).
>
> Once the guest-vm bios carves out guest-physical-addresses for the
> pci-device-bars, it programs the bars by writing to bars-offsets in
> the pci-config-space. qemu detects this, and does the following :
>
>    * does not relay the actual-writes to physical bars on the host.
>    * since the bar-guest-physical-addresses are now known, so now the
> missing ept-mappings
>      for pci-bar-mmio-space are now set up.
>
> d)
> Finally, guest-kernel takes over, and
>
>    * all accesses to ram go through vanilla two-stages translation.
>    * all accesses to pci-bars-mmio go through vanilla two-stages translat=
ion.
>
>
> Requests :
>
> i)
> Alex / QEMU-experts : kindly correct me if I am wrong :) till now.
>
> ii)
> Once kernel boots up, how are accesses to pci-config-space handled? Is
> again qemu-bios involved in pci-config-space accesses after
> guest-kernel has booted up?
>
>
> Once again, many thanks to everyone for their time and help.
>
> Thanks and Regards,
> Ajay
>
>
> On Sat, Dec 20, 2025 at 5:36=E2=80=AFAM Alex Williamson <alex@shazbot.org=
> wrote:
> >
> > On Fri, 19 Dec 2025 11:53:56 +0530
> > Ajay Garg <ajaygargnsit@gmail.com> wrote:
> >
> > > Hi Alex.
> > > Kindly help if the steps listed in the previous email are correct.
> > >
> > > (Have added qemu mailing-list too, as it might be a qemu thing too as
> > > virtual-pci is in picture).
> > >
> > > On Mon, Dec 15, 2025 at 9:20=E2=80=AFAM Ajay Garg <ajaygargnsit@gmail=
.com> wrote:
> > > >
> > > > Thanks Alex.
> > > >
> > > > So does something like the following happen :
> > > >
> > > > i)
> > > > During bootup, guest starts pci-enumeration as usual.
> > > >
> > > > ii)
> > > > Upon discovering the "passthrough-device", guest carves the physica=
l
> > > > MMIO regions (as usual) in the guest's physical-address-space, and
> > > > starts-to/attempts to program the BARs with the
> > > > guest-physical-base-addresses carved out.
> > > >
> > > > iii)
> > > > These attempts to program the BARs (lying in the
> > > > "passthrough-device"'s config-space), are intercepted by the
> > > > hypervisor instead (causing a VM-exit in the interim).
> > > >
> > > > iv)
> > > > The hypervisor uses the above info to update the EPT, to ensure GPA=
 =3D>
> > > > HPA conversions go fine when the guest tries to access the PCI-MMIO
> > > > regions later (once gurst is fully booted up). Also, the hypervisor
> > > > marks the operation as success (without "really" re-programming the
> > > > BARs).
> > > >
> > > > v)
> > > > The VM-entry is called, and the guest resumes with the "impression"
> > > > that the BARs have been "programmed by guest".
> > > >
> > > > Is the above sequencing correct at a bird's view level?
> >
> > It's not far off.  The key is simply that we can create a host virtual
> > mapping to the device BARs, ie. an mmap.  The guest enumerates emulated
> > BARs, they're only used for sizing and locating the BARs in the guest
> > physical address space.  When the guest BAR is programmed and memory
> > enabled, the address space in QEMU is populated at the BAR indicated
> > GPA using the mmap backing.  KVM memory slots are used to fill the
> > mappings in the vCPU.  The same BAR mmap is also used to provide DMA
> > mapping of the BAR through the IOMMU in the legacy type1 IOMMU backend
> > case.  Barring a vIOMMU, the IOMMU IOVA space is the guest physical
> > address space.  Thanks,
> >
> > Alex

