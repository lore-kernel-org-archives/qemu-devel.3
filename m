Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62625606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjxLxAl0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtpw-00058Z-LJ; Tue, 27 Oct 2026 22:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLtpv-00058R-2L
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 22:56:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLtpt-0001tL-7V
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 22:56:22 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b413b0a974so795893a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793156180; cv=none;
 d=google.com; s=arc-20260327;
 b=KMIjsc8+br+7jpTUqimGfiH3/zO7yuQPZUNE7vKJpJ7+uCgtdACoKI3+J1x6rGapst
 xrcdhaf0edpYcBTy2gwS4pKlG4bvnX6y4sHhLzC7dZCVtcHlvL0yPnYE/aoMzgKTFHkn
 8ojCTN8dpPJeB1S3NvQNgQP1fjndJ4UsJk+HykhWYwee2wDprf+UVUOzlvXqOtR14bRB
 aRjNRXaWmF94JUZUaFB84QMyAnp/QAoKrPgEaQdFVC12gypLgZlUKvTLO+IRKkNyRvhR
 QS4HRxFs3HYxNdGHSUJKqZlz9WQlmOwUoZG4ByP8ZGmtm9QNdG1aGWbrGylyhLcnoFzo
 G4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=iraMBC7b6bC/Ea6LJ81I7eKv90rsp5NsmR3Z3oqfETs=;
 fh=ANMbBlJElToxpd1b8GeaZc/x37GWepENn3silVxk46s=;
 b=sXQfRZeJdY1PBKhWT26SSmHhU36AMKJidAj4wFdX1HVIeWBS3WnvgyHWWDaKzvvj/A
 mLJNbMVUNg8FzaCz2oRU/0E8CaQtPs6pZHw9KsGjg1g24yi83sp9fUgGL85oXN8QXFEd
 deLDudXCbgw9r6LAtj6eHbF4q6hYPU4hvQXRPD00UeCBfs090OoOAygHeQluwhHUBUz0
 SQxr1UNARDVsbO/1xJYs9GdefPGfsidNMAwIjSc9xuo14LjlOBCNbWcoBk4erpn1QuEy
 j/o+9WHKUiFVHof+mVHeB4SYOcGIqlbInkmScLPu4jQbfTXiQ6Z8QkIHORPvD5GabTS5
 iQHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793156180; x=1793760980; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iraMBC7b6bC/Ea6LJ81I7eKv90rsp5NsmR3Z3oqfETs=;
 b=NjxLxAl0qnOjbEg43ZmxES2Egy08kqsdo+9bADLntPkNTia4ZviFXSKn+OZKSDuLH3
 wzH/x4jqvyHlkh9+CDCpX2VW3axvRsQFlGWO/URG0CmiFs1tQZuF5wGSIs2Zk5L+iIyr
 vZkPlVLcQKamY1zbrDAyoHJLP3FOmlzvKCI6VdVsgu22Rp3RjneB+ED+p5+i+EMkuuMt
 46VIuiib+PgXlukjsD27iMfDuHSZ730bQm1qpFkAzlHsKIOH+Qo4WQceLGOYQQXHbeQA
 EaRW1jlv4jMxWEWtc1jH20P01ZynIOIyEN19cfEg9qmtVhc9mZa4bEP7ZY2spereq/Bm
 VE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793156180; x=1793760980;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iraMBC7b6bC/Ea6LJ81I7eKv90rsp5NsmR3Z3oqfETs=;
 b=e08Qrtr7JEQMijn+elCovfi+qWiYYSfyJytrTEfDh9RfvMxrr5qcz++BL7PeTE305h
 FyyQv8saXIez3VOXBF1+1wXTR1iquQNf3nOULkaNoprvnTpWj0KWWYdEAEF9U1BZjk3z
 jskwIqZnP30aVdtzUqLYzEyXywIqrfOMk6lbZCpdbsqVUdEj7Q/qLrsrNiFTvtPFM2aH
 jUWHVFRW947VgHQAXpGUeaC6KUj7gUlGf916AYA4feuWz645s39lrNZHrnTZ7VNhz/Jb
 HKBikMWtf5rINU3vxgaieRSxjQPC2HpDhxw9EppTziwDAfqmwUOeJCbQH65kgkK7WGcM
 rbBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7/3UMjUrrX3CsR2PsuV5CcdJ1IThkKbQ7xqR+EOjp4XvQAIh33FTcvzrrce1e0xe89baemWLzdza1@nongnu.org
