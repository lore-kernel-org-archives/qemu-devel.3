Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32439606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JdNYIPp8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJe3i-0007WV-Qn; Wed, 21 Oct 2026 17:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJe3b-0007W5-CB
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:41:11 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJe3Y-00045g-UO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:41:10 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so1657691a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 14:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792618867; cv=none;
 d=google.com; s=arc-20260327;
 b=DwCWJPAoW7izpwIQvhsXi6OLqqN4bhmzwyoJbMUMIj7Pi1mbDROPpvMszC0kY9k2yI
 sajV02nNRDBrUt1avdBwLzdhpJaflz+Sgx+qrNuYsiApC0/J/Y82m3zM5iHcNZZRJp3w
 0SAEGEj+1f8GItwvNjEGGoycE3H9qCcvl/OhBjwozn/8wHAo6sWD5xqb0MD0lSt0eDv6
 XVwM8awbxJ3SVEEdrF/+xtt/2wEDnXRcBlhG5vfopzfJMPYge8lrwg+6DcBZRmgGOPgb
 +rQ8lE0CAckLAgohfnATlm/8UD/UgfQbPJkKGOeYJZE2hnufj7DoGZfF0VMaf3KpqbiM
 abpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=6W0fDYW0smBDgG1Ho1Yc44ogmmxXNvJp1bB+mjCFFcw=;
 fh=AVuRSoEKBA1UJ3JYrFoZN4ddlWvf8ssCYUe/U+9zCec=;
 b=Se7TJuWbVzm+uYL9Q/giHwxvAus51xEUudLIPBwsMA8s5AbMcoaUB19o/Ne4pIwfkY
 8Y5PCTWKtR4mp8b95gXXSl9OAD6hYWfKPYtzdvVPPwAuVQnvoNTZeru7EJX+RmZvDc1U
 72/qLZcCybhhz7sIc1fmetddO6nitso8oiJ7bTk1mNTali7cFIa3zZrI8+ZJ+kVCJ6Ai
 6FdUiiuW0STsmNfHXExmtzEltzT/2Y3NQyRHlgRtghgbQ6fmFnKb2z5jTl28MOn+Bp0C
 2dwN+ov8thPN22VSG+fkUh945v6+bxPbll3n2L3Uf7UiDMTj/i+X0IHaJUOnsc0c6kFG
 zp6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792618867; x=1793223667; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6W0fDYW0smBDgG1Ho1Yc44ogmmxXNvJp1bB+mjCFFcw=;
 b=JdNYIPp8/CkETi7819yvMVlRwXpHpFZh6AFKP3+inkwSFxA3nIWpCL3e58tfhCuz4d
 9Z9y+X21fXdrfAdeDckKVdv8DYc5yJfTdLORnGBT0AeWckN1kLRcPwSPJEGJpmzc5++H
 lfCKAitGUYuh6YZw3I75bbGMXwkFJu1uO8KMgebh916ixbRzbGAQzwYKTa7lTs/EbGag
 PDYoDmmm3yHXiR0RUsQj0NXzSwfEYvRx8lkUQrDrJv7ZkHgo4OpPDY6PPIN0ClpODZgH
 /LmAxl5jbCsb7mtUvp0w/7Q6ZWtOcsOH6Ck1leOugY5lh/zI387BOkOXpVqmaN6y57zF
 K8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792618867; x=1793223667;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6W0fDYW0smBDgG1Ho1Yc44ogmmxXNvJp1bB+mjCFFcw=;
 b=H63j1cz+qTtO9OLtX7fJr7Uo9b3oNakhwG6gGlJ+tgFdDuoV9eJ6fOvQUC2TQDE8R8
 JN4rFFF3mCD9QKDsqJhDA4jXPOLuI/ksgqpcB3Zo3olCHEmGyBpKc3iAJOfGrXkJ+LIH
 tVkGxkHwQMk513MLgBKhn9I8b8sdmNHtYJBOyvxC9yruzYBj3PR7HrF6uZYSJ5SwaWNZ
 u1wCCYm8aHNy+STxM7jlxwJ4DdM5s3zPgBI7jA6dvuFdfpeZRZeknSyc1Vgkbra2Lb6D
 e+QNEYni1LgxBIMRzmxhW5ETN1l8GpZcwqfyTx4dNjX7tz0On+R4j7SChlXwi+XU7bSt
 8m2Q==
