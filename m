Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB767F36C2A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 06:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEiPK-0007h7-AZ; Mon, 20 Apr 2026 02:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wEiPD-0007bR-61; Mon, 20 Apr 2026 02:46:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wEiPB-0007t0-4F; Mon, 20 Apr 2026 02:46:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JMxEb13987518; Mon, 20 Apr 2026 06:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Wx3Ub5
 lvRpcKiudQnvj9T2ITXyP0gYhnoOcJpHR3rwA=; b=qN7fE3YRkZl+CZewlVmmj7
 /GWZSD2Q6mOY4YWWio59QT+gQtyK2zHI9a35H4P/WItgP9Ngz9bHoIPOcDEGlqGe
 K2sP0rrbmjn4OUjUcUpZ/48C3dEEXD8VkOX4fvf4BtlnundfuIbqu2xFYcSpRmRK
 G/+RNlqgUCvdac/udKL2nE8Pa/+GU8dnHPdsv3a+Wt/oNlAp8gWEqSf4zPDISa8f
 xflIgtfq7966bRIpw4TAB3TP6w0VqfhAr7S4lFbeTQzdonJDdEZbBApqEB5CshYS
 7kSmP9NEIXMSgoAkhILyQU8YZmm84W6Y2n4/mn7lhXBVmnFfHfZqQcDi7ZS/N1Vg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k0nvdq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 06:46:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K6ZOR3020695;
 Mon, 20 Apr 2026 06:46:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg3j1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 06:46:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63K6kbBJ29688402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Apr 2026 06:46:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4125B58054;
 Mon, 20 Apr 2026 06:46:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B425758050;
 Mon, 20 Apr 2026 06:46:33 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Apr 2026 06:46:33 +0000 (GMT)
Message-ID: <09352eea-3794-42c2-becc-b5c7dbd37732@linux.ibm.com>
Date: Mon, 20 Apr 2026 12:16:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] target/ppc: Factor common ppc_load_epr() helper out
Content-Language: en-GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20260319111936.68041-1-philmd@linaro.org>
 <20260319111936.68041-3-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260319111936.68041-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: D0aTPj8iCrIVmuZCumGDaI9z7ny-fqPR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA1OSBTYWx0ZWRfX/xYVP93Nl13O
 VxcqJrpGJ/eRQGa1zrSmNojt0DwdAnJt3k1WRNTyqulBkAFdJukguvXFWk6tybqlUt831fOgg1Z
 hMK4ykWZtLsbOsfWbUmHDPQlFSjzqdwxQ40yD52sJEmMwkqdVB1deH26JuOg8VJrNHQmLMOrGtx
 dtX/dURwuz/i1RbZ58R/smVC4wJvpwEU/btfTBQHo++LtL8Cx3UN7pcR0NL0mqvAts9PPWaxjJb
 c1iIhrqUZUqUUIziJ4ptU8xm/N73HEJGemYAgDz9/7lATCVJSmWHvLD/TLNMPMjxIQkY8oSFU6Q
 Epoi06ouGv90rPir1+QYfws2sdBvXls0ClwsghHnaG+I3qxIRBGO3keI/Di9Lq5jBYELR2NZP5l
 Ww3oUBAogjtdkEaS1yst3w0H8w0HPoeX0LqBV2uSpd129aedYG0pK7ZxsnQ1oIJhLnqOpIQAIDm
 Oj1baEg7PPRzJieEfYA==
X-Authority-Analysis: v=2.4 cv=PtujqQM3 c=1 sm=1 tr=0 ts=69e5cbcf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=LBd1l7Yb-2XZM44x8U0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: sBzfiEJnuLe6gGEQbkRdi8wRpRlLWOeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200059
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 19/03/26 4:49 pm, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu.h         | 2 ++
>   target/ppc/cpu.c         | 8 ++++++++
>   target/ppc/excp_helper.c | 3 +--
>   target/ppc/kvm.c         | 2 +-
>   4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index d637a50798f..e3e4bce91b7 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2822,6 +2822,8 @@ enum {
>   target_ulong cpu_read_xer(const CPUPPCState *env);
>   void cpu_write_xer(CPUPPCState *env, target_ulong xer);
>   
> +uint64_t ppc_load_epr(CPUPPCState *env);
> +

This declaration is added unconditionally, although its implementation 
in target/ppc/cpu.c is placed inside #if !defined(CONFIG_USER_ONLY).
Should we guard the declaration also?

Otherwise, LTGM.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   /*
>    * All 64-bit server processors compliant with arch 2.x, ie. 970 and newer,
>    * have PPC_SEGMENT_64B.
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index 4d8faaddee2..f24801a9731 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -26,6 +26,7 @@
>   #include "fpu/softfloat-helpers.h"
>   #include "mmu-hash64.h"
>   #include "helper_regs.h"
> +#include "system/memory.h"
>   #include "system/tcg.h"
>   
>   target_ulong cpu_read_xer(const CPUPPCState *env)
> @@ -105,6 +106,13 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>       ppc_maybe_interrupt(env);
>   }
>   
> +uint64_t ppc_load_epr(CPUPPCState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +
> +    return ldl_phys(cs->as, env->mpic_iack);
> +}
> +
>   #if defined(TARGET_PPC64)
>   void ppc_update_ciabr(CPUPPCState *env)
>   {
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 6d05b865058..3b476c145ab 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1166,9 +1166,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>           break;
>       case POWERPC_EXCP_EXTERNAL:  /* External input                           */
>           if (env->mpic_proxy) {
> -            CPUState *cs = env_cpu(env);
>               /* IACK the IRQ on delivery */
> -            env->spr[SPR_BOOKE_EPR] = ldl_phys(cs->as, env->mpic_iack);
> +            env->spr[SPR_BOOKE_EPR] = ppc_load_epr(env);
>           }
>           break;
>       case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 41bd03ec2a2..3bff75b7f54 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1692,7 +1692,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>   #endif
>       case KVM_EXIT_EPR:
>           trace_kvm_handle_epr();
> -        run->epr.epr = ldl_phys(cs->as, env->mpic_iack);
> +        run->epr.epr = ppc_load_epr(env);
>           ret = 0;
>           break;
>       case KVM_EXIT_WATCHDOG:


