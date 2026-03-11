Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22E6112584F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Lxd-0007Xn-W8; Wed, 11 Mar 2026 11:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LxW-0007XL-7q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:58:55 -0400
Received: from p-west2-cluster3-host12-snip4-4.eps.apple.com ([57.103.69.37]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LxT-00032C-8a
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:58:53 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPS id
 957ED1800491; Wed, 11 Mar 2026 15:58:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773244728; x=1775836728;
 bh=w+c6cOk8tA/H5cXDL8ZE+HdGU8gpruJsPMXJfLYwg58=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=FTCXaAcTABRGq/pfaP1AqenNniNVzYEwPqmQuViFLXiJwf93tpq5nMjBis6ZHWc8WhJpjn3eK27Nhnwi3XFNzxlu8KReOrscjPyIaWjdg5FNsYsaIcEyIgROXBWodl3iopEmLfsQTBibleRdJrV8mfu5/B3U1HPztyEjiPXx9k0N4bOk41nDikfUKAxjfTjky5x/Va7KXHwnvlVDSAztEI+PgLm0RLmf6KbTj0PAMKmtIM5oskTNU3mV3WnzExevn7OMNU3Pz5j3Hqg9HY3bwS/hRszP/F5pqyVeePiSbQMxZkpfhonMFwl1CAS0PX9KYBS4XuM0YPxxMOR70JCGKA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPSA id
 F419C1801164; Wed, 11 Mar 2026 15:58:40 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 11/14] target/arm/mshv: add vCPU run loop
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-11-c31699b7bc1f@anirudhrb.com>
Date: Wed, 11 Mar 2026 16:58:28 +0100
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DBA9B933-08E0-4599-AF36-AED339598F75@unpredictable.fr>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-11-c31699b7bc1f@anirudhrb.com>
To: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: SHNKLr6DaaVBWvuzHwbQjMznofW3Mjaw
X-Authority-Info-Out: v=2.4 cv=dK2rWeZb c=1 sm=1 tr=0 ts=69b19134
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tFGNSmrwAAAA:8 a=TIPGJ-2hCsdCqnleXSkA:9
 a=CjuIK1q_8ugA:10 a=LpD6Tdepsyerr7eS-Jg7:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzNSBTYWx0ZWRfX4UyEtaCnXeWt
 WeSXwTAEkzQIntQG4AkKRAulukckFGGxj3SH6PMPomfRifcjB7eWI+yScORqNqi6579S6D3mqYV
 OEHRrc0hjGS9SkEyUu5s5J+V4ibRmkc0md9SqbGa/8PZ7X7YV3f+QOIRBC3umApGl2aaeXMsdgf
 Al4eJI8iMuz3fSHdonzK/s7pV73RC26RrQCR+0kSU4QUSnnzge+INc1MUE88pSa5gl2MU0NLF8e
 XJx2IrHKypuwTckVVD6GYZmearivHjJDbfB1mCzzWM5Ej/o9PY/bWMgUfggwqKOQ9LURg6hXW7L
 S6nlOTasO08g0fyYxbjltfvvgDxwS0QhNsCiWT5EzhEyEJE++3/9ep91eyeNtQ=
X-Proofpoint-ORIG-GUID: SHNKLr6DaaVBWvuzHwbQjMznofW3Mjaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxscore=0
 phishscore=0 clxscore=1030 malwarescore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110135
X-JNJ: AAAAAAABuCmvTdsmKxiq854AMf6Di63+GmFREsIKyLVSnpMMDKEFQUyNm+hxIJlO5f84CeT6LgKvQ83GjW1UXeJbARYbHEHcAQvaVQQyZ5WyYLsyoHamh5HNJaCLr/lUupyjbqMe1ECiXz1Ol3s1deER7qKXiUIqxLE57RPzlkNyOqIuKtMs3kyB7SlVJtf14zf3UJbw27GLX+uRwaYquloPJQIDmgqweQeH6m5Ne1TP5CnFXWr2QHfb6fz8aKrVpReHJ6JD5FgbzxqqamcUWKnH6BfS76MdcyG9wBZwLWP19f7yGNpphlBBqCLtSEAkB/jmdF5oAPwX2nRLwKihfWcN4AYfoAtH6jJPmAQCnTwmMZkUgVRAM0V61VbFsc3ZG9M3sXyJuEMTqRXzNUoIV/lXM/9rM8MyBa0F39TA+hQ9LQXXW+taG9hHMwvP4pwIdi+vgjbVfZvYpbsO+4hSog9DW+BB8aJsYvTpRZLnzSklraj7kTfPyehnaxJhEAW56vE1kKwUkDRVHtbfxBgVPiZuAoGEEEtZ6hHCzAoJaKa/R1N+OIrbOuXNjsqOsX91nDKvtyteFf2xP/sjOjCTaj6qfqy51owdADgtoTN7xuFeNDLR4TFb0dfFFkZ2DfTT1dRx0ambDkG+7Vt2Eh7DDADPlk/WOyhdXpPFKrXlR285Zkapn0gSWNrnFWpSWeJ+hiaqP2lD92yWR3g950eVBp0VfkzclJvL1Ri884a2ymSlhmfDIbYKDtNsKtIYamT2ofE2z4gLow==
Received-SPF: pass client-ip=57.103.69.37;
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



