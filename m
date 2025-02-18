Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF6CC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 00:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkB7R-0007Ts-1w; Mon, 17 Feb 2025 19:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tkB7H-0007T8-Ig
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 19:05:37 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tkB7D-00076C-5A
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 19:05:33 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-868e368ec74so3094397241.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 16:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739837129; x=1740441929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpaiaKBvYgvTyHoZWIVs66iM3HrsPAH4OJYsHdjhSZI=;
 b=VsmvTa8zg1CrUCxMWIEix+DgvfCqtoDpIf3QdNJ/8jCjZCHp1E0P2Jj/WOZ3bMyW/R
 461IXaH3CSR0batb2ZQTyD/pG9IBk92ERSYNuGi6GDanjue+a3lMyUUPEIqfLsSthrqD
 XWj03Jhb88Ts42J2Rr80DssXJxLXoeZ75lJ3nIwBRh/42Niw3FWIaMpmZ40J06n2/e+0
 ZMS40qxL9jEaNkIpUUH9phNKs1X/Ceumj/7dKhYjcK8cHeXBIwb2r40XHo+no1D0o49q
 9nJgu1WuhlVbu3vUi8kjWmwXPb5m9cjW3x17+vEcZTmPb9VpKwf0dUwfYt4UZ1B0vqFV
 GqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739837129; x=1740441929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpaiaKBvYgvTyHoZWIVs66iM3HrsPAH4OJYsHdjhSZI=;
 b=a/fg6vS/Tej2fSRHZRLibcp7+TzcFLpFKNZYQ0MLKRZXheOo6ryyiBUvTv+90tXioG
 cUJ3C9whK3V3qDJd1A6vTJd/L7bfbGOrGMyNI/9sQhX9f2lGGrRG2HVqDl6CtavcxDNq
 z3v1C1RK+LIekqDo5Qktvfa8bEhIwDrKkE11QDyIUTwN2DIlmC6/Kr4Fjq6fEwTqfTJO
 YNV6Mg7bPMAQFbqDxf3WFjCTyJdEtJyjfLi38xA33hhfLmU4e3bCvtrGh9h9CXk5s/DJ
 QQzl73SwxPi2Gf3Wm69bMYsTk3zD/65hw9vOKlyG3kxr6hxp3L8je5WD86Dmy/QIRc8V
 tXOg==
X-Gm-Message-State: AOJu0YwEEty/UoN6kaTWX9bb71GVgzfsqjYFsgnfMUubQBZU4FmY+sGd
 Yxe+6U95mKA90TNkLdDzR+eJEXEXmg2qxVKwcOU2fQwAvptu3zU1kwyyjc2rlyNXsQHIzq47n5l
 ApJMtcLh8fKxw066rDfX+gSQN8CQ=
X-Gm-Gg: ASbGncv+W6FTugXGn/cC+wIXydZIFTlx7hOslw1XuO8olSQCQLwVlMOVPXQ3Fzi3Eb5
 bouoyG1O+7gt4RQrl9LdKImHJV0/BMPTZ2AzhvUfXex7YwYb4aWgsxNUaZOmeefjP3//Kc/trYL
 QuL5NOPMBPQp1PVm7qmxR9dF6AxA==
X-Google-Smtp-Source: AGHT+IHVNaOWz5qMHJ9b2w3Trn7GMm+PoOItbaPoFzpf769NLt7qcSfiIGysV9ZuIXW3xSIdImvNHWCoIJ2z2EhjfwE=
X-Received: by 2002:a05:6102:cca:b0:4bb:ecb9:b354 with SMTP id
 ada2fe7eead31-4bd3fa98b27mr7126632137.0.1739837129458; Mon, 17 Feb 2025
 16:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20250206182711.2420505-1-pbonzini@redhat.com>
 <20250206182711.2420505-5-pbonzini@redhat.com>
In-Reply-To: <20250206182711.2420505-5-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Feb 2025 10:05:03 +1000
X-Gm-Features: AWEUYZkdaVcIonwqpXZBFKRDUo6ykPib-3rKumdIEjisLYBidKC-Y6WyBmYoiZ4
Message-ID: <CAKmqyKOHNcpNQ5Qq9JQfjgHmSV_MyjtsQko299g58P+cV8Cc3g@mail.gmail.com>
Subject: Re: [PATCH 04/22] target/riscv: merge riscv_cpu_class_init with the
 class_base function
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
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

On Fri, Feb 7, 2025 at 4:29=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Since all TYPE_RISCV_CPU subclasses support a class_data of type
> RISCVCPUDef, process it even before calling the .class_init function
> for the subclasses.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 803b2a7c3f4..baf4dd017b2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2961,15 +2961,18 @@ static void riscv_cpu_class_base_init(ObjectClass=
 *c, void *data)
>      } else {
>          mcc->def =3D g_new0(RISCVCPUDef, 1);
>      }
> -}
>
> -static void riscv_cpu_class_init(ObjectClass *c, void *data)
> -{
> -    RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> -    RISCVCPUDef *def =3D data;
> +    if (data) {
> +        RISCVCPUDef *def =3D data;
> +        if (def->misa_mxl_max) {
> +            assert(def->misa_mxl_max <=3D MXL_RV128);
> +            mcc->def->misa_mxl_max =3D def->misa_mxl_max;
> +        }
> +    }
>
> -    mcc->def->misa_mxl_max =3D def->misa_mxl_max;
> -    riscv_cpu_validate_misa_mxl(mcc);
> +    if (!object_class_is_abstract(c)) {
> +        riscv_cpu_validate_misa_mxl(mcc);
> +    }
>  }
>
>  static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
> @@ -3069,7 +3072,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_DYNAMIC_CPU,                   \
>          .instance_init =3D (initfn),                          \
> -        .class_init =3D riscv_cpu_class_init,                 \
>          .class_data =3D &((RISCVCPUDef) {                     \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
>          }),                                                 \
> @@ -3080,7 +3082,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_VENDOR_CPU,                    \
>          .instance_init =3D (initfn),                          \
> -        .class_init =3D riscv_cpu_class_init,                 \
>          .class_data =3D &((RISCVCPUDef) {                     \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
>          }),                                                 \
> @@ -3091,7 +3092,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
> -        .class_init =3D riscv_cpu_class_init,                 \
>          .class_data =3D &((RISCVCPUDef) {                     \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
>          }),                                                 \
> @@ -3102,7 +3102,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
> -        .class_init =3D riscv_cpu_class_init,                 \
>          .class_data =3D &((RISCVCPUDef) {                     \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
>          }),                                                 \
> --
> 2.48.1
>
>

