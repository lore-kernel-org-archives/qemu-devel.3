Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA83C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 04:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmnp7-000330-Jr; Wed, 20 Mar 2024 00:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rmnoo-000315-55; Wed, 20 Mar 2024 00:44:55 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rmnoj-0006Wd-Rp; Wed, 20 Mar 2024 00:44:49 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7e09ba2ac02so481505241.1; 
 Tue, 19 Mar 2024 21:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710909884; x=1711514684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGpmq1iOzGD/8ZU8Ie79khdW76DBVm4qzdcB2SjfX9w=;
 b=izcmfaSNPjQpTfpMtv5P+xucouRlHCTq20eRS4XxcfN4powVTJwCTwr8I9Oah5pgNu
 5RYwrMbq5zrmKw3brf6r89sImaWrbmDbEnmFGDhFCv420k4YK0MribezusFgyGbkIys7
 z5KZ5SE40OZXUU8zeZSb4xsKYva0aBjM1A1RrPnaPRhV8sZ7cxEc/UDTfXiuncjTtw3f
 oQzmWBY0LeI7MHxlAf7Fftwh923wLsFEoi/zQ7IJ0xibUXJJYsSRkc+K66gASXIyHMP7
 C9Wq3UEeOezUjCPyOrkfYUUwaTuVOQWWvbUo9fTYh5MJ0HfUgonY1IqvVBO76WGjHKT1
 0b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710909884; x=1711514684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rGpmq1iOzGD/8ZU8Ie79khdW76DBVm4qzdcB2SjfX9w=;
 b=U+xqTE/0Ym5oqwLvcXPlHmz1Jte5At6wlSEoC+dcBpkoKPsZIfh+b34xytac/cIZQm
 nXbHglbZl/B8pW5PKUTf1ZO1/ZR8HzHNL3ZHrMYx+pecHa3QA6GZL5Xqi1AlGb1HsbDh
 Sh6MZkknCOxm+jfkQ0dtorOvJUrH76gLw03x6C1BZxgd7zZFDbhe5WGh+RiXHquiUBLr
 GedPIid73CjyGezWUefF0TcFrVl4HamhNgm5BKfGp2gTBeioL5x+UyxDNNEhyw4ubKeM
 gSKDz+YcHF/DluuOOPls7QdCy4+hhyfzDnZT2iVnxNFPie3OHwmxhYJVRDBrnSh5I11v
 VfDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE75hJKjQbNnOOTndpWqir7rc0sYo0OaQDvQqeZyf9PVP0X2pw+uzJFtu8K4EeOZ0dnoTenr9cIJhu10EmTil1YjSpIJw=
X-Gm-Message-State: AOJu0YyE4O766e0ped9XbFZ3gCCGDp0gTpPWsIRbFX8jUWRcfOlfR+BP
 9zAM9cIy5FkB7Zkboffo4/cHqMVS1etJbygGWRedmmqVv3X7Df5Cu2xad9dBsYBH6BRsFJl+XJQ
 j8wcfoKpQpE6PjInLxkwMdlruAJs=
X-Google-Smtp-Source: AGHT+IEGjzWHSpqk2QqKRZHUUSAqmGRZnAMrKw9kGxBQ5GuTGaYyo5kJ5qdlyZ/TtnHUd3XxbbF5YL3nCX6TMfQkdiI=
X-Received: by 2002:a67:e34d:0:b0:476:af2b:2845 with SMTP id
 s13-20020a67e34d000000b00476af2b2845mr1221345vsm.20.1710909884073; Tue, 19
 Mar 2024 21:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-7-dbarboza@ventanamicro.com>
