Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B72C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhgFo-0006Zj-3Q; Tue, 05 Mar 2024 20:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgFl-0006ZS-Vb; Tue, 05 Mar 2024 20:39:29 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgFj-0005Xp-8v; Tue, 05 Mar 2024 20:39:29 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-47268928105so336402137.1; 
 Tue, 05 Mar 2024 17:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709689166; x=1710293966; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qv8xdlTrDZkIAcCukScrqQi/ki4/B6nd1CQZ9UGoBao=;
 b=VW3ROD8UdyxR7qWPEpyqcL+B7yaWEfnOchesg0jG2cN6ejroJVAS90PdDTAV9CkVV6
 D6n4Pz2eJ8Mus6vHPOFE2GKeh1JBGUNxh8OT96MXrfVd5JOGd/H8YNaEDz96Pv5nVN9K
 rU5uQXYheSfFrIei2tp1G7a61vUxb7i10JifOCd8+DivnmL97BSISi0FPZPld2vnPaDh
 h4Y0MhrVwtryBtGxqjOvHy1NQQqj/cP5XF8pjOHZHYI3UYw76GTkZpBmMKP2WU8JM1Wc
 Pdpjuxq8K04XAT4nCVkDMUPiUy/HCRtiQ9wYbemXHZByjeKV/n/AZXdtrkSKGjZZ+A/4
 pS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709689166; x=1710293966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qv8xdlTrDZkIAcCukScrqQi/ki4/B6nd1CQZ9UGoBao=;
 b=QgP+Y0yZW/1x8AT+cGIfgVlaqyK4G/xp+vdUbKOGw6uQ8pWU0UCXkg7BCOVtAEJgNO
 kV4ggJnPmD65atO3sx8zeS3kWHwONdHRWbdWygQSNqGdiI3U9E9O2jFGRv6abPGa4i23
 ogNuiv/NzrLcdx8hCpnw3FMuN4bpA+EzUDrFT1B2bWjFP9hmkcNrKmEosOzUrxwegrFw
 Jj0s8lOxNQc2t8xYpM2faMEdY8PrpqK35OuqoocQdZr6hmTaZdQyIsXnseQNgYr84YXR
 1reW0L9oxLk+p0HhW1DNz5/4AyRX1ctV2WmZ5oWLSZvkFUq9BsgPz1fWB0Dal6MGMwOl
 25NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoNX5VetRFo6Sa+nrT0PjvKGS2LLebdw81lh22D1LS0l9w1ssiewErHlPDklpYSUIv8RWV/PBIvJlkYNGHqydCIQT4/uM=
X-Gm-Message-State: AOJu0Yy3YDmvDHXMJ0mXcSAd7gpE7xvNVrGl8u2kqUC2fctr/RmXrLK7
 RD0HCEz/uP6wj5i01NdBhG4iTAH60cCmIokx/RMW63x9LoFaNW7UYzd04HiUzTJhB/HBhiWpc6m
 gMRdjiiPC7AbzRwN3p/Gx5+d2/Xw=
X-Google-Smtp-Source: AGHT+IHeNzTl6uplwKWgtU6sp2HGasg6qEcIE2mNGjY11CR+RljhMfGEufp3iGnqfgxK2/4pQi0A4K/kmeLqQbMxFGI=
X-Received: by 2002:a05:6102:953:b0:472:e6f4:5aec with SMTP id
 a19-20020a056102095300b00472e6f45aecmr1968423vsi.9.1709689165734; Tue, 05 Mar
 2024 17:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-9-dbarboza@ventanamicro.com>
In-Reply-To: <20240221213140.365232-9-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:38:59 +1000
Message-ID: <CAKmqyKMSawmuKxRFZB+TNYJbkVCedLW+Hzu_QViQc9gMdaV1Kg@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] target/riscv: Clear vstart_qe_zero flag
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org, max.chou@sifive.com, 
 Ivan Klokov <ivan.klokov@syntacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Thu, Feb 22, 2024 at 7:34=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Ivan Klokov <ivan.klokov@syntacore.com>