X-Gm-Message-State: AFq9FYKvT3xmFVnPgVb1YBPGAktxlQ7KgldMSPmElm99tpML/bJKj5in
 7nZmSVIujJBS2a1tLWqBf3Ew0GQE1znckHJ0KoGXrf8lhGBsl2ryw8aNem0u6/KeLOoS82m9bKi
 xUNN5xJt0op+el3t97I099xEtZ0PT5Bo=
X-Gm-Gg: AYBFou2ufMOhCGvz+HXNlj8GWxgdzEX/EiplXgRQEkpGL4IVIEJWEmrwoDxPUluYRnG
 QCPEAy1MieCVZzwkDGqciDRPQkBM96eW0HgNi5HEbECJ+X3rLD5J2TNuAR+5Z8CgFMBH9+Kl90G
 sI8i8OPJ1D/aNy3u5Osat4UNHsrgD1aozb4OffPP/sifgjrhNMIiqohOk+RTv1LKRQVunitolnu
 TdMdg0Rb8+6yCR3/bQbRAv6raTlwMiV1IfxEWW7x7VxAsJzs/V8u+PrUrVrgNScEN7WuoQKD6ki
 2M1I0MRhYUEwNeuh4lFC8NKUYcwSin2UstFnPraTIWtZx3LSSXofBlKzMI+VNK7livU/BW/p1E0
 pcnNt1s9/ajmiQw9/nWQX0uqEXQjloAnZHzIB
X-Received: by 2002:a05:6402:158f:b0:6b1:ba86:5f48 with SMTP id
 4fb4d7f45d1cf-6b49cb8e221mr478414a12.36.1793156179444; Tue, 27 Oct 2026
 19:56:19 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013195606.152-1-luoyonggang@gmail.com>
 <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
 <CAE2XoE828e76zdCEkYVcbjRwhcsaSYZF1_UE4akeaoCTqCK3zg@mail.gmail.com>
 <baf81ba3-f29f-48f0-a9a2-6dc4f005d433@oss.qualcomm.com>
 <CAE2XoE9L8tuhU2nieJ8D=Cz9svS=W3oqAH+j30RGtZibjp1G=Q@mail.gmail.com>
 <bb979f8e-1372-4be4-814e-aa5dcb09942a@oss.qualcomm.com>
 <CAE2XoE-RcE24+9BNTSUD08QT1ECdbZm464YHiDQ4JJ4xpOE4Ww@mail.gmail.com>
 <CAFEAcA_sSTSR-J2p1C-euCsOCr0dCvQ3RJU0fr5pDa5QPKjiig@mail.gmail.com>
 <00d8ad3f-5a5a-4e3f-9656-1e2df124011a@oss.qualcomm.com>
In-Reply-To: <00d8ad3f-5a5a-4e3f-9656-1e2df124011a@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 28 Oct 2026 10:56:07 +0800
X-Gm-Features: AclHuK-afJ9C2vmrWLupnIqJVZvhwcGXR7O8DnfWWUTzS9EUq-uAN7p02Fsx2hM
Message-ID: <CAE2XoE81ZQy=xutiCTBvJnCZpjho8c_7wy+8osxjcfm3bq2uxg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x532.google.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 1:44=E2=80=AFAM Pierrick Bouvier