X-Gm-Message-State: AFq9FYJbLEs7ZUX9B+hmlFcVAo8iGtAS4eg0tmxy0zKdsHRmSaxBdjnL
 UKaJzL5DCIpYkU86AK1TI/ZzdqjB3pIBoE8je4JHT5CQw8Yz+EYWfdw5ELDyovZD9mBHgFQ9q6M
 ctYJ9ssY6Dh8izJrXppYSJw1QZU/JmM0=
X-Gm-Gg: AYBFou3YZEFaf7OR+0IwE0P3jpcU3HMlkiwhf9tR8M1Eum8MfP4JQeakm5qpkaFu7sw
 ut2qBVIb3KMW6eDPjk69/YnBBnQf7qaDJ1oFyPpKMiKTMpn8P3FX2Fjc41x2x2Z3e2qMVYSzd+8
 aPcy8IH1M6qG+6YHfv4clYqKCXYL/GQvkD+u+wIxQJKT2v/E2fygP7fEiMm2V3O+1jymcjqN2dq
 RLq48em/sP4gGR6A2SX/gxKZFJfgiBBxW7J+Z6yJOHlsppBIiaAx2JhekHnMsyrpJbRU7+szkJO
 8us0gHKuACdk/ZKXaJTkpsaqRtKYh0QwY9VNOqvUP2f3rTIrYQBXOXWh47PTCZ5fiOREkAUgM2Z
 fJ6aIyh+ViaQ4m5UkNCfvlb0/Oj5MSzDPOi/k
X-Received: by 2002:a05:6402:2111:b0:6ac:94cf:9f2e with SMTP id
 4fb4d7f45d1cf-6b408e825cfmr2558940a12.13.1792618866724; Wed, 21 Oct 2026
 14:41:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 22 Oct 2026 05:40:54 +0800
X-Gm-Features: AclHuK9cq6PC4Uxh-fzQq7PtdXquhIj_t7su8UVNAtaeTjG43k5mL7f2a4f6mHI
Message-ID: <CAE2XoE_4_kLo+p2k+3+JvD_pPLPjc5M9_HSX70_6ewqjg1HyEQ@mail.gmail.com>
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x536.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 5:22=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> When linking multiple targets together, we usually have conflicts with he=
lper
> names. So far, it was solved using ad-hoc renaming, but multiple people p=
ointed it
> would be better to have a general mechanism for it, so here it is.
>
> A previous series attempted that:
> https://lore.kernel.org/qemu-devel/20260930073935.712-1-luoyonggang@gmail=
.com/,
> but it was relying on (binary) symbol renaming, which is not a portable s=
olution.
> Instead, this series approaches the problem from source code directly.
> It requires more change, but it's cleaner IMHO.


Hi Pierrick
thanks, this is what I want, I was thinking of this way, just changed
too much, so I am
worried about so many changes.

I have a bad feeling that my patch has so many magic macros, your way
is decent.

Series:
Acked-by: Yonggang Luo <luoyonggang@gmail.com>


>
> Series follows these steps:
>
> First, we make sure all helpers and definition are using HELPER() macro. =
A lot
> of helpers were already defined this way, we just make sure it's exhausti=
ve.
> After that we don't have any 'helper_' left on any target code. This is a=
 big
> change touching the whole codebase, but it's a simple mechanical change. =
As long
> as it compiles and links, we know it's correct.
>
> Then, we introduce the prefix for target helpers. For this , we add a new=
 define
