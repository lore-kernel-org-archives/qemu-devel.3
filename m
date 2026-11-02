Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F0606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H9AyoPAq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNiMD-0002h4-LK; Sun, 01 Nov 2026 22:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNiMA-0002go-VI
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 22:05:11 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNiM8-0006C5-9n
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 22:05:10 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so3373955a12.1
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 19:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793588706; cv=none;
 d=google.com; s=arc-20260327;
 b=EDPfDYEUjd0UW30qrPpPvjiyltYJl/TaIgYSvc3n6Y43K7sD5M+ix4QGzUWiXAMfPc
 U8cHsfyy9n4ivzN8mgbbgeAknqiro5ZEovuwuBnaFNENHPip8JePqpAsGp0qhlqGNLFB
 asvIkY4udrsDI+WTdPX40fI3dqIGvt++/x2BhkjOjhm981dcQkWS6EJIso8Qf6/IMDB6
 VDKtnPLg9YASdh7kVyq58PSlS8a3oc709WL7ll+sDdTWYFaqZIg8ZRbNwaFwtQ3Z7M+k
 EVqWXCYFJpmUgAhMSVpfj/0uRre80ARJEKrZLyEompPbo15wYWZQekdFOP5Bwq674INf
 T1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=imk8Y3dp71z9rketUe9RnJkNrtaKIPDOf8w3Ba5TnQo=;
 fh=2WyXaQEsVO00iOZjOFiMF0hbkJ8QWJzEmqhSR1cNtb0=;
 b=hWgN/FcVvrZKpxNZDxwTSmId9A9LA92h5CUWmAJkZ1uJJMB0DxBlu/yITQ2J7j9DXu
 7CI4fBVUxpC8e1S/C8stT2PnpjXKSnEkUTB4CNgiPzSqGYAGlaq0dH1gdThiw09HXJmY
 aVLNWe7C/0qT1f1hUg+yh4CdP3Sn3eGH7ug63BwxapCfPbE1B8bXH9QuNB+opE8ZVLpZ
 wwzqUl9G/J0TYWwMvk88ftnxmMgEM//PuCBa7uMkgt4UeY3CrOmNA8zcFuoLZdrO9KH6
 bTH751I/9Ma0v5pfgYxyqZeFTrDVWUo+ZwHk5ihzonrvI8J28AZHWajPYI2KdLN1W1S4
 ZcCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793588706; x=1794193506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=imk8Y3dp71z9rketUe9RnJkNrtaKIPDOf8w3Ba5TnQo=;
 b=H9AyoPAqCgZpy+ufA1sRf010sY8utiPWwUTEW2D6mAKtMAcaAGNQF3jaRwK0Ox3sIt
 /NpY9JV9Bdwjs4arwYgH50d1a76DA0eUNdYKSx4YFb5Ckw3eF0EpAy7v/Z5g6VoxWiHP
 tfva01tXEspjerF4/hLVtGpMQ7ND6jw1e4zw5iGjUbCg/f6gUjUegFXa5S/YLlE+K++a
 QXTk9lFEfGul9rEOY5QPEJxFwGa1wbw6pSaWjPxxy5XBnnGHM27Yf9nKtqvWVlleO0UO
 tSvnV0/UyJ4X9rDVyzu8eLDnTElIUJqbVyofvEW8mCIMTjHBhVZNpGYG7+fw8O0y/aMZ
 u+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793588706; x=1794193506;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=imk8Y3dp71z9rketUe9RnJkNrtaKIPDOf8w3Ba5TnQo=;
 b=Xhh2WK37mTLIr0YdG8I4/oIzv0m1sCIXdxhF3XmQb/EPO6yl4EcidUeBl5qkaAWSZi
 ialfX56kCOolGlQXuilnyzurO4EgE0VHTdZegiXdTGo7DFjhKrclCEq8nEfIR/PYBBUv
 MBBWHKV2H3ieEJ/gnFoIbyPd07F4r8WX4tnrCSzmszW2IfI0ZocslKPOSIwhuRAW2t0K
 R/iomPDOpWdIEHPmfeF4raQPsayEbSfa0QX8T4QRDdaroEOnu0alJLPxeQlb23hfILZ8
 TtVUGosagudsP2lYGW1AHcPybpVoKdSxQm8JoTeOO4Vzs1C8ue1HNP2hTWCTa8N98z1S
 HDoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBykYwy5bwx0PB3FUZiMP93ud9qZX33gL7vdTiDCGVvKv5CgnnUNnwHKShwFWG2IlY11eOEaLTX9jiPb@nongnu.org
