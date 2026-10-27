Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A50606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gypHITNa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLgt9-0007p6-Mr; Tue, 27 Oct 2026 09:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLgt6-0007ov-6N
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 09:06:48 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLgt2-0005Kp-A8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 09:06:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so7188262a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 06:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793106400; cv=none;
 d=google.com; s=arc-20260327;
 b=nQfzzm4g+sTzgMrc0u8D4IgjehIfQBLcGTuXbDzN861kmDvniN7itzb/Uvxs84MnBB
 yguGZby4R/TIRco1flRokL0JW3hch4Q7OsEcIupJVqNd6hIbKzts9EZD0P+S+DsQPVkX
 Sgmz170TtnutB1FmGt+1zBdwKjPJNBt98i57FHNJbAwic5FdkaOjC7oh0q22ATiwnTE9
 GnAwP8uKxKhZZGezexUpE/pyeRX7twUYNUxlSFgMtgydsKWwzU/ylnfIxXwDb1gs8g32
 G+RZeFpf8swNeq60nBUQWh9Aiew6e5Ane0yo8AInAwZKwkB/M/okMMfNaEkYnu4F2MEV
 9R1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=nNCCpcY9seP+WQyZ1YKoKkqfU69q1FwbdZ21A/Nmb8A=;
 fh=MPecqsMkaRSl3GhOUqX93KZ8cCVU8vKIFsgDrs5S8Kg=;
 b=rlajI2XjWXscQ0DA8Kz4t0tR6qxU/TqYtYiw6Yylkdl4GeXRZTp6PWddRbkViHEeX8
 qm+ZxzhfEEV3B4tUTxiD7b/GeRm45EBxZZyQEMYEt8TWkw586D3dxpK/8ILOlwA8kC0M
 UdQtwTZ0HSZtYvAIu9HyH8JvgwgPt0icNMVr0ojWWiITk7fYL4D7CutmOx8c1nT+Zwud
 PxlRrYJsFnyiLjt5IrzPsua44m/LjD7fEqXv7SVrIyMumhQz02+wcq0NS5fEZI5zX26J
 N+8jOonGdaoeZkVi2LFUZS3iCpV/666hYxdVJqLbzyXmuNwb5ABvNqemyqYm9hrCud5y
 8ekQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793106400; x=1793711200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nNCCpcY9seP+WQyZ1YKoKkqfU69q1FwbdZ21A/Nmb8A=;
 b=gypHITNajASU/jjjpf9zvyzAQw5XGpBhsvygsurOuaKd6E28wn8sfUe90k4r22xzpJ
 OhtluCDzSSEW81EPL7zb4OpPqrjJjqja8Qj7AwLl2ktYlvUFTcRGQkKqj6pOtAnuM0xk
 QO8MC5s/U1LmrP90CAoRupF67o4idlgxwo+nJGJDaPEdt6tvLyNT2ZP5Ec70N/grhiBO
 SNV8YmqkfFpphcgJpfXxl3zTmi3F53kXBgIapI4aPWg6XZSyszabajXZb4U4jkVOcBWh
 xIIuiHiJpBeTmdMI6WhwTvBxa2Z/DbUbHi70mixUJHhvKGx8xA+pYguk+gfNM2DD+ctC
 SNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793106400; x=1793711200;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nNCCpcY9seP+WQyZ1YKoKkqfU69q1FwbdZ21A/Nmb8A=;
 b=uCGkgPP9FUvigFIpJLB6+gzMn4ZO0k8zJ/skXb8lRm4GZDU7hWLhu8tqZTIbpu76Vz
 39Htp1RFcjLNR5YLDWRvMQfcSHge88dgJLXAe2CYct+xdEjNNKZZVLF++yYa8bgRlKLA
 ity8lydVoWVmSCunLdnh9tyThmaBcX6/xRHC3sv4FQMLuOyIRKqjIbPAk9ZvqURcOylM
 ODK68ZFZ9pIgnNXQ/h4Ov+XbhX1KQp5mhL6AG4G3DQ74E8l90l0YpAwFfrTzjgdwhbFY
 skCYE5LBb232JBQz96JAs1gk5EJ4I7e416HkyCUPxpU2FQgBbvjnZ9g4ZSXzbsZtmOwC
 XZPA==
X-Gm-Message-State: AFq9FYJsFNOcNqrZsM3sJgXhl+QCmoix77DXGbdjglgE5Z0HgOWziUNe
 +9BeH7y2U+lnkDnqJQScy/XfQ6pq2uSg4CPeCDanb+6INZiwQB53yYyihwKsVmAEFKB5S1spO2f
 BaPmu7v4LS1Ad1tQEyVfGkiO4OdNSR9o=
X-Gm-Gg: AYBFou2+ZGEPGYqRB8nGjwMQCPI126Rn877hGyfPcmyzoWa34LdZj7KNyfv/DoV/U5l
 Bb1APiD8KcQDM6fN2CR9YmGvd4OWZi8ZpTG8ZMR1Z82XZxUhyDPUNDMhnqXdA/86iiNg8oyvXuf
 ipIAEK9IKoKa4wvOV6AtG5Jl0x+qUC44M1ATVTVzcgg1ZLyK/aT+wD+x/cXbYeAPM5/awq5VX78
 kLkkNunZE1HtzztDyCJHugsQMSpEPnEZCRQjDP+oYta2HsSYjkTpUxjgHo8i6cDuOrgG40P+wNb
 N4y9Eneyj4C4fqybVXmGILOYb7MYqvAzXGPjXtkXDOHl91b7EBjZAZQW3u1cRihgyPgHNIYpX7j
 LwNCO/nMlZE3YfF1ZC5p9uNtMxOu0Kx3uLN921k+/qV2fGo+PJNdeTFVZIg==
