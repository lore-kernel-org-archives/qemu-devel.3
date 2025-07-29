Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E2CC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 03:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugavU-00052R-CU; Mon, 28 Jul 2025 23:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugavS-00050F-7x; Mon, 28 Jul 2025 23:22:50 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugavP-0005Wt-Mw; Mon, 28 Jul 2025 23:22:49 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5315ebfda19so1687206e0c.1; 
 Mon, 28 Jul 2025 20:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753759366; x=1754364166; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMY9qF/HMQwLOGZH9shqClkch8X+1Vpxc/qabb/gbXQ=;
 b=jWtHkeGmUKFYchxvu2Mi9bGgSrU5xPdbo4nzAR1aRB6Q1mWWhDc82sw9CejX1VHlWL
 rhhy30MIjgRDJ2+R5CezmV4oKhlGcJ9no4ZJFbqx9FwOj/8ahj3JetSQJvhrmuhlRWMx
 i6xnpJYxBfKkh4tO7SiqGbFRjfBFivMHJraH8mFg8iDywnHLJFqhrHUzyVJHctU4K+84
 fh+FpUw0lJgqPp0SXKwxEaIDXSQnYeAPTNmrVzFj880Z7uDV+nXBjRFtsTAufU02wTXt
 cyk09ytxOGNzTuHHc7jEk/q97fxEY9QvHng7PSifjq4VURRvuVw+veJfewGdLtD/aEfO
 KqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753759366; x=1754364166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMY9qF/HMQwLOGZH9shqClkch8X+1Vpxc/qabb/gbXQ=;
 b=DlfJ6wScuBo92ehKbH50Bs1zy/4nIxRwjwp/NK4EUnDtiQYhmM17+DqysbuNQ0bK5A
 dUCUdud1vCdxdkdHCYnZZw3S2UNscjAdbRVkRuCtGHYIV/lTlQKcP8Q4tBMLr7QjQQG7
 g5ixHH1KBPRxe0cjOhSMIz6FenAOdd84W226WoN9QYWeCzHPUVpEBuVrED/yqLGEqPfi
 MxU9hOcXs020S0hYN4AHLXeDplg2/SxaQNZXuknr4za3SSDMZRZLLK2SGhwCEK4Ft7VS
 tgOs2eMci0wqynInI1FWGCsXnzmBoFonvsctmVdTtmhaAd74CXWHbOLoBBagjgrPL/1X
 gjZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm+/b6Obctyz4iX2K28tfjrMBiUBP8AKd2IEQUTXo4sAhv/J6rgzWyCxtGHLdF7pqIRNda4x7N7ttX@nongnu.org
X-Gm-Message-State: AOJu0YxIBn3alL8ccxLjCISoqXOxI9/So//UlAPxDuD/H8wRURNGxYIJ
 PtZ6yvcVIvZeF+DKuqQ8AvvoUlTi/JprcoQTit+rp6DiFoCVmiosWXiPZumajZbPoZWkC7b5y+T
 X4oAhK5IIurh+zWgwsrKmt3oSVRWWk7+i4A==
X-Gm-Gg: ASbGncu62r/x4OKOl+VILlNg3wdqLP+yvAx/pQ/1s1jsfgVi3vIYD2rY6pR0kFj+ui/
 H4S9Yr9jvJXCNENW317gCdS/9yasNSYS37Wg8dYCoXnmhEfG3R7tTvLw316KFqvJyUSLtG2KaH8
 pRBTrz3Gat8juM2KUNPhwQdYJm7GHCHa9dk6wrPfz9SfWSp1nozdR3A6vnKF5MHY2XMlRw2ifc2
 U0FdGdOLgwlgaM+zZ7aPDa3am9VhDzjtGlstQ==
X-Google-Smtp-Source: AGHT+IG3afyfayD2L2enDp1hcxN/16uVUPscdYeApUAZUJi62yNrC60XE/cVOnbOy806yx+OtsFZ/U0hktCAbni+uD4=
X-Received: by 2002:a05:6122:3094:b0:538:d49b:719 with SMTP id
 71dfb90a1353d-538db4efaccmr5049098e0c.1.1753759365739; Mon, 28 Jul 2025
 20:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250710100525.372985-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250710100525.372985-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Jul 2025 13:22:19 +1000
