Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DD2C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4aaB-00083P-Gd; Tue, 15 Apr 2025 03:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4aa4-00082u-WF; Tue, 15 Apr 2025 03:19:41 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4aa3-0003HW-0H; Tue, 15 Apr 2025 03:19:40 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-523dc190f95so2504248e0c.1; 
 Tue, 15 Apr 2025 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744701577; x=1745306377; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjKyiPhOVXeVtdxzvUCltH49IDyVOBLNMtwAGWhXMEY=;
 b=jJSAi/7/F0ZGbzIspx5Q2bcHsgl9j/EGvcV+oI8SfQse9THVR36/H2ApC4oY4mDjx1
 eGRHs5LeqWfZEbStLGo/Vgpfok0lsyNK4VzScchbymyP8Xv3a1v8o6U2kxNxBV1v3wAE
 EuVRwFA2wbBsPh+WETvkg3MQtTnDMuvm9SRLS0ZqgZG8V4gK2MLvmnNjEnVhgqpIY8Q2
 vGM4DY3KBjOUGUcQkGzCeLd4dsx+YWoZ23839s25slrwr8qCVYIjZlC7+YJn6MKhULkq
 3W4+hsgfjVi0WtSN6hBIMubiuCDxErZb3rIITe5OhNjIo6MglkqJ2ULt0VQkilwMKYeC
 EPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744701577; x=1745306377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PjKyiPhOVXeVtdxzvUCltH49IDyVOBLNMtwAGWhXMEY=;
 b=K/+/FIC7RT5ah8SVbMEZZftNJGF+iuawh+Y0zG++iiN8cVC0iH5izlVhDi3e9GBETm
 7CEKlLylPudiFeR6xP0jqHFUgEBHEYRvuG031JtmbJHk/3PqvexvxVqvsbKb5m3lpcw5
 JTVHbVgcxiLoqchUBu+uDutdnyBkjT8oMx5vWYdrK355pc2qzxPnexrab1Sqe2uIBnbT
 sWAQPyKKJ64mdIttt3N9nkePWOgDunQF35YK7EmYWyPscWKRnYzzMFt8qEsL+SLNxVPv
 PFH39SoBGsU051qz9Ps7k+Ai7LC/PpymMVjlaFCkxGsb+Yrq/52M/mTKUb3bkG88Rylt
 q/Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfn/ze4EUYytlAd57t+ektuzuvAcxBBoYdKO6NAVnRUuYQwwvz4wD2FKjVvBfFiKNQ0/ZWUiO97enSs2g=@nongnu.org
X-Gm-Message-State: AOJu0Yz22XKkv8NvvI/6Tdm9fK2lTxCAE7fxQXCtqH3Ch6/9OuhPd1q2
 pH5GRtH7MsN8thYL4ExKwoATfLXcIlh6Trnrv8tE7B7JnKp/I4pEr4TJXi3MfRb1S5LGP8Ww5Tt
 FfCMg+FOTk0gyrPvbr2LXSr2vVv0=
X-Gm-Gg: ASbGncu48oBYtAg212UWfeFbI048M/ytG1FRZlbs6D+194AXZBlPWpR6bmi+eniVTO3
 Mw5Qib59G9ktYLi/Ck6wWNg4kSWyNUA4+L7ukiFVDvDfEhRFlsrn28gxK22Gbj6noTdKIHonLtj
 cR3wUAUCQWfoqqvnA+OS64lg==