>
> The vstart_qe_zero flag is set at the beginning of the translation
> phase from the env->vstart variable. During the execution phase all
> functions will set env->vstart =3D 0 after a successful execution,
> but the vstart_eq_zero flag remains the same as at the start of the
> block. This will wrongly cause SIGILLs in translations that requires
> env->vstart =3D 0 and might be reading vstart_eq_zero =3D false.
>
> This patch adds a new finalize_rvv_inst() helper that is called at the
> end of each vector instruction that will both update vstart_eq_zero and
> do a mark_vs_dirty().
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1976
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvbf16.c.inc |  6 +-
>  target/riscv/insn_trans/trans_rvv.c.inc    | 78 ++++++++++++----------
>  target/riscv/insn_trans/trans_rvvk.c.inc   | 12 ++--
>  target/riscv/translate.c                   |  6 ++
>  4 files changed, 56 insertions(+), 46 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/in=
sn_trans/trans_rvbf16.c.inc
> index a842e76a6b..0a9cd1ec31 100644
> --- a/target/riscv/insn_trans/trans_rvbf16.c.inc
> +++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
> @@ -83,7 +83,7 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, a=
rg_vfncvtbf16_f_f_w *a)
>                             ctx->cfg_ptr->vlenb,
>                             ctx->cfg_ptr->vlenb, data,
>                             gen_helper_vfncvtbf16_f_f_w);
> -        mark_vs_dirty(ctx);
> +        finalize_rvv_inst(ctx);
>          return true;
>      }
>      return false;
> @@ -108,7 +108,7 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx,=
 arg_vfwcvtbf16_f_f_v *a)
>                             ctx->cfg_ptr->vlenb,
>                             ctx->cfg_ptr->vlenb, data,
>                             gen_helper_vfwcvtbf16_f_f_v);
> -        mark_vs_dirty(ctx);
> +        finalize_rvv_inst(ctx);
>          return true;
>      }
>      return false;
> @@ -135,7 +135,7 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, a=
rg_vfwmaccbf16_vv *a)
>                             ctx->cfg_ptr->vlenb,
>                             ctx->cfg_ptr->vlenb, data,
>                             gen_helper_vfwmaccbf16_vv);
> -        mark_vs_dirty(ctx);
> +        finalize_rvv_inst(ctx);
>          return true;
>      }
>      return false;
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index db08efa278..1933a6f5c2 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -167,7 +167,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs=
1, TCGv s2)
>
>      gen_helper_vsetvl(dst, tcg_env, s1, s2);
>      gen_set_gpr(s, rd, dst);
> -    mark_vs_dirty(s);
> +    finalize_rvv_inst(s);
>
>      gen_update_pc(s, s->cur_insn_len);
>      lookup_and_goto_ptr(s);
> @@ -187,7 +187,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv=
 s1, TCGv s2)
