Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B124C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNJY-0000Pl-2p; Sun, 25 Aug 2024 20:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNJW-0000Jm-Li; Sun, 25 Aug 2024 20:10:30 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNJU-0001UG-Ps; Sun, 25 Aug 2024 20:10:30 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a429so4446287a12.2; 
 Sun, 25 Aug 2024 17:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724631026; x=1725235826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05dsszevZH+H1luYfZRCfwIL2RBJOpXMGjJwTXWyOK8=;
 b=Bggva4IpQqtqCxRySr9t3qLqlF/dYN8lhAJpQM7bXjcIsO52IzsQk4RFpVVx06sHDA
 FhP+HFxr/0VScFYEMVyrVhzLAZajdGFzIVqiYhFyt8edL0w5vibh9xc6pdM8mvGkRCcH
 /MljiI6jic4zUV5nsHELLEGRAAsiqhEOQ0qlzjQYUDJCoCmLoAGd4zCOzhZQGua9fdhd
 8OXOW7GdcMgo3vTAX1qkhxjizPSqzvGLARBZCrVOFif1Q8wIP1IRWUWfk3QsO+FWkOm5
 gD1gIwNGLRYOjhJdOtqF/94pOYkUyBaRfoFqEFnS1Je+lB4OXOUNlJjyt0lpp4gF3m6q
 Ol0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724631026; x=1725235826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05dsszevZH+H1luYfZRCfwIL2RBJOpXMGjJwTXWyOK8=;
 b=KsL4hpnZTENDRWSNeYYh6cO92m70Oz4AIcha+KLPxQvWZoXGcEwEvZMf4aJy4ML/KE
 pJWrWq9AcAkuL4imoZizmg5rSVXQlyJ/bzMndTFpDmN2YWjavoiX21zmqoTYwIt5HCRU
 KXQNu+jNDBPf5ImL7Im3kljqii7BQ5tYTUOzEqW9EKvrOSikdidOxiBNGS28Tr3gfdfb
 rIvTfROhuCj/IitCAiuMHyXN6ST3tx/ZBWMudJafYBnhyTx3Sy4s5eXI0ASbkeWoLpT6
 17lxWs9tTDnhV+f3M6CCDFBx8imeOfrkrD6Ci9k5VFY5TghrHYGldLktWnQTP6oW2Hor
 1l1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/NfwdpSpUIYnNuJFYbJzUaZ6hiBytP7RnWyp/lGAtYhBY4h25OgNqLAfPdLLYENw6XvzWC1YRqyaa@nongnu.org
X-Gm-Message-State: AOJu0Yyz3C1VB2VtoCBbCWlnAg3xgwhsegRAES7tawJ8kzUc2gNEVlH8
 DBSk7EDiaDJUy9WEfymuSKMONZDiC2pue7wjSzxorYRIpGatz12SsAnf3HiSEaBeBIp1FvmLXYA
 q+uH3GqIwYZo5HncL6gmi8av+hwo=
X-Google-Smtp-Source: AGHT+IHYaG46qWDLzXloHzZgAKKfqoVZDkruXb4tjTmWGzFBim6iZ6UdLDCRra4W1YJZWl6fTDGvFlk6uUPU8bfbM2c=
X-Received: by 2002:a05:6402:2808:b0:5a2:2654:7fc4 with SMTP id
 4fb4d7f45d1cf-5c089159ce4mr4814552a12.8.1724631025808; Sun, 25 Aug 2024
 17:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240824173338.316666-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240824173338.316666-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:09:58 +1000
Message-ID: <CAKmqyKMzb+vV3VgwRdWL6q5Dw7cvOQM+AGvu-akZ2nsoc-Gfgg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/tcg/tcg-cpu.c: consider MISA bit choice in
 implied rule
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Aug 25, 2024 at 3:34=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Gitlab issue [1] reports a misleading error when trying to run a 'rv64'
> cpu with 'zfinx' and without 'f':
>
> $ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=3Dtrue,f=
=3Dfalse
> qemu-system-riscv64: Zfinx cannot be supported together with F extension
>
> The user explicitly disabled F and the error message mentions a conflict
> with Zfinx and F.
>
> The problem isn't the error reporting, but the logic used when applying
> the implied ZFA rule that enables RVF unconditionally, without honoring
> user choice (i.e. keep F disabled).
>
> Change cpu_enable_implied_rule() to check if the user deliberately
> disabled a MISA bit. In this case we shouldn't either re-enable the bit
> nor apply any implied rules related to it.
>
> After this change the error message now shows:
>
> $ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=3Dtrue,f=
=3Dfalse
> qemu-system-riscv64: Zfa extension requires F extension
>
> Disabling 'zfa':
>
> $ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=3Dtrue,f=
=3Dfalse,zfa=3Dfalse
> qemu-system-riscv64: D extension requires F extension
>
> And finally after disabling 'd':
>
> $ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=3Dtrue,f=
=3Dfalse,zfa=3Dfalse,d=3Dfalse
> (OpenSBI boots ...)
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2486
>
> Cc: Frank Chang <frank.chang@sifive.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2486
> Fixes: 047da861f9 ("target/riscv: Introduce extension implied rule helper=
s")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b8814ab753..dea8ab7a43 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -778,11 +778,18 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
>      if (!enabled) {
>          /* Enable the implied MISAs. */
>          if (rule->implied_misa_exts) {
> -            riscv_cpu_set_misa_ext(env,
> -                                   env->misa_ext | rule->implied_misa_ex=
ts);
> -
>              for (i =3D 0; misa_bits[i] !=3D 0; i++) {
>                  if (rule->implied_misa_exts & misa_bits[i]) {
> +                    /*
> +                     * If the user disabled the misa_bit do not re-enabl=
e it
> +                     * and do not apply any implied rules related to it.
> +                     */
> +                    if (cpu_misa_ext_is_user_set(misa_bits[i]) &&
> +                        !(env->misa_ext & misa_bits[i])) {
> +                        continue;
> +                    }
> +
> +                    riscv_cpu_set_misa_ext(env, env->misa_ext | misa_bit=
s[i]);
>                      ir =3D g_hash_table_lookup(misa_ext_implied_rules,
>                                               GUINT_TO_POINTER(misa_bits[=
i]));
>
> --
> 2.45.2
>
>

