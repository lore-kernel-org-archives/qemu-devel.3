Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177ECC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 14:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toNXU-0002Bb-4z; Sat, 01 Mar 2025 09:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1toNXM-00028v-EW
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 09:09:53 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1toNXK-000559-4a
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 09:09:51 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f6ae4846c7so26976307b3.1
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 06:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740838186; x=1741442986; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bx7bBRXdx0hUs/MZzB6t4WM5W6m0Sm32LK9sY2qItNg=;
 b=pfJHXqHRySE1qKBe/O4r/vry9P2Bq1PSWJb4loxAFeLJ6MCS3B8z+LTMbHktpE5T47
 Z+Q1p/dNgBoL8J+1emp9sGGnaNWbl1eK0Rd1Tz7vm2V2WjX5sQHW6upubrpTG/tCgkY6
 Uab1W4VzrFcHHzQhY+h7TjjqD+S6j21eKhqsmSJznSWO0r0dwRifCJmWJbDrcn3NTVcr
 DNT29I67rut4bm3O3F4+F+NJIlCMtSn1oqhlD35K6YIhcpFeBPLue/newsH5UAkhsoEH
 xdmvqN4BfiFBFWoKCqQkPFcs8PuOPuhG5ZDhsNL/dsWxrC6NsGU4UMRGr0Zrmf3VpeNP
 pWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740838186; x=1741442986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bx7bBRXdx0hUs/MZzB6t4WM5W6m0Sm32LK9sY2qItNg=;
 b=Ih01U3YcQ/aQdEMV1dtDoYiLR0MRq59gfpHj1buWzJKq2ehnPDgQXzYScuMtp9/RKS
 VfbcR6jWzsug6MAgYfX8wAqVVcbsl0l61Ns6ijMvdhrgT1aKu6wuqenDSmMu5ILE16X3
 H7OB18UjpiN7sSYoqV4VSlVFdjjPOY57nN+zzERhx7ek/T3yvfJSBk29vaEdjE+5z9oD
 LdXlCmKvpivxYWFjWLoheEaCtT8D8Im2+n+Y77I/kTluRWbhHakFcZ1nL7ul7m0fhy26
 J6P8FmG6NKB/7fZebFg4FZ40OyxworSWvnPrBY2ilAHvU4Gq7u6xZbu8+Slr9BWDFKab
 Eg0w==
X-Gm-Message-State: AOJu0YwP1UJeX+/6Vo/RYw1zcHt4QFAbSphegn8BAGrxHBYMy37uhigu
 0XIZg7n14yL8AiSq8X6Ln0eZZqeg3EyP/Z8PGAI5BIXTUbRApIqOCm+U+VUINXk9o3CCs3hWEnB
 cCgfYxHq6yqFlOC5Ueaxm0lkuCyy1Laz0pYPk2Q==
X-Gm-Gg: ASbGnct83l9SLw4MeUMWgtmCcB2rV60fSjbG9uBataMmffxm/vX3yzfL8Up9Qs3NGE5
 3Svhb2I/TJBTPDzmOGSlbgbYfV+gO+EeuXp27yxedwljYG5vEgRFSUI8W2e7yWCFwXvudAwZxYp
 f0edUdLm8/rPVJHBQp2k9SK9MMnyk=
X-Google-Smtp-Source: AGHT+IHlSpiz+yTbYnfjgDw407MXuAwDUVDFRMlE4mREaEPkPTICA+i9ElfEV+/RKSahmZKhBb0w8na0KuBCo5tTtLQ=
X-Received: by 2002:a05:690c:6186:b0:6ef:8dd0:fff9 with SMTP id
 00721157ae682-6fd4a0382f2mr94713517b3.8.1740838186513; Sat, 01 Mar 2025
 06:09:46 -0800 (PST)
MIME-Version: 1.0
References: <3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca>
 <CAFEAcA9kED+fB1repp2+r-zMfZ_5ZeAkZq2ChyxjSUo1j5gAFQ@mail.gmail.com>
 <aef79501-b99f-4e84-b6fe-14dec1e030e6@csclub.uwaterloo.ca>
 <CAFEAcA9ht=T_XqKaKB-PaNK9joQFYgks37JHjqUO-qkaNe7YUQ@mail.gmail.com>
 <d714a7c2-2291-4a85-abcc-81648da1ef57@csclub.uwaterloo.ca>