> (from meson) that applies to all target related code. It could later be u=
sed to
> prefix other symbols also, that's why it's not named "TCG".
>
> Finally, we cleanup the previous manual helpers prefix that were added in
> codebase.
>
> Pierrick Bouvier (26):
>   target/alpha: define and call helpers using HELPER macro
>   target/arm: define and call helpers using HELPER macro
>   target/avr: define and call helpers using HELPER macro
>   target/hppa: define and call helpers using HELPER macro
>   target/i386: define and call helpers using HELPER macro
>   target/loongarch: define and call helpers using HELPER macro
>   target/m68k: define and call helpers using HELPER macro
>   target/microblaze: define and call helpers using HELPER macro
>   target/mips: define and call helpers using HELPER macro
>   target/or1k: define and call helpers using HELPER macro
>   target/ppc: define and call helpers using HELPER macro
>   target/riscv: define and call helpers using HELPER macro
>   target/rx: define and call helpers using HELPER macro
>   target/s390x: define and call helpers using HELPER macro
>   target/sh4: define and call helpers using HELPER macro
>   target/sparc: define and call helpers using HELPER macro
>   target/tricore: define and call helpers using HELPER macro
>   tcg: introduce HELPER_INFO macro
>   tcg: prefix helpers with target base architecture
>   target/alpha: remove explicit target specific prefix
>   target/hexagon: remove explicit target specific prefix
>   target/hppa: remove explicit target specific prefix
>   target/microblaze: remove explicit target specific prefix
>   target/or1k: remove explicit target specific prefix
>   target/rx: remove explicit target specific prefix
>   target/tricore: remove explicit target specific prefix
>
>  include/exec/helper-gen-common.h        |   7 +
>  include/exec/helper-gen.h.inc           |  48 +-
>  include/exec/helper-head.h.inc          |   8 +-
>  include/exec/helper-info.c.inc          |  16 +-
>  include/exec/helper-proto-common.h      |   7 +
>  meson.build                             |   2 +
>  target/alpha/clk_helper.c               |   2 +-
>  target/alpha/fpu_helper.c               |  60 +--
>  target/alpha/helper.c                   |   6 +-
>  target/alpha/helper.h                   |   2 +-
>  target/alpha/int_helper.c               |  38 +-
>  target/alpha/sys_helper.c               |  12 +-
>  target/alpha/translate.c                |   4 +-
>  target/alpha/vax_helper.c               |  42 +-
>  target/arm/tcg/helper-a64.c             |   6 +-
>  target/arm/tcg/mve_helper.c             |  28 +-
>  target/arm/tcg/psci.c                   |   2 +-
>  target/arm/tcg/sme_helper.c             |   4 +-
>  target/arm/tcg/sve_helper.c             | 141 ++---
>  target/arm/tcg/tlb_helper.c             |   2 +-
>  target/arm/tcg/vec_helper.c             |  72 +--
>  target/arm/tcg/vec_helper64.c           |  64 +--
>  target/arm/tcg/vec_internal.h           |   5 +-
>  target/avr/helper.c                     |  12 +-
>  target/hexagon/gen_tcg.h                |   2 +-
>  target/hexagon/gen_tcg_sys.h            |   2 +-
>  target/hexagon/helper.h                 |   4 +-
>  target/hexagon/op_helper.c              |   4 +-
>  target/hexagon/translate.c              |   4 +-
>  target/hppa/fpu_helper.c                |   2 +-
>  target/hppa/helper.h                    |   6 +-
>  target/hppa/op_helper.c                 |   4 +-
>  target/hppa/sys_helper.c                |  10 +-
>  target/hppa/translate.c                 |   6 +-
>  target/i386/ops_sse.h                   | 401 +++++++-------
>  target/i386/tcg/bpt_helper.c            |   6 +-
>  target/i386/tcg/cc_helper.c             |  14 +-
>  target/i386/tcg/excp_helper.c           |   8 +-
>  target/i386/tcg/fpu_helper.c            | 182 +++----
>  target/i386/tcg/int_helper.c            |  34 +-
>  target/i386/tcg/mem_helper.c            |   4 +-
>  target/i386/tcg/misc_helper.c           |  16 +-
>  target/i386/tcg/mpx_helper.c            |  12 +-
>  target/i386/tcg/seg_helper.c            |  32 +-
>  target/i386/tcg/system/bpt_helper.c     |   6 +-
>  target/i386/tcg/system/misc_helper.c    |  32 +-
>  target/i386/tcg/system/seg_helper.c     |   4 +-
>  target/i386/tcg/system/smm_helper.c     |  12 +-
>  target/i386/tcg/system/svm_helper.c     |  16 +-
>  target/i386/tcg/user/seg_helper.c       |   4 +-
>  target/loongarch/tcg/csr_helper.c       |  22 +-
>  target/loongarch/tcg/fpu_helper.c       | 126 ++---
>  target/loongarch/tcg/iocsr_helper.c     |  16 +-
>  target/loongarch/tcg/op_helper.c        |  18 +-
>  target/loongarch/tcg/tlb_helper.c       |  26 +-
>  target/loongarch/tcg/vec_helper.c       |   4 +-
>  target/m68k/op_helper.c                 |   2 +-
>  target/microblaze/helper.h              |  10 +-
>  target/microblaze/op_helper.c           |  46 +-
>  target/microblaze/translate.c           |  10 +-
>  target/mips/tcg/dsp_helper.c            | 187 +++----
>  target/mips/tcg/exception.c             |   8 +-
>  target/mips/tcg/fpu_helper.c            | 291 +++++-----
>  target/mips/tcg/ldst_helper.c           |  18 +-
>  target/mips/tcg/lmmi_helper.c           |  98 ++--
>  target/mips/tcg/msa_helper.c            | 690 ++++++++++++------------
>  target/mips/tcg/octeon_crypto.c         | 100 ++--
>  target/mips/tcg/op_helper.c             |  34 +-
>  target/mips/tcg/system/cp0_helper.c     | 276 +++++-----
>  target/mips/tcg/system/lcsr_helper.c    |   8 +-
>  target/mips/tcg/system/special_helper.c |  12 +-
>  target/mips/tcg/system/tlb_helper.c     |  14 +-
>  target/mips/tcg/vr54xx_helper.c         |  30 +-
>  target/or1k/fpu_helper.c                |  16 +-
>  target/or1k/helper.h                    |   2 +-
>  target/or1k/interrupt_helper.c          |   2 +-
>  target/or1k/translate.c                 |   2 +-
>  target/ppc/dfp_helper.c                 |  52 +-
>  target/ppc/fpu_helper.c                 | 396 +++++++-------
>  target/ppc/int_helper.c                 | 292 +++++-----
>  target/ppc/internal.h                   |   7 +-
>  target/ppc/mem_helper.c                 |  28 +-
>  target/ppc/misc_helper.c                |  56 +-
>  target/ppc/mmu-hash64.c                 |  18 +-
>  target/ppc/mmu_helper.c                 |  70 +--
>  target/ppc/power8-pmu.c                 |  14 +-
>  target/ppc/tcg-excp_helper.c            |  56 +-
>  target/ppc/timebase_helper.c            |  54 +-
>  target/ppc/translate/vsx-impl.c.inc     |   2 +-
>  target/riscv/tcg/debug.c                |   2 +-
>  target/riscv/tcg/fpu_helper.c           | 196 +++----
>  target/riscv/tcg/op_helper.c            |  74 +--
>  target/rx/helper.h                      |  12 +-
>  target/rx/op_helper.c                   |  62 +--
>  target/rx/translate.c                   |  14 +-
>  target/s390x/tcg/mem_helper.c           |   2 +-
>  target/sh4/op_helper.c                  |  76 +--
>  target/sparc/fop_helper.c               | 106 ++--
>  target/sparc/helper.c                   |  22 +-
>  target/sparc/int64_helper.c             |   6 +-
>  target/sparc/ldst_helper.c              |  14 +-
>  target/sparc/vis_helper.c               |  94 ++--
>  target/sparc/win_helper.c               |  38 +-
>  target/tricore/fpu_helper.c             |  32 +-
>  target/tricore/helper.h                 |  14 +-
>  target/tricore/op_helper.c              | 220 ++++----
>  target/tricore/translate.c              |  14 +-
>  107 files changed, 2789 insertions(+), 2739 deletions(-)
>
> --
> 2.43.0
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

