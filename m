Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68063C2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRQb-0006zH-Hw; Thu, 15 May 2025 01:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRPz-0006cd-F1
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:46:10 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRPx-00008l-II
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:46:06 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-525da75d902so170860e0c.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287963; x=1747892763; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seb0RtiqSD7AZPkJHvDYLX0KngzFGy7J3RwYD/uBKG4=;
 b=BYNzCMAzGOHSz3dejc/UG1zPwFDSC8wdG3o8UTSo1/sLahRe3bKIlI64vhi2P21wK+
 Tmp54KONURTKY/8GQ6UDIk9VyWyvj0g41R28L8b+si2Fh7EvSmy3gsbs0xDXC40L3g8v
 vlScY09Me3sw+YE947VxI8Tt/R8n1n1b76+dmv2WhesTo0SV63/t7G3ro+vTDIo02xr8
 k67l1sRbgealH3N986JZ28mJ9z0IWg/PjAGE44GJcoWApnOpWt6hKO8pf33NB15Siyv7
 Al2afOUpjQ8BaGdswNORXDk8xnlWjZjEP0YJH+22ASD8/r00eEow/W6hx7jFUZSmhf5I
 RHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287963; x=1747892763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seb0RtiqSD7AZPkJHvDYLX0KngzFGy7J3RwYD/uBKG4=;
 b=weuO68a+eFqti4UWC3v/bTeitOUZch55bm0cbndRhwPJRngiTTIRAYKM2r6/QWkCIT
 RdLO2u6J7J3zmJQGZjVR11bOMWUtDuCjx2uN7nQBuF3UG1ERQ7+xIoIbxJ1/LQkV1QzD
 +uuqmNtGp+HfYCVij7qAZu+piWBjigRNjDxESOYft/p3iSGwhn2e3DuD+6ErgXYm2zQY
 1ez5Ai+cMsTZK3l/4kkWepj0zB862bWXWuIi1KPVWzSo3aw9gHHH7dFlmyzxhORJzqtO
 vNn7PJqGqPFgoIcIkvV2Tekter6v3nBeFb883Z5a69q6goPLzKzjUKw38et8aDEVP+Ei
 WXgw==
X-Gm-Message-State: AOJu0YwUXQuZ1wfeF9Z0a65uKAiRf8PlCdAAXFlUtK2KpFCqv86jeeB2
 a0HUPpNdNMa3J3O7uWRNWSHY1a1PlGx8s7pZbNWdJwvmL+u9WTa5rFpIXf5cXEiEWMnihHoF/WO
 m3MrTifyOnPnAnxgAkyZezDO3tLsUNQ==
X-Gm-Gg: ASbGncu8/cOEuLBll9wkvH1HW/y3HJymlgKOdhJOQEH/uFRxgr6dXB7uskgyP4E9OT/
 3+AcNDoYi/HO+tdyhd/4c/LNEnH2PCQLakHdkRzZ9SA1MbwJ1EyLyvWyRShG8Cy5kzMBs+wpd6x
 rEm9QXKweJ9ZgIwLhamm3eSqYUP599M8XVcn1CrhgI/3ae+MhIwXzU0LTGqH5zUAU=
X-Google-Smtp-Source: AGHT+IHZVhYqtEx+MERvPj8V1gIFYnXMz/uIkqDTZkguvW6iXNznyVakDtDCJGLKcTOwzrw/PuuPDN6Qcq4q2OglC0w=
X-Received: by 2002:a05:6122:2a54:b0:52a:7787:53d7 with SMTP id
 71dfb90a1353d-52d9c689881mr5770916e0c.6.1747287963268; Wed, 14 May 2025
 22:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-26-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-26-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:45:37 +1000
X-Gm-Features: AX0GCFstXnEZnQquLT2cugAXFX5A-K4Wqb-WWWF18pLNqqPuzrrpD7DAQIamFMQ
Message-ID: <CAKmqyKNKFuqqn6dCDe1OH0ibUhFbaSfZx7cyjik3ioNiQBCzXw@mail.gmail.com>
Subject: Re: [PATCH 25/26] target/riscv: remove .instance_post_init
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Mon, May 12, 2025 at 7:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Unlike other uses of .instance_post_init, accel_cpu_instance_init()
> *registers* properties, and therefore must be run before
> device_post_init() which sets them to their values from -global.
>
> In order to move all registration of properties to .instance_init,
> call accel_cpu_instance_init() at the end of riscv_cpu_init().
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f4d4abada75..2437d53d4bc 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1083,11 +1083,6 @@ static bool riscv_cpu_is_dynamic(Object *cpu_obj)
>      return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) !=3D NUL=
L;
>  }
>
> -static void riscv_cpu_post_init(Object *obj)
> -{
> -    accel_cpu_instance_init(CPU(obj));
> -}
> -
>  static void riscv_cpu_init(Object *obj)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(obj);
> @@ -1143,6 +1138,8 @@ static void riscv_cpu_init(Object *obj)
>          riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
>      }
>  #endif
> +
> +    accel_cpu_instance_init(CPU(obj));
>  }
>
>  typedef struct misa_ext_info {
> @@ -2885,7 +2882,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .instance_size =3D sizeof(RISCVCPU),
>          .instance_align =3D __alignof(RISCVCPU),
>          .instance_init =3D riscv_cpu_init,
> -        .instance_post_init =3D riscv_cpu_post_init,
>          .abstract =3D true,
>          .class_size =3D sizeof(RISCVCPUClass),
>          .class_init =3D riscv_cpu_common_class_init,
> --
> 2.49.0
>

