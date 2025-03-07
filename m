Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B396C282D1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 00:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqLql-0004gm-FB; Thu, 06 Mar 2025 19:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tqLqF-0004fl-Q3
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 19:45:31 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tqLqC-0001KL-Aw
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 19:45:31 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-86d2fba8647so1133036241.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 16:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741308327; x=1741913127; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBphd+2KFjs0Cd0y8Fd2STViBQkFlCtFX+kqLjAioic=;
 b=XmO2McKI15LQD8K+f8u0wDPLVOczZ+3tr16r9lKTBOz8hPZJbF6LiL3jHnLC1xgb+Q
 +W2yyhB0nnMQoxi8zuvKL97jQhOmw0ebt3usqOU02G5+oiIwaofQIy3oj1/cRUYtCO92
 51Qhr9y+JLHRMfGgTt3p56j9LcLhTPndj5fLE6c+sgcz50PQHbU3drjYOWS3v/oKROIW
 rXX/zXKNg49Q0sCA+S7Onmw3X5fDNLLpmKfc2GM+mmIuV+Ea3ol5/gk5IEI4nQuF+oEM
 0G8UQ1zC93FZ0a8lY7GQ4PHPr9s3882tmrC12yZ5N026cALGl7C92SZMdUnCHNiNQTSl
 g12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741308327; x=1741913127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBphd+2KFjs0Cd0y8Fd2STViBQkFlCtFX+kqLjAioic=;
 b=Y4OBx94whbELIH8JS4dZ1MNDjaiQkuhW/vjIPvj2MbOjFsh+kgLZYFyRrVDVjIkDUW
 2zFjfbg1aaOYdfSjXNke1BoKT7Jn6lmsOV6K7uobeDlS1dJ01fWw1l6ti8GxszrAyoho
 zsfs81C6Qcup/ZgKKs5rHCOAeLRrhOYlgGWUq1KKU6jNifWqybM/dYbRqLw2UDby8M9H
 BHNs9AJ2TYnZx5cnLfOEVPBpUX+76teUGxXQfzfgDiIfBKqJWV80dtE3fJSra0Vpv5ix
 55dbqW64QhTeNWWUESvTxXTAQfnE01GCjA4leFymiNM2hIBW4HMBui4qiO+u+lArNRDz
 3Yrw==
X-Gm-Message-State: AOJu0YwUZeWHX+wo8fxPnYIJdKoTt+b//UlMJ0DQgEouTQvsEWK8kMlk
 wyqVAcn8+xIIoS1tHFdvfXZWQX/8i965NpkId9z04WYBr52yn4O/5VkTwtpfNA4nCrlrpvDQv1q
 x9qF+oUEtE+Rl+GyDfDCMB+XLRj0=
X-Gm-Gg: ASbGnctWT6cILDLBmcPbEgw9pfosBYmuu+kxfg18KkGOLBCYPpxTS8jJpi0FDZeDLnT
 Mavwmr7ADHA0jI9lI6eWss6/P+pCLGM5fgOF1JBML/xL8/UpaEnxmHnO/MFnCVoBLCrRpdQgPwV
 ATaFzhaNAzILEWJ6sh8nhdW1WMe3YcVNhAInDvFrAjIraexOKAfbYxwPT0
X-Google-Smtp-Source: AGHT+IG2DlGolwwHFzRQpHcu2gggHIO+DbIoRPQtFhan8c56YzEOhaRH+AOI/zd62EuJ5C1eK9DPv+Sls9aTrtc0Ng4=
X-Received: by 2002:a05:6102:578f:b0:4bb:e511:15a6 with SMTP id
 ada2fe7eead31-4c30a5eec6cmr1125494137.11.1741308326799; Thu, 06 Mar 2025
 16:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-3-pbonzini@redhat.com>
 <CAKmqyKMdUONoXD69m3RH1PeoLLtL8qT-eXweVh9WHEZM5Feufg@mail.gmail.com>
 <ab9b6720-cb48-4b8f-9059-2856c78b5577@redhat.com>
In-Reply-To: <ab9b6720-cb48-4b8f-9059-2856c78b5577@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Mar 2025 10:44:58 +1000
X-Gm-Features: AQ5f1JpytgaTsPd00sP3ki7nrL8Ya2EslIop-maooGVQxn7GYQ4reZlPJlZ-oSU
Message-ID: <CAKmqyKP4Fe1FHyW=fpxa47SDq=Tz2-7rAcjTxv8W2L9+q5-oCQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] target/riscv: env->misa_mxl is a constant
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Thu, Mar 6, 2025 at 11:00=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 3/6/25 02:16, Alistair Francis wrote:
> > On Wed, Feb 19, 2025 at 3:01=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.=
com> wrote:
> >>
> >> There is nothing that overwrites env->misa_mxl, so it is a constant.  =
Do
> >
> > The idea is that misa_mxl can change, although that's not supported now=
.
>
> At run-time, or only at configuration time (before realize)?

Runtime, at least kind of

The RISC-V spec 1.12 and earlier allows MXL to change at runtime by
writing to misa.MXL. QEMU doesn't support this and AFAIK no hardware
does either, but it was something that we might support in the future
(hence the split).

The latest RISC-V priv spec has changed misa.MXL to be read only though.

So I guess although in theory it can be changed at runtime, we are
probably never going to support that now that it's deprecated.

Now that the latest priv spec has dropped the ability to write to
misa.MXL we will probably work towards just consolidating misa_mxl_max
and misa_mxl into a single value that is constant after realise.

>
> >> not let a corrupted migration stream change the value; changing misa_m=
xl
> >
> > Does this actually happen? If the migration data is corrupted won't we
> > have all sorts of strange issues?
>
> Generally migration data (just like disk image formats) is treated as
> security-sensitive, overriding any other considerations.  So you have to
> assume that the corruption is intentional, and sneaky enough to cause
> trouble.

I'm not convinced that this is the thing that we should be checking
for. If someone can corrupt the migration data for an attack there are
better things to change then the MXL

Alistair

>
> Paolo
>
> > Alistair
> >
> >> would have a snowball effect on, for example, the valid VM modes.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>   target/riscv/machine.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> >> index d8445244ab2..c3d8e7c4005 100644
> >> --- a/target/riscv/machine.c
> >> +++ b/target/riscv/machine.c
> >> @@ -375,6 +375,18 @@ static const VMStateDescription vmstate_ssp =3D {
> >>       }
> >>   };
> >>
> >> +static bool riscv_validate_misa_mxl(void *opaque, int version_id)
> >> +{
> >> +    RISCVCPU *cpu =3D RISCV_CPU(opaque);
> >> +    CPURISCVState *env =3D &cpu->env;
> >> +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cpu);
> >> +    uint32_t misa_mxl_saved =3D env->misa_mxl;
> >> +
> >> +    /* Preserve misa_mxl even if the migration stream corrupted it  *=
/
> >> +    env->misa_mxl =3D mcc->misa_mxl_max;
> >> +    return misa_mxl_saved =3D=3D mcc->misa_mxl_max;
> >> +}
> >> +
> >>   const VMStateDescription vmstate_riscv_cpu =3D {
> >>       .name =3D "cpu",
> >>       .version_id =3D 10,
> >> @@ -394,6 +406,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
> >>           VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
> >>           VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
> >>           VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
> >> +        VMSTATE_VALIDATE("MXL must match", riscv_validate_misa_mxl),
> >>           VMSTATE_UINT32(env.misa_ext, RISCVCPU),
> >>           VMSTATE_UNUSED(4),
> >>           VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
> >> --
> >> 2.48.1
> >>
> >>
> >
> >
>

