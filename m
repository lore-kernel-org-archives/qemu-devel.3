Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD49606D820
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NbMGxAYe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFLI-0004ct-Vv; Tue, 03 Nov 2026 09:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOFL8-0004c8-Rs
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:18:19 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOFL4-0002ob-W6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:18:18 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-676804a3a22so3411328d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 06:18:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793715486; cv=none;
 d=google.com; s=arc-20260327;
 b=V9JhQW//qBBdWm0VgB39V5qmSP4y2zzQlAbE2VtujyvxWoPnAvfI/mq2pTLJGOhEd0
 ogPJxZC96krbfNsKabz3Yi179VGq+U3/LNS76QfVyWIoMW/GReaXpNBKx/3tnPXcq9SO
 B8qRHFtke9qquodynfYM/AK2SpwlBYY735REDkrsydviN1dazy6mOfLcNSK4BX6H6m8m
 DysjqZ2JOvv1hQkTwAuauL/V/T+c8AKF59anuuE90zSOARQ87DiYZ4UHdazqGvbXvB7B
 9X87pRF758juCsGisozSCgB7QA8dFqsAkEnCoJWfW4YrU6fP3v/k0mOYgO1YvZJH14bG
 iQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=DrlFZ8OwnA0TZT2cK4MNtmqKlz1PKYoO5uN1djvDVsg=;
 fh=9AKim2lswK2vLKa40WbQhJPAT0Lp7VHZAEyazbKtkrg=;
 b=BXxewc0TOI53gq4+92Du8LrwYa84OWT1JvzQgs0eHCFq8Uy07e7yNzAKtiDrTbsBh6
 x0YxJsO7AwfLcmPnAnVyz8XfCVhKAvdd7w/Bkc8Ru5p+Lfem0NfEruK6uV6tgKr5eU/k
 3AWXFTJqiTjahmE1hqmEUXMh5sX8Ds4Ep1tuZ+8SfdQpr8y4BhjjNkeNW0Mb3bt6tBBB
 6nkudYl+5QXf67oDPwTchrRzKAZ/OoVcjmG3SiQF8MhXaowpVwRxW6iNHGci2065KDvS
 m0aYmD+bCodMr2gfLWyojFugPaYVZ2lhsiDTK7DxgEMdPyQtvwJoNoV0H6MgIvxollDZ
 4IGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793715486; x=1794320286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DrlFZ8OwnA0TZT2cK4MNtmqKlz1PKYoO5uN1djvDVsg=;
 b=NbMGxAYeMCaJwRaY1d1l2TppHYYZHCzWUAYhtSKX83V6LNT9lfGLfpzgefZtXN2ROJ
 aT6LDhnnl/TxoPC5HODYfbSrfxYTd3PIsAt1fz+JBuufuvqSTQL4E/Rn3zLdw5wVHmXe
 yEiG16Z7wexSH2jzpM87zOgPHFfpTfoDhh+zDZ7mc47bmM3Qc9YPNW5KJI994xshBx2k
 Lu+IyYKS+75iwQOULKUiLQiHr8Wp4VJ+NrSl864v/zfrnnvIKncVqwzm0oNtLAodoTXS
 zhJHU56hlCsflqGi46vSoQQF/rBWe7cUjKZ7fx6YQ0fBVfNEo6x/iU/FSNJHj/6kqVrF
 V2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793715486; x=1794320286;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DrlFZ8OwnA0TZT2cK4MNtmqKlz1PKYoO5uN1djvDVsg=;
 b=JqTM+CpVv3M+c+S0xVK7CNO5FBQcDucQrUNh1VhM3FqUnCsj6mfeC6aerGCN4sBy51
 D9BQug3PfovYUtltOWksAY1etEobm+VYlfMXdVdNN8XGO+7KCbd5uJSgGCw/vwvLIn5P
 hP47Vf+xGNXi3/VodtxYIEdjxIGfpVB/6y/XlkmhupiVYdEMDLLqhlG36tJnfMgThzsg
 zGtGe9455YXkv86kdfrNIC1Ih39AydvV5iBaRJdeosDD55u8s6KJf1QbCPu5CfAovvYh
 4Cw+pp6F/0HddER8sF9DMyBLpLzdwYr5Nm3q8HPA2nBt8o0E/2UaHXWORlIXwZy1I/Dj
 foFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwj0VrRxP4WSI+VPFOJ/vGDAhOZ4yB43t/hHzqya7AAv+wzuYN/ohEfhcSJZo4xIzEWRTfLmhEX++8D@nongnu.org
