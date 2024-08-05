Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB14C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 02:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1san6h-00050e-Jj; Sun, 04 Aug 2024 22:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1san6f-0004xk-5r; Sun, 04 Aug 2024 22:05:53 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1san6d-00076m-Je; Sun, 04 Aug 2024 22:05:52 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-825eaedff30so1939842241.0; 
 Sun, 04 Aug 2024 19:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722823550; x=1723428350; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4u8RxcCkbfbJnyRI7AhVyk+gymq8R5qSK28f0IIUWwI=;
 b=llJDlMZ4O5V7CwdvlEKfZIb+iTx9dNIap4pcdaZZ+NZordXvHyKiI/3P6SOyVz3aUy
 leesj93rCV9tuUq660h8GrWgcm3QKhtJt348xDjs4aCc3znbHudVdyI4oX+nGx70QUDR
 FbJ4bJawKW+qAlqDu8w3240vW1Xks6U2j1p/7pO+hxrGsVigfSFqfUrgTRpqfawI/d0z
 R8I02RF0jRC4+/63HDIEqlfP657Qz6Jx/buHSmv6BAPd0YhsllArvdoEzsdAX570Oxek
 QxO87NGidrpK+h4YaOmWByld3hcZ6GEgVJ1mLdu04C6wIyVyddmEH7tbC+96MG1G000s
 2LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722823550; x=1723428350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4u8RxcCkbfbJnyRI7AhVyk+gymq8R5qSK28f0IIUWwI=;
 b=nboDGb12Ka4HYZBD9+h1ysbfxmmnlI6ACrJ7nCLQmuQrAqdyO+bWZyFBATLA1NhSVR
 2KWh9ECs9YuKqIkw+DRN6l3H3/gVFYHZoxs4qkB8YZMSNc0xaAqX6kAc+PWZtlwhzMZ1
 bZDz2JePN0m0nZlEChHTaj/reD6v5Mcn9kxEdQ+yk+sWLxIrKE2ZlQZQiAamvhVxgyZv
 byZREYG240f0yft2sHSfOSaNnjqVm5vUCzdnOjmO/TcE8AG5FDbBdV7LaYZfIgvuUYu1
 gv/roFEKKYuDoWELv852TAfb+0p8VRx07of4uiuU/VValNLPsO5xwYbUVHfezrc6VHeC
 Tyeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqvkuipHVwhy9hne5qGAt9DdapkW34BI8fk0dIMZGmZfbGY+CAXo6nmM1ykGAJzZxR2a8A+MoxEPyuU8tL09qJ8eXLKp0=
X-Gm-Message-State: AOJu0Yx92P3swLQDbpPaiiM9erH8kgDkC7okeJnhiuhOIG5l8D6lekuf
 1wA5nSGFndTAh6lZsNDeQQbBKDm8hY+Y1Rshqqow91XwwvHte92L/+BgDR1c/9w98fkAk7la/k8
 UUe1FTzqLHw0znGHVeMJci37Hs9zy/rxt
X-Google-Smtp-Source: AGHT+IGQul+2BxcgRnicnQevyliAjwbwzbEBXlfyN7PxbI2hgX4rcbZhlM3W3zc9WTylyt940SrCiEgGXZu7nQuS4ec=
X-Received: by 2002:a05:6102:162c:b0:493:dbbc:7d56 with SMTP id
 ada2fe7eead31-4945be0a4e3mr6690661137.8.1722823550069; Sun, 04 Aug 2024
 19:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
In-Reply-To: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 12:05:24 +1000
Message-ID: <CAKmqyKM0Gjo4MybfTQz4oax4hUPAJVziq2EAgNbLhwirvYz7WA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add asserts for out-of-bound access
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Wed, Jul 24, 2024 at 6:33=E2=80=AFPM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Coverity complained about the possible out-of-bounds access with
> counter_virt/counter_virt_prev because these two arrays are
> accessed with privilege mode. However, these two arrays are accessed
> only when virt is enabled. Thus, the privilege mode can't be M mode.
>
> Add the asserts anyways to detect any wrong usage of these arrays
> in the future.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> The lore discussion can be found here
> https://lore.kernel.org/all/CAHBxVyGQHBobpf71o4Qp51iQGXKBh0Ajup=3De_a95xd=
LF=3D=3DV_WQ@mail.gmail.com/
> ---
>  target/riscv/pmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 3cc0b3648cad..e05ab067d2f2 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -204,6 +204,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVStat=
e *env,
>      }
>
>      if (env->virt_enabled) {
> +        g_assert(env->priv <=3D PRV_S);
>          counter_arr =3D env->pmu_fixed_ctrs[1].counter_virt;
>          snapshot_prev =3D env->pmu_fixed_ctrs[1].counter_virt_prev;
>      } else {
> @@ -212,6 +213,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVStat=
e *env,
>      }
>
>      if (new_virt) {
> +        g_assert(newpriv <=3D PRV_S);
>          snapshot_new =3D env->pmu_fixed_ctrs[1].counter_virt_prev;
>      } else {
>          snapshot_new =3D env->pmu_fixed_ctrs[1].counter_prev;
> @@ -242,6 +244,7 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState=
 *env,
>      }
>
>      if (env->virt_enabled) {
> +        g_assert(env->priv <=3D PRV_S);
>          counter_arr =3D env->pmu_fixed_ctrs[0].counter_virt;
>          snapshot_prev =3D env->pmu_fixed_ctrs[0].counter_virt_prev;
>      } else {
> @@ -250,6 +253,7 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState=
 *env,
>      }
>
>      if (new_virt) {
> +        g_assert(newpriv <=3D PRV_S);
>          snapshot_new =3D env->pmu_fixed_ctrs[0].counter_virt_prev;
>      } else {
>          snapshot_new =3D env->pmu_fixed_ctrs[0].counter_prev;
>
> ---
> base-commit: daff9f7f7a457f78ce455e6abf19c2a37dfe7630
> change-id: 20240723-fixes-439b929bfbc8
> --
> Regards,
> Atish patra
>
>