>
>      gen_helper_vsetvl(dst, tcg_env, s1, s2);
>      gen_set_gpr(s, rd, dst);
> -    mark_vs_dirty(s);
> +    finalize_rvv_inst(s);
>      gen_update_pc(s, s->cur_insn_len);
>      lookup_and_goto_ptr(s);
>      s->base.is_jmp =3D DISAS_NORETURN;
> @@ -636,6 +636,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, =
uint32_t data,
>
>      fn(dest, mask, base, tcg_env, desc);
>
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> @@ -791,6 +792,7 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t r=
s1, uint32_t rs2,
>
>      fn(dest, mask, base, stride, tcg_env, desc);
>
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> @@ -892,6 +894,7 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs=
1, uint32_t vs2,
>
>      fn(dest, mask, base, index, tcg_env, desc);
>
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> @@ -1022,7 +1025,7 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, u=
int32_t data,
>
>      fn(dest, mask, base, tcg_env, desc);
>
> -    mark_vs_dirty(s);
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> @@ -1079,6 +1082,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t =
rs1, uint32_t nf,
>
>      fn(dest, base, tcg_env, desc);
>
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> @@ -1168,7 +1172,7 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen=
3Fn *gvec_fn,
>                             tcg_env, s->cfg_ptr->vlenb,
>                             s->cfg_ptr->vlenb, data, fn);
>      }
> -    mark_vs_dirty(s);
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> @@ -1219,7 +1223,7 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, =
uint32_t vs2, uint32_t vm,
>
>      fn(dest, mask, src1, src2, tcg_env, desc);
>
> -    mark_vs_dirty(s);
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> @@ -1244,7 +1248,7 @@ do_opivx_gvec(DisasContext *s, arg_rmrr *a, GVecGen=
2sFn *gvec_fn,
>          gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
>                  src1, MAXSZ(s), MAXSZ(s));
>
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
> @@ -1377,7 +1381,7 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, =
uint32_t vs2, uint32_t vm,
>
>      fn(dest, mask, src1, src2, tcg_env, desc);
>
> -    mark_vs_dirty(s);
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> @@ -1391,7 +1395,7 @@ do_opivi_gvec(DisasContext *s, arg_rmrr *a, GVecGen=
2iFn *gvec_fn,
>      if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
>          gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
>                  extract_imm(s, a->rs1, imm_mode), MAXSZ(s), MAXSZ(s));
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s, imm_mode);
> @@ -1450,7 +1454,7 @@ static bool do_opivv_widen(DisasContext *s, arg_rmr=
r *a,
>                             tcg_env, s->cfg_ptr->vlenb,
>                             s->cfg_ptr->vlenb,
>                             data, fn);
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -1522,7 +1526,7 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmr=
r *a,
>                             vreg_ofs(s, a->rs2),
>                             tcg_env, s->cfg_ptr->vlenb,
>                             s->cfg_ptr->vlenb, data, fn);
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -1590,7 +1594,7 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, =
uint32_t vs2, uint32_t vm,
>      tcg_gen_gvec_4_ptr(vreg_ofs(s, vd), vreg_ofs(s, 0), vreg_ofs(s, vs1)=
,
>                         vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlenb,
>                         s->cfg_ptr->vlenb, data, fn);
> -    mark_vs_dirty(s);
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> @@ -1723,7 +1727,7 @@ do_opivx_gvec_shift(DisasContext *s, arg_rmrr *a, G=
VecGen2sFn32 *gvec_fn,
>          gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
>                  src1, MAXSZ(s), MAXSZ(s));
>
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
> @@ -1780,7 +1784,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)             \
>                             s->cfg_ptr->vlenb,                      \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew]);                           \
> -        mark_vs_dirty(s);                                          \
> +        finalize_rvv_inst(s);                                      \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -1983,7 +1987,7 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_=
v_v *a)
>                                 s->cfg_ptr->vlenb, data,
>                                 fns[s->sew]);
>          }
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -2028,7 +2032,7 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_=
v_x *a)
>              fns[s->sew](dest, s1_i64, tcg_env, desc);
>          }
>
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -2062,7 +2066,7 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_=
v_i *a)
>              tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
>              fns[s->sew](dest, s1, tcg_env, desc);
>          }
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -2210,7 +2214,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)             \
>                             s->cfg_ptr->vlenb,                      \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew - 1]);                       \
> -        mark_vs_dirty(s);                                          \
> +        finalize_rvv_inst(s);                                      \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2244,7 +2248,7 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, =
uint32_t vs2,
>
>      fn(dest, mask, t1, src2, tcg_env, desc);
>
> -    mark_vs_dirty(s);
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> @@ -2319,7 +2323,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)           \
>                             s->cfg_ptr->vlenb,                    \
>                             s->cfg_ptr->vlenb, data,              \
>                             fns[s->sew - 1]);                     \
> -        mark_vs_dirty(s);                                        \
> +        finalize_rvv_inst(s);                                    \
>          return true;                                             \
>      }                                                            \
>      return false;                                                \
> @@ -2390,7 +2394,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)             \
>                             s->cfg_ptr->vlenb,                      \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew - 1]);                       \
> -        mark_vs_dirty(s);                                          \
> +        finalize_rvv_inst(s);                                      \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2502,7 +2506,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
>                             vreg_ofs(s, a->rs2), tcg_env,
>                             s->cfg_ptr->vlenb,
>                             s->cfg_ptr->vlenb, data, fn);
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -2612,7 +2616,7 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfm=
v_v_f *a)
>
>              fns[s->sew - 1](dest, t1, tcg_env, desc);
>          }
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -2684,7 +2688,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>                             s->cfg_ptr->vlenb,                      \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew - 1]);                       \
> -        mark_vs_dirty(s);                                          \
> +        finalize_rvv_inst(s);                                      \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2732,7 +2736,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>                             s->cfg_ptr->vlenb,                      \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew]);                           \
> -        mark_vs_dirty(s);                                          \
> +        finalize_rvv_inst(s);                                      \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2796,7 +2800,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>                             s->cfg_ptr->vlenb,                      \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew - 1]);                       \
> -        mark_vs_dirty(s);                                          \
> +        finalize_rvv_inst(s);                                      \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2842,7 +2846,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>                             s->cfg_ptr->vlenb,                      \
>                             s->cfg_ptr->vlenb, data,                \
>                             fns[s->sew]);                           \
> -        mark_vs_dirty(s);                                          \
> +        finalize_rvv_inst(s);                                      \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -2928,7 +2932,7 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)=
                \
