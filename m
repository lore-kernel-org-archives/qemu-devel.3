Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58D2C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VVK-000694-Pb; Thu, 03 Apr 2025 21:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0VVI-00068j-QK; Thu, 03 Apr 2025 21:05:53 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0VVH-0007aU-AJ; Thu, 03 Apr 2025 21:05:52 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-86d377306ddso722867241.2; 
 Thu, 03 Apr 2025 18:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743728750; x=1744333550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWoCiyYamvjBW+J1nk+9jUvaGWzMy3PufhfjvKuH460=;
 b=K7XldSolRPwx0VJnehF28YpS4UQPYY0x5hgXhoFRV93y4GeOVkisFsuMaS8mnMMDGD
 mLAjAqSZfP1ULFVAUg8X7Kgak92xQvdrQbhRMEUvGGmeJnhXzkFYqXUnFf28HaTWD2pf
 tV9G4OrvVTwmUB1yQHzs2XWALusaf1WQPp5Rab1e98cScA2wQdTwrEDo6j84sNF8c1JA
 Htj/SsIvAdLJguQKfCFRipYtgp/BL+IwWPdHIPO1OBVgZdKdThx8rT1psQMiF75SqAIc
 AKgcG8YJYcWHYyKorG9TenjJCZR17F5WM574FKASduqxKN1qhe3RdEUCTuqJYd0/QsK7
 knbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728750; x=1744333550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWoCiyYamvjBW+J1nk+9jUvaGWzMy3PufhfjvKuH460=;
 b=QMbKoGDMa6StQ6ttcnfM64acXWB+FlD2wm23JpaSZWFTJWPhgZ5HDxBiUrZdTyIEUf
 lslfqB0qV5y/KW0gaN6V4I/QSenfo+zK4r0EBHp5qpzFEno+FTsC7e3jVUPeh6fD7itx
 vu3SPxQ/flQ5G+vgLWMJF+iA/ESnqmGhBjEZ/fEjtObzEoQ8z5UTmaTKCjejz7ELtNQt
 +qY2T4bD/TL8Wr5vaGgD2q9i15wBlGvh9Dnolvq5vwy338VzUbWWKWJR/gzl4312GFiG
 JfOPW/3txRzG2YUrhvY1WqJrhm71syUprT3KEFmNh3MwKELTedxN1JAJjk6O2/pchpVR
 c/BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvU+k9mgodJN5Y+QBlCbwWyJ8mw746fnL1G9wEEL1Izdt6BXLaHuO+R2bt3AAG8m5/7+QYP/8mE+22@nongnu.org
X-Gm-Message-State: AOJu0YzLzBXQ/qpK/0c+gHV5mpJmmEc6fmLfcSQkGC4E3T+nXLe6hFl8
 Z3maKH1uCncernUebOs2zV7bhFRBF7Pml2RE8DimUHhp/Jep6xmC9D4rCAnGaFG8KA03J7MDB/G
 0inOSQhzPt56I0qnpQn9Ue0abVGU=
X-Gm-Gg: ASbGncssXaMyQZjFRGtMvrGBSUiLaKbP9jXPM8vKmibRxXA2qymzqXXxvDL4QQVo8Ij
 6O1GSnYkk+Yn5pUBwibnWD76aymAUlcJ8zfiOJ8EhemnSYIsGZ9BN9RcTpFN9ap5FGHNB2aUCUR
 n1Xb33DIJWOJPe+gb9qh7lwmdKUjiZkaKRdfvQrA4om2xPGkWvLMcGxgrU
X-Google-Smtp-Source: AGHT+IH76mYeELh4UB4z0prNCre1FoRMMwlZr/dAVsk9s7TTRv3KKlmIVUmveAxcg4BH9BHJmO3ieRGMe7hl8NVPOSU=
X-Received: by 2002:a05:6102:3e91:b0:4bb:e5bf:9c7d with SMTP id
 ada2fe7eead31-4c855484a7amr1275402137.17.1743728749858; Thu, 03 Apr 2025
 18:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-5-loic@rivosinc.com>
In-Reply-To: <20250313193011.720075-5-loic@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 11:05:22 +1000
X-Gm-Features: ATxdqUFUSWLTrF3k0itW7pICrl4MsSIdZNh0choxs9VqC9453H-Fc7EmLS7D3gU
Message-ID: <CAKmqyKMtNX9=-2QR3nCPGS8kGAJ_2uUT1-Le4ARkUQCdg4fkMA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] target/riscv: pmp: exit csr writes early if value
 was not changed
To: =?UTF-8?B?TG/Dr2MgTGVmb3J0?= <loic@rivosinc.com>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Fri, Mar 14, 2025 at 5:33=E2=80=AFAM Lo=C3=AFc Lefort <loic@rivosinc.com=
> wrote:
>
> Signed-off-by: Lo=C3=AFc Lefort <loic@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index c5f6cdaccb..845915e0c8 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -141,6 +141,11 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *en=
v, uint32_t pmp_index)
>  static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_=
t val)
>  {
>      if (pmp_index < MAX_RISCV_PMPS) {
> +        if (env->pmp_state.pmp[pmp_index].cfg_reg =3D=3D val) {
> +            /* no change */
> +            return false;
> +        }
> +
>          if (pmp_is_readonly(env, pmp_index)) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "ignoring pmpcfg write - read only\n");
> @@ -528,6 +533,11 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t =
addr_index,
>      bool is_next_cfg_tor =3D false;
>
>      if (addr_index < MAX_RISCV_PMPS) {
> +        if (env->pmp_state.pmp[addr_index].addr_reg =3D=3D val) {
> +            /* no change */
> +            return;
> +        }
> +
>          /*
>           * In TOR mode, need to check the lock bit of the next pmp
>           * (if there is a next).
> @@ -544,14 +554,12 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t=
 addr_index,
>          }
>
>          if (!pmp_is_readonly(env, addr_index)) {
> -            if (env->pmp_state.pmp[addr_index].addr_reg !=3D val) {
> -                env->pmp_state.pmp[addr_index].addr_reg =3D val;
> -                pmp_update_rule_addr(env, addr_index);
> -                if (is_next_cfg_tor) {
> -                    pmp_update_rule_addr(env, addr_index + 1);
> -                }
> -                tlb_flush(env_cpu(env));
> +            env->pmp_state.pmp[addr_index].addr_reg =3D val;
> +            pmp_update_rule_addr(env, addr_index);
> +            if (is_next_cfg_tor) {
> +                pmp_update_rule_addr(env, addr_index + 1);
>              }
> +            tlb_flush(env_cpu(env));
>          } else {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "ignoring pmpaddr write - read only\n");
> --
> 2.47.2
>
>

