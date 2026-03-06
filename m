Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD6BF01821
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySng-0006b5-FD; Fri, 06 Mar 2026 05:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vySne-0006aX-Kh; Fri, 06 Mar 2026 05:52:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vySnc-0008L2-QS; Fri, 06 Mar 2026 05:52:54 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6260ssmh1873366; Fri, 6 Mar 2026 10:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+9ZLiz
 pit0ldtsh0WM8IrCm3L5gh+kFqZnKdyY90VeU=; b=N+PlmHokE13BZ1cJjBQVJy
 yWbea3yBY4tYNDsKy8LTbVM17Ucu6P/wCI0wC9Q0J/g7LOJIJtmycUgYVDDwo+0f
 hsezYpyYnXvFW+zzOpxRzp4KYjuujqYQHB2y5Ub+Euh33sLqx1AaRAPOMPlw6l8q
 Fb07KB924Bt+4S9A04ki2UzSVa/BsAthnB5juJ8FaoHVN5n5qoHIETfgmDUz0LRQ
 tjmcZ0fd7NxItGPXipKqt7e0BxPtyLYwlJk+2YhdD4P3WqS7CpN12RJRrRIljer8
 NHOGwvDWOM72eAdLa821HIOKcg6G/pRF0FtIkEddgj6SpPGjjPMvsDlTMupEukbQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdr24w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:52:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6269t1pJ010327;
 Fri, 6 Mar 2026 10:52:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6kfcx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:52:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 626Aqjbg51905016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2026 10:52:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 541DA2004E;
 Fri,  6 Mar 2026 10:52:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7124A2004B;
 Fri,  6 Mar 2026 10:52:42 +0000 (GMT)
Received: from [9.39.17.151] (unknown [9.39.17.151])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2026 10:52:42 +0000 (GMT)
Message-ID: <81c7a239-b977-4e4c-8418-50d4b71c8c0f@linux.ibm.com>
Date: Fri, 6 Mar 2026 16:22:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] ppc/mpipl: Implement S0 SBE interrupt
To: Hari Bathini <hbathini@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260225124633.1841222-1-adityag@linux.ibm.com>
 <20260225124633.1841222-3-adityag@linux.ibm.com>
 <b8f14d86-25a5-48c4-a982-b728371964a8@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <b8f14d86-25a5-48c4-a982-b728371964a8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69aab202 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=vQyZk1MQt6G97x1FY9sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3CMIPFlYVd9Zwh6sPf5666mi5Oa5ri_U
X-Proofpoint-GUID: rAi8GVVNMf_HMJmZMMIKboHu3s1w14tY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEwMSBTYWx0ZWRfX5lRyxhoN34sd
 w+2BsSUoCW5ctWfRbp69wUOq5Ugroiz+neL+aGlEfk4epyWx9ZSnO70QQ2pR+n9Rkx0NN+wPexv
 pO67Kbry5fFrcbKdfB44NPhD4rCJp2G1DSmnv0W7mZTHDEXBdtpHY7RS/GSiZiinZPV8RHLHzKR
 6EJtDaAloFEJo/1OKvESXaWbPn2/fDXfBmOS9CXEPCwf/IoYBc1bpxdr1wxRR6gE6GDX1vxGLmG
 rngralRQ6dlHKbdNRcFH5s/V15nF8t0IP8H+5qjtoIf3IBYjJloO5YcOBBLzDMgMDTJOgxLzjVc
 IR/beHuO3vYpPsC0li3B23yaFBDp58EipK76hUsJluUl6SXRoGrO8980znvRxn848177T8kFYhH
 F37ZcVQBpHCewHCFddAjRi967Rh1rVWbbR1j9Wz0YvmCp+doytMe69EhAB++xE4juFnsiSkwyEo
 rIJLlHWFyilFhQ8nIFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 06/03/26 16:18, Hari Bathini wrote:

>
> On 25/02/26 6:16 pm, Aditya Gupta wrote:
>> During MPIPL (aka fadump), after a kernel crash, the kernel does
>> opal_cec_reboot2 opal call, signifying an abnormal termination.
>
> Minor nit..
>
>> When OPAL recieves this opal call, it further triggers SBE S0 interrupt,
>
> s/recieves/receives/

Sure hari, will fix in v4.


Thanks,

- Aditya G


