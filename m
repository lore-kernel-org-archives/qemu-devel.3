Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D724FC02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcxAy-00063f-5Q; Tue, 28 Jan 2025 20:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcxAc-0005pd-IJ; Tue, 28 Jan 2025 20:47:16 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcxAa-00051G-DZ; Tue, 28 Jan 2025 20:47:09 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5187f0b893dso2036674e0c.3; 
 Tue, 28 Jan 2025 17:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738115227; x=1738720027; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iP2RxzvE9uzlo5o/XHXRIawQW5zfIMTx6sNzlyNMgt0=;
 b=MKKTi5fFBoPdUK6e5UxwebHSM/Pq+w+ZjLWqXURnn2vRRuRFbKLb5ROCdWoYyjZRNS
 ebjt0x4D8WbFvQSO9Ntb+z/WKceTadFq4EWZOvGu0BVB/5TjKXFe1RzD7jDCVZX5kn7w
 a7CAA1zWhs8uZ72nWT0M+lFAYKjsa4+azukZydPhGZRxNnctvSdIb8zoW3NNumfiC1OR
 fclMvAbwGtfsVq0NZr++PnDNzpLObvq+hfyDT7qVRTn+gKLmi5r407kALM67qtw2dWWR
 gonwC22Jia+DJnyn5pCRmh8zpkIgk8HD/I3zd8X1NOYPT87F8VscHqBGextbdFGyTmmU
 u4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738115227; x=1738720027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iP2RxzvE9uzlo5o/XHXRIawQW5zfIMTx6sNzlyNMgt0=;
 b=JTkYpEuDLHQmT5icXoAsvo0JMBd8Vi3/dKxpo/r4hWWARAwTlXgNDKNx5Yfw0k/l6M
 Lr1kjvOwHWHqvazWP3EY7VUP8U+YxmaIni9XbL56QipZyVuwBAcKp71hSZXOeMRCpK0s
 p0PNx7K8rNapy04+5INOAiS4sNAmniJDzCKRW312ITIM80+jsiA09iMXjSgYPRGDXkoe
 fvlZ71Ol7/Y1R5HbBIiRNxvSx6mrH8gv66NTs0NaWAEWd1CzGliUVUChHZzWWho3F2Zs
 Qm/8mqTr/HKUTqVz/psFejlCodSunxCLnDyiVNfUi4vsUnKtLGmYOR7NcVv4aFS2azqw
 cucg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFaJV+enIJuk8sUniDX2npAtPy9OebQ8ZYPE7HTwhZwT4oAuDBdhvmCKm4C1Kpi1Zp3fVqh7E9kpKW@nongnu.org
X-Gm-Message-State: AOJu0YyRnX6QCL9DPq1IL7XyAb2jWFj28sOMVB/LcFy7g86GjT8529bB
 3TmSAW4jbzqKRVuOkmLZb6/XOpG3bcydj1LUavfl2fygV/cKUslmxhPV3ps6LupKGAXjSTa2gbr
 UUgUWaGqFJl9H//fKQi/tRqCcl6E=
X-Gm-Gg: ASbGnct27msLp25FqYMymFEcR6rDO4VcHx5HiIldiXgqgSR69I5kkbK+cpEhQ/WDOHV
 S+HTFrGdSl+UXZEJEe5E0mQzDVpaan32tM9+ZOFxWKmZzmtAOCqk7w5YidHJnylC4r/xE9Ex6xJ
 iBWmOHf3ZlrlF6IHa1H2u/KyosCw==
X-Google-Smtp-Source: AGHT+IGbnBzPG80AJQ9DgXUu+mVwImdZzOZJOcOhWq12Wf0ZcyTHyOlRt6QEO7xTwR1Jzq/7HxAzQafoSdUEJrlzrKc=
X-Received: by 2002:a05:6122:65a2:b0:516:157d:c5fb with SMTP id
 71dfb90a1353d-51e9e55bbbemr1641800e0c.10.1738115226904; Tue, 28 Jan 2025
 17:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
 <20250121170626.1992570-3-dbarboza@ventanamicro.com>
In-Reply-To: <20250121170626.1992570-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:46:40 +1000
X-Gm-Features: AWEUYZkdcjotdOVyuPTjVC54AiXlPpxWmo7Wxghik-_vqHNVVJIOSGozy2WU8rQ
Message-ID: <CAKmqyKOoJ=L=9k0s27pc3QQ+EQZEtmsJD0ktWiS_4jhNn1hBNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] target/riscv: throw debug exception before page
 fault
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Wed, Jan 22, 2025 at 3:08=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> In the RISC-V privileged ISA section 3.1.15 table 15, it is determined
> that a debug exception that is triggered from a load/store has a higher
> priority than a possible fault that this access might trigger.
>
> This is not the case ATM as shown in [1]. Adding a breakpoint in an
> address that deliberately will fault is causing a load page fault
> instead of a debug exception. The reason is that we're throwing in the
> page fault as soon as the fault occurs (end of riscv_cpu_tlb_fill(),
> raise_mmu_exception()), not allowing the installed watchpoints to
> trigger.
>
> Call cpu_check_watchpoint() in the page fault path to search and execute
> any watchpoints that might exist for the address, never returning back
> to the fault path. If no watchpoints are found cpu_check_watchpoint()
> will return and we'll fall-through the regular path to
> raise_mmu_exception().
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2627
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2627
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e1dfc4ecbf..df5de53379 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -27,6 +27,7 @@
>  #include "exec/page-protection.h"
>  #include "instmap.h"
>  #include "tcg/tcg-op.h"
> +#include "hw/core/tcg-cpu-ops.h"
>  #include "trace.h"
>  #include "semihosting/common-semi.h"
>  #include "system/cpu-timers.h"
> @@ -1708,6 +1709,23 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr addres=
s, int size,
>      } else if (probe) {
>          return false;
>      } else {
> +        int wp_access =3D 0;
> +
> +        if (access_type =3D=3D MMU_DATA_LOAD) {
> +            wp_access |=3D BP_MEM_READ;
> +        } else if (access_type =3D=3D MMU_DATA_STORE) {
> +            wp_access |=3D BP_MEM_WRITE;
> +        }
> +
> +        /*
> +         * If a watchpoint isn't found for 'addr' this will
> +         * be a no-op and we'll resume the mmu_exception path.
> +         * Otherwise we'll throw a debug exception and execution
> +         * will continue elsewhere.
> +         */
> +        cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
> +                             wp_access, retaddr);
> +
>          raise_mmu_exception(env, address, access_type, pmp_violation,
>                              first_stage_error, two_stage_lookup,
>                              two_stage_indirect_error);
> --
> 2.47.1
>
>

