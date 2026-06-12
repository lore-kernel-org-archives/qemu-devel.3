Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31370CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXwki-0003cD-86; Fri, 12 Jun 2026 03:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wXwkf-0003Yp-5N
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:56:29 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wXwkd-0005dV-28
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:56:28 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bec450b950dso92585566b.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1781250985; x=1781855785; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3DrFaGSZKbNXW4A1RFDqCT6Sm0R+Ztztc5wQVzZLhOY=;
 b=e1fyIRkzNR77J32Qnw4XsiykMlwt2Sq93p9J890L2Rfm7F8FGC6LWa6cs6JGpnCTb+
 emlHDyYN6BcJmbxB+FmWPZdO5X2+QwvzM5tv3Am8/9DghIWA8JbOvEcWOEQmSwiE8a2t
 iehVSbgJBdJPHNL6gYUDrtNWKBtZqRpTGbFONWygOvsabLSmFy622XB0zUXbqGZJJVwd
 CbcdOf3RLIa5gW69nEOEKBRMO7rJdC6n/Ik8SlzepYOd8/OLkOuR+3UdVuRWqJYmADpm
 0Ey549Cnt3slWJudB0eiJC2skwtZ8PjQ2mpKstiokJeBM50m4/XyHRI2+0GpRWR73L7g
 nNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781250985; x=1781855785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DrFaGSZKbNXW4A1RFDqCT6Sm0R+Ztztc5wQVzZLhOY=;
 b=sIJ7aSX2vYn+etk2d39z1AV+5h/caawfsSNlbXEcuPzu9FugnOjwIIdkzbdum9I7yL
 HY8YwkDsD/hb70yN+y4pDhHPKkXiZXWHPrINaJTd991IeBZF+K0Z9RPG2HeU4E629UHv
 TPw3Yjv5RiMRWGzhBbYntz4JxqE8FAP3p85Am4RqVVNzO4pNuS2z5zOQnVCI3ToY9Kt/
 ptwo+hBuZS1djjG4NakLSCf4gs91TOjrdEXhulksteW7kZoCF5VeeC0oHwae0Blb/zxN
 csuWeBroIfqd+R4L8akCUn2z8fjz+eH0C6iL8t3F5cfQeSYMeJMOSl+3TLA1chzD5A8u
 Qm3g==
X-Gm-Message-State: AOJu0YyZqpdZ/Q47yt3dIig4WQ7wUsPCOooFZvODlpYDMzCr96SozkLZ
 byocpOU7AqTyncxKQccncRrCaocIK/QOyblrR3AfobtmD/L8czUMZj0D+6EicZFqWKkJx4uAEI8
 pek8auNkhz05FIfe4sdVkcYiT9zPndohgqUXoUX18ONqnSXbmb8WnOQeYyCRk+nLI7ms6yzu6lB
 nPTW/SqM241sqAR2SOrrmUoGzu+B1//iID/W9Ju+Z7xd4=
X-Gm-Gg: Acq92OHn19jSxaHe6hW+kZOiYr28gkhbwqH+7Y+XC72KDiwtabcfvUlC+Krp1gy3ewT
 7ko0oM97Vdja+H9Htcs3zhasknaMfbSphYgcHrW8ruwhkQ1idYbX8PpXRbU9Xnor31JeL1xieaY
 +DnmL9hfSs4WzJKtcj6OpCja/Om+NRHYEbygRW5pd6/A3yf7SdBg3xnPwYrczKLlBf7XJ3pCDvw
 YXnyGXenQ45gASmdfucRlGmhFjDGmZXTEymPay3Rng3D7jdI+6zojSslnefcbcscus8YYDaoSz/
 +P3BJPVt2P2BHJA7JOnJ6yRyhb2nRYe8VLzqbcWkmpMmXJ5rVP+EK3z2giwVszvaW+0UI/ezRO/
 6LP2ksY7BJWi1vSwRtzHCs/K78bcv3jTZ1sESmLScltYyoBlImUcE7rvugedAB2SblIAsSNxcuZ
 hZnL0heDmJ86sk7eNwdhkTgjSvLRKZRvhVl9xjo2OeQFm4FYgXwn+KyBNSqFKq
X-Received: by 2002:a17:907:9725:b0:bec:d077:c4dd with SMTP id
 a640c23a62f3a-bfe28f178b4mr79639966b.32.1781250985357; 
 Fri, 12 Jun 2026 00:56:25 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com.
 [209.85.208.47]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb4d1b856sm71220466b.20.2026.06.12.00.56.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 00:56:24 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-68d233bf083so1010629a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 00:56:24 -0700 (PDT)
