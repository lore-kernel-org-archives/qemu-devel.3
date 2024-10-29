Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC0FD5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 04:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5dat-00060n-QR; Tue, 29 Oct 2024 00:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5daq-00060F-Kb; Tue, 29 Oct 2024 00:12:32 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5dao-0004IY-OK; Tue, 29 Oct 2024 00:12:32 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-50d564df009so1324601e0c.0; 
 Mon, 28 Oct 2024 21:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730175149; x=1730779949; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/4lfV9eBCcB4+Tm4ukK72nGZCWmMRInLqc5iC21cx0=;
 b=nK6dGlUagOQ1V5rdSfWN4LjOioa69su/qvPdAgSKqXPpoaAuOJJLm8jZB+yPyWNUaD
 62nNo9pQeEZVhUjb+oBDulfsdf01QnVeiFpfS2l+WyueMQpBB3wPa4638RzDCyPVggrC
 s6t6iDYgrXHTzDzA164U39cRHQQVv11tmNFG3DkakHZGHzrf3rlTXgx5imJhHv52hvuD
 91sn8pMqr6Qze96pdgAGonrlKSechaNDBnvjtLjOH77ycf1SiF8L0WBD2GPq0nkjyZuO
 eIrrqayNGPT7XbK8/q9+1FTwtGWB7oxqemvSFbxgQYEfDI3s1uj14mOrEZWumDjatiEy
 AepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730175149; x=1730779949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/4lfV9eBCcB4+Tm4ukK72nGZCWmMRInLqc5iC21cx0=;
 b=VGbMQVmmSQw6nWXvvjMzpnGqlLS0UgwenrHsA/M9FF1cnLeC5JaUN55wjvMeQRtS7Q
 PJkYRiekDiSbkrHEr4SYGPUajLl0P/tTWHbFE4pUfUrWmrAM3cN5CvtNKkdW7bb4JdiK
 SFPBx1VCrrwems3hq/Ta7IseZ3J1dyb7QzKeL6zGl1Wk4OtaXGKWIl29yW4idTYqCu+l
 4HWTPRcul0SQnoyqwgf6OkS/wPOI02BTLjUUdHkRcyQXEfmBVoDNxCN/C+6cmEKW+NFZ
 TP/SvFY3NimAqH9Ie7SpQafwHZFijTFcpyd3bdrqQsTfe6+4r0cWXTT8gislaaq4p9hg
 JksA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7GxHTFdNDPI2dzR6pzgYoCvP+z7r5kdoMq/KWTla7V6YhQHElS+OJ9slgf6IEmCmNenAP5PLOxExq@nongnu.org
X-Gm-Message-State: AOJu0YyUUzMRedIXhJcXTyshWt8ssIAZQ6GfgPW42sJ24ucLyRB5D0EL
 pQqHv3FnECfdhjI4DzZxQ6C4Q5X42UfZX/PR7wRZUgoRAXE853aIVs7OOT3+NeeIeOto3eLLSKj
 z4BQLs8+TwR1hFKusp7Prgxt1eHg=
X-Google-Smtp-Source: AGHT+IELqfCwfHdqCmSQol9nBUO1AMbjQFoEkWCk0yWi8kbyfq+gLm9E1DR/3aQwgddzV02jvUxDgjpaT1ssyQGwCRw=
X-Received: by 2002:a05:6122:2a41:b0:4f6:aa3e:aa4c with SMTP id
 71dfb90a1353d-51014ff7a70mr7755375e0c.3.1730175149171; Mon, 28 Oct 2024
 21:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241008225010.1861630-1-debug@rivosinc.com>
 <20241008225010.1861630-14-debug@rivosinc.com>
