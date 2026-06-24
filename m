Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56234CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcN9k-00067c-Dp; Wed, 24 Jun 2026 08:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wcN9i-000677-FA; Wed, 24 Jun 2026 08:56:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wcN9g-0008H8-Pa; Wed, 24 Jun 2026 08:56:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OAn2oM562336; Wed, 24 Jun 2026 12:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L0Tf7p
 Th20Nh40eQ/2RakmStbSdoVnFscjmsQrWoQ7o=; b=bOxhBONHzVz9oJ2F5s2hLY
 ebj/fboggtnQ5f9+cqquXygO+5UUr5Oc078kWkueE+lIb/svY59bzVCkXEVUNCHo
 zcZBoEP/a3ViIbbsIP0inEl8MknT47BPjnYSlPQ/QqIJEp/mQa52iF27SMEH+sZt
 vaSAiSNM+d7IzdMyk/9EyUzZM9z89La2o0f+5flhx6BXvg2FmK+dG0G9HcUVJbsu
 pra+Di4un3yCDxwzKP3fay4fjjplSOS3VBm8sg2RT6Gb81wq+92HuzVdJx8aqMs8
 kBijfcI70WzCdAhrMrvT3hA51avtKzxqCrj2akvF1s/78sIc7f6TQ0QJWxsxZWBQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsuw2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 12:56:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OCnkGd002546;
 Wed, 24 Jun 2026 12:56:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg8bxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 12:56:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65OCuJiQ43057440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 12:56:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BF3720043;
 Wed, 24 Jun 2026 12:56:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EB8720040;
 Wed, 24 Jun 2026 12:56:18 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.104])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2026 12:56:18 +0000 (GMT)
Message-ID: <e516de9c-e9fb-45af-aa5e-8cb9dbf1e3f3@linux.ibm.com>
Date: Wed, 24 Jun 2026 14:56:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEwNiBTYWx0ZWRfXzyiPplXsq14D
 NMuf2UjkTZU7sdEWTGKvzTZhjHYPk9YIk5CxU6ENNtqrgsY4L1BqOyVFSvMTcjUzOmqXIldMg02
 CamBSjLqQm2rr9gZ6lMijPZS3GFnKgSl3u4r3v0TpcvYBQrKf4Ik7+lPkxzFYw9IIXWHBaswPtV
 smLPCtvSTrCwxSblf0MOgDQub1yn9o8iHM5bv9yBW6cgcUC7jegeeaNEwAaOox/jj3sOVjJ0bsA
 mVAHuQfIDc0KInUGYVmEzVLEPnA7182pvW0UMScY6Hw4VqdT3tXQB/ZOuT1aZtz6RvyiXTGewbg
 FDoIxZzDNQvh+YuasZs8G8GjkSCJkV5DOIfv6Ub0FxDQnsBmfNUnb7nMhsrEAHvkI8rYAFuAxaC
 UeRkxIO/hbWRUH7r7cM/izuwgX9nSg==
X-Proofpoint-GUID: y3bp4mlRxJcW5cmzwMn-AoblMJWYWv6o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEwNiBTYWx0ZWRfX7h6+BZcSH7J/
 reLQOY2p1gO6OOR4x61q2GJUb44srojYY0e7J5dYqnUpVs/dZGcQZnLeJfxi2KNGuyi383tCunF
 5GGhyaS/rRtoSIyFqq6fBSTgUFZhi/s=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3bd3f8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=KHZQTp77v83W7mwugnYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: y3bp4mlRxJcW5cmzwMn-AoblMJWYWv6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240106
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



On 6/24/26 10:09, Harald Freudenberger wrote:
> With the introduction of the address wrapping function
> wrap_address() the result can't be used to walk the
> source address any more. So introduce a new local variable
> to hold the wrapped address to avoid mixing source and
> wrapped address value.
> 
> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx argument")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

If I take as an example AMODE 24 and look at the third loop iteration,
with the current code in master I would get:

     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff

and with your patch it would be:

     (addr + 8 + 8) & 0xffffff

which is undeniably more elegant, but otherwise looks equivalent to me.

What is the functional issue here?

> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index ae392bce0e..29ad2aff43 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
>   
>       for (int i = 0; i < 8; i++, addr += 8) {
> -        addr = wrap_address(env, addr);
> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
> +        uint64_t _addr = wrap_address(env, addr);
> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>       }
>   }

[...]


