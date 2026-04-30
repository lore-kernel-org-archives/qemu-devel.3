Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF3DCD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITmB-0005BR-O2; Thu, 30 Apr 2026 11:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wITlj-00052H-IY; Thu, 30 Apr 2026 11:57:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wITlc-0005pc-0U; Thu, 30 Apr 2026 11:57:34 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63U4ZJPh1684395; Thu, 30 Apr 2026 15:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=67T9Sb
 q4gJTCPa/+uBWWben/qoxAohbiSQfzHvc55zI=; b=cSfGsxypeqiQxoLwjMjoXQ
 sXO34NtUAzq4H9MAAcF/7ukKS+8u/sWhpsVyElauXRR0mU2UhD1sOoZEaIJLlaei
 ni4zU1pAoLMC9kXacnpphRAqM9MixKLkSrtrCQgt/JyDZjj7SGcI2PhTTHlOTZEQ
 UexCtEuoZ6JCubHoL8zW9fQrnXPdmnfPT2VqpiW0nN53aBAoCeRpmZrP21bmAwsK
 pNlng2yB4UZbFqKa1GmMunGFJYqXrntZFE6ypZ5+MFtL4DcWdBhuTaU1y+Z4ApG0
 Nqg20SLbBbSDVfzIQUFvtf0CFKAkUuVKIaYSTKrDpB6r0IjsALic3Z4Lw2mdFTNw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5gmhj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:57:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFrsfu020623;
 Thu, 30 Apr 2026 15:57:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xkbp4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:57:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UFvKeq40501706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 15:57:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0730020043;
 Thu, 30 Apr 2026 15:57:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E48920040;
 Thu, 30 Apr 2026 15:57:17 +0000 (GMT)
Received: from [9.124.223.167] (unknown [9.124.223.167])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 15:57:16 +0000 (GMT)
Message-ID: <65e1b092-146c-4839-89ee-66d2b0589000@linux.ibm.com>
Date: Thu, 30 Apr 2026 21:27:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: Skip system reset for quiesced CPUs
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260430085409.680930-1-shivangu@linux.ibm.com>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <20260430085409.680930-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f37be7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=D23PPXuEu1KsBxDnNFkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2MyBTYWx0ZWRfXw2edKP1bc7fu
 JwKp5XtBa5DdRO5ARM+QoqMrCLbGABAOQZ+zXLiJRT+G58KTR7GqmxvK233A3V1G0FLRjHv4jzD
 EyC1wb987trpvCi7Lmo/PJF1pg8w1aHoCBG5PmXJlKwcSchifEXzdylVgebzivz6xzi5SfMC8GJ
 Se5yKxuudC4+oujllW5LeebrXSefeZxTGN9FU3LsDe/WjT4iDAEwTMadG3RHddpZInRZItKAkxR
 +hYENziPaHqJzcf5X6hgpOyHv/EHoEvYgSePFjXBqOqOv2PJkUogHSBGhLHrUeohds4bgVNerI5
 3B7tStgAqYl8tKGjcf/mEz5TCUiK+PvTXRyrrijcE5Dg+MLWkVWooqeb+WRf5IvYAcUBA0OeQyQ
 dGDWdjUm3DVNtFyvXIV0A2eH8UnRtUU9YQYADRBn3MysT81mR8Xu2dGcV74RfQ51vn4GWp/1U+2
 Rcyn4xkRJc3rgTRtQ2g==
X-Proofpoint-GUID: VvvoQit9FX_IMdEpautXDepwEmzU1AtY
X-Proofpoint-ORIG-GUID: VvvoQit9FX_IMdEpautXDepwEmzU1AtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300163
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
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

Hi Anushree, Shivang,

Thank you for working on this patch.

On 30/04/26 14:24, Shivang Upadhyay wrote:
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
Also worth noting that when the system reboots, the newly DLPAR'ed CPUs
that were never started via start-cpu will not be present.
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
> +
>               run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
>           }
>           return H_SUCCESS;
Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>

