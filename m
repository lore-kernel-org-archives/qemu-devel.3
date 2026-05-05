Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473B1CD13DA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK8q8-0005uo-Jn; Tue, 05 May 2026 02:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK8q4-0005uW-7E
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:01:01 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK8q0-0003YU-TU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:00:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b788a98557so40006595ad.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777960854; x=1778565654; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fMJcwTxiggxHaMmt06Sw86f0O6UI8H4SoYWx/UapNXU=;
 b=Fcs7oYYcnOk2yPNPhojSrCUbMHyrkczEhK/dHD5+4rGo6tIJ5cdTEk/qqZlWt2lxxC
 GpUYlLPmKFwr7a1ovbcsRhrN8ASfeoTKHPi0/l8F4yAugJX6RZAuewYHSEsBAB1m1/AJ
 iwRNnXQMZ926YDwkiyFf3CVzwzEZYwH2cOxz3nkTKwHW52jP2NziBsjHT5CMQSj1oVsR
 DTuS3s6hdvUV9BLMbr1qPwvyD6iGbF7gTyQeYo6xCJyYxCnGpGN3UYxRWyMu9KNbygEo
 RdklIcr8IDthDoFHTnoeNBC0vivii+F6mxSqq0ljfFxQUEPkLpJKieQ3QqpR79qJhCVq
 0YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777960854; x=1778565654;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fMJcwTxiggxHaMmt06Sw86f0O6UI8H4SoYWx/UapNXU=;
 b=kXjkUkjtX7xdDt7VkjJIj+ka6t3qjjR00paixTV0W3JKaAq24z6jsgfcwG8+aBgUBS
 lje8sowS6tV8KcjjMve/Cgk7oEalVcKc5Cvrwnyb2HprimIKHv0hMo4JAnQsr3rFDgJ8
 69jdOmEnsjkzeBQ4YJ/TJyNTHiXWHvnTu2DCpGP7qS48ljf06vzsePDN2IvfMWEEA5Qf
 OfnPI945uCqK1bOIP8WnnqUvroex0sdCCZcwjySXWYgrAiViIuykjtNEX+JXIb3hIlRD
 Wve9Doc22rKFwMo97FNJTd9hTM7ZQ4gXjvilHY8Adw06QyKSSje18MKg5M7ZvXc1UQC8
 Wmrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Fk1YU7+8RZkhlCj1PDYUCM8FIb7HxV3CAFuVnt3UvLq7JJkMnP+2J+xiRBP4Zk9whG1cWbT7nntoz@nongnu.org
X-Gm-Message-State: AOJu0YyqG1pVvSIMYJVp8NNC0kBKFlUGRLN7BCiGnceILlz3xJ1YvkBL
 TUA21sfNabfbBNos76VBh2NXJfP21IKmVVUbaAhdXB7qWQLmyeqkPLoU
X-Gm-Gg: AeBDieu63iGgyJuQ8pfwFjDE0GgQP/LJwGAl7o4MMLovX9cKUDxObf7+R+okULapXs5
 BsPDRkzRgcRPRgUvDlGmt5NQyi2x3UWjGU7P1kP85F60JCqJ4DC9wPcKhoEgSHC8GnKOAlom7bo
 S5rts4MI5PgYyUcpMGD/+oJv8+B7lAzmlMo91PkRATRZho4+A9VrRmcQvzDrOwC9+HI9a7zJ/qv
 UXLXly63y4GdmNtcGxj440B5TXVrFC5S/atB1uWOV6Vg7SGQFrhdadAtMUpCtAGN0k0XDWUQvyp
 9hZCnFzC/7bQ5maQmPakywXKNAtN6QEql5T1HRhl+AQf7kdzMNULw8xJie+eFfZAUydvyG4qwGE
 AIWxLaOHWp8cSS9+5mPpSeFMPErzCfj601nwN7pH1QN/sTbhSGnGm1GeL+IxgDsQsBoynLKq8Eo
 viNBwAk1k6sYXRmbqXfa81c4enysGw+IrRAJe7Sx74MQ72ZvSNbUpAtg==
X-Received: by 2002:a17:903:3ba4:b0:2b9:fe59:2375 with SMTP id
 d9443c01a7336-2b9fe592496mr102687525ad.39.1777960854218; 
 Mon, 04 May 2026 23:00:54 -0700 (PDT)
