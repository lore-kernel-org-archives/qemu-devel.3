Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F609C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 22:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trlSK-0007Ii-Ix; Mon, 10 Mar 2025 18:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trlSI-0007HC-9v
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 18:18:38 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trlSG-0007y9-4n
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 18:18:37 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86cce5dac90so2103571241.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741645114; x=1742249914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0cxjXvr7M1l3QctO5tlve329s2NQtBJhI9UU4feZ1U=;
 b=d/uQDKWYx11XRUHb1jiDAlQN1ySvZijanj2TVqQN5OPraPzuLEWYuDsfDvf3/sQnxx
 Fh1o2JOg1iB8TIblBcPYmL15Epz8N/jQFcjt6oNRu0oeTzqsJIX1mpptv0UTkYl7vJdX
 Kt5BMt+u7S6U3jBVhdVc3f2iCpqjKf1kVQeyvWyHMPvndyT+Q/1D+071Vz+WAYRT1qvf
 fyUUeYh2J0Yv2GUEWjGgDNJp5zczFRYo4fhasTZRkQNY5OhF0M1/GS1drC94BqRyVo1o
 6X6IoOU5to/slOifSkOPZ0rFJzuoYr72ZNpUPmK80foBPK1VeDWjY50A4wlLhkRYjbAL
 umyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741645114; x=1742249914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0cxjXvr7M1l3QctO5tlve329s2NQtBJhI9UU4feZ1U=;
 b=T7uWLcWIuUnQ39FGPpsS6x3oU9z5T8nvadjizAlqUe17GAfF90Un0dgGWhU83Gnb1W
 mxtAyRIbiEpF6fGMfIk3uN5jJsWAIMG1izgzJhtUPkjKkLSGgFxVaq6Vsbj0PhxaR7tw
 wcHDrV2nGasZkOsa17vIc4s9Jag3DSNAeibeCWgtu68+oIRZiYVIyndMU9jdAocA4kdU
 3ZXSHzXAPv51pCeiyoGUPRxiDMDguyxgTytW7YVtOyUhtmNQbC5b7SwZvesKuxhzY9y5
 QOKOebThFCeg6Vv2vs+zV7Uc7nn4j6QwKSIjnVWim4gRpGaru1NtB5kkrB6xB1Gur/2i
 PLCw==
X-Gm-Message-State: AOJu0YziDsrB1REJvvNwxXP5/oLzGiR2fTt1MUdk8DFA9yVseZjEBxy5
 9Jqv2sfpVRhgirO+fn/Hwzvg43FRnaLWRJJ6JNMa6AciUOqiadeBkgqhGzuVrxzLYiqjTLM7+zA
 taOXOE4AkyWqO6GuvhmuymZDj7tQIvjrmhk4=
X-Gm-Gg: ASbGnctE3f4t0aIJM8Vq8MPD5qvF/gaabjlAEdQSRuqailJXCZ7bF9PdOhVu1mEEbj1
 bm4Phhk/9kaquo/idpxs70n9MCjd3FtbFMls8+e8VwcTnZQtOeZKd/xYg79+kKqeISipX0EEfrf
 91+bATRom3KwXd1/dAP4g4jOemOm+N2OmTdorDHwqAWD7G8voaDP7Gqz/J
X-Google-Smtp-Source: AGHT+IFgEN1AIAIusS6G5e3J2tC1xv0RCqF1KZR/6e7pWAuRMzqAkgqivwsynQRHGT8EIQbk+YFjkYGzUDqL+XmZIRU=
X-Received: by 2002:a05:6102:304a:b0:4c1:a2b4:aa0c with SMTP id
 ada2fe7eead31-4c30a5ad2bbmr8959735137.10.1741645114551; Mon, 10 Mar 2025
 15:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-3-pbonzini@redhat.com>
 <CAKmqyKMdUONoXD69m3RH1PeoLLtL8qT-eXweVh9WHEZM5Feufg@mail.gmail.com>
 <ab9b6720-cb48-4b8f-9059-2856c78b5577@redhat.com>
 <CAKmqyKP4Fe1FHyW=fpxa47SDq=Tz2-7rAcjTxv8W2L9+q5-oCQ@mail.gmail.com>
 <CABgObfbVWoCwM7W0Mej_4FyfDLHagtun-ieHPpynsfO=s9M4=A@mail.gmail.com>