> On 11. Mar 2026, at 16:15, Anirudh Rayabharam (Microsoft) =
<anirudh@anirudhrb.com> wrote:
>=20
> Add the main vCPU run loop for MSHV using the MSHV_RUN_VP_IOCTL.
>=20
> Handle MMIO exits by emulating the instruction using the syndrome
> information from ESR_EL2.
>=20
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
> include/hw/hyperv/hvgdk_mini.h |  44 +++++++++
> target/arm/mshv/mshv-all.c     | 198 =
+++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 242 insertions(+)
>=20
Hello,

GDK updates in separate patches from the rest please. Maybe even combine =
them together.

And more comments below...

> diff --git a/include/hw/hyperv/hvgdk_mini.h =
b/include/hw/hyperv/hvgdk_mini.h
> index d56be0d70f..84b3c6af5f 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -750,6 +750,50 @@ struct hv_x64_memory_intercept_message {
>     uint8_t instruction_bytes[16];
> };
>=20
> +union hv_arm64_vp_execution_state {
> +    uint16_t as_uint16;
> +    struct {
> +        uint16_t cpl:2;
> +        uint16_t debug_active:1;
> +        uint16_t interruption_pending:1;
> +        uint16_t vtl:4;
> +        uint16_t virtualization_fault_active:1;
> +        uint16_t reserved:7;
> +    };
> +};
> +
> +struct hv_arm64_intercept_message_header {
> +    uint32_t vp_index;
> +    uint8_t instruction_length;
> +    uint8_t intercept_access_type;
> +    union hv_arm64_vp_execution_state execution_state;
> +    uint64_t pc;
> +    uint64_t cpsr;
> +};
> +
> +union hv_arm64_memory_access_info {
> +    uint8_t as_uint8;
> +    struct {
> +        uint8_t gva_valid:1;
> +        uint8_t gva_gpa_valid:1;
> +        uint8_t hypercall_output_pending:1;
> +        uint8_t reserved:5;
> +    };
> +};
> +
> +struct hv_arm64_memory_intercept_message {
> +    struct hv_arm64_intercept_message_header header;
> +    uint32_t cache_type; /* enum hv_cache_type */
> +    uint8_t instruction_byte_count;
> +    union hv_arm64_memory_access_info memory_access_info;
> +    uint16_t reserved1;
> +    uint8_t instruction_bytes[4];
> +    uint32_t reserved2;
> +    uint64_t guest_virtual_address;
> +    uint64_t guest_physical_address;
> +    uint64_t syndrome;
> +};
> +
> union hv_message_flags {
>     uint8_t asu8;
>     struct {
> diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
> index 2b983845d3..b0649ba10b 100644
> --- a/target/arm/mshv/mshv-all.c
> +++ b/target/arm/mshv/mshv-all.c
> @@ -166,8 +166,206 @@ int mshv_arch_put_registers(const CPUState *cpu)
>     return 0;
> }
>=20
> +static int set_memory_info(const struct hyperv_message *msg,
> +                           struct hv_arm64_memory_intercept_message =
*info)
> +{
> +    if (msg->header.message_type !=3D HVMSG_GPA_INTERCEPT
> +            && msg->header.message_type !=3D HVMSG_UNMAPPED_GPA
> +            && msg->header.message_type !=3D HVMSG_UNACCEPTED_GPA) {
> +        error_report("invalid message type");
> +        return -1;
> +    }
> +    memcpy(info, msg->payload, sizeof(*info));
> +
> +    return 0;
> +}
> +
> +typedef union {
> +    uint64_t raw;
> +    struct {
> +        uint32_t iss:25;
> +        uint32_t il:1;
> +        uint32_t ec:6;
> +        uint32_t iss2:5;
> +        uint32_t _rsvd:27;
> +    } QEMU_PACKED;
> +} EsrEl2;
> +
> +typedef union {
> +    uint32_t raw;
> +    struct {
> +        uint32_t dfsc:6;
> +        uint32_t wnr:1;
> +        uint32_t s1ptw:1;
> +        uint32_t cm:1;
> +        uint32_t ea:1;
> +        uint32_t fnv:1;
> +        uint32_t set:2;
> +        uint32_t vncr:1;
> +        uint32_t ar:1;
> +        uint32_t sf:1;
> +        uint32_t srt:5;
> +        uint32_t sse:1;
> +        uint32_t sas:2;
> +        uint32_t isv:1;
> +        uint32_t _unused:7;
> +    } QEMU_PACKED;
> +} IssDataAbort;
Think this is better suited for common code somewhere...
> +
> +typedef enum {
> +    data_abort_lower =3D 36,
> +    data_abort =3D 37,
> +} ExceptionClass;
> +
> +int mshv_store_regs(CPUState *cpu)
> +{
> +    int ret;
> +
> +    ret =3D set_standard_regs(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to store standard registers");
> +        return -1;
> +    }
> +
> +    /* TODO: should store special registers? the equivalent hvf code =
doesn't */
WHPX does handle this via state levels, but what HVF does via a separate =
function is also workable.

> +    return 0;
> +}
> +
> +static int emulate_with_syndrome(CPUState *cpu,
> +                                 struct =
hv_arm64_memory_intercept_message *info)
> +{
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +    CPUARMState *env =3D &arm_cpu->env;
> +    int ret;
> +    EsrEl2 syndrome =3D { 0 };
> +    IssDataAbort iss =3D { 0 };
> +    uint64_t gpa =3D info->guest_physical_address;
> +    uint64_t len, reg_index;
> +    bool sign_extend;
> +
> +    syndrome.raw =3D info->syndrome;
> +
> +    if (!(syndrome.ec =3D=3D data_abort_lower || syndrome.ec =3D=3D =
data_abort)) {
> +        error_report("Unknown exception class 0x%x", syndrome.ec);
> +        return -1;
> +    }
> +
> +    iss.raw =3D syndrome.iss;
> +    if (!iss.isv) {
> +        error_report("Invalid ESR EL2 ISV field");
> +        return -1;
> +    }
> +
> +    len =3D 1ULL << iss.sas;
> +    sign_extend =3D iss.sse;
> +    reg_index =3D iss.srt;
> +
> +    ret =3D mshv_load_regs(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to load registers");
> +        return -1;
> +    }
> +
> +    if (iss.wnr) {
> +        uint8_t data[8];
> +        uint64_t val =3D reg_index < 31 ? env->xregs[reg_index] : =
0ULL;
> +
> +        val =3D cpu_to_le64(val);
> +
> +        memcpy(data, &val, sizeof(val));
> +        ret =3D mshv_guest_mem_write(gpa, data, len, false);
> +        if (ret < 0) {
> +            error_report("Failed to write guest memory");
> +            return -1;
> +        }
> +    } else {
> +        uint8_t data[8] =3D { 0 };
> +
> +        ret =3D mshv_guest_mem_read(gpa, data, len, false, false);
> +        if (ret < 0) {
> +            error_report("Failed to read guest memory");
> +            return -1;
> +        }
> +
> +        uint64_t val;
> +        memcpy(&val, data, sizeof(val));
> +
> +        val =3D le64_to_cpu(val);
> +
> +        if (sign_extend) {
> +            uint64_t shift =3D 64 - (len * 8);
> +            val =3D (((int64_t)val << shift) >> shift);
> +            if (!iss.sf) {
> +                val &=3D 0xffffffff;
> +            }
> +        }
> +
> +        env->xregs[reg_index] =3D val;
> +    }
> +
> +    env->pc +=3D (syndrome.il =3D=3D 1) ? 4 : 2;
> +
> +    ret =3D mshv_store_regs(cpu);
> +    if (ret < 0) {
> +        error_report("failed to store registers");
> +        return -1;
> +    }
> +
> +    return 0;
> +}

I think this deserves to go to common code somewhere at this point :)

