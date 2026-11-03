Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD5606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pMLsxR1F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOEso-0005mQ-Sr; Tue, 03 Nov 2026 08:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOEsn-0005lZ-BX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:49:01 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOEsl-0007iy-71
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:49:01 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b10d24345dso37339987b3.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 05:48:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793713738; cv=none;
 d=google.com; s=arc-20260327;
 b=NErjayEGLSwUDM4lbRK5JKBOL0XewAslw8OTeP3h62b2SfpABtsFp3PzbGrl8cbRgC
 vDcHJl/jDYdHnSCOBLWsvHn9MWuXTKC+5qAJoL4yee/7CiIIIExs+bCBJdxYUtOHm+OK
 0G0o+Tw2zasxioyRuIE/pa893/c2t71V8ttmDY86T+LYG143w8LYMDJPo0jD8/5CNdFF
 VXKD9LpAAqoYCkcDpxHmCYA0EiA1PXlFFuRE+plkE13ybu2pxqi8bzcDM3qu3c4hsFxz
 h8ZEJmmM41lWY72c6O2hC0pSWZXvYK4YDsw0Q1Yn6X0COgyKNDjbbcP2syCA8QN0OdKN
 1swQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=VhJo4HokwhEWSYkNV3t4SWIVzwRlrhbcTP4O4ufZ8fc=;
 fh=FsEiPLRYD/7x9oFrcZOVs6ERQzH1mQWnxkZRTi50FZM=;
 b=fRFeKmr/SOcv0YoY8297TWCegxuwzE0TlU+CQ/Mp+hAgZsn5G6JMwMuupQ4tfyt0Yw
 pVyis/SQXne+Ur7A2i/4kcydvCzPfT9ilxZFWU79yLQyaX7DGau7JPWScw8y1RPALHuE
 XqGmHkW72/PXQbUs17OYbgnANkid/YIm+4NVDEDHPlqSY4dRr3CV0hOUaqvfVnCBbvCG
 lRZ2mm+/yZrTRav6YrOlUgD8iafKsMoc4ohqOFgehT/ydqw+MjmhescOsQrhPdQ2MeVU
 qf9tPdvt0c0QNqt/nNiykiOtZWkTAurQz4apvgew6h2hQJSJNq9+DB9btNxr9IK4t2Wh
 1giQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793713738; x=1794318538; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VhJo4HokwhEWSYkNV3t4SWIVzwRlrhbcTP4O4ufZ8fc=;
 b=pMLsxR1FKnaplSmBS8WrvMM0ngiR4z85glf8St+VvN/3hLcKEhM+cq4Dor5dg9GB1h
 qYDbXsxuLd2WalZ8zbHSboHsPGVmYUpTwrxSt6j0Ps9OrYriX/tQRxihN2H2XzB+/4NR
 1D+OaCjU4Wby2gXM1YTDWVlWrUJPDOC4Wz3QbWfQ0xBAOuu8CbctINmVWrRd8eolOJkK
 TwkkiIGLyhPZrfo6LeO2R7hOBBJZglE36BI1ct4rxHC5ARe3cL7gTWLZGH1c9QHzWSN1
 2jF/JC+9AGPADwsMGHSdXpxNlEh3LodQUBlg3P1kEKe31Y0r9n77VzoGFDBQg/mMhqqz
 HEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713738; x=1794318538;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VhJo4HokwhEWSYkNV3t4SWIVzwRlrhbcTP4O4ufZ8fc=;
 b=0A00DN8bbWW5+A7+s72988N3p37Zto4olkYyzkkwucDsdalBV4UneW1z7iZNAH0XQW
 sBOJWy2YdjWGHJ36xbpLACVmI8KvBZ3ri7faVagYwH6F7nmpiSDj4lbVooWw8AlY0xci
 A+iIU8lNlHPl210GymqZXIPFmP3iOLpp9qOw3/AeTSCOkcZA4A7S6/mEti2Q1G+7BDNv
 dZhhDvR3dzywDr8O1jZgyI4GVJCl+AZiqrpHdQSOC3cfLsgioZx7FXphn0CTR7VbScMk
 4DmPi1AIlNrG8tf1Jm1bFaN9eFMi6nSp9BPSJK5J02SYCjP6dLBs3x07aIjKPH5zU3ey
 jOZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzlMbRJepO/NyCgM0e8P6q66RXfe+8m3Gj2LRJnZODx2s2cj0DDH01UnDhGSLBD0b3+TNB9dUqWADv@nongnu.org
X-Gm-Message-State: APuU4Z+cn6SxP9k6+ngvnl0CBURtl2drK3/p3/0KiNK7TfUbhdokb/XF
 tvbLe3ukCU3IYfLZRq/zN/CvwX91E+GTofvFjwE1mrED5miat1okDOJKNhNhUTj+Yrx2kBlQoBx
 tQ3cbkh8u8bw04tlh9KBhjNCN165qB20=
