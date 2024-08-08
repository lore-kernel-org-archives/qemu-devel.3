Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144CEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 01:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbrsK-0001To-BA; Wed, 07 Aug 2024 21:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbrsJ-0001Sr-86; Wed, 07 Aug 2024 21:23:31 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbrsH-0005N0-N9; Wed, 07 Aug 2024 21:23:31 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-493d748ba72so147870137.3; 
 Wed, 07 Aug 2024 18:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723080208; x=1723685008; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vg7okiYsNqaUBQTojGB2GxEZhpyZbjMU+czVbHdw7sI=;
 b=IUxiOJZuS0K2Us+DKOu/N8uH49FtrYI6q6KiH8fHi6ztJd8m8bHX2fCgybWd/gMXsF
 MKad0aEhSNj+M1ZiScnZHSKJ2pxWU0mWlZmO86KpWhnJAXoKEs2/eKzXOdShD82Jyiuj
 w0/+80gYi3eudAQynlERvoHXJ2KR8qmy8HSppzy8cfcT0DJ4oCEcFAYGNQGJ+81/uGLv
 QaT9XmuEmYx2PGin1z9sUAtfrgg8R7BXcpDt/JFkNjqXJK3BptEQd8ZDqBgLLwhacHl7
 p12PdGWYHwIkfjboMgUALpnwAUiyE+V4Wg7hbX7/3Uwvgqgu3GJNhjk5rKiMvrcOgjr8
 7x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723080208; x=1723685008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vg7okiYsNqaUBQTojGB2GxEZhpyZbjMU+czVbHdw7sI=;
 b=hO17uo0E+dlZmbP4lEqaj7rj8EGuBDhfQak9ovSc8yO2BDh60CK7EJxsOrRg1ZcYY2
 0Kx0QjJGAxBnx4rWeDO8dHAETXVDuFHGq/yI7BGCnUVoXpu0LdBkdKnDhlHnEcaqNA+7
 PnxXCjwbRe/4++H36XIBjYWw17hb/GcGxgpM+Ol0klEoyoVt+SrnVJvXWgxykothTFvn
 rIHqr7kaNj9yVWCfkfthQDB3BxZT6hY6bKN5qj7Wf86nAcOyRfu8nc50+O+8DzJkx7sR
 aNZYF9grzOpnIYQHEx/QeYwQjRJCm8/E+tBRjtn7h1nch5sfJ4m2Rg/uEn6OAdWmHYB3
 SMSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhKGr8n2Xj6yf0/p5OUEcSjYZk/YH8c3pTig6nTwdtYkmZznaU5UOt/u7Qcf+xJEER6eHUZa/plSKf@nongnu.org
X-Gm-Message-State: AOJu0Yx6Zd1AoixTT/uxgzJi2XJg/rAR2lXj7u3QR1cYZe2XNR6C562W
 HdzI90loOE4Bek5UzHnWsFynHXGR0PT1khUNQs1WLt4gN7vtk3eUlfju/nb0Lsn8mtWJm2UQi95
 xstJAhcTykbHckhnpNsh9N1Kx34k=
X-Google-Smtp-Source: AGHT+IHFGTnRc6DIJ20XiiYpiVTeDJ7CfvOB913fygVWfz8SJC/oIhwDSndG12DJ41f58TBkBDdFiMTmjLiHiIGfU+8=
X-Received: by 2002:a05:6102:3052:b0:493:b719:efaf with SMTP id
 ada2fe7eead31-495c5c33af9mr595748137.20.1723080208100; Wed, 07 Aug 2024
 18:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240722175004.23666-1-jason.chien@sifive.com>
In-Reply-To: <20240722175004.23666-1-jason.chien@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Aug 2024 11:23:01 +1000
Message-ID: <CAKmqyKOTNuW6UFqedmtkwM+sQGWUr+9z2huZ9AaMMUiTKSW9DA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add a property to set vl to ceil(AVL/2)
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

On Tue, Jul 23, 2024 at 3:51=E2=80=AFAM Jason Chien <jason.chien@sifive.com=
> wrote:
>
> RVV spec allows implementations to set vl with values within
> [ceil(AVL/2),VLMAX] when VLMAX < AVL < 2*VLMAX. This commit adds a
> property "rvv_vl_half_avl" to enable setting vl =3D ceil(AVL/2). This
> behavior helps identify compiler issues and bugs.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c           | 1 +
>  target/riscv/cpu_cfg.h       | 1 +
>  target/riscv/vector_helper.c | 2 ++
>  3 files changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..8f21171ffa 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2687,6 +2687,7 @@ static Property riscv_cpu_properties[] =3D {
>
>      DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, false=
),
>      DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false=
),
> +    DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl, f=
alse),
>
>      /*
>       * write_misa() is marked as experimental for now so mark
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8b272fb826..96fe26d4ea 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -127,6 +127,7 @@ struct RISCVCPUConfig {
>      bool ext_smepmp;
>      bool rvv_ta_all_1s;
>      bool rvv_ma_all_1s;
> +    bool rvv_vl_half_avl;
>
>      uint32_t mvendorid;
>      uint64_t marchid;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 1b4d5a8e37..825312552b 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -75,6 +75,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_=
ulong s1,
>      vlmax =3D vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
>      if (s1 <=3D vlmax) {
>          vl =3D s1;
> +    } else if (s1 < 2 * vlmax && cpu->cfg.rvv_vl_half_avl) {
> +        vl =3D (s1 + 1) >> 1;
>      } else {
>          vl =3D vlmax;
>      }
> --
> 2.43.2
>
>

