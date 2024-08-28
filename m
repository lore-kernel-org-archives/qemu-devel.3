Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75358C7114C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 23:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjS7N-0000sG-4T; Wed, 28 Aug 2024 19:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjS7H-0000pG-UE; Wed, 28 Aug 2024 19:30:19 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjS7F-0001Kf-Fy; Wed, 28 Aug 2024 19:30:18 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-8430670f247so34669241.0; 
 Wed, 28 Aug 2024 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724887816; x=1725492616; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSbm3AM7ZBzne0KdAI8833fiOZgTrlkPXA8Kb2mEqVM=;
 b=Oj7uF6VN36OrGVZXybrfX/P7cA5ATCUdtYh81s2/z+46DV+KjXqnKF2iv7MABa7dSe
 TVs4LeEi5DWjbtEMWe/LVBskA7+8/o0rs1wRGsY8ZUcgMmrn0ltRKnPKXUtzj/eRGD4x
 D48pCgjdae8gmrt4l6OhmmsicltqCgjHPk0qskQQdFLKOUBrV8pt61xN0GCnsAw5IE3n
 acHciXShwUDRjlkhSc0kieLPzeEHO1eCt23OC6OCzHLYK1IXG3shby23aY5eV6lRKVBE
 rAJN/34MV9c4z8reprSJ+x8OocnWSZ8hy+oJTfXpqAXiAuKjf9TdJg4np18IHlgUIGS4
 Sdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724887816; x=1725492616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GSbm3AM7ZBzne0KdAI8833fiOZgTrlkPXA8Kb2mEqVM=;
 b=PcQG3dh+j3gzK4gUj3xtbC5CQT5R4L8VTYPMCEQvBqe/9sJ2MyYDvfPSXFUzKr5G2e
 SSqtdVcfCNfIqmD0bj7UrbGnw0oVe49Os5kARNtkMgCZAy5pKN8D7B46aBg+bd3lLD2g
 yBzz5cZA5wmT3UJGmI+JG8d3593BwlID3Ur8CgFK+gO3FmgMichjix3QlJR6Sc2l/sIn
 t3ja9l6JYJdHao4OGs1T0AF3IhRqN2DJJrfcbBJz1TuWALRzQ+KIFvb41+ZClRoR/BuO
 3L6AAUJmblyOSBZZvZSG2+nGb4d12NRI98A3QI4fzAMDMtP0EgQo5Jo6TIsqDGcvvLBC
 PeTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn0gzmYN/nfxuq89igte4xKn7TDdOGfzLGmdKGoqyiIMwzwfTFwGwJk2VRCcsNbofxjxNQTyFK0K3c@nongnu.org
X-Gm-Message-State: AOJu0YzvqPyEpLDpxkKFugk1W3BSWpMWbNYFhyz2rOE5aJh2ybXzhu61
 5C3O/6KkmJHK4lGtlFIGrPtZ8hczhu4heNNRSn9t4oiab2oLGUtUPmO7D4YkEiH3kwffiJ3UNQr
 vr3PUJBXqMqIJfkGvs9Vdaxv8M2g=
X-Google-Smtp-Source: AGHT+IGHfxson81nNRUOdLqkR87A7fIeCgcAZm4IEyqm7J0s+fFPM1n20noZ6S2NE/5Ypx8UP88utnh4G4dMRaczY7w=
X-Received: by 2002:a05:6122:a25:b0:4fd:15c8:ef03 with SMTP id
 71dfb90a1353d-4ffe4b9eea1mr1178291e0c.4.1724887815829; Wed, 28 Aug 2024
 16:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-14-debug@rivosinc.com>
In-Reply-To: <20240828174739.714313-14-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 09:29:49 +1000
Message-ID: <CAKmqyKPyyupykqc-0yrGm+msZPuf+=jVWvD86yz7mfqjn5MT9A@mail.gmail.com>
Subject: Re: [PATCH v11 13/20] target/riscv: mmu changes for zicfiss shadow
 stack protection
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Thu, Aug 29, 2024 at 3:49=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> zicfiss protects shadow stack using new page table encodings PTE.W=3D1,
> PTE.R=3D0 and PTE.X=3D0. This encoding is reserved if zicfiss is not
> implemented or if shadow stack are not enabled.
> Loads on shadow stack memory are allowed while stores to shadow stack
> memory leads to access faults. Shadow stack accesses to RO memory
> leads to store page fault.
>
> To implement special nature of shadow stack memory where only selected
> stores (shadow stack stores from sspush) have to be allowed while rest
> of regular stores disallowed, new MMU TLB index is created for shadow
> stack.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/cpu_helper.c | 37 +++++++++++++++++++++++++++++++------
>  target/riscv/internals.h  |  3 +++
>  2 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index be4ac3d54e..39544cade6 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -893,6 +893,8 @@ static int get_physical_address(CPURISCVState *env, h=
waddr *physical,
>      hwaddr ppn;
>      int napot_bits =3D 0;
>      target_ulong napot_mask;
> +    bool is_sstack_idx =3D ((mmu_idx & MMU_IDX_SS_WRITE) =3D=3D MMU_IDX_=
SS_WRITE);
> +    bool sstack_page =3D false;
>
>      /*
>       * Check if we should use the background registers for the two
> @@ -1101,21 +1103,36 @@ restart:
>          return TRANSLATE_FAIL;
>      }
>
> +    target_ulong rwx =3D pte & (PTE_R | PTE_W | PTE_X);
>      /* Check for reserved combinations of RWX flags. */
> -    switch (pte & (PTE_R | PTE_W | PTE_X)) {
> -    case PTE_W:
> +    switch (rwx) {
>      case PTE_W | PTE_X:
>          return TRANSLATE_FAIL;
> +    case PTE_W:
> +        /* if bcfi enabled, PTE_W is not reserved and shadow stack page =
*/
> +        if (cpu_get_bcfien(env) && first_stage) {
> +            sstack_page =3D true;
> +            /* if ss index, read and write allowed. else only read allow=
ed */
> +            rwx =3D is_sstack_idx ? PTE_R | PTE_W : PTE_R;
> +            break;
> +        }
> +        return TRANSLATE_FAIL;
> +    case PTE_R:
> +        /* shadow stack writes to readonly memory are page faults */
> +        if (is_sstack_idx && access_type =3D=3D MMU_DATA_STORE) {
> +            return TRANSLATE_FAIL;
> +        }
> +        break;
>      }
>
>      int prot =3D 0;
> -    if (pte & PTE_R) {
> +    if (rwx & PTE_R) {
>          prot |=3D PAGE_READ;
>      }
> -    if (pte & PTE_W) {
> +    if (rwx & PTE_W) {
>          prot |=3D PAGE_WRITE;
>      }
> -    if (pte & PTE_X) {
> +    if (rwx & PTE_X) {
>          bool mxr =3D false;
>
>          /*
> @@ -1160,7 +1177,7 @@ restart:
>
>      if (!((prot >> access_type) & 1)) {
>          /* Access check failed */
> -        return TRANSLATE_FAIL;
> +        return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;

Why is it a PMP error if it's a shadow stack page?

Alistair