Received: from localhost ([124.158.97.178]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9cae15fb6sm128714315ad.43.2026.05.04.23.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 23:00:53 -0700 (PDT)
Date: Tue, 5 May 2026 16:00:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 09/13] hw/riscv: Add Tenstorrent Atlantis machine
Message-ID: <afl6x1CTIx2jvMH0@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-10-joel@jms.id.au>
 <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
 <afk0kVtQGz7OZ65_@lima-default>
 <CAKmqyKMbWXFBSuiKyp1uQ5TBhFAEex961Jzp4To5uyBzuUGMBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMbWXFBSuiKyp1uQ5TBhFAEex961Jzp4To5uyBzuUGMBQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 05, 2026 at 02:34:50PM +1000, Alistair Francis wrote:
> On Tue, May 5, 2026 at 11:04 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Thu, Apr 30, 2026 at 09:57:34AM +1000, Alistair Francis wrote:
> > > On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:
> > > >
> > > > The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
> > > > and CoreLab Technology. It is based on the Atlantis SoC, which includes
> > > > the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
> > >
> > > Can you provide a link to documentation
> >
> > Also not presently.
> 
> Hmmm... That's a bit annoying. Can we get some?

That's the plan but I don't have a date I can give you for it, sorry.

[...]

> > > > +static void create_fdt_cpus(TTAtlantisState *s, uint32_t *intc_phandles)
> > >
> > > So generally we only create a device tree for virtual boards, that is
> > > boards that don't really exist and are just QEMU constructs.
> > >
> > > You said that this is based on the "Atlantis SoC" so I assume it's
> > > real hardware. In the real hardware do you expect the device tree to
> > > be provided by the ROM? Usually for boards users supply the device
> > > tree as part of the boot flow (via u-boot or something similar). In
> > > which case should QEMU actually generate this or can users just supply
> > > their own?
> > >
> > > Basically the question is, if you are trying to model the hardware, is
> > > generating the device tree here correct?
> > >
> > > Obviously the advantage of doing it here is then the device tree
> > > describes what QEMU supports, which is great. But that can be harder
> > > to manage when the hardware doesn't do that, as then you have
> > > divergence.
> >
> > We went around this same discussion internally and yeah it's a valid
> > question, we could have explained this a bit better.
> >
> > In the real (unreleased) hardware and the DT will be loaded from ROM.
> 
> Really? That usually doesn't go well

Well not ROM but flash loaded by early firmware. The plan is to have an
"M mode" dtb loaded for opensbi and then later stages supply their own
dtb.

The opensbi dtb won't go away from the tt-atlantis model, whether its
generated or we change it to use a dtb for the purpose of QEMU. I guess
if the next stage does not have its own dtb it can use one supplied by
opensbi.

Does that sound right? I don't know if I have the details exactly right.

> > I think we should do that when the model and firmware and dt is more
> > complete. At the moment it has been easier for development to use QEMU
> > generated fdt.
> >
> > Is that acceptable to do that now and switch to a fdt ROM later...
> 
> Obviously guest software can decide to use whatever it wants. But what
> we don't want to do is break users. So removing the generated FDT
> (which is the equivalent of ROM FDT on hardware) will cause breakages.
> So we don't want to do that if we can avoid it. Also generating the
> FDT is overhead for us, so we only want to if the guest software will
> actually use it. Does that make sense?
> 
> Adding the device tree later is fine though, as guests don't have to use it.
> 
> >
> > [...]
> >
> > > > +static void finalize_fdt(TTAtlantisState *s)
> > > > +{
> > > > +    uint32_t aplic_s_phandle = next_phandle();
> > > > +    uint32_t imsic_s_phandle = next_phandle();
> > > > +    void *fdt = MACHINE(s)->fdt;
> > > > +
> > > > +    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> > > > +
> > > > +    /*
> > > > +     * We want to do this, but the Linux aplic driver was broken before v6.16
> > > > +     *
> > > > +     * qemu_fdt_setprop_cell(MACHINE(s)->fdt, "/soc", "interrupt-parent",
> > > > +     *                       aplic_s_phandle);
> > > > +     */
> > >
> > > And now we are stuck with hacks like this, which we really don't want
> > > to be dealing with. Maybe it's best to leave the device tree to the
> > > kernel.
> >
> > ... Despite issues like this?
> 
> If the kernel generates a device tree for it to use then we don't have
> mismatched problems (like this one). Generating the DT in QEMU for
> real boards proves to be a challenge and this is exactly why. Now we
> have to choose between pre or post 6.16 support (I assume 6.16+ works
> without this, but you get the point).

Yeah I see do see why we'd want a Linux one, and we are currently
upstreaming dts for Linux. At the moment we don't have it so using
the firmware stage one fills the gap.

It is a little bit hacky maybe but I guess I'm not seeing where a
compatibility problem comes in versus other systems with their own
firmware DTB (that I assume a next-stage could similarly use and be
exposed to these issues if it did not supply its own).

Thanks,
Nick

