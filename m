Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFE2C0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 02:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temao-0003Kt-Ni; Sun, 02 Feb 2025 21:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1teman-0003Kb-A9; Sun, 02 Feb 2025 21:53:45 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1temal-0006xs-Gb; Sun, 02 Feb 2025 21:53:45 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4b1279ca1d2so1145963137.3; 
 Sun, 02 Feb 2025 18:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738551222; x=1739156022; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UG50QAWvMW6C8BrZ2RzBiXm4og9zSTf+hUpQ4eaLpC4=;
 b=Ji16JeGFM8zaFaHQ7oSzOFoBbLG4In/kIIUurM9L/Igqm7h/AWH21UhsixxC2ElYbX
 ptbnubh13B8DXo7+FsXMIrPvB4nwpilRCt3z2QHv2+3TF6vnkrYGHzs4lQFb71/cnOuF
 fAGVmRr524tf2vXN4SARfoiixV/7cd2gjs7dsYjypK/oVWsA+ftlMQlFeqm/wG6WMSfk
 OHBEQJKoBnj5tEq5gQOHmvvVewQqA5dx/yIgEfWikVB9c5Ch/E4zAY86nthwpiEYKYw+
 1hQaffTQZRHXTm5FVKwmQbtKjGDFcl9JzJSudQiNw7u3TnfSfbzuM/VqCrMxgrM5i3eR
 awGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738551222; x=1739156022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UG50QAWvMW6C8BrZ2RzBiXm4og9zSTf+hUpQ4eaLpC4=;
 b=w49yi02mE4/ECFPdcKp1sjwfiRgPhRcZ4GwWCqbpicbJEvM8nDflqMDn3dFSFIcLgf
 iQfPZs+KdS6XN9MviiXMjuGYPS0KMuhbQq6vRr9pc64dXJNVlP7ssG2VaTcLIiaiNnuP
 JywMaP0CI6GrO/Rk2kzQD6fJ5Ng0XTiygudmtxgYDqL46XXyUrZVrVSyGhpBa4DzWsWE
 GCdnOGFH+2RFbh2K5TtVTvfjrbWWi/aWFzL4d+vczD9mfbELl9PBD3Bzpuk/Im4soXHX
 S0dD1pwaHJL+ek2HKy2qTmUoMmAYro3ViizGSU4u4/Tarb4O2XBWX7wVDmivnSNS7mWS
 xsZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU40iTAnhqbiNJhElOgQWatHGoAZ+6FXlVLQPVuJfuKLNhbd1vx3XjRqttNU0X7GtjBQU0YjIr78WTf@nongnu.org
X-Gm-Message-State: AOJu0YxVGjLzqJ3Eor8QeSVJ4K50VhfnCPuDvunA42s5Yi/OhdoVUMiI
 r8mM2nmhNkvjYcmxYcbxk/aI1327xY7Xz3Wik2V7Qr+wMah3YbrX2f1JypG28xgbvbSat5BQktb
 f6pnhj1azF7N6X3mWsVW5+SyInec=
X-Gm-Gg: ASbGncvijFjkdZg+uzLQIoq2bziWAhWeowVP+dKgcss4zdpu4fcoZ8yv4hnECTC8tjR
 WKpdEsxnGqmPnRmoXYCt1PMFiQIcv6UwtspcxnZqbg+86FlnwxkxTGqQnwwf1+XnYhdenwvuSP/
 BZY9OTPBB6N8m4u0MI96mQDCOViQ==
X-Google-Smtp-Source: AGHT+IHK6svO0xjLrOan7u9t+891VxKsRT9QR6DreAwFnJPdEkP4CF/aPWtsHDYAklCYB9NFZ4zPPXE/s9hlDEQnImk=
X-Received: by 2002:a05:6102:c89:b0:4b2:7446:fc18 with SMTP id
 ada2fe7eead31-4b9a5237822mr14721963137.17.1738551221746; Sun, 02 Feb 2025
 18:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
 <20241205-b4-ctr_upstream_v3-v5-5-60b993aa567d@rivosinc.com>
In-Reply-To: <20241205-b4-ctr_upstream_v3-v5-5-60b993aa567d@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Feb 2025 12:53:15 +1000
X-Gm-Features: AWEUYZkCqm7g-L5_Z_bVYOrAE-wQxToVqF9qlJH9c42SCbJQ_cPBH9KVrEZICKE
Message-ID: <CAKmqyKObzKTMGd2pu6Rof6y9USx7X2S_f0o7wg6f1OX4D9BxOA@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] target/riscv: Add CTR sctrclr instruction.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
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

