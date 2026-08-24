Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F72AC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyc4N-0006SL-SQ; Mon, 24 Aug 2026 17:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyc4M-0006Rq-0K; Mon, 24 Aug 2026 17:19:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyc4K-0003KK-JO; Mon, 24 Aug 2026 17:19:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJWI8L2905421; Mon, 24 Aug 2026 21:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=n7EJQ3
 /dB+uboMfq7HAkM69dHRvN2zAHZaQ1BIFR/4s=; b=jref/qFzRggYyQETa+cSu4
 i6jURF1Ck/z205fKQoxKHfX5wbQaAxriC+gGZWt/w1aq0478Sba04PqKm6xmePtv
 vCJYRpVO+1AFGBkd59UUKDZddj1QeNtw7XON+A9O8qETnhPNzQ3zHXDE9V7M+gUS
 Fo+nD5tVUrQVixUk6PEj8qEcrcmiEo8c8I7rOEoPPo8XpPgPv9jMNGv/8fPiZW7g
 hsnxatv332zF3ZNSA99lzrNkFfBzlMo9cdZynENVclb8fgOW6kK+mHifGGx/mi//
 qVIJxgxeinc8ua+BqkBUSRmCVCumS8Pay2X0lMJSILBMiv/u9Izp1+j40+H8uBZQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx424c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:18:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLBY1p030091;
 Mon, 24 Aug 2026 21:18:55 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy0an6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:18:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OLIrjS53346742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 21:18:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B1F058052;
 Mon, 24 Aug 2026 21:18:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 870DE58056;
 Mon, 24 Aug 2026 21:18:52 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 21:18:52 +0000 (GMT)
Message-ID: <0f06e029-1e9e-4242-bf5c-a4767647a17d@linux.ibm.com>
Date: Mon, 24 Aug 2026 17:18:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/15] s390x/pci: Move/rename enabled from S390PCIIOMMU
 to S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818172521.223460-1-kshk@linux.ibm.com>
 <20260818172521.223460-8-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818172521.223460-8-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE3OCBTYWx0ZWRfXzBRXDqy94oPA
 1bv6mEGcENji3bO5YxvZMZxiotov2KrGdy8HztY3XsbOSZFHHhdrGlCN6RSuHZth8YdBGTHPNKI
 Z7+T/kfyqtCWWErMjggCh/CwYiHZH8s=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8cb540 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=K5RFVuYA7s4pMnEJfqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: V3QqpMWvFySxpRbNNdGJIYU92B4rJlc7
X-Proofpoint-GUID: V3QqpMWvFySxpRbNNdGJIYU92B4rJlc7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE3OCBTYWx0ZWRfX3/HpMAVdFH7C
 z9j0GJHqBK+toniTL1kKLbq/splpcVWTdvDAqPCp0WyVAufNybhUqFEzO6GGOco4FwbJdMoOO9/
 wzPFvJ9sJcEb5ZeH5g91p82ThQfMy2VR/yRjnjg0hE8cwtRU5nFiOU9d8TqpCGQmHv/K3C12TaR
 STNP/ljbNtWMu9SV/z+HT9qgGB/7julBGuqVtixBex6JGLUCZPKc3DRjYC6O71V5CAwk9d60iEe
 K3rj0i64+EpYVYRpoh0/Krn2hVm8s4zEB2sekgLKupgkVmaC/kMXieuuXu2Z1gzlrKqIWf5aFr4
 w8++8IxiKQErN0IXicdfncy+n87c9tHiuLJuZk6adn0Ke9tzdI8AyxbZt2UijOjBbpLD8v6i3Nh
 xGctZzQi5x3rroVkI8mn18fUKRIGlIrhNFt+2EyAaNI94Rpy3d7r8wyriLcOfjtiwry1lfzUWkN
 3PDnYccu/iLQWKnTIxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240178
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 8/18/26 1:25 PM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.
> 
> This also allows to save/restore this field during migration.
> 
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
With commit message fixed as described in patch 3:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