X-Gm-Message-State: APuU4Z+auT9ULKahKGyARRc0t7Zl0daEwEqBNqYKBG7e2mQt5n+vYDnb
 7ctVkoth3vyR0TlroWfKSFhyGKKIVgCh6THCt2IlFQFI6eSCWJCfEKY8S2x0RNSjLqAFzThQPJf
 gH0NLboNExvnNjU/HtIbgiA+NcyaE7qA=
X-Gm-Gg: AYBFou3r/7auMaxSnO05Dt0zkq86bdhsdgallUXHFJKNnMqOHPee0Z5dpJsB38iI+Fq
 U6QcVxy5ZK5kTcb/sG76QBIoQhox1RRTAGFRah6cQWRcpxTikPqJxD89QPT0oPSNpTZmkix9QH5
 +wfz7GGjNKn/ac4oXN/u4ifeofFYmXCzhgU/+xAqoDadbNaQmb31fhawR4PazcEIo4ONOTc0Igt
 bALDGfRJuPkRBtKUwR4cCcgM5vjlnIFlr426qNbcd0GGaov/qKMlRCq3QI09Asg6lrCLAVipZll
 dFJAVsa6VVp9hmTccnWC5iDHQvd+zVsJgHN/lzoYvpFEUI+5UVGHqJOUe0/FvnfP0Yc3dbt338A
 yxPd9nCXKLVlkeZqas5kT8eYLMWtnFyZtdVVk
X-Received: by 2002:a05:690e:1288:b0:67a:2a60:355a with SMTP id
 956f58d0204a3-67ba50cf3f3mr9964430d50.94.1793715486001; Tue, 03 Nov 2026
 06:18:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
 <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
 <aumYOBw-nKQAWdYK@redhat.com>
 <CAE2XoE8Xwevk523OfB+GgwbRu0iVnyD4VNOx81rj7J7F5aq=OA@mail.gmail.com>
 <54851326-3627-2b86-57d6-c338ed4e4b50@eik.bme.hu>
 <CAE2XoE_P2mZAT8wZwzFsTqJTK8nxNSSqJRrOM2T-AJkQjwJHBw@mail.gmail.com>
 <aunnuwhsx9ZOOXBX@redhat.com>
In-Reply-To: <aunnuwhsx9ZOOXBX@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 3 Nov 2026 22:17:50 +0800
X-Gm-Features: AclHuK9FwIlA9RQMifRxUKLKMCqA8pdJuRMt5xIisjyLT66i66IA7_a2r-8WMT8
Message-ID: <CAE2XoE974tDG8fd6A_SGqwwXiAAjWTF37MCGm4Qo2-DbBQxjnw@mail.gmail.com>
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=luoyonggang@gmail.com; helo=mail-yx1-xb132.google.com
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

On Tue, Nov 3, 2026 at 9:55=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Tue, Nov 03, 2026 at 09:48:44PM +0800, Yonggang Luo wrote:
> > On Tue, Nov 3, 2026 at 9:23=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.=
hu> wrote:
> > >
> > > On Tue, 3 Nov 2026, Yonggang Luo wrote:
> > > > On Tue, Nov 3, 2026 at 4:16=E2=80=AFPM Daniel P. Berrang=C3=A9 <ber=
range@redhat.com> wrote:
> > > >>
> > > >> On Fri, Oct 30, 2026 at 05:51:44PM -0800, Pierrick Bouvier wrote:
> > > >>> On 10/30/2026 4:09 PM, BALATON Zoltan wrote:
> > > >>>> On Fri, 30 Oct 2026, Yonggang Luo wrote:
> > > >>>>> DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo an=
d the
> > > >>>>> type_init
> > > >>>>> function that calls type_register_static(). A later change need=
s to
> > > >>>>> pass a
> > > >>>>
> > > >>>> That's the point of the macro to hide the boiler plate code.
> > > >>>>
> > > >>>>> target mask into that registration, and the macros have no para=
meter
> > > >>>>> for it.
> > > >>>>
> > > >>>> Couldn't you just change the macros to take that parameter inste=
ad of
> > > >>>> expanding it everywhere?
> > > >>>>
> > > >>>
> > > >>> Problem of macros is that they don't have default parameters, so =
you
> > > >>> need variants for everything:
> > > >>>
> > > >>> DEFINE_MACHINE
> > > >>> DEFINE_MACHINE_EXTENDED
> > > >>> DEFINE_MACHINE_WITH_INTERFACES
> > > >>> DEFINE_MACHINE_WITH_INTERFACE_ARRAY
> > > >>> and now would need a new variant, with variant for other existing=
 ones.