On Thu, Dec 5, 2024 at 9:35=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.com=
> wrote:
>
> CTR extension adds a new instruction sctrclr to quickly
> clear the recorded entries buffer.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h                             |  1 +
>  target/riscv/cpu_helper.c                      |  7 +++++++
>  target/riscv/helper.h                          |  1 +
>  target/riscv/insn32.decode                     |  1 +
>  target/riscv/insn_trans/trans_privileged.c.inc | 11 ++++++++++
>  target/riscv/op_helper.c                       | 29 ++++++++++++++++++++=
++++++
>  6 files changed, 50 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f39ca48d37332c4e5907ca87040de420f78df2e4..85ca2bfe435d0c9d245f2690f=
e3bde3e076d3b2f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -613,6 +613,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ul=
ong newpriv, bool virt_en);
>
>  void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_lon=
g dst,
>      enum CTRType type, target_ulong prev_priv, bool prev_virt);
> +void riscv_ctr_clear(CPURISCVState *env);
>
>  void riscv_translate_init(void);
>  G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dbdad4e29d7de0713f7530c46e9fab03d3c459a4..b1130180710b0e01e8ebe33f0=
974edd8d5abe56d 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -783,6 +783,13 @@ static void riscv_ctr_freeze(CPURISCVState *env, uin=
t64_t freeze_mask,
>      }
>  }
>
> +void riscv_ctr_clear(CPURISCVState *env)
> +{
> +    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
> +    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
> +    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
> +}
> +
>  static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
>  {
>      switch (priv) {
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 820ddccf92ab07cbe80ae03b3d2d2ccc4f8e4765..011ee628f81333e30cfa7a375=
788e546965e4b30 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl=
)
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_1(sret, tl, env)
>  DEF_HELPER_1(mret, tl, env)
> +DEF_HELPER_1(ctr_clear, void, env)
>  DEF_HELPER_1(wfi, void, env)
>  DEF_HELPER_1(wrs_nto, void, env)
>  DEF_HELPER_1(tlb_flush, void, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index a2b4c0ddd47ad9464b4b180fb19e6a3b64dbe4e5..8188113bcc90482733f676227=
858829bac5c5462 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -114,6 +114,7 @@
>  # *** Privileged Instructions ***
>  ecall       000000000000     00000 000 00000 1110011
>  ebreak      000000000001     00000 000 00000 1110011
> +sctrclr     000100000100     00000 000 00000 1110011
>  uret        0000000    00010 00000 000 00000 1110011
>  sret        0001000    00010 00000 000 00000 1110011
>  mret        0011000    00010 00000 000 00000 1110011
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/insn_trans/trans_privileged.c.inc
> index b19d692c22dc74c41df72dae99448c37a0216980..a67088d25bade5cb3be62647e=
411045894bffe33 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -69,6 +69,17 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak=
 *a)
>      return true;
>  }
>
> +static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +        gen_helper_ctr_clear(tcg_env);
> +        return true;
> +    }
> +#endif
> +    return false;
> +}
> +
>  static bool trans_uret(DisasContext *ctx, arg_uret *a)
>  {
>      return false;
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 0684a27bfdb72f6fc5945f30500c2e3a95e85e2f..e7301ee8ca2e3145396a27412=
6e591921b6d9e01 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -389,6 +389,35 @@ void helper_ctr_add_entry(CPURISCVState *env, target=
_ulong src,
>                          env->priv, env->virt_enabled);
>  }
>
> +void helper_ctr_clear(CPURISCVState *env)
> +{
> +    /*
> +     * It's safe to call smstateen_acc_ok() for umode access regardless =
of the
> +     * state of bit 54 (CTR bit in case of m/hstateen) of sstateen. If t=
he bit
> +     * is zero, smstateen_acc_ok() will return the correct exception cod=
e and
> +     * if it's one, smstateen_acc_ok() will return RISCV_EXCP_NONE. In t=
hat
> +     * scenario the U-mode check below will handle that case.
> +     */
> +    RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        riscv_raise_exception(env, ret, GETPC());
> +    }
> +
> +    if (env->priv =3D=3D PRV_U) {
> +        /*
> +         * One corner case is when sctrclr is executed from VU-mode and
> +         * mstateen.CTR =3D 0, in which case we are supposed to raise
> +         * RISCV_EXCP_ILLEGAL_INST. This case is already handled in
> +         * smstateen_acc_ok().
> +         */
> +        uint32_t excep =3D env->virt_enabled ? RISCV_EXCP_VIRT_INSTRUCTI=
ON_FAULT :
> +            RISCV_EXCP_ILLEGAL_INST;
> +        riscv_raise_exception(env, excep, GETPC());
> +    }
> +
> +    riscv_ctr_clear(env);
> +}
> +
>  void helper_wfi(CPURISCVState *env)
>  {
>      CPUState *cs =3D env_cpu(env);
>
> --
> 2.34.1
>
>

