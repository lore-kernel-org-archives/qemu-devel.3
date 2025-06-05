Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F3EC5B549
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 03:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN1QL-0005dw-7q; Wed, 04 Jun 2025 23:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN1QG-0005dg-PP; Wed, 04 Jun 2025 23:37:44 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN1QF-0006LV-Aj; Wed, 04 Jun 2025 23:37:44 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-53090b347dfso214282e0c.0; 
 Wed, 04 Jun 2025 20:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749094661; x=1749699461; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IZ/Gm4Z8yq42pvlxJJK+uTUmprpxPqVpbZk4WfSkoE=;
 b=AIXAuKcKwwx1Z7p2ydbgzo8Z9zN9fCnXQq4NdIr7haQWLPFBFcCTKRPGM8eHpgQGe9
 +kR1cUW47lGml1jr7Ihb47BLjXs0Supxqo8K3mM/UbFF3DmJOyjF8gFCmF5+6mbBlrHt
 K8jCaU6tvHn9ZpKIzbNsVH9ZPozGREEUU1KkH4p1+bc1YQNfyRHS67X4NfU4EYn67LkL
 UdPJz0BqefnSxp1eOxR8goxfc2m8TcQ1TrdxOsuy9TzWePY1dYZZ6rfluNpTBQ4g2Rb6
 6JgeTEKO0jZbJ4VONLlTNN0CkmXFcQZWRy2z57TCMIq81eXTH8Xqntx8WKihd46dqSpM
 z1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749094661; x=1749699461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IZ/Gm4Z8yq42pvlxJJK+uTUmprpxPqVpbZk4WfSkoE=;
 b=muqNsCyHnlEwp2AlrukHF7W+j4F2psm7LPYejIB2qcv3+YiWIZKgilC4c91X9q9Mh1
 onz6zn7/aAGse83X0bN4j+AePy7ey0vNDKqAluKHb1qRZEw+7JDk3V5R+kQtkcKOldA4
 nPcnSz0E2EYnBudf8AkNkE7x8OwFlyZJo1rRhvHlmxIJwUrwmLzVc8/9Hrsex48UzuFq
 R8gim12uYyZvSXHyYM9i50dQ12AUbCeHw9MKTSaHED1EKIlByfLhhbWV54T6BpWq6btd
 Jp+OIYRS5yExUNGFlgVmVaUmVG4o+HFvjXL/B2rDt99p1BpwjYplkdzu4c2M7vjysy4s
 Zu2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH+6DiVW6dwNU02bZuxft7W6858ymL5EpP7nJM4F1Mco0yTuFs1ejO9HTvMpwsiokQFLBlfTcRWVyP@nongnu.org
X-Gm-Message-State: AOJu0YwGl7De0g/NCo7vALdki475aUxstQLZACt7SZeG4t2dmERDOBtp
 Z+xN/xW+Ave0z3tGD4mnrMNBtsK7YreVYyAczE0Z/O/2KnhIF13sGZ/LGHvxBkP0nF+jD0ebsOY
 ZftNYOHFUc+d0Jtic0y2bee0guh+W4lQ=
X-Gm-Gg: ASbGncuhM9m+Kfg9Xv/hJBMi5qxwvCgTeR3ceiYTP/rdxBnFGSRwMJe+WZh4su7csNj
 ZJLd0n49CI8YXmVhCXc/NIrpb0nH+bPFMnsMGQq5QEIrOdK8wdNTwOg8EEM2NsdCzBzTrQMUJim
 4Bh//4YfCZRjpMYxWbdEC3I+jj9L7WtBwqIvzbxxbZ8D8HUyNzIyf2nBxg0YxeMLE=
X-Google-Smtp-Source: AGHT+IFwM65ihg8iV43q1jbZhlBobk6/I1hXrzTmTrPVVMoacYEdGHpU5zjb84EMRIB3EmwyG1yKNUYePZrnVt3EHOE=
X-Received: by 2002:a05:6122:1789:b0:530:81ad:1d79 with SMTP id
 71dfb90a1353d-530c89141a8mr4571428e0c.6.1749094661352; Wed, 04 Jun 2025
 20:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250604174329.1147549-1-dbarboza@ventanamicro.com>
 <20250604174329.1147549-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250604174329.1147549-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Jun 2025 13:37:15 +1000
X-Gm-Features: AX0GCFuOMAitol05u6Hzc6u2OGnlCHAcp5dt8HP-9gHUNK91CL5aAudSfk2kZvQ
Message-ID: <CAKmqyKM4NyO-WkiniFyqEppJvYUnD9=FMSJwOw8bgrU2hF+2Pg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/3] target/riscv/cpu.c: add 'sdtrig' in riscv,
 isa
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Thu, Jun 5, 2025 at 3:45=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We have support for sdtrig for awhile but we are not advertising it. It
> is enabled by default via the 'debug' flag. Use the same flag to also
> advertise sdtrig.
>
> Add an exception in disable_priv_spec_isa_exts() to avoid spamming
> warnings for 'sdtrig' for vendor CPUs like sifive_u.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c                |   1 +
>  target/riscv/tcg/tcg-cpu.c        |   9 +++++++++
>  tests/data/acpi/riscv64/virt/RHCT | Bin 400 -> 406 bytes
>  3 files changed, 10 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ee3ee0e883..eeb44a2f1e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
>      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
>      ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>      ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 81174de409..7fbfc26adf 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -451,6 +451,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RIS=
CVCPU *cpu)
>                  continue;
>              }
>
> +            /*
> +             * cpu.debug =3D true is marked as 'sdtrig', priv spec 1.12.
> +             * Skip this warning dince existing CPUs with older priv

since

> +             * specd and debug =3D true will be impacted.

spec

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +             */
> +            if (!strcmp(edata->name, "sdtrig")) {
> +                continue;
> +            }
> +
>              isa_ext_update_enabled(cpu, edata->ext_enable_offset, false)=
;
>
>              /*
> diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/=
virt/RHCT
> index 13c8025b868051485be5ba62974a22971a07bc6a..156607dec45b0e63e5b3ebed6=
2e81076dacd80d0 100644
> GIT binary patch
> delta 49
> zcmbQhJdK$v$iq2g8Y2S(<Ex2W2COEGj0`#x?N_s=3DloVyAPkd23IgL??BZrZJp^TA%
> F0RTq!4730M
>
> delta 43
> zcmbQnJb{@j$iq2g0wV(h<JXB?2CRCFj0~z1?N?9ySUowLQJEu+k%6Irk%0jK_Q(p3
>
> --
> 2.49.0
>
>

