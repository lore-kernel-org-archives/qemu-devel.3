Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEE5C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 13:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD29F-0004jI-Tc; Fri, 31 May 2024 09:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sD29E-0004iq-K2
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:18:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sD29C-0000e8-PK
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:18:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so18279125ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717161497; x=1717766297; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RRbOq4KpbT+DnehSKJ61qjKdLRLWoT1dRUVpHSlMKQI=;
 b=GIpG6i4iL9pWIsXvwyaiJ82mYvOso4/r5Lx2+mahHrEBInAOrwgZ6toJBbM2IjnNzZ
 fxt79u1KKT7KY4/78/RgZ2StGGcKCsNh79jf8oFhsImTJKM9sVRUmX6OdvMkJ72KiR9y
 K5tlDSDLTab6R+GO8irtRtezj/3PIfyW4imOTWjBoC5Zi8FSe5Ujkz1MLaRYSOeAVaMJ
 at5h/u8Fi5dBpjbJrBxU6kT3gbbY3WHUJLrja8deNY1Yle7IyxsLtPRdu6MyflFTy+2d
 y4ld/+iq5Z06u1jvtK5wlO1ePQivg+3XSdWadlATiyUwukIasSnoq74UwWbioOCeVA7t
 SBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717161497; x=1717766297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRbOq4KpbT+DnehSKJ61qjKdLRLWoT1dRUVpHSlMKQI=;
 b=g62NsELyI0l7TAXNSH3T9tM2ql0566CmAcXWJqQXNGW5LCPBa7YWpVaGk5/UyHbIBH
 eLXePZHcPKjHaQFed3685fNCZ9G41aFJG3ohNuiOUNEYCKQERsZYM1MY+9IsfqyfvdQP
 f6nAIztT0pqe8T3cn5auHImmeP9ArCGocCijjj4B7jnWNsaFK0wYsaK2BZATVuASaD5N
 W3J5mMW6O6X4joBoY6uanRBds0e92Szh+nvfLaNbl1kva5PxF0P1zcOPIlyh9QLlsTvY
 /lhm5ymVTNmLk/r6kuWpkyygxgi56XztCP5AK2yI2q/IIsELInsLC85otfgCOogwqZzv
 mF6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVskoQAE2Nzwma/hzfjEEbzzkszAfAL1zKOPLPQ8Rz1hAJZ5Eh2NHWYxhM4uYUFesEbY/DlTQOlmf81W9NqLG4iTHoXiVo=
X-Gm-Message-State: AOJu0YyB+QlEiUXNnnKLJGpdVq/qCtQHwy9AhJjXUzLpG0fg9hX4FpVK
 Xz7s7qjvIoN2HuoVAzso41kMyPbBzZO4L4BaJtwlN9T/XOOwcyxRDA9V1jK8aWo=
X-Google-Smtp-Source: AGHT+IGCD3DFFjsCMKVdr2qtZctoWnLAltve+X4lmQVPcbxeflcEJiKtpTcNhsAnH7oipaqSH2oCXw==
X-Received: by 2002:a17:902:e84a:b0:1f4:960c:a05a with SMTP id
 d9443c01a7336-1f6370cea67mr15796015ad.48.1717161496628; 
 Fri, 31 May 2024 06:18:16 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63237d9c3sm16255135ad.116.2024.05.31.06.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 06:18:16 -0700 (PDT)
Date: Fri, 31 May 2024 18:48:06 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 0/3] hw/riscv/virt: pflash improvements
Message-ID: <ZlnODgN5wbKgqY9F@sunil-laptop>
References: <20230525164803.17992-1-sunilvl@ventanamicro.com>
 <CABJz62MFZzx3jBgW6TtGFD9emY+DAbbftSybD8ZouC65n3-auA@mail.gmail.com>
 <20230526-b0d8b56e9688dea7ae9d00d5@orel>
 <CABJz62Nk-U+qHQjn6G2-bN8i9RcMEZWdYTyi7wqC=7BVjDSBWQ@mail.gmail.com>
 <20230526-e398cfda73f326653323ea68@orel>
 <CABJz62PXvVNEwpqUz0dUUYTAGjmNU4h0NtFf664oubaJmKxwKw@mail.gmail.com>
 <20230526-cbbe3fe3734dc64264a2ad83@orel>
 <CABJz62N3tBpCtLmQmnYzLHnUNRZcxOxn2iLzPu=V3THVpp698g@mail.gmail.com>
 <ZVtu44sFAQeWxGjO@sunil-laptop>
 <CABJz62PXn7g+Qa5kUsrYYAO3_pqVHwpk0z2DLpgq2pspBA4biQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJz62PXn7g+Qa5kUsrYYAO3_pqVHwpk0z2DLpgq2pspBA4biQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 30, 2024 at 04:37:56AM -0700, Andrea Bolognani wrote:
> On Mon, Nov 20, 2023 at 08:06:19PM GMT, Sunil V L wrote:
> > On Mon, Nov 20, 2023 at 02:29:28PM +0000, Andrea Bolognani wrote:
> > > On Fri, May 26, 2023 at 11:10:12AM +0200, Andrew Jones wrote:
> > > > > > > So, are edk2 users the only ones who would (temporarily) need to
> > > > > > > manually turn ACPI off if virt-manager started enabling it by
> > > > > > > default?
> > > > > >
> > > > > > I assume so, but I'm not tracking firmware status. If the firmware
> > > > > > doesn't extract the ACPI tables from QEMU and present them to the
> > > > > > guest (afaik only edk2 does that), then the guest kernel falls back
> > > > > > to DT, which is why it's working for you.
> > > > > >
> > > > > > I suppose we should wait until Linux merges the ACPI patches, before
> > > > > > adding RISC-V to the libvirt capabilities ACPI list.
> > > > >
> > > > > That sounds reasonable to me, but note that 1) the libvirt change
> > > > > might take a while to propagate to distros and 2) someone will have
> > > > > to remind me to prepare such a patch when the time comes ;)
> > > >
> > > > Initial ACPI support will probably be merged for 6.4. So maybe it is
> > > > time to get the libvirt side of things going.
> > >
> > > Randomly remembered about this. Did ACPI support make it into 6.4
> > > after all? Is now a good time to change libvirt?
> >
> > Hi Andrea,
> >
> > Not yet. While basic ACPI changes are merged, the interrupt controller
> > support is still going on. Looks like it will take few merge windows to
> > get ACPI fully supported. So, we still need to wait for libvirt change.
> 
> Hey,
> 
> I've been working on making RISC-V support a bit smoother across the
> virtualization stack recently, and I just so happened to remember
> that this topic was still pending.
> 
> I've tried manually switching ACPI on for an existing Fedora RISC-V
> guest running under TCG and booting via UEFI, which promptly made it
> stop working, so I assume the necessary bits haven't made it into the
> kernel yet.
> 
> Is anyone actually tracking that work? We've been waiting for it to
> land for a fairly long time at this point...
> 
Hi Andrea,

It is still WIP. DT patches (which was a dependency for ACPI)  for AIA
interrupt controllers got merged recently and available in 6.10-rc1. So,
I hope ACPI patches will be merged within next couple of merge windows
provided maintainers of different subsystems will have sufficient time
to review.

Thanks,
Sunil