X-Gm-Gg: AYBFou0GpJPey2vJeqRFTzLPF/db/7Gl99HXpH49OU7CmEIYTQpdvTOpQyVnwewfhWX
 /hpBBxjqsotDA2My9JGmKtWuZIyq38xJs9AT/QPM7eYgXWO3RXfAfJUKO1BamSVgmrC95Mgpfvp
 8DapTau5bfQ8FI9sgYgBKrZRypgwrSXjgsz66NAJAa1M8I4wdZbdICFJ95Il2DOmH3sMyLpuEAy
 KURO3LuTMkv4Ji6sh6uYoac84e02JHonmCk78yv3iEUFNgBpMBpdZ7uGnA6IkdXHYsTgtzqNn9y
 /HWp09SazXEWbun58t2iEiU4aQYETT3RONENl9AO6ouqb6CuV8f3RcLG4Wtt4e3Q3C4lFMHSmfR
 yLFMP7/GZjPhcG7w+tVpCtZqYjPK4z1qmUTa9IQ==
X-Received: by 2002:a05:690e:b89:b0:677:d251:ccd9 with SMTP id
 956f58d0204a3-67ba500f58dmr9210985d50.48.1793713737821; Tue, 03 Nov 2026
 05:48:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
 <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
 <aumYOBw-nKQAWdYK@redhat.com>
 <CAE2XoE8Xwevk523OfB+GgwbRu0iVnyD4VNOx81rj7J7F5aq=OA@mail.gmail.com>
 <54851326-3627-2b86-57d6-c338ed4e4b50@eik.bme.hu>
In-Reply-To: <54851326-3627-2b86-57d6-c338ed4e4b50@eik.bme.hu>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 3 Nov 2026 21:48:44 +0800
X-Gm-Features: AclHuK-kyxeFGeOmdxTnC2slmrHrvKR4DYxVNGXjAJzfbSHbPByoLDfveF6OVPE
Message-ID: <CAE2XoE_P2mZAT8wZwzFsTqJTK8nxNSSqJRrOM2T-AJkQjwJHBw@mail.gmail.com>
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=luoyonggang@gmail.com; helo=mail-yw1-x1134.google.com
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

On Tue, Nov 3, 2026 at 9:23=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
> On Tue, 3 Nov 2026, Yonggang Luo wrote:
> > On Tue, Nov 3, 2026 at 4:16=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> >>
> >> On Fri, Oct 30, 2026 at 05:51:44PM -0800, Pierrick Bouvier wrote:
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
> >>
> >> For each machine, it is only written once, but we add machines
> >> over time, and every time a new machine is added the code style
> >> is slightly different. We introduced all the variuos DEFINE_*
> >> macros for QOM to better ensure consistent style and usage as
> >> new code is added over time.
> >
> > I understand that the DEFINE_* macros are bloating because of this.
> > Indeed currently the only two macros used are "DEFINE_MACHINE" and
> > "DEFINE_MACHINE_EXTENDED"
>
> There are a few machines using some others but these are the most used.
> That suggests maybe we should change the convenience wrappers to match
> what machines need but DEFINE_MACHINE_EXTENDED is meant to be the one tha=
t
> allows all parameters which should be rarely needed.
>
> > ; each time people want to add a new attribute, the macros is twiced.
>
> Not necessarily. The SECURE parameter did that to preserve previous
> behaviour but if you add new parameter changing all callers (which is the
> same as expanding the macro that would also change all callers) then it's
> just a new parameter added not changing the number of DEFINE_MACHINE*
> wrappers. Rearranging the wrappers to make DEFINE_MACHINE_EXTENDED used
> less is an independent change.
>
> > And the usage of DEFINE_MACHINE_EXTENDED is rare and can be replaced
> > with DEFINE_TYPES or TypeInfo
> > and be more explicit. When we used as macro parameter, we need think
>
> But that defies the purpose of hiding the QOM boiler plate as much as
> possible. New people are confused by QOM and it's easier for them to look
> up documentation on the DEFINE_MACHINE* macros to see what parameter is
> what and not care about how it's stored in QOM TypeInfo or what is that
> at all.
>
> > what's that parameter means, and for
> > TypeInfo, we can directly know what that member is about(because we
> > are assigned with the member name).
>
> The parameter also has a name and documentation so it's not simpler to
> look up TypeInfo than look at the macro definition or docs. In fact it's
> harder to guess from TypeInfo as then you also need to get into QOM.
>
> > That's why I suggest keeping a single DEFINE_MACHINE, just like
> > DEFINE_TYPES; as they are the most
> > used macros(and simple enough), and won't suffer from changes much.
>
> That means exposing all the boiler plate for all machines other than the
> simplest case. I think it would be better to keep DEFINE_MACHINE_EXTENDED
> but maybe rethink the existing wrappers and drop unused ones and maybe ad=
d
> new ones that reduce the usage of DEFINE_MACHINE_EXTENDED but still keep
> the boiler plate hidden.

Thanks, I'll go this way, remove unused macros, and keep DEFINE_MACHINE_EXT=
ENDED
and extend both DEFINE_MACHINE_EXTENDED DEFINE_MACHINE supports
"targets" or "arch_mask" parameter.


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

