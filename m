Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36247F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBGmw-0001er-3J; Fri, 10 Apr 2026 14:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wBGmm-0001eB-AL; Fri, 10 Apr 2026 14:40:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wBGmk-0000sM-Ie; Fri, 10 Apr 2026 14:40:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AF8RMk2326591; Fri, 10 Apr 2026 18:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HLP16T
 dFcrNnrR4pVuiFVmbzbyk5ImWJzUwsEgpoOt8=; b=Ze7Ohb4aTubzHflnxabpBE
 f78Zqg43+zabAYBlJTb3iaSdSeHJLMIk2usGBuLi4m8V+vF7AkbAQQ1Vzq+BC+oc
 +sIoqd74cL1+S//mRCXZn+F0ptn82qatX/OQR0fqJVKYPFOoQftWQarvYGvcgQmD
 7cpmDmUEoCSPeIsFB/W0xk1sm+sGKdPp5uXm0RamQrK6z2JbP/vMcoepKJQGLXBY
 15Fk2tOf4dMzeY4e3zeIIi164a6jg6rK1JAErhSrAFPMcXhEiCHa2sDlJAC30h7H
 RlDnOrpeLhVVMSdJ3frr4DXFflPMXuXlvjybw0seeDW+068h1YtVPnM9vKA5vUmQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ktdh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 18:40:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63AGsEg0026655;
 Fri, 10 Apr 2026 18:40:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg89e39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 18:40:45 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63AIehd064356854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 18:40:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1AF958062;
 Fri, 10 Apr 2026 18:40:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B7F95805E;
 Fri, 10 Apr 2026 18:40:42 +0000 (GMT)
Received: from [9.61.251.32] (unknown [9.61.251.32])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Apr 2026 18:40:42 +0000 (GMT)
Message-ID: <4db0a947-0994-4149-8e2c-08fd68030f96@linux.ibm.com>
Date: Fri, 10 Apr 2026 11:40:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 14/30] pc-bios/s390-ccw: Define memory for IPLB and
 convert IPLB to pointers
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, brueckner@linux.ibm.com, jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-15-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-15-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE3MSBTYWx0ZWRfX7Nv2WBfm5nSd
 YBRCUb8MSB108GJ0azWV/Q96jVYh6PSD5gtJgoXqr2R0A6Yn4hkMCawoRaBbOGoTA9IQ88AMzj/
 hVv+nripiX1QWYnxd+jm2YJJbvhddqJVniev4KHjnRC/OSh56rPY4CA/03wHBCzmPDSdvtNT1R+
 fGe3sHcjhv1Jf9Q0bJu0ZhIjZL57s6uLmP12rZ3Mp2Thwg0t/wN5JPy5xlhsoLtDj6ZaKJrP2AV
 Pqz8xtTeUQiSgj3rwSIeBpHidXgAayVNRATCC0b61JM/OylHDGoupbRLzDyxWtUWoF3e/+pHww3
 nxZkHNs2CKcNj6lVH1zhdLcCBGdHNZzO+a3CMqx0H0Y6ki34EaEbbMpMRxhOZ2famFRjU3TW5W3
 Yh9+DEZalWtCVCHPNZ8Qukt+3U64lwR3s21gIwz9oPlN22h1DaAucIHgyVKKlJc/FyUPSUdCSOZ
 JUJh1sE9BPvOybbgR1w==
X-Proofpoint-ORIG-GUID: PrbeNbckljyW3LOk1h4rffkZNvUGMnyb
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d9442e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=aRknlBhs1iR8BIPwus4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PrbeNbckljyW3LOk1h4rffkZNvUGMnyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100171
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 4/2/2026 3:14 PM, Zhuoying Cai wrote:
> Define a memory space for both IPL Parameter Block (IPLB) and
> IPL Information Report Block (IIRB) since IIRB is stored immediately
> following IPLB.
>
> Convert IPLB to pointer and it points to the start of the defined memory space.
> IIRB points to the end of IPLB.
>
> Signed-off-by: Zhuoying Cai<zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> ---
>   include/hw/s390x/ipl/qipl.h |  6 ++++++
>   pc-bios/s390-ccw/iplb.h     |  5 +++--
>   pc-bios/s390-ccw/jump2ipl.c |  6 +++---
>   pc-bios/s390-ccw/main.c     | 34 +++++++++++++++++++---------------
>   pc-bios/s390-ccw/netmain.c  |  8 ++++----
>   5 files changed, 35 insertions(+), 24 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>


