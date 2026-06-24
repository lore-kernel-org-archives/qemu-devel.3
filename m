Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0105DCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOcR-0004pH-4X; Wed, 24 Jun 2026 10:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wcOcM-0004mJ-13; Wed, 24 Jun 2026 10:30:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wcOcJ-0001Gm-L7; Wed, 24 Jun 2026 10:30:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OAnU1K597048; Wed, 24 Jun 2026 14:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pEznVU
 +QxB8+o1/ilzgZP2lZoODnRbI+ECyxYrTVnoI=; b=FBNTD8bUvV6UvwSBZQq+yW
 bzDpuH1jBuB+56w1jNMdX3mj74JX9aKY8fjvuQ6FqEqFigWNW53slgBCQ49EDAx+
 y1q+C1+wjOMVjuRpPJoJGTXvRkvJCb2t/F6hZ4NqxdAabqcpPXdWATAYPZN9gjVP
 N1nUjzjTPlaOgCUITxFw8QbZwDtTwP4JE+6VOO1+icyhks7eYzJjnJyiMG0cSQjs
 NRQJEuwuGUualOG4bJk88H9Seluak+6O47XOaoQwNjWp22X7MJ8UvAqSqBpz2KBg
 ZwE8DVOkqO5yGe/SAT8J44mZvnSyIAD6+VKHW6ol6k76Nxv71j0gbzEEW1/KChPg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hvsph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 14:30:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OEJf9d027341;
 Wed, 24 Jun 2026 14:30:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qh8v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 14:30:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65OEU6tR47972784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 14:30:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A35D20040;
 Wed, 24 Jun 2026 14:30:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D71B32004B;
 Wed, 24 Jun 2026 14:30:05 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.104])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2026 14:30:05 +0000 (GMT)
Message-ID: <da195a4a-4951-465c-91d0-4e76fd2ce5a1@linux.ibm.com>
Date: Wed, 24 Jun 2026 16:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/18] target/s390x: Move cpacf sha512 code into a new
 file
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-4-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0ufHE_y3jTrsigLwX4OBnl0S8m1B6GYX
X-Proofpoint-GUID: 0ufHE_y3jTrsigLwX4OBnl0S8m1B6GYX
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3be9f3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=nytM24UiTcO3Y7UnWsIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfXxaDZDHqzVtWY
 qi30H/r8Pb9FHeFBIiQ1vIUpiuDA/dzgSl520bjVxNlnYRRl59pmmTCEa5sXKyWaJ61xIvkSTul
 aAWYa71s0xRTrSewU4/1orKvfk8s7vPSuatrO3zzvUUuTCW4Y31lQxHI2i0QkSjLF//vN9LQTGt
 aV/rlAIr5w8DaAojCEmIsJYLJgh3a9gaYvI3heYwVTIeUQkZambS7ZwNsSeMQNDc+XhpxzqWErI
 q6oKVIxp7Z/qhLpVOUevYPYuL+WlC7Jj/3o+zPaEi5qnbCN6IrkmK9TRlDdCBvaaA9vs68GTAzj
 G06uSsp9dEZDNNA/ix/5h+oXkFHVAxgKncvAGHi/1TK8n//g1Fk7Eoyeo86RtFVys0NeO5sli0Y
 kfXZRow7eSSLwaeRdsBQudDC9lP21g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX8bczneEq9t1A
 9k7YhYmdsLS4DyBmZzaB1RLqsSeY6r02SAZz6AyD6hDE0rxlx9GDP9uNyZ1ztvlh+PkYxH5S3jG
 Vi8iIYvYGdTU+9La29lt/yI+ilDubz8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240119
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



On 6/24/26 10:10, Harald Freudenberger wrote:
> Move the cpacf sha512 implementation into a new file
> cpacf_sha512.c. Add this new file to the build and add a
> new header file cpacf.h containing the prototypes for the
> s390 cpacf stuff.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf.h         |  19 +++
>   target/s390x/tcg/cpacf_sha512.c  | 245 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 227 +---------------------------
>   target/s390x/tcg/meson.build     |   1 +
>   4 files changed, 266 insertions(+), 226 deletions(-)
>   create mode 100644 target/s390x/tcg/cpacf.h
>   create mode 100644 target/s390x/tcg/cpacf_sha512.c

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

