Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330E4CAC587
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 03:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxzRN-00086b-1y; Sun, 14 Sep 2025 22:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzRK-00086K-P1
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 22:59:38 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzRC-0002VS-GF
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 22:59:38 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b03fa5c5a89so564957366b.2
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 19:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757905163; x=1758509963; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beunKNVuZm35GDhVUgDKLikV0TKgfENd+xLUOeNU9cQ=;
 b=GJ+g6QDFvHbTRcRtRIaKHFhWskGLp3NkdstpTeWh9jKNzk6bHgiQS3SssZ2XYVD60B
 v5goaHs2KkKrjl9ZshKqyQbJSlhi1iGVAIXhfnqvd6Qs1jliCkiqHhcFZFlTQiCelr52
 Cf2iICt5lICj+mrEpeUJ3Un6wtaImuXWNVkc2VnOFfckAWwzTysLy8G4MZysDiizVrKG
 9Y1ubFvect3KxqwaJkePs5bVesHRxEjpoYv4OK+9NgqswBwjMIT/KGngEkX8J/k5A8Ve
 tJ3AmdJdJx6sjNOnqqEisKAFrhWikLwYiNjAxgpaK8amqLBQ7KWnN4qy7pmMOpBJZSzZ
 odIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757905163; x=1758509963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beunKNVuZm35GDhVUgDKLikV0TKgfENd+xLUOeNU9cQ=;
 b=GPsB+3qr2L9aEpWqfxhi/uO8oSInyIR+87yU2sIBBRCqmD1AvmQyD+1xW2+DchETbd
 aAyoAn6tmML+LabynnOdislLrFN+HubpB8rgg4d+S/XCkJ6illLgszWy0eYtE5ZDfaI/
 P51+SBOeQJDdnv6ACfCne7gKOppL+Snh0ZBciSKbCG09Gef1OD+Ig+eoyby+uMvRFoP7
 OEIgJl2rfKshHx6Bbo7EJUNgctGA2Ur9J5PMObucpAiKKoOLMd56VUXKYgjA4zwWhrQX
 T1VEjcKSwRNVBP29FknhaPnbwuBPO8K2MXSdO9T3bExqNO0g0cJqPjo4q2RmIx9nsMTm
 xiWg==
X-Gm-Message-State: AOJu0YyMTOrZ2Ls97RKq52wpm9KzgQsfDbNN0sJE2LxeNN+BIyM1iAZ4
 bk+dt4c18D2SJt8zMjP1RzoZR66aJPIQh952Q/aW/TbGYhi+rCPyh8LfyOkpkzKrhJNTC9ecFlm
 u/Dvoej/OGFtv9DCvhVfVb98kiWqKAEs=
X-Gm-Gg: ASbGncuLJFEQyyfSBXPZh3u3ezjXUmEyoX8kHS+gtgkEpim4zAAYd0kHc3MYWHVv0BF
 EYuL1rzo9Dn4NIEJdL25NRY1+Q6o/lMcPgjRcLIVWS2Va6vLIroFEO2KbaFjVRz0lgN2PfVodll
 UVpyxaQmbsJQfR5cb0to1U/mXfgKNxC84PTbYvB5+yfoQvJmQDmrQ67NRRB+gCUwue/g8znLSgW
 Qu5DZEzUZNlXTzRjYbzZjT9M0EQc5LfjSGbU7JCjXcSasNq
X-Google-Smtp-Source: AGHT+IGH/hFg333BzEpcOiXk7E1J1jpFuoCp8/0iTAZbCoOgnxziRHRA/2+rsOLQHw8/T6OLUJu8USy2tR27SwhdJv4=
X-Received: by 2002:a17:907:3e95:b0:b04:9acf:46c4 with SMTP id
 a640c23a62f3a-b07c38345f9mr1080672866b.51.1757905162778; Sun, 14 Sep 2025
 19:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250703130815.1592493-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250703130815.1592493-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 12:58:56 +1000