In-Reply-To: <CABgObfbVWoCwM7W0Mej_4FyfDLHagtun-ieHPpynsfO=s9M4=A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Mar 2025 08:18:08 +1000
X-Gm-Features: AQ5f1JqRpGo_XFOPhK429PoKpKZVGuyl0wvmBHXkc3E1CNAyQsfK7cdma-batHw
Message-ID: <CAKmqyKPOdzB=yKzv2q3+Zn-MrpAuaPwbeZscvreT1=2CWebvTQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] target/riscv: env->misa_mxl is a constant
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Tue, Mar 11, 2025 at 3:34=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Fri, Mar 7, 2025 at 1:45=E2=80=AFAM Alistair Francis <alistair23@gmail=
.com> wrote:
> > I'm not convinced that this is the thing that we should be checking
> > for. If someone can corrupt the migration data for an attack there are
> > better things to change then the MXL
>
> In principle you could have code that uses 2 << MXL to compute the
> size of a memcpy, or something like that... never say never. :)

But couldn't they also change the PC at that point and execute
malicious code? Or MTVEC or anything else?

It just seems like this check doesn't actually provide any security.
In the future we will want to merge misa_mxl and misa_mxl_max and this
patch just makes that a little bit harder, for no real gains that I
can see.

>
> Do you prefer turning all the priv_ver, vext_ver, misa_mxl,
> misa_ext_mask fields into VMSTATE_UNUSED? That would also be okay.

I think we do want to migrate them, they contain important information.

Alistair

>
> I would also add a check for misa_ext against misa_ext_mask and
> riscv_cpu_validate_set_extensions().
>
> Paolo
>
> > Alistair
> >
> > >
> > > Paolo
> > >
> > > > Alistair
> > > >
> > > >> would have a snowball effect on, for example, the valid VM modes.
> > > >>
> > > >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > >> ---
> > > >>   target/riscv/machine.c | 13 +++++++++++++
> > > >>   1 file changed, 13 insertions(+)
> > > >>
> > > >> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > > >> index d8445244ab2..c3d8e7c4005 100644
> > > >> --- a/target/riscv/machine.c
> > > >> +++ b/target/riscv/machine.c
> > > >> @@ -375,6 +375,18 @@ static const VMStateDescription vmstate_ssp =
=3D {
> > > >>       }
> > > >>   };
> > > >>
> > > >> +static bool riscv_validate_misa_mxl(void *opaque, int version_id)
> > > >> +{
> > > >> +    RISCVCPU *cpu =3D RISCV_CPU(opaque);
> > > >> +    CPURISCVState *env =3D &cpu->env;
> > > >> +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cpu);
> > > >> +    uint32_t misa_mxl_saved =3D env->misa_mxl;
> > > >> +
> > > >> +    /* Preserve misa_mxl even if the migration stream corrupted i=
t  */
> > > >> +    env->misa_mxl =3D mcc->misa_mxl_max;
> > > >> +    return misa_mxl_saved =3D=3D mcc->misa_mxl_max;
> > > >> +}
> > > >> +
> > > >>   const VMStateDescription vmstate_riscv_cpu =3D {
> > > >>       .name =3D "cpu",
> > > >>       .version_id =3D 10,
> > > >> @@ -394,6 +406,7 @@ const VMStateDescription vmstate_riscv_cpu =3D=
 {
> > > >>           VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
> > > >>           VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
> > > >>           VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
> > > >> +        VMSTATE_VALIDATE("MXL must match", riscv_validate_misa_mx=
l),
> > > >>           VMSTATE_UINT32(env.misa_ext, RISCVCPU),
> > > >>           VMSTATE_UNUSED(4),
> > > >>           VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
> > > >> --
> > > >> 2.48.1
> > > >>
> > > >>
> > > >
> > > >
> > >
> >
>

