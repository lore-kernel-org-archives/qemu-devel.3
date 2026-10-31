Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E3606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=od5ub31Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNCgb-0006tz-NA; Sat, 31 Oct 2026 13:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNCgR-0006rN-BC
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 13:15:59 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNCgO-000229-3j
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 13:15:59 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so2250064a12.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 10:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793466954; cv=none;
 d=google.com; s=arc-20260327;
 b=RpHDYem38FBtlWjyCeSA5foRjwTP5G0L3VE6x73CwD1EbeFtutRYae4eLQBHsGd1mP
 /fYSMMGWfPjyUPh28WAgyGaEk3Uc82n9W+COYyA9ayVe2Ved8UUjaag+IFv74Z+u4kNL
 glHrIL7Ya4AshjJs6UP2Y0FWSiJ0WmAgn7dlOmRCP9o2rLoOHWNb+jo3Gb6ccNYW371M
 +6tw3qn3YLSA1hjQ/j8vaAFIBEvKewgT5NrAG+c3wpYAkj7nFSoT13ApA2mGn6YdPRdt
 1dnl2CP6LsWDYg5+ED6WAikocLYpftu0iJcivsGe+G0jTAm6LMOMSq7WqaJgAAPT8RSv
 aoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=jcR6W1B2xKRqIisqldgJOoXdL57ofMb0Mlm4KaPe//A=;
 fh=vg27fZV1n5mwhCM70klgGCnq6dc+q6M71Mjxq0UrOCo=;
 b=lBv82iKLlwfL5TE9igOlxiVvIsMztWL1R5522o+jO9s+U86qoaMtvK+U8QwFu1sxJL
 z4HEHn0lOrpyZ/1qXJluXX512/tzvNJh3+auObE+QOioAyegaXE933iBXOa9PLOF3br+
 U87xFE6Na1y+fZImdiQ7I4ej1/R1IxjNkPZJmVkhB3Qak3AI0Dq/vS3Tp+ONuupSib4B
 EO9vqtoKbeH61f5HAoBZN/1RFpvSZJz/v9r0BtAHq7aFlW8NOOaDHxRhdNv84L+OXT6o
 YsNlH/YWP7PRtmuvJSnsuKxvkeazL4mZXkHmmJ3V5vh6gqROIuCHTlf1/K3hIdfRJLV/
 qroA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793466954; x=1794071754; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jcR6W1B2xKRqIisqldgJOoXdL57ofMb0Mlm4KaPe//A=;
 b=od5ub31ZOvJPvyP6yY4M2o9CKHRwaYetrIc5yL6SU4B+SlERUCBXOh2OjuyD/iQJgv
 NPIMEHeVZ0BRvL4LKbBQ7E11oLRafdDxANmk/EUjkaAwRcSew9Eyukh36sbVhig65BUF
 EWPAMceV5Hna1HRqi9pQDb36Nl9YgRHQN/v3ubzisZNRJzxD6FVhhMW5IGNGT+EJQwRo
 g4RaKCcM1tUQ5sZ38plqHDBi8lkszKoMYnMOHIc2dZmPx6yVgjxhTTidz9yYB9WOK2gk
 slQ1wrlqEq5UiNnnxUeeGUlMd4B3XJVvy7glbrPqkYgwFNqidb7H/M5wE8ur48fWUO38
 c3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793466954; x=1794071754;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jcR6W1B2xKRqIisqldgJOoXdL57ofMb0Mlm4KaPe//A=;
 b=E5mFezejSdcqPcjbFIr/JYGUErCnAhj/6VA0avquPsMsL3aAxE2I+Xnj4SGo/WxvNa
 4WAvPiHYgQAs2s29Da35LWhv0YPir0Ih7tyoYPR+hnsGk2pan3PnNMpCfnxi+xlganzf
 0TJpdqhjXkv05HfDpkrsoaJhxO5Fa+xzI6NYkTig8n7NJTCLZfC6zyQnH1Z88yG8pBe4
 65rc510URVISjq0kmDJwmKlH0/GrJKtVfWAlmkyNmw4rQAS5MLt6zGrVqODjo7Y31EFf
 GGXUmrMrqr0uLMUuWLQVQ4HsJFEI3U0ifgFq0yVFqDNE+70ikLuyqTAMPS5zLx9KQpBZ
 1T0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxNb9N+57EpE9NaCu+Ws+1HvEHE6emrHz5rZ8r7q/uBwx2GPPYR5XWr6vGNsO0tAENn+AvTv4mNAoY@nongnu.org
X-Gm-Message-State: AFq9FYKLkROtLenjuoOHdruWzNX3y3h3+pw8fzud9g67QmNbDdNg7iLk
 T7yFLRuz+SYZ5CssHxhyF/T0lQB7bQPogGM3rUuzYY/ZtKy2laVTBmnnQN9I4uIkyroNWzniiRl
 c2rgt/HnWyL3m1D/gZUgt9twyRKldhRE=
X-Gm-Gg: AYBFou21cUqgkhi0PMHW7SdDLatcgRUYWdj9R8Hcv8RHAgnSR4Lf2SKJE8K6ay5KMLC
 zcKDPm628JH411Cd7j/woJLMXP7/LZ4UHwRH4UJc1zn7Y7vysdrBmKwcttzwiVcz2LDjxB3HyiR
 CFApuXyA8AW6kXoDJwyWq4yQQbiH4FHbqLiQx+OcOsAyIXf50OIJH30qiEguzi4q4lA8Lx0rFCg
 IV0QszXJ41XPod1W+rwuckbL9VG1/1cTtU7aXcggBbuYQRhp1DsHgLEs1UaSxpg2CwRzjiqYwUg
 Bi69C4wLovWmfpmBStKLbTYS8+IJ6xvZ4hVZDyNhL5JE9+Dm3hwuQ4Vopw5ucluo4RhOgt2QsN/
 ky4zmVNv9EItBM//wbRis5es4+jIalxz+vTm/