In-Reply-To: <d714a7c2-2291-4a85-abcc-81648da1ef57@csclub.uwaterloo.ca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Mar 2025 14:09:35 +0000
X-Gm-Features: AQ5f1Jq2WNFqXs4m631xVIIJMU6x3mnJfPaNzbHfjjos46HhJ4C17ONHW1GFajg
Message-ID: <CAFEAcA-9Nj9KrcPwoBBT88wK=NUPsorT71XbBbyLJYOemmkojQ@mail.gmail.com>
Subject: Re: [PATCH] bcm2838: Add GIC-400 timer interupt connections
To: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sat, 1 Mar 2025 at 01:47, Sourojeet Adhikari
<s23adhik@csclub.uwaterloo.ca> wrote:
>
> On 2025-02-27 10:17, Peter Maydell wrote:
>
> On Thu, 27 Feb 2025 at 09:15, Sourojeet Adhikari
> <s23adhik@csclub.uwaterloo.ca> wrote:
>
> The systmr INTERRUPT_TIMER0..3 sysbus IRQ outputs are already
> being wired up in the function bcm_soc_peripherals_common_realize()
> in hw/arm/bcm2835_peripherals.c (to the TYPE_BCM2835_IC
> interrupt controller), and it isn't valid to wire one input
> directly to multiple outputs.
>
> In fact it looks like we are currently getting this wrong for
> all of the interrupts that need to be wired to both the
> "legacy interrupt controller" and the GIC. I think at the moment
> what happens is that the wiring to the GIC will happen last
> and this overrides the earlier wiring to the legacy interrupt
> controller, so code using the latter won't work correctly.
>
> I'll try reading through the relevant sections and send an
> updated patch later next week. From what I can tell it falls
> under the bcm2835_pheripherals.c file, right?
>
> Yes. To expand a bit, QEMU's qemu_irq abstraction must
> always be wired exactly 1-to-1, from a single output to
> a single input. Wiring either one input to multiple outputs
> or one output to multiple inputs will not behave correctly
> (and unfortunately we don't have an easy way to assert()
> if code in QEMU gets this wrong).
>
> So for cases where you want the one-to-many behaviour you need
> to create an object of TYPE_SPLIT_IRQ. This has one input and
> multiple outputs, so you can connect your wire from device A's
> output to the splitter's input, and then connect outputs
> from the splitter to devices B, C, etc. (In this case A
> would be the timer, and B, C the two interrupt controllers.)
> Searching the source code for TYPE_SPLIT_IRQ will give some
> places where it's used. (Ignore the qdev_new(TYPE_SPLIT_IRQ)
> ones, those are a code pattern we use in board models, not
> in SoC device models.)
>
> In this specific bcm2838 case, it's a little more awkward,
> because one of the two interrupt controllers is created inside
> bcm2835_peripherals.c and one of them is created outside it.
> Since bcm2838 is already reaching inside the bcm2835_peripherals
> object I guess the simplest thing is:
>  * create a splitter object in bcm2835_peripherals.c for
>    every IRQ line that needs to be connected to both
>    interrupt controllers (probably easiest to have an array
>    of splitter objects, irq_splitter[])
>  * in bcm2835_peripherals.c, connect the device's outbound
>    IRQ to the input of the appropriate splitter, and
>    connect output 0 of that splitter to the BCM2835_IC
>    correct interrupt controller input
>  * in bcm2838.c, connect output 0 of ps_base->irq_splitter[n]
>    to the correct GIC input
>
> (This is kind of breaking the abstraction layer that ideally
> exists where the code that creates and uses a device doesn't
> try to look "inside" it at any subparts it might have. We
> could, for instance, instead make the bcm2835_peripherals
> object expose its own qemu_irq outputs which were the second
> outputs of the splitters, so that the bcm2838.c code wasn't
> looking inside and finding the splitters directly. But I
> think that's more awkward than it's worth. It's also possible
> that we have the split between the main SoC and the
> peripheral object wrong and either both interrupt controllers
> or neither should be inside the peripheral object; but
> reshuffling things like that would be a lot of work too.)
>
> This weekend I'll try my best to mess around, and get the solution
> you proposed working. From what I can tell, I (personally) think , the no=
t-reshuffling things approach might be a bit better here. Since otherwise i=
t'd turn into a somewhat sizeable patch pretty quick, and is a lot of work,=
 for something that's not *too* big of an issue. I do have access to a rasp=
berry pi if you think I should do any kind of testing before doing the resh=
uffling.

Yeah, to be clear, what I'm suggesting is that we should
not do that reshuffling, exactly because it is a lot of
work and it's not that important. Better to just fix the bug.

> On another note, do you think it's reasonable to add what you said
> here into the development documentation (paraphrased, and if not
> already documented). If I do write a patch to the documentation,
> can/should I cc you on it?

In general, yes, we should at least document this kind of
beartrap. The difficulty is finding some good place to do it
(there are two broad locations: in a doc comment on the
function(s) for "connect a qemu_irq", and in some more
general "how to do device/board stuff" place in docs/devel/).
Feel free to cc me on any patch you send about that.

> (PS: for the other "not 1:1" case, where you want to connect
> many qemu_irqs outputs together into one input, the usual semantics
> you want is to logically-OR the interrupt lines together, and
> so you use TYPE_OR_IRQ for that.)
>
> (oh oki, I'll make sure to do that on the upcoming patch then,
> thank you!)

I think you won't need the OR gate part -- I mentioned it just
for completeness.

> (P.S the patch probably won't be coming till next week since I
> have quite a bit of work outside of my programming stuff to do.
> Should hopfully be done by Wednesday next week though?)

That's fine -- since this is a bug fix we don't have to worry
about getting it in before softfreeze.

-- PMM