X-Gm-Message-State: APuU4Z/SnM2lf6XnkcuvST68TOKtcp7gWtFl9I2cyVZMsk9SV0MSI9LK
 iXnb/x86XV6z5AZ+obdbBDsHx7ie/uxj/Y1yixck45nT2r6jjRlt/sOgkGNeHIjRNFnGuWYVoLL
 iQrErCRAjXtH9B2rM5IHrrR4j1dgiIV8=
X-Gm-Gg: AYBFou0p1S9DhA05R7ZmfL7dUI0dsMW6tHKhy7VgQOgfGfaTzIqiZOOXDGCk2r8jq6o
 1zZAR2O+YLIWX7ElvOVh1L4Ex1K8LHxFEcvOG/oCrql5AMiNTTV8UWLZDHITbsTQRrHMp+58vhl
 6raQevJZ+2gDgzM6VDDLAwh9eJXl88lXPzyeOvD7oN5gAIocIoeKF7IrB20ZdnbQtQ8IlvN2vx+
 MIkITJBoVsUmCTKVopo4QnrRp8flvHu4rO4TThfj8qAbPLkhCgYzKn+d3R7xBDTnGHXhU/HGzQV
 W41eyLsAR8eXFCCGcsM950tX7hiftNFbYjNU2nf5m4/O7/WLCHTTU241pnxungd+IiVWo6kbwPD
 uRTT1XbChuAcqvjk3U4XXoRjb3L7tWCh4A3NJ
X-Received: by 2002:a05:6402:11d3:b0:6af:dc4c:5f28 with SMTP id
 4fb4d7f45d1cf-6b4d4f71386mr6168227a12.37.1793588705869; Sun, 01 Nov 2026
 19:05:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
 <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
 <ba106173-fca3-6019-3028-122831887921@eik.bme.hu>
 <CAE2XoE9cR_X0kkDfGTU4Mt_5Hc3WZ8K5rghw2AeL4Vh=eugGag@mail.gmail.com>
 <bf45a858-db07-de03-70ea-ca0061d7a5d1@eik.bme.hu>
 <CAE2XoE9_b5UiE2+BXFRqB3RPv=M+8jr1HQy7rEFVEb6w1DdoGg@mail.gmail.com>
 <a479df5b-721d-c357-5c69-c3760a73e521@eik.bme.hu>
 <CAE2XoE-2w3A4=BeskGgp7NYUtkRVNkNufu4SZjW_OQ-KAQZvhg@mail.gmail.com>
 <6efa9f73-75dd-efd0-3fd9-6b2654b69737@eik.bme.hu>
In-Reply-To: <6efa9f73-75dd-efd0-3fd9-6b2654b69737@eik.bme.hu>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 2 Nov 2026 11:04:50 +0800
X-Gm-Features: AclHuK-B5Bt-Oq5n8C1F46Ueo6UjVwoSHbd-GyMOrqSjrQb5HmRreMzyOD5B1cQ
Message-ID: <CAE2XoE8pNaP3rAR5Y2BpUZ2vSu-UC-wG9V9U7gPXrEGY=kx0RA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x531.google.com
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

On Mon, Nov 2, 2026 at 4:57=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
> On Sun, 1 Nov 2026, Yonggang Luo wrote:
> > On Sun, Nov 1, 2026 at 7:29=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.=
hu> wrote:
> >>
> >> On Sun, 1 Nov 2026, Yonggang Luo wrote:
> >>> On Sun, Nov 1, 2026 at 1:06=E2=80=AFAM BALATON Zoltan <balaton@eik.bm=
e.hu> wrote:
> >>>>
> >>>> On Sat, 31 Oct 2026, Yonggang Luo wrote:
> >>>>> On Sat, Oct 31, 2026 at 8:42=E2=80=AFPM BALATON Zoltan <balaton@eik=
.bme.hu> wrote:
> >>>>>>
> >>>>>> On Fri, 30 Oct 2026, Pierrick Bouvier wrote:
> >>>>>>> On 10/30/2026 4:09 PM, BALATON Zoltan wrote:
> >>>>>>>> On Fri, 30 Oct 2026, Yonggang Luo wrote:
> >>>>>>>>> DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo an=
d the
> >>>>>>>>> type_init
> >>>>>>>>> function that calls type_register_static(). A later change need=
s to
> >>>>>>>>> pass a
> >>>>>>>>
> >>>>>>>> That's the point of the macro to hide the boiler plate code.
> >>>>>>>>
> >>>>>>>>> target mask into that registration, and the macros have no para=
meter
> >>>>>>>>> for it.
> >>>>>>>>
> >>>>>>>> Couldn't you just change the macros to take that parameter inste=
ad of
> >>>>>>>> expanding it everywhere?
> >>>>>>>>
> >>>>>>>
> >>>>>>> Problem of macros is that they don't have default parameters, so =
you
> >>>>>>> need variants for everything:
> >>>>>>>
> >>>>>>> DEFINE_MACHINE
> >>>>>>> DEFINE_MACHINE_EXTENDED
> >>>>>>> DEFINE_MACHINE_WITH_INTERFACES
> >>>>>>> DEFINE_MACHINE_WITH_INTERFACE_ARRAY
> >>>>>>> and now would need a new variant, with variant for other existing=
 ones.