X-Received: by 2002:a05:6402:4505:b0:6b4:8d16:f026 with SMTP id
 4fb4d7f45d1cf-6b4d3391cd5mr3933460a12.1.1793466954061; Sat, 31 Oct 2026
 10:15:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
 <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
 <ba106173-fca3-6019-3028-122831887921@eik.bme.hu>
 <CAE2XoE9cR_X0kkDfGTU4Mt_5Hc3WZ8K5rghw2AeL4Vh=eugGag@mail.gmail.com>
 <bf45a858-db07-de03-70ea-ca0061d7a5d1@eik.bme.hu>
In-Reply-To: <bf45a858-db07-de03-70ea-ca0061d7a5d1@eik.bme.hu>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sun, 1 Nov 2026 01:15:40 +0800
X-Gm-Features: AclHuK8AaPCnv2Mbs_9iupAlH2py4_RazQLc7kNcPpAEEJrZBPKdgONHzmsQuE0
Message-ID: <CAE2XoE9_b5UiE2+BXFRqB3RPv=M+8jr1HQy7rEFVEb6w1DdoGg@mail.gmail.com>
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Anthony PERARD <anthony@xenproject.org>, Felipe Balbi <balbi@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 Antony Pavlov <antonynpavlov@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, Niek Linnenbank <nieklinnenbank@gmail.com>, 
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 1:06=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
> On Sat, 31 Oct 2026, Yonggang Luo wrote:
> > On Sat, Oct 31, 2026 at 8:42=E2=80=AFPM BALATON Zoltan <balaton@eik.bme=
.hu> wrote:
> >>
> >> On Fri, 30 Oct 2026, Pierrick Bouvier wrote:
> >>> On 10/30/2026 4:09 PM, BALATON Zoltan wrote:
> >>>> On Fri, 30 Oct 2026, Yonggang Luo wrote:
> >>>>> DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo and th=
e
> >>>>> type_init
> >>>>> function that calls type_register_static(). A later change needs to
> >>>>> pass a
> >>>>
> >>>> That's the point of the macro to hide the boiler plate code.
> >>>>
> >>>>> target mask into that registration, and the macros have no paramete=
r
> >>>>> for it.
> >>>>
> >>>> Couldn't you just change the macros to take that parameter instead o=
f
> >>>> expanding it everywhere?
> >>>>
> >>>
> >>> Problem of macros is that they don't have default parameters, so you
> >>> need variants for everything:
> >>>
> >>> DEFINE_MACHINE
> >>> DEFINE_MACHINE_EXTENDED
> >>> DEFINE_MACHINE_WITH_INTERFACES
> >>> DEFINE_MACHINE_WITH_INTERFACE_ARRAY
> >>> and now would need a new variant, with variant for other existing one=
s.
> >>>
> >>> In the end, it's just simpler to remove this and add the boilerplate.
> >>> It's written once and never modified, so using a macro just save typi=
ng
> >>> those lines once.
> >>>
> >>>> Regards,
> >>>> BALATON Zoltan
> >>>>
> >>>>> This series expands every caller first, with no behavior change, so=
 the
> >>>>> follow-up only replaces the type_register_static() call.
> >>>>>
> >>>>> Each machine file gains a class_init function, a TypeInfo, and a
> >>>>> type_init
> >>>>> function that calls type_register_static(). The last patch removes
> >>>>> DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* from include/hw/core/boa=
rds.h.
> >>
> >> Macros help reading the code not saving typing. If the actual
> >> functionality is buried in a lot of boiler plate it's harder to unders=
tand
> >> and spot bugs so putting the unintresting boiler plate behind a macro =
is
> >> better even if you need a separate version for different cases. Then t=
he
> >> code that uses the macro will be much more obvious and not just a lot =
of
> >
> > I think mainly because DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* are
> > not defined properly
> > that causes them to not be extended easily.
> >
> > DEFINE_TYPES is another example, use them can extend easily, how about
> > always use DEFINE_TYPES?
> > Or add a DEFINE_TYPE to replace DEFINE_MACHINE* and DEFINE_SECURE_MACHI=
NE*?
>
> Maybe I'm missing the problem but DEFINE_MACHINE macros are just
> convenience wrappers around DEFINE_MACHINE_EXTENDED. So why can't you add
> the needed parameter to DEFINE_MACHINE_EXTENDED and use that for machines
> that need it, or if it's needed by all machines then make the new
> parameter required and add it to all convenience wrappers too so you can
> keep using DEFINE_MACHINE* and just need to add one parameter to it in
> machines?

That's the issue, add parameter to DEFINE_MACHINE_EXTENDED means all
calls to it also need
to be changed, that means touch many $target_arch files. currently
it's 13. But after these
changes, there will be much more usage on it, and if we want to add
more parameters or attributes
to it, it will be a new tree-wide change.

And DEFINE_TYPES do not suffer from such issues. As the TypeInfo[] is
explicit defined for
DEFINE_TYPES

>
> Regards,
> BALATON Zoltan



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

