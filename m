Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450C9C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 23:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sal6P-0006bv-8V; Sun, 04 Aug 2024 19:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sal5z-0006Tr-6d; Sun, 04 Aug 2024 19:57:06 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sal5p-00038u-0F; Sun, 04 Aug 2024 19:57:01 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4928fa870a9so2337038137.2; 
 Sun, 04 Aug 2024 16:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722815807; x=1723420607; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sa7wf7pY054ym1tQ8MQTBXihxy/ZR255C4eRuf1Xe4I=;
 b=gS/9n3+OyuwUyCLVrYcwCPhbRP5waYBXR6trfCDtlBDrkuqbBsmA1hnBDQJIWTawqt
 5uYDwbSE8BJmxaHp8cHToMbjVNclnj19IJI7cNbBPxn39e82wD+1bkpKVe4EfuLqdbWY
 vIMXKq4MDuP53cApr149S20hT+WQp+49Zc8Wmhys5iW+dgYticgAzvH2fecthWpvOFEc
 kTpcXRM6FU45CGD+MwYPY8IGR5syxE5iIZtGgJLPOmrm/lV0dAUeLTCATOneH9ZxIdL1
 UEonYeyYeAK18bKnf6qWHjljiyDT55yRWpm65EszRaff4X8mb+edWd6woU5HDi74AX31
 X9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722815807; x=1723420607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sa7wf7pY054ym1tQ8MQTBXihxy/ZR255C4eRuf1Xe4I=;
 b=IeqAfksbC73uikeFWJF2o6SLdTC5ry38Nw3GKtpsy0AiGdpUartwv6+vSsXdjx/GwM
 mQo3HI2gyUSaq13bwo6EyamoHcKhE2GpLO4BI1WUAQ0236M+0m95FUJKprCH+oVY+4nK
 Bv1tiOBOgDbw8RtJVnZOzzYSqc85W6N8rlKbgMOvSkhpTOLPaq95fqpzGQJi3SA9U5WH
 A9Z/PafcmHUIZ4nBVlI0ju4dJiOPYyZTnQn3Um8HQSTYsH6Ng5EgnTYoW+dADaDUxcUT
 Lc4SnFXe7fbl7asDXwoIyra6AAZRt9tNxireDs0Um9hN2ah1fG5xNSaHSEmF9C6WbRw2
 FKlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQYSRgSfjYE+P1uwA5mtu0a0khFLQ/nZ3PmER+5pzzwniW3ZEyE6dcI5A4pnCbFLn9XMA/eLsgaNi+@nongnu.org
X-Gm-Message-State: AOJu0YwInq5Fwmqj4vS1bIwgQtNXn6Vf9hKSBssCkyFGmtGRYj1BETmZ
 +UzMtmapTlxsjDQF9aY4/5JTIdV82nSBwn09M/FR44MUkvIlMVsKqa83Tp0SGd1dI38Nsczk60f
 eQcMKJ0JcicendVfChwzcxn0XL3Y7//6f
X-Google-Smtp-Source: AGHT+IFtaDB/9MnI/oGo78zrtYPl9ghPEjUkyPR1BpR5cvQnNCOwoo3bu4Oh/cfpic5Lli8Gb52QwwqL4EAECILNg+Q=
X-Received: by 2002:a05:6102:2ac4:b0:48f:4bd5:23d9 with SMTP id
 ada2fe7eead31-4945bde6458mr8378246137.5.1722815806693; Sun, 04 Aug 2024
 16:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
 <20240802072417.659-4-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240802072417.659-4-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 09:56:20 +1000
Message-ID: <CAKmqyKPM0OLNrNMw+VFTqesammB0hfCeRZH9wSsUizTZZmLYGQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/riscv: Relax fld alignment requirement
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Fri, Aug 2, 2024 at 5:27=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> According to the risc-v specification:
> "FLD and FSD are only guaranteed to execute atomically if the effective
> address is naturally aligned and XLEN=E2=89=A564."
>
> We currently implement fld as MO_ATOM_IFALIGN when XLEN < 64, which does
> not violate the rules. But it will hide some problems. So relax it to
> MO_ATOM_NONE.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvd.c.inc | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_=
trans/trans_rvd.c.inc
> index 49682292b8..8a46124f98 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -48,11 +48,17 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>      REQUIRE_EXT(ctx, RVD);
>
>      /*
> -     * Zama16b applies to loads and stores of no more than MXLEN bits de=
fined
> -     * in the F, D, and Q extensions.
> +     * FLD and FSD are only guaranteed to execute atomically if the effe=
ctive
> +     * address is naturally aligned and XLEN=E2=89=A564. Also, zama16b a=
pplies to
> +     * loads and stores of no more than MXLEN bits defined in the F, D, =
and
> +     * Q extensions.
>       */
> -    if ((get_xl_max(ctx) >=3D MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
> +    if (get_xl_max(ctx) =3D=3D MXL_RV32) {
> +        memop |=3D MO_ATOM_NONE;
> +    } else if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
> +    } else {
> +        memop |=3D MO_ATOM_IFALIGN;
>      }
>
>      decode_save_opc(ctx);
> @@ -71,8 +77,12 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
>
> -    if ((get_xl_max(ctx) >=3D MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
> +    if (get_xl_max(ctx) =3D=3D MXL_RV32) {
> +        memop |=3D MO_ATOM_NONE;
> +    } else if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
> +    } else {
> +        memop |=3D MO_ATOM_IFALIGN;
>      }
>
>      decode_save_opc(ctx);
> --
> 2.25.1
>
>

