Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86178C44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTLM-0005hz-Q8; Thu, 16 Jul 2026 17:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTLK-0005dv-TW; Thu, 16 Jul 2026 17:10:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTLJ-0002Gk-Ii; Thu, 16 Jul 2026 17:10:06 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GKBvtF4120322; Thu, 16 Jul 2026 21:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JbY+la
 GMe0FsdmJZkeQtXlWZjLhCrCnfttzTYOUhYas=; b=afRsMLFw8wdwXaMojJ1xqK
 e3r4s0rpZO11sEnP2OqkqzjWIt/M7amJVzmNUa3j5wCHCCobkQfTgMmxHtxouB52
 nL8BD9GKvDOE1t2hxaR9XsLMFoaOM0Ul29whtLxk8i8lIyBkrVwywblLXUgKT5Q+
 hHowpxJ/mT5OPbdhc/FwA7/JBW5oQeM9ndez9Qb/H/6iykkQ0e3xd2Ld7XtsZI80
 KCRVQiuf6PQIg4hI1ROOMRQo7wZQPEKXfY4/6cCZgWU48yicL+6gtJUFGYzMYfrI
 hAeEDY9/a9IT6W4x7f+k4xAeYOsHOpq/Nzgpz/BsznlY7JGp4NDsvXmkLYypbiqA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx286a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:10:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GL4a9h018392;
 Thu, 16 Jul 2026 21:10:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyej9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:10:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GL9xql46530900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 21:09:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72AC520043;
 Thu, 16 Jul 2026 21:09:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2041420040;
 Thu, 16 Jul 2026 21:09:59 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.65.221])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 21:09:59 +0000 (GMT)
Message-ID: <01a59143-21d8-4330-a75b-4aa50275ab95@linux.ibm.com>
Date: Thu, 16 Jul 2026 23:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/51] exec/breakpoint: Add CPUWatchpoint.hitlast
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-25-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: mUodptWQ4Ufqu54X8TwgvgepLvbtJGWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX5CfcL7Sw6MuL
 JMmWbKzp2+eVnE9MTW0WOXU++TfUkZBnMaUItWi4NFAdmLNv9W/7Fqm4c6Y/I4zdguEc+14b6DO
 Pr9s8omqbtxMOV6rlDe+8Jq+WvLbVkjTN9y4UEADvb4hrD3xBJg610c+XFxl+0m84EFvVE8zIv9
 vheW1ISI+SZpJljGeXTm3vr+f7bQr1Y0jgtaCaneK+b0FDunNwm1HznArJiyLkb0koK8hthUu3F
 IPT15cIWDYzSfXPcyzJMJnFE5Nz03Ymw+cTWmj8Dx0EHRGdi0UqkAb38B9F6oc5ZP3Il3HndBzr
 vL49UeHZN2UXMoWH9sq8cyk2XsouOiI4ajWC/lNXyT3vSm7sS4Id/xHhyr1UCnaemD84bHjRwKS
 pHl53mnhk7aMjt7OSF0yI0r5ADya+SJiw+uaM7KRIggUPuxcVvwdhweo1gVAWbh8E1KxVdTorsL
 1A0LZFtiZwyS0ycDeGg==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a5948aa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=r74WaKCYnNQTuuYHEboA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jrA6hW9rzY3rCvE9OowrJ9XfwVPiIeAG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX4v9AGbIagK4z
 Dyd88C83hFay7FgMUPfkS2oF81WCc0uo4L6UwC6YEgHsa4TuAP6AvN8BX8mnIq5N24BUUqWmyHN
 ft3ZUPwokrC145a95sB1BulnHj/t+QE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160211
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
> Allow the debug_check_watchpoint callback to see the
> entire range that triggered the query.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h | 1 +
>   accel/tcg/watchpoint.c    | 2 ++
>   2 files changed, 3 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



