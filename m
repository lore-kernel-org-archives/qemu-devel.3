Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ACD1099B39
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3fX2-000253-3c; Fri, 20 Mar 2026 15:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w3fWx-00024h-Ry; Fri, 20 Mar 2026 15:29:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w3fWw-0002ZQ-2R; Fri, 20 Mar 2026 15:29:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62KELta13291959; Fri, 20 Mar 2026 19:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sh0MSY
 NoVOnrRs1HaBmB0O6aHOOBOH5CiHerbujjUTk=; b=AYbbMaCRV+bUzwQwvtcCV0
 9ocC20d+Sns8jKBFCyYuyRfzWemV6dRcTxzmB+B73X5+xTBzrRtgl1MlWA7GSaad
 yRvimryidgPTuL9H6234/DJk9geu/54J/3vbzFJWgkCtfme/MJH5Qdbg2QA7Plm6
 bvlTzwIWJItlDW+vxlRfrK8K8Thswg0kOe1XuI+V4KH8Zjr0CUbI0EiqtjCETWJP
 xQYbzOEni8lHvl8tcVViTuHmu4yyY3Cx07Xrs8RHHRBli0PJ2MVZxZTTO64dbdFJ
 ViydHMFmpXXF3qke0eSvNWsgdBMFVjILTVQuhQV8q0rf4E9/ApANUKfIvfIiVtMQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3dc77d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 19:28:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KHEx1w015644;
 Fri, 20 Mar 2026 19:28:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nrnm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 19:28:03 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62KJS18m30474986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 19:28:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 884B85805C;
 Fri, 20 Mar 2026 19:28:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC29B5805F;
 Fri, 20 Mar 2026 19:28:00 +0000 (GMT)
Received: from [9.61.145.197] (unknown [9.61.145.197])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Mar 2026 19:28:00 +0000 (GMT)
Message-ID: <f0965bf8-b736-4e53-b809-374945f0f48e@linux.ibm.com>
Date: Fri, 20 Mar 2026 15:28:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/s390x: Forbid to use legacy ldst_phys() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>
References: <20260319185203.11799-1-philmd@linaro.org>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260319185203.11799-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bd9fc3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=YtseRGV3vcOpFp3jGzIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1NiBTYWx0ZWRfX58ypproNrh+u
 lvMu69SEUYMZxsWLYEaPYBzEWdWlK6dalZQqtnhj4jHa3uhA1EGN9pi7kvsaUeGJVdwPL/vhsgC
 EaxRpP6QmOEdTwzMmRqRl1ZdJXq0l1/1xAPrYaLdCguuYf0TUmqb92L9pTxlonKIuigqKmKnwY/
 GH3IErxecijENmbyxhLq0Dv+5nKvgZNmp5HP2Gxm9+fPzfS4Z8KygqYaCnh4fsUuLMhsQ2KEcjN
 Fv5xyg9LXXXdql73IAP74s0uIMyJrkt2YOgfm5Ke+pm64wuui7Q6jHb8fy+D7irIGxRofvxj98p
 JFrvMqY1umBOCVvuQOV0iodeEmcb7/AniPlqMvzXUdOKSYP6Ga5/zYGS276oXWGe1CqWSZS3Fr4
 cUxp3BXckLpa1okDrmJhfYxGKmaFp+SVqi43QyyZDZqv3k9QqU86WCJIHDEXLzRc72BCcHMvpof
 5MKz0PCx9+dqhjhto1A==
X-Proofpoint-GUID: NrCHlsGSKbzKFdGYRhYMIMpP73P3ekhm
X-Proofpoint-ORIG-GUID: NrCHlsGSKbzKFdGYRhYMIMpP73P3ekhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200156
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On 3/19/26 2:51 PM, Philippe Mathieu-Daudé wrote:
> Replace legacy ld/st_phys() by address_space_ld/st()
> then lock the target again further legacy API uses.
> 
> Philippe Mathieu-Daudé (5):
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (cpu)
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (mmu)
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (tcg)
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (kvm)
>   configs/targets: Restrict the legacy ldst_phys() API on s390x target

For the series:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

For good measure I also ran some s390x kvm regression tests, took a less comprehensive spin with a tcg s390x guest (on s390 host), and forced a few of these codepaths as a sanity check.

> 
>  configs/targets/s390x-softmmu.mak |  1 +
>  target/s390x/cpu-system.c         |  2 +-
>  target/s390x/kvm/kvm.c            | 12 ++++++++----
>  target/s390x/mmu_helper.c         |  5 +++--
>  target/s390x/tcg/excp_helper.c    | 21 +++++++++++++--------
>  target/s390x/tcg/mem_helper.c     | 12 +++++++-----
>  6 files changed, 33 insertions(+), 20 deletions(-)
> 


