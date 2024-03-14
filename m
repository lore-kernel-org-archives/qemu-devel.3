Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2603C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 02:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkapb-0001al-2R; Wed, 13 Mar 2024 22:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1rkapZ-0001aO-Mh
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 22:28:29 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1rkapU-0005NM-BA
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 22:28:29 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513cfd48224so281247e87.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 19:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710383302; x=1710988102; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/b+khNJEi49ePDotxFv03YXRyNImE+Jwwhb6Mm8O5aQ=;
 b=QTuS/ecda2JrJDUmIbfbULJyDFiTPrXkVnI4MzY0Peug5Uh7WUfwPpq6Cidnt353gO
 xDMqKDWq46KRd+y8Z/zYv05e1JnVZZ81c0gl9rDC6u8jznQ8viTeqtdbvhuHm6fwdWiU
 0j4pqpY3tFz5611dW15kRmcZxQFPpG5K0nzIcjxMmQg+8JbB0PuV/2zyjsuryA0ljFUy
 9xjcbPG7U/8yPKN9CRRuhdiQQ+BwkFcPmAQ02squgLv8s8Txnr/u1nPC9Z7zeuqW8QRT
 cr9ntMgEeawXa5l2JYtFuv1m1Ibebeh1WZpVbLvHtMMOoOq8naBSIIPNgKIg81RRFODG
 wFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710383302; x=1710988102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/b+khNJEi49ePDotxFv03YXRyNImE+Jwwhb6Mm8O5aQ=;
 b=xLHW/zxfLajfV3PTF5NoyX97ljn+FJh00K6xd/exeLRhYQyv6ElnuVZKcWkyeqzKi5
 zJ1rTnxkU/zHxm3Y55kvHPGjBa1GY1rO4K4b91qu0YTm3C1gQPwKGkmAuSYn5XTF7Ndj
 z8f8evAZC6EDVX92HdyLT5FeaJ0sHowuaFJDXFlXL5X5ue62r8NT1nRyfRWiJ8JPjkZU
 pt9MHs0BoOl9uxkQ4cGe4P682N86eqwM9/qIl+Kj9yoAMXxH8rzrQXRF2BJgWuAx2xbt
 i2tqvNIu8B2TdnthY4frxM3+ynW1NkSUGMssi97hXudc+Sk1tblUxYGMGt7uotQrzfr4
 Opcg==
X-Gm-Message-State: AOJu0Yw9XPV/0fX/QX5cA/4iUkJlqWASXKenmKSaL6BvM1BjIfDb/cMl
 DbDqs/jwJgTBDjpMcHMQd6HRs0/8Ha0A+Wyw6g7YTnkg2RPeHo0bIdk7oEc1/JrBgss1f7skixM
 0+sffKN3jt4Dqv52iWfadjF/k8HiPYO1JSA+zO79J
X-Google-Smtp-Source: AGHT+IEVu2ZFG0O0xzs6ByNjce8A9PfuE2kdtbmXxGRF3MUOTG/51bVMimGuCKMX6m4gx/IT5wE3HOYrS8wWYrgWKZ4=
X-Received: by 2002:a05:6512:28c:b0:513:baec:b18b with SMTP id
 j12-20020a056512028c00b00513baecb18bmr184513lfp.28.1710383301368; Wed, 13 Mar
 2024 19:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1710379781.git.lixianglai@loongson.cn>
 <0e940b2aee9a5c29bb41d6a9611955482d250325.1710379781.git.lixianglai@loongson.cn>
In-Reply-To: <0e940b2aee9a5c29bb41d6a9611955482d250325.1710379781.git.lixianglai@loongson.cn>
From: chen huacai <zltjiangshi@gmail.com>
Date: Thu, 14 Mar 2024 10:28:12 +0800
Message-ID: <CABDp7VqrVua8T7LRf8mNsQFXae9TwKVA7Viq10-363aQrHkvMw@mail.gmail.com>
Subject: Re: [PATCH V4 1/1] target/loongarch: Fixed tlb huge page loading issue
To: Xianglai Li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn,
 yijun@loongson.cn, wuruiyang@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi, Xianglai,