> >>>>>>>
> >>>>>>> In the end, it's just simpler to remove this and add the boilerpl=
ate.
> >>>>>>> It's written once and never modified, so using a macro just save =
typing
> >>>>>>> those lines once.
> >>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> BALATON Zoltan
> >>>>>>>>
> >>>>>>>>> This series expands every caller first, with no behavior change=
, so the
> >>>>>>>>> follow-up only replaces the type_register_static() call.
> >>>>>>>>>
> >>>>>>>>> Each machine file gains a class_init function, a TypeInfo, and =
a
> >>>>>>>>> type_init
> >>>>>>>>> function that calls type_register_static(). The last patch remo=
ves
> >>>>>>>>> DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* from include/hw/core=
/boards.h.
> >>>>>>
> >>>>>> Macros help reading the code not saving typing. If the actual
> >>>>>> functionality is buried in a lot of boiler plate it's harder to un=
derstand
> >>>>>> and spot bugs so putting the unintresting boiler plate behind a ma=
cro is
> >>>>>> better even if you need a separate version for different cases. Th=
en the
> >>>>>> code that uses the macro will be much more obvious and not just a =
lot of
> >>>>>
> >>>>> I think mainly because DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* a=
re
> >>>>> not defined properly
> >>>>> that causes them to not be extended easily.
> >>>>>
> >>>>> DEFINE_TYPES is another example, use them can extend easily, how ab=
out
> >>>>> always use DEFINE_TYPES?
> >>>>> Or add a DEFINE_TYPE to replace DEFINE_MACHINE* and DEFINE_SECURE_M=
ACHINE*?
> >>>>
> >>>> Maybe I'm missing the problem but DEFINE_MACHINE macros are just
> >>>> convenience wrappers around DEFINE_MACHINE_EXTENDED. So why can't yo=
u add
> >>>> the needed parameter to DEFINE_MACHINE_EXTENDED and use that for mac=
hines
> >>>> that need it, or if it's needed by all machines then make the new
> >>>> parameter required and add it to all convenience wrappers too so you=
 can
> >>>> keep using DEFINE_MACHINE* and just need to add one parameter to it =
in
> >>>> machines?
> >>>
> >>> That's the issue, add parameter to DEFINE_MACHINE_EXTENDED means all
> >>> calls to it also need
> >>> to be changed, that means touch many $target_arch files. currently
> >>> it's 13. But after these
> >>
> >> That's not different from expanding the macro which would touch the sa=
me
> >> files.
> >>
> >>> changes, there will be much more usage on it, and if we want to add
> >>> more parameters or attributes
> >>> to it, it will be a new tree-wide change.
> >>
> >> Do you expect to need more parameters? Can't you add them at once then=
?
> >>
> >>> And DEFINE_TYPES do not suffer from such issues. As the TypeInfo[] is
> >>> explicit defined for
> >>> DEFINE_TYPES
> >>
> >> My point is that keeping the boiler plate as little as possible makes =
the
> >> code more readable. DEFINE_TYPES hides some of the boiler plate,
> >> DEFINE_MACHINE hides even more so converting to DEFINE_TYPES would exp=
ose
> >> some even if it's better than no macro at all.
> >>
> >> What exactly are the parameters missing from DEFINE_MACHINE_EXTENDED t=
hat
> >> need to be added?
> >
> > Hi BALATON
> > the things we faced is we first is to add TypeInfo::is_available parame=
ter to
> > DEFINE_MACHINE_EXTENDED, and have more usage of it.
> > Then we will add targets:uint64_t parameter to DEFINE_MACHINE_EXTENDED,=
 this is
