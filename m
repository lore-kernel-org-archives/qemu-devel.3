Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18AEC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhgD7-0004qj-NH; Tue, 05 Mar 2024 20:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgD5-0004hV-T2; Tue, 05 Mar 2024 20:36:43 -0500
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgD4-00059r-C0; Tue, 05 Mar 2024 20:36:43 -0500
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-47273838a21so203713137.1; 
 Tue, 05 Mar 2024 17:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709689001; x=1710293801; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsZtk0G8275gJqLUKAYWXNfTYSX/HVN9CEL6bBdYZYQ=;
 b=W9G9y/w4t62qWbJ2+uNk1Sngrw1xpTwpvQUiaP2uN4cnz//qCxoNx30SBzGfsdLdSj
 3eLE76I9OFEIwA9cfCL7Kv6OzSvdy1plTWqKO3A8sxGe1orEJEBCgrIfwLx7kH3VG7i9
 pHoY78Iviph8dHF4aqxScvLwj38hw8DcNHLJ/Qh5zBJc8G223O3LvcLDQqOmxMQHMqij
 Z1EqlO2xhQwi3lTIVNZdw0CU2dn4krl2CO48NAn7+SheCl3ZYqr+uzFg182DuelCHbLk
 9Vk+Hz8+COtvr7wlQbmtrFlcw/nEgoBBwttSj3YnJb/6YHMeLIKRzU/Z4/bBWdhPgXFv
 6H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709689001; x=1710293801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsZtk0G8275gJqLUKAYWXNfTYSX/HVN9CEL6bBdYZYQ=;
 b=XF0PHWFGHR/4A/AHcqaFl2v62z9CITVfg3ujl87fBdi0hvwJimee5aCrcSL0Z8F7SC
 a3m4wMTTmJ75me97Du3KPeNcJVnKrreh0ckMpH7llE+VRUiqRCewxbY2Md3jkz+4xvq/
 6sebd8XiH89IxX31KbYRuro0HqRPWaQ6JdX0z8DJHhPcrPNOPR8ThrWyAepyGTLfWS7/
 Tudbd7HaJRJmytbDFuvAB20ReGcpvd/mAXGBJIrB6ekE8DWjQfOEHbyWIRW1rjzZrUBS
 LSrqp+qUM1xMOaZ6RSSGPLclAVG0K2NlA0gbEgBJQKFaTpPaZnK6WsYodsVVtYm4Wnsz
 BXIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRvsJi3He1FZxXn8RuPfmQcsf5gYE/7p++7uA2nDEUY7UJ40yHyMWIGIdyv6VAonS4Llp5K1UdJfpwwqCsUrqXchXBA3o=
X-Gm-Message-State: AOJu0YxlvEihlJUwqTsyFHYx7qehiPkdiMFzfavdlv9Yfo8SjT2/psAX
 oA472TyTDvZ4nf88VTImmrboNFDxp6i/Fay5DoZ+Czdo3ODtxRaibMkIuWC2QF1nEZAefrF72J1
 9YIDrxnQd5Aax/Ghurv27kToyKKk=
X-Google-Smtp-Source: AGHT+IGcGQxUzM/l2+ig75qF/cXnMS7Qe+FVTmrX9gU8XIXQELY8eMcwwKVfncbj1pzIgTxRDZxNkNCXqsgMXXsMxos=
X-Received: by 2002:a67:fb84:0:b0:471:e1da:ed29 with SMTP id
 n4-20020a67fb84000000b00471e1daed29mr2591595vsr.13.1709689001048; Tue, 05 Mar
 2024 17:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-8-dbarboza@ventanamicro.com>
In-Reply-To: <20240221213140.365232-8-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:36:15 +1000
Message-ID: <CAKmqyKPSQX09fBPqDrBBxA1p6DA_N_eXu+5rhzYKNe_K7GR8tQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] trans_rvv.c.inc: remove redundant mark_vs_dirty()
 calls
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
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

On Thu, Feb 22, 2024 at 7:33=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> trans_vmv_v_i , trans_vfmv_v_f and the trans_##NAME macro from
> GEN_VMV_WHOLE_TRANS() are calling mark_vs_dirty() in both branches of
> their 'ifs'. conditionals.
>
> Call it just once in the end like other functions are doing.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 69f32d081e..db08efa278 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -2044,7 +2044,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_=
v_i *a)
>          if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
>              tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
>                                   MAXSZ(s), MAXSZ(s), simm);
> -            mark_vs_dirty(s);
>          } else {
>              TCGv_i32 desc;
>              TCGv_i64 s1;
> @@ -2062,9 +2061,8 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_=
v_i *a)
>                                                s->cfg_ptr->vlenb, data));
>              tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
>              fns[s->sew](dest, s1, tcg_env, desc);
> -
> -            mark_vs_dirty(s);
>          }
> +        mark_vs_dirty(s);
>          return true;
>      }
>      return false;
> @@ -2591,7 +2589,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfm=
v_v_f *a)
>
>              tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
>                                   MAXSZ(s), MAXSZ(s), t1);
> -            mark_vs_dirty(s);
>          } else {
>              TCGv_ptr dest;
>              TCGv_i32 desc;
> @@ -2614,9 +2611,8 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfm=
v_v_f *a)
>              tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
>
>              fns[s->sew - 1](dest, t1, tcg_env, desc);
> -
> -            mark_vs_dirty(s);
>          }
> +        mark_vs_dirty(s);
>          return true;
>      }
>      return false;
> @@ -3524,12 +3520,11 @@ static bool trans_##NAME(DisasContext *s, arg_##N=
AME * a)               \
>          if (s->vstart_eq_zero) {                                        =
\
>              tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),                =
\
>                               vreg_ofs(s, a->rs2), maxsz, maxsz);        =
\
> -            mark_vs_dirty(s);                                           =
\
>          } else {                                                        =
\
>              tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), =
\
>                                 tcg_env, maxsz, maxsz, 0, gen_helper_vmvr=
_v); \
> -            mark_vs_dirty(s);                                           =
\
>          }                                                               =
\
> +        mark_vs_dirty(s);                                               =
\
>          return true;                                                    =
\
>      }                                                                   =
\
>      return false;                                                       =
\
> --
> 2.43.2
>
>

