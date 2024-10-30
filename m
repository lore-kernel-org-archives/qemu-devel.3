Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBC0D74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xiD-0006p2-Fm; Tue, 29 Oct 2024 21:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5xiB-0006om-8i; Tue, 29 Oct 2024 21:41:27 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5xi8-0001LP-U9; Tue, 29 Oct 2024 21:41:26 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4a47240d31aso1765723137.3; 
 Tue, 29 Oct 2024 18:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730252483; x=1730857283; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kf3H2QnSzAnyrekx2Ol+MGx2tn8+4DiQSqnuvwn2oeY=;
 b=MBSMgaeTXX72VbD3yo/7gok4SLRRaRvG6/XVEzMyojjxedxO91vBQqapnrNIBzXQd3
 qMVYJWql/jKF/R28cnYh5qCVC334Bc3MlCAlWsGz4b3IgLbSMJgg+GtETsrrj9+X/eAU
 LOLaPkCK6GC/JfzAXp3pKN0cfzLzAYP1gkvYoaYHw0C4DjjfFuAe1NByG3o43GHqzqBx
 DENbSuTSBXy3a+lbVWpsbFo4horhO1WHxRMjo+KIpAPx5Fc7jS5c4zn++UmroqZlET+s
 xT6W3bwlZcA/QeztpTqGsVWisTGXp1UUqlRFhq05Y6l+1pEom3hxKfnOSwi0lEprXN3e
 LivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730252483; x=1730857283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kf3H2QnSzAnyrekx2Ol+MGx2tn8+4DiQSqnuvwn2oeY=;
 b=ul6oxNljjY6gnSiEBroJ/VO0kG9vvT0QQ935HrejsEobd02OTJd4LarABnyf4SqQKj
 B3GvmDxBVSRmgLi/wsh4iqyYos3uQ6r4m03fE3irTQVNx1iskH81DYNO/vES37dCXa45
 B4UxoCBByZTiTPhzm15NrkEuVhvCRFKruVG0hSeCWwBZBaq8YQw5ijRAcfT9SI/AXLel
 uK6gqlcXjhy7/hPocnBeDf6IV6Sdqr8PJusqW3UDQXg+NxkrTbaThHHLWbaYl46s7HL1
 1xvPw44I30oxtjwADOffG+/3+zBEJMJs7LQU+BTefPkBJ/tyv1f5YTMRqOpSW69krBFA
 vzhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx4KMNwkdKRGUZRdkC2zqLXr7bEkglwjyKgw2986iGCjMa1uSZjT4+CT+70ejBpgwriRqviGsc9ttk@nongnu.org
X-Gm-Message-State: AOJu0YzJB6p6igIYjA8QJzwrL95HSAYk4fPgKGY0Q4QXLPeiT9vpaYY2
 If/qkd3K5Ox2XGn+pDxfjew2Beaq1XlNHypoj0PBaKjOHdDQ4EnNX3cEd4rCr08cOeqG2AFgHS2
 wzUuAiuxvZFUV1Z5M0b5fBC2Q6IQ=
X-Google-Smtp-Source: AGHT+IHafc9TvAG5esdN6kl+X2sNvhciVVHXil4BNZ1vpBzH+ZBIvfwVT7yO/502Li7Ilg8SGwo8DHOmiyye5vhC5YU=
X-Received: by 2002:a05:6102:f14:b0:4a4:8d45:684e with SMTP id
 ada2fe7eead31-4a8cfd5fbb5mr12880963137.29.1730252483284; Tue, 29 Oct 2024
 18:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
 <20240924124407.766495-4-dbarboza@ventanamicro.com>
 <CAKmqyKMMRCFvWYa1GjwkbJsBh8q_OgtA2UVdaNEJsr=N66hvkQ@mail.gmail.com>
 <b7271701-195a-461d-ba64-e2a02c634177@ventanamicro.com>