X-Received: by 2002:a05:6402:528e:b0:68d:4e6:7187 with SMTP id
 4fb4d7f45d1cf-69378a45e9fmr678632a12.23.1781250983948; Fri, 12 Jun 2026
 00:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260318185238.99143-1-luisccunha8@gmail.com>
 <20260318185238.99143-5-luisccunha8@gmail.com>
In-Reply-To: <20260318185238.99143-5-luisccunha8@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Fri, 12 Jun 2026 15:56:12 +0800
X-Gmail-Original-Message-ID: <CAMXXpfa6E6evwjdpe62pdoWwednaoV_JiFqhzwygWEP9Pq2S2w@mail.gmail.com>
X-Gm-Features: AVVi8Cc_fxKReAfiFbIMHZs_tHKnoP8WH92nNFdYIQIs8eOpWyiI6SgNqcn81Ic
Message-ID: <CAMXXpfa6E6evwjdpe62pdoWwednaoV_JiFqhzwygWEP9Pq2S2w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] target/riscv: Implement extension for Optimizing
 Context Switching (Sspmpen)
To: luisccc <luisccunha8@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="000000000000278726065409d058"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000278726065409d058
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jay Chang <jay,chang@sifive.com>

Thanks

On Thu, Mar 19, 2026 at 3:45=E2=80=AFAM luisccc <luisccunha8@gmail.com> wro=
te:

