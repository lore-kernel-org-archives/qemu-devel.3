Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EA1EF8FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxp1J-0004YP-Hd; Wed, 04 Mar 2026 11:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxp1F-0004Xz-9L
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:24:17 -0500
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxp1B-0004qt-9U
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:24:16 -0500
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2be1ab1fa7dso3960442eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772641450; x=1773246250; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rE+aO2UdN5Q7xj4C/zLh96wqcGzDSAGMHOTaSoYy8gg=;
 b=DruCo/orILMfFndya87cpq25sqG0vBJv9rvqfUhybBhf4vtkYdy+AIKSeSBuassyq2
 cWd9Pg8pEkOr+j8jBrodxul1KcCVD0aXZ0ACwsnwn0jE6nsYo8qewqtce5Pf+VIsfI1w
 mr29r8xHY9e/lL191o2amj8+gkiwhGCvdHrWUs8f3r8Rs/aUpuDVhp2sScST0Xf1IBc7
 ADH1MRbRzSt8KNq6008aIV6BpGBqFcquk2Tsi5n1GnMfPw5CfP2J1kheoymfFbH42nfq
 QuKUE4+jYT4zqFgAZHWwWe92CnHQL5GCnUGh8uPDwtRvY4fH3Uh8cuBQY1YRpa6yNSLH
 E9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772641450; x=1773246250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rE+aO2UdN5Q7xj4C/zLh96wqcGzDSAGMHOTaSoYy8gg=;
 b=t2j+XwMZ3aDiccrBD+mnJ8/VqcUqHuiiTnQ+p/oVyUPSFWwxFcWWZnKkAKyXJiC7R6
 g4m31e8lz4ES+L3BgBSWnSal3Hjmy9wzWQODNDVIaW7TXsWrI5tyLZ2x492fbL0JZLZ3
 6n1/BLnW3mavcfeAgYhp2vhRJ9NKw+LW4BzR2+x5hNHXGOhW1V4fjJPF4iAtHhdUZWjf
 xp8bs8R8QeBkqZTgH8PkNb9PE8RqjYimP155hI8EDZnUx+1vqa5ctACwmQvQpGgx6rlt
 9B04syWmZsPhXDzNn2vOnv4Kt5IhDCm1r40uRweEpv4mpzlEoXzg+10rypxE0ykhUCNx
 ORWQ==
X-Gm-Message-State: AOJu0YwiWDSWnmTmwznHcHKbZbGwv+MIkJWJ77InZn6fwqL6Qbf9ycwu
 kbwunzVzF3K7lQAAQcadzjzdeD8/hXhpBGQw0SyhSjlyr0UehGmDanaU
X-Gm-Gg: ATEYQzwMskYyzGf3xRVCZWqgyktdBMftXLowQ9c0JUU9VU8zECls4Ga2DOj8GTjWFYj
 K0eRt9l5Z65k8XfLURvbgxaknN7kvaT3qKXiOJfBLx0H0EH2TBdGnU2U8S6gLsnXUEfs1XJoauf
 E3qMAcJCfw8wSeZdmioEnGsoVhENS2Xg6sIxmdUwdvGjkm16+evRs5UUlxIsYU1QL03CSpZV2au
 5PBTSkePGevimoOdBZNsaqEIuvEQyz5gClD3RFbZvdo3cnhrwvSgovDgNkWpqws2KXvrl+izFSd
 hQtuK2QaITlJYcNGzhrMdn+oPzBCm2xyX2OtExagLuRm4gxPk1Mu0h33Si+iowRxTUCaPXCshq1
 nFVuhTEYFFZfrEiUCismeZnDh+VNBGfC/fPlwj6/y6bCDbOGekl+h3L9VlE67AoGeSO3V2VRS06
 PE6SSPb6zYvGwA7YinhxkKVGUZGi/s57m3Uk1B5iR/Fmxd+19V0dJa4L/4SIKqHBPF8iTHoK55n
 dyfgrmWbdsRZBuRGjMreGvXyFScpDi9QfBry62uXw==
X-Received: by 2002:a05:7300:ef97:b0:2bd:fff8:c7ea with SMTP id
 5a478bee46e88-2be311d2377mr1004687eec.38.1772641450132; 
 Wed, 04 Mar 2026 08:24:10 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f7e955sm15381186eec.32.2026.03.04.08.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:24:09 -0800 (PST)
Date: Thu, 5 Mar 2026 00:23:44 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 7/9] target/riscv: Introduce BF16 canonical NaN for
 Zvfbfa extension
Message-ID: <aahce637uSLp0e0O@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-8-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132514.2889449-8-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 04, 2026 at 09:25:11PM +0800, Max Chou wrote:
> According to the Zvfbfa ISA spec (v0.1), improperly NaN-boxed
> f-register operands must substitute the BF16 canonical NaN instead of
> the FP16 canonical NaN for some vector floating-point instructions.
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
>  target/riscv/translate.c                |  8 ++++++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 4df9a40b44..03ae85796a 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -2319,17 +2319,17 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
>   */
>  static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
>  {
> -    switch (s->sew) {
> -    case 1:
> -        gen_check_nanbox_h(out, in);
> -        break;
> -    case 2:
> +    if (s->sew == MO_16) {
> +        if (s->altfmt) {
> +            gen_check_nanbox_h_bf16(out, in);
> +        } else {
> +            gen_check_nanbox_h(out, in);
> +        }
> +    } else if (s->sew == MO_32) {
>          gen_check_nanbox_s(out, in);
> -        break;
> -    case 3:
> +    } else if (s->sew == MO_64) {
>          tcg_gen_mov_i64(out, in);
> -        break;
> -    default:
> +    } else {
>          g_assert_not_reached();
>      }
>  }
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 89d4f6fe67..d9df6a35ca 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -214,6 +214,14 @@ static void gen_check_nanbox_h(TCGv_i64 out, TCGv_i64 in)
>      tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
>  }
>  
> +static void gen_check_nanbox_h_bf16(TCGv_i64 out, TCGv_i64 in)
> +{
> +    TCGv_i64 t_max = tcg_constant_i64(0xffffffffffff0000ull);
> +    TCGv_i64 t_nan = tcg_constant_i64(0xffffffffffff7fc0ull);
BF16 canonical NaN is 0x7fc0. Correct.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu
> +
> +    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
> +}
> +
>  static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
>  {
>      TCGv_i64 t_max = tcg_constant_i64(0xffffffff00000000ull);
> -- 
> 2.52.0
> 

