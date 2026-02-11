Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F242ECD6EE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 23:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqJko-0003Qq-GI; Wed, 11 Feb 2026 18:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqJkn-0003Qh-A7
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 18:36:17 -0500
Received: from ci-2001b-snip4-4.eps.apple.com ([57.103.91.17]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqJkk-00050t-UP
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 18:36:17 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPS id
 ACEA618003E9; Wed, 11 Feb 2026 23:36:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770852973; x=1773444973;
 bh=L/pCwHCjJcYy9VdRSDSYiJPtiBnVVnoktbevrtTLAW8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=OxF8BUPAK72ZBCRBSXeRZZf1YTfHJE548bRt3yBXO+K2hh49/t8tnsn7aB1B4tk8eDx3xDw/bnhCcRqRPoYSYcyA6wVODsQkdJ5KEuLyCsFEV2nlQALCKTqCk3XP0fLOKwAykoShPc73hEhvuGozoROiLj9LCjv+nBkE0w73Kut1dIMVWBEWiHi6DusSpk9tkfLuKK0lUkdoOHMvG4YMbSBS43EctCdg5KL6sYJg8vuREiOC7QpHpMJmrhg6ywUdweGxy2+0iC8O8svMLfFBMBRkZLZXRfVltW+RVkn67Iy7aPhqVodlG5nN0tAtLSzNDeU2moJ7iE2c/BjR3iM2BQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPSA id
 E8AF41800153; Wed, 11 Feb 2026 23:36:09 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 08/10] target/i386: query mshv accel for supported cpuids
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260211155410.203883-9-magnuskulke@linux.microsoft.com>
Date: Thu, 12 Feb 2026 00:35:57 +0100
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <28261EA8-97DB-400F-A85C-4066A1AC425A@unpredictable.fr>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-9-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE4MyBTYWx0ZWRfX1yFuVDzEllsB
 giOOeTv6Krm5N2loieOZcDwmOi7tl6Gn0naBFDVmQvWC/NRpgjmbsRpTgzKBS4infYCQ+JxUleE
 6sOySvf0Gfa5NLZjg7j2WkTyeZqPcViN+o6zz6joRxFVdyrAF3fNpaQ7V+eUa/13GIBTEM9QHA/
 EDy9IFDe9wxuPN7NBsHWXTanrq4FSg66EIzIyxfOgK6WSmKZGf/HgtdeJb1sWjrsm6L+2KRSD7c
 RIGchxcVUQe2MzaofYuZQ426xTyhJjd3P0d8Dw2G6MW03aAygWkAsGADQYFCmXaxWYuksSZPpul
 VU8FJEqh6PcZ2k5+X3WQXZTAXdLWhIxNVV9Ywh93F4j8s/gQfW+/MCJdmSPpV4=
X-Proofpoint-ORIG-GUID: yXkIP3FI5TB2ikto89pRjIUSIAwe_Th8
X-Authority-Info-Out: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=698d126c
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=yMhMjlubAAAA:8 a=fLMWlKUBUD3eFdo45lYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yXkIP3FI5TB2ikto89pRjIUSIAwe_Th8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1030 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110183
X-JNJ: AAAAAAABqlM3TjW8kaIJS5Dqjciepoar6lDXGSzGPVutO9RVHYska2Bqg7tbAZkF6sJEnB2vrIl3zr8nJ4D8Hr/4bmssYHJN/ReApkl3QPJTvdK9p1NUdIWNRIwJmU1W/miuVsqKLYxQtS57hDtbieQshMiA9qLAaVMCfY6JPi6gcTcdqJm6cPXnZIxzLzteqbgSNmj5uZftwbz4YBMnRpZT9ft1WOjI0xl5BdQIW9EBuQ9Sftu+uay77hLJGIRG5mm7tRid6iLfupGl8QAloIiR+iFoBPbLVLaI4SbxIbF5uYC/SJc9Luxl3Wgecgux5BHCCzIhdP/RwUd9Nhyj69e2tf/JPgFVrerbMIRVkM5RpOaDxu55Sql7JN/n1xJ1VJHKIlXpaqsXQh/H2E1qN0tanJmv/LmoE1qxIA2TRW3e8Gv3bS4fvA1Dmw6TeK1Z+aHORu7pgualQMtxW/GkBb+RJdCEg79Bn2sUPdx/Idk9qIA2hvdK+TK+xbCTT1owj5xKrZVwt3CwbZHcR3wDeGTsCZmTNZjI+HMCTZbmtHZOElBUU2QIs55kFcZlLLgoEMf8Dpzwa1Ib4fwwRioPHfwnLCVXfGeJk4MzmO9iwCv9zKAVwbh7eBmKQicoGxarQ1CG/QOAHAx5tRKaqkoHxivhSXO3bSV2Vo1NMUkO8BbDT8XdV7wBHpN15+gdPQ==
Received-SPF: pass client-ip=57.103.91.17;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 11. Feb 2026, at 16:54, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> We implement mshv_get_supported_cpuid() and invoke it in
> x86_cpu_get_supported_feature_word() retrieve the cpu features that =
the
> host is supporting. Initially we mask the virtualization =
capabilitities
> potentially we might need to mask more in the future.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Hi,

