Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AADC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipEx-0000sh-9o; Tue, 27 Aug 2024 01:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sipEv-0000ql-RB; Tue, 27 Aug 2024 01:59:37 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sipEu-0001Cd-5D; Tue, 27 Aug 2024 01:59:37 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4fd0d7fe6f6so1717879e0c.2; 
 Mon, 26 Aug 2024 22:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724738375; x=1725343175; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXCkxLr9/9NnUcoiWzoqm0HizMtuIeDZE5+QzeDQZPk=;
 b=atGpFKOo1sDMMe2BtFq84S7dU6TgDg1fyBOWCdW4MnHaDFrgIYzLfw7SVtWz0DkYWK
 /8+ykNIJC5RU2E4N818bdQkc+zYQqA20i/GhF322JXhcQ3rlguYRu3897UxNsb+0vOWz
 vFgDWG59Tv86FhFEjBrq+10G/eAxflGxZQYxTQMXN1BUIZA4XyN1ulbPBwKyce/7G5Vt
 gcUDwK/qTcnmV1FVwVl0oEBrAzSjkonyKQs127W+QxTN7dof7mRIBCy1K35jd1tZfikJ
 KCwPKL6THga/fgEzu+bIUBLuCardhyKU/ycYK/K8XJGvd/rCO79uhU4YUdvn+5kU0atZ
 Nkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724738375; x=1725343175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXCkxLr9/9NnUcoiWzoqm0HizMtuIeDZE5+QzeDQZPk=;
 b=jfqYfwm5Dusa9ZjG2kHk20jGdX2rLXJw7zshGC+S8X6b+PdjR5TAYm0EehojUP56X+
 DDen3WScbpaVlE8jDxqU1fZF9m1JwLX+wzVZc1toeP9t9B6cND3VuC31zplatxSZfrwA
 /flPurvMQw7Be5PY467dKVaMoiBOtQxptBT1G6G7EcVDIXRHe9x6cvjtoeh5ePMSgK5X
 N6Zm338TqF+F5Feq9Ii6bHc636m3bf9qA1PBQ1N5s52QiK6uMsTXI4p1VgQ458pcBOM0
 bcToMNRd/Qin0ee40q2ZMxnhDDivRJNy37WKkWNF4RJ4syv2Z4bBQJ/HbyhWQdSaNVWF
 FY1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhZ+Xmlv6Ox6S18F/pZLFoVJE0YvsTiHh2dHZCcDGdgsH7cvptIRgsypDdU76mDqL53QhcVH57xZLS@nongnu.org
X-Gm-Message-State: AOJu0YxniWuslPMcMQ9mKugHoNdejFt2ipQ8xTliSuVp0zRE4A3u1kb2
 qpGE86z7uhP0PROnqytkAodjM/9Hqx5ZAFowH+xAotknSN2BrqbAKv70g4k/HAda3+0vz6aBDQi
 Mr97dhL3JxqTIQ9wXRjY/GvOIkhU=
X-Google-Smtp-Source: AGHT+IGt5CcIaJSEDN9HIZIyaSEi4+E2MHiT9DXz3FvagA2KqguuA4m2id4VydxyGaz2t75iPUsKU7mIHwUrR4++UmA=
X-Received: by 2002:a05:6122:3c4e:b0:4f5:254e:e111 with SMTP id
 71dfb90a1353d-4fed5d57e6amr2664756e0c.7.1724738374559; Mon, 26 Aug 2024
 22:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-12-debug@rivosinc.com>
In-Reply-To: <20240826152949.294506-12-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 15:59:08 +1000
Message-ID: <CAKmqyKOQcUBjz0PsaYFWnir=FCNA_+7CkrN=5PLH+ayxU+zLkg@mail.gmail.com>
Subject: Re: [PATCH v9 11/17] target/riscv: mmu changes for zicfiss shadow
 stack protection
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, richard.henderson@linaro.org, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Tue, Aug 27, 2024 at 1:31=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> zicfiss protects shadow stack using new page table encodings PTE.W=3D0,
> PTE.R=3D0 and PTE.X=3D0. This encoding is reserved if zicfiss is not

Shouldn't this be R=3D0, W=3D1, and X=3D0 ?

Alistair

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
> index ca6d8f1f39..b10c3a35c4 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -892,6 +892,8 @@ static int get_physical_address(CPURISCVState *env, h=
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
> @@ -1100,21 +1102,36 @@ restart:
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
> @@ -1159,7 +1176,7 @@ restart:
>
>      if (!((prot >> access_type) & 1)) {
>          /* Access check failed */
> -        return TRANSLATE_FAIL;
> +        return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
>      }
>
>      target_ulong updated_pte =3D pte;
> @@ -1346,9 +1363,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, v=
addr addr,
>          break;
>      case MMU_DATA_LOAD:
>          cs->exception_index =3D RISCV_EXCP_LOAD_ADDR_MIS;
> +        /* shadow stack mis aligned accesses are access faults */
> +        if (mmu_idx & MMU_IDX_SS_WRITE) {
> +            cs->exception_index =3D RISCV_EXCP_LOAD_ACCESS_FAULT;
> +        }
>          break;
>      case MMU_DATA_STORE:
>          cs->exception_index =3D RISCV_EXCP_STORE_AMO_ADDR_MIS;
> +        /* shadow stack mis aligned accesses are access faults */
> +        if (mmu_idx & MMU_IDX_SS_WRITE) {
> +            cs->exception_index =3D RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +        }
>          break;
>      default:
>          g_assert_not_reached();
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 0ac17bc5ad..ddbdee885b 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -30,12 +30,15 @@
>   *  - U+2STAGE          0b100
>   *  - S+2STAGE          0b101
>   *  - S+SUM+2STAGE      0b110
> + *  - Shadow stack+U   0b1000
> + *  - Shadow stack+S   0b1001
>   */
>  #define MMUIdx_U            0
>  #define MMUIdx_S            1
>  #define MMUIdx_S_SUM        2
>  #define MMUIdx_M            3
>  #define MMU_2STAGE_BIT      (1 << 2)
> +#define MMU_IDX_SS_WRITE    (1 << 3)
>
>  static inline int mmuidx_priv(int mmu_idx)
>  {
> --
> 2.44.0
>
>

