Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED58C3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 07:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXFb8-0004XD-VV; Fri, 26 Jul 2024 03:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sXFb6-0004UV-DR; Fri, 26 Jul 2024 03:42:40 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sXFb4-0000JW-OI; Fri, 26 Jul 2024 03:42:40 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-822eb80f6e4so129147241.2; 
 Fri, 26 Jul 2024 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721979755; x=1722584555; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GA1qr8yeDLRPXG0TWGtCqV7FBMHeUGOmsI1YwaYk1w4=;
 b=mX7gYisqCZh1srbOib8DJEf4IaGt8M03HdRSFL+tspVWlzT/9rt/5fdIK8M5RKluq+
 dBCR6npC+Bj7/C4TnrzLxtHEJuJe4or+x69AtyouyOoEqyKBxI3XTNBAI12tMKylcV4R
 LddsDY/gBp7efpbM6+dKnP+MoJg6bR8SsbW2yR6vytUFePGxXLYMJ9HFDfEEkN/YfKIz
 5DggXo+qKxDdIfyGorjVZJCFXSjmLMBZeR8O2vru4OWl/PPpi9dPPLEmdph/BYc1VXRM
 ZqzS1R1DXJ3AoACYSeYtgb2pydLphi2xtzTupdkQGLCk/zXcAytOYbWGB8jl7C2+UTdZ
 s/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721979755; x=1722584555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GA1qr8yeDLRPXG0TWGtCqV7FBMHeUGOmsI1YwaYk1w4=;
 b=LvHqfYQ1U8qudCEFMZBEynfn4Pd+7NwMCw1eN/0y05e3aojeZ5BoLwPvRujMQ0bWXj
 otFLXn0znNTpW+W1TZTgF0ys7toezo2CG9GjRT3sLvcgNHTW8qH8jS5uEwQanQ5EkxGM
 ROyctVZ0GewEyDfzxrxlYzGt76rfaJPuE6d/K9M4rhJ8L21YnNBT4piICcx8UrD5dxyz
 Sd3wcwSP6mS0riE9MtclhaDNBsUGBwupuaNvmwGjtjXShSVeYWL3m1PMn1epigBAy5FJ
 cY+8O/QEfP5XZ4kMJtYBoK1bbJ0DsApbUutSM+k9wRivOjbAINySTSm9QuEh1k4NosnN
 0PlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyiRgFa9e3aBdblhru3WDThBT7lddu2YGi/+Go3OjzFJxI/PEK3LkrqtGrkdbMiPCkcSGEO4Q9VTZUalfxvnC2A6D5hH4=
X-Gm-Message-State: AOJu0YyY8xOdVFiQl5k1tbKQ6Lq4w9je5fVzb9Ok6yy86hTB5qiNhQ8n
 uqbYr/5IR91h4wjF61KeQX5oUgtu/DNbvWGxBhApW3vC55/xffloyZJ20Ab1f2jXnF8rNa9M83l
 fQNlTd+v++uZRtIO1SHVQCUAMMgA=
X-Google-Smtp-Source: AGHT+IEJ8zFmm0cCnr2DoFmkl02+Y4bnVsMka7jejimIXljkgg/9KlHZ6aMDfJK+l6HIsNoUGbrFW4V709oXupDgfJo=
X-Received: by 2002:a05:6102:568b:b0:492:94eb:5769 with SMTP id
 ada2fe7eead31-493d9ac510amr4087034137.15.1721979754940; Fri, 26 Jul 2024
 00:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-1-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-1-c4170a5348ca@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jul 2024 17:42:08 +1000
Message-ID: <CAKmqyKPEWgA=s5sokPG2_v2qdbuaHwdGf6RJzqFfL15Htq=vBA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] target/riscv: Add properties for Indirect CSR
 Access extension
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
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

On Wed, Jul 24, 2024 at 9:31=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> This adds the properties for sxcsrind. Definitions of new registers and
> implementations will come with future patches.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---
>  target/riscv/cpu.c     | 2 ++
>  target/riscv/cpu_cfg.h | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3bace..ebc19090b40d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -183,12 +183,14 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
> +    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_12_0, ext_smcsrind),

This is actually part of the unpriv spec, so it's a bit weird that it
depends on the priv spec. But that's how it's all set up.

But shouldn't this be PRIV_VERSION_1_13_0?

Alistair