Generally, the subject should be "Fix tlb huge page loading issue"
rather than "Fixed tlb huge page loading issue".

On Thu, Mar 14, 2024 at 9:34=E2=80=AFAM Xianglai Li <lixianglai@loongson.cn=
> wrote:
>
> When we use qemu tcg simulation, the page size of bios is 4KB.
> When using the level 2 super large page (page size is 1G) to create the p=
age table,
> it is found that the content of the corresponding address space is abnorm=
al,
> resulting in the bios can not start the operating system and graphical in=
terface normally.
>
> The lddir and ldpte instruction emulation has
> a problem with the use of super large page processing above level 2.
> The page size is not correctly calculated,
> resulting in the wrong page size of the table entry found by tlb.
>
> Cc: maobibo@loongson.cn
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: zhaotianrui@loongson.cn
> Cc: yijun@loongson.cn
> Cc: wuruiyang@loongson.cn
>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
>  target/loongarch/cpu-csr.h        |   3 +
>  target/loongarch/internals.h      |   5 --
>  target/loongarch/tcg/tlb_helper.c | 105 ++++++++++++++++++++----------
>  3 files changed, 74 insertions(+), 39 deletions(-)
>
> Changes log:
> V3->V4:
> Optimize the huge page calculation method,
> use the FIELD macro for bit calculation.
>
> V2->V3:
> Delete the intermediate variable LDDIR_PS, and implement lddir and ldpte
> huge pages by referring to the latest architecture reference manual.
>
> V1->V2:
> Modified the patch title format and Enrich the commit mesg description
>
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index c59d7a9fcb..b0775cf6bf 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -67,6 +67,9 @@ FIELD(TLBENTRY, D, 1, 1)
>  FIELD(TLBENTRY, PLV, 2, 2)
>  FIELD(TLBENTRY, MAT, 4, 2)
>  FIELD(TLBENTRY, G, 6, 1)
> +FIELD(TLBENTRY, HUGE, 6, 1)
> +FIELD(TLBENTRY, HG, 12, 1)
> +FIELD(TLBENTRY, LEVEL, 13, 2)
>  FIELD(TLBENTRY_32, PPN, 8, 24)
>  FIELD(TLBENTRY_64, PPN, 12, 36)
>  FIELD(TLBENTRY_64, NR, 61, 1)
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index a2fc54c8a7..944153b180 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -16,11 +16,6 @@
>  #define TARGET_PHYS_MASK MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS)
>  #define TARGET_VIRT_MASK MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS)
>
> -/* Global bit used for lddir/ldpte */
> -#define LOONGARCH_PAGE_HUGE_SHIFT   6
> -/* Global bit for huge page */
> -#define LOONGARCH_HGLOBAL_SHIFT     12
> -
>  void loongarch_translate_init(void);
>
>  void loongarch_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb=
_helper.c
> index 22be031ac7..b9a8633791 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -17,6 +17,34 @@
>  #include "exec/log.h"
>  #include "cpu-csr.h"
>
> +static void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_bas=
e,
> +                               uint64_t *dir_width, target_ulong level)
> +{
> +    switch (level) {
> +    case 1:
> +        *dir_base =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
> +        *dir_width =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
> +        break;
> +    case 2:
> +        *dir_base =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
> +        *dir_width =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
> +        break;
> +    case 3:
> +        *dir_base =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
> +        *dir_width =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
> +        break;
> +    case 4:
> +        *dir_base =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
> +        *dir_width =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
> +        break;
> +    default:
> +        /* level may be zero for ldpte */
> +        *dir_base =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
> +        *dir_width =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
> +        break;
> +    }
> +}
> +
>  static void raise_mmu_exception(CPULoongArchState *env, target_ulong add=
ress,
>                                  MMUAccessType access_type, int tlb_error=
)
>  {
> @@ -485,7 +513,23 @@ target_ulong helper_lddir(CPULoongArchState *env, ta=
rget_ulong base,
>      target_ulong badvaddr, index, phys, ret;
>      int shift;
>      uint64_t dir_base, dir_width;
> -    bool huge =3D (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
> +
> +    if (unlikely((level =3D=3D 0) || (level > 4))) {
> +        return base;
> +    }
> +
> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
> +        if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
> +            return base;
> +        } else {
> +            return  FIELD_DP64(base, TLBENTRY, LEVEL, level);
> +        }
> +
> +        if (unlikely(level =3D=3D 4)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Attempted use of level %lu huge page\n", leve=
l);
> +        }
> +    }
>
>      badvaddr =3D env->CSR_TLBRBADV;
>      base =3D base & TARGET_PHYS_MASK;
> @@ -494,33 +538,12 @@ target_ulong helper_lddir(CPULoongArchState *env, t=
arget_ulong base,
>      shift =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
>      shift =3D (shift + 1) * 3;
>
> -    if (huge) {
> -        return base;
> -    }
> -    switch (level) {
> -    case 1:
> -        dir_base =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
> -        dir_width =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
> -        break;
> -    case 2:
> -        dir_base =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
> -        dir_width =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
> -        break;
> -    case 3:
> -        dir_base =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
> -        dir_width =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
> -        break;
> -    case 4:
> -        dir_base =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
> -        dir_width =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
> -        break;
> -    default:
> -        do_raise_exception(env, EXCCODE_INE, GETPC());
> -        return 0;
> -    }
> +    get_dir_base_width(env, &dir_base, &dir_width, level);
> +
>      index =3D (badvaddr >> dir_base) & ((1 << dir_width) - 1);
>      phys =3D base | index << shift;
>      ret =3D ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
> +
>      return ret;
>  }
>
> @@ -530,20 +553,34 @@ void helper_ldpte(CPULoongArchState *env, target_ul=
ong base, target_ulong odd,
>      CPUState *cs =3D env_cpu(env);
>      target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, ps, badv;
>      int shift;
> -    bool huge =3D (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
>      uint64_t ptbase =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
>      uint64_t ptwidth =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
> +    uint64_t dir_base, dir_width;
>
>      base =3D base & TARGET_PHYS_MASK;
> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
> +        /*
> +         * Gets the huge page level and Gets huge page size
> +         * Clears the huge page level information in the address
> +         * Clears huge page bit
> +         */
> +        get_dir_base_width(env, &dir_base, &dir_width,
> +                           FIELD_EX64(base, TLBENTRY, LEVEL));
> +
> +        FIELD_DP64(base, TLBENTRY, LEVEL, 0);
> +        FIELD_DP64(base, TLBENTRY, HUGE, 0);
> +        if (FIELD_EX64(base, TLBENTRY, HG)) {
> +            FIELD_DP64(base, TLBENTRY, HG, 0);
> +            FIELD_DP64(base, TLBENTRY, G, 1);
> +        }
>
> -    if (huge) {
> -        /* Huge Page. base is paddr */
> -        tmp0 =3D base ^ (1 << LOONGARCH_PAGE_HUGE_SHIFT);
> -        /* Move Global bit */
> -        tmp0 =3D ((tmp0 & (1 << LOONGARCH_HGLOBAL_SHIFT))  >>
> -                LOONGARCH_HGLOBAL_SHIFT) << R_TLBENTRY_G_SHIFT |
> -                (tmp0 & (~(1 << LOONGARCH_HGLOBAL_SHIFT)));
> -        ps =3D ptbase + ptwidth - 1;
> +        /*
> +         * Huge pages are evenly split into parity pages
> +         * when loaded into the tlb,
> +         * so the tlb page size needs to be divided by 2.
> +         */
> +        ps =3D dir_base + dir_width - 1;
> +        tmp0 =3D base;
>          if (odd) {
>              tmp0 +=3D MAKE_64BIT_MASK(ps, 1);
>          }
> --
> 2.39.1
>
>


--=20
Huacai Chen