> > > >>>
> > > >>> In the end, it's just simpler to remove this and add the boilerpl=
ate.
> > > >>> It's written once and never modified, so using a macro just save =
typing
> > > >>> those lines once.
> > > >>
> > > >> For each machine, it is only written once, but we add machines
> > > >> over time, and every time a new machine is added the code style
> > > >> is slightly different. We introduced all the variuos DEFINE_*
> > > >> macros for QOM to better ensure consistent style and usage as
> > > >> new code is added over time.
> > > >
> > > > I understand that the DEFINE_* macros are bloating because of this.
> > > > Indeed currently the only two macros used are "DEFINE_MACHINE" and
> > > > "DEFINE_MACHINE_EXTENDED"
> > >
> > > There are a few machines using some others but these are the most use=
d.
> > > That suggests maybe we should change the convenience wrappers to matc=
h
> > > what machines need but DEFINE_MACHINE_EXTENDED is meant to be the one=
 that
> > > allows all parameters which should be rarely needed.
> > >
> > > > ; each time people want to add a new attribute, the macros is twice=
d.
> > >
> > > Not necessarily. The SECURE parameter did that to preserve previous
> > > behaviour but if you add new parameter changing all callers (which is=
 the
> > > same as expanding the macro that would also change all callers) then =
it's
> > > just a new parameter added not changing the number of DEFINE_MACHINE*
> > > wrappers. Rearranging the wrappers to make DEFINE_MACHINE_EXTENDED us=
ed
> > > less is an independent change.
> > >
> > > > And the usage of DEFINE_MACHINE_EXTENDED is rare and can be replace=
d
> > > > with DEFINE_TYPES or TypeInfo
> > > > and be more explicit. When we used as macro parameter, we need thin=
k
> > >
> > > But that defies the purpose of hiding the QOM boiler plate as much as
> > > possible. New people are confused by QOM and it's easier for them to =
look
> > > up documentation on the DEFINE_MACHINE* macros to see what parameter =
is
> > > what and not care about how it's stored in QOM TypeInfo or what is th=
at
> > > at all.
> > >
> > > > what's that parameter means, and for
> > > > TypeInfo, we can directly know what that member is about(because we
> > > > are assigned with the member name).
> > >
> > > The parameter also has a name and documentation so it's not simpler t=
o
> > > look up TypeInfo than look at the macro definition or docs. In fact i=
t's
> > > harder to guess from TypeInfo as then you also need to get into QOM.
> > >
> > > > That's why I suggest keeping a single DEFINE_MACHINE, just like
> > > > DEFINE_TYPES; as they are the most
> > > > used macros(and simple enough), and won't suffer from changes much.
> > >
> > > That means exposing all the boiler plate for all machines other than =
the
> > > simplest case. I think it would be better to keep DEFINE_MACHINE_EXTE=
NDED
> > > but maybe rethink the existing wrappers and drop unused ones and mayb=
e add
> > > new ones that reduce the usage of DEFINE_MACHINE_EXTENDED but still k=
eep
> > > the boiler plate hidden.
> >
> > Thanks, I'll go this way, remove unused macros, and keep DEFINE_MACHINE=
_EXTENDED
> > and extend both DEFINE_MACHINE_EXTENDED DEFINE_MACHINE supports
> > "targets" or "arch_mask" parameter.
>
> Given that we don't need to do general per-arch type filtering in
> QOM, we could just move 'is_available' out of TypeInfo, and into the

We do need general per-arch type filtering, not only the Machine,
Device also suffer from
this. So are the CPU QOM objects. Here the MR needs that
https://lore.kernel.org/qemu-devel/20261031164009.2048-1-luoyonggang@gmail.=
com/

And the add targets/arch_mask to
DEFINE_MACHINE_EXTENDED/DEFINE_MACHINE is for removing 'is_available'
latter, as is_available has restriction that can not works well for
target_heterogeneous


> MachineClass, so it is a regular class level property, which can be
> set in the class_init methods, and thus avoid any changes to the
> DEFINE_MACHINE macros.
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

