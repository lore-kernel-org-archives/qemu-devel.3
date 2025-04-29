Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA64C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9dTo-0006pV-0l; Tue, 29 Apr 2025 01:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9dTl-0006pD-ES; Tue, 29 Apr 2025 01:26:01 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9dTj-0000kH-Aq; Tue, 29 Apr 2025 01:26:01 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so940573866b.1; 
 Mon, 28 Apr 2025 22:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1745904357; x=1746509157; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UULEW/KaWm2jHs9sP0tHkXnBwnbTPDhkgpLa7XVbG8s=;
 b=jSQlYPOOIeW/+B0cXoMo8XUJ7EeacTiv0EgSDmDOFZ8NkQQvnii2BuLOgvVL7Q+kW0
 MFf6Jc5X9NlZGAZfQLW/8X436PJ64GzONBkwlwmGBswcVZ6thI0ngOVEtwmzDhFIcyiP
 zV683ZLGFuUdhzG1UMhiv2E8skaLMnmgGUHMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745904357; x=1746509157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UULEW/KaWm2jHs9sP0tHkXnBwnbTPDhkgpLa7XVbG8s=;
 b=PbElT4lCuO2i3TNH20Xp+PqztWY9Z/VnPtX7Mw75rYXHtIZNAXAHp3592Vs+ABNuEF
 3ZR9dFNbJfMvWwiPRtDszdREaN5RgfuwN0vUZq62v7u0cJYJqLEPNen2DV9PglUjKDHD
 OETcXLjrDqPlivo5ApjV1lNkFyuTN3z2GYIuvdxGN76//P58YgxecOimUSWoSsFOV164
 CSCYPI10hXCQcFIy089UAA0BL+97fGZJe/t2v2SH/fBnHRmLIH5uySHXenCU3SGNT/0r
 jDNR55qsvUUaxOqGYCkeSY77Vd7ioe5sWmGUWDMgsaxTkKMBvl2uv1cn0hZew9XbDKQW
 FjGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqOosv3GS6ZP6IVlUsaRAu3sPgfekcmmQ8ckETpNFSdK2D+AH9Sm6l5wWPPTIumW5jxmzMV7354HG9@nongnu.org
X-Gm-Message-State: AOJu0YyKb2JXLxd456qtVD0f5OSLbtEZdCmpFDmbdHBLzvj4HbjSueof
 lZBojiM3WX2hiQM1oEzYwJtcw1kuJ3KwD1sNQLxaru9wWXpgsB8oCLtEVfeMTZK+Z085WHleMza
 iL+jAQKRh0/A1dofOEdHM8Q5PJy39Jg==
X-Gm-Gg: ASbGncs63oEg8PeQGhu9cBdIiApFHRbAuixJtjhN4kFJR6pdCxki/d84i7MQKRZWGM/
 kJMZtlBmrNE5l/m64C+AISnqYSrpZGZnu0XlHXZuCONjN7oj94th39TmSMkMEo0AFVu+K8F8lMB
 NYiv7Czz3iFnnrWVxOhnLFTw==
X-Google-Smtp-Source: AGHT+IHwInmrQ99CC5fXl+RJmPAd3a1co+2sk+ZRtvp5tGYk1gaBMBg8DNUSG6zrzvrKAlW45RQsbOF3adyW6CkaPvQ=
X-Received: by 2002:a17:907:3e26:b0:acb:124e:81fa with SMTP id
 a640c23a62f3a-acec69cfafbmr174269966b.5.1745904357043; Mon, 28 Apr 2025
 22:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-2-dbarboza@ventanamicro.com>
 <CACPK8XfF74wHqdBBz=qPLefAD8pKT-0C8e=kfFtTeMH+teF-7A@mail.gmail.com>
 <7d5181de-eb42-44b0-80cb-b2f8a3aed47c@ventanamicro.com>
In-Reply-To: <7d5181de-eb42-44b0-80cb-b2f8a3aed47c@ventanamicro.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 29 Apr 2025 14:55:44 +0930
X-Gm-Features: ATxdqUGqqgq0pkLWP1GWf5c5uX3f6AlSA4y8QdT2ntMam8_fIKmLE6P8rI51ToU
Message-ID: <CACPK8Xc5Av4QnHwcfe5JhcHUYmdLxm6P+vDh=_zze7UvbaaJ8w@mail.gmail.com>
Subject: Re: [PATCH 1/9] hw/riscv/virt.c: enforce s->memmap use in
 machine_init()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

On Fri, 25 Apr 2025 at 21:23, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 4/24/25 6:51 AM, Joel Stanley wrote:
> > On Wed, 23 Apr 2025 at 20:37, Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> >>
> >> Throughout the code we're accessing the board memmap, most of the time,
> >> by accessing it statically via 'virt_memmap'. This static map is also
> >> assigned in the machine state in s->memmap.
> >>
> >> We're also passing it as a variable to some fdt functions, which is
> >> unorthodox since we can spare a function argument by accessing it
> >> statically or via the machine state.
> >>
> >> All the current forms are valid but not all of the are scalable. In the
> >> future we will version this board, and then all this code will need
> >> rework because it should point to the updated memmap. In this case,
> >> we'll want to assign the adequate versioned memmap once during init,
> >> in s->memmap like it is being done today, and the rest of the code
> >> will access the updated map via s->memmap.
> >
> > I was writing a patch for a machine and came across the same
> > inconsistencies. Nice clean up.
> >
> > Some of the device initlisation code could be refactored out to be
> > shared by other machines within the riscv directory. Related, parts of
> > the device tree creation could belong to the model, instead of to the
> > machine, as the properties are a property (!) of the device.
>
>
> Yes, delegating the FDT creation to the device, instead of having each machine
> to create the (mostly) same FDT code over and over again, is something that
> I've considering for awhile.
>
> I keep postponing it mainly because I would like to verify with the DT folks if
> there's a guarantee that a given device/CPU DT is always the same, i.e. a device
> DT is always the same regardless of the machine. I have a guess that that this is
> indeed the case but a confirmation would be nice .... Conor, care to comment?

I'd be interested in Coner's thoughts on this.

My understanding is bindings strive to specify the hardware
independent of the machine it's part of. We have bindings in the
kernel tree, and associated drivers that use those bindings, that work
fine on different machines. The litex peripherals are an extreme case
of this; peripherals defined in python that are attached to soft cores
often running on a FPGA.

At a practical level generating the device tree for a given device
does need to take into account specifics of the machine.

Things like interrupt properties depend on the interrupt device you're
delivering to (some have two cells to provide a 'flags' parameter
alongside the irq number). In general anything that contains phandles
could end up being machine specific. Another case is the number of
cells in reg properties, which depend on the bus the device is
described to be on.

These are things that some common code would need to handle, not show
stoppers for the idea.

> In this refactor we could then create FDTs by passing along a memmap pointer and
> a fdt pointer, as you've suggested.
>
> All this said, there's no need to do such FDT refactory all at once. I think I'll
> start with the most common devices between RISC-V boards and go from there.

Agreed! It was just something to keep in mind when deciding what
pointers to pass around.

Cheers,

Joel