X-Gm-Features: Ac12FXx1W1rnLhs9oAkZ3eexWyt5j0TcnXoV2SQxkva6KOdxf16aA4W3AflK_u8
Message-ID: <CAKmqyKN2YW9iYzakUS-KQ6MdfbX8g__k5acrwiSwiqf8vyW84A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Revert "Generate strided vector loads/stores with
 tcg nodes."
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
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

On Thu, Jul 10, 2025 at 8:06=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> This reverts commit 28c12c1f2f50d7f7f1ebfc587c4777ecd50aac5b.
>
> As reported in [1] this commit is breaking Linux vector code, and
> although a simpler reproducer was provided, the fix itself isn't trivial
> due to the amount and the nature of the changes. And we really do not
> want to keep Linux broken while we work on it.
>
> The revert will fix Linux and will give us time to do a proper fix.
>
> [1] https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02525.html
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 323 ++++--------------------
>  1 file changed, 50 insertions(+), 273 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 610bf9ff30..71f98fb350 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -864,286 +864,32 @@ GEN_VEXT_TRANS(vlm_v, MO_8, vlm_v, ld_us_mask_op, =
ld_us_mask_check)
>  GEN_VEXT_TRANS(vsm_v, MO_8, vsm_v, st_us_mask_op, st_us_mask_check)
>
>  /*
> - * MAXSZ returns the maximum vector size can be operated in bytes,
> - * which is used in GVEC IR when vl_eq_vlmax flag is set to true
> - * to accelerate vector operation.
> - */
> -static inline uint32_t MAXSZ(DisasContext *s)
> -{
> -    int max_sz =3D s->cfg_ptr->vlenb << 3;
> -    return max_sz >> (3 - s->lmul);
> -}
> -
> -static inline uint32_t get_log2(uint32_t a)
> -{
> -    uint32_t i =3D 0;
> -    for (; a > 0;) {
> -        a >>=3D 1;
> -        i++;
> -    }
> -    return i;
> -}
> -
> -typedef void gen_tl_ldst(TCGv, TCGv_ptr, tcg_target_long);
> -
> -/*
> - * Simulate the strided load/store main loop:
> - *
> - * for (i =3D env->vstart; i < env->vl; env->vstart =3D ++i) {
> - *     k =3D 0;
> - *     while (k < nf) {
> - *         if (!vm && !vext_elem_mask(v0, i)) {
> - *             vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
> - *                               (i + k * max_elems + 1) * esz);
> - *             k++;
> - *             continue;
> - *         }
> - *         target_ulong addr =3D base + stride * i + (k << log2_esz);
> - *         ldst(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
> - *         k++;
> - *     }
> - * }
> - */
> -static void gen_ldst_stride_main_loop(DisasContext *s, TCGv dest, uint32=
_t rs1,
> -                                      uint32_t rs2, uint32_t vm, uint32_=
t nf,
> -                                      gen_tl_ldst *ld_fn, gen_tl_ldst *s=
t_fn,
> -                                      bool is_load)
> -{
> -    TCGv addr =3D tcg_temp_new();
> -    TCGv base =3D get_gpr(s, rs1, EXT_NONE);
> -    TCGv stride =3D get_gpr(s, rs2, EXT_NONE);
> -
> -    TCGv i =3D tcg_temp_new();
> -    TCGv i_esz =3D tcg_temp_new();
> -    TCGv k =3D tcg_temp_new();
> -    TCGv k_esz =3D tcg_temp_new();
> -    TCGv k_max =3D tcg_temp_new();
> -    TCGv mask =3D tcg_temp_new();
> -    TCGv mask_offs =3D tcg_temp_new();
> -    TCGv mask_offs_64 =3D tcg_temp_new();
> -    TCGv mask_elem =3D tcg_temp_new();
> -    TCGv mask_offs_rem =3D tcg_temp_new();
> -    TCGv vreg =3D tcg_temp_new();
> -    TCGv dest_offs =3D tcg_temp_new();
> -    TCGv stride_offs =3D tcg_temp_new();
> -
> -    uint32_t max_elems =3D MAXSZ(s) >> s->sew;
> -
> -    TCGLabel *start =3D gen_new_label();
> -    TCGLabel *end =3D gen_new_label();
> -    TCGLabel *start_k =3D gen_new_label();
> -    TCGLabel *inc_k =3D gen_new_label();
> -    TCGLabel *end_k =3D gen_new_label();
> -
> -    MemOp atomicity =3D MO_ATOM_NONE;
> -    if (s->sew =3D=3D 0) {
> -        atomicity =3D MO_ATOM_NONE;
> -    } else {
> -        atomicity =3D MO_ATOM_IFALIGN_PAIR;
> -    }
> -
> -    mark_vs_dirty(s);
> -
> -    tcg_gen_addi_tl(mask, (TCGv)tcg_env, vreg_ofs(s, 0));
> -
> -    /* Start of outer loop. */
> -    tcg_gen_mov_tl(i, cpu_vstart);
> -    gen_set_label(start);
> -    tcg_gen_brcond_tl(TCG_COND_GE, i, cpu_vl, end);
> -    tcg_gen_shli_tl(i_esz, i, s->sew);
> -    /* Start of inner loop. */
> -    tcg_gen_movi_tl(k, 0);
> -    gen_set_label(start_k);
> -    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end_k);
> -    /*
> -     * If we are in mask agnostic regime and the operation is not unmask=
ed we
> -     * set the inactive elements to 1.
> -     */
> -    if (!vm && s->vma) {
> -        TCGLabel *active_element =3D gen_new_label();
> -        /* (i + k * max_elems) * esz */
> -        tcg_gen_shli_tl(mask_offs, k, get_log2(max_elems << s->sew));
> -        tcg_gen_add_tl(mask_offs, mask_offs, i_esz);
> -
> -        /*
> -         * Check whether the i bit of the mask is 0 or 1.
> -         *
> -         * static inline int vext_elem_mask(void *v0, int index)
> -         * {
> -         *     int idx =3D index / 64;
> -         *     int pos =3D index  % 64;
> -         *     return (((uint64_t *)v0)[idx] >> pos) & 1;
> -         * }
> -         */
> -        tcg_gen_shri_tl(mask_offs_64, mask_offs, 3);
> -        tcg_gen_add_tl(mask_offs_64, mask_offs_64, mask);
> -        tcg_gen_ld_i64((TCGv_i64)mask_elem, (TCGv_ptr)mask_offs_64, 0);
> -        tcg_gen_rem_tl(mask_offs_rem, mask_offs, tcg_constant_tl(8));
> -        tcg_gen_shr_tl(mask_elem, mask_elem, mask_offs_rem);
> -        tcg_gen_andi_tl(mask_elem, mask_elem, 1);
> -        tcg_gen_brcond_tl(TCG_COND_NE, mask_elem, tcg_constant_tl(0),
> -                          active_element);
> -        /*
> -         * Set masked-off elements in the destination vector register to=
 1s.
> -         * Store instructions simply skip this bit as memory ops access =
memory
> -         * only for active elements.
> -         */
> -        if (is_load) {
> -            tcg_gen_shli_tl(mask_offs, mask_offs, s->sew);
> -            tcg_gen_add_tl(mask_offs, mask_offs, dest);
> -            st_fn(tcg_constant_tl(-1), (TCGv_ptr)mask_offs, 0);
> -        }
> -        tcg_gen_br(inc_k);
> -        gen_set_label(active_element);
> -    }
> -    /*
> -     * The element is active, calculate the address with stride:
> -     * target_ulong addr =3D base + stride * i + (k << log2_esz);
> -     */
> -    tcg_gen_mul_tl(stride_offs, stride, i);
> -    tcg_gen_shli_tl(k_esz, k, s->sew);
> -    tcg_gen_add_tl(stride_offs, stride_offs, k_esz);
> -    tcg_gen_add_tl(addr, base, stride_offs);
> -    /* Calculate the offset in the dst/src vector register. */
> -    tcg_gen_shli_tl(k_max, k, get_log2(max_elems));
> -    tcg_gen_add_tl(dest_offs, i, k_max);
> -    tcg_gen_shli_tl(dest_offs, dest_offs, s->sew);
> -    tcg_gen_add_tl(dest_offs, dest_offs, dest);
> -    if (is_load) {
> -        tcg_gen_qemu_ld_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atom=
icity);
> -        st_fn((TCGv)vreg, (TCGv_ptr)dest_offs, 0);
> -    } else {
> -        ld_fn((TCGv)vreg, (TCGv_ptr)dest_offs, 0);
> -        tcg_gen_qemu_st_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atom=
icity);
> -    }
> -    /*
> -     * We don't execute the load/store above if the element was inactive=
.
> -     * We jump instead directly to incrementing k and continuing the loo=
p.
> -     */
> -    if (!vm && s->vma) {
> -        gen_set_label(inc_k);
> -    }
> -    tcg_gen_addi_tl(k, k, 1);
> -    tcg_gen_br(start_k);
> -    /* End of the inner loop. */
> -    gen_set_label(end_k);
> -
> -    tcg_gen_addi_tl(i, i, 1);
> -    tcg_gen_mov_tl(cpu_vstart, i);
> -    tcg_gen_br(start);
> -
> -    /* End of the outer loop. */
> -    gen_set_label(end);
> -
> -    return;
> -}
> -
> -
> -/*
> - * Set the tail bytes of the strided loads/stores to 1:
> - *
> - * for (k =3D 0; k < nf; ++k) {
> - *     cnt =3D (k * max_elems + vl) * esz;
> - *     tot =3D (k * max_elems + max_elems) * esz;
> - *     for (i =3D cnt; i < tot; i +=3D esz) {
> - *         store_1s(-1, vd[vl+i]);
> - *     }
> - * }
> + *** stride load and store
>   */
> -static void gen_ldst_stride_tail_loop(DisasContext *s, TCGv dest, uint32=
_t nf,
> -                                      gen_tl_ldst *st_fn)
> -{
> -    TCGv i =3D tcg_temp_new();
> -    TCGv k =3D tcg_temp_new();
> -    TCGv tail_cnt =3D tcg_temp_new();
> -    TCGv tail_tot =3D tcg_temp_new();
> -    TCGv tail_addr =3D tcg_temp_new();
> -
> -    TCGLabel *start =3D gen_new_label();
> -    TCGLabel *end =3D gen_new_label();
> -    TCGLabel *start_i =3D gen_new_label();
> -    TCGLabel *end_i =3D gen_new_label();
> -
> -    uint32_t max_elems_b =3D MAXSZ(s);
> -    uint32_t esz =3D 1 << s->sew;
> -
> -    /* Start of the outer loop. */
> -    tcg_gen_movi_tl(k, 0);
> -    tcg_gen_shli_tl(tail_cnt, cpu_vl, s->sew);
> -    tcg_gen_movi_tl(tail_tot, max_elems_b);
> -    tcg_gen_add_tl(tail_addr, dest, tail_cnt);
> -    gen_set_label(start);
> -    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end);
> -    /* Start of the inner loop. */
> -    tcg_gen_mov_tl(i, tail_cnt);
> -    gen_set_label(start_i);
> -    tcg_gen_brcond_tl(TCG_COND_GE, i, tail_tot, end_i);
> -    /* store_1s(-1, vd[vl+i]); */
> -    st_fn(tcg_constant_tl(-1), (TCGv_ptr)tail_addr, 0);
> -    tcg_gen_addi_tl(tail_addr, tail_addr, esz);
> -    tcg_gen_addi_tl(i, i, esz);
> -    tcg_gen_br(start_i);
> -    /* End of the inner loop. */
> -    gen_set_label(end_i);
> -    /* Update the counts */
> -    tcg_gen_addi_tl(tail_cnt, tail_cnt, max_elems_b);
> -    tcg_gen_addi_tl(tail_tot, tail_cnt, max_elems_b);
> -    tcg_gen_addi_tl(k, k, 1);
> -    tcg_gen_br(start);
> -    /* End of the outer loop. */
> -    gen_set_label(end);
> -
> -    return;
> -}
> +typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
> +                                    TCGv, TCGv_env, TCGv_i32);
>
>  static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
> -                              uint32_t data, DisasContext *s, bool is_lo=
ad)
> +                              uint32_t data, gen_helper_ldst_stride *fn,
> +                              DisasContext *s)
>  {
> -    if (!s->vstart_eq_zero) {
> -        return false;
> -    }
> -
> -    TCGv dest =3D tcg_temp_new();
> -
> -    uint32_t nf =3D FIELD_EX32(data, VDATA, NF);
> -    uint32_t vm =3D FIELD_EX32(data, VDATA, VM);
> -
> -    /* Destination register and mask register */
> -    tcg_gen_addi_tl(dest, (TCGv)tcg_env, vreg_ofs(s, vd));
> -
> -    /*
> -     * Select the appropriate load/tore to retrieve data from the vector
> -     * register given a specific sew.
> -     */
> -    static gen_tl_ldst * const ld_fns[4] =3D {
> -        tcg_gen_ld8u_tl, tcg_gen_ld16u_tl,
> -        tcg_gen_ld32u_tl, tcg_gen_ld_tl
> -    };
> -
> -    static gen_tl_ldst * const st_fns[4] =3D {
> -        tcg_gen_st8_tl, tcg_gen_st16_tl,
> -        tcg_gen_st32_tl, tcg_gen_st_tl
> -    };
> +    TCGv_ptr dest, mask;
> +    TCGv base, stride;
> +    TCGv_i32 desc;
>
> -    gen_tl_ldst *ld_fn =3D ld_fns[s->sew];
> -    gen_tl_ldst *st_fn =3D st_fns[s->sew];
> +    dest =3D tcg_temp_new_ptr();
> +    mask =3D tcg_temp_new_ptr();
> +    base =3D get_gpr(s, rs1, EXT_NONE);
> +    stride =3D get_gpr(s, rs2, EXT_NONE);
> +    desc =3D tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
> +                                      s->cfg_ptr->vlenb, data));
>
> -    if (ld_fn =3D=3D NULL || st_fn =3D=3D NULL) {
> -        return false;
> -    }
> +    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
> +    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
>
>      mark_vs_dirty(s);
>
> -    gen_ldst_stride_main_loop(s, dest, rs1, rs2, vm, nf, ld_fn, st_fn, i=
s_load);
> -
> -    tcg_gen_movi_tl(cpu_vstart, 0);
> -
> -    /*
> -     * Set the tail bytes to 1 if tail agnostic:
> -     */
> -    if (s->vta !=3D 0 && is_load) {
> -        gen_ldst_stride_tail_loop(s, dest, nf, st_fn);
> -    }
> +    fn(dest, mask, base, stride, tcg_env, desc);
>
>      finalize_rvv_inst(s);
>      return true;
> @@ -1152,6 +898,16 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t=
 rs1, uint32_t rs2,
