Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584E5C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8Ow-00088b-Om; Mon, 18 Mar 2024 04:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rm8Oo-00087k-4X; Mon, 18 Mar 2024 04:31:15 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rm8Om-0005xA-I0; Mon, 18 Mar 2024 04:31:13 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4d43d602cd6so515579e0c.0; 
 Mon, 18 Mar 2024 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710750671; x=1711355471; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjPhb7w4dmQcA3V7iijrR2fatnw1z9jDT7J6T384WGw=;
 b=J3cKXdyXkhndqejE4uGJadU9lrZ/+mVKXbAHHo3YDv/U7b9UHcZ3F8386R/AfFmpjp
 bfKXLwSWi2m/s82LkrcwXAwsT1/pGb79kS1KIvLnHeCJnR02rdzH4rHKA0iRi1Fk7RKS
 aYw2MX3Nx0HLFhcCEJxSrE7eAEHz8X0pyhv3mAJrX0jZqHo8JI14uU0ALlrQ1RiHyN2T
 r6hamkMnWhNtQyAIL9FhQRLh/2ilXLuOr6n+AFTXEggPPK6Xy29EvW/w0hMSwu5N9BlH
 Ugk9D/9G/fxWJjL2AUkHslXhToVErESGkJ+xP4fc04qwAenHf6vPAPFnoJmTCl9WqmyK
 iAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710750671; x=1711355471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjPhb7w4dmQcA3V7iijrR2fatnw1z9jDT7J6T384WGw=;
 b=sI+xEK425JZKsjfK6i4/3gjH/Yu0p+mrkWGNp1ySe/EkskeB77gLYS1pZqxXcjJlwd
 DvjPWaG4cJozoKq439iKTqV8qICacvIzuxjVSws61Ues4fRjGqfKrpu0ut0f9ZhJ03oZ
 hZdB5U3NEVvszzqdl6vSfJDMmkii45w0TYZffMivDKZ2acjfT3Nwktq2E3ihQLBm2Fmv
 o0213f5sYThtdQkGtsR86y5z6HFbpnGu63MG3Wb8s57HXpHIA//vJOKIbP82tYos7Mz0
 xfvMIYhgn7zSgmVDKrXEgfp+P7hopVJRdeKKD+oJ2CYPG/3xEhMv0QMm45xfhTobmAKE
 bV4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZujMTQCSlr3h2m85EEUBP5tte+PBHJPevKM9A42CJaMYO0nkfwnM/6Z8fLzZIWyQpUhD+qLuE+Zucp1yErogMlkA8QLE=
X-Gm-Message-State: AOJu0Yywnw8Ukk/e0InljIooycdNmvPS5J/mXkBKc6EZS/DgkgGjJsEx
 /AAhCyjzvviNeKWk9ROvBfI2rffVCIUW1hGg0eu5qLoV2/DB5KzgkiMa5GU/3/dH26Zb1H/xfuY
 HJp7qaw8QOuMxyi/NrcFSC0dIO9M=
X-Google-Smtp-Source: AGHT+IGFVdXCtlNlPD6ey/Lcj+xvUFfYCoK3AYAc8kI7a1rn8J95KCfDDtqC6TehasS7wG4n/PaNqH++/Flp4YT1vgg=
X-Received: by 2002:a1f:fc42:0:b0:4c0:1bb6:322 with SMTP id
 a63-20020a1ffc42000000b004c01bb60322mr6628430vki.15.1710750670991; Mon, 18
 Mar 2024 01:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240314175704.478276-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Mar 2024 18:30:44 +1000
Message-ID: <CAKmqyKOdQ_iFpVd-RahRD_hXw8Vk7YhBqhC-dZhR-GfRn_8FeA@mail.gmail.com>
Subject: Re: [PATCH for 9.0 v15 02/10] trans_rvv.c.inc: set vstart = 0 in int
 scalar move insns
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, max.chou@sifive.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Fri, Mar 15, 2024 at 3:59=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> trans_vmv_x_s, trans_vmv_s_x, trans_vfmv_f_s and trans_vfmv_s_f aren't
> setting vstart =3D 0 after execution. This is usually done by a helper in
> vector_helper.c but these functions don't use helpers.
>
> We'll set vstart after any potential 'over' brconds, and that will also
> mandate a mark_vs_dirty() too.
>
> Fixes: dedc53cbc9 ("target/riscv: rvv-1.0: integer scalar move instructio=
ns")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index e42728990e..8c16a9f5b3 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3373,6 +3373,8 @@ static bool trans_vmv_x_s(DisasContext *s, arg_vmv_=
x_s *a)
>          vec_element_loadi(s, t1, a->rs2, 0, true);
>          tcg_gen_trunc_i64_tl(dest, t1);
>          gen_set_gpr(s, a->rd, dest);
> +        tcg_gen_movi_tl(cpu_vstart, 0);
> +        mark_vs_dirty(s);
>          return true;
>      }
>      return false;
> @@ -3399,8 +3401,9 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_=
s_x *a)
>          s1 =3D get_gpr(s, a->rs1, EXT_NONE);
>          tcg_gen_ext_tl_i64(t1, s1);
>          vec_element_storei(s, a->rd, 0, t1);
> -        mark_vs_dirty(s);
>          gen_set_label(over);
> +        tcg_gen_movi_tl(cpu_vstart, 0);
> +        mark_vs_dirty(s);
>          return true;
>      }
>      return false;
> @@ -3427,6 +3430,8 @@ static bool trans_vfmv_f_s(DisasContext *s, arg_vfm=
v_f_s *a)
>          }
>
>          mark_fs_dirty(s);
> +        tcg_gen_movi_tl(cpu_vstart, 0);
> +        mark_vs_dirty(s);
>          return true;
>      }
>      return false;
> @@ -3452,8 +3457,9 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfm=
v_s_f *a)
>          do_nanbox(s, t1, cpu_fpr[a->rs1]);
>
>          vec_element_storei(s, a->rd, 0, t1);
> -        mark_vs_dirty(s);
>          gen_set_label(over);
> +        tcg_gen_movi_tl(cpu_vstart, 0);
> +        mark_vs_dirty(s);
>          return true;
>      }
>      return false;
> --
> 2.44.0
>
>

