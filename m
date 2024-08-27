Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE59C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 05:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sip7j-00077s-7K; Tue, 27 Aug 2024 01:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sip7f-00074t-NB; Tue, 27 Aug 2024 01:52:07 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sip7d-0000dR-Az; Tue, 27 Aug 2024 01:52:07 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-8430557e436so1477153241.2; 
 Mon, 26 Aug 2024 22:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724737924; x=1725342724; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gAzcMf+Ys3oWmmLGTEqiSSagVsKuv2f+bnv/3WObjQ=;
 b=E/pK1Ttt2bP8wENHUaMbbGtayjciY2i3oxe7Fza1VrOVNblugjeTrY0xmlAKja8EYB
 d7534qlc/45Swgjj8ljcXF29Ds/IMDXXcVA1jts1Kk23rZIIPN1hk+D79Boa5NFHTSny
 PPxNx8W56EslLzPXRa6ixxTxxPE2BaWMw/IlJq5pOgetDNWatWhwucMtBNzTWrXAilKw
 /4DWH9qCyKJpoTjFggG5+xQDL/Xk/FRd5j1XsiMHmKPopXONe3TvhRb+sikFSWCnIFVx
 Prt4n1HxSJtolO7TgDE/KpbhFwiTBRgZ1crAliYPANfV3t2TUF7Rc2eMRhGNvtSSd5tm
 rINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724737924; x=1725342724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gAzcMf+Ys3oWmmLGTEqiSSagVsKuv2f+bnv/3WObjQ=;
 b=pFtZ+r8ZzAV1jui5blqBvhsnwyy7sZsgz1yc0xpMF+nfoi4B1zCjNxJaQhRqD1veop
 hONeJB+amOPFQXmNNPq7d+94g9wwgtRqxBr3h5r2T5rFjnmbHqKi2wVnFORBkqe8OX5T
 1NymyyxST5+1zhchrYJO0G3cHAwtGUNjp1ejrxbYySaa2TodMcNWTh2Co9/1gBRpmoSf
 xu9sNNvS6egkMTf/h5uWi6PwFjK/siJNYBCh47YRO4FoXFq3cEF0h+fWlsC3yWYMNKmn
 SQKMr8JrllhCaQVD3ow21tABELl3zmA7/8p/9soIHo6YC0tcU5jVNMX05R8nGpqLkq1H
 1IMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHsyrA9KegzBJQGEu5phxQlXyhLOFqnXtTsdyFzWcKLhqtoWnCRagEjUT02RHnztEA17x3etleKFb6@nongnu.org
X-Gm-Message-State: AOJu0Yyd89MwefwA5/yr2RgV9PauieS3Z4iNx+mfK7ZQ440xNJzK2pp7
 AceyGgGQ+X2k4T4bd4YyZ5Y+FBSlMm3geC8WOaun7qCoEWmBRz+aB60BlFIGu3z04htrSdONzUs
 oLNmrsksuJOEsFvMGTfjJSlvHpvw=
X-Google-Smtp-Source: AGHT+IEfM3rKbPwrv1LvBIO8VYAJaxTVpykZn/ekrNURA2RtVsydEgeOR2lEgAyEOwQnfr7uQLkMzWzCY/VumCiVqwc=
X-Received: by 2002:a05:6102:3593:b0:498:f027:254a with SMTP id
 ada2fe7eead31-49a3bb88464mr2259121137.1.1724737923816; Mon, 26 Aug 2024
 22:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-11-debug@rivosinc.com>
In-Reply-To: <20240826152949.294506-11-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 15:51:37 +1000
Message-ID: <CAKmqyKNR0qfyoV0ib8HT1E0y3mjejPZx1RE6gOucN4Qx7v117g@mail.gmail.com>
Subject: Re: [PATCH v9 10/17] target/riscv: tb flag for shadow stack
 instructions
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, richard.henderson@linaro.org, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Tue, Aug 27, 2024 at 1:33=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Shadow stack instructions can be decoded as zimop / zcmop or shadow stack
> instructions depending on whether shadow stack are enabled at current
> privilege. This requires a TB flag so that correct TB generation and corr=
ect
> TB lookup happens. `DisasContext` gets a field indicating whether bcfi is
> enabled or not.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 2 ++
>  target/riscv/cpu_helper.c | 4 ++++
>  target/riscv/translate.c  | 4 ++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5a57099d59..dcc3bc9d93 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -613,6 +613,8 @@ FIELD(TB_FLAGS, AXL, 26, 2)
>  /* zicfilp needs a TB flag to track indirect branches */
>  FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
>  FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
> +/* zicfiss needs a TB flag so that correct TB is located based on tb fla=
gs */
> +FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
>
>  #ifdef TARGET_RISCV32
>  #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index c9165b1d86..ca6d8f1f39 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -168,6 +168,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr =
*pc,
>          flags =3D FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
>      }
>
> +    if (cpu_get_bcfien(env)) {
> +        flags =3D FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
> +    }
> +
>  #ifdef CONFIG_USER_ONLY
>      fs =3D EXT_STATUS_DIRTY;
>      vs =3D EXT_STATUS_DIRTY;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index b5c0511b4b..b1d251e893 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -119,6 +119,8 @@ typedef struct DisasContext {
>      /* zicfilp extension. fcfi_enabled, lp expected or not */
>      bool fcfi_enabled;
>      bool fcfi_lp_expected;
> +    /* zicfiss extension, if shadow stack was enabled during TB gen */
> +    bool bcfi_enabled;
>  } DisasContext;
>
>  static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -1241,6 +1243,8 @@ static void riscv_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      ctx->pm_base_enabled =3D FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENAB=
LED);
>      ctx->ztso =3D cpu->cfg.ext_ztso;
>      ctx->itrigger =3D FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
> +    ctx->bcfi_enabled =3D cpu_get_bcfien(env) &&
> +                        FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
>      ctx->fcfi_lp_expected =3D FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXP=
ECTED);
>      ctx->fcfi_enabled =3D FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
>      ctx->zero =3D tcg_constant_tl(0);
> --
> 2.44.0
>
>

