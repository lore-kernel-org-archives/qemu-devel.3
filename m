Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF73CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyYD-0002qi-1l; Wed, 14 Oct 2026 08:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGyY0-0002Y2-AR; Wed, 14 Oct 2026 08:57:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGyXx-0001oS-FJ; Wed, 14 Oct 2026 08:57:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ECJAIR1774676; Wed, 14 Oct 2026 12:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SFpIgw
 5RQXR1TJOp6l/f/qCT5vKo7yKr5BzwuDiCpd0=; b=OZ5mlcRwX247ZfpRW7enQl
 g3HxXaGdFWJz2PtMwyKRih+zAiQrte5dO4eQzgh5xulHCQd94dOzIsu51BwQyk05
 YbrqldHx8TdTQaTzL9oAP6bt7TTkm3gBtwulhaLZu8tsS+7h6Ad3OxkS0tLccnsF
 K3bUwLUPVkvrHwxEOyDVi3pjgXWaSKFMv95gYw/BLIx5Uk96Jcfsi0qsMBIBdadK
 ax7VaxDIP4W4KA0VSmfCZ3qxmFVPPHQq6WPW//emYciJ64p0+AjdXIdFO55KE8D5
 xzmb894U+uDLLnaMtfNcdma4DQiFz/hwdDSCA+l9syQQ7N+SMSPTGB4N3yK+jMVQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwj3yat-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 12:57:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EBFEKm2709272; Wed, 14 Oct 2026 12:57:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h7bdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 12:57:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69ECvJ8R43450672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 12:57:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3333D20049;
 Wed, 14 Oct 2026 12:57:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E55C920040;
 Wed, 14 Oct 2026 12:57:18 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.31.234])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 12:57:18 +0000 (GMT)
Message-ID: <eb426f52-d4da-47b0-8c69-c5db6b3a1914@linux.ibm.com>
Date: Wed, 14 Oct 2026 14:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x/tcg: fix register update on guest memory
 fault in cpacf_aes_ecb
To: Andrew Holden <andy0x48@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, richard.henderson@linaro.org, david@kernel.org,
 cohuck@redhat.com, freude@linux.ibm.com
References: <20261008154455.369004-1-andy0x48@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261008154455.369004-1-andy0x48@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MCBTYWx0ZWRfX36+vtJeKIfGc
 dAzsL5dffyZcplKN5qCoEQTKncm4STDcOQ5U1cjQ1tM1JFDNif9gRcOvsBXI9voGrPzdiG8WbSs
 K0TvnQyCA8cp+5AhT4WTpMfsoMWKxhxAlF05wDBXH80ytfX7kHnF3mKim5nSGDAam8GEd8qBaoN
 lBGUtVRACs738vcwDnwyRkVqt3kNJgBKlfoH6tar67gobe/uivCY3KCCKCzGYXIkDdeOcNvry7O
 DOIRreP8vAZIE0zSpZ7XyOw0l+MCfOSk/aF6I2siG7tx6o71cohcX7g3F6YARQn/kArJ/PJIFql
 aTJ5qiPHYu281u1+es8zIG2MJZ1n7LHEB0lgx4Bo2fqIoiRwreZNU0mu1Wq53eLl+CFptxd1iz3
 iyt7H7KeHGGlPp2WjFYiy+TGR9r9EYpie6KR9FEfnnsr8oxYDuExMb6XwkbAmr78YsnhATbSj4H
 uKjNNf+jVK7LWjtBFQw==
X-Proofpoint-GUID: QXVL066XCrHzqX0OyAMsOMfROn6Qu9fm
X-Proofpoint-ORIG-GUID: QXVL066XCrHzqX0OyAMsOMfROn6Qu9fm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MCBTYWx0ZWRfXx+L2PU/NM+pp
 AE7jrksZxxEkHyF38muksZ1FF2M500EjDtjWk/HivFu8JE8MIJEEYpPZHLk77A131YpY2ps3l8P
 avbs1t7oDBV4FIJAsAhnWHczB+Jv1W0=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acf7c33 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pYz2OXkNAIB79UDkkJEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140050
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



On 10/8/26 17:44, Andrew Holden wrote:
> The KM instruction loop in cpacf_aes_ecb() updated the source pointer,
> destination pointer, and length registers only after the entire loop
> completed, using a 'done' accumulator. If a guest memory access fault
> fires mid-loop, siglongjmp unwinds the C stack before the register
> update is reached. The registers then reflect block 0 rather than the
> block being processed, causing the instruction to restart from the
> beginning on every fault. This results in quadratic reprocessing and
> violates the PoP requirement that registers reflect partial completion
> per block processed.
> 
> Fix this by updating the registers inside the loop body after each
> successfully processed block, and removing the 'done' accumulator.
> 
> Signed-off-by: Andrew Holden <andy0x48@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf_aes.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)


In addition to what Harald already mentioned, it would be good to contribute
a linux-user test.

