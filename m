Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74B6FCC9A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 01:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzluA-0002Ml-EF; Mon, 09 Mar 2026 21:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzlu4-0002MF-UI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 21:28:56 -0400
Received: from p-west2-cluster2-host4-snip4-7.eps.apple.com ([57.103.68.160]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzlu2-00012h-SO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 21:28:56 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPS id
 12CE6180012F; Tue, 10 Mar 2026 01:28:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773106134; x=1775698134;
 bh=f28tpuqdLcGC45GwzTg/S9M6CfA8/cETz8vtTkkJt4c=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=WveAaHiil7AEe51C+AdgPTxyQ7psi+LWmG0lw44KDZOc/ztZ9gMZrdyEdEpw9UyLUC95ki635TXauTw6DOJSdI82AVw7VFaGD9tl2U1KmtD2e1AwMT7ux/a+Azr1ulz5eorHy3uYqRmHku4uxErm/ux+Z5btIOCnnWUKNcSB8t27Lbkh77fsHGtKmxyRue1wvOe25SKOPvlu4fcC+XSJWDaQsHDYxFFxePheZ/2A91SpYOrE5dl91x0vLQ/nQfUlq4NE4G9YFqvSvWO4Db5LfNC4GuSg7ROmfO+nUPtMngu/2ikyPRhA+uGxHZlweqQ/NYV41B2jeP4BELXEwyeikA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPSA id
 3A4371800093; Tue, 10 Mar 2026 01:28:49 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] target/arm/hvf: emulate ISV=0 data abort instructions
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260309214852.92545-1-lucaaamaral@gmail.com>
Date: Tue, 10 Mar 2026 02:28:37 +0100
Cc: qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,
 agraf@csgraf.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <10F88EF8-950B-42AE-80A6-6B1E13BAD27D@unpredictable.fr>
References: <20260309214852.92545-1-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=TNJIilla c=1 sm=1 tr=0 ts=69af73d3
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=hONZm29C8bqNLOFPYg4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAwOSBTYWx0ZWRfX5VLam+lMa0Mx
 w6DyK5MBQISSvzBYoQWom07CNXJpqAQ1ibaKAfMK+e0pkpRkQ7LFFvk6aoY2l2RDCTAHwbkIMj8
 U8+7IrCl8Jw781d0s+1X/ZN9gUnniTy0F6wRlsnwLwNhgRqYOAZH226I6Pj/LEtZ8gyFKdjsFuP
 wmLxAh/y/W5ysoFOAgh9o4/x9JAo+CqWVxenA6sYsUYR2ruWklJ+Jd5nNgqTQNP1+bNUFvllvrL
 ghLICIhiaNiCyO2o4h+laomZEasZE4LDRU/WshlIA6khWibEUGPCptDMsPeflonuvKECcCU9vrF
 OgomsUmzLXSw54ylaVlxscXXB+0+71D2bSJ5uYwm1CLL3O4TYOhkx3v0Gy5ps8=
X-Proofpoint-GUID: J_1-LA25z_RJu5H7vfTovQH-bSUcMX_Q
X-Proofpoint-ORIG-GUID: J_1-LA25z_RJu5H7vfTovQH-bSUcMX_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=477
 clxscore=1030 mlxscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603100009