In-Reply-To: <20241008225010.1861630-14-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Oct 2024 14:12:02 +1000
Message-ID: <CAKmqyKPNPpoXEbzTP2WP4zO19E-ih0E8BC9N11DXbnbYX52f7w@mail.gmail.com>
Subject: Re: [PATCH v16 13/20] target/riscv: mmu changes for zicfiss shadow
 stack protection
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 kito.cheng@sifive.com, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Wed, Oct 9, 2024 at 8:54=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
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
> Furthermore, `check_zicbom_access` (`cbo.clean/flush/inval`) may probe
> shadow stack memory and must always raise store/AMO access fault because
> it has store semantics. For non-shadow stack memory even though
> `cbo.clean/flush/inval` have store semantics, it will not fault if read
> is allowed (probably to follow `clflush` on x86). Although if read is not
> allowed, eventually `probe_write` will do store page (or access) fault (i=
f
> permissions don't allow it). cbo operations on shadow stack memory must
> always raise store access fault. Thus extending `get_physical_address` to
> recieve `probe` parameter as well.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 64 ++++++++++++++++++++++++++++++---------
>  target/riscv/internals.h  |  3 ++
>  2 files changed, 53 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 93d199748e..8f7871c92b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -884,7 +884,7 @@ static int get_physical_address(CPURISCVState *env, h=
waddr *physical,
>                                  target_ulong *fault_pte_addr,
>                                  int access_type, int mmu_idx,
>                                  bool first_stage, bool two_stage,
> -                                bool is_debug)
> +                                bool is_debug, bool is_probe)
>  {
>      /*
>       * NOTE: the env->pc value visible here will not be
> @@ -898,6 +898,8 @@ static int get_physical_address(CPURISCVState *env, h=
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
> @@ -1028,7 +1030,7 @@ restart:
>              int vbase_ret =3D get_physical_address(env, &vbase, &vbase_p=
rot,
>                                                   base, NULL, MMU_DATA_LO=
AD,
>                                                   MMUIdx_U, false, true,
> -                                                 is_debug);
> +                                                 is_debug, false);
>
>              if (vbase_ret !=3D TRANSLATE_SUCCESS) {
>                  if (fault_pte_addr) {
> @@ -1106,21 +1108,43 @@ restart:
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
> +            /*
> +             * if ss index, read and write allowed. else if not a probe
> +             * then only read allowed
> +             */
> +            rwx =3D is_sstack_idx ? (PTE_R | PTE_W) : (is_probe ? 0 :  P=
TE_R);
> +            break;
> +        }
> +        return TRANSLATE_FAIL;
> +    case PTE_R:
> +        /*
> +         * no matter what's the `access_type`, shadow stack access to re=
adonly
> +         * memory are always store page faults. During unwind, loads wil=
l be
> +         * promoted as store fault.
> +         */
> +        if (is_sstack_idx) {
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
> @@ -1164,8 +1188,11 @@ restart:
>      }
>
>      if (!((prot >> access_type) & 1)) {
> -        /* Access check failed */
> -        return TRANSLATE_FAIL;
> +        /*
> +         * Access check failed, access check failures for shadow stack a=
re
> +         * access faults.
> +         */
> +        return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
>      }
>
>      target_ulong updated_pte =3D pte;
> @@ -1303,13 +1330,13 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs=
, vaddr addr)
>      int mmu_idx =3D riscv_env_mmu_index(&cpu->env, false);
>
>      if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_=
idx,
> -                             true, env->virt_enabled, true)) {
> +                             true, env->virt_enabled, true, false)) {
>          return -1;
>      }
>
>      if (env->virt_enabled) {
>          if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL=
,
> -                                 0, MMUIdx_U, false, true, true)) {
> +                                 0, MMUIdx_U, false, true, true, false))=
 {
>              return -1;
>          }
>      }
> @@ -1352,9 +1379,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, v=
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
> @@ -1415,7 +1450,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
>          /* Two stage lookup */
>          ret =3D get_physical_address(env, &pa, &prot, address,
>                                     &env->guest_phys_fault_addr, access_t=
ype,
> -                                   mmu_idx, true, true, false);
> +                                   mmu_idx, true, true, false, probe);
>
>          /*
>           * A G-stage exception may be triggered during two state lookup.
> @@ -1438,7 +1473,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
>
>              ret =3D get_physical_address(env, &pa, &prot2, im_address, N=
ULL,
>                                         access_type, MMUIdx_U, false, tru=
e,
> -                                       false);
> +                                       false, probe);
>
>              qemu_log_mask(CPU_LOG_MMU,
>                            "%s 2nd-stage address=3D%" VADDR_PRIx
> @@ -1475,7 +1510,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
>      } else {
>          /* Single stage lookup */
>          ret =3D get_physical_address(env, &pa, &prot, address, NULL,
> -                                   access_type, mmu_idx, true, false, fa=
lse);
> +                                   access_type, mmu_idx, true, false, fa=
lse,
> +                                   probe);
>
>          qemu_log_mask(CPU_LOG_MMU,
>                        "%s address=3D%" VADDR_PRIx " ret %d physical "
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
> 2.45.0
>
>

