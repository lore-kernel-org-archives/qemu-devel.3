Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B627ECD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOwr-000853-Iu; Fri, 08 May 2026 13:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wLOwp-00084a-Jp; Fri, 08 May 2026 13:25:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wLOwn-0003sF-LJ; Fri, 08 May 2026 13:25:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6486X1JP1080687; Fri, 8 May 2026 17:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UyawY6
 28E7httD8nCA9bSF+6mqtcB6hqhW/mWrzh4CM=; b=baUoxwfD3MR8WAMxTHu/RY
 QTUl/wbP2uwIMl5toUHBmujgquwhMRjcmGqcw7o9tC66oX0dRD1LZhHWguPfRppx
 jmKOkLSzyPZJRiTYCgglBFkdeBfM+yf12NU2t9i0iZee4tA5K/iAkqbQpYdlIt5+
 hSIwhiDv1tS/9NWwtkLRfKjqwiFRJvXnfYY8S/PAsnWunJmBp+sy/WKWxJQ8npFp
 aBpqkZ2pqaPArLLB9VDlLgKj6Q4SJlIgFZqBI3fB8KQpzRSIKvf9cEMSI1tSc+Mg
 5JlNUhIWIkm4aTteDLrTM5IcBTeW+6i22JeYYasqbQSMixM330D9ijjqpo3qytVg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1vsxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 17:25:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648HOm6L001067;
 Fri, 8 May 2026 17:25:06 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywh9nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 17:25:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648HP31917498848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 17:25:03 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEC4358066;
 Fri,  8 May 2026 17:25:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5067F58063;
 Fri,  8 May 2026 17:25:00 +0000 (GMT)
Received: from [9.124.210.81] (unknown [9.124.210.81])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 17:24:59 +0000 (GMT)
Message-ID: <776218d1-c2e2-4c6a-a43c-432027d1958a@linux.ibm.com>
Date: Fri, 8 May 2026 22:54:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: Skip system reset for quiesced CPUs
Content-Language: en-GB
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
References: <20260430085409.680930-1-shivangu@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260430085409.680930-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n2j1AYoKTT7uqy-GM3tCIfvSmjGZFi2A
X-Proofpoint-GUID: n2j1AYoKTT7uqy-GM3tCIfvSmjGZFi2A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE3MSBTYWx0ZWRfX+Ybz4zHXhnSG
 6Ah2/2W/+09GVy3mTpFKiI1iKedwKOFhjS4KXa6iiCFjP/XWVaTcMLt3DFrDeg1FA0V66cXfj7k
 yEJuldAXssPshEC9jSNb0CXuMriBFetvDZXJ7JE70Olh6lkZO0CpvJFZnCq1QwC9pmYRlLkbW/f
 T1dTnOV//MZTWaDJvH19Fv1IwzcX8hNiSw58SgbBEcGO8mm9Yg31hRWWHvwrFN5CerkLwlRdsrh
 VL84OXFTgEMyZrasCNsKCGo0dudug3B2T9AOBe4NiZq3QNW5cbrO1Y09cKkADO5ADA+K+Jwv4gv
 YeglJB2XLocevdk4dvLYvtBQtZC9q0JhC6Gb8LR+i1Lt1PMTf3E9IdTclF+FSk3P7OrRptuRv4M
 r9uRLKUJuEnIO3J0uY1zOOp6Gepgp5OAvgQTOjlGRp00Fd4SpFgX3waSRz5tmpjv+zZpRVoB+8B
 Cp66BPsXYds23td45gA==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fe1c73 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=sVcIqltJxjcIs10R69MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080171
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



On 30/04/26 2:24 pm, Shivang Upadhyay wrote:
> During DLPAR CPU hotplug, newly added CPUs start in RTAS stopped state
> (quiesced). If a kexec crash occurs before the guest starts these CPUs
> via start-cpu RTAS call, H_SIGNAL_SYS_RESET_ALL_OTHERS will reset them
> anyway, causing the kdump kernel to hang:
> 
>    [    5.519483][    T1] Processor 0 is stuck.
>    [   11.089481][    T1] Processor 1 is stuck.
> 
> The hypervisor should only reset CPUs that the guest has started. The
> cpu->env.quiesced flag tracks RTAS stopped state - CPUs in this state
> are already inactive and should not be reset.
> 
> Skip system reset for quiesced CPUs to prevent kdump hangs during CPU
> hotplug operations.
> 
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Suggested-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   hw/ppc/spapr_hcall.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 032805a8d0..e63ec24f0c 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1105,6 +1105,10 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
>                       continue;
>                   }
>               }
> +
> +            /* Skip quiesced CPUs */
> +            if (c->env.quiesced) continue;

Qemu coding style suggests having braces even for single statements 
within an if block.
Please refer Block structure in docs/devel/style.rst.


> +
>               run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
>           }
>           return H_SUCCESS;


