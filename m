Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EABC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTGY-00030v-2w; Thu, 16 Jul 2026 17:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTGV-0002yy-VC; Thu, 16 Jul 2026 17:05:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTGU-0001gq-23; Thu, 16 Jul 2026 17:05:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GKC4lR022486; Thu, 16 Jul 2026 21:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=j+dxHd
 mh17O1Qqj4dMTQmXu564QX27WWYAAdeC5Hu28=; b=Spg0VveP5kgZ75/saaNOo+
 EZtCB3A5RGAuyolxnr0tEl0o0RhS6iu+0R0+VGPtIsyE5xFFg/Q7bWOOAKahVbPp
 vQNcFEIgaMat7ZaVHzVxPffBLPKTYMlA/HvQNt0lDwXpLeAgXmn1GHr9/Ar4N+/4
 UXwF4lACOCTiwbn3G9+UQMzLu6unWSESw1RiF51qgRaW9rp6axwIXo2iaRrv76i8
 mfkifSSvEfgh9mfZI9ktDtUKPPlaHUmvr8mYs5M6/a43l2FrQ1hItwMDXo5a68JJ
 NcAcftMkaEJPG12AyihI/0oTFneE2f9B0a2NipmlMj7UcMfP6v7nhXRLdwdzf61A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtk544-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:05:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GL4drU004439;
 Thu, 16 Jul 2026 21:05:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhps06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:05:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GL4wLI24117638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 21:04:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 423A120040;
 Thu, 16 Jul 2026 21:04:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E426D2004B;
 Thu, 16 Jul 2026 21:04:57 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.65.221])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 21:04:57 +0000 (GMT)
Message-ID: <a3687796-086f-40b6-b8fd-86279859bc3c@linux.ibm.com>
Date: Thu, 16 Jul 2026 23:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/51] system: Remove cpu_watchpoint_insert error
 return path
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-21-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pIa7psXy1-n2Tyql_Lg0UF5-RMzUv6Q9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfXwvArROH8yMlf
 NUTIRa2HwnLt3i9HEHK1yrfQVOGlmL9fXAWTVNF3fQftnjri4076hQ+fRH+PK93h1R8ZX2wihHX
 mTbltn7ZsyuGOUpH68o27SaIeLrY1+8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX9GF2dHHPEPNI
 UaApb9GYJSXCLqkCkY9VziflNlj0dKIecgwurC5n4UZjWknqEL9W5y4oeIm8mFPPVOlxLAa3m6w
 kxS4LJRFSeV5pJ6apN5BiD0asHWyirvvyimPax+jdMaDAqOIZwLHaduL1MOrAUn4NT00XdVB53c
 zU6brKk/3CJbIfp3Z5+uJ1BHBhw1S/cMf6mFQSe2LSyPQ17pey9H0yUvxnHVCPYHZMTwunzQ34j
 Ve5NViUGjC1/7akFIqIPvzKNNlMc21cM3P4RtpQ/0N5lxyzb4/xqTHQ70AgC6N7gQ4OX2mLXk5K
 Jj23X1WEchRDzGaNWVSt1Uh9mXfmicaCLe1NDsf3NLUt9m6hT19IoeFBgSwmfp2vKwdMmc7Rx10
 sFp2PodhAWrg/efd8SzheOaNSbJqlrWYkbFhLTnfDAgeTTTcDyLCdn2nJhTJDCcRWzwXsFadB2v
 mL1ME6E+m3T7VQd2lpQ==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a59477e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=pZVW5Mm1fYg_kLs75vEA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -cfISRRSMAWEKVwLYyNZtiB85uNh7DQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160211
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 7/10/26 22:53, Richard Henderson wrote:
> Move the validation of the address range to tcg_insert_breakpoint,
> which has to deal with gdbstub inputs.  Leave assertions behind
> in cpu_watchpoint_insert, but no error return path.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.c | 3 +++
>   system/watchpoint.c       | 9 ++-------
>   2 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


