Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C21C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPXb-0002Qx-0D; Sun, 23 Feb 2025 22:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPXQ-0002QK-T1; Sun, 23 Feb 2025 22:53:48 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPXP-0006nd-8C; Sun, 23 Feb 2025 22:53:48 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-51e902b58c0so2472075e0c.0; 
 Sun, 23 Feb 2025 19:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740369225; x=1740974025; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1VxqJlXQLRAXQsTUsNU8uC+4iuKdQ8cSmKPGsRjfcf0=;
 b=m6Mq4vkvGNUHtH5QpkSljPoiTIHlgykcx9DMPYdGARwLCcmap1/zoYb41iQy35B16w
 SnT28REKDwJmKSnrO1L8h4igqZu4QsS3sevMU2T92qtB8mMBmPJjV4AZ91BidSNBjxZp
 EkUvEueliRNc6AFbHaWBoxI33mtPppcJ5s2FINawZk5VdvAXbWB1a4A8EzMdI0gH8Iwr
 jN6Hc8Fun+9fom5e2uxaa6z2yCHfOCJhwxqG5zwK3vqKN5zEsS6MPQT6e/91t6CpQsqV
 uNC/nrbYHm2MCDi903axLDs3z0e+gcyeyPyy/zlZMZJGJMW2+ER25G1Zqw9MsxWx+Vkq
 Q6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740369225; x=1740974025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1VxqJlXQLRAXQsTUsNU8uC+4iuKdQ8cSmKPGsRjfcf0=;
 b=QEt0Lhixp6pDuq+1jqYHmrcNjMOXO7hKOA/AmFFHhlJuAtyvcnme+Mp/f/QyCylSIL
 v1eCdF+JM4mIB/dH5mPgDIVnHoSXqS0UIqFhCEGM4LTWbH8bc4iVRAgwNZjeTVXEpxuj
 hGyxsZcJ7fWz69nH1s+Kn2/Uf/Jb0h6HbAcUPMa8HXbKg3aoyhqXpd/TYQSC37kVenhK
 uZ/NgHrG2FPn3DnbqnB9lASjDFFxkpW/NKL9h9m/60+rhu5B4VqkX41flZs89TEn6jDa
 DaahufU+abwDjYp7wyucDL1VvfQPAKt4PWhAKo6nwvIRaeTCfAc/7ClU1nsU35vYr9bt
 FZdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdezHaK9E3UoHj2649SruLAyojh5X0IOMEiA0xN0VfLcx3Emh881Ic65Pc5igMnYrtuydxx7mDzj6L@nongnu.org
X-Gm-Message-State: AOJu0Yz+vok6aYr9+kIrA7GMdFCZpMGK3MQmEYTmTuMkS9ydapfLQ/Cm
 M8B/5BtT2CytmjB4I4B1+63vbpIhM9AhViTg8EVDYRE1NHLC5qKo+8EeqENyZtRjYB1bij9jjgk
 DbAOCNW8SxMZkkRIHVEiwa3zzbM8=
X-Gm-Gg: ASbGncuJP3L098u1AgD8jymFFhd35CKAdGVpwJPztU7IlGTUcbmKNXJFm1qDPQa3jjo
 LH0/PeXa/1g/kHdZlWpJ+ZNF0pwzv//V8Fl74I9UHEMAqKGcKAfzI4JZpSswyjHGw6Bf9x/VWI4
 Vj0F+cr6pUhwnOicf/ah+JH6uxV0zo+jkqWS90
X-Google-Smtp-Source: AGHT+IG89oY+QYLzmLefpgZAcBlxG9XYQfLoCrEdTCWoLF3PF+HYqPDp3IQd9Gl6j2SVtUrlAWqeH0Jyz/jIdVT5gvo=
X-Received: by 2002:a05:6122:421a:b0:520:3536:febc with SMTP id
 71dfb90a1353d-521efcef48fmr5359987e0c.8.1740369225610; Sun, 23 Feb 2025
 19:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20250221135735.85151-1-vladimir.isaev@syntacore.com>
In-Reply-To: <20250221135735.85151-1-vladimir.isaev@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 13:53:19 +1000
X-Gm-Features: AWEUYZlrFTmMxFiESzul22Ez52KbnNRXGD_fxd6Vm5DWBO73syccJyLhaX76sn8
Message-ID: <CAKmqyKMbdWpNeb6xz5T-xfFh_BHkzZY_JCBH5etNLF7PK1HFTw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: fix C extension disabling on misa write
To: Vladimir Isaev <vladimir.isaev@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_MXG_EMAIL_FRAG=0.01 autolearn=ham autolearn_force=no
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

On Sat, Feb 22, 2025 at 12:00=E2=80=AFAM Vladimir Isaev
<vladimir.isaev@syntacore.com> wrote:
>
> According to spec:
> Writing misa may increase IALIGN, e.g., by disabling the "C" extension. I=
f an instruction that would
> write misa increases IALIGN, and the subsequent instruction=E2=80=99s add=
ress is not IALIGN-bit aligned, the
> write to misa is suppressed, leaving misa unchanged.
>
> So we should suppress write to misa without "C" if it is enabled
> and the subsequent instruction is not aligned to 4.
>
> Fixes: f18637cd611c ("RISC-V: Add misa runtime write support")
> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
> ---
> v2:
> - use env->pc instead of GETPC() since GETPC() is a host pc;
> - use !QEMU_IS_ALIGNED(env->pc, 4) instead of GETPC() & 3;
>
> ---
>  target/riscv/csr.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index afb7544f0780..8aa77c53a0db 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2067,11 +2067,13 @@ static RISCVException write_misa(CPURISCVState *e=
nv, int csrno,
>      val &=3D env->misa_ext_mask;
>
>      /*
> -     * Suppress 'C' if next instruction is not aligned
> -     * TODO: this should check next_pc
> +     * Disabling 'C' increases IALIGN to 32. If subsequent instruction's=
 address
> +     * is not 32-bit aligned, write to misa is suppressed.
> +     *
> +     * All csr-related instructions are 4-byte, so we can check current =
pc alignment.
>       */
> -    if ((val & RVC) && (GETPC() & ~3) !=3D 0) {
> -        val &=3D ~RVC;
> +    if (!(val & RVC) && (env->misa_ext & RVC) && !QEMU_IS_ALIGNED(env->p=
c, 4)) {

env->pc has a stale PC unfortunately

See https://patchew.org/QEMU/20250220163120.77328-1-vladimir.isaev@syntacor=
e.com/#97bea0ff-f93a-45a5-b8ec-2bb91e37f143@linaro.org
for details on how to fix this

Alistair

> +        return RISCV_EXCP_NONE;
>      }
>
>      /* Disable RVG if any of its dependencies are disabled */
> --
> 2.47.2
>
>
>

