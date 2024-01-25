Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24F3C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqFB-0006sJ-Ep; Wed, 24 Jan 2024 22:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rSqF2-0006rY-28; Wed, 24 Jan 2024 22:17:26 -0500
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rSqEz-00052g-PM; Wed, 24 Jan 2024 22:17:23 -0500
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4b978e5e240so1515059e0c.0; 
 Wed, 24 Jan 2024 19:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706152640; x=1706757440; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwaN3CbtlAQJ3htcvjSjKVPspX5QtiKkTXlSr2wqJ3c=;
 b=Auu1iC0lWyMafTQLM3CEiQKHWiT0VS8vD9bnTd2mjNfjKNybsDg4zFubUTxRZxDJXn
 yLYLXUMjF4i8Yq3bTWQOoLyHDO30t83vJ0wfwxcqwk30tqtSGU2Db4d0/6FZrgcO1wjm
 JXJNCjHjE5VkLkk+tXYCHW+vnbpWt0Ol5ue0OylYIkXFinI2aikQJ6KQWBWyeIonRHFB
 /QTkQw/q1TrcCxb9/IUeoFbrAPycQ0M3RtXIHsU47E58ejhcmh0Qb1itXQuc/GsH3P8e
 Fn5pgXuJD4nRZsAZo75xCHj3zryQZ4PFFZPwG8xZ+D2MVAikeC3FFCDkNSRDQM7TwTkh
 IRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706152640; x=1706757440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwaN3CbtlAQJ3htcvjSjKVPspX5QtiKkTXlSr2wqJ3c=;
 b=uM786k8nT+Xra06PSGCwNYpZalWx/pKRAnHy0VENns0kBGbRM7bSWiH939jJvQByQE
 x485upHAYyrTzyHUxioao3KDxU9u14/3OW2gnEQlY1kCI72oA4tN1wlSnn+FWmB/2+go
 DedYPvYtCAFCxLyEjGua3eYNB1moCInccorJpN6aPrQTCBm7DpzK7mvNVD2o3h1FYFSS
 eK0fNJVrmtk8R1CTVQ4iesj1bpLh05Hlf5eWjJUtJwncaYJFtRSAz5bO964+2BXdDeKV
 YkLbzyXnjEzt5D173vtMLycqYAy+I+hdhUMOQDALT/HZ9vQtNl0aHkTBNf0c8DXd/UI2
 sCpA==
X-Gm-Message-State: AOJu0Yw8UEJd1HqYfzMB3G8LpQ5qOwwuxu1X8OPI0DnhhYojoovmJ9K1
 VPE87V+ji6DwPBhQcq1KkFtYB9WSqnHqLFGTKX7hPM9e2mV/X9M3U2Z8Yqe9kB4PQQgVUKuYNJa
 fciA1SXQVwC5m3HWkD2+UMpXY9Bg=
X-Google-Smtp-Source: AGHT+IHMHxdKXSL/IXvLYYZtkgnAb2Gv/ERvktmnhUmi93yIVwMielkr4sosTa0CGfH1uMGM6evZ/chjZ2JPgUrGoiw=
X-Received: by 2002:a05:6122:4598:b0:4bd:6041:99f9 with SMTP id
 de24-20020a056122459800b004bd604199f9mr189318vkb.31.1706152639678; Wed, 24
 Jan 2024 19:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20231229120724.41383-1-heinrich.schuchardt@canonical.com>
 <20231229120724.41383-4-heinrich.schuchardt@canonical.com>
 <20240122-4f4cbce3692cd684e0409f9e@orel>
 <22105210-d8d1-4808-b9ed-41eee71c53ca@canonical.com>
 <20240122-195c4a8d0ece609441068e16@orel>
In-Reply-To: <20240122-195c4a8d0ece609441068e16@orel>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jan 2024 13:16:53 +1000
Message-ID: <CAKmqyKOpcLoMnSKwsecSqNEFS8rmxsAuPW_njT=+v_tPsswXww@mail.gmail.com>
Subject: Re: Re: [PATCH v2 3/4] target/riscv: SMBIOS support for RISC-V virt
 machine
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jan 23, 2024 at 12:19=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Mon, Jan 22, 2024 at 01:28:18PM +0100, Heinrich Schuchardt wrote:
> > On 22.01.24 10:57, Andrew Jones wrote:
> > > On Fri, Dec 29, 2023 at 01:07:23PM +0100, Heinrich Schuchardt wrote:
> ...
> > > > +#if defined(TARGET_RISCV32)
> > > > +    smbios_set_default_processor_family(0x200);
> > > > +#elif defined(TARGET_RISCV64)
> > > > +    smbios_set_default_processor_family(0x201);
> > > > +#endif
> > >
> > > I think we should use misa_mxl_max to determine the family, rather th=
an
> > > TARGET_*, because, iirc, we're slowly working our ways towards allowi=
ng
> > > rv32 cpus to be instantiated with qemu-system-riscv64.
> >
> > Hello Andrew,
> >
> > thank you for reviewing. I guess you mean something like:
> >
> >     if (riscv_is_32bit(&s->soc[0])) {
> >         smbios_set_default_processor_family(0x200);
> > #if defined(TARGET_RISCV64)
> >     } else {
> >         smbios_set_default_processor_family(0x201);
> > #endif
> >     }
>
> Yes, but I'm not sure we need the #ifdef around the 64-bit part.
>
> >
> > riscv_is_32bit returns harts->harts[0].env.misa_mxl_max =3D=3D MXL_RV32=
.
> >
> > Some real hardware has a 32bit hart and multiple 64bit harts. Will QEMU
> > support mixing harts with different bitness on the virt machine in futu=
re?

That is the hope. Although no one is directly working on it at the
moment. We want to try and keep the RISC-V target setup to do this.

The first goal is to just create and use a 32-bit CPU on the 64-bit
build, which currently doesn't work but it's something that should
work.

Alistair

> > In that case we would have to revisit the code using misa_mxl_max in
> > multiple places.
> >
>
> Never say never, but I don't think there has been much effort to support
> these types of configurations with a single QEMU binary. My googling is
> failing me right now, but I seem to recall that there may have been
> efforts to implement Arm big.LITTLE with multiprocess QEMU [1]. IOW, I
> think we're safe to use misa_mxl_max, since we'll have one for each QEMU
> instance and we'll use a different QEMU instance for each hart bitness.
>
> [1] docs/system/multi-process.rst
>
> Thanks,
> drew
>

