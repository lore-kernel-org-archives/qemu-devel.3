Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA855C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8n7-0006fS-Sv; Mon, 18 Mar 2024 04:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rm8n6-0006fA-A8; Mon, 18 Mar 2024 04:56:20 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rm8ms-0001pl-FZ; Mon, 18 Mar 2024 04:56:20 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4d42d18bd63so1239739e0c.2; 
 Mon, 18 Mar 2024 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710752165; x=1711356965; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jK7I1oMqOUtvGmi/aaRpnmqT1Z+iytKnO9Az1DAavgc=;
 b=WMZLQgnghJn9TIjEmVeIPIaVHmw9JNVkA5p+392RgTqBBx4oMJcAh0QjLw3cqFiW1f
 FhnnFupnxTBOzgp5+af+Unycu/niSN+HDnOhl7axfNjV07eBmhdVs0TDQnotcN4oAv1e
 3ybaI9CWlV3hhAA9kAEMgw+dgTAks01OSEsGtikt8Qe7Ijt0ZdQw+6hlFIRVmjhdYzMZ
 jGPMLTHXUH5l2/cTZasu9UsFE+30lPE75yU8mmS3u3DSIdWvrEWqzYWLtHFUpW3SynQi
 n4Vs1TAY/ZhPGmjLDgzkYBeWD6hMZndeNLAxCxNIbO2++Etppphzu5ibfjV/oa/VUBqz
 CyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710752165; x=1711356965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jK7I1oMqOUtvGmi/aaRpnmqT1Z+iytKnO9Az1DAavgc=;
 b=V3RNCTLFTGbMd5ootT9gmmTkdObQjpW3UgLx18BUrc/yrOYYd4oKcUxd7hO2SxxXgo
 rDBubbR0AiVVoZBXkOIz5hp8vzJBfRwBf9Jr6UuI+3bv5n/SmQctlOOTy15y5J0JzVO3
 ipxkrNbOFR+L5N1Ulel+p0a8C/NvLa9BwxrRkfayJk1uISVso+ImaAeVgDyDfYVa9z24
 RoMynJStO2YC7WnhJ5mub4f1xjVQw3zHjQzD7ONUDrAlVdydKQ2sakILayS+XbdWrvQ8
 3PPM3sPsSrbmaBGgus9j/KV/jwB1+wDFneMxXIdeCtVg6kSYUPeO7rQCDlgvDKRfmIOS
 sDpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqok4bOdnptVDzYV5LtCleQlxscvIF4rGxLxtngrq59pzV4OXJ1/i1g7hPkR/5Io4xfMF77unWDRhr6v8C355ZVE+QmL0=
X-Gm-Message-State: AOJu0YyVGjvJh3I5A62sxMCyVIZ4AXiRIZJci92vwLuXIs2DrlkhxBGG
 MAU1AmTqUXUbArur1LOOOHRinwzi5Ak0afDQ1lblwh1c/Z06NDv5VtYMU07UifH1LcAyuiXqIqD
 mQVFGLjy0SzXkKJnOS48uiYdELV4=
X-Google-Smtp-Source: AGHT+IF9O2hE92M/CVZftRdCZAduK/cz1EWlEmlW123IzOl4W+PguHSNmGCjvtAq9I9G74E2a2tNg+LLRDeF7DvMZrU=
X-Received: by 2002:a05:6122:997:b0:4d4:5124:17b2 with SMTP id
 g23-20020a056122099700b004d4512417b2mr1452548vkd.6.1710752164971; Mon, 18 Mar
 2024 01:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-5-dbarboza@ventanamicro.com>
In-Reply-To: <20240314175704.478276-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Mar 2024 18:55:38 +1000
Message-ID: <CAKmqyKNN6zR7m+rfM1-gi5T9AMHH9VRf5GfXvEVgF1LBKntWYQ@mail.gmail.com>
Subject: Re: [PATCH for 9.0 v15 04/10] target/riscv: always clear vstart in
 whole vec move insns
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, max.chou@sifive.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 15, 2024 at 3:58=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> These insns have 2 paths: we'll either have vstart already cleared if
> vstart_eq_zero or we'll do a brcond to check if vstart >=3D maxsz to call
> the 'vmvr_v' helper. The helper will clear vstart if it executes until
> the end, or if vstart >=3D vl.
>
> For starters, the check itself is wrong: we're checking vstart >=3D maxsz=
,
> when in fact we should use vstart in bytes, or 'startb' like 'vmvr_v' is
> calling, to do the comparison. But even after fixing the comparison we'll
> still need to clear vstart in the end, which isn't happening too.
>
> We want to make the helpers responsible to manage vstart, including
> these corner cases, precisely to avoid these situations:
>
> - remove the wrong vstart >=3D maxsz cond from the translation;
> - add a 'startb >=3D maxsz' cond in 'vmvr_v', and clear vstart if that
>   happens.
>
> This way we're now sure that vstart is being cleared in the end of the
> execution, regardless of the path taken.
>
> Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 3 ---
>  target/riscv/vector_helper.c            | 5 +++++
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 8c16a9f5b3..52c26a7834 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3664,12 +3664,9 @@ static bool trans_##NAME(DisasContext *s, arg_##NA=
ME * a)               \
>                               vreg_ofs(s, a->rs2), maxsz, maxsz);        =
\
>              mark_vs_dirty(s);                                           =
\
>          } else {                                                        =
\
> -            TCGLabel *over =3D gen_new_label();                         =
  \
> -            tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  =
\
>              tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), =
\
>                                 tcg_env, maxsz, maxsz, 0, gen_helper_vmvr=
_v); \
>              mark_vs_dirty(s);                                           =
\
> -            gen_set_label(over);                                        =
\
>          }                                                               =
\
>          return true;                                                    =
\
>      }                                                                   =
\
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 34ac4aa808..bcc553c0e2 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5075,6 +5075,11 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVS=
tate *env, uint32_t desc)
>      uint32_t startb =3D env->vstart * sewb;
>      uint32_t i =3D startb;
>
> +    if (startb >=3D maxsz) {
> +        env->vstart =3D 0;
> +        return;
> +    }
> +
>      if (HOST_BIG_ENDIAN && i % 8 !=3D 0) {
>          uint32_t j =3D ROUND_UP(i, 8);
>          memcpy((uint8_t *)vd + H1(j - 1),
> --
> 2.44.0
>
>