X-Gm-Features: Ac12FXx8zE1GKLaOaLyE329LNI3B5E14VZH0aa3aIKf1tgOkNRtxl0_WTcelevo
Message-ID: <CAKmqyKOduKFDX8biFe0j0qj0HYRYVp7NaSXOVZgqdWMBNmJDbQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: implement MonitorDef HMP API
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 3, 2025 at 11:09=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The MonitorDef API is related to two HMP monitor commands: 'p' and 'x':
>
> (qemu) help p
> print|p /fmt expr -- print expression value (use $reg for CPU register ac=
cess)
> (qemu) help x
> x /fmt addr -- virtual memory dump starting at 'addr'
>
> For x86, one of the few targets that implements it, it is possible to
> print the PC register value with $pc and use the PC value in the 'x'
> command as well.
>
> Those 2 commands are hooked into get_monitor_def(), called by
> exp_unary() in hmp.c. The function tries to fetch a reg value in two
> ways: by reading them directly via a target_monitor_defs array or using
> a target_get_monitor_def() helper. In RISC-V we have *A LOT* of
> registers and this number will keep getting bigger, so we're opting out
> of an array declaration.
>
> We're able to retrieve all regs but vregs because the API only fits an
> uint64_t and vregs have 'vlen' size that are bigger than that.
>
> With this patch we can do things such as:
>
> - print CSRs and use their val in expressions:
> (qemu) p $mstatus
> 0xa000000a0
> (qemu) p $mstatus & 0xFF
> 0xa0
>
> - dump the next 10 insn from virtual memory starting at x1 (ra):
>
> (qemu) x/10i $ra
> 0xffffffff80958aea:  a9bff0ef          jal                     ra,-1382  =
              # 0xffffffff80958584