X-Google-Smtp-Source: AGHT+IHX3wDisihZ5OL7kboy5j08XjUQWoOPquehAolAK0IGUj0Vq+GP+oxi+huGDr7rr8/LwtNPKw8s8B6bSVjsULo=
X-Received: by 2002:a05:6102:5f05:b0:4c5:505a:c1f5 with SMTP id
 ada2fe7eead31-4c9e505d56emr10280104137.24.1744701577363; Tue, 15 Apr 2025
 00:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250414034626.3491489-1-ziqiaokong@gmail.com>
 <20250414034626.3491489-2-ziqiaokong@gmail.com>
 <3c9e1adc-eb4e-49f4-be32-b273a5a161b8@linaro.org>
 <CAM0BWNCVU3GNqAe-stRRYytqC2H7G2iC8Wmpe3sz0u4kkUpYDg@mail.gmail.com>
 <CAM0BWND3dr=_nZHXSoV2jzkXPXd=hViX6vM0cUMZ2Uru+TD6GQ@mail.gmail.com>
 <c566eed5-605f-4aeb-8841-dae4e591fcb3@linaro.org>
 <CAM0BWNBNrjJ6UuF+TRtkuEesLatnY1pzSjyaiPVDeKSMF8no-A@mail.gmail.com>
 <CAM0BWNBGAJ-scbhXAQ2s2Y=w3WhJ5pR72xSA5Xf+bsbk73cL6w@mail.gmail.com>
 <7d2e61de-17da-4a6b-b9c8-2ff14fdce15f@linaro.org>
In-Reply-To: <7d2e61de-17da-4a6b-b9c8-2ff14fdce15f@linaro.org>
From: Ziqiao Kong <ziqiaokong@gmail.com>
Date: Tue, 15 Apr 2025 15:19:26 +0800
X-Gm-Features: ATxdqUGhEvIjjFY9lHRBO_Kx_c6E5PAPeqAn-5Ccfs4ay9z5_Hw4tQONOoPvntY
Message-ID: <CAM0BWNCOYwNZjD4h2XgEesV-HJYbDhapqfPYDcMm+U90PeU-vA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv: fix endless translation loop on big
 endian systems
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org, 
 alistair.francis@wdc.com, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=ziqiaokong@gmail.com; helo=mail-vk1-xa31.google.com
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

Hello Philippe,

On Tue, Apr 15, 2025 at 3:15=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 15/4/25 09:04, Ziqiao Kong wrote:
> > Accidentally not cc all recipients. Sorry for the confusion. Below is
> > the duplicated message:
> >
> > Hello Philippe,
> >
> > On Tue, Apr 15, 2025 at 1:38=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> >>
> >> Hi,
> >>
> >> On 14/4/25 18:59, Ziqiao Kong wrote:
> >>> Hello Philippe,
> >>>
> >>> Any further concern regarding this series? I certainly would like to =
investigate
> >>> and help =3D).
> >>
> >> Short term I can't keep looking because I'm busy with other stuffs and
> >> tagged this patch for another review, because there is some endianness
> >> code smell in get_physical_address(). I understand your change fixes
> >> your issue, but I'm skeptical about it, in part because there are no
> >> such use in the whole code base. My change suggestion is just a starti=
ng
> >> point, more is needed.
> >
> > Thanks for responding.
> >
> > Actually, the pattern of this usage is actually very common in the code=
 base and
