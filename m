Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244EBCD4F35
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMie6-0004XR-5Q; Tue, 12 May 2026 04:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wMie5-0004XD-1K; Tue, 12 May 2026 04:39:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wMidP-0002lB-Uq; Tue, 12 May 2026 04:39:16 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK75AO3187033; Tue, 12 May 2026 08:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5sxv/0
 Ch6PR0mG5AQ8JlBNTIDLRquw0yy14xGIrhaUo=; b=syMrMo26fTm+jZgrO/ZfA/
 w+ksIAm8KCLDMZ+8iM98SOjF8h9g2FCipqK09jKrd6+FipU4hVmwAiYYZiujYoq/
 nEya9HtEssyi+NPEMM1DtJgt4ncRGhqqI3b4ksd6OhoFNTHvoGYecFshbT8r9bGe
 wLKZJZnfM55CgYdgyZd8bbWdsLuzz5LrqmTHa9iuVuobKY2iufEMRsSmcdw2VnDU
 KyJuxfCI0UI4ollKOwBH1bEbUHoH+JqG/WniCqrnkycMnwl/zLXk3CsRwjkzEY+6
 t1Do6QhBqMWcVpRPD8icRWBZKbuZR1XrhageQuqAAExOdV+QycLhV/s3XtrSAKYA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5a69v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 08:38:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C8OOqj030234;
 Tue, 12 May 2026 08:38:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgjbcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 08:38:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64C8cKD029426324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 08:38:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EA0958055;
 Tue, 12 May 2026 08:38:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C5C358054;
 Tue, 12 May 2026 08:38:17 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 May 2026 08:38:16 +0000 (GMT)
Message-ID: <75769ad1-5aab-48da-9dd7-7646d50b24bf@linux.ibm.com>
Date: Tue, 12 May 2026 14:08:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/ppc/kvm: Fix const violation when trimming CPU
 alias suffix
Content-Language: en-GB
To: Vaibhav Jain <vaibhav@linux.ibm.com>, qemu-devel@nongnu.org,
 kvm-ppc@vger.kernel.org, qemu-ppc@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shivaprasad G Bhat
 <sbhat@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>
References: <20260511131018.102168-1-vaibhav@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260511131018.102168-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a02e6fe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Qj0HYR67M3tMq7YF4SsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Rzmuu_Onr7BMyxuE7m1L7Pzskp7sUWyK
X-Proofpoint-GUID: Rzmuu_Onr7BMyxuE7m1L7Pzskp7sUWyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA4NiBTYWx0ZWRfX+yzViU6imD/s
 im05NWOauvS0OU2S5oJTcL9ZBDnh+NuKyj+dXoLSGsTiIn7wlIjfERcOFhjYztTajMKedfWR1zf
 yjaA5JcDzwUZ+Nbzos6c2fIZVMSRBEArBflEyFv4WJWf+e24fJXjs53KrEzJlqlPK/anzBnAMBo
 uJiif6lu+EDqJzmipi00dGIw0hRAIdodBsNIpb5l/EeXpVnxfRilQaF+BV+4OIJ/RXaAULiyus5
 7fXsmOk9fJ2kSl0HCY9PBQQ2w8Wbdg89mEIHA9kPiq3PrmUwogCaHNyqqVyZlFHqgXCDE9FlrTg
 S5x+c2zQK8jif+U7PyXs+oe+pplh3hqVpBsgSfEu7Fxo+5m9x7TibWjogV6eD5WOflMvXFZon0x
 nhmaZOg1eRlXmPfrdmVuRf4/MqomJt9GYctw2i5grYmRJSHEmjdwfqbRxUoLgli7w/HH6qbOuA3
 x9002G9zX2dNdYhTUnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

Hi Vaibhav,

Thanks for taking a look ...

On 11/05/26 6:40 pm, Vaibhav Jain wrote:
> GCC 16 tightens diagnostics around const correctness and now correctly
> rejects attempts to modify strings referenced through const-qualified
> pointers. In kvm_ppc_register_host_cpu_type(), ppc_cpu_aliases[i].model
> is defined as const char *, but the code was using strstr() on it and
> then modifying the returned pointer in-place to strip
> POWERPC_CPU_TYPE_SUFFIX.
> 
> This results in a write through a pointer derived from const data,
> triggering a build failure with GCC 16:
> 
>    error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>          suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
>                 ^
> Fix this by copying only the needed suffix from the object class-name to
> 'ppc_cpu_aliases.model' using g_strdup and g_strndup, which maintains the
> constness of the allocated buffer assigned to 'ppc_cpu_aliases.model'
> member of the 'ppc_cpu_aliases' struct array.
> 
> The patch also adds error handling for possible memory allocation failure
> while calling g_str{n}dup functions so that the error is properly
> propogated back from kvm_arch_init().
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Signed-off-by: Vaibhav Jain (IBM) <vaibhav@linux.ibm.com>
> 
> ---
> Change-log:
> 
> v1->v2:
> https://lore.kernel.org/all/20260504134344.38958-1-amachhiw@linux.ibm.com
> * Avoid pointer aliasing
> * Handle memory allocation failure error
> ---
>   target/ppc/kvm.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 25c28ad089..42cd4f4fff 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -170,9 +170,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>   
>       cap_rpt_invalidate = kvm_vm_check_extension(s, KVM_CAP_PPC_RPT_INVALIDATE);
>       cap_ail_mode_3 = kvm_vm_check_extension(s, KVM_CAP_PPC_AIL_MODE_3);
> -    kvm_ppc_register_host_cpu_type();
>   
> -    return 0;
> +    return kvm_ppc_register_host_cpu_type();
>   }
>   
>   int kvm_arch_irqchip_create(KVMState *s)
> @@ -2654,14 +2653,17 @@ static int kvm_ppc_register_host_cpu_type(void)
>       dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
>       for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>           if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
> -            char *suffix;
> +            const gchar *suffix, *cname = object_class_get_name(oc);
> +
> +            suffix = g_strstr_len(cname, -1, POWERPC_CPU_TYPE_SUFFIX);
> +            ppc_cpu_aliases[i].model = unlikely(suffix) ?
> +                g_strndup(cname, suffix - cname) : g_strdup(cname);
>   
> -            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
> -            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
> -            if (suffix) {
> -                *suffix = 0;
> +            if (!ppc_cpu_aliases[i].model) {
> +                return -ENOMEM;

IIUC, g_strndup will abort the program in case of OOM eventually making
it a dead code. We may consider using g_try_strndup at all if needed.
Also, not sure if we really need unlikely() and a typecast may be needed 
for (suffix - cname).

However, can we keep OOM related changes in a separate patch and keep 
only GCC16 build breakage fix in this patch retaining the original patch 
authorship with delta changes attributed alongside respective SoB?

Thanks
Harsh

> +            } else {
> +                return 0;
>               }
> -            break;
>           }
>       }
>   


