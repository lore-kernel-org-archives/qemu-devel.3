Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0993CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKvQ-0003KR-KT; Thu, 18 Sep 2025 16:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzKvH-0003Ik-1T; Thu, 18 Sep 2025 16:08:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzKux-0000op-Q7; Thu, 18 Sep 2025 16:08:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFOR2h000352;
 Thu, 18 Sep 2025 20:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JaYtym
 H1/RsLo4L9kxb1a0utyzK29ZuhycACYGm/3Xo=; b=j8cdllXtD3OFDwMLgt3UW7
 0ft4eeT0PHFhs6eau5HnWeMHoQy5AF3XD+X5A0/7dcuEFiSNncO+H2B1sWcK7bdF
 T0fwyDEGUrJRggbnPm8EBYlVbM5Ns9vlQfYlMTOhWQTbbXinwqS9tPcf5KBeDJBj
 QHDc7WBDjlEFg+J7FNpw5kgD4qpus/+kRaBX0fC/3wHE8+bzET8pD9WOWR+xdvRR
 +0NhAoYfysfptSx9UIMlbNpjSjHqWw9HQMTdKJ2sa6/LQGWLpZl3c2HiAmfuIPtj
 osYaDmcGRkpCSKWiIiodKzcFCOwq1zP9osXBeQgECxL8JCH1yTa8jMnysN0vXhBQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hvjj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 20:07:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IHcvSI018649;
 Thu, 18 Sep 2025 20:07:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mrc20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 20:07:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58IK7Wpa19268140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 20:07:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BAB158050;
 Thu, 18 Sep 2025 20:07:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95A7958045;
 Thu, 18 Sep 2025 20:07:40 +0000 (GMT)
Received: from [9.61.251.145] (unknown [9.61.251.145])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 20:07:40 +0000 (GMT)
Message-ID: <18cbd241-0ea4-44c6-a0b4-fb15e8dfe7e7@linux.ibm.com>
Date: Thu, 18 Sep 2025 13:07:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/28] s390x/diag: Introduce DIAG 320 for Certificate
 Store Facility
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-6-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-6-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ORPh8WpCswKtok14qzov0jgN7K2hGsuU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX2Xc4ESQ7i1zE
 XOsmtihSIn3UniqOuu4e3XjJ3RxQYGde/uuLIFYylfgiNsJhMQg8SlF+qmUnFfCjKtzcEzG7Tg7
 7Bj+1CTkLt+LJaOO8NNFfJt0iJOEolK8vVz8rtUNv+WTeqGFINMzM91MVbtrzH7t4Ux/2bXWz+a
 laaqHPUEVU8fufKHU8Fmaw0cs7I0/pLb2SyXV7lCfZyCU5yJGvXWxK3obnqDKbitmCB+pJSgsBL
 Rh+lg8jG99wpo5oM6+2QYPpimTAPBuYCH6Y3/kQhipJAYWP/6zYT8XIdGTif8MMyqxpDcxOSuFg
 uqJ8BBi4fRLoiEgDLR92A3A+qULiy/cRt6UdAekv6r5YxRjv3WXA4dDWP6r7P+tZehDapn5y8pM
 Ca8d/w7f