> > that's why I fixed in this way. Sorry I should have put this in the
> > cover letter to
> > justify my fix. Below is an incomplete list of the code using this patt=
ern:
> >
> > - target/i386/tcg/system/excp_helper.c:129
> >
> > if (likely(in->haddr)) {
> > old =3D cpu_to_le32(old);
> > new =3D cpu_to_le32(new);
> > return qatomic_cmpxchg((uint32_t *)in->haddr, old, new) =3D=3D old;
> > }
> >
> > - target/arm/ptw.c: 840
> >
> > if (ptw->out_be) {
> > old_val =3D cpu_to_be64(old_val);
> > new_val =3D cpu_to_be64(new_val);
> > cur_val =3D qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val=
);
> > cur_val =3D be64_to_cpu(cur_val);
> > } else {
> > old_val =3D cpu_to_le64(old_val);
> > new_val =3D cpu_to_le64(new_val);
> > cur_val =3D qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val=
);
> > cur_val =3D le64_to_cpu(cur_val);
> > }
>
> Doh OK...
>
> >
> > You might want to do a `grep -rn "qatomic_cmpxchg" .` to see all matche=
s.
> >
> >
> >>
> >>>
> >>> Bests,
> >>> Ziqiao
> >>>
> >>> On Mon, Apr 14, 2025 at 7:17=E2=80=AFPM Ziqiao Kong <ziqiaokong@gmail=
.com> wrote:
> >>>>
> >>>> On Mon, Apr 14, 2025 at 6:41=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> >>>> <philmd@linaro.org> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> On 14/4/25 05:46, Ziqiao Kong wrote:
> >>>>>> On big endian systems, pte and updated_pte hold big endian host da=
ta
> >>>>>> while pte_pa points to little endian target data. This means the b=
ranch
> >>>>>> at cpu_helper.c:1669 will be always satisfied and restart translat=
ion,
> >>>>>> causing an endless translation loop.
> >>>>>>
> >>>>>
> >>>>> Cc: qemu-stable@nongnu.org
> >>>>> Fixes: 0c3e702aca7 ("RISC-V CPU Helpers")
> >>>>>
> >>>>>> Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
> >>>>>> ---
> >>>>>>     target/riscv/cpu_helper.c | 4 ++--
> >>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >>>>>> index 6c4391d96b..bc146771c8 100644
> >>>>>> --- a/target/riscv/cpu_helper.c
> >>>>>> +++ b/target/riscv/cpu_helper.c
> >>>>>> @@ -1662,9 +1662,9 @@ static int get_physical_address(CPURISCVStat=
e *env, hwaddr *physical,
> >>>>>>                 target_ulong *pte_pa =3D qemu_map_ram_ptr(mr->ram_=
block, addr1);
> >>>>>>                 target_ulong old_pte;
> >>>>>>                 if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
> >>>>>> -                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, p=
te, updated_pte);
> >>>>>> +                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, c=
pu_to_le32(pte), cpu_to_le32(updated_pte));
>
> Then don't we need:
>
>      old_pte =3D le32_to_cpu(old_pte);
>
> >>>>>>                 } else {
> >>>>>> -                old_pte =3D qatomic_cmpxchg(pte_pa, pte, updated_=
pte);
> >>>>>> +                old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_le64(p=
te), cpu_to_le64(updated_pte));
>
>      old_pte =3D le64_to_cpu(old_pte);
>
> ?

Note old_pte is no longer used later (it is defined within the scope here) =
and
dropped immediately after qatomic_cmpxchg so we don't need that extra bswap=
.

>
> >>>>>>                 }
> >>>>>>                 if (old_pte !=3D pte) {
> >>>>>>                     goto restart;
> >>>>>
> >>>>> If PTEs are always stored in LE order, maybe what we want is earlie=
r:
> >>>>>
> >>>>> -- >8 --
> >>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >>>>> index 619c76cc001..b6ac2800240 100644
> >>>>> --- a/target/riscv/cpu_helper.c
> >>>>> +++ b/target/riscv/cpu_helper.c
> >>>>> @@ -1464,5 +1464,5 @@ static int get_physical_address(CPURISCVState
> >>>>> *env, hwaddr *physical,
> >>>>>             if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> >>>>> -            pte =3D address_space_ldl(cs->as, pte_addr, attrs, &re=
s);
> >>>>> +            pte =3D address_space_ldl_le(cs->as, pte_addr, attrs, =
&res);
> >>>>>             } else {
> >>>>> -            pte =3D address_space_ldq(cs->as, pte_addr, attrs, &re=
s);
> >>>>> +            pte =3D address_space_ldq_le(cs->as, pte_addr, attrs, =
&res);
> >>>>
> >>>> Unfortunately, this doesn't work in two ways:
> >>>>
> >>>> 1. Note pte is used in the following code and that means pte must ho=
ld
> >>>> a correct value from the
> >>>> view of host endian (in my case, big endian not little endian).
> >>>> 2. address_space_ldq_le will dispatch to ldq_le_p, while
> >>>> address_space_leq will dispatch to ldq_p.
> >>>> However, on little endian targets, ldq_p is an alias of ldq_le_p so
> >>>> making no effects.
> >>>>
> >>>> Per my testing, this patch doesn't have any effect indeed. To have a
> >>>> brief view what is happening,
> >>>> see the logs just before atomic_cmpxchg:
> >>>>
> >>>> pte_pa 0xf14000000000000 =3D=3D pte 0x140f ? updated_pte 0x144f
> >>>>
> >>>>>             }
> >>>>> ---
> >>
>