In-Reply-To: <20240314175704.478276-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 Mar 2024 14:44:17 +1000
Message-ID: <CAKmqyKN-UktxBUL0UU-f369a8a=rRUECTN6voeX+0fi67r1sMQ@mail.gmail.com>
Subject: Re: [PATCH for 9.0 v15 06/10] target/riscv/vector_helpers: do early
 exit when vstart >= vl
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, max.chou@sifive.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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
> We're going to make changes that will required each helper to be
> responsible for the 'vstart' management, i.e. we will relieve the
> 'vstart < vl' assumption that helpers have today.
>
> Helpers are usually able to deal with vstart >=3D vl, i.e. doing nothing
> aside from setting vstart =3D 0 at the end, but the tail update functions
> will update the tail regardless of vstart being valid or not. Unifying
> the tail update process in a single function that would handle the
> vstart >=3D vl case isn't trivial (see [1] for more info).
>
> This patch takes a blunt approach: do an early exit in every single
> vector helper if vstart >=3D vl, unless the helper is guarded with
> vstart_eq_zero in the translation. For those cases the helper is ready
> to deal with cases where vl might be zero, i.e. throwing exceptions
> based on it like vcpop_m() and first_m().
>
> Helpers that weren't changed:
>
> - vcpop_m(), vfirst_m(), vmsetm(), GEN_VEXT_VIOTA_M(): these are guarded
>   directly with vstart_eq_zero;
>
> - GEN_VEXT_VCOMPRESS_VM(): guarded with vcompress_vm_check() that checks
>   vstart_eq_zero;
>
> - GEN_VEXT_RED(): guarded with either reduction_check() or
>   reduction_widen_check(), both check vstart_eq_zero;
>
> - GEN_VEXT_FRED(): guarded with either freduction_check() or
>   freduction_widen_check(), both check vstart_eq_zero.
>
> Another exception is vext_ldst_whole(), who operates on effective vector
> length regardless of the current settings in vtype and vl.
>
> [1] https://lore.kernel.org/qemu-riscv/1590234b-0291-432a-a0fa-c5a6876097=
bc@linux.alibaba.com/
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vcrypto_helper.c   | 32 ++++++++++++++++
>  target/riscv/vector_helper.c    | 66 +++++++++++++++++++++++++++++++++
>  target/riscv/vector_internals.c |  4 ++
>  target/riscv/vector_internals.h |  9 +++++
>  4 files changed, 111 insertions(+)
>
> diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.=
c
> index e2d719b13b..f7423df226 100644
> --- a/target/riscv/vcrypto_helper.c
> +++ b/target/riscv/vcrypto_helper.c
> @@ -222,6 +222,8 @@ static inline void xor_round_key(AESState *round_stat=
e, AESState *round_key)
>          uint32_t total_elems =3D vext_get_total_elems(env, desc, 4);    =
    \
>          uint32_t vta =3D vext_vta(desc);                                =
    \
>                                                                          =
  \
> +        VSTART_CHECK_EARLY_EXIT(env);                                   =
  \
> +                                                                        =
  \
