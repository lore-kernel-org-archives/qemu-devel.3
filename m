Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F7CC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0bH-0000dh-OR; Thu, 20 Aug 2026 07:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wx0bE-0000aa-Ni; Thu, 20 Aug 2026 07:06:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wx0bD-0001MF-Am; Thu, 20 Aug 2026 07:06:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8cJEY363375; Thu, 20 Aug 2026 11:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FtO2Um
 cwTipu0m8QdOfI7+bBhabUBryTKVDXf4aEmqE=; b=epb2XPXkNEHvTtXQX5nH13
 dwhvSrQla/XRPMEisEBSM2lC2PxBgP0D0harkjWfQf+AUy6xlcp75GhfeIDwY1O3
 XcyOMmllhBdTkKJncFRMF2uz52RBY66Kd7Ap4wsCjHlsCpS/Vixnp5LU1P+KKhb8
 UoReUJQi67p/0En4D9iCJj3k3nbF6JBdBT+rmUWjPLMvOY+x7YIiJa1eujmVFV02
 w/8ZyE77tk1xTsC6UH2qNY27TRP8PXjHluIDjTVAKGGZZ95Z6NScAIJSufTGaTbT
 Thzo6eWkh7e+ozM8AlDYAE+sC2OEQht8+3MwfcsdB7WDTHBXzCKSsSy3UZLkfDXw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu49p45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 11:06:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KAuLgK010288;
 Thu, 20 Aug 2026 11:06:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ynuvp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 11:06:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KB69bL41222586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 11:06:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CDDC2004D;
 Thu, 20 Aug 2026 11:06:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C139120043;
 Thu, 20 Aug 2026 11:06:08 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.154.102])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 11:06:08 +0000 (GMT)
Message-ID: <09aca457-ec54-4960-b29a-318a0528cf52@linux.ibm.com>
Date: Thu, 20 Aug 2026 13:06:08 +0200
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
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-6-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260820104730.25462-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4MSBTYWx0ZWRfX7j8ewnZOZwgk
 fZYeAtIZvsI2TTvdbNsPjVGnx359hbm63gvyjRH6QCIaMyRxto0KlqSJ8IIJQosM1fumcCAiTjO
 pWQDssjXAvLtV8glIvCknRonmUxdgUU=
X-Proofpoint-GUID: 98l9W_qfQlKtGgVdkP8j1SFC-x4oQ4v2
X-Proofpoint-ORIG-GUID: 98l9W_qfQlKtGgVdkP8j1SFC-x4oQ4v2
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a86dfa5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=yya1H_lFuFQStgZNww8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4MSBTYWx0ZWRfX0nFWjSeYc49I
 WCFIgA/TyUf2eseFaUDYmQu19f+3AykyVZbzoIMaNRco5yRGat34iDS/3auOGqRpGEX5sMZco76
 xrx88tYC4ZvxeHxzCOmHgVQXBYFzuQNtjAX4Ej+4WPwZ/MDCpKBJSA4pllcDBoRV5xWbvc/Modl
 gqbPAcB1XpdlM7Vw3gb3JqYrk8HvKrLlBt/vnrhR5OvmbWs7qI1HzuxJmklZfj6nsmPt9jgd7S2
 5FnZuA1EyG6usrWQC7KNrKYM44FKJE7xTEDmKcflJanbCz8HV4kb7pg9WfbYt7nurYI1fgtVHeh
 F050znoefOc3YQ8FFG4GsIKq9WCIXahlwzeJlLj6SX64vJOpenLRjzDtzuEdLcUbwmHRqzO13C9
 jzVijF/VvEaJNsW08jG1vbn06XLPGxzm2f3X/UkCzFLyM9RIFXQCW5QiPAGuDFmJ50AIOHbSA/T
 kiLsmAoeSMTv+34lHWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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



On 8/20/26 12:47, Philippe Mathieu-Daudé wrote:
> Add the const qualifier to S390CPU when the argument
> is accessed without modification.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/s390x/cpu.h            |  2 +-
>   target/s390x/s390x-internal.h | 12 ++++++------
>   target/s390x/interrupt.c      | 22 +++++++++++-----------
>   3 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