X-Received: by 2002:a05:6402:5506:b0:6b1:ef5a:6719 with SMTP id
 4fb4d7f45d1cf-6b442fcb0f3mr10272399a12.10.1793106400159; Tue, 27 Oct 2026
 06:06:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013195606.152-1-luoyonggang@gmail.com>
 <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
 <CAE2XoE828e76zdCEkYVcbjRwhcsaSYZF1_UE4akeaoCTqCK3zg@mail.gmail.com>
 <baf81ba3-f29f-48f0-a9a2-6dc4f005d433@oss.qualcomm.com>
 <CAE2XoE9L8tuhU2nieJ8D=Cz9svS=W3oqAH+j30RGtZibjp1G=Q@mail.gmail.com>
 <bb979f8e-1372-4be4-814e-aa5dcb09942a@oss.qualcomm.com>
In-Reply-To: <bb979f8e-1372-4be4-814e-aa5dcb09942a@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 27 Oct 2026 21:06:26 +0800
X-Gm-Features: AclHuK8EdUvF4ypjcwRQQ2rjEoP47ej4J7r5TLfR9Bm7zCPrwAifmCLOUY4W3R4
Message-ID: <CAE2XoE-RcE24+9BNTSUD08QT1ECdbZm464YHiDQ4JJ4xpOE4Ww@mail.gmail.com>
Subject: Re: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x536.google.com
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

On Wed, Oct 14, 2026 at 5:37=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/13/2026 2:30 PM, Yonggang Luo wrote:
> > On Wed, Oct 14, 2026 at 5:07=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/13/26 1:19 PM, Yonggang Luo wrote:
> >>> On Wed, Oct 14, 2026 at 4:08=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 10/13/2026 12:56 PM, Yonggang Luo wrote:
> >>>>> This is for avoid "max-v8" qom name conflict in multi-target qemu
> >>>>>
> >>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>>>> ---
> >>>>>   target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
> >>>>>   1 file changed, 13 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v=
8.c
> >>>>> index 65f851f2006..d7323ab431c 100644
> >>>>> --- a/target/arm/tcg/cpu-max-v8.c
> >>>>> +++ b/target/arm/tcg/cpu-max-v8.c
> >>>>> @@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
> >>>>>   #endif
> >>>>>   }
> >>>>>
> >>>>> +static void max_v8_tcg_initfn(Object *obj)
> >>>>> +{
> >>>>> +    if (target_aarch64()) {
> >>>>> +        aarch64_max_v8_tcg_initfn(obj);
> >>>>> +    } else {
> >>>>> +        aarch32_max_v8_tcg_initfn(obj);
> >>>>> +    }
> >>>>> +}
> >>>>> +
> >>>>>   static void cpu_max_v8_register_type(void)
> >>>>>   {
> >>>>> -    static const ARMCPUInfo max_v8[2] =3D {
> >>>>> -        { .name =3D "max-v8", .initfn =3D aarch32_max_v8_tcg_initf=
n },
> >>>>> -        { .name =3D "max-v8", .initfn =3D aarch64_max_v8_tcg_initf=
n },
> >>>>> +    static const ARMCPUInfo max_v8 =3D {
> >>>>> +        .name =3D "max-v8",
> >>>>> +        .initfn =3D max_v8_tcg_initfn,
> >>>>>       };
> >>>>> -    arm_cpu_register(&max_v8[target_aarch64()]);
> >>>>> +    arm_cpu_register(&max_v8);
> >>>>>   }
> >>>>>   type_init(cpu_max_v8_register_type)
> >>>>
> >>>> It works for the current need, but will require further changes for
> >>>> heterogeneous emulation. A more versatile solution could be:
> >>>>
> >>>> arm_cpu_register(&aarch32_max_v8, target_arm);
> >>>> arm_cpu_register(&aarch64_max_v8, target_aarch64);
> >>>
> >>> And another way to handle it is like x86. it's comes with two variant=
 for
> >>>
> >>> #ifdef TARGET_X86_64
> >>> #define TYPE_X86_CPU "x86_64-cpu"
> >>> #else
> >>> #define TYPE_X86_CPU "i386-cpu"
> >>> #endif
> >>>
> >>> This also solves this issue, which looks more straightforward. no nee=
d
> >>> .targets magic for CPU.
> >>> Anyway, maybe the best way is to merge "x86_64-cpu" and "i386-cpu"
> >>> into a single cpu type and
> >>> add .targets magic? When I am trying to get x86 works, faced this iss=
ue
> >>>
> >>
> >> This solves including i386 or x86_64, but not including both at the sa=
me
> >> time. Same goes for arm vs aarch64.
> >>
> >> You can take a look at git history in target/arm, to see which kind of
> >> changes we did to make arm and aarch64 targets linkable. You'll notice
> >> most of the work was to remove (a lot of) #ifdef TARGET_X.
> >
> > See it
> > SHA-1: ec7e5a90fea996f04ea24e81b680a87bc975354a
> > * target/arm: Remove TYPE_AARCH64_CPU
> >
> > So I am just doing just the reverse direction, I am fixes x86_64 in a w=
ay that
> > register both "x86_64-cpu" "i386-cpu" variants, though this way seems
> > more suitable
> > for your heterogeneous emulation, but we need to register
> > everything(CPUs) twice.
>
> We'll have to register this twice anyway for heterogeneous, I don't see
> any other solution to have both accessible at the same time. That said,
> we are not yet there, and current patch solves the actual problem of
> having QOM types registered twice.
>
> I'll let Peter say what he thinks about this.

Hi Peter, what's your suggest about this?

>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

