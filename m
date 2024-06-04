Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3CDC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEHqq-0003dj-DD; Mon, 03 Jun 2024 20:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEHqo-0003dS-8g
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 20:16:30 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEHqk-00040v-IS
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 20:16:28 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-80ad976d6a2so1056970241.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717460185; x=1718064985; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HnZlTCKJKZqKbb9soXINNh9krqQWQzw4zxVEKS0dKw=;
 b=AnHVXFQCoTG5sZzYbVPRz7e+TWpYtnWie1OqOA/IAvVZewGh6d9PlxzNNtHZR7u48y
 np7x41+IE//qB6ATKbFmaFJTTlXUt6EceeIzNMnOneK1kAixQ06iY9sOM5pvbkPSq8Cy
 VUOoserN8FzwpSRZQryOMtLk+ev+EGyUZXNaoWwj+ggQTBnUSmW6Go/FCitnj6yVp/Rb
 AmouqULpfm6uwYNdiw22BNu2ZGLtFbH4Mk3g8VuIxh1WF9J1WmVvFE8LiAtsPwFoVxzU
 t73R/kFiCYhyQgJweu66VbGRlcyor9cmpFnQvy2a7UcLdA1gC26AoCF+wp6S6KEOM6oc
 gAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717460185; x=1718064985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HnZlTCKJKZqKbb9soXINNh9krqQWQzw4zxVEKS0dKw=;
 b=UZuuQaI0p4oI6U1UrJqmRLun/5HfB8fjFoxg1idLTozgiSZt31ytFWrDwzEWuo8UHQ
 thcCYIGjAAgYJmaHiUM/okmQpTUGpagcvNGXEKPOlF6sS89S/elYV2OQ9rdruDpBR1dJ
 Zx0R6qrlYKCXsUG8I+uNH7BKIJ01J8c7cidwkiY9Ih7Kfevv3eaZVD+8HbdluSEKftzO
 azu1ktvRsalAU9GD0bHLKptz98HuCAjrbD7sy4sJwDc/k63evbeEmETHF06Cxo0+DQKn
 3K1qd5ZWi/F8ILD8B/wDqe6BaPZZFriKrWgV8eAvz7Hh6Yym6LaZnP7lzyNOiY3cFuwQ
 O2lQ==
X-Gm-Message-State: AOJu0YyEaoZ7yKT7cKQdSqccGnkpMivh71uWoEX7Y6/EJeTbVZOCK1cn
 YjFBQGUKucCib40Vynkgj07+U85P4BPq37zjzbGtFsOON27NQC9OQFrz9kw+i5ahFduVGqptnU/
 ptOk/uGlZf2MW5Z+2D7kZntTOwUroUQ==
X-Google-Smtp-Source: AGHT+IGaKc5i0UjOjF9BlV6gjLMid018KnEW5qDynDeaRGGrpISgtV2+4raXsgz/jv9UQhbNga0iwU3TjbpNOPvnrYA=
X-Received: by 2002:a05:6102:80f:b0:47e:8c40:497c with SMTP id
 ada2fe7eead31-48bc2551894mr8387264137.34.1717460184182; Mon, 03 Jun 2024
 17:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-22-richard.henderson@linaro.org>