> +
> +static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
> +                               const struct hyperv_message *msg,
> +                               MshvVmExit *exit_reason)
> +{
> +    struct hv_arm64_memory_intercept_message info =3D { 0 };
> +    int ret;
> +
> +    ret =3D set_memory_info(msg, &info);
> +    if (ret < 0) {
> +        error_report("failed to convert message to memory info");
> +        return -1;
> +    }
> +
> +    ret =3D emulate_with_syndrome(cpu, &info);
> +    if (ret < 0) {
> +        error_report("Failed to emulate with syndrome");
> +        return -1;
> +    }
> +
> +    *exit_reason =3D MshvVmExitIgnore;
> +
> +    return 0;
> +}
> +
> int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, =
MshvVmExit *exit)
> {
> +    int ret;
> +    int cpu_fd =3D mshv_vcpufd(cpu);
> +
> +    ret =3D ioctl(cpu_fd, MSHV_RUN_VP, msg);
> +    if (ret < 0) {
> +        *exit =3D MshvVmExitShutdown;
> +        return ret;
> +    }
> +
> +    switch (msg->header.message_type) {
> +    case HVMSG_UNRECOVERABLE_EXCEPTION:
> +        *exit =3D MshvVmExitShutdown;
> +        break;
> +    case HVMSG_UNMAPPED_GPA:
At least as observed on WHPX you also need to handle GpaIntercept the =
same way
for EDK2 to be happy
>=20
>=20
> +        ret =3D handle_unmapped_mem(vm_fd, cpu, msg, exit);
> +        if (ret < 0) {
> +            error_report("failed to handle mmio");
> +            return -1;
> +        }
> +        break;
> +    default:
> +        error_report("Unhandled message type: 0x%x", =
msg->header.message_type);
> +        return -1;
> +    }
> +
>     return 0;
> }
>=20
>=20
> --=20
> 2.43.0
>=20
>=20