<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/27/2026 6:05 AM, Peter Maydell wrote:
> > On Tue, 27 Oct 2026 at 13:06, Yonggang Luo <luoyonggang@gmail.com> wrot=
e:
> >>
> >> On Wed, Oct 14, 2026 at 5:37=E2=80=AFAM Pierrick Bouvier
> >> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>
> >>> On 10/13/2026 2:30 PM, Yonggang Luo wrote:
> >>>> On Wed, Oct 14, 2026 at 5:07=E2=80=AFAM Pierrick Bouvier
> >>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>
> >>>>> On 10/13/26 1:19 PM, Yonggang Luo wrote:
> >>>>>> On Wed, Oct 14, 2026 at 4:08=E2=80=AFAM Pierrick Bouvier
> >>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>>
> >>>>>>> On 10/13/2026 12:56 PM, Yonggang Luo wrote:
> >>>>>>>> This is for avoid "max-v8" qom name conflict in multi-target qem=
u
> >>>>>>>>
> >>>>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>>>>>>> ---
> >>>>>>>>   target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
> >>>>>>>>   1 file changed, 13 insertions(+), 4 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-ma=
x-v8.c
> >>>>>>>> index 65f851f2006..d7323ab431c 100644
> >>>>>>>> --- a/target/arm/tcg/cpu-max-v8.c
> >>>>>>>> +++ b/target/arm/tcg/cpu-max-v8.c
> >>>>>>>> @@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj=
)
> >>>>>>>>   #endif
> >>>>>>>>   }
> >>>>>>>>
> >>>>>>>> +static void max_v8_tcg_initfn(Object *obj)
> >>>>>>>> +{
> >>>>>>>> +    if (target_aarch64()) {
> >>>>>>>> +        aarch64_max_v8_tcg_initfn(obj);
> >>>>>>>> +    } else {
> >>>>>>>> +        aarch32_max_v8_tcg_initfn(obj);
> >>>>>>>> +    }
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>   static void cpu_max_v8_register_type(void)
> >>>>>>>>   {
> >>>>>>>> -    static const ARMCPUInfo max_v8[2] =3D {
> >>>>>>>> -        { .name =3D "max-v8", .initfn =3D aarch32_max_v8_tcg_in=
itfn },
> >>>>>>>> -        { .name =3D "max-v8", .initfn =3D aarch64_max_v8_tcg_in=
itfn },
> >>>>>>>> +    static const ARMCPUInfo max_v8 =3D {
> >>>>>>>> +        .name =3D "max-v8",
> >>>>>>>> +        .initfn =3D max_v8_tcg_initfn,
> >>>>>>>>       };
> >>>>>>>> -    arm_cpu_register(&max_v8[target_aarch64()]);
> >>>>>>>> +    arm_cpu_register(&max_v8);
> >>>>>>>>   }
> >>>>>>>>   type_init(cpu_max_v8_register_type)
> >>>>>>>
> >>>>>>> It works for the current need, but will require further changes f=
or
> >>>>>>> heterogeneous emulation. A more versatile solution could be:
> >>>>>>>
> >>>>>>> arm_cpu_register(&aarch32_max_v8, target_arm);
> >>>>>>> arm_cpu_register(&aarch64_max_v8, target_aarch64);
> >>>>>>
> >>>>>> And another way to handle it is like x86. it's comes with two vari=
ant for
> >>>>>>
> >>>>>> #ifdef TARGET_X86_64
> >>>>>> #define TYPE_X86_CPU "x86_64-cpu"
> >>>>>> #else
> >>>>>> #define TYPE_X86_CPU "i386-cpu"
> >>>>>> #endif
> >>>>>>
> >>>>>> This also solves this issue, which looks more straightforward. no =
need
> >>>>>> .targets magic for CPU.
> >>>>>> Anyway, maybe the best way is to merge "x86_64-cpu" and "i386-cpu"
> >>>>>> into a single cpu type and
> >>>>>> add .targets magic? When I am trying to get x86 works, faced this =
issue
> >>>>>>
> >>>>>
> >>>>> This solves including i386 or x86_64, but not including both at the=
 same
> >>>>> time. Same goes for arm vs aarch64.
> >>>>>
> >>>>> You can take a look at git history in target/arm, to see which kind=
 of
> >>>>> changes we did to make arm and aarch64 targets linkable. You'll not=
ice
> >>>>> most of the work was to remove (a lot of) #ifdef TARGET_X.
> >>>>
> >>>> See it
> >>>> SHA-1: ec7e5a90fea996f04ea24e81b680a87bc975354a
> >>>> * target/arm: Remove TYPE_AARCH64_CPU
> >>>>
> >>>> So I am just doing just the reverse direction, I am fixes x86_64 in =
a way that
> >>>> register both "x86_64-cpu" "i386-cpu" variants, though this way seem=
s
> >>>> more suitable
> >>>> for your heterogeneous emulation, but we need to register
> >>>> everything(CPUs) twice.
> >>>
> >>> We'll have to register this twice anyway for heterogeneous, I don't s=
ee
> >>> any other solution to have both accessible at the same time. That sai=
d,
> >>> we are not yet there, and current patch solves the actual problem of
> >>> having QOM types registered twice.
> >>>
> >>> I'll let Peter say what he thinks about this.
> >>
> >> Hi Peter, what's your suggest about this?
> >
> > I don't really have a preference here as I haven't been following
> > the heterogenous work that closely. I'm happy to go with whatever
> > Pierrick / Philippe think makes sense.
> >
>
> Ok. In this case Yonggang, let's go with two max types, each with on
> init function, and using is_available to register the right one.

Good, now I somewhat know how to do it in two max types now. I'll try
to prototype
the idea first

>
> Regards,
> Pierrick



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

