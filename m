Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAC1F364CA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxcm-0003r2-AI; Thu, 09 Apr 2026 18:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxck-0003qf-Kv
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:13:18 -0400
Received: from p-east2-cluster5-host9-snip4-10.eps.apple.com ([57.103.79.113]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxci-0001zA-2V
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:13:18 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPS id
 4CB5F1800ADE; Thu, 09 Apr 2026 22:13:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775772792; x=1778364792;
 bh=0D1d/QKolzA1KrfQvkROrKknGQUn6IWPvj5l8EVojLs=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=NrsDYl2rbJX9PCckh48N5+N7V9uz7AKWkNbR2L4569rM2SefPVby4n9KNjgXHQKhVe0WNKN1mzr+7rjBaiGmJe09y2M9/uwvBi/IiyNsDs3tozj4+nzwZnsdBQGEYugr5E3IbYWJdyknsE/CPulMsi6eiuvXZFIy7UYow0I+Z8a5YYvm76SI8mzJGxSjahVd8afjc+EhJ1ZAcK/3YLhUz8W5R474DDs3OuOOtkZybBhVmqB2fucyXOKdjHwauT6lQPYhjx4pNWPvGrlIs7q3C2zkfchdzxyzKbW4FnHG3agMpSeK1YMDLLe2o/78UluKf4SsNvV/FaAAlBCsYkmFLw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPSA id
 084991800AC7; Thu, 09 Apr 2026 22:13:06 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 6/6] target/arm/hvf, whpx: wire ISV=0 emulation for data
 aborts
In-Reply-To: <20260409220614.65558-7-lucaaamaral@gmail.com>
Date: Fri, 10 Apr 2026 00:12:54 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4303E81D-5539-4666-BBE8-BA58E3F72B6F@unpredictable.fr>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <20260409220614.65558-7-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=KYjfcAYD c=1 sm=1 tr=0 ts=69d82476
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=9fa6GIJ-UKfugACyS8kA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwNSBTYWx0ZWRfX/sYw40ZcMmya
 3IhVKuVS21B3OHnmBJckRQaS5qzP57cyedlP1W03Dl2Tj4evvs9Q+KKSxEcGJOqVui2YFNi6Gdo
 aDsYThqbN407HE8OvDuOgrCyLu6jUR8PckqE7VlBabeYZU6g1NewybAwd5cvJPai75lrKb49cM9
 1ruqo3KUatube6dUgaAyWiFrMdG9h3aLUMVYgjNIbnfE2eEtfp52mCsQ0JftD6ELCq2gG1EhNTC
 HIiV+BxL+xQwp++dDzXZWJGuspE7XTRLuQ0f023p4EsEamADxYq1Lws4olGUC2szIfjAhtQzFZg
 /61KSXYFapCxwLbVb8fS5g5mhaSx7OLh8uW1OMhiM4sl5ycsT2L23aKMUFTgYY=