X-JNJ: AAAAAAABk+Hd2q9bFN0F95tfeKgEjntvRZGFUjtoEedFzMqw+YWDNX7hITlVp+4oCttZYp+6rnqM5A+uDKTV2g7ewm9rJXzDgy0aEXqgcw3ua8w0rzhlvOaQ3WbSnMiT3Oi4HJn340vSIVCrJuf2+Fw7nQf8w6NEsjKj3g4qbL3OAyk6p+9NfCZQaX2Ph9h7KQrdM9AQf91hRK6F0MhCm/Y/1sUDbRwIeGK7vROMKk5aZXyJ8KNkoIVOTS+ROwhUIlaPUHnHjCJ5kqxjYzMx49xGI+7cQZJ+Tx251PNuAR1NYcShQo3p4h5UqlmZLeUMErxz0y5vB9Fz01TC5DmLX4uHU24SmaQGVHx/pTzj4ciTV1oXtYJYdj0Zfav7K//e6eNXHp8IewVVrNO3EK7jZ0A+6NVBi5mAKG4W3OTnq5mH8FvVZNLPKa3iexwV6l+YXC/iVwfCeFH1cOxUepBUZYFTqX5r8Uz7tuSO5koPO5FxM5OzMgT+dkxtFxZvgUxt7M8oor2PQLy43MGb4KXddnXVoxEdut6o5Eydjo2lbUeIvGH/xQlrPfFkJf+OM9MnYw3tQZh/huHE5sl1AswmNoXVS+VgiM6MWkqgzZlYCYuwJJU1qL8+NqbONxBAV/7yVIk9Pg==
Received-SPF: pass client-ip=57.103.68.160;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 9. Mar 2026, at 22:48, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>=20
> On Apple Silicon, HVF exits with ISV=3D0 (no syndrome information)
> for STP/LDP/STNP/LDNP, SIMD/FP load/stores, and DC cache
> maintenance instructions that access MMIO regions.  The existing
> code asserted ISV!=3D0, crashing the VM.
>=20
> Decode the faulting instruction from guest memory and emulate:
> - Load/Store Pair (STP/LDP/STNP/LDNP) for GPR and SIMD registers
> - Single Load/Store with writeback and SIMD/FP variants
> - DC system instructions (NOP on MMIO regions)
> - LDPSW (sign-extending load pair)
>=20
> For pair instructions, compute the effective virtual address from
> the base register to handle page-straddling accesses correctly.
> HPFAR_EL2 reports the faulting page, not the effective address,
> so using the IPA directly would produce wrong results when an
> STP straddles an HVF-mapped / MMIO boundary.
>=20
> Tested with virtio-gpu Venus blob resources on macOS ARM64.
>=20
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> =E2=80=94
Hello,

The idea is good, but this specific implementation is NAK for me.

This ought to be in common code target/i386/emulate style instead of in =
specific HVF code.

Oh, and using something that looks more like a regular decoder perhaps.

