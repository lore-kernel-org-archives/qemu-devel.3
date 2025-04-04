Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F3AC3601B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VRF-0004Jf-4q; Thu, 03 Apr 2025 21:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0VR6-0004IU-DT; Thu, 03 Apr 2025 21:01:35 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0VR4-0006lA-Cq; Thu, 03 Apr 2025 21:01:32 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-525b44b7720so729746e0c.0; 
 Thu, 03 Apr 2025 18:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743728488; x=1744333288; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9ZN+uaVkysmdETJU7nCMCOT4x8hY8tA+eCd1RjHnNc=;
 b=UjQYTG9MZlbQP8qPN4eU++BBgB2QFTscInP8mxxRknHcJWL5zAYfUXInIz2V+yMAHN
 2NAPc7htCKbcqTwgSDHzCVSNCiCEPRoBmMPZg4f/t+rWZ/jhMBVYXtrv1H4M3TVSIHK5
 AtTHNF2no6/+wHZbJX6ZVpHkrm2fmaYLXeSzRsAwfr68FnYkp1x+Fj2n/knyr0vARe1u
 OlhZlaGUgr0KFLEOXFihZBg1qnjJLDbR/nuUv4WD3mg2nIkb+kRbiKnCiZulz4fdfnc3
 OMy9aND4jWksoYwaAh+2IP70U4+e/30/0Y2hEOwsePwnmjjfWlVnPogWK8pBtw7DdaQL
 liZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728488; x=1744333288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9ZN+uaVkysmdETJU7nCMCOT4x8hY8tA+eCd1RjHnNc=;
 b=tRPYnOe/MpLf7lvOaqs1kC1cEzEvqI/hWYgU8tLQnP7NK/9Cx+eoS28CikO6HMwru3
 sZ2yxmRsnQNvPP2QuDXy2+pEB+ijLz++UmI6TxEP1VJOftcsJkCh+3BD0/C8uuu8whAR
 ibfl3orS1yCNeGlOCFnlVqnmr2uOqd7CrZeM/ecDhNZBjsnNbliZfi+aZMJaKxMIQTLL
 24iZpvhFxkF9QzgDd+aHdnzNYTuxKqe5+Z5cvL9tw877ChH+G64Fg+iXFTJ8dV/btDb+
 JktH1dpDBPGobMpTdFtrK34LKuSCmMnrtipSSo70IJ+Mn2XvM0/HXo018F9WhhTobkFa
 bdoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX5k5L1tUwP746PxCqPd0Hfk4JWiN9LAcMURAJjz7KR0DLngj5YXASdGdHlKaQsgzxW0uAKJHiLHqG@nongnu.org
X-Gm-Message-State: AOJu0YwnUXzZfIG9d/YB1Wh0we9rtCpLspMaD0uE2u79JNL42eUXhTCe
 /q7jRPU4UeVgBQHZ/XLAcEZs0T3XVHMTqSzFXt7b9nHptpZlEho0RhwAbOJidGLvbTFNs9ygaZz
 /gzf6B3XyimtSCJDb3cgWIwYEWM8=
X-Gm-Gg: ASbGncul5SKMhLdRZJdvQdMP8qy0HdXRLHezCH80Y/vO5O4WgrsvVo3hS3j3PJQov9t
 e8B0NA2ZH4TazQ4bjSLAXMwrqoUPv1M+hlmJIwzNa/gNiXBiNwEMBiau9ppvSHHc+x8VFHNsaEF
 wLC/Yn0OA70gqCGa9KR1Np1/fmHbnQbSDDyviYySOxZKeYpkGLrvQBV7Un+G6riKyarpM=
X-Google-Smtp-Source: AGHT+IFA5HMQcVw5lpGwRdDWkSHEoWhxnAl2xQ2T2IV45Vq0WUVF569XwS7i3co0UPQeoUx8azWuLC745e8jJbi/K/A=
X-Received: by 2002:a05:6122:181d:b0:524:2f10:8bc8 with SMTP id
 71dfb90a1353d-527645b7bcdmr1334483e0c.11.1743728487800; Thu, 03 Apr 2025
 18:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-2-loic@rivosinc.com>
In-Reply-To: <20250313193011.720075-2-loic@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 11:01:01 +1000
X-Gm-Features: ATxdqUHHqHS0_YVFchDqHbkres6D3V-jNCAlXlJjz1tu06qWWQLqaUbLqbvBx60
Message-ID: <CAKmqyKMcNC061cMmumd-jW_AWPCnFHePxWEMxxX5FZAynGE-zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] target/riscv: pmp: don't allow RLB to bypass rule
 privileges
To: =?UTF-8?B?TG/Dr2MgTGVmb3J0?= <loic@rivosinc.com>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Fri, Mar 14, 2025 at 5:32=E2=80=AFAM Lo=C3=AFc Lefort <loic@rivosinc.com=
> wrote:
>
> When Smepmp is supported, mseccfg.RLB allows bypassing locks when writing=
 CSRs