> > a prepare to remove TypeInfo::is_available parameter from
> > DEFINE_MACHINE_EXTENDED,
> >
> > And finally, once all usage of TypeInfo::is_available can be replaced w=
ith
> > targets:uint64_t, then we finally need to remove
> > TypeInfo::is_available parameter from DEFINE_MACHINE_EXTENDED,
>
> Is there a way to avoid the temporary is_available churn and introduce th=
e
> targets:uint64_t right away? (I'm not following this so I don't really
> know what you're talking about just looks like there's some churn here
> which might be good to awoid anyway independent of these macros.)
>
> > That's what I am facing now. And the explicit
> > static const TypeInfo xxx_machine_typeinfo =3D {
> >    .name       =3D MACHINE_TYPE_NAME("xxx"),
> >    .parent     =3D TYPE_MACHINE,
> >    .class_init =3D xxx_machine_class_init,
> > };
> >
> > Will help me avoid the issue. And I think this is a little boilerplate
> > and very explicit.
>
> That's not all DEFINE_MACHINE hides though. It's longer with .abstract,
> .secure and .iterfaces plus the machine initfn that would also need to be
> expanded if you used DEFINE_TYPES.
>
> Is this conversion needed for all machines using all DEFINE_MACHINE

At the end, only "none" machine do not have targets parameter or
(QEMU_ARCH_ALL), as that's the sole
machine that supports all targets.

> variants or only some of them? If the latter why not convert those to




> DEFINE_MACHINE_EXTENDED and then only that macro needs to be changed with
> other wrappers passing a default value without needing a new parameter.
> That does not work if all machines need to do this but even then, keeping
> the macro and adding a new required parameter is better in my opinion as
> it keeps boiler plate hidden.

Another option is keep DEFINE_MACHINE and introduce DEFINE_MACHINE_TARGETS
and remove DEFINE_MACHINE_EXTENDED, and we only use DEFINE_MACHINE for
simple case,
that is parent is TYPE_MACHINE and have no custom type and no more
attributes assigned.
DEFINE_MACHINE_EXTENDED is too verbose, when calling it, it less clear
than calling to DEFINE_MACHINE.
And if we want to set more attributes to TypeInfo, just expand it to
use type_init or DEFINE_TYPES, how about this way.

This will be something like:

#define DEFINE_MACHINE_TARGETS(namestr, machine_initfn, targets) \
    static void machine_initfn##_class_init(ObjectClass *oc, const void *da=
ta) \
    { \
        MachineClass *mc =3D MACHINE_CLASS(oc); \
        machine_initfn(mc); \
    } \
    static const TypeInfo machine_initfn##_typeinfo =3D { \
        .name       =3D MACHINE_TYPE_NAME(namestr), \
        .parent     =3D TYPE_MACHINE, \
        .class_init =3D machine_initfn##_class_init, \
    }; \
    static void machine_initfn##_register_types(void) \
    { \
        type_register_targets(&machine_initfn##_typeinfo, targets); \
    } \
    type_init(machine_initfn##_register_types)

/* Implicitly insecure */
#define DEFINE_MACHINE(namestr, machine_initfn) \
    DEFINE_MACHINE_TARGETS(namestr, machine_initfn, QEMU_ARCH_ALL) \

As the many call is to DEFINE_MACHINE.

And after all conversion, all existing usage of DEFINE_MACHINE will be
converted to
DEFINE_MACHINE_TARGETS.
DEFINE_MACHINE will be called for ('none') machine or future heterogeneous
machines


Either way, these patches will be dropped. We will introduce
DEFINE_MACHINE_TARGETS first.

>
> Regards,
> BALATON Zoltan
>
> >
> > And the
> >    .instance_size =3D sizeof(MachineState),
> > is indeed not needed, they sharing TYPE_MACHINE's sizeof(MachineState)
> > is enough.
> > Even though DEFINE_MACHINE expands to .instance_size =3D
> > sizeof(MachineState), and it's redundant.
> > So I think convert to DEFINE_TYPES would be a good alternative to this
> > issue, less boilerplate(not none)
> > And dealt with the issue we faced.
> >
> > What do you think about this idea, BALATON
> >
> >>
> >> Regards,
> >> BALATON Zoltan
> >
> >
> >
> >



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