X-Proofpoint-GUID: xV5HHaqicpl0eow_j9KwY7Kn4p3apvcx
X-Proofpoint-ORIG-GUID: xV5HHaqicpl0eow_j9KwY7Kn4p3apvcx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=620 spamscore=0 clxscore=1030 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090205
Received-SPF: pass client-ip=57.103.79.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Mohamed Mediouni <mohamed@unpredictable.fr>
From:  Mohamed Mediouni via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 10. Apr 2026, at 00:06, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>=20
> When a data abort with ISV=3D0 occurs during MMIO emulation, the
> syndrome register does not carry the access size or target register.
> Previously this hit an assert(isv) and killed the VM.
>=20
> Replace the assert with instruction fetch + decode + emulate using the
> shared library in target/arm/emulate/.  The faulting instruction is =
read
> from guest memory via cpu_memory_rw_debug(), decoded by the =
decodetree-
> generated decoder, and emulated against the vCPU register file.
>=20
> Both HVF (macOS) and WHPX (Windows Hyper-V) use the same pattern:
>  1. cpu_synchronize_state() to flush hypervisor registers
>  2. Fetch 4-byte instruction at env->pc
>  3. arm_emul_insn(env, insn)
>  4. On success, advance PC past the emulated instruction
>=20
> If the instruction is unhandled or a memory error occurs, a =
synchronous
> external abort is injected into the guest via syn_data_abort_no_iss()
> with fnv=3D1 and fsc=3D0x10, matching the syndrome that KVM uses in
> kvm_inject_arm_sea().  The guest kernel's fault handler then reports
> the error through its normal data abort path.
>=20
> WHPX adds a whpx_inject_data_abort() helper and adjusts the
> whpx_handle_mmio() return convention so the caller skips PC =
advancement
> when an exception has been injected.
>=20
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
> target/arm/hvf/hvf.c       | 46 ++++++++++++++++++++++++++--
> target/arm/whpx/whpx-all.c | 61 +++++++++++++++++++++++++++++++++++++-
> 2 files changed, 103 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 5fc8f6bb..000e54bd 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -32,6 +32,7 @@
> #include "arm-powerctl.h"
> #include "target/arm/cpu.h"
> #include "target/arm/internals.h"
> +#include "emulate/arm_emulate.h"
> #include "target/arm/multiprocessing.h"
> #include "target/arm/gtimer.h"
> #include "target/arm/trace.h"
> @@ -2175,10 +2176,49 @@ static int hvf_handle_exception(CPUState *cpu, =
hv_vcpu_exit_exception_t *excp)
>         assert(!s1ptw);
>=20
>         /*
> -         * TODO: ISV will be 0 for SIMD or SVE accesses.
> -         * Inject the exception into the guest.
> +         * ISV=3D0: syndrome doesn't carry access size/register info.
> +         * Fetch and emulate via target/arm/emulate/.
>          */
> -        assert(isv);
> +        if (!isv) {
> +            ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +            CPUARMState *env =3D &arm_cpu->env;
> +            uint32_t insn;
> +            ArmEmulResult r;
> +
> +            cpu_synchronize_state(cpu);
> +
> +            if (cpu_memory_rw_debug(cpu, env->pc,
> +                                    (uint8_t *)&insn, 4, false) !=3D =
0) {
Hello,

Having a version of mem_access exported and used there too to read the =
instruction
to get rid of cpu_memory_rw_debug there too

(For both WHPX and HVF)

> +                bool same_el =3D arm_current_el(env) =3D=3D 1;
> +                uint32_t esr =3D syn_data_abort_no_iss(same_el,
> +                    1, 0, 0, 0, iswrite, 0x10);
> +
> +                error_report("HVF: cannot read insn at pc=3D0x%" =
PRIx64,
> +                             (uint64_t)env->pc);
> +                env->exception.vaddress =3D excp->virtual_address;
> +                hvf_raise_exception(cpu, EXCP_DATA_ABORT, esr, 1);
> +                break;
> +            }
> +
> +            r =3D arm_emul_insn(env, insn);
> +            if (r =3D=3D ARM_EMUL_UNHANDLED || r =3D=3D =
ARM_EMUL_ERR_MEM) {
> +                bool same_el =3D arm_current_el(env) =3D=3D 1;
> +                uint32_t esr =3D syn_data_abort_no_iss(same_el,
> +                    1, 0, 0, 0, iswrite, 0x10);
> +
> +                error_report("HVF: ISV=3D0 %s insn 0x%08x at "
> +                             "pc=3D0x%" PRIx64 ", injecting data =
abort",
> +                             r =3D=3D ARM_EMUL_UNHANDLED ? =
"unhandled"
> +                                                     : "memory =
error",
> +                             insn, (uint64_t)env->pc);
> +                env->exception.vaddress =3D excp->virtual_address;
> +                hvf_raise_exception(cpu, EXCP_DATA_ABORT, esr, 1);
> +                break;
> +            }
> +
> +            advance_pc =3D true;
> +            break;
> +        }
>=20
>         /*
>          * Emulate MMIO.
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 513551be..0c04073e 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -29,6 +29,7 @@
> #include "syndrome.h"
> #include "target/arm/cpregs.h"
> #include "internals.h"
> +#include "emulate/arm_emulate.h"
>=20
> #include "system/whpx-internal.h"
> #include "system/whpx-accel-ops.h"
> @@ -352,6 +353,27 @@ static void whpx_set_gp_reg(CPUState *cpu, int =
rt, uint64_t val)
>     whpx_set_reg(cpu, reg, reg_val);
> }
>=20
> +/*
> + * Inject a synchronous external abort (data abort) into the guest.
> + * Used when ISV=3D0 instruction emulation fails.  Matches the =
syndrome
> + * that KVM uses in kvm_inject_arm_sea().
> + */
> +static void whpx_inject_data_abort(CPUState *cpu, bool iswrite)
> +{
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +    CPUARMState *env =3D &arm_cpu->env;
> +    bool same_el =3D arm_current_el(env) =3D=3D 1;
> +    uint32_t esr =3D syn_data_abort_no_iss(same_el, 1, 0, 0, 0, =
iswrite, 0x10);
> +
> +    cpu->exception_index =3D EXCP_DATA_ABORT;
> +    env->exception.target_el =3D 1;
> +    env->exception.syndrome =3D esr;
> +
> +    bql_lock();
> +    arm_cpu_do_interrupt(cpu);
> +    bql_unlock();
> +}
> +
> static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT =
*ctx)
> {
>     uint64_t syndrome =3D ctx->Syndrome;
> @@ -366,7 +388,40 @@ static int whpx_handle_mmio(CPUState *cpu, =
WHV_MEMORY_ACCESS_CONTEXT *ctx)
>     uint64_t val =3D 0;
>=20
>     assert(!cm);
> -    assert(isv);
> +
> +    /*
> +     * ISV=3D0: syndrome doesn't carry access size/register info.
> +     * Fetch and decode the faulting instruction via the emulation =
library.
> +     */
> +    if (!isv) {
> +        ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +        CPUARMState *env =3D &arm_cpu->env;
> +        uint32_t insn;
> +        ArmEmulResult r;
> +
> +        cpu_synchronize_state(cpu);
> +
> +        if (cpu_memory_rw_debug(cpu, env->pc,
> +                                (uint8_t *)&insn, 4, false) !=3D 0) {
> +            error_report("WHPX: cannot read insn at pc=3D0x%" PRIx64,
> +                         (uint64_t)env->pc);
> +            whpx_inject_data_abort(cpu, iswrite);
> +            return 1;
> +        }
> +
> +        r =3D arm_emul_insn(env, insn);
> +        if (r =3D=3D ARM_EMUL_UNHANDLED || r =3D=3D ARM_EMUL_ERR_MEM) =
{
> +            error_report("WHPX: ISV=3D0 %s insn 0x%08x at "
> +                         "pc=3D0x%" PRIx64 ", injecting data abort",
> +                         r =3D=3D ARM_EMUL_UNHANDLED ? "unhandled"
> +                                                 : "memory error",
> +                         insn, (uint64_t)env->pc);
> +            whpx_inject_data_abort(cpu, iswrite);
> +            return 1;
> +        }
> +
> +        return 0;
> +    }
>=20
>     if (iswrite) {
>         val =3D whpx_get_gp_reg(cpu, srt);
> @@ -451,6 +506,10 @@ int whpx_vcpu_run(CPUState *cpu)
>             }
>=20
>             ret =3D whpx_handle_mmio(cpu, =
&vcpu->exit_ctx.MemoryAccess);
> +            if (ret > 0) {
> +                advance_pc =3D false;
> +                ret =3D 0;
> +            }
>             break;
>         case WHvRunVpExitReasonCanceled:
>             cpu->exception_index =3D EXCP_INTERRUPT;
> --=20
> 2.52.0
>=20


