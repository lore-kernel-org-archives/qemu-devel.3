Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C824C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 03:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKTYa-0006fj-72; Wed, 28 May 2025 23:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKTYZ-0006dI-7M; Wed, 28 May 2025 23:03:47 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKTYQ-0000GA-Jo; Wed, 28 May 2025 23:03:47 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86d5e3ddb66so125066241.2; 
 Wed, 28 May 2025 20:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748487815; x=1749092615; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90Ou3mhqa2bWGMUaUF3rq2RwIXP4ve2uJYD6M6z4iuA=;
 b=QLJnw1l4w0G4VTwEqgq2p+ZsORHM9rQiwOQyofua+m/Lb5dPuNGeKWFq5R7JlG5T56
 46lHRR3J+uu4VVW1TaBPeE/yXQXXDG8thuEHHOsA7HtNo3h2+UVV4q1QSTS4vdh8oJb+
 ALwgcBH2TZqbyy6TGjU45PK/xcMGqaHWLmN1agny2JADx6F6GA0WpZjmCJ+XWU/arhab
 qupwgH9e2vpBWFOjtvd+KONM3AGqh+lDdT4RLtABxB8XPj8jwweBQMHGSK4+0MSYMMcP
 6JS1u+FIVAGlY6U5zxQ5Px6aoDd+5MhTGr+wrZ65XNVzbq//57xS65AK31r9noTLGk6F
 fJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748487815; x=1749092615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=90Ou3mhqa2bWGMUaUF3rq2RwIXP4ve2uJYD6M6z4iuA=;
 b=Up1O10YJ+q6puZrl/dRCk273AKuoq9GwrgwsGQd/7StlZJXs/fLndjcCWnNo9HgitE
 s6RD/MbND0Y6AtVqL3b9Xf3+8yTbppRAZziWLe3XcClwlUak903q4xt4ufN5CupMqFa8
 ciypTQoJksEY2Nx7xu+bBcLm32JPgvHGqdkLcgeWF2ETIdmLATSNwtlT6abYJbJUb+PD
 qzVnvFUh6t3pmfL2j3npdGDelEaoCc0JVKEc78ikhjeSQBmh15XGHbTPbucHvvyQBEW0
 o1T3su2CgpTddB3Htn2RYlzyhsqKgino8nwoNmmkw1pYoJXa2vFVyOhj4VO2/5FlN+2Z
 tK9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9gUA65XdzbI/MJ67arXb/ZJqJFRV1kK11BXHPEtT7yqV+GavWFz/mNit0QvV3Q1pgAOIfRLCqVS50@nongnu.org
X-Gm-Message-State: AOJu0YzBQ6M1RZMhwWWvXkVwVYjFPS12wCtwGLeC6W5Sfa+ZE0Uu1dpm
 VLopAIrQvZxMgJKzQN8tYnV8zj9Gt/yoUJs3foYqqmdiKhcNZty5Ff5snFWYPZ5SvhbWDmYcOri
 XjkDdl6ZOecTzzAKEDWCZznLVzGPR6pA=
X-Gm-Gg: ASbGncuQheIEOGa2csCfuVvyaBq+pRsr//NDjyYFU/IkaaHutdHgP6iRd2PG6bKZzAL
 rAj81R/FTcHNdGllvGBuIRqi8CKx7L/oEEDSP46z50Rt0jNbIIKt7vVu+TPFhPvCKW325U5zlKf
 GAqTPsUYwcqfVkuVdBNVVOTte5rplJKbxGqm9Oc2oOKa2GL6Mg8+azdvYs2i426d8=
X-Google-Smtp-Source: AGHT+IEtbH9aWCsJ71ZS0iGXHyB53qmuQmAEKlTOzVTdQMjkhGvtJrMS7Fgbr3hsQNU5EWNILnzGuoOE3fqyd/5J31U=
X-Received: by 2002:a05:6102:6c1:b0:4c1:992c:b95d with SMTP id
 ada2fe7eead31-4e42416147dmr16003023137.17.1748487814868; Wed, 28 May 2025
 20:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
 <20250520172336.759708-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250520172336.759708-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 May 2025 13:03:08 +1000
X-Gm-Features: AX0GCFu2a3geykdH_8PNKN4-eBOJjxjiFeAttXyI3yg_HigzkjHc7IoPTEE9QC0
Message-ID: <CAKmqyKMr1-VwQvTY0MdW+i1jhqfPogZ3m1cKEdUWEo28-exDOg@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv/tcg: restrict satp_mode changes in
 cpu_set_profile
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Wed, May 21, 2025 at 3:24=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We're changing 'mmu' to true regardless of whether the profile is
> being enabled or not, and at the same time we're changing satp_mode to
> profile->enabled.
>
> This will promote a situation where we'll set mmu=3Don without a virtual
> memory mode, which is a mistake.
>
> Only touch 'mmu' and satp_mode if the profile is being enabled.
>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Fixes: 55398025e7 ("target/riscv: add satp_mode profile support")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 55e00972b7..7f93414a76 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1338,16 +1338,16 @@ static void cpu_set_profile(Object *obj, Visitor =
*v, const char *name,
>
>      if (profile->enabled) {
>          cpu->env.priv_ver =3D profile->priv_spec;
> -    }
>
>  #ifndef CONFIG_USER_ONLY
> -    if (profile->satp_mode !=3D RISCV_PROFILE_ATTR_UNUSED) {
> -        object_property_set_bool(obj, "mmu", true, NULL);
> -        const char *satp_prop =3D satp_mode_str(profile->satp_mode,
> -                                              riscv_cpu_is_32bit(cpu));
> -        object_property_set_bool(obj, satp_prop, profile->enabled, NULL)=
;
> -    }
> +        if (profile->satp_mode !=3D RISCV_PROFILE_ATTR_UNUSED) {
> +            object_property_set_bool(obj, "mmu", true, NULL);
> +            const char *satp_prop =3D satp_mode_str(profile->satp_mode,
> +                                                  riscv_cpu_is_32bit(cpu=
));
> +            object_property_set_bool(obj, satp_prop, true, NULL);
> +        }
>  #endif
> +    }
>
>      for (i =3D 0; misa_bits[i] !=3D 0; i++) {
>          uint32_t bit =3D misa_bits[i];
> --
> 2.49.0
>
>

