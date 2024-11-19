Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F44D60D18
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 03:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDErn-0004CW-1u; Mon, 18 Nov 2024 22:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDErl-0004C2-An; Mon, 18 Nov 2024 22:25:25 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDErj-0000he-SU; Mon, 18 Nov 2024 22:25:25 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5146e6531c8so1706416e0c.0; 
 Mon, 18 Nov 2024 19:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731986722; x=1732591522; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUC+SQfuv2D0k74IW7awSHarWFJ7UEXStqEojIXITQQ=;
 b=AuoUVqdZmYQJRJ42Yl9SF6ZybtY+zvHVsD5E+ma0F1Jm60e0FR6hfR5RIZLjVMSPCg
 f4wY2JI8xoiKtOKJ4HACsWp7/bVdJ7DD0HNzRkW86DXpgeKUDLRVt+jPgBD70KyRLlOl
 8IFN0MkBhqqADkeDg21V1f4sU6V1aGMG5kCuU02BOBoMxeRDLvOlFnOp9DH25tFzHUXS
 8t8Dl/xb4vjrjCualyGkgCEy2Bc8ad/MSfyOQqRhikVdm2B7dauIR+1ngHsEn0G2VVgw
 wC4SjrUvWwaEeUoR9DWwP1wBYPiVXu/M+qe08TZbyesWMcSMLcNhPokhr8lge4hAe3I0
 r0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731986722; x=1732591522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUC+SQfuv2D0k74IW7awSHarWFJ7UEXStqEojIXITQQ=;
 b=RALYn+WowMkD7mlLLJ3ICIdtxvCA7HLO9xObeJRHmuhUu3DflryVhYhNwz25shuQbS
 mEuCEjVyMAy0rEmi3yA8lAJAUN7xhsIiaqBbSqmV/aFTUcGiKD7gFIpE5EYW7sqs7tcA
 2HJVQHt/vGIg+8SANgnCF6P8e+Zw/KdoVRb7dUfyLCzJyLUMlevpxl+eV5wpApJ4Z2nX
 BIpry8MbWcEDG3YgLiaC++mewn+Yi2MeDPpioWiTdnu92y5T74QiEJHoYr2TNwrkCBQu
 6jXQsxG+nsktqntZxZtKCoOi/uSSB6Vqx1vnQL5ayg/K6CgQVQKj1jha1UIFOkLFA1+F
 ecZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkWhFfLZmEBejy0NnpaC3opL4yCTIiMxfOfPqH4iXjZ/PwtFNfTdsw5kD2oEXWWOyePTSbtOi99dse@nongnu.org
X-Gm-Message-State: AOJu0YzOC4b9JRRUugSSSwFL5pBB5cg5wJKT99hTPrbw7oIS/c2+3R/d
 RjiaC+p1KFgT1IfmXs8urxJUMzyY4421kjQGhoZQQ4xBHSYlDASCvhr3yG5PjgwYUpW/4u43gNA
 PzvVdO+nWSc4y0fLzMI7xFCB8sxY=
X-Google-Smtp-Source: AGHT+IE85Wrqca5o8d1qoPJm+TiQGeWFCDJOfIGKm846ITEYwWzPHfFCrcumoihiC9lA1KGVwxJBo+HyScxrCGxDfGk=
X-Received: by 2002:a05:6122:2a06:b0:50d:35d9:ad60 with SMTP id
 71dfb90a1353d-51477f14a71mr13716396e0c.5.1731986722082; Mon, 18 Nov 2024
 19:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20241112091423.2529583-1-fea.wang@sifive.com>
 <20241112091423.2529583-4-fea.wang@sifive.com>
In-Reply-To: <20241112091423.2529583-4-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 13:24:56 +1000
Message-ID: <CAKmqyKMY7pK3m5Npd3Aooqy5AjJHV6tsxh-aYSEcuRwGG1AaXQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] target/riscv: Support hstatus[HUKTE] bit when
 svukte extension is enabled
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Tue, Nov 12, 2024 at 7:14=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Svukte extension add HUKTE bit, bit[24] in hstatus CSR. The written
> value will be masked when the svukte extension is not enabled.
>
> When hstatus[HUKTE] bit is set, HLV/HLVX/HSV work in the U-mode should
> do svukte check.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 1 +
>  target/riscv/csr.c      | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 4b9f899217..fe4e34c64a 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -604,6 +604,7 @@ typedef enum {
>  #define HSTATUS_VTVM         0x00100000
>  #define HSTATUS_VTW          0x00200000
>  #define HSTATUS_VTSR         0x00400000
> +#define HSTATUS_HUKTE        0x01000000
>  #define HSTATUS_VSXL         0x300000000
>
>  #define HSTATUS32_WPRI       0xFF8FF87E
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 1936a6f32a..b6fa8ae53f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3540,6 +3540,9 @@ static RISCVException read_hstatus(CPURISCVState *e=
nv, int csrno,
>  static RISCVException write_hstatus(CPURISCVState *env, int csrno,
>                                      target_ulong val)
>  {
> +    if (!env_archcpu(env)->cfg.ext_svukte) {
> +        val =3D val & (~HSTATUS_HUKTE);
> +    }
>      env->hstatus =3D val;
>      if (riscv_cpu_mxl(env) !=3D MXL_RV32 && get_field(val, HSTATUS_VSXL)=
 !=3D 2) {
>          qemu_log_mask(LOG_UNIMP,
> --
> 2.34.1
>
>