X-Proofpoint-GUID: ORPh8WpCswKtok14qzov0jgN7K2hGsuU
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cc6690 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=P4d8GkPxNutzi0EvIlMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
> DIAGNOSE 320 is introduced to support Certificate Store (CS)
> Facility, which includes operations such as query certificate
> storage information and provide certificates in the certificate
> store.
>
> Currently, only subcode 0 is supported with this patch, which is
> used to query the Installed Subcodes Mask (ISM).
>
> This subcode is only supported when the CS facility is enabled.
>
> Availability of CS facility is determined by byte 134 bit 5 of the
> SCLP Read Info block. Byte 134's facilities cannot be represented
> without the availability of the extended-length-SCCB, so add it as
> a check for consistency.
>
> Note: secure IPL is not available for Secure Execution (SE) guests,
> as their images are already integrity protected, and an additional
> protection of the kernel by secure IPL is not necessary.
>
> This feature is available starting with the gen16 CPU model.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst     | 12 ++++++++
>   include/hw/s390x/ipl/diag320.h      | 20 +++++++++++++
>   target/s390x/cpu_features.c         |  1 +
>   target/s390x/cpu_features_def.h.inc |  1 +
>   target/s390x/cpu_models.c           |  2 ++
>   target/s390x/diag.c                 | 44 +++++++++++++++++++++++++++++
>   target/s390x/gen-features.c         |  3 ++
>   target/s390x/kvm/kvm.c              | 16 +++++++++++
>   target/s390x/s390x-internal.h       |  2 ++
>   target/s390x/tcg/misc_helper.c      |  7 +++++
>   10 files changed, 108 insertions(+)
>   create mode 100644 include/hw/s390x/ipl/diag320.h
>
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 9b1de5c604..30ddc81c2b 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -13,3 +13,15 @@ will keep track of the number of certificates, their respective size,
>   and a summation of the sizes.
>   
>   Note: A maximum of 64 certificates are allowed to be stored in the certificate store.
> +
> +DIAGNOSE function code 'X'320' - Certificate Store Facility
> +-----------------------------------------------------------
> +
> +DIAGNOSE 'X'320' is used to provide support for userspace to directly
> +query the s390 certificate store. Userspace may be the s390-ccw BIOS or
> +the guest kernel.
> +
> +Subcode 0 - query installed subcodes
> +    Returns a 256-bit installed subcodes mask (ISM) stored in the installed
> +    subcodes block (ISB). This mask indicates which sucodes are currently
> +    installed and available for use.
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> new file mode 100644
> index 0000000000..aa04b699c6
> --- /dev/null
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -0,0 +1,20 @@
> +/*
> + * S/390 DIAGNOSE 320 definitions and structures
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef S390X_DIAG320_H
> +#define S390X_DIAG320_H
> +
> +#define DIAG_320_SUBC_QUERY_ISM     0
> +
> +#define DIAG_320_RC_OK              0x0001
> +#define DIAG_320_RC_NOT_SUPPORTED   0x0102
> +
> +#define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
> +
> +#endif
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 4b5be6798e..436471f4b4 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -147,6 +147,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>           break;
>       case S390_FEAT_TYPE_SCLP_FAC134:
>           clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
> +        clear_be_bit(s390_feat_def(S390_FEAT_CERT_STORE)->bit, data);
>           break;
>       default:
>           return;
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index c017bffcdc..941a69e013 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -138,6 +138,7 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
>   
>   /* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
>   DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
> +DEF_FEAT(CERT_STORE, "cstore", SCLP_FAC134, 5, "Provide Certificate Store functions")
>   
>   /* Features exposed via SCLP CPU info. */
>   DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 954a7a99a9..6b8471700e 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -248,6 +248,7 @@ bool s390_has_feat(S390Feat feat)
>       if (s390_is_pv()) {
>           switch (feat) {
>           case S390_FEAT_DIAG_318:
> +        case S390_FEAT_CERT_STORE:
>           case S390_FEAT_HPMA2:
>           case S390_FEAT_SIE_F2:
>           case S390_FEAT_SIE_SKEY:
> @@ -505,6 +506,7 @@ static void check_consistency(const S390CPUModel *model)
>           { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
>           { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
>           { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
> +        { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },
>           { S390_FEAT_NNPA, S390_FEAT_VECTOR },
>           { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
>           { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index cff9fbc4b0..a35d808fd7 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -18,6 +18,7 @@
>   #include "hw/watchdog/wdt_diag288.h"
>   #include "system/cpus.h"
>   #include "hw/s390x/ipl.h"
> +#include "hw/s390x/ipl/diag320.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
>   #include "system/kvm.h"
>   #include "kvm/kvm_s390x.h"
> @@ -191,3 +192,46 @@ out:
>           break;
>       }
>   }
> +
> +void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
> +{
> +    S390CPU *cpu = env_archcpu(env);
> +    uint64_t subcode = env->regs[r3];
> +    uint64_t addr = env->regs[r1];
> +
> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> +        return;
> +    }
> +
> +    if (!s390_has_feat(S390_FEAT_CERT_STORE)) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +
> +    if ((subcode & ~0x000ffULL) || (r1 & 1)) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +
> +    switch (subcode) {
> +    case DIAG_320_SUBC_QUERY_ISM:
> +        /*
> +         * The Installed Subcode Block (ISB) can be up 8 words in size,
> +         * but the current set of subcodes can fit within a single word
> +         * for now.
> +         */
> +        uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES);
> +
> +        if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
> +
> +        env->regs[r1 + 1] = DIAG_320_RC_OK;
> +        break;
> +    default:
> +        env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
> +        break;
> +    }
> +}
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 8218e6470e..6c20c3a862 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -720,6 +720,7 @@ static uint16_t full_GEN16_GA1[] = {
>       S390_FEAT_PAIE,
>       S390_FEAT_UV_FEAT_AP,
>       S390_FEAT_UV_FEAT_AP_INTR,
> +    S390_FEAT_CERT_STORE,
>   };
>   
>   static uint16_t full_GEN17_GA1[] = {
> @@ -919,6 +920,8 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KIMD_SHA_512,
>       S390_FEAT_KLMD_SHA_512,
>       S390_FEAT_PRNO_TRNG,
> +    S390_FEAT_EXTENDED_LENGTH_SCCB,
> +    S390_FEAT_CERT_STORE,
>   };
>   
>   /****** END FEATURE DEFS ******/
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 8ee33924df..5510fc2fc5 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -98,6 +98,7 @@
>   #define DIAG_TIMEREVENT                 0x288
>   #define DIAG_IPL                        0x308
>   #define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
> +#define DIAG_CERT_STORE                 0x320
>   #define DIAG_KVM_HYPERCALL              0x500
>   #define DIAG_KVM_BREAKPOINT             0x501
>   
> @@ -1560,6 +1561,16 @@ static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
>       }
>   }
>   
> +static void kvm_handle_diag_320(S390CPU *cpu, struct kvm_run *run)
> +{
> +    uint64_t r1, r3;
> +
> +    r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
> +    r3 = run->s390_sieic.ipa & 0x000f;
> +
> +    handle_diag_320(&cpu->env, r1, r3, RA_IGNORED);
> +}
> +
>   #define DIAG_KVM_CODE_MASK 0x000000000000ffff
>   
>   static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
> @@ -1590,6 +1601,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
>       case DIAG_KVM_BREAKPOINT:
>           r = handle_sw_breakpoint(cpu, run);
>           break;
> +    case DIAG_CERT_STORE:
> +        kvm_handle_diag_320(cpu, run);
> +        break;
>       default:
>           trace_kvm_insn_diag(func_code);
>           kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
> @@ -2490,6 +2504,8 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>           set_bit(S390_FEAT_DIAG_318, model->features);
>       }
>   
> +    set_bit(S390_FEAT_CERT_STORE, model->features);
> +
>       /* Test for Ultravisor features that influence secure guest behavior */
>       query_uv_feat_guest(model->features);
>   
> diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
> index 56cce2e7f5..ecff2d07a1 100644
> --- a/target/s390x/s390x-internal.h
> +++ b/target/s390x/s390x-internal.h
> @@ -391,6 +391,8 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
>   int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
>   void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
>                        uintptr_t ra);
> +void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3,
> +                     uintptr_t ra);
>   
>   
>   /* translate.c */
> diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
> index f7101be574..412c34ed93 100644
> --- a/target/s390x/tcg/misc_helper.c
> +++ b/target/s390x/tcg/misc_helper.c
> @@ -142,6 +142,13 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
>           /* time bomb (watchdog) */
>           r = handle_diag_288(env, r1, r3);
>           break;
> +    case 0x320:
> +        /* cert store */
> +        bql_lock();
> +        handle_diag_320(env, r1, r3, GETPC());
> +        bql_unlock();
> +        r = 0;
> +        break;
>       default:
>           r = -1;
>           break;