>                             vreg_ofs(s, a->rs2), tcg_env,           \
>                             s->cfg_ptr->vlenb,                      \
>                             s->cfg_ptr->vlenb, data, fn);           \
> -        mark_vs_dirty(s);                                          \
> +        finalize_rvv_inst(s);                                      \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -3027,7 +3031,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *=
a)              \
>                             tcg_env, s->cfg_ptr->vlenb,             \
>                             s->cfg_ptr->vlenb,                      \
>                             data, fn);                              \
> -        mark_vs_dirty(s);                                          \
> +        finalize_rvv_inst(s);                                      \
>          return true;                                               \
>      }                                                              \
>      return false;                                                  \
> @@ -3066,7 +3070,7 @@ static bool trans_viota_m(DisasContext *s, arg_viot=
a_m *a)
>                             vreg_ofs(s, a->rs2), tcg_env,
>                             s->cfg_ptr->vlenb,
>                             s->cfg_ptr->vlenb, data, fns[s->sew]);
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -3093,7 +3097,7 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v =
*a)
>                             tcg_env, s->cfg_ptr->vlenb,
>                             s->cfg_ptr->vlenb,
>                             data, fns[s->sew]);
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -3272,7 +3276,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_=
s_x *a)
>          s1 =3D get_gpr(s, a->rs1, EXT_NONE);
>          tcg_gen_ext_tl_i64(t1, s1);
>          vec_element_storei(s, a->rd, 0, t1);
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -3320,7 +3324,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfm=
v_s_f *a)
>          do_nanbox(s, t1, cpu_fpr[a->rs1]);
>
>          vec_element_storei(s, a->rd, 0, t1);
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -3426,7 +3430,7 @@ static bool trans_vrgather_vx(DisasContext *s, arg_=
rmrr *a)
>
>          tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
>                               MAXSZ(s), MAXSZ(s), dest);
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>      } else {
>          static gen_helper_opivx * const fns[4] =3D {
>              gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
> @@ -3454,7 +3458,7 @@ static bool trans_vrgather_vi(DisasContext *s, arg_=
rmrr *a)
>                                   endian_ofs(s, a->rs2, a->rs1),
>                                   MAXSZ(s), MAXSZ(s));
>          }
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>      } else {
>          static gen_helper_opivx * const fns[4] =3D {
>              gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
> @@ -3499,7 +3503,7 @@ static bool trans_vcompress_vm(DisasContext *s, arg=
_r *a)
>                             tcg_env, s->cfg_ptr->vlenb,
>                             s->cfg_ptr->vlenb, data,
>                             fns[s->sew]);
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -3524,7 +3528,7 @@ static bool trans_##NAME(DisasContext *s, arg_##NAM=
E * a)               \
>              tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), =
\
>                                 tcg_env, maxsz, maxsz, 0, gen_helper_vmvr=
_v); \
>          }                                                               =
\
> -        mark_vs_dirty(s);                                               =
\
> +        finalize_rvv_inst(s);                                           =
\
>          return true;                                                    =
\
>      }                                                                   =
\
>      return false;                                                       =
\
> @@ -3595,7 +3599,7 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a,=
 uint8_t seq)
