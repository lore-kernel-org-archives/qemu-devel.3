Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8369606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dCBQEPiY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLhww-0002k3-EG; Tue, 27 Oct 2026 10:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLhws-0002jh-C1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:14:47 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLhwq-0003Lb-4e
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:14:46 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c43fbcb4393so597613666b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793110482; cv=none;
 d=google.com; s=arc-20260327;
 b=bimeW79/VYfi2XdoDe/PJ56eOVPGjHV6V793v6ojSxc2IHuJYGyfKcXOl9ptKLxbz9
 eF6jYbo9s1BHcdRtx7VjVDzi4JoBxlDbu4xFlJfHsN92/MkiBPn9v74RQsDnAi/FBwMo
 1OnRQP5PivhpTWAFhC+la/0p0040bOLwMklstnHcP88VL91jTctKmACTbcFotDZhc0zm
 bGUJkJZoEcbm03LIokELfQE/J45ScA+F2ygl4cXc08tMSJhjf0+bJ75g6PaEOyns/otF
 /LhjB0zLlD/sxG5A0m0kPfKj2fBUspR+scIu4SGuO/HphhpER2lq0+Up0a4666wdH4d+
 oXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=z1YmAaYHSXtmRVmaoOqjqNzyAy9sDqrNlAqh4Iye/6Y=;
 fh=QKdANP/nO7rvHn5kIgspvwzO+mszMlwslD4O4YvMNsA=;
 b=TuP7ZM+6Ob14CG5f5RUxSFbYGt9Kdxgp6SG1SYbZ9pHC+MSUe3fCht7YdCn/IsAEDE
 VJlTt0a40FQ8botV5bHIn7XjQpifCaJqUUFZlK1XGeNOfNn5k4ZhQTvBQOFh+Olbzpz7
 c5nWeHP90LuYrbRREkMnjMT0lHEnsbuHg5Cc8ZCTED3GmjoRK8P712WcW9F9bqpfRf+a
 NoEw1PbNC5XnXBtU5JeSD65lAASqRz4BJvFWcbv0kFmkev/VXFLN6QAjo7SSATw2wkTW
 E83W9RcUpMFBygnFMnijr/yXqjYYNsasOdrlBHHF0oLJwzZ1LS7jeccho7DkqSQZkiTp
 PlPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793110482; x=1793715282; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z1YmAaYHSXtmRVmaoOqjqNzyAy9sDqrNlAqh4Iye/6Y=;
 b=dCBQEPiYI1HF+Mzh3RFCTuXB+QlR3ru3tPhHMt2KU9jfBMyT5P+dNgRptnkhwol00f
 vK0W2DuCTCaOwdF6i9fRXlu6T6AtiYsBPn/E9bilzCmqdiPCTI70Rhg87Qw0eQkMEI6n
 yaKg8ydvPOxjJ34ORsjW63QlW29jThdl2J2Z3q57b/yaimJ1qp8pAWiWrT/7VEvdQEY7
 GmON4ZqY0YVj8J+kqk35U65gfsIiO2ks/V8ZspxVpvB8idHG4TT6HuVOrMnKl0iH7osu
 iXtMVIuOCYQcASEPi/MQrOM+gW0ivjEMDJIozVykwhDSQyp9XOGRaCBCWYM4X4ISZTp/
 OluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793110482; x=1793715282;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z1YmAaYHSXtmRVmaoOqjqNzyAy9sDqrNlAqh4Iye/6Y=;
 b=xx6Gh+2mGbVdfqJxs/y5DkKg6Dq8ox0JuZz3G6r+aAtL6n7GfWr7/5mYPwIZT35xLe
 TsbhSsB49opso8dwNinb7Rj4z+ofc2GkdGEM143f84RjpnoQN23sgfqiLFUGzn398XbX
 SqvK3Mh/y/eodVCCKyXNVIIUqmADtdnR7EhWMOgoPjsTAk73RUNlHDjvN8Up2e1+0OB0
 gpyraWgkvqH9tYR40RUsncoazNmeLkjUHF6uCEmUuoU7xKevdhq6Ql5b+9KkPotENW5A
 UtlR2wxJ+yCG/LjwlXeQJtejIIBII5hhUEihsgaGfQ/MwbtTE9LdGYxi7H9arCvhumTe
 P3zg==
X-Gm-Message-State: AFq9FYJCzQ8e4uNqGDvRuCFc59iekqjhMpaRxcw0CCmJrf/02G8uy8Sa
 4FNlnK0bSSAYSrdI25idEGRrmp/PDw46Kp/uocCbpvofjMO8LKA653S8jUr6qylc2EZ/qyE3Kap
 ht3b7aGEpidGKuWqci1BlEnw2lUTzyxM=
X-Gm-Gg: AYBFou37B/0SFX+1GjeNDUW5sKZsDgEInal1fanAHhD9dzdKuzVUXVQy24UBQmu3nDA
 9LuaXAmY181RgjHG6UEPKUrDtWVtJpk+p4sNfTThTDaqIuzS3SDQ1JaK/nH4zeF/n1C2VxwW1El
 3WJ3jI/Sq4TLPGKTpGQqwoHdseH/Oat78FLfX38Dj7mH5pnVZ3FZIrBs+7d/pIc4biBcLPA/2aq
 dp4DRpXYD1hI/6GA86Fk8r9YSJJ6P/c43zZDzJnXbxdX9Ohp6bt1iooMokhIbnjAEv5LwdsvtCa
 zPw0sS9qWGQYOOuv+c44Oykkc4Zzs/OsGTMRYOQ1mY4UgAEbqsbN/hfpUP4vxWzqycdUaBUk6vm
 u8XwF1ogllRKBXKXSkpCSJvLi7AzGupCB+p/q
X-Received: by 2002:a17:907:9307:b0:c29:4915:83cb with SMTP id
 a640c23a62f3a-c46bde93525mr1160549866b.39.1793110481955; Tue, 27 Oct 2026
 07:14:41 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 22:14:28 +0800
X-Gm-Features: AclHuK_cSUetcQ-qBiw2E_eFsVkYy0D5Ga_2kCaWmvgxAyvrHPgGVmXSXGdHCuQ
Message-ID: <CAE2XoE-rJ67RbTem3fSirtNUR0bzEXEBsqt90fRqV1BFmKi2TQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x629.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
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

I am not sure what heterogeneous would be, currently max_v8_tcg_initfn
is called for
both target_aarch64/target_arm, and call
aarch64_max_v8_tcg_initfn/aarch32_max_v8_tcg_initfn
depends on   if (target_aarch64()); so basically, when call to
max_v8_tcg_initfn, the target
is selected even under heterogeneous mode. would under heterogeneous
mode, target_info() is a
thread local data, if that's true, I think the current PATCH is
enough, we do not need two different
QOM-type-name for CPU .name =3D "max-v8",

> we are not yet there, and current patch solves the actual problem of
> having QOM types registered twice.
>
> I'll let Peter say what he thinks about this.
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

