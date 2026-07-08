Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D72C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 05:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whL2B-0004LL-QH; Wed, 08 Jul 2026 01:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1whL2A-0004L6-86; Wed, 08 Jul 2026 01:41:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1whL28-0005vG-Hr; Wed, 08 Jul 2026 01:41:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MmaYj184826; Wed, 8 Jul 2026 05:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cCvr6Y
 B4ShNBB73LMyiQFfvMzXxaZWkpwDyMjya8Yj8=; b=YyskcwZy4S7rSqc1WTOH8u
 DrMMQFD3LS3QU4SGWUw4tdNzpy+5PQOWu7aajBVF2bBIUDD1s2M0Uj4YwHgaMG0+
 fK5b62Z1H2BtM4reFD3kNflWj8m2ALK6MMTqVQss98fuF/lhg4kNDmt+5wTbwd5f
 xDQ5py4muTo3flRBnh0X85T3pGmXfhvxtkbQo+zsDix+i7ed6b+ogZBVrDQJ3EMm
 4u42hliVgx0TjvfG8Ra4nNrFvv432gB943QaeF3O04ECOritWJTI8gn015Q2qMrA
 kUsWVwklbs397g6cGozke9bO5eZxW+z1qvJ8dlvZndhAzIwEAgq6IkifqkTH5qFQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdu94j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 05:41:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6685Ybb3007217;
 Wed, 8 Jul 2026 05:41:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw6a8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 05:41:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6685fFj027918936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 05:41:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F33BD58059;
 Wed,  8 Jul 2026 05:41:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA9C05805B;
 Wed,  8 Jul 2026 05:41:09 +0000 (GMT)
Received: from [9.39.27.36] (unknown [9.39.27.36])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 05:41:09 +0000 (GMT)
Message-ID: <88ddf6a2-282f-4842-84e7-2f81cba257f8@linux.ibm.com>
Date: Wed, 8 Jul 2026 11:11:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ppc/spapr: refactor cpu hotplug code to separate file
Content-Language: en-GB
To: Vishal Chourasia <vishalc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, rathc@linux.ibm.com,
 sbhat@linux.ibm.com, gautam@linux.ibm.com
References: <20260704103617.632929-2-vishalc@linux.ibm.com>
 <20260704103617.632929-4-vishalc@linux.ibm.com>
 <20260707164428.5e4a4500-04-amachhiw@linux.ibm.com>
Cc: mchauras@linux.ibm.com, mkchauras@gmail.com, sshegde@linux.ibm.com,
 srikar@linux.ibm.com
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260707164428.5e4a4500-04-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4de2fd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=Rg27Hn24Qh5PSjqivGoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0OCBTYWx0ZWRfXxVXAHwfIa/kV
 5kTe6OqHnAKxGU0lewJvzB8ucwFMLYVgj9KyP0x8K4LxzR1dMESZzfEypTSLIJ3EQ52fw+ESo7t
 FZ5gpeBqJu3im4TrnApV2JsiLt/R/STyZmZtc9noDZd7KiAfnMkotjbVK6/t1oib4K5cC+L++VT
 xz6NA/lKRrInj7yKsMvPvXqm5zz09naAl0Y9GcS6xQN7t8U5yMvwzsj6CuZy5QvsK2gOj3itGXV
 x58n+U6BTKM9c2WWFPG2Ek+SaxeghZhb0NJJ88CFfqnM7k3vIvSHV4dwPcaYyl/7iaCZnkyzzjt
 nByWyL4/yXHObbsrzouNGEKO5VtbfdurFVM5utfmcanYR3In47sRoxFiPTKvH5zwCzNJqjRXnTL
 M8v4nNcgKCpnZvsKxlTdiTEmplzQwK3oJJ0L1TF6SlE2scQwIoBzWd+CP0WgqErUeb8aFimbZAH
 nSiGTGGohTS5pytm4dA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0OCBTYWx0ZWRfX/dS+6IrCw0eT
 pY8IUemlaqzSqOhXVaOei60xI0UuwavxsFBY8DELthpr22KA+6+FK1EVQPxHQW4jSkH5sSZJL0I
 hFmpUKXND0B/C7HzCowXWSI6wT9CcYA=
X-Proofpoint-GUID: vqAbm0L_-IXhA0VRd9wR0mEE7Wmd1jGG
X-Proofpoint-ORIG-GUID: QNj15X_hwiaYVNABdB8QsZgOiOhhs78R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

+ Mukesh, Shrikant, Srikar

On 07/07/26 7:19 pm, Amit Machhiwal wrote:
> The file name suggests it only contains hotplug code, but the majority of its
> content is not on the hotplug path: spapr_init_cpus() and spapr_set_vsmt_mode()
> are called only from spapr_machine_init() at boot; spapr_dt_cpu() /
> spapr_dt_cpus() are driven by boot-time FDT construction and CAS;
> spapr_cpu_exec_enter/exit() are TCG dispatch callbacks; and
> spapr_get/set_vcpu_id(), spapr_find_cpu() are general CPU infrastructure used
> across the subsystem.
> 
> I think it'd be better to refactor cpu related functions not specific to hotplug
> in a separate file with a more accurate name as spapr_cpu.c / spapr_cpu.h if you
> want to also keep the spapr_cpu_hotplug.{c,h}.

While we are at it, we may also want to consider cpu related files in 
target/ppc:

qemu % wc -l target/ppc/cpu*
     7803 target/ppc/cpu_init.c
       91 target/ppc/cpu_init.h
      931 target/ppc/cpu-models.c
      482 target/ppc/cpu-models.h
       33 target/ppc/cpu-param.h
       61 target/ppc/cpu-qom.h
      256 target/ppc/cpu.c
     3137 target/ppc/cpu.h
    12794 total

regards,
Harsh

> 
> Thanks,
> Amit


