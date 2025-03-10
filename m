Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81799C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trh1m-0008MH-5B; Mon, 10 Mar 2025 13:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trh1b-0008Hy-23
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trh1X-0004GC-PL
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741628078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3heVs68im2e3T8kN2zQIbqXCs7edjrTXcHgwZGWeoRo=;
 b=Tw3m/KByTTKp+HJL6LkFeqKJvVmn0SYm0BuZzpNIvtrfQrKFHCglGOeSoLQxEhqa6d4osG
 LOPARKzKIdoyilAtMxF5TF7iJwKoFTeNoexSMvrjkcVN9xGDRWNNP/HqJaAIO6xh/L9kLM
 8Tz8+txuCD172YrtgVJ+MNJa9znt4xc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-iaCM8EIoP0eJ0pMzHe6NVQ-1; Mon, 10 Mar 2025 13:34:37 -0400
X-MC-Unique: iaCM8EIoP0eJ0pMzHe6NVQ-1
X-Mimecast-MFC-AGG-ID: iaCM8EIoP0eJ0pMzHe6NVQ_1741628076
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391425471d6so668112f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741628075; x=1742232875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3heVs68im2e3T8kN2zQIbqXCs7edjrTXcHgwZGWeoRo=;
 b=kgaT4mLeNjgkJAu57UF2djW0iv4IjEU4nhnmVviuOle+gRE/EcTC6HyQh01xfZl2xr
 7l43daFMS3fgodcXaz2XzBN797phFaMkWwa7P2pLeZO98gnbDc4IhqFXjPpv7Ms7TRjn
 KVXC7jysB5v8oh+bXXvLYLjAEds8nAzAZfQTrIFW3KYfqoG/j8aqm/bPVZ2mP538WJml
 C5KOTBjLSXnOGxXYKpnG7zETGs9NAIeBya/jvcdSSII+KFI8zywZx4KmXk8fuMmPet9w
 VRdOhMPUZDJanY4iPrRYT1ZdS553Tga+W8pDg9ClnBdCazfMGNI7dHeMzfeC2KxzjKJb
 Z6Wg==
X-Gm-Message-State: AOJu0YwxEbS5qraE0CwPXqVYSaAtvs2OBZWfazp/3lVeKkxNmsOmzEb+
 sTcFwvwbIzMmrgjghSbc7kagSDXRdk3Mv4EmpQCL0yaDwag6w8j2Tn+q9tZ1fBKmJ9OqYgQn8mU
 hvaTLe/YT+Fdvn14F+BfW78qAlCGnjEQ2CVX4wKyzMOiSXRPt07TjZUOkzvs6Qifaz4NGA1CQuU
 nE8XJ99Yp1T2Kgwi9Fn266JnG41SwppULE+TxjI8bS
X-Gm-Gg: ASbGncs2Dw0QPDBq7/Sw7YmTepuGhwAaumCFlnXs+pBeh0tnI8zE3CfGK1ATVO8HVmu
 kypZrs6OjewjB6OF0seDH2Nv+LlJDD+31BuTCCxFgGg3B8TZ2RD+Qwf9rHKi8NVhCyf1/oMUsGP
 w=
X-Received: by 2002:a05:6000:144d:b0:38f:3a89:fdb5 with SMTP id
 ffacd0b85a97d-39132d244fdmr9042189f8f.11.1741628075540; 
 Mon, 10 Mar 2025 10:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEbZl1Sn5gXGywNo1kKAW/vSHmv4Mz/2Wuf/9W4IHmyj/A+GGWrkHw7JlFocBsxVMzjJT4QicQHoTxgDZxI8o=
X-Received: by 2002:a05:6000:144d:b0:38f:3a89:fdb5 with SMTP id
 ffacd0b85a97d-39132d244fdmr9042174f8f.11.1741628075261; Mon, 10 Mar 2025
 10:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-3-pbonzini@redhat.com>
 <CAKmqyKMdUONoXD69m3RH1PeoLLtL8qT-eXweVh9WHEZM5Feufg@mail.gmail.com>
 <ab9b6720-cb48-4b8f-9059-2856c78b5577@redhat.com>
 <CAKmqyKP4Fe1FHyW=fpxa47SDq=Tz2-7rAcjTxv8W2L9+q5-oCQ@mail.gmail.com>
In-Reply-To: <CAKmqyKP4Fe1FHyW=fpxa47SDq=Tz2-7rAcjTxv8W2L9+q5-oCQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Mar 2025 18:34:23 +0100
X-Gm-Features: AQ5f1JouT81kjyWhvBf4-5WXGxLAAe0fhWxQhB-36jybUzoDnaxpixNE919Om2Y
Message-ID: <CABgObfbVWoCwM7W0Mej_4FyfDLHagtun-ieHPpynsfO=s9M4=A@mail.gmail.com>
Subject: Re: [PATCH 2/7] target/riscv: env->misa_mxl is a constant
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 7, 2025 at 1:45=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
> I'm not convinced that this is the thing that we should be checking
> for. If someone can corrupt the migration data for an attack there are
> better things to change then the MXL

In principle you could have code that uses 2 << MXL to compute the
size of a memcpy, or something like that... never say never. :)

Do you prefer turning all the priv_ver, vext_ver, misa_mxl,
misa_ext_mask fields into VMSTATE_UNUSED? That would also be okay.

I would also add a check for misa_ext against misa_ext_mask and
riscv_cpu_validate_set_extensions().

Paolo

> Alistair
>
> >
> > Paolo
> >
> > > Alistair
> > >
> > >> would have a snowball effect on, for example, the valid VM modes.
> > >>
> > >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > >> ---
> > >>   target/riscv/machine.c | 13 +++++++++++++
> > >>   1 file changed, 13 insertions(+)
> > >>
> > >> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > >> index d8445244ab2..c3d8e7c4005 100644
> > >> --- a/target/riscv/machine.c
> > >> +++ b/target/riscv/machine.c
> > >> @@ -375,6 +375,18 @@ static const VMStateDescription vmstate_ssp =3D=
 {
> > >>       }
> > >>   };
> > >>
> > >> +static bool riscv_validate_misa_mxl(void *opaque, int version_id)
> > >> +{
> > >> +    RISCVCPU *cpu =3D RISCV_CPU(opaque);
> > >> +    CPURISCVState *env =3D &cpu->env;
> > >> +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cpu);
> > >> +    uint32_t misa_mxl_saved =3D env->misa_mxl;
> > >> +
> > >> +    /* Preserve misa_mxl even if the migration stream corrupted it =
 */
> > >> +    env->misa_mxl =3D mcc->misa_mxl_max;
> > >> +    return misa_mxl_saved =3D=3D mcc->misa_mxl_max;
> > >> +}
> > >> +
> > >>   const VMStateDescription vmstate_riscv_cpu =3D {
> > >>       .name =3D "cpu",
> > >>       .version_id =3D 10,
> > >> @@ -394,6 +406,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
> > >>           VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
> > >>           VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
> > >>           VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
> > >> +        VMSTATE_VALIDATE("MXL must match", riscv_validate_misa_mxl)=
,
> > >>           VMSTATE_UINT32(env.misa_ext, RISCVCPU),
> > >>           VMSTATE_UNUSED(4),
> > >>           VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
> > >> --
> > >> 2.48.1
> > >>
> > >>
> > >
> > >
> >
>


