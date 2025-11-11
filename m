Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7AECCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 08:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIjyQ-0002yb-JV; Tue, 11 Nov 2025 03:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vIjyM-0002wW-MB; Tue, 11 Nov 2025 03:43:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vIjyK-00006K-BF; Tue, 11 Nov 2025 03:43:30 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AANHwBZ021651;
 Tue, 11 Nov 2025 08:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/9e7mD
 ExVCJG7YkTy9C5bGqe53cHmn2lOof6JKyitmw=; b=chs4QoGSX2vPAiduUgOR82
 p+pbrPFwfl7qfSQ0xTh6mMcmZP36c8fVXHOifihQ4paGSwwSfLBIHBFElqWJ7bEg
 3YdTvtRH6pWPtBeMpi6dZaDFM1Ywdv988BMtGfZwDMipGHtlnLJ0frl73Orm2nJy
 2wpc8Qsd8iMIKtAUQdOLiCL7THyFn7sZAGJ2teElXAXrVOXoHx5SUyYaWVOYtjKg
 uWLfcbZNI9SKcw8pr+C7xfMcxKXxHi/5zRDfKqttlwxRpNs5VOsfNz2pkULJsyHm
 NmudO5+TogP9Rrq3++Hdjj3EMWL+gtIO3pJJKcnkeV2mTzwQecB7nQuUqoLYcD3A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjsyqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 08:43:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5FD2Z007309;
 Tue, 11 Nov 2025 08:43:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdj9pfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 08:43:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AB8hHJD40894850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 08:43:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 756232004B;
 Tue, 11 Nov 2025 08:43:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E83820043;
 Tue, 11 Nov 2025 08:43:17 +0000 (GMT)
Received: from [9.155.199.94] (unknown [9.155.199.94])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Nov 2025 08:43:17 +0000 (GMT)
Message-ID: <2347cd4a-dc40-410a-89f0-9c7b261cff29@linux.ibm.com>
Date: Tue, 11 Nov 2025 09:43:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: Nicholas Miehlbradt <nicholas@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 pasic@linux.ibm.com, farman@linux.ibm.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20250429052021.10789-1-nicholas@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rV5ix-Yi7lE2G4U12xootKBaMsXEWFO2
X-Proofpoint-ORIG-GUID: rV5ix-Yi7lE2G4U12xootKBaMsXEWFO2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX5c7k/tsvK4oo
 Li01IgQlpkUKh89NWkYKjtOP9bz1+pwI5K0hzwH5+e64j8CmMu3exHJR8djF0TRWdko6swAUYx+
 18J1vkO3UDTELOh9QrGNwamMZsEEbiEl+zLxtsEdBnmpK65lij1gpU2RzXMKXjIRtveRjzLGqbY
 jK0hBYUp6aDbY4hQa3i8KWbQtIPL+LpuLBQbhBC1urNespeIFTnBTvl0qI1zIXWO3CbbTc8Jk8D
 zyVVrbHN3N9s7hPK5UWfF6uTMAzpjP6HWl+aTJjf455G2VUwU4c3AEJNP4zKiZEjyv5rRSaQ6pI
 0kZl43AyB4ocs9W2tsZk9ceKctrTffweKMRB58hb0khA4yPvQ/G1LAGvPZk2aF2bwMM421Vd8LQ
 aC49WszwewGLIGkyVXnDm49HIiD8hw==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=6912f72a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=cmxpyTkTEHtOj86fWsoA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Am 29.04.25 um 07:20 schrieb Nicholas Miehlbradt:
> The reset performed by subcode 3 of the diag308 instruction specifies
> that system memory should be reset. This patch implements that
> behaviour.
> 
> Introduce S390_RESET_REIPL_CLEAR to differentiate between subcode 3 and
> subcode 4 resets.
> 
> When doing a clear reset, discard the ramblock containing the system
> ram.
> 
> Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
> ---
>   hw/s390x/ipl.h             | 1 +
>   hw/s390x/s390-virtio-ccw.c | 6 ++++++
>   target/s390x/diag.c        | 3 +--
>   target/s390x/kvm/kvm.c     | 6 +++++-
>   4 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index cb55101f06..9c38946363 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -38,6 +38,7 @@ enum s390_reset {
>       /* default is a reset not triggered by a CPU e.g. issued by QMP */
>       S390_RESET_EXTERNAL = 0,
>       S390_RESET_REIPL,
> +    S390_RESET_REIPL_CLEAR,
>       S390_RESET_MODIFIED_CLEAR,
>       S390_RESET_LOAD_NORMAL,
>       S390_RESET_PV,
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 94edd42dd2..bc07158b16 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -455,6 +455,7 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
>       enum s390_reset reset_type;
>       CPUState *cs, *t;
>       S390CPU *cpu;
> +    RAMBlock *rb = machine->ram->ram_block;
>   
>       /*
>        * Temporarily drop the record/replay mutex to let rr_cpu_thread_fn()
> @@ -479,6 +480,7 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
>       switch (reset_type) {
>       case S390_RESET_EXTERNAL:
>       case S390_RESET_REIPL:
> +    case S390_RESET_REIPL_CLEAR:
>           /*
>            * Reset the subsystem which includes a AP reset. If a PV
>            * guest had APQNs attached the AP reset is a prerequisite to
> @@ -489,6 +491,10 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
>               s390_machine_unprotect(ms);
>           }
>   
> +        if (reset_type == S390_RESET_REIPL_CLEAR) {
> +            ram_block_discard_range(rb, 0 , qemu_ram_get_used_length(rb));
> +        }
> +
>           /*
>            * Device reset includes CPU clear resets so this has to be
>            * done AFTER the unprotect call above.
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index da44b0133e..cff9fbc4b0 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -105,8 +105,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>           s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
>           break;      case DIAG308_LOAD_CLEAR:
> -        /* Well we still lack the clearing bit... */
> -        s390_ipl_reset_request(cs, S390_RESET_REIPL);
> +        s390_ipl_reset_request(cs, S390_RESET_REIPL_CLEAR);
>           break;
>       case DIAG308_SET:
>       case DIAG308_PV_SET:
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index b9f1422197..f2d5f7ddc0 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -1915,7 +1915,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>               ret = handle_intercept(cpu);
>               break;
>           case KVM_EXIT_S390_RESET:
> -            s390_ipl_reset_request(cs, S390_RESET_REIPL);
> +            if (run->s390_reset_flags & KVM_S390_RESET_CLEAR) {
> +                s390_ipl_reset_request(cs, S390_RESET_REIPL_CLEAR);
> +            } else {
> +                s390_ipl_reset_request(cs, S390_RESET_REIPL);
> +            }
>               break;
>           case KVM_EXIT_S390_TSCH:
>               ret = handle_tsch(cpu);



Do I see that right that this patch never made it into qemu master? IIRC Matt has clarified all concerns?

