Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF00ED11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 10:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOZOr-00014Q-P3; Thu, 27 Nov 2025 05:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vOZOq-00012Q-0A
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 05:38:56 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vOZOo-0006mg-Fp
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 05:38:55 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-29555b384acso8851655ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 02:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1764239932; x=1764844732; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIwwQROXGy91/29pza/VX2Dx40Vo9rIyqD49B0fXL+g=;
 b=KhhkeYj5hoMZA5q0hE5yFamV0PKDKp0yy55PDQAyrZf846SdKyvnbGmbRNjHP/KKu5
 eD8VQHbOswLudvflxz158hqJ1Rzfkw7u0kODLMrvW0GbkVo1/SWeBhOonfuTIVO/A7Vv
 bbw0VcW45mcc2qTgl4Mk3gNRINMHyD9qhl864d50oJADdyDxqB6JMRscaiZq0RmgCQd2
 8ckqOh3BjZlnJDExcBmt/GroIwL36KGCmkg7B/IngDZ6nHd24kUB11WKpS540njfamV1
 sAuFSqSBia3QRogi5JYnv1PtaX+Pvtcqy44H0qMLRh05B7jw0WxDCDIdhADSSc3aWeoH
 ib6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764239932; x=1764844732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pIwwQROXGy91/29pza/VX2Dx40Vo9rIyqD49B0fXL+g=;
 b=wCv0c2qMKrk0ukFEj9T3A+LTxTi74temeu1DvJXuCOC82pF0F3t3qTlfVKNLKrsw2j
 2AJalI7ke820eR2vdb0LZXlwxM/c6uorGxJwMahkVWx7FXgy5YTE/jt3xbFKt7sRD5DO
 nzUDi5QlUg//hWfq31e0hbymrtXyVQUE3lm0/ewxwbUld6SAtP/ApGJ+r8FlrYsvGELx
 gHcM5FgBH+g4OJJT3K5ip1DVBV8qGOnMshiZfeHJe6FPdRAL/WBlt03XWkxo4uWbMQYx
 /SRO4XJeqUjjPJSGvdlJ6c32hWTxOmRM4JPW8g+unEvHAQmB0NFdoS3LvK8EFQF8uYyx
 csNA==
X-Gm-Message-State: AOJu0YwYWoG0wnW4PG0y0CAeg5TJyxxCZYQ7rU1Nj8fKphlU6gsKo+ZC
 mQlhh6AL8whOZqQMWFO+QI6ZR/1hPpRBAtgl+6+NywajNC058x2eEM3Z8WLwmPIZCvpyrZm37gW
 hQJXa9XPNsKeDf7+lNRWHLyNZp1wmAwNvKELqQdOPO2seK4GAO7+kjR2lIQgsD/jbFnAXg3PriS
 +u/Iehv3LP4KRAnC4S0pX1a+jFLdpwRaznCuWvy4hl9Ao=
X-Gm-Gg: ASbGncvjfN97krVxP9If7tWH7b8NbCHBZrblUKj90p8fIFMKV+0tTdq98kICeG9d9sH
 lrOJNF5ZffUzlPr7psxAgHzM8/fX7hf01u4B2paYmnsrLuHxlQjjM0S+1UqLATRiBoiEv9wl/xp
 6FJo43enXnclQB+j2VibQRuKUhKt5/cXOae3BAMcj6XZtn67/wnQ81OqbpZp9SSnzdqM7QKLJWm
 CW3M/Ok8RXe3vpZf2924aqZCTvvrCdfhn/Oi5z6LXG3ENykhNKBS8SOOQ3REM5SzTrCGMyYY5Yz
 Xb7cwWlPdXcT6zN61KNP2e/Cv5HCEgM7WryGQ+wzsrNE/aVDsIJ3Y2ZJv6q/R7psI0/MK9vO+NW
 OIxavV5AMACffxhLqA31xEYX0wREGdK+AhcqrDWlM4nOUuCT7ptHL58uBmiUGFe62nlaYsbiOj8
 KfXhOEgxh69QLMDa053KrZIAkg5xKgaVdDrC4hvUekyXT2/D3EHQjMJ/Mtj6tNts0NKQ==
X-Google-Smtp-Source: AGHT+IFoSYPAMKOCgu1toJAIdV+3FW01+NewxNdF/gjIBMEDNV2cBL2kqYiWEYOk/+7YqOg192gE/A==
X-Received: by 2002:a17:902:f691:b0:295:68dd:4ebf with SMTP id
 d9443c01a7336-29b6c3e3c48mr280053415ad.16.1764239931577; 
 Thu, 27 Nov 2025 02:38:51 -0800 (PST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com.
 [209.85.215.178]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bce2e676esm14283745ad.0.2025.11.27.02.38.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Nov 2025 02:38:50 -0800 (PST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-bc09b3d3afeso446602a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 02:38:50 -0800 (PST)
X-Received: by 2002:a05:7301:2e88:b0:2a4:3593:ddd9 with SMTP id
 5a478bee46e88-2a71953cdd9mr14901073eec.6.1764239929897; Thu, 27 Nov 2025
 02:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20251114090134.1125646-1-frank.chang@sifive.com>
 <20251114090134.1125646-2-frank.chang@sifive.com>
In-Reply-To: <20251114090134.1125646-2-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 27 Nov 2025 18:38:38 +0800
X-Gmail-Original-Message-ID: <CANzO1D0A3br9+H7tDvgkYLrf=QuqLZ_HBace8++H2--TNOvVow@mail.gmail.com>
X-Gm-Features: AWmQ_bmo1Y2I3W6CtqjEpvZ_7coOzFdmoCyPeM3cpCA5uKvxs2rhtjbGPiGqNTs
Message-ID: <CANzO1D0A3br9+H7tDvgkYLrf=QuqLZ_HBace8++H2--TNOvVow@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Update MISA.C for Zc* extensions
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

<frank.chang@sifive.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=8814=E6=97=A5=E9=
=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Frank Chang <frank.chang@sifive.com>
>
> MISA.C is set if the following extensions are selected:
>   * Zca and not F.
>   * Zca, Zcf and F (but not D) is specified (RV32 only).
>   * Zca, Zcf and Zcd if D is specified (RV32 only).
>   * Zca, Zcd if D is specified (RV64 only).
>
> Therefore, we need to set MISA.C according to the rules for Zc*
> extensions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 440626ddfad..da09a2417cc 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1150,6 +1150,36 @@ static void riscv_cpu_enable_implied_rules(RISCVCP=
U *cpu)
>      }
>  }
>
> +/*
> + * MISA.C is set if the following extensions are selected:
> + *   - Zca and not F.
> + *   - Zca, Zcf and F (but not D) is specified on RV32.
> + *   - Zca, Zcf and Zcd if D is specified on RV32.
> + *   - Zca, Zcd if D is specified on RV64.
> + */
> +static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +
> +    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32 &&
> +        cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
> +        riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd : riscv_has_ext(env, =
RVF)) {

I missed the parentheses here, should be:

if (riscv_cpu_mxl(env) =3D=3D MXL_RV32 &&
    cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
    (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd : riscv_has_ext(env, RVF)))=
 {

I will send out the v2 patchset to fix the issue.

Regards,
Frank Chang

> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> +        cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +}
> +
>  void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -1157,6 +1187,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>
>      riscv_cpu_init_implied_exts_rules();
>      riscv_cpu_enable_implied_rules(cpu);
> +    riscv_cpu_update_misa_c(cpu);
>
>      riscv_cpu_validate_misa_priv(env, &local_err);
>      if (local_err !=3D NULL) {
> --
> 2.43.0
>
>