> 0xffffffff80958aee:  10016073          csrrsi                  zero,sstat=
us,2
> 0xffffffff80958af2:  60a2              ld                      ra,8(sp)
> 0xffffffff80958af4:  6402              ld                      s0,0(sp)
> 0xffffffff80958af6:  0141              addi                    sp,sp,16
> 0xffffffff80958af8:  8082              ret
> 0xffffffff80958afa:  10016073          csrrsi                  zero,sstat=
us,2
> 0xffffffff80958afe:  8082              ret
> 0xffffffff80958b00:  1141              addi                    sp,sp,-16
> 0xffffffff80958b02:  e422              sd                      s0,8(sp)
> (qemu)
>
> Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h            |   1 +
>  target/riscv/riscv-qmp-cmds.c | 148 ++++++++++++++++++++++++++++++++++
>  2 files changed, 149 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 229ade9ed9..487884c42c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -576,6 +576,7 @@ static inline int riscv_has_ext(CPURISCVState *env, t=
arget_ulong ext)
>  extern const char * const riscv_int_regnames[];
>  extern const char * const riscv_int_regnamesh[];
>  extern const char * const riscv_fpr_regnames[];
> +extern const char * const riscv_rvv_regnames[];
>
>  const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
>  int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.=
c
> index 8ba8aa0d5f..2c8c74bbe4 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -31,6 +31,10 @@
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/visitor.h"
>  #include "qom/qom-qobject.h"
> +#include "qemu/ctype.h"
> +#include "qemu/qemu-print.h"
> +#include "monitor/hmp.h"
> +#include "monitor/hmp-target.h"
>  #include "system/kvm.h"
>  #include "system/tcg.h"
>  #include "cpu-qom.h"
> @@ -240,3 +244,147 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansio=
n(CpuModelExpansionType type,
>
>      return expansion_info;
>  }
> +
> +/*
> + * We have way too many potential CSRs and regs being added
> + * regularly to register them in a static array.
> + *
> + * Declare an empty array instead, making get_monitor_def() use
> + * the target_get_monitor_def() API directly.
> + */
> +const MonitorDef monitor_defs[] =3D { { } };
> +const MonitorDef *target_monitor_defs(void)
> +{
> +    return monitor_defs;
> +}
> +
> +static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
> +                                 target_ulong *val, bool is_gprh)
> +{
> +    const char * const *reg_names;
> +    target_ulong *vals;
> +
> +    if (is_gprh) {
> +        reg_names =3D riscv_int_regnamesh;
> +        vals =3D env->gprh;
> +    } else {
> +        reg_names =3D riscv_int_regnames;
> +        vals =3D env->gpr;
> +    }
> +
> +    for (int i =3D 0; i < 32; i++) {
> +        g_autofree char *reg_name =3D g_strdup(reg_names[i]);
> +        char *reg1 =3D strtok(reg_name, "/");
> +        char *reg2 =3D strtok(NULL, "/");
> +
> +        if (strcasecmp(reg1, name) =3D=3D 0 ||
> +            (reg2 && strcasecmp(reg2, name) =3D=3D 0)) {
> +            *val =3D vals[i];
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_=
t *val)
> +{
> +    if (qemu_tolower(name[0]) !=3D 'f') {
> +        return false;
> +    }
> +
> +    for (int i =3D 0; i < 32; i++) {
> +        g_autofree char *reg_name =3D g_strdup(riscv_fpr_regnames[i]);
> +        char *reg1 =3D strtok(reg_name, "/");
> +        char *reg2 =3D strtok(NULL, "/");
> +
> +        if (strcasecmp(reg1, name) =3D=3D 0 ||
> +            (reg2 && strcasecmp(reg2, name) =3D=3D 0)) {
> +            *val =3D env->fpr[i];
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static bool reg_is_vreg(const char *name)
> +{
> +    if (qemu_tolower(name[0]) !=3D 'v' || strlen(name) > 3) {
> +        return false;
> +    }
> +
> +    for (int i =3D 0; i < 32; i++) {
> +        if (strcasecmp(name, riscv_rvv_regnames[i]) =3D=3D 0) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pva=
l)
> +{
> +    CPURISCVState *env =3D &RISCV_CPU(cs)->env;
> +    target_ulong val =3D 0;
> +    uint64_t val64 =3D 0;
> +    int i;
> +
> +    if (reg_is_ulong_integer(env, name, &val, false) ||
> +        reg_is_ulong_integer(env, name, &val, true)) {
> +        *pval =3D val;
> +        return 0;
> +    }
> +
> +    if (reg_is_u64_fpu(env, name, &val64)) {
> +        *pval =3D val64;
> +        return 0;
> +    }
> +
> +    if (reg_is_vreg(name)) {
> +        if (!riscv_has_ext(env, RVV)) {
> +            return -EINVAL;
> +        }
> +
> +        qemu_printf("Unable to print the value of vector "
> +                    "vreg '%s' from this API\n", name);
> +
> +        /*
> +         * We're returning 0 because returning -EINVAL triggers
> +         * an 'unknown register' message in exp_unary() later,
> +         * which feels ankward after our own error message.
> +         */
> +        *pval =3D 0;
> +        return 0;
> +    }
> +
> +    for (i =3D 0; i < ARRAY_SIZE(csr_ops); i++) {
> +        RISCVException res;
> +        int csrno =3D i;
> +
> +        /*
> +         * Early skip when possible since we're going
> +         * through a lot of NULL entries.
> +         */
> +        if (csr_ops[csrno].predicate =3D=3D NULL) {
> +            continue;
> +        }
> +
> +        if (strcasecmp(csr_ops[csrno].name, name) !=3D 0) {
> +            continue;
> +        }
> +
> +        res =3D riscv_csrrw_debug(env, csrno, &val, 0, 0);
> +
> +        /*
> +         * Rely on the smode, hmode, etc, predicates within csr.c
> +         * to do the filtering of the registers that are present.
> +         */
> +        if (res =3D=3D RISCV_EXCP_NONE) {
> +            *pval =3D val;
> +            return 0;
> +        }
> +    }
> +
> +    return -EINVAL;
> +}
> --
> 2.49.0
>
>