In-Reply-To: <b7271701-195a-461d-ba64-e2a02c634177@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Oct 2024 11:40:57 +1000
Message-ID: <CAKmqyKPvfm7fxa7cCtNWpQaw_=SBvmUFJ15hfJemNg=-YQCbNA@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/riscv/kvm: add kvm-aia bools props
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Oct 11, 2024 at 9:19=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 10/10/24 10:57 PM, Alistair Francis wrote:
> > On Tue, Sep 24, 2024 at 10:46=E2=80=AFPM Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> >>
> >> Boolean properties are preferrable in comparision to string properties
> >> since they don't require a string parsing.
> >>
> >> Add three bools that represents the available kvm-aia mode:
> >> riscv-aia-emul, riscv-aia-hwaccel, riscv-aia-auto. They work like the
> >> existing riscv-aia string property, i.e. if no bool is set we'll defau=
lt
> >> to riscv-aia-auto, if the host supports it.
> >>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> ---
> >>   target/riscv/kvm/kvm-cpu.c | 77 ++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 77 insertions(+)
> >>
> >> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> >> index 32f3dd6a43..e256e3fc48 100644
> >> --- a/target/riscv/kvm/kvm-cpu.c
> >> +++ b/target/riscv/kvm/kvm-cpu.c
> >> @@ -1671,6 +1671,62 @@ static void riscv_set_kvm_aia(Object *obj, cons=
t char *val, Error **errp)
> >>       }
> >>   }
> >>
> >> +static void riscv_set_kvm_aia_bool(uint32_t aia_bool, bool val)
> >> +{
> >> +    bool default_aia_mode =3D KVM_DEV_RISCV_AIA_MODE_AUTO;
> >> +
> >> +    g_assert(aia_bool <=3D KVM_DEV_RISCV_AIA_MODE_AUTO);
> >> +
> >> +    if (val) {
> >> +        aia_mode =3D aia_bool;
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * Setting an aia_bool to 'false' does nothing if
> >> +     * aia_mode isn't set to aia_bool.
> >> +     */
> >> +    if (aia_mode !=3D aia_bool) {
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * Return to default value if we're disabling the
> >> +     * current set aia_mode.
> >> +     */
> >> +    aia_mode =3D default_aia_mode;
> >> +}
> >> +
> >> +static bool riscv_get_kvm_aia_emul(Object *obj, Error **errp)
> >> +{
> >> +    return aia_mode =3D=3D KVM_DEV_RISCV_AIA_MODE_EMUL;
> >> +}
> >> +
> >> +static void riscv_set_kvm_aia_emul(Object *obj,  bool val, Error **er=
rp)
> >> +{
> >> +    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_EMUL, val);
> >> +}
> >> +
> >> +static bool riscv_get_kvm_aia_hwaccel(Object *obj, Error **errp)
> >> +{
> >> +    return aia_mode =3D=3D KVM_DEV_RISCV_AIA_MODE_HWACCEL;
> >> +}
> >> +
> >> +static void riscv_set_kvm_aia_hwaccel(Object *obj,  bool val, Error *=
*errp)
> >> +{
> >> +    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_HWACCEL, val);
> >> +}
> >> +
> >> +static bool riscv_get_kvm_aia_auto(Object *obj, Error **errp)
> >> +{
> >> +    return aia_mode =3D=3D KVM_DEV_RISCV_AIA_MODE_AUTO;
> >> +}
> >> +
> >> +static void riscv_set_kvm_aia_auto(Object *obj,  bool val, Error **er=
rp)
> >> +{
> >> +    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_AUTO, val);
> >> +}
> >> +
> >>   void kvm_arch_accel_class_init(ObjectClass *oc)
> >>   {
> >>       object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia=
,
> >> @@ -1681,6 +1737,27 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
> >>           "if the host supports it");
> >>       object_property_set_default_str(object_class_property_find(oc, "=
riscv-aia"),
> >>                                       "auto");
> >> +
> >> +    object_class_property_add_bool(oc, "riscv-aia-emul",
> >> +                                   riscv_get_kvm_aia_emul,
> >> +                                   riscv_set_kvm_aia_emul);
> >> +    object_class_property_set_description(oc, "riscv-aia-emul",
> >> +        "Set KVM AIA mode to 'emul'. Changing KVM AIA modes relies on=
 host "
> >> +        "support. Default mode is 'auto' if the host supports it");
> >> +
> >> +    object_class_property_add_bool(oc, "riscv-aia-hwaccel",
> >> +                                   riscv_get_kvm_aia_hwaccel,
> >> +                                   riscv_set_kvm_aia_hwaccel);
> >> +    object_class_property_set_description(oc, "riscv-aia-hwaccel",
> >> +        "Set KVM AIA mode to 'hwaccel'. Changing KVM AIA modes relies=
 on host "
> >> +        "support. Default mode is 'auto' if the host supports it");
> >> +
> >> +    object_class_property_add_bool(oc, "riscv-aia-auto",
> >> +                                   riscv_get_kvm_aia_auto,
> >> +                                   riscv_set_kvm_aia_auto);
> >> +    object_class_property_set_description(oc, "riscv-aia-auto",
> >> +        "Set KVM AIA mode to 'auto'. Changing KVM AIA modes "
> >> +        "relies on host support");
> >
> > This seems more confusing. What should happen if a user sets multiple t=
o true?
>
> It'll work like most options in QEMU: the last setting will overwrite the=
 previous
> ones. "-accel kvm,riscv-aia-hwaccel=3Dtrue,riscv-aia-emul=3Dtrue" will se=
t the mode
> to 'emul'. This is the same behavior that we have with the existing 'risc=
v-aia'
> string option.

To me, reading "-accel kvm,riscv-aia-hwaccel=3Dtrue,riscv-aia-emul=3Dtrue"
means that the `riscv-aia-hwaccel` and the `riscv-aia-emul` features
are enabled.

Converting a single multi-option property to a range of bools just
feels strange. It seems more confusing to users.

I agree that not requiring string parsing is nice, but this doesn't
really seem worth it

>
> In case someone tries it out with multiple -accel options, this doesn't w=
ork. Only
> the first '-accel <type>' are parsed. This happens due to a known command=
 line
> parsing/accel globals issue that I tried to fix in [1] and [2].
>
> For now, using the existing 'riscv-aia' string option:
>
> -accel kvm,riscv-aia=3Demul -accel kvm,riscv-aia=3Dhwaccel -accel kvm,ris=
cv-aia=3Dauto
>
> This will set riscv-aia to "emul" because all other "-accel kvm" options =
aren't
> being parsed. You can do silly stuff like:
>
> -accel kvm,riscv-aia=3Demul -accel kvm,riscv-aia=3Dthis_is_not_an_option
>
> And the guest will boot normally, setting riscv-aia to 'emul'.

Both of those are unfortunate, but I do at least feel that reading
them it's clear that something is wrong as the user has listed `-accel
kvm...` multiple times.

Alistair