Thank you,
-Mohamed
> target/arm/hvf/hvf.c | 309 ++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 306 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index d79469c..87ddcdb 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1871,10 +1871,313 @@ static int hvf_handle_exception(CPUState =
*cpu, hv_vcpu_exit_exception_t *excp)
>         assert(!s1ptw);
>=20
>         /*
> -         * TODO: ISV will be 0 for SIMD or SVE accesses.
> -         * Inject the exception into the guest.
> +         * ISV=3D0: syndrome doesn't carry access size/register info.
> +         * This happens for STP/LDP/STNP/LDNP, SIMD/SVE load/stores,
> +         * and DC (data cache) maintenance instructions.
> +         *
> +         * Sync all CPU state (including TTBR/TCR/SCTLR for page =
table
> +         * walk) and decode the faulting instruction from guest =
memory.
>          */
> -        assert(isv);
> +        if (!isv) {
> +            ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +            CPUARMState *env =3D &arm_cpu->env;
> +            uint32_t insn;
> +
> +            /*
> +             * Sync system registers (TTBR, TCR, SCTLR, etc.) from =
HVF
> +             * so cpu_memory_rw_debug can walk guest page tables.
> +             */
> +            cpu_synchronize_state(cpu);
> +
> +            if (cpu_memory_rw_debug(cpu, env->pc,
> +                                    (uint8_t *)&insn, 4, false) !=3D =
0) {
> +                error_report("HVF: ISV=3D0 at ipa=3D0x%" PRIx64
> +                             " -- cannot read insn at pc=3D0x%" =
PRIx64,
> +                             ipa, (uint64_t)env->pc);
> +                goto isv0_inject_fault;
> +            }
> +            insn =3D le32_to_cpu(insn);
> +
> +            /*
> +             * System instructions (DC CIVAC, DC CVAC, etc.):
> +             * bits [31:22] =3D 1101010100 identifies MRS/MSR/SYS =
class.
> +             * Cache maintenance on MMIO regions is a harmless NOP.
> +             */
> +            if ((insn & 0xFFC00000) =3D=3D 0xD5000000) {
> +                advance_pc =3D true;
> +                break;
> +            }
> +
> +            /*
> +             * Load/Store Pair (STP/LDP/STNP/LDNP):
> +             * bits [29:27] =3D 101 identifies this instruction =
class.
> +             * Supports both integer (GPR) and SIMD/FP register =
pairs.
> +             */
> +            if ((insn & 0x38000000) =3D=3D 0x28000000) {
> +                uint32_t opc =3D extract32(insn, 30, 2);
> +                bool is_vec =3D extract32(insn, 26, 1);
> +                bool is_load =3D extract32(insn, 22, 1);
> +                uint32_t rt =3D extract32(insn, 0, 5);
> +                uint32_t rt2 =3D extract32(insn, 10, 5);
> +                uint32_t rn =3D extract32(insn, 5, 5);
> +                uint32_t type =3D extract32(insn, 23, 3);
> +                bool writeback =3D (type =3D=3D 1 || type =3D=3D 3);
> +                uint32_t esize;
> +                int32_t imm7 =3D sextract32(insn, 15, 7);
> +
> +                if (!is_vec) {
> +                    esize =3D (opc & 2) ? 8 : 4;
> +                } else {
> +                    esize =3D 4u << opc;  /* 4, 8, or 16 bytes */
> +                }
> +
> +                int64_t stp_offset =3D (int64_t)imm7 * esize;
> +
> +                /*
> +                 * Compute the effective virtual address from the =
base
> +                 * register and immediate offset. HPFAR_EL2 reports
> +                 * the faulting page, not the effective address, so =
we
> +                 * must derive the VA from the instruction encoding.
> +                 *
> +                 * After cpu_synchronize_state(), env->xregs[0..30] =
are
> +                 * GPRs and env->xregs[31] is the current SP =
(restored
> +                 * via aarch64_restore_sp).
> +                 *
> +                 * Using the VA with cpu_memory_rw_debug() correctly
> +                 * splits page-straddling accesses via guest page =
tables.
> +                 */
> +                uint64_t rn_va =3D env->xregs[rn];
> +                /* post-index: access at unmodified base */
> +                uint64_t va =3D (type =3D=3D 1) ? rn_va : rn_va + =
stp_offset;
> +
> +                if (is_load =3D=3D iswrite) {
> +                    error_report("HVF: ISV=3D0 load/write mismatch at =
"
> +                                 "ipa=3D0x%" PRIx64, ipa);
> +                    goto isv0_inject_fault;
> +                }
> +
> +                if (iswrite) {
> +                    /* Store pair */
> +                    if (!is_vec) {
> +                        uint64_t val1 =3D env->xregs[rt];
> +                        uint64_t val2 =3D env->xregs[rt2];
> +                        uint8_t buf[16]; /* max 2 x 8 bytes */
> +                        memcpy(buf, &val1, esize);
> +                        memcpy(buf + esize, &val2, esize);
> +                        cpu_memory_rw_debug(cpu, va, buf,
> +                                            2 * esize, true);
> +                    } else {
> +                        /*
> +                         * SIMD STP: register data is in =
env->vfp.zregs[]
> +                         * after cpu_synchronize_state().
> +                         * esize=3D4: S reg, esize=3D8: D reg, =
esize=3D16: Q reg
> +                         */
> +                        uint8_t buf[32]; /* max 2 x 16 bytes */
> +                        memcpy(buf, &env->vfp.zregs[rt], esize);
> +                        memcpy(buf + esize,
> +                               &env->vfp.zregs[rt2], esize);
> +                        cpu_memory_rw_debug(cpu, va, buf,
> +                                            2 * esize, true);
> +                    }
> +                } else {
> +                    /* Load pair */
> +                    if (!is_vec) {
> +                        uint64_t val1 =3D 0, val2 =3D 0;
> +                        uint8_t buf[16];
> +                        memset(buf, 0, sizeof(buf));
> +                        cpu_memory_rw_debug(cpu, va, buf,
> +                                            2 * esize, false);
> +                        memcpy(&val1, buf, esize);
> +                        memcpy(&val2, buf + esize, esize);
> +                        if (opc =3D=3D 1 && !is_vec) {
> +                            /* LDPSW: sign-extend 32-bit to 64-bit */
> +                            val1 =3D (int64_t)(int32_t)val1;
> +                            val2 =3D (int64_t)(int32_t)val2;
> +                        }
> +                        hvf_set_reg(cpu, rt, val1);
> +                        hvf_set_reg(cpu, rt2, val2);
> +                    } else {
> +                        /* SIMD LDP */
> +                        uint8_t buf[32];
> +                        memset(buf, 0, sizeof(buf));
> +                        cpu_memory_rw_debug(cpu, va, buf,
> +                                            2 * esize, false);
> +                        memset(&env->vfp.zregs[rt], 0,
> +                               sizeof(env->vfp.zregs[rt]));
> +                        memset(&env->vfp.zregs[rt2], 0,
> +                               sizeof(env->vfp.zregs[rt2]));
> +                        memcpy(&env->vfp.zregs[rt], buf, esize);
> +                        memcpy(&env->vfp.zregs[rt2],
> +                               buf + esize, esize);
> +                        cpu->vcpu_dirty =3D true;
> +                    }
> +                }
> +
> +                /* Handle base register writeback (pre/post-index) */
> +                if (writeback) {
> +                    env->xregs[rn] =3D env->xregs[rn] + stp_offset;
> +                    cpu->vcpu_dirty =3D true;
> +                }
> +
> +                advance_pc =3D true;
> +                break;
> +            }
> +
> +            /*
> +             * Load/Store Register (single):
> +             * bits [29:27] =3D 111, bit [25] =3D 0.
> +             * Covers immediate (unscaled, post-index, pre-index),
> +             * unsigned offset, and register offset variants.
> +             *
> +             * ISV=3D0 for: writeback variants (pre/post-indexed) and
> +             * all SIMD/FP loads/stores.
> +             */
> +            if ((insn & 0x3A000000) =3D=3D 0x38000000) {
> +                uint32_t size_field =3D extract32(insn, 30, 2);
> +                bool is_vec =3D extract32(insn, 26, 1);
> +                uint32_t opc =3D extract32(insn, 22, 2);
> +                bool is_unsigned =3D extract32(insn, 24, 1);
> +                bool bit21 =3D extract32(insn, 21, 1);
> +                uint32_t rn =3D extract32(insn, 5, 5);
> +                uint32_t rt =3D extract32(insn, 0, 5);
> +                uint32_t sub_type =3D extract32(insn, 10, 2);
> +                bool is_reg =3D !is_unsigned && bit21;
> +
> +                /*
> +                 * [24]=3D0, [21]=3D1, [11:10]!=3D10 could be atomic =
ops
> +                 * (LDADD, SWP, CAS, etc.) -- not handled.
> +                 */
> +                if (is_reg && sub_type !=3D 2) {
> +                    goto isv0_inject_fault;
> +                }
> +
> +                bool writeback =3D !is_unsigned && !is_reg
> +                                 && (sub_type =3D=3D 1 || sub_type =3D=3D=
 3);
> +
> +                uint32_t esize;
> +                bool is_load;
> +                bool is_signed =3D false;
> +                uint32_t sign_extend_to =3D 0;
> +
> +                if (!is_vec) {
> +                    esize =3D 1u << size_field;
> +                    switch (opc) {
> +                    case 0: /* STR */
> +                        is_load =3D false;
> +                        break;
> +                    case 1: /* LDR */
> +                        is_load =3D true;
> +                        break;
> +                    case 2:
> +                        is_load =3D true;                      /* =
LDRS->64 */
> +                        is_signed =3D true;
> +                        sign_extend_to =3D 8;
> +                        break;
> +                    case 3:
> +                        if (size_field =3D=3D 3) {
> +                            /* PRFM -- prefetch is NOP on MMIO */
> +                            advance_pc =3D true;
> +                            goto isv0_done;
> +                        }
> +                        is_load =3D true;                      /* =
LDRS->32 */
> +                        is_signed =3D true;
> +                        sign_extend_to =3D 4;
> +                        break;
> +                    }
> +                } else {
> +                    /* SIMD/FP: size+opc determines element width */
> +                    is_load =3D (opc & 1);
> +                    if (opc >=3D 2 && size_field =3D=3D 0) {
> +                        esize =3D 16;  /* Q register (128-bit) */
> +                    } else if (opc < 2) {
> +                        esize =3D 1u << size_field;
> +                    } else {
> +                        goto isv0_inject_fault;
> +                    }
> +                }
> +
> +                if (is_load =3D=3D iswrite) {
> +                    error_report("HVF: ISV=3D0 LDR/STR load/write =
mismatch "
> +                                 "at ipa=3D0x%" PRIx64, ipa);
> +                    goto isv0_inject_fault;
> +                }
> +
> +                /* Perform memory access */
> +                if (!is_load) {
> +                    if (!is_vec) {
> +                        uint64_t val =3D hvf_get_reg(cpu, rt);
> +                        address_space_write(as, ipa,
> +                                            MEMTXATTRS_UNSPECIFIED,
> +                                            &val, esize);
> +                    } else {
> +                        address_space_write(as, ipa,
> +                                            MEMTXATTRS_UNSPECIFIED,
> +                                            &env->vfp.zregs[rt], =
esize);
> +                    }
> +                } else {
> +                    if (!is_vec) {
> +                        uint64_t val =3D 0;
> +                        address_space_read(as, ipa,
> +                                           MEMTXATTRS_UNSPECIFIED,
> +                                           &val, esize);
> +                        if (is_signed) {
> +                            switch (esize) {
> +                            case 1:
> +                                val =3D (int64_t)(int8_t)val;
> +                                break;
> +                            case 2:
> +                                val =3D (int64_t)(int16_t)val;
> +                                break;
> +                            case 4:
> +                                val =3D (int64_t)(int32_t)val;
> +                                break;
> +                            }
> +                            if (sign_extend_to =3D=3D 4) {
> +                                val &=3D 0xFFFFFFFF;
> +                            }
> +                        }
> +                        hvf_set_reg(cpu, rt, val);
> +                    } else {
> +                        /* SIMD/FP load */
> +                        memset(&env->vfp.zregs[rt], 0,
> +                               sizeof(env->vfp.zregs[rt]));
> +                        address_space_read(as, ipa,
> +                                           MEMTXATTRS_UNSPECIFIED,
> +                                           &env->vfp.zregs[rt], =
esize);
> +                        cpu->vcpu_dirty =3D true;
> +                    }
> +                }
> +
> +                /* Base register writeback (post/pre-indexed) */
> +                if (writeback) {
> +                    int32_t imm9 =3D sextract32(insn, 12, 9);
> +                    env->xregs[rn] =3D env->xregs[rn] + imm9;
> +                    cpu->vcpu_dirty =3D true;
> +                }
> +
> +                advance_pc =3D true;
> +                goto isv0_done;
> +            }
> +
> +isv0_inject_fault:
> +            /*
> +             * Inject data abort into guest for unrecognized or
> +             * inconsistent ISV=3D0 instructions.  The guest kernel
> +             * will deliver SIGBUS to the faulting process.
> +             */
> +            {
> +                int target_el =3D 1;
> +                bool same_el =3D arm_current_el(env) =3D=3D =
target_el;
> +                uint32_t esr =3D syn_data_abort_no_iss(same_el,
> +                    /*fnv=3D*/1, /*ea=3D*/0, /*cm=3D*/0,
> +                    /*s1ptw=3D*/0, iswrite, /*fsc=3D*/0x10);
> +                env->exception.vaddress =3D ipa;
> +                hvf_raise_exception(cpu, EXCP_DATA_ABORT,
> +                                    esr, target_el);
> +            }
> +isv0_done:
> +            break;
> +        }
>=20
>         /*
>          * Emulate MMIO.
> --=20
> 2.52.0
>=20
>=20


