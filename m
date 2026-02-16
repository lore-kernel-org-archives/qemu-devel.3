Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A229E83830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 20:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs5VN-0000E5-PP; Mon, 16 Feb 2026 15:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vs5VL-0000DQ-FF; Mon, 16 Feb 2026 15:47:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vs5VJ-0007PG-T6; Mon, 16 Feb 2026 15:47:39 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GEcBpR3400804; Mon, 16 Feb 2026 20:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yekLwi
 1rAG1I1yGTPVgQJ2xYpw7JXDERd5Gu58M5sks=; b=AvnZJW+bDrWJdZSyJ/yY7a
 uZeO3PmfwcmuZPjuRyJuhmreB6vTXOabgWdtJaxclQEHEGD9ZpNBLqeXCPe1iPBW
 YnswAOAm3Frzl7JLqF8xpky/UZ1EKF5gKvPmz+fh7dnG4nrWXmaGvYMenOqB1ZOg
 7JIK6kXfAbHpzTIPgcVEBKuOaOFDvdoeA8LBUB18Nzj8PcobeEw80gHkTE1RKr5F
 EhKGnVHSn6rEEXl2Rdo5LsbB+bCQMCAAv4U1KB0/OYltU0ydhJP4TAHeOEJRfQ9/
 zKDl/5I8p3cu2k2jxRCxbqsOWm8lGcXykfuEswqN/kZDdFxJxOxHqZOAXNmfMXpA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rs8ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 20:47:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GH0Wbt003744;
 Mon, 16 Feb 2026 20:47:31 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4cmxsbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 20:47:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61GKlVkT28115672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Feb 2026 20:47:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB76558056;
 Mon, 16 Feb 2026 20:47:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8745258052;
 Mon, 16 Feb 2026 20:47:30 +0000 (GMT)
Received: from [9.61.241.179] (unknown [9.61.241.179])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Feb 2026 20:47:30 +0000 (GMT)
Message-ID: <bca708cd-a776-4103-a328-fa6b3d65a47e@linux.ibm.com>
Date: Mon, 16 Feb 2026 14:47:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/3] aio-poll: avoid unnecessary polling time
 computation
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260113174824.464720-2-jhkim@linux.ibm.com>
 <20260216152131.GB396170@fedora>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260216152131.GB396170@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=69938264 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=_2359ND7rWshGlaeOjYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _Y5o6x2JcN2fGyc0y9peg1amTuy5AmRz
X-Proofpoint-ORIG-GUID: _Y5o6x2JcN2fGyc0y9peg1amTuy5AmRz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE3NyBTYWx0ZWRfX7qudTjMk59eB
 SkkF6d4nE+2E6bbHDeRCOzzLcw7oIRlYsC/wY/fSNiesSNQNCJayfNv6MildzYV0Mivlgheg7n2
 ZbgI8AmlEjolWjqA36IeH0vHmdTvCmc3DVP24x9ubJG2CaU4Su9IdpE3aiLJBsyoYyNcST4kqUV
 RmfKo4Uj5yEbNrXmtO19bcTimPP9DngbNv2t/w+5OBjqsMm+KQm2r2SdMCXipiYfWdL7BhEP4bA
 V0X826iNSSQkgSp1TPtkiTHzlwb6l8ihK7G3ehRMY9JsuWE2Ewl5Q3wj/X88eqD9j2ODvwcH1D8
 WGpFw4OwH/6Uw1y6oTiXTbYly7ARRowE7vEGsWNvEk0aEQHjCHJ727s4SdOJQBax9bnjIpKyHsJ
 t+wC7p4FzDrUd0Zs5oFFzoN1+UyLE1wpvur9SQ4LouX0GQnbVzq4R1trATXpBCBBTOBN+S9aB3x
 SiWsuJOGeRrW3+Z2Mjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_07,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160177
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 2/16/2026 9:21 AM, Stefan Hajnoczi wrote:
> On Tue, Jan 13, 2026 at 11:48:22AM -0600, Jaehoon Kim wrote:
>> Nodes are no longer added to poll_aio_handlers when adaptive polling is
>> disabled, preventing unnecessary try_poll_mode() calls. Additionally,
>> aio_poll() skips try_poll_mode() when timeout is 0.
>>
>> This avoids iterating over all nodes to compute max_ns unnecessarily
>> when polling is disabled or timeout is 0.
> Did you consider optimizing the case when polling is active and there is
> no way around calculating the polling time? Glib has ordered data
> structures that have lower operation costs than O(n).
>
> Stefan

If I understand correctly, while optimizing the data structure to be 
cheaper
than O(n) is one approach, I believe bypassing the function entirely 
efficient
for cases where timeout=0 is frequently triggered.

Since the result of the calculation is not used at all in these cases, 
it seems
to more efficient to skip the function than to optimize calculation itself.

Please let me know if I have misunderstood your point.

Thanks,
Jaehoon Kim.