>                         s->cfg_ptr->vlenb,
>                         s->cfg_ptr->vlenb, data, fn);
>
> -    mark_vs_dirty(s);
> +    finalize_rvv_inst(s);
>      return true;
>  }
>
> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn=
_trans/trans_rvvk.c.inc
> index 6d640e4596..ae1f40174a 100644
> --- a/target/riscv/insn_trans/trans_rvvk.c.inc
> +++ b/target/riscv/insn_trans/trans_rvvk.c.inc
> @@ -174,7 +174,7 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_c=
heck)
>                                 vreg_ofs(s, a->rs2), tcg_env,            =
   \
>                                 s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,    =
   \
>                                 data, fns[s->sew]);                      =
   \
> -            mark_vs_dirty(s);                                           =
   \
> +            finalize_rvv_inst(s);                                       =
   \
>              return true;                                                =
   \
>          }                                                               =
   \
>          return false;                                                   =
   \
> @@ -266,7 +266,7 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vws=
ll_vx_check)
>              tcg_gen_addi_ptr(rd_v, tcg_env, vreg_ofs(s, a->rd));        =
      \
>              tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));      =
      \
>              gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);              =
      \
> -            mark_vs_dirty(s);                                           =
      \
> +            finalize_rvv_inst(s);                                       =
      \
>              return true;                                                =
      \
>          }                                                               =
      \
>          return false;                                                   =
      \
> @@ -341,7 +341,7 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED=
_EGS)
>              tcg_gen_addi_ptr(rd_v, tcg_env, vreg_ofs(s, a->rd));        =
      \
>              tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));      =
      \
>              gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);      =
      \
> -            mark_vs_dirty(s);                                           =
      \
> +            finalize_rvv_inst(s);                                       =
      \
>              return true;                                                =
      \
>          }                                                               =
      \
>          return false;                                                   =
      \
> @@ -405,7 +405,7 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKN=
ED_EGS)
>                                 s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,    =
      \
>                                 data, gen_helper_##NAME);                =
      \
>                                                                          =
      \
> -            mark_vs_dirty(s);                                           =
      \
> +            finalize_rvv_inst(s);                                       =
      \
>              return true;                                                =
      \
>          }                                                               =
      \
>          return false;                                                   =
      \
> @@ -457,7 +457,7 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmr=
r *a)
>              s->sew =3D=3D MO_32 ?
>                  gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
>
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> @@ -488,7 +488,7 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmr=
r *a)
>              s->sew =3D=3D MO_32 ?
>                  gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
>
> -        mark_vs_dirty(s);
> +        finalize_rvv_inst(s);
>          return true;
>      }
>      return false;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 3040f5e0e4..6b107186de 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -674,6 +674,12 @@ static void mark_vs_dirty(DisasContext *ctx)
>  static inline void mark_vs_dirty(DisasContext *ctx) { }
>  #endif
>
> +static void finalize_rvv_inst(DisasContext *ctx)
> +{
> +    mark_vs_dirty(ctx);
> +    ctx->vstart_eq_zero =3D true;
> +}
> +
>  static void gen_set_rm(DisasContext *ctx, int rm)
>  {
>      if (ctx->frm =3D=3D rm) {
> --
> 2.43.2
>
>