>          for (uint32_t i =3D env->vstart / 4; i < env->vl / 4; i++) {    =
    \
>              AESState round_key;                                         =
  \
>              round_key.d[0] =3D *((uint64_t *)vs2 + H8(i * 2 + 0));      =
    \
> @@ -246,6 +248,8 @@ static inline void xor_round_key(AESState *round_stat=
e, AESState *round_key)
>          uint32_t total_elems =3D vext_get_total_elems(env, desc, 4);    =
    \
>          uint32_t vta =3D vext_vta(desc);                                =
    \
>                                                                          =
  \
> +        VSTART_CHECK_EARLY_EXIT(env);                                   =
  \
> +                                                                        =
  \
>          for (uint32_t i =3D env->vstart / 4; i < env->vl / 4; i++) {    =
    \
>              AESState round_key;                                         =
  \
>              round_key.d[0] =3D *((uint64_t *)vs2 + H8(0));              =
    \
> @@ -305,6 +309,8 @@ void HELPER(vaeskf1_vi)(void *vd_vptr, void *vs2_vptr=
, uint32_t uimm,
>      uint32_t total_elems =3D vext_get_total_elems(env, desc, 4);
>      uint32_t vta =3D vext_vta(desc);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      uimm &=3D 0b1111;
>      if (uimm > 10 || uimm =3D=3D 0) {
>          uimm ^=3D 0b1000;
> @@ -351,6 +357,8 @@ void HELPER(vaeskf2_vi)(void *vd_vptr, void *vs2_vptr=
, uint32_t uimm,
>      uint32_t total_elems =3D vext_get_total_elems(env, desc, 4);
>      uint32_t vta =3D vext_vta(desc);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      uimm &=3D 0b1111;
>      if (uimm > 14 || uimm < 2) {
>          uimm ^=3D 0b1000;
> @@ -457,6 +465,8 @@ void HELPER(vsha2ms_vv)(void *vd, void *vs1, void *vs=
2, CPURISCVState *env,
>      uint32_t total_elems;
>      uint32_t vta =3D vext_vta(desc);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D env->vstart / 4; i < env->vl / 4; i++) {
>          if (sew =3D=3D MO_32) {
>              vsha2ms_e32(((uint32_t *)vd) + i * 4, ((uint32_t *)vs1) + i =
* 4,
> @@ -572,6 +582,8 @@ void HELPER(vsha2ch32_vv)(void *vd, void *vs1, void *=
vs2, CPURISCVState *env,
>      uint32_t total_elems;
>      uint32_t vta =3D vext_vta(desc);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D env->vstart / 4; i < env->vl / 4; i++) {
>          vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
>                    ((uint32_t *)vs1) + 4 * i + 2);
> @@ -590,6 +602,8 @@ void HELPER(vsha2ch64_vv)(void *vd, void *vs1, void *=
vs2, CPURISCVState *env,
>      uint32_t total_elems;
>      uint32_t vta =3D vext_vta(desc);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D env->vstart / 4; i < env->vl / 4; i++) {
>          vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
>                    ((uint64_t *)vs1) + 4 * i + 2);
> @@ -608,6 +622,8 @@ void HELPER(vsha2cl32_vv)(void *vd, void *vs1, void *=
vs2, CPURISCVState *env,
>      uint32_t total_elems;
>      uint32_t vta =3D vext_vta(desc);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D env->vstart / 4; i < env->vl / 4; i++) {
>          vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
>                    (((uint32_t *)vs1) + 4 * i));
> @@ -626,6 +642,8 @@ void HELPER(vsha2cl64_vv)(void *vd, void *vs1, void *=
vs2, CPURISCVState *env,
>      uint32_t total_elems;
>      uint32_t vta =3D vext_vta(desc);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D env->vstart / 4; i < env->vl / 4; i++) {
>          vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
>                    (((uint64_t *)vs1) + 4 * i));
> @@ -658,6 +676,8 @@ void HELPER(vsm3me_vv)(void *vd_vptr, void *vs1_vptr,=
 void *vs2_vptr,
>      uint32_t *vs1 =3D vs1_vptr;
>      uint32_t *vs2 =3D vs2_vptr;
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (int i =3D env->vstart / 8; i < env->vl / 8; i++) {
>          uint32_t w[24];
>          for (int j =3D 0; j < 8; j++) {
> @@ -757,6 +777,8 @@ void HELPER(vsm3c_vi)(void *vd_vptr, void *vs2_vptr, =
uint32_t uimm,
>      uint32_t *vs2 =3D vs2_vptr;
>      uint32_t v1[8], v2[8], v3[8];
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (int i =3D env->vstart / 8; i < env->vl / 8; i++) {
>          for (int k =3D 0; k < 8; k++) {
>              v2[k] =3D bswap32(vd[H4(i * 8 + k)]);
> @@ -780,6 +802,8 @@ void HELPER(vghsh_vv)(void *vd_vptr, void *vs1_vptr, =
void *vs2_vptr,
>      uint32_t vta =3D vext_vta(desc);
>      uint32_t total_elems =3D vext_get_total_elems(env, desc, 4);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D env->vstart / 4; i < env->vl / 4; i++) {
>          uint64_t Y[2] =3D {vd[i * 2 + 0], vd[i * 2 + 1]};
>          uint64_t H[2] =3D {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])}=
;
> @@ -817,6 +841,8 @@ void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, =
CPURISCVState *env,
>      uint32_t vta =3D vext_vta(desc);
>      uint32_t total_elems =3D vext_get_total_elems(env, desc, 4);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D env->vstart / 4; i < env->vl / 4; i++) {
>          uint64_t Y[2] =3D {brev8(vd[i * 2 + 0]), brev8(vd[i * 2 + 1])};
>          uint64_t H[2] =3D {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])}=
;
> @@ -853,6 +879,8 @@ void HELPER(vsm4k_vi)(void *vd, void *vs2, uint32_t u=
imm5, CPURISCVState *env,
>      uint32_t esz =3D sizeof(uint32_t);
>      uint32_t total_elems =3D vext_get_total_elems(env, desc, esz);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D group_start; i < group_end; ++i) {
>          uint32_t vstart =3D i * egs;
>          uint32_t vend =3D (i + 1) * egs;
> @@ -909,6 +937,8 @@ void HELPER(vsm4r_vv)(void *vd, void *vs2, CPURISCVSt=
ate *env, uint32_t desc)
>      uint32_t esz =3D sizeof(uint32_t);
>      uint32_t total_elems =3D vext_get_total_elems(env, desc, esz);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D group_start; i < group_end; ++i) {
>          uint32_t vstart =3D i * egs;
>          uint32_t vend =3D (i + 1) * egs;
> @@ -943,6 +973,8 @@ void HELPER(vsm4r_vs)(void *vd, void *vs2, CPURISCVSt=
ate *env, uint32_t desc)
>      uint32_t esz =3D sizeof(uint32_t);
>      uint32_t total_elems =3D vext_get_total_elems(env, desc, esz);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D group_start; i < group_end; ++i) {
>          uint32_t vstart =3D i * egs;
>          uint32_t vend =3D (i + 1) * egs;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 1f4c276b21..63a1083f03 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -207,6 +207,8 @@ vext_ldst_stride(void *vd, void *v0, target_ulong bas=
e,
>      uint32_t esz =3D 1 << log2_esz;
>      uint32_t vma =3D vext_vma(desc);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (i =3D env->vstart; i < env->vl; i++, env->vstart++) {
>          k =3D 0;
>          while (k < nf) {
> @@ -272,6 +274,8 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVSta=
te *env, uint32_t desc,
>      uint32_t max_elems =3D vext_max_elems(desc, log2_esz);
>      uint32_t esz =3D 1 << log2_esz;
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      /* load bytes from guest memory */
>      for (i =3D env->vstart; i < evl; i++, env->vstart++) {
>          k =3D 0;
> @@ -386,6 +390,8 @@ vext_ldst_index(void *vd, void *v0, target_ulong base=
,
>      uint32_t esz =3D 1 << log2_esz;
>      uint32_t vma =3D vext_vma(desc);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      /* load bytes from guest memory */
>      for (i =3D env->vstart; i < env->vl; i++, env->vstart++) {
>          k =3D 0;
> @@ -477,6 +483,8 @@ vext_ldff(void *vd, void *v0, target_ulong base,
>      target_ulong addr, offset, remain;
>      int mmu_index =3D riscv_env_mmu_index(env, false);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      /* probe every access */
>      for (i =3D env->vstart; i < env->vl; i++) {
>          if (!vm && !vext_elem_mask(v0, i)) {
> @@ -882,6 +890,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void=
 *vs2,   \
>      uint32_t vta =3D vext_vta(desc);                            \
>      uint32_t i;                                               \
>                                                                \
> +    VSTART_CHECK_EARLY_EXIT(env);                             \
> +                                                              \
>      for (i =3D env->vstart; i < vl; i++) {                      \
>          ETYPE s1 =3D *((ETYPE *)vs1 + H(i));                    \
>          ETYPE s2 =3D *((ETYPE *)vs2 + H(i));                    \
> @@ -914,6 +924,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1=
, void *vs2,        \
>      uint32_t vta =3D vext_vta(desc);                                    =
   \
>      uint32_t i;                                                         =
 \
>                                                                          =
 \
> +    VSTART_CHECK_EARLY_EXIT(env);                                       =
 \
> +                                                                        =
 \
>      for (i =3D env->vstart; i < vl; i++) {                              =
   \
>          ETYPE s2 =3D *((ETYPE *)vs2 + H(i));                            =
   \
>          ETYPE carry =3D vext_elem_mask(v0, i);                          =
   \
> @@ -949,6 +961,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void=
 *vs2,   \
>      uint32_t vta_all_1s =3D vext_vta_all_1s(desc);              \
>      uint32_t i;                                               \
>                                                                \
> +    VSTART_CHECK_EARLY_EXIT(env);                             \
> +                                                              \
>      for (i =3D env->vstart; i < vl; i++) {                      \
>          ETYPE s1 =3D *((ETYPE *)vs1 + H(i));                    \
>          ETYPE s2 =3D *((ETYPE *)vs2 + H(i));                    \
> @@ -987,6 +1001,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s=
1,          \
>      uint32_t vta_all_1s =3D vext_vta_all_1s(desc);                \
>      uint32_t i;                                                 \
>                                                                  \
> +    VSTART_CHECK_EARLY_EXIT(env);                               \
> +                                                                \
>      for (i =3D env->vstart; i < vl; i++) {                        \
>          ETYPE s2 =3D *((ETYPE *)vs2 + H(i));                      \
>          ETYPE carry =3D !vm && vext_elem_mask(v0, i);             \
> @@ -1083,6 +1099,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,   =
                       \
>      uint32_t vma =3D vext_vma(desc);                                    =
    \
>      uint32_t i;                                                         =
  \
>                                                                          =
  \
> +    VSTART_CHECK_EARLY_EXIT(env);                                       =
  \
> +                                                                        =
  \
>      for (i =3D env->vstart; i < vl; i++) {                              =
    \
>          if (!vm && !vext_elem_mask(v0, i)) {                            =
  \
>              /* set masked-off elements to 1s */                         =
  \
> @@ -1130,6 +1148,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong =
s1,      \
>      uint32_t vma =3D vext_vma(desc);                          \
>      uint32_t i;                                             \
>                                                              \
> +    VSTART_CHECK_EARLY_EXIT(env);                           \
> +                                                            \
>      for (i =3D env->vstart; i < vl; i++) {                    \
>          if (!vm && !vext_elem_mask(v0, i)) {                \
>              /* set masked-off elements to 1s */             \
> @@ -1192,6 +1212,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, vo=
id *vs2,   \
>      uint32_t vma =3D vext_vma(desc);                            \
>      uint32_t i;                                               \
>                                                                \
> +    VSTART_CHECK_EARLY_EXIT(env);                             \
> +                                                              \
>      for (i =3D env->vstart; i < vl; i++) {                      \
>          ETYPE s1 =3D *((ETYPE *)vs1 + H(i));                    \
>          ETYPE s2 =3D *((ETYPE *)vs2 + H(i));                    \
> @@ -1257,6 +1279,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong =
s1, void *vs2,   \
>      uint32_t vma =3D vext_vma(desc);                                  \
>      uint32_t i;                                                     \
>                                                                      \
> +    VSTART_CHECK_EARLY_EXIT(env);                                   \
> +                                                                    \
>      for (i =3D env->vstart; i < vl; i++) {                            \
>          ETYPE s2 =3D *((ETYPE *)vs2 + H(i));                          \
>          if (!vm && !vext_elem_mask(v0, i)) {                        \
> @@ -1804,6 +1828,8 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVStat=
e *env,           \
>      uint32_t vta =3D vext_vta(desc);                                   \
>      uint32_t i;                                                      \
>                                                                       \
> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
> +                                                                     \
>      for (i =3D env->vstart; i < vl; i++) {                             \
>          ETYPE s1 =3D *((ETYPE *)vs1 + H(i));                           \
>          *((ETYPE *)vd + H(i)) =3D s1;                                  \
> @@ -1828,6 +1854,8 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVSt=
ate *env,         \
>      uint32_t vta =3D vext_vta(desc);                                   \
>      uint32_t i;                                                      \
>                                                                       \
> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
> +                                                                     \
>      for (i =3D env->vstart; i < vl; i++) {                             \
>          *((ETYPE *)vd + H(i)) =3D (ETYPE)s1;                           \
>      }                                                                \
> @@ -1851,6 +1879,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, vo=
id *vs2,          \
>      uint32_t vta =3D vext_vta(desc);                                   \
>      uint32_t i;                                                      \
>                                                                       \
> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
> +                                                                     \
>      for (i =3D env->vstart; i < vl; i++) {                             \
>          ETYPE *vt =3D (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
>          *((ETYPE *)vd + H(i)) =3D *(vt + H(i));                        \
> @@ -1875,6 +1905,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong =
s1,               \
>      uint32_t vta =3D vext_vta(desc);                                   \
>      uint32_t i;                                                      \
>                                                                       \
> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
> +                                                                     \
>      for (i =3D env->vstart; i < vl; i++) {                             \
>          ETYPE s2 =3D *((ETYPE *)vs2 + H(i));                           \
>          ETYPE d =3D (!vext_elem_mask(v0, i) ? s2 :                     \
> @@ -1920,6 +1952,8 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *v=
s2,
>               uint32_t vl, uint32_t vm, int vxrm,
>               opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
>  {
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D env->vstart; i < vl; i++) {
>          if (!vm && !vext_elem_mask(v0, i)) {
>              /* set masked-off elements to 1s */
> @@ -2045,6 +2079,8 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, vo=
id *vs2,
>               uint32_t vl, uint32_t vm, int vxrm,
>               opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
>  {
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (uint32_t i =3D env->vstart; i < vl; i++) {
>          if (!vm && !vext_elem_mask(v0, i)) {
>              /* set masked-off elements to 1s */
> @@ -2842,6 +2878,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,   =
       \
>      uint32_t vma =3D vext_vma(desc);                        \
>      uint32_t i;                                           \
>                                                            \
> +    VSTART_CHECK_EARLY_EXIT(env);                         \
> +                                                          \
>      for (i =3D env->vstart; i < vl; i++) {                  \
>          if (!vm && !vext_elem_mask(v0, i)) {              \
>              /* set masked-off elements to 1s */           \
> @@ -2885,6 +2923,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, =
       \
>      uint32_t vma =3D vext_vma(desc);                        \
>      uint32_t i;                                           \
>                                                            \
> +    VSTART_CHECK_EARLY_EXIT(env);                         \
> +                                                          \
>      for (i =3D env->vstart; i < vl; i++) {                  \
>          if (!vm && !vext_elem_mask(v0, i)) {              \
>              /* set masked-off elements to 1s */           \
> @@ -3471,6 +3511,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,   =
    \
>      uint32_t vma =3D vext_vma(desc);                     \
>      uint32_t i;                                        \
>                                                         \
> +    VSTART_CHECK_EARLY_EXIT(env);                      \
> +                                                       \
>      if (vl =3D=3D 0) {                                     \
>          return;                                        \
>      }                                                  \
> @@ -3992,6 +4034,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, vo=
id *vs2,   \
>      uint32_t vma =3D vext_vma(desc);                            \
>      uint32_t i;                                               \
>                                                                \
> +    VSTART_CHECK_EARLY_EXIT(env);                             \
> +                                                              \
>      for (i =3D env->vstart; i < vl; i++) {                      \
>          ETYPE s1 =3D *((ETYPE *)vs1 + H(i));                    \
>          ETYPE s2 =3D *((ETYPE *)vs2 + H(i));                    \
> @@ -4032,6 +4076,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, =
void *vs2,       \
>      uint32_t vma =3D vext_vma(desc);                                  \
>      uint32_t i;                                                     \
>                                                                      \
> +    VSTART_CHECK_EARLY_EXIT(env);                                   \
> +                                                                    \
>      for (i =3D env->vstart; i < vl; i++) {                            \
>          ETYPE s2 =3D *((ETYPE *)vs2 + H(i));                          \
>          if (!vm && !vext_elem_mask(v0, i)) {                        \
> @@ -4225,6 +4271,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, =
void *vs2, \
>      uint32_t vta =3D vext_vta(desc);                            \
>      uint32_t i;                                               \
>                                                                \
> +    VSTART_CHECK_EARLY_EXIT(env);                             \
> +                                                              \
>      for (i =3D env->vstart; i < vl; i++) {                      \
>          ETYPE s2 =3D *((ETYPE *)vs2 + H(i));                    \
>          *((ETYPE *)vd + H(i)) =3D                               \
> @@ -4549,6 +4597,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,   =
       \
>      uint32_t i;                                           \
>      int a, b;                                             \
>                                                            \
> +    VSTART_CHECK_EARLY_EXIT(env);                         \
> +                                                          \
>      for (i =3D env->vstart; i < vl; i++) {                  \
>          a =3D vext_elem_mask(vs1, i);                       \
>          b =3D vext_elem_mask(vs2, i);                       \
> @@ -4742,6 +4792,8 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState=
 *env, uint32_t desc)  \
>      uint32_t vma =3D vext_vma(desc);                                    =
    \
>      int i;                                                              =
  \
>                                                                          =
  \
> +    VSTART_CHECK_EARLY_EXIT(env);                                       =
  \
> +                                                                        =
  \
>      for (i =3D env->vstart; i < vl; i++) {                              =
    \
>          if (!vm && !vext_elem_mask(v0, i)) {                            =
  \
>              /* set masked-off elements to 1s */                         =
  \
> @@ -4777,6 +4829,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong =
s1, void *vs2,         \
>      uint32_t vma =3D vext_vma(desc);                                    =
    \
>      target_ulong offset =3D s1, i_min, i;                               =
    \
>                                                                          =
  \
> +    VSTART_CHECK_EARLY_EXIT(env);                                       =
  \
> +                                                                        =
  \
>      i_min =3D MAX(env->vstart, offset);                                 =
    \
>      for (i =3D i_min; i < vl; i++) {                                    =
    \
>          if (!vm && !vext_elem_mask(v0, i)) {                            =
  \
> @@ -4810,6 +4864,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong =
s1, void *vs2,         \
>      uint32_t vma =3D vext_vma(desc);                                    =
    \
>      target_ulong i_max, i_min, i;                                       =
  \
>                                                                          =
  \
> +    VSTART_CHECK_EARLY_EXIT(env);                                       =
  \
> +                                                                        =
  \
>      i_min =3D MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                     =
    \
>      i_max =3D MAX(i_min, env->vstart);                                  =
    \
>      for (i =3D env->vstart; i < i_max; ++i) {                           =
    \
> @@ -4852,6 +4908,8 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0=
, uint64_t s1,           \
>      uint32_t vma =3D vext_vma(desc);                                    =
      \
>      uint32_t i;                                                         =
    \
>                                                                          =
    \
> +    VSTART_CHECK_EARLY_EXIT(env);                                       =
    \
> +                                                                        =
    \
>      for (i =3D env->vstart; i < vl; i++) {                              =
      \
>          if (!vm && !vext_elem_mask(v0, i)) {                            =
    \
>              /* set masked-off elements to 1s */                         =
    \
> @@ -4901,6 +4959,8 @@ static void vslide1down_##BITWIDTH(void *vd, void *=
v0, uint64_t s1,           \
>      uint32_t vma =3D vext_vma(desc);                                    =
        \
>      uint32_t i;                                                         =
      \
>                                                                          =
      \
> +    VSTART_CHECK_EARLY_EXIT(env);                                       =
      \
> +                                                                        =
      \
>      for (i =3D env->vstart; i < vl; i++) {                              =
        \
>          if (!vm && !vext_elem_mask(v0, i)) {                            =
      \
>              /* set masked-off elements to 1s */                         =
      \
> @@ -4976,6 +5036,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, vo=
id *vs2,               \
>      uint64_t index;                                                     =
  \
>      uint32_t i;                                                         =
  \
>                                                                          =
  \
> +    VSTART_CHECK_EARLY_EXIT(env);                                       =
  \
> +                                                                        =
  \
>      for (i =3D env->vstart; i < vl; i++) {                              =
    \
>          if (!vm && !vext_elem_mask(v0, i)) {                            =
  \
>              /* set masked-off elements to 1s */                         =
  \
> @@ -5019,6 +5081,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong =
s1, void *vs2,         \
>      uint64_t index =3D s1;                                              =
    \
>      uint32_t i;                                                         =
  \
>                                                                          =
  \
> +    VSTART_CHECK_EARLY_EXIT(env);                                       =
  \
> +                                                                        =
  \
>      for (i =3D env->vstart; i < vl; i++) {                              =
    \
>          if (!vm && !vext_elem_mask(v0, i)) {                            =
  \
>              /* set masked-off elements to 1s */                         =
  \
> @@ -5113,6 +5177,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,   =
              \
>      uint32_t vma =3D vext_vma(desc);                               \
>      uint32_t i;                                                  \
>                                                                   \
> +    VSTART_CHECK_EARLY_EXIT(env);                                \
> +                                                                 \
>      for (i =3D env->vstart; i < vl; i++) {                         \
>          if (!vm && !vext_elem_mask(v0, i)) {                     \
>              /* set masked-off elements to 1s */                  \
> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_intern=
als.c
> index 12f5964fbb..996c21eb31 100644
> --- a/target/riscv/vector_internals.c
> +++ b/target/riscv/vector_internals.c
> @@ -44,6 +44,8 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs=
2,
>      uint32_t vma =3D vext_vma(desc);
>      uint32_t i;
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (i =3D env->vstart; i < vl; i++) {
>          if (!vm && !vext_elem_mask(v0, i)) {
>              /* set masked-off elements to 1s */
> @@ -68,6 +70,8 @@ void do_vext_vx(void *vd, void *v0, target_long s1, voi=
d *vs2,
>      uint32_t vma =3D vext_vma(desc);
>      uint32_t i;
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      for (i =3D env->vstart; i < vl; i++) {
>          if (!vm && !vext_elem_mask(v0, i)) {
>              /* set masked-off elements to 1s */
> diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_intern=
als.h
> index 842765f6c1..9e1e15b575 100644
> --- a/target/riscv/vector_internals.h
> +++ b/target/riscv/vector_internals.h
> @@ -24,6 +24,13 @@
>  #include "tcg/tcg-gvec-desc.h"
>  #include "internals.h"
>
> +#define VSTART_CHECK_EARLY_EXIT(env) do { \
> +    if (env->vstart >=3D env->vl) {         \
> +        env->vstart =3D 0;                  \
> +        return;                           \
> +    }                                     \
> +} while (0)
> +
>  static inline uint32_t vext_nf(uint32_t desc)
>  {
>      return FIELD_EX32(simd_data(desc), VDATA, NF);
> @@ -151,6 +158,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,     =
  \
>      uint32_t vma =3D vext_vma(desc);                     \
>      uint32_t i;                                        \
>                                                         \
> +    VSTART_CHECK_EARLY_EXIT(env);                      \
> +                                                       \
>      for (i =3D env->vstart; i < vl; i++) {               \
>          if (!vm && !vext_elem_mask(v0, i)) {           \
>              /* set masked-off elements to 1s */        \
> --
> 2.44.0
>
>

