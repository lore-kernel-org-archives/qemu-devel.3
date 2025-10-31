Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC059CCF9F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEfIv-00062h-8T; Thu, 30 Oct 2025 22:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfIt-0005va-0l
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:55:51 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfIl-0003pK-DY
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:55:50 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c1a0d6315so3631635a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761879341; x=1762484141; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhIf6wW3+KrXXh4jwlvQYs4gdq3qb1YBkK1I+C6N9/M=;
 b=kelxVdjuyfkIYzgO1kOZ/hnpyOsKoCAwyPDh9/cuZc/EKmhQfeGWVlBcxDhrN58odT
 2kT6z9sD2SNEEC4swCft1zsZuS6heXq6bSfVgvBOebttk8Z8Mv8BSP6t+AyUEybbEead
 Ib8CvZIC35x/mcwEXNDUZm2iT9NAwom9lviqxNnZcpNhoChnk9KdjV/Gg5rPriY/jObS
 o5QkrJr83nRYTmqcaPvnoRXb7dIA3BG024rr8XjKpzgwIgBAUBkSQ9doW5j+5eTWaLBN
 osl+/3MFhIqYrQTPYqjUKiACB343M7m79zQi03AeLLBiXe1JTyitnb0RIGVCxk5vcVW3
 89HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761879341; x=1762484141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhIf6wW3+KrXXh4jwlvQYs4gdq3qb1YBkK1I+C6N9/M=;
 b=CTLHROPijgW9bwJxIPFgDlu7PWRJbZRO9hlM+GpZ6gSZponYnlihv6mSZn7tNR6CX4
 bFKU2L2GeZOoEV9OpSM35jZuakGFR2MjOXhWY1jOQ7zhvPh4VvWLIy6ZnisiYhCplspR
 gjUWavbhGOlgq2FYgSNNiJx7LRozFRbRQiM1N2DtYe2fpcvTogCexkZbjpQEBV7JwG3C
 n9aswXeQ9L+6a5vguJJ66kwyW/uUGFY0YBma+ROsDtLvF8Tdtch28psZ32b3SdDJLK4X
 HSTD/F06+d1F1yNl2zK2AjEezN3TYVNz18kqd0jkNnXg2OxAXRjnizGBvtD6Jhh6w/SN
 bdpw==
X-Gm-Message-State: AOJu0YyZUgiMJr8RaRC2RqmyVxDU3toMwvyCwlbfrVRTGMmpk9DMkalQ
 LO4r6aI4gMFsAJ6VGmBsKA9UJAyKHfWunj154kxE6ES9Bcuny9ByGtRsBxiMxxy21KWcCRB294p
 FlQ9fWYkHt3IVB9oQw12MS1BwSXeJeAc=
X-Gm-Gg: ASbGncuBj5drRxh2TWbqEo89ltvzxxBVsQE+rdE5gQufOqn9rW4sbc+QgsLlIgIJovo
 uaerfzyZPhQ17B2YpE6eLRJ9okELmj85xYaXE7EYNnje/43PXjyUZGpp6Fvjamahw92gn09QRE0
 udDQd2s078I1OuX90nlgCBD0br7EcYe2lCVFg07U1nhX1cuExjpixruoEJkpJMny2RZ57KX6bJT
 pSXlbexEZbbaG7ha+gp29joopT5RVhn42Kx/FnsMvCTOqWDqB9K0r7GWuJjKCC4M2dR129N2HAH
 2K/c0n2GbvKmO7c9kJuWaOvk0g==
X-Google-Smtp-Source: AGHT+IHt9N3M0INwFnE/kk2Go9wjbnFpeX695dbxlr5YG2IuuDTlQxnbQLfFrHIg9vnbt8St1kV0uqoUDsPCe38xk3E=
X-Received: by 2002:a05:6402:1e90:b0:63c:1417:c185 with SMTP id
 4fb4d7f45d1cf-64076de3473mr1403662a12.0.1761879340529; Thu, 30 Oct 2025
 19:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-30-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-30-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 12:55:14 +1000
X-Gm-Features: AWmQ_bmcZtg3vw85SlqCLHIK1tQXstMo3dHpGsAjvjiuqcG3u0T79uaaPu24NY8
Message-ID: <CAKmqyKNC1nOH=QFaFs=vyDkkBLUKr9fs3LeqQA_+vXuLmtcaoA@mail.gmail.com>
Subject: Re: [PATCH v4 29/33] target/riscv: Fix size of mseccfg
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Tue, Oct 28, 2025 at 4:23=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> mseccfg is defined in version 20250508 of the privileged specification
> to be 64 bits in size.  Update relevant function arguments.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 2 +-
>  target/riscv/pmp.h | 4 ++--
>  target/riscv/pmp.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 153480846a..cc40d6c86c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -464,7 +464,7 @@ struct CPUArchState {
>
>      /* physical memory protection */
>      pmp_table_t pmp_state;
> -    target_ulong mseccfg;
> +    uint64_t mseccfg;
>
>      /* trigger module */
>      uint16_t mcontext;
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 271cf24169..e322904637 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -69,8 +69,8 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_=
index,
>                        target_ulong val);
>  target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
>
> -void mseccfg_csr_write(CPURISCVState *env, target_ulong val);
> -target_ulong mseccfg_csr_read(CPURISCVState *env);
> +void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
> +uint64_t mseccfg_csr_read(CPURISCVState *env);
>
>  void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>                         target_ulong val);
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 3ef62d26ad..0b23b4b8ed 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -643,7 +643,7 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uin=
t32_t addr_index)
>  /*
>   * Handle a write to a mseccfg CSR
>   */
> -void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
> +void mseccfg_csr_write(CPURISCVState *env, uint64_t val)
>  {
>      int i;
>      uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;
> @@ -689,7 +689,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulo=
ng val)
>  /*
>   * Handle a read from a mseccfg CSR
>   */
> -target_ulong mseccfg_csr_read(CPURISCVState *env)
> +uint64_t mseccfg_csr_read(CPURISCVState *env)
>  {
>      trace_mseccfg_csr_read(env->mhartid, env->mseccfg);
>      return env->mseccfg;
> --
> 2.51.0
>
>

