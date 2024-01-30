Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2C7C47DB3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUcC5-0001ty-GZ; Mon, 29 Jan 2024 19:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcBz-0001oV-3A
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:41:36 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcBw-0002Dq-1Z
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:41:34 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4676a37e2c4so751894137.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 16:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706575290; x=1707180090; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2Lk5HVyBGBoFVy/SPPTpSyC9wQbjqykaNNwn6OlgPg=;
 b=MbwvFtD/ySlAu86LuPSDPl6VuATzhNqJik60jo2fWV/MIZgqFmx3019zF+1/Svs/o5
 EmI8j8d0Xf41L6mY+v1n/5tnzlymZt7MOWHrm/c66GBzcuNe5cUnmOh9Ic4ZpW6z4gu2
 e0pkQ9cP6pcmR4DUSOSwWs4kkvlsKQkN+CandET7kbCfpPgXzKQnKtKjCPO/mnZ31gOa
 NnS1qgoYMjpubS6ki45ivRmGLytLmGrxvqEK0dEXs12TeUD7jSRdledzW+lhhz7ezj2p
 aJZri8X6V86ZBDxUnvLXOCl0ehkjtPcT7XnVjJKh9KN/T+w8bQ1lRScPDwHULM9c8G21
 Xb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706575290; x=1707180090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2Lk5HVyBGBoFVy/SPPTpSyC9wQbjqykaNNwn6OlgPg=;
 b=SlUpblBGxkwRJXs/leLkrTPI73p+8v1wu/LczjQ9VXU18Oh63lNZHsPxnoiP/rJ+UZ
 PFryNOR9im1bL+wCn/MALTnYOpQBnyuIymkt5Kcd0KkW8TsBAfYtcC/H24IkmroKHgRg
 XkQh34Ai++4WiprhpapZsxpQA0aqQvU3ve/5dXBHrHrNPYQoPFomOxHkzuHgr+j2psSw
 gBJ4r9ZjEhssZrs3X+tYDLdCm9AvSLUteIGWqcCd3bYDkTcZW9FxgQ8IiE+gSXDcEP26
 v1ghQzr2L8Pzf5XwOQG2JXtmB7+6OXv9uuk+rg1N4gg43Xdq1MdJS2bMbU0cqlcCWdIY
 GY8Q==
X-Gm-Message-State: AOJu0Yx1rZ5apFF4joVnDamMdsnRiAW3+Pc7dPqlT06QZc2U3ZvGcIli
 qLlBOdjbC1uDCOdh3OfgMyHJ9KjLYWvsrTQssD+ir0tKGx0YiKihD0bfwK4x0C/6B5KckQb5Akf
 FK+IjfcDzLHJAqYUQQgfZzFQTqdiazItSQVc=
X-Google-Smtp-Source: AGHT+IEUeN79JALIpePhdUGsdkVwMHaGWYdh2UPUOStH++/erFg/c6Eiw2bVTPonnTrK09T/KA5OePY6Fkehxb2tr/s=
X-Received: by 2002:a05:6102:72f:b0:46b:1891:33e0 with SMTP id
 u15-20020a056102072f00b0046b189133e0mr3529932vsg.5.1706575290258; Mon, 29 Jan
 2024 16:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-24-richard.henderson@linaro.org>
In-Reply-To: <20240129233043.34558-24-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jan 2024 10:41:04 +1000
Message-ID: <CAKmqyKO8cNieQ-AfzVZUQLdayBvQX9SFXFoO205W6+L_myaT3A@mail.gmail.com>
Subject: Re: [PATCH 23/33] target/riscv: Replace cpu_mmu_index with
 riscv_env_mmu_index
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Tue, Jan 30, 2024 at 9:36=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use the target-specific function name in preference
> to the generic name.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c    | 4 ++--
>  target/riscv/op_helper.c     | 4 ++--
>  target/riscv/vector_helper.c | 9 +++++----
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 15f87ecdb0..b6b23b7d03 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -106,7 +106,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *=
pc,
>  #else
>      flags =3D FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
>
> -    flags |=3D cpu_mmu_index(env, 0);
> +    flags |=3D riscv_env_mmu_index(env, 0);
>      fs =3D get_field(env->mstatus, MSTATUS_FS);
>      vs =3D get_field(env->mstatus, MSTATUS_VS);
>
> @@ -1200,7 +1200,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, =
vaddr addr)
>      CPURISCVState *env =3D &cpu->env;
>      hwaddr phys_addr;
>      int prot;
> -    int mmu_idx =3D cpu_mmu_index(&cpu->env, false);
> +    int mmu_idx =3D riscv_env_mmu_index(&cpu->env, false);
>
>      if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_=
idx,
>                               true, env->virt_enabled, true)) {
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 5355225d56..f414aaebdb 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -157,7 +157,7 @@ void helper_cbo_zero(CPURISCVState *env, target_ulong=
 address)
>  {
>      RISCVCPU *cpu =3D env_archcpu(env);
>      uint16_t cbozlen =3D cpu->cfg.cboz_blocksize;
> -    int mmu_idx =3D cpu_mmu_index(env, false);
> +    int mmu_idx =3D riscv_env_mmu_index(env, false);
>      uintptr_t ra =3D GETPC();
>      void *mem;
>
> @@ -205,7 +205,7 @@ static void check_zicbom_access(CPURISCVState *env,
>                                  uintptr_t ra)
>  {
>      RISCVCPU *cpu =3D env_archcpu(env);
> -    int mmu_idx =3D cpu_mmu_index(env, false);
> +    int mmu_idx =3D riscv_env_mmu_index(env, false);
>      uint16_t cbomlen =3D cpu->cfg.cbom_blocksize;
>      void *phost;
>      int ret;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index c1c3a4d1ea..fe0d5d053c 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -113,14 +113,15 @@ static void probe_pages(CPURISCVState *env, target_=
ulong addr,
>  {
>      target_ulong pagelen =3D -(addr | TARGET_PAGE_MASK);
>      target_ulong curlen =3D MIN(pagelen, len);
> +    int mmu_index =3D riscv_env_mmu_index(env, false);
>
>      probe_access(env, adjust_addr(env, addr), curlen, access_type,
> -                 cpu_mmu_index(env, false), ra);
> +                 mmu_index, ra);
>      if (len > curlen) {
>          addr +=3D curlen;
>          curlen =3D len - curlen;
>          probe_access(env, adjust_addr(env, addr), curlen, access_type,
> -                     cpu_mmu_index(env, false), ra);
> +                     mmu_index, ra);
>      }
>  }
>
> @@ -464,6 +465,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
>      uint32_t esz =3D 1 << log2_esz;
>      uint32_t vma =3D vext_vma(desc);
>      target_ulong addr, offset, remain;
> +    int mmu_index =3D riscv_env_mmu_index(env, false);
>
>      /* probe every access */
>      for (i =3D env->vstart; i < env->vl; i++) {
> @@ -478,8 +480,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
>              remain =3D nf << log2_esz;
>              while (remain > 0) {
>                  offset =3D -(addr | TARGET_PAGE_MASK);
> -                host =3D tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD,
> -                                         cpu_mmu_index(env, false));
> +                host =3D tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu=
_index);
>                  if (host) {
>  #ifdef CONFIG_USER_ONLY
>                      if (!page_check_range(addr, offset, PAGE_READ)) {
> --
> 2.34.1
>
>