In-Reply-To: <20240412073346.458116-22-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:15:57 +1000
Message-ID: <CAKmqyKMOhorQoKJ9tuqkM=GQiiNbENRfJVuhzjCy+yzuikLF1A@mail.gmail.com>
Subject: Re: [PATCH v3 21/27] disas/riscv: Use GString in format_inst
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Fri, Apr 12, 2024 at 5:37=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Allocate and fill a GString instead of snprintf and
> appending to a fixed sized buffer.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 209 ++++++++++++++++++++++----------------------------
>  1 file changed, 92 insertions(+), 117 deletions(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index e236c8b5b7..f60f9bda43 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4757,272 +4757,249 @@ static size_t inst_length(rv_inst inst)
>
>  /* format instruction */
>
> -static void append(char *s1, const char *s2, size_t n)
> -{
> -    size_t l1 =3D strlen(s1);
> -    if (n - l1 - 1 > 0) {
> -        strncat(s1, s2, n - l1);
> -    }
> -}
> -
> -static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode =
*dec)
> +static GString *format_inst(size_t tab, rv_decode *dec)
>  {
>      const rv_opcode_data *opcode_data =3D dec->opcode_data;
> -    char tmp[64];
> +    GString *buf =3D g_string_sized_new(64);
>      const char *fmt;
>
>      fmt =3D opcode_data[dec->op].format;
>      while (*fmt) {
>          switch (*fmt) {
>          case 'O':
> -            append(buf, opcode_data[dec->op].name, buflen);
> +            g_string_append(buf, opcode_data[dec->op].name);
>              break;
>          case '(':
> -            append(buf, "(", buflen);
> -            break;
>          case ',':
> -            append(buf, ",", buflen);
> -            break;
>          case ')':
> -            append(buf, ")", buflen);
> -            break;
>          case '-':
> -            append(buf, "-", buflen);
> +            g_string_append_c(buf, *fmt);
>              break;
>          case 'b':
> -            snprintf(tmp, sizeof(tmp), "%d", dec->bs);
> -            append(buf, tmp, buflen);
> +            g_string_append_printf(buf, "%d", dec->bs);
>              break;
>          case 'n':
> -            snprintf(tmp, sizeof(tmp), "%d", dec->rnum);
> -            append(buf, tmp, buflen);
> +            g_string_append_printf(buf, "%d", dec->rnum);
>              break;
>          case '0':
> -            append(buf, rv_ireg_name_sym[dec->rd], buflen);
> +            g_string_append(buf, rv_ireg_name_sym[dec->rd]);
>              break;
>          case '1':
> -            append(buf, rv_ireg_name_sym[dec->rs1], buflen);
> +            g_string_append(buf, rv_ireg_name_sym[dec->rs1]);
>              break;
>          case '2':
> -            append(buf, rv_ireg_name_sym[dec->rs2], buflen);
> +            g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
>              break;
>          case '3':
> -            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rd] =
:
> -                                              rv_freg_name_sym[dec->rd],
> -                   buflen);
> +            if (dec->cfg->ext_zfinx) {
> +                g_string_append(buf, rv_ireg_name_sym[dec->rd]);
> +            } else {
> +                g_string_append(buf, rv_freg_name_sym[dec->rd]);
> +            }
>              break;
>          case '4':
> -            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rs1]=
 :
> -                                              rv_freg_name_sym[dec->rs1]=
,
> -                   buflen);
> +            if (dec->cfg->ext_zfinx) {
> +                g_string_append(buf, rv_ireg_name_sym[dec->rs1]);
> +            } else {
> +                g_string_append(buf, rv_freg_name_sym[dec->rs1]);
> +            }
>              break;
>          case '5':
> -            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rs2]=
 :
> -                                              rv_freg_name_sym[dec->rs2]=
,
> -                   buflen);
> +            if (dec->cfg->ext_zfinx) {
> +                g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
> +            } else {
> +                g_string_append(buf, rv_freg_name_sym[dec->rs2]);
> +            }
>              break;
>          case '6':
> -            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rs3]=
 :
