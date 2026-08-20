Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B259BC5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8MB-00036y-T1; Thu, 20 Aug 2026 15:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wx8M3-000350-I4; Thu, 20 Aug 2026 15:23:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wx8M1-0006tE-Lj; Thu, 20 Aug 2026 15:23:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIVYNi1475187; Thu, 20 Aug 2026 19:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=esG1pk
 B67gpfr9xVCjc9GXD6pQIoQAvbS7TqbMB/Iwk=; b=EgeRksVMx5rkven3rBtEoZ
 Vs9E3sEZDDtX6/jWHZwkC4p9EXJ4RaDN2QW7I57e0rl23sxwbTHGE3iI49vqcCsy
 QLH8fPzYGP04IEn6v5XTsD+iWcdSE0FLt4aU8+X8K5tr8y8NsffCWl8688DZnsoj
 yENKieXK/U46NZ+pGsK6bMPBakU/KxEwV06TnkmiGoYOEUIi8qIxtXg1lMJuBFng
 QWoUb68jMuRIWtL0x/CRzUKn4yQKyEQpDJN3xpOp03alocowKXKO/nutWOkGD/9A
 5tGdLVRTYOUG+P13zJ5zUCi4LIIIg6XdaNcmZHkmKJLVI9868rnQjzQJo0I29IGg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0ckvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 19:23:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KJBINO008851;
 Thu, 20 Aug 2026 19:23:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yr5t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 19:23:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KJMLFv26542646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 19:22:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83FFF58056;
 Thu, 20 Aug 2026 19:23:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87CEC5803F;
 Thu, 20 Aug 2026 19:22:59 +0000 (GMT)
Received: from [9.61.78.161] (unknown [9.61.78.161])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 19:22:59 +0000 (GMT)
Message-ID: <7ab9d9a8-7a97-413a-8e10-7db17dd918ed@linux.ibm.com>
Date: Thu, 20 Aug 2026 15:22:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] target/s390x: Constify S390CPU for cpu_has_*()
 getters
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-6-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260820104730.25462-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QziXKDFapTgc1jB8NI3CBj0joWK_DyuT
X-Proofpoint-GUID: QziXKDFapTgc1jB8NI3CBj0joWK_DyuT
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a875417 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=DwDBe3OJ7H-l8F9KR2UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MyBTYWx0ZWRfX3a1GTAjvttc2
 MnP5KlYWGceNB0vs4SfatD56kXXC1BRn4ZZ8V5xiSoheklXwrHKSovv2ZyX19qxOiIBIZryXA6G
 hIbvDyut0CGK9CtXXRN7LkbDBQWdyG4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MyBTYWx0ZWRfXyX49TNIn6Rj9
 onIzGZLN3FUhO1rCaN/8/8OGZDEOmnZvLuUWgPAmCz7ANETn4+rUUPrkXhFOf1hj9OVZWO5UYSM
 1OwYJuZki2fOsRESkJFO8oSJnBUHM4+0FSdUjuE4VmhdscLqcw3Tk1ZvquYOptdXSSbb6hYv4kg
 lqo40zn7DnxAycaR8aFUTQPrFzMeLyfARNOp4T7jwIhgcFguAUgU3z1KVhudOg9PunHpmyTlQkA
 V6gRKEbKMvaLaOpa0uFIrq7adX0gstg8uEiY5/OvIMzpbbMKd+ZQ6dgHbFbTkgvZg4lCaL3Ymug
 X016pKGhdfhtyjiCcWkClTpq2uLz6B3d2DsXp47JMMql7UlvCJKfwFZG1Lsav4ugnZ82r+U7e8s
 L9rpZlEYoNpjCdXZvVuiZRsYfFH5qhSnBBD5ajyoqPvyACl/6FRi8CDzGaq+M0P+9Nop64BWWuR
 k+WrWoYo4/JDVe6ybxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1011 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200143
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 8/20/26 6:47 AM, Philippe Mathieu-Daudé wrote:
> Add the const qualifier to S390CPU when the argument
> is accessed without modification.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/s390x/cpu.h            |  2 +-
>   target/s390x/s390x-internal.h | 12 ++++++------
>   target/s390x/interrupt.c      | 22 +++++++++++-----------
>   3 files changed, 18 insertions(+), 18 deletions(-)

Acked-by: Eric Farman <farman@linux.ibm.com>

> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index f55b79ef8ac..998bbb0d7ff 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -854,7 +854,7 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
>       return 0;
>   }
>   #endif /* CONFIG_USER_ONLY */
> -static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
> +static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
>   {
>       return cpu->env.cpu_state;
>   }
> diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
> index 35d1e34ef4d..54b62808d83 100644
> --- a/target/s390x/s390x-internal.h
> +++ b/target/s390x/s390x-internal.h
> @@ -334,12 +334,12 @@ void cpu_inject_clock_comparator(S390CPU *cpu);
>   void cpu_inject_cpu_timer(S390CPU *cpu);
>   void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
>   int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr);
> -bool s390_cpu_has_io_int(S390CPU *cpu);
> -bool s390_cpu_has_ext_int(S390CPU *cpu);
> -bool s390_cpu_has_mcck_int(S390CPU *cpu);
> -bool s390_cpu_has_int(S390CPU *cpu);
> -bool s390_cpu_has_restart_int(S390CPU *cpu);
> -bool s390_cpu_has_stop_int(S390CPU *cpu);
> +bool s390_cpu_has_io_int(const S390CPU *cpu);
> +bool s390_cpu_has_ext_int(const S390CPU *cpu);
> +bool s390_cpu_has_mcck_int(const S390CPU *cpu);
> +bool s390_cpu_has_int(const S390CPU *cpu);
> +bool s390_cpu_has_restart_int(const S390CPU *cpu);
> +bool s390_cpu_has_stop_int(const S390CPU *cpu);
>   void cpu_inject_restart(S390CPU *cpu);
>   void cpu_inject_stop(S390CPU *cpu);
>   #endif /* CONFIG_USER_ONLY */
> diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
> index 1dca835c5d8..d7e3fd45e4b 100644
> --- a/target/s390x/interrupt.c
> +++ b/target/s390x/interrupt.c
> @@ -139,10 +139,10 @@ void s390_crw_mchk(void)
>       fsc->inject_crw_mchk(fs);
>   }
>   
> -bool s390_cpu_has_mcck_int(S390CPU *cpu)
> +bool s390_cpu_has_mcck_int(const S390CPU *cpu)
>   {
>       QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
> -    CPUS390XState *env = &cpu->env;
> +    const CPUS390XState *env = &cpu->env;
>   
>       if (!(env->psw.mask & PSW_MASK_MCHECK)) {
>           return false;
> @@ -157,10 +157,10 @@ bool s390_cpu_has_mcck_int(S390CPU *cpu)
>       return false;
>   }
>   
> -bool s390_cpu_has_ext_int(S390CPU *cpu)
> +bool s390_cpu_has_ext_int(const S390CPU *cpu)
>   {
>       QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
> -    CPUS390XState *env = &cpu->env;
> +    const CPUS390XState *env = &cpu->env;
>   
>       if (!(env->psw.mask & PSW_MASK_EXT)) {
>           return false;
> @@ -199,10 +199,10 @@ bool s390_cpu_has_ext_int(S390CPU *cpu)
>       return false;
>   }
>   
> -bool s390_cpu_has_io_int(S390CPU *cpu)
> +bool s390_cpu_has_io_int(const S390CPU *cpu)
>   {
>       QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
> -    CPUS390XState *env = &cpu->env;
> +    const CPUS390XState *env = &cpu->env;
>   
>       if (!(env->psw.mask & PSW_MASK_IO)) {
>           return false;
> @@ -211,21 +211,21 @@ bool s390_cpu_has_io_int(S390CPU *cpu)
>       return qemu_s390_flic_has_io(flic, env->cregs[6]);
>   }
>   
> -bool s390_cpu_has_restart_int(S390CPU *cpu)
> +bool s390_cpu_has_restart_int(const S390CPU *cpu)
>   {
> -    CPUS390XState *env = &cpu->env;
> +    const CPUS390XState *env = &cpu->env;
>   
>       return env->pending_int & INTERRUPT_RESTART;
>   }
>   
> -bool s390_cpu_has_stop_int(S390CPU *cpu)
> +bool s390_cpu_has_stop_int(const S390CPU *cpu)
>   {
> -    CPUS390XState *env = &cpu->env;
> +    const CPUS390XState *env = &cpu->env;
>   
>       return env->pending_int & INTERRUPT_STOP;
>   }
>   
> -bool s390_cpu_has_int(S390CPU *cpu)
> +bool s390_cpu_has_int(const S390CPU *cpu)
>   {
>       if (!tcg_enabled()) {
>           return false;