> Signed-off-by: Luis Cunha <luisccunha8@gmail.com>
> ---
>  target/riscv/cpu_bits.h           |  4 ++
>  target/riscv/cpu_cfg_fields.h.inc |  1 +
>  target/riscv/csr.c                | 67 +++++++++++++++++++++++++++++++
>  target/riscv/spmp.c               |  6 ++-
>  4 files changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 36f7c1e873..0a8cfedc5d 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -255,6 +255,10 @@
>  #define CSR_SCTRSTATUS      0x14f
>  #define CSR_SCTRDEPTH       0x15f
>
> +/* S-mode Physical Memory Protection (SPMP) */
> +#define CSR_SPMPEN          0x183
> +#define CSR_SPMPENH         0x193
> +
>  /* VS-Level Control transfer records CSRs */
>  #define CSR_VSCTRCTL        0x24e
>
> diff --git a/target/riscv/cpu_cfg_fields.h.inc
> b/target/riscv/cpu_cfg_fields.h.inc
> index 772cc176d0..88edac21ca 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -120,6 +120,7 @@ BOOL_FIELD(rvv_ma_all_1s)
>  BOOL_FIELD(rvv_vl_half_avl)
>  BOOL_FIELD(rvv_vsetvl_x0_vill)
>  BOOL_FIELD(ext_smpmpdeleg)
> +BOOL_FIELD(ext_sspmpen)
>  /* Named features  */
>  BOOL_FIELD(ext_svade)
>  BOOL_FIELD(ext_zic64b)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 4b9fa11540..a11d7e6704 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -769,6 +769,16 @@ static RISCVException spmp(CPURISCVState *env, int
> csrno)
>      return smode(env, csrno);
>  }
>
> +static RISCVException sspmpen(CPURISCVState *env, int csrno)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_sspmpen) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    /* SSPMPEN can only exist, if spmp exists */
> +    return spmp(env, csrno);
> +}
> +
>  static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>  {
>      if (riscv_cpu_cfg(env)->ext_smepmp) {
> @@ -5389,6 +5399,61 @@ static RISCVException rmw_mpmpdeleg(CPURISCVState
> *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException rmw_spmpen64(CPURISCVState *env, int csrno,
> +                                    uint64_t *ret_val,
> +                                    uint64_t new_val, uint64_t wr_mask)
> +{
> +    uint64_t new_spmpen =3D (env->spmp_state.spmpen & ~wr_mask) |
> +                            (new_val & wr_mask);
> +
> +    if (env->spmp_state.num_deleg_rules =3D=3D 0) {
> +        if (ret_val) {
> +            *ret_val =3D 0;
> +        }
> +
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    if (ret_val) {
> +        *ret_val =3D env->spmp_state.spmpen;
> +    }
> +
> +    sspmpen_csr_write(env, new_spmpen);
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_spmpen(CPURISCVState *env, int csrno,
> +                                  target_ulong *ret_val,
> +                                  target_ulong new_val, target_ulong
> wr_mask)
> +{
> +    uint64_t rval =3D 0;
> +    RISCVException ret;
> +    ret =3D rmw_spmpen64(env, csrno, &rval, new_val, wr_mask);
> +    if (ret_val) {
> +        *ret_val =3D rval;
> +    }
> +
> +    return ret;
> +}
> +
> +static RISCVException rmw_spmpenh(CPURISCVState *env, int csrno,
> +                                   target_ulong *ret_val,
> +                                   target_ulong new_val,
> +                                   target_ulong wr_mask)
> +{
> +    uint64_t rval =3D 0;
> +    RISCVException ret;
> +
> +    ret =3D rmw_spmpen64(env, csrno, &rval,
> +        ((uint64_t)new_val) << 32, ((uint64_t)wr_mask) << 32);
> +    if (ret_val) {
> +        *ret_val =3D rval >> 32;
> +    }
> +
> +    return ret;
> +}
> +
>  static RISCVException read_tselect(CPURISCVState *env, int csrno,
>                                     target_ulong *val)
>  {
> @@ -6388,6 +6453,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>
>      /* S-mode Physical Memory Protection */
>      [CSR_MPMPDELEG]   =3D { "mpmpdeleg", spmp, NULL, NULL, rmw_mpmpdeleg=
 },
> +    [CSR_SPMPEN]  =3D { "spmpen", sspmpen, NULL, NULL, rmw_spmpen },
> +    [CSR_SPMPENH] =3D { "spmpenh", sspmpen, NULL, NULL, rmw_spmpenh },
>
>      /* Debug CSRs */
>      [CSR_TSELECT]   =3D  { "tselect",  debug, read_tselect,  write_tsele=
ct
> },
> diff --git a/target/riscv/spmp.c b/target/riscv/spmp.c
> index 85c5259b33..1615c207df 100644
> --- a/target/riscv/spmp.c
> +++ b/target/riscv/spmp.c
> @@ -147,7 +147,11 @@ static uint8_t spmp_is_in_range(CPURISCVState *env,
> int spmp_index,
>
>  static bool spmp_get_spmpen_bit(CPURISCVState *env, int index)
>  {
> -    return true;
> +    if (!riscv_cpu_cfg(env)->ext_sspmpen) {
> +        return true;
> +    }
> +
> +    return (env->spmp_state.spmpen >> index) & 0x1;
>  }
>
>  /*
> --
> 2.43.0
>
>
>

--000000000000278726065409d058
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-il">Reviewed-by</span>: Jay Chang &lt=
;jay,<a href=3D"mailto:chang@sifive.com">chang@sifive.com</a>&gt;<br><br>Th=
anks</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Thu, Mar 19, 2026 at 3:45=E2=80=AFAM luisccc &=
lt;<a href=3D"mailto:luisccunha8@gmail.com">luisccunha8@gmail.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off=
-by: Luis Cunha &lt;<a href=3D"mailto:luisccunha8@gmail.com" target=3D"_bla=
nk">luisccunha8@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 ++<br>
=C2=A0target/riscv/cpu_cfg_fields.h.inc |=C2=A0 1 +<br>
=C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 67 +++++++++++++++++++++++++++++++<br>
=C2=A0target/riscv/spmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 6 ++-<br>
=C2=A04 files changed, 77 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h<br>
index 36f7c1e873..0a8cfedc5d 100644<br>
--- a/target/riscv/cpu_bits.h<br>
+++ b/target/riscv/cpu_bits.h<br>
@@ -255,6 +255,10 @@<br>
=C2=A0#define CSR_SCTRSTATUS=C2=A0 =C2=A0 =C2=A0 0x14f<br>
=C2=A0#define CSR_SCTRDEPTH=C2=A0 =C2=A0 =C2=A0 =C2=A00x15f<br>
<br>
+/* S-mode Physical Memory Protection (SPMP) */<br>
+#define CSR_SPMPEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x183<br>
+#define CSR_SPMPENH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x193<br>
+<br>
=C2=A0/* VS-Level Control transfer records CSRs */<br>
=C2=A0#define CSR_VSCTRCTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x24e<br>
<br>
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc<br>
index 772cc176d0..88edac21ca 100644<br>
--- a/target/riscv/cpu_cfg_fields.h.inc<br>
+++ b/target/riscv/cpu_cfg_fields.h.inc<br>
@@ -120,6 +120,7 @@ BOOL_FIELD(rvv_ma_all_1s)<br>
=C2=A0BOOL_FIELD(rvv_vl_half_avl)<br>
=C2=A0BOOL_FIELD(rvv_vsetvl_x0_vill)<br>
=C2=A0BOOL_FIELD(ext_smpmpdeleg)<br>
+BOOL_FIELD(ext_sspmpen)<br>
=C2=A0/* Named features=C2=A0 */<br>
=C2=A0BOOL_FIELD(ext_svade)<br>
=C2=A0BOOL_FIELD(ext_zic64b)<br>
diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
index 4b9fa11540..a11d7e6704 100644<br>
--- a/target/riscv/csr.c<br>
+++ b/target/riscv/csr.c<br>
@@ -769,6 +769,16 @@ static RISCVException spmp(CPURISCVState *env, int csr=
no)<br>
=C2=A0 =C2=A0 =C2=A0return smode(env, csrno);<br>
=C2=A0}<br>
<br>
+static RISCVException sspmpen(CPURISCVState *env, int csrno)<br>
+{<br>
+=C2=A0 =C2=A0 if (!riscv_cpu_cfg(env)-&gt;ext_sspmpen) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* SSPMPEN can only exist, if spmp exists */<br>
+=C2=A0 =C2=A0 return spmp(env, csrno);<br>
+}<br>
+<br>
=C2=A0static RISCVException have_mseccfg(CPURISCVState *env, int csrno)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (riscv_cpu_cfg(env)-&gt;ext_smepmp) {<br>
@@ -5389,6 +5399,61 @@ static RISCVException rmw_mpmpdeleg(CPURISCVState *e=
nv, int csrno,<br>
=C2=A0 =C2=A0 =C2=A0return RISCV_EXCP_NONE;<br>
=C2=A0}<br>
<br>
+static RISCVException rmw_spmpen64(CPURISCVState *env, int csrno,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *ret_val,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t new_val, uint=
64_t wr_mask)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t new_spmpen =3D (env-&gt;spmp_state.spmpen &amp; ~wr=
_mask) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (new_val &amp; wr_mask);<br>
+<br>
+=C2=A0 =C2=A0 if (env-&gt;spmp_state.num_deleg_rules =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret_val) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ret_val =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ret_val) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *ret_val =3D env-&gt;spmp_state.spmpen;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 sspmpen_csr_write(env, new_spmpen);<br>
+<br>
+=C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>
+}<br>
+<br>
+static RISCVException rmw_spmpen(CPURISCVState *env, int csrno,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong *ret_val,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong new_val, target_=
ulong wr_mask)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t rval =3D 0;<br>
+=C2=A0 =C2=A0 RISCVException ret;<br>
+=C2=A0 =C2=A0 ret =3D rmw_spmpen64(env, csrno, &amp;rval, new_val, wr_mask=
);<br>
+=C2=A0 =C2=A0 if (ret_val) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *ret_val =3D rval;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+static RISCVException rmw_spmpenh(CPURISCVState *env, int csrno,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong *ret_val,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong new_val,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong wr_mask)<b=
r>
+{<br>
+=C2=A0 =C2=A0 uint64_t rval =3D 0;<br>
+=C2=A0 =C2=A0 RISCVException ret;<br>
+<br>
+=C2=A0 =C2=A0 ret =3D rmw_spmpen64(env, csrno, &amp;rval,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((uint64_t)new_val) &lt;&lt; 32, ((uint64_t)wr=
_mask) &lt;&lt; 32);<br>
+=C2=A0 =C2=A0 if (ret_val) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *ret_val =3D rval &gt;&gt; 32;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0static RISCVException read_tselect(CPURISCVState *env, int csrno,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong *val)<br>
=C2=A0{<br>
@@ -6388,6 +6453,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0/* S-mode Physical Memory Protection */<br>
=C2=A0 =C2=A0 =C2=A0[CSR_MPMPDELEG]=C2=A0 =C2=A0=3D { &quot;mpmpdeleg&quot;=
, spmp, NULL, NULL, rmw_mpmpdeleg },<br>
+=C2=A0 =C2=A0 [CSR_SPMPEN]=C2=A0 =3D { &quot;spmpen&quot;, sspmpen, NULL, =
NULL, rmw_spmpen },<br>
+=C2=A0 =C2=A0 [CSR_SPMPENH] =3D { &quot;spmpenh&quot;, sspmpen, NULL, NULL=
, rmw_spmpenh },<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Debug CSRs */<br>
=C2=A0 =C2=A0 =C2=A0[CSR_TSELECT]=C2=A0 =C2=A0=3D=C2=A0 { &quot;tselect&quo=
t;,=C2=A0 debug, read_tselect,=C2=A0 write_tselect=C2=A0 },<br>
diff --git a/target/riscv/spmp.c b/target/riscv/spmp.c<br>
index 85c5259b33..1615c207df 100644<br>
--- a/target/riscv/spmp.c<br>
+++ b/target/riscv/spmp.c<br>
@@ -147,7 +147,11 @@ static uint8_t spmp_is_in_range(CPURISCVState *env, in=
t spmp_index,<br>
<br>
=C2=A0static bool spmp_get_spmpen_bit(CPURISCVState *env, int index)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 if (!riscv_cpu_cfg(env)-&gt;ext_sspmpen) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return (env-&gt;spmp_state.spmpen &gt;&gt; index) &amp; 0x1;=
<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--000000000000278726065409d058--