>  static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>  {
>      uint32_t data =3D 0;
> +    gen_helper_ldst_stride *fn;
> +    static gen_helper_ldst_stride * const fns[4] =3D {
> +        gen_helper_vlse8_v, gen_helper_vlse16_v,
> +        gen_helper_vlse32_v, gen_helper_vlse64_v
> +    };
> +
> +    fn =3D fns[eew];
> +    if (fn =3D=3D NULL) {
> +        return false;
> +    }
>
>      uint8_t emul =3D vext_get_emul(s, eew);
>      data =3D FIELD_DP32(data, VDATA, VM, a->vm);
> @@ -1159,7 +915,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm =
*a, uint8_t eew)
>      data =3D FIELD_DP32(data, VDATA, NF, a->nf);
>      data =3D FIELD_DP32(data, VDATA, VTA, s->vta);
>      data =3D FIELD_DP32(data, VDATA, VMA, s->vma);
> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, true);
> +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>  }
>
>  static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> @@ -1177,13 +933,23 @@ GEN_VEXT_TRANS(vlse64_v, MO_64, rnfvm, ld_stride_o=
p, ld_stride_check)
>  static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>  {
>      uint32_t data =3D 0;
> +    gen_helper_ldst_stride *fn;
> +    static gen_helper_ldst_stride * const fns[4] =3D {
> +        /* masked stride store */
> +        gen_helper_vsse8_v,  gen_helper_vsse16_v,
> +        gen_helper_vsse32_v,  gen_helper_vsse64_v
> +    };
>
>      uint8_t emul =3D vext_get_emul(s, eew);
>      data =3D FIELD_DP32(data, VDATA, VM, a->vm);
>      data =3D FIELD_DP32(data, VDATA, LMUL, emul);
>      data =3D FIELD_DP32(data, VDATA, NF, a->nf);
> +    fn =3D fns[eew];
> +    if (fn =3D=3D NULL) {
> +        return false;
> +    }
>
> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, false);
> +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>  }
>
>  static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> @@ -1534,6 +1300,17 @@ GEN_LDST_WHOLE_TRANS(vs8r_v, int8_t, 8, false)
>   *** Vector Integer Arithmetic Instructions
>   */
>
> +/*
> + * MAXSZ returns the maximum vector size can be operated in bytes,
> + * which is used in GVEC IR when vl_eq_vlmax flag is set to true
> + * to accelerate vector operation.
> + */
> +static inline uint32_t MAXSZ(DisasContext *s)
> +{
> +    int max_sz =3D s->cfg_ptr->vlenb * 8;
> +    return max_sz >> (3 - s->lmul);
> +}
> +
>  static bool opivv_check(DisasContext *s, arg_rmrr *a)
>  {
>      return require_rvv(s) &&
> --
> 2.50.0
>
>