> -                                              rv_freg_name_sym[dec->rs3]=
,
> -                   buflen);
> +            if (dec->cfg->ext_zfinx) {
> +                g_string_append(buf, rv_ireg_name_sym[dec->rs3]);
> +            } else {
> +                g_string_append(buf, rv_freg_name_sym[dec->rs3]);
> +            }
>              break;
>          case '7':
> -            snprintf(tmp, sizeof(tmp), "%d", dec->rs1);
> -            append(buf, tmp, buflen);
> +            g_string_append_printf(buf, "%d", dec->rs1);
>              break;
>          case 'i':
> -            snprintf(tmp, sizeof(tmp), "%d", dec->imm);
> -            append(buf, tmp, buflen);
> +            g_string_append_printf(buf, "%d", dec->imm);
>              break;
>          case 'u':
> -            snprintf(tmp, sizeof(tmp), "%u", ((uint32_t)dec->imm & 0b111=
111));
> -            append(buf, tmp, buflen);
> +            g_string_append_printf(buf, "%u", ((uint32_t)dec->imm & 0b11=
1111));
>              break;
>          case 'j':
> -            snprintf(tmp, sizeof(tmp), "%d", dec->imm1);
> -            append(buf, tmp, buflen);
> +            g_string_append_printf(buf, "%d", dec->imm1);
>              break;
>          case 'o':
> -            snprintf(tmp, sizeof(tmp), "%d", dec->imm);
> -            append(buf, tmp, buflen);
> -            while (strlen(buf) < tab * 2) {
> -                append(buf, " ", buflen);
> +            g_string_append_printf(buf, "%d", dec->imm);
> +            while (buf->len < tab * 2) {
> +                g_string_append_c(buf, ' ');
>              }
> -            snprintf(tmp, sizeof(tmp), "# 0x%" PRIx64,
> -                dec->pc + dec->imm);
> -            append(buf, tmp, buflen);
> +            g_string_append_printf(buf, "# 0x%" PRIx64, dec->pc + dec->i=
mm);
>              break;
>          case 'U':
>              fmt++;
> -            snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
> -            append(buf, tmp, buflen);
> +            g_string_append_printf(buf, "%d", dec->imm >> 12);
>              if (*fmt =3D=3D 'o') {
> -                while (strlen(buf) < tab * 2) {
> -                    append(buf, " ", buflen);
> +                while (buf->len < tab * 2) {
> +                    g_string_append_c(buf, ' ');
>                  }
> -                snprintf(tmp, sizeof(tmp), "# 0x%" PRIx64,
> -                    dec->pc + dec->imm);
> -                append(buf, tmp, buflen);
> +                g_string_append_printf(buf, "# 0x%" PRIx64, dec->pc + de=
c->imm);
>              }
>              break;
>          case 'c': {
>              const char *name =3D csr_name(dec->imm & 0xfff);
>              if (name) {
> -                append(buf, name, buflen);
> +                g_string_append(buf, name);
>              } else {
> -                snprintf(tmp, sizeof(tmp), "0x%03x", dec->imm & 0xfff);
> -                append(buf, tmp, buflen);
> +                g_string_append_printf(buf, "0x%03x", dec->imm & 0xfff);
>              }
>              break;
>          }
>          case 'r':
>              switch (dec->rm) {
>              case rv_rm_rne:
> -                append(buf, "rne", buflen);
> +                g_string_append(buf, "rne");
>                  break;
>              case rv_rm_rtz:
> -                append(buf, "rtz", buflen);
> +                g_string_append(buf, "rtz");
>                  break;
>              case rv_rm_rdn:
> -                append(buf, "rdn", buflen);
> +                g_string_append(buf, "rdn");
>                  break;
>              case rv_rm_rup:
> -                append(buf, "rup", buflen);
> +                g_string_append(buf, "rup");
>                  break;
>              case rv_rm_rmm:
> -                append(buf, "rmm", buflen);
> +                g_string_append(buf, "rmm");
>                  break;
>              case rv_rm_dyn:
> -                append(buf, "dyn", buflen);
> +                g_string_append(buf, "dyn");
>                  break;
>              default:
> -                append(buf, "inv", buflen);
> +                g_string_append(buf, "inv");
>                  break;
>              }
>              break;
>          case 'p':
>              if (dec->pred & rv_fence_i) {
> -                append(buf, "i", buflen);
> +                g_string_append_c(buf, 'i');
>              }
>              if (dec->pred & rv_fence_o) {
> -                append(buf, "o", buflen);
> +                g_string_append_c(buf, 'o');
>              }
>              if (dec->pred & rv_fence_r) {
> -                append(buf, "r", buflen);
> +                g_string_append_c(buf, 'r');
>              }
>              if (dec->pred & rv_fence_w) {
> -                append(buf, "w", buflen);
> +                g_string_append_c(buf, 'w');
>              }
>              break;
>          case 's':
>              if (dec->succ & rv_fence_i) {
> -                append(buf, "i", buflen);
> +                g_string_append_c(buf, 'i');
>              }
>              if (dec->succ & rv_fence_o) {
> -                append(buf, "o", buflen);
> +                g_string_append_c(buf, 'o');
>              }
>              if (dec->succ & rv_fence_r) {
> -                append(buf, "r", buflen);
> +                g_string_append_c(buf, 'r');
>              }
>              if (dec->succ & rv_fence_w) {
> -                append(buf, "w", buflen);
> +                g_string_append_c(buf, 'w');
>              }
>              break;
>          case '\t':
> -            while (strlen(buf) < tab) {
> -                append(buf, " ", buflen);
> +            while (buf->len < tab) {
> +                g_string_append_c(buf, ' ');
>              }
>              break;
>          case 'A':
>              if (dec->aq) {
> -                append(buf, ".aq", buflen);
> +                g_string_append(buf, ".aq");
>              }
>              break;
>          case 'R':
>              if (dec->rl) {
> -                append(buf, ".rl", buflen);
> +                g_string_append(buf, ".rl");
>              }
>              break;
>          case 'l':
> -            append(buf, ",v0", buflen);
> +            g_string_append(buf, ",v0");
>              break;
>          case 'm':
>              if (dec->vm =3D=3D 0) {
> -                append(buf, ",v0.t", buflen);
> +                g_string_append(buf, ",v0.t");
>              }
>              break;
>          case 'D':
> -            append(buf, rv_vreg_name_sym[dec->rd], buflen);
> +            g_string_append(buf, rv_vreg_name_sym[dec->rd]);
>              break;
>          case 'E':
> -            append(buf, rv_vreg_name_sym[dec->rs1], buflen);
> +            g_string_append(buf, rv_vreg_name_sym[dec->rs1]);
>              break;
>          case 'F':
> -            append(buf, rv_vreg_name_sym[dec->rs2], buflen);
> +            g_string_append(buf, rv_vreg_name_sym[dec->rs2]);
>              break;
>          case 'G':
> -            append(buf, rv_vreg_name_sym[dec->rs3], buflen);
> +            g_string_append(buf, rv_vreg_name_sym[dec->rs3]);
>              break;
>          case 'v': {
> -            char nbuf[32] =3D {0};
>              const int sew =3D 1 << (((dec->vzimm >> 3) & 0b111) + 3);
> -            sprintf(nbuf, "%d", sew);
>              const int lmul =3D dec->vzimm & 0b11;
>              const int flmul =3D (dec->vzimm >> 2) & 1;
>              const char *vta =3D (dec->vzimm >> 6) & 1 ? "ta" : "tu";
>              const char *vma =3D (dec->vzimm >> 7) & 1 ? "ma" : "mu";
> -            append(buf, "e", buflen);
> -            append(buf, nbuf, buflen);
> -            append(buf, ",m", buflen);
> +
> +            g_string_append_printf(buf, "e%d,m", sew);
>              if (flmul) {
>                  switch (lmul) {
>                  case 3:
> -                    sprintf(nbuf, "f2");
> +                    g_string_append(buf, "f2");
>                      break;
>                  case 2:
> -                    sprintf(nbuf, "f4");
> +                    g_string_append(buf, "f4");
>                      break;
>                  case 1:
> -                    sprintf(nbuf, "f8");
> -                break;
> +                    g_string_append(buf, "f8");
> +                    break;
>                  }
> -                append(buf, nbuf, buflen);
>              } else {
> -                sprintf(nbuf, "%d", 1 << lmul);
> -                append(buf, nbuf, buflen);
> +                g_string_append_printf(buf, "%d", 1 << lmul);
>              }
> -            append(buf, ",", buflen);
> -            append(buf, vta, buflen);
> -            append(buf, ",", buflen);
> -            append(buf, vma, buflen);
> +            g_string_append_c(buf, ',');
> +            g_string_append(buf, vta);
> +            g_string_append_c(buf, ',');
> +            g_string_append(buf, vma);
>              break;
>          }
>          case 'x': {
>              switch (dec->rlist) {
>              case 4:
> -                snprintf(tmp, sizeof(tmp), "{ra}");
> +                g_string_append(buf, "{ra}");
>                  break;
>              case 5:
> -                snprintf(tmp, sizeof(tmp), "{ra, s0}");
> +                g_string_append(buf, "{ra, s0}");
>                  break;
>              case 15:
> -                snprintf(tmp, sizeof(tmp), "{ra, s0-s11}");
> +                g_string_append(buf, "{ra, s0-s11}");
>                  break;
>              default:
> -                snprintf(tmp, sizeof(tmp), "{ra, s0-s%d}", dec->rlist - =
5);
> +                g_string_append_printf(buf, "{ra, s0-s%d}", dec->rlist -=
 5);
>                  break;
>              }
> -            append(buf, tmp, buflen);
>              break;
>          }
>          case 'h':
> -            append(buf, rv_fli_name_const[dec->imm], buflen);
> +            g_string_append(buf, rv_fli_name_const[dec->imm]);
>              break;
>          default:
>              break;
>          }
>          fmt++;
>      }
> +
> +    return buf;
>  }
>
>  /* lift instruction to pseudo-instruction */
> @@ -5108,9 +5085,8 @@ static void decode_inst_decompress(rv_decode *dec, =
rv_isa isa)
>
>  /* disassemble instruction */
>
> -static void
> -disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst i=
nst,
> -            RISCVCPUConfig *cfg)
> +static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
> +                            RISCVCPUConfig *cfg)
>  {
>      rv_decode dec =3D { 0 };
>      dec.pc =3D pc;
> @@ -5157,7 +5133,7 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, u=
int64_t pc, rv_inst inst,
>      decode_inst_operands(&dec, isa);
>      decode_inst_decompress(&dec, isa);
>      decode_inst_lift_pseudo(&dec);
> -    format_inst(buf, buflen, 24, &dec);
> +    return format_inst(24, &dec);
>  }
>
>  #define INST_FMT_2 "%04" PRIx64 "              "
> @@ -5168,7 +5144,6 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, u=
int64_t pc, rv_inst inst,
>  static int
>  print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa =
isa)
>  {
> -    char buf[128] =3D { 0 };
>      bfd_byte packet[2];
>      rv_inst inst =3D 0;
>      size_t len =3D 2;
> @@ -5209,9 +5184,9 @@ print_insn_riscv(bfd_vma memaddr, struct disassembl=
e_info *info, rv_isa isa)
>          }
>      }
>
> -    disasm_inst(buf, sizeof(buf), isa, memaddr, inst,
> -                (RISCVCPUConfig *)info->target_info);
> -    (*info->fprintf_func)(info->stream, "%s", buf);
> +    g_autoptr(GString) str =3D
> +        disasm_inst(isa, memaddr, inst, (RISCVCPUConfig *)info->target_i=
nfo);
> +    (*info->fprintf_func)(info->stream, "%s", str->str);
>
>      return len;
>  }
> --
> 2.34.1
>
>