Interesting. For WHPX on Arm, what=E2=80=99s done is creating a stub =
partition and extract CPUID info from
it (with necessary guest stub code if necessary) but doing it this way =
like HVF x86 does is intriguing too=E2=80=A6

Is this future-proof or are there catches with this approach?

Thank you,
> ---
> include/system/mshv.h       |  3 +++
> target/i386/cpu.c           |  8 ++++++++
> target/i386/mshv/mshv-cpu.c | 27 +++++++++++++++++++++++++++
> 3 files changed, 38 insertions(+)
>=20
> diff --git a/include/system/mshv.h b/include/system/mshv.h
> index 75286baf16..51b0420735 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -60,4 +60,7 @@ int mshv_irqchip_add_irqfd_notifier_gsi(const =
EventNotifier *n,
>                                         const EventNotifier *rn, int =
virq);
> int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int =
virq);
>=20
> +/* cpuid */
> +uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int =
reg);
> +
> #endif
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0a7b884528..b611afc21a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -26,6 +26,7 @@
> #include "tcg/helper-tcg.h"
> #include "exec/translation-block.h"
> #include "system/hvf.h"
> +#include "system/mshv.h"
> #include "hvf/hvf-i386.h"
> #include "kvm/kvm_i386.h"
> #include "kvm/tdx.h"
> @@ -7958,6 +7959,13 @@ uint64_t =
x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
>         r =3D hvf_get_supported_cpuid(wi->cpuid.eax,
>                                     wi->cpuid.ecx,
>                                     wi->cpuid.reg);
> +     } else if (mshv_enabled()) {
> +        if (wi->type !=3D CPUID_FEATURE_WORD) {
> +            return 0;
> +        }
> +        r =3D mshv_get_supported_cpuid(wi->cpuid.eax,
> +                                     wi->cpuid.ecx,
> +                                     wi->cpuid.reg);
>     } else if (tcg_enabled()) {
>         r =3D wi->tcg_features;
>     } else {
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 38e0a045c2..bbb58461a4 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1757,6 +1757,33 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
>     g_clear_pointer(&env->emu_mmio_buf, g_free);
> }
>=20
> +uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int =
reg)
> +{
> +    uint32_t eax, ebx, ecx, edx;
> +    uint32_t ret =3D 0;
> +
> +    host_cpuid(func, idx, &eax, &ebx, &ecx, &edx);
> +    switch (reg) {
> +    case R_EAX:
> +        ret =3D eax; break;
> +    case R_EBX:
> +        ret =3D ebx; break;
> +    case R_ECX:
> +        ret =3D ecx; break;
> +    case R_EDX:
> +        ret =3D edx; break;
> +    }
> +
> +    /* Disable nested virtualization features not yet supported by =
MSHV */
> +    if (func =3D=3D 0x80000001 && reg =3D=3D R_ECX) {
> +        ret &=3D ~CPUID_EXT3_SVM;
> +    }
> +    if (func =3D=3D 0x01       && reg =3D=3D R_ECX) {
> +        ret &=3D ~CPUID_EXT_VMX;
> +    }
> +    return ret;
> +}
> +
> /*
>  * Default Microsoft Hypervisor behavior for unimplemented MSR is to =
send a
>  * fault to the guest if it tries to access it. It is possible to =
override
> --=20
> 2.34.1
>=20
>=20