> but should not affect interpretation of actual PMP rules.
>
> This is not the case with the current implementation where pmp_hart_has_p=
rivs
> calls pmp_is_locked which implements mseccfg.RLB bypass.
>
> This commit implements the correct behavior by removing mseccfg.RLB bypas=
s from
> pmp_is_locked.
>
> RLB bypass when writing CSRs is implemented by adding a new pmp_is_readon=
ly
> function that calls pmp_is_locked and check mseccfg.RLB. pmp_write_cfg an=
d
> pmpaddr_csr_write are changed to use this new function.
>
> Signed-off-by: Lo=C3=AFc Lefort <loic@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index b0841d44f4..e1e5ca589e 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -45,11 +45,6 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)
>   */
>  static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
>  {
> -    /* mseccfg.RLB is set */
> -    if (MSECCFG_RLB_ISSET(env)) {
> -        return 0;
> -    }
> -
>      if (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_LOCK) {
>          return 1;
>      }
> @@ -62,6 +57,15 @@ static inline int pmp_is_locked(CPURISCVState *env, ui=
nt32_t pmp_index)
>      return 0;
>  }
>
> +/*
> + * Check whether a PMP is locked for writing or not.
> + * (i.e. has LOCK flag and mseccfg.RLB is unset)
> + */
> +static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
> +{
> +    return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
> +}
> +
>  /*
>   * Count the number of active rules.
>   */
> @@ -90,39 +94,38 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env=
, uint32_t pmp_index)
>  static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_=
t val)
>  {
>      if (pmp_index < MAX_RISCV_PMPS) {
> -        bool locked =3D true;
> +        bool readonly =3D true;
>
>          if (riscv_cpu_cfg(env)->ext_smepmp) {
>              /* mseccfg.RLB is set */
>              if (MSECCFG_RLB_ISSET(env)) {
> -                locked =3D false;
> +                readonly =3D false;
>              }
>
>              /* mseccfg.MML is not set */
> -            if (!MSECCFG_MML_ISSET(env) && !pmp_is_locked(env, pmp_index=
)) {
> -                locked =3D false;
> +            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_ind=
ex)) {
> +                readonly =3D false;
>              }
>
>              /* mseccfg.MML is set */
>              if (MSECCFG_MML_ISSET(env)) {
>                  /* not adding execute bit */
>                  if ((val & PMP_LOCK) !=3D 0 && (val & PMP_EXEC) !=3D PMP=
_EXEC) {
> -                    locked =3D false;
> +                    readonly =3D false;
>                  }
>                  /* shared region and not adding X bit */
>                  if ((val & PMP_LOCK) !=3D PMP_LOCK &&
>                      (val & 0x7) !=3D (PMP_WRITE | PMP_EXEC)) {
> -                    locked =3D false;
> +                    readonly =3D false;
>                  }
>              }
>          } else {
> -            if (!pmp_is_locked(env, pmp_index)) {
> -                locked =3D false;
> -            }
> +            readonly =3D pmp_is_readonly(env, pmp_index);
>          }
>
> -        if (locked) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - lock=
ed\n");
> +        if (readonly) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "ignoring pmpcfg write - read only\n");
>          } else if (env->pmp_state.pmp[pmp_index].cfg_reg !=3D val) {
>              /* If !mseccfg.MML then ignore writes with encoding RW=3D01 =
*/
>              if ((val & PMP_WRITE) && !(val & PMP_READ) &&
> @@ -524,14 +527,14 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t=
 addr_index,
>              uint8_t pmp_cfg =3D env->pmp_state.pmp[addr_index + 1].cfg_r=
eg;
>              is_next_cfg_tor =3D PMP_AMATCH_TOR =3D=3D pmp_get_a_field(pm=
p_cfg);
>
> -            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor) {
> +            if (pmp_is_readonly(env, addr_index + 1) && is_next_cfg_tor)=
 {
>                  qemu_log_mask(LOG_GUEST_ERROR,
> -                              "ignoring pmpaddr write - pmpcfg + 1 locke=
d\n");
> +                              "ignoring pmpaddr write - pmpcfg+1 read on=
ly\n");
>                  return;
>              }
>          }
>
> -        if (!pmp_is_locked(env, addr_index)) {
> +        if (!pmp_is_readonly(env, addr_index)) {
>              if (env->pmp_state.pmp[addr_index].addr_reg !=3D val) {
>                  env->pmp_state.pmp[addr_index].addr_reg =3D val;
>                  pmp_update_rule_addr(env, addr_index);
> @@ -542,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>              }
>          } else {
>              qemu_log_mask(LOG_GUEST_ERROR,
> -                          "ignoring pmpaddr write - locked\n");
> +                          "ignoring pmpaddr write - read only\n");
>          }
>      } else {
>          qemu_log_mask(LOG_GUEST_ERROR,
> --
> 2.47.2
>
>

