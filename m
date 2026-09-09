Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9484CC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4MUT-0007aQ-Nj; Wed, 09 Sep 2026 13:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x4MUR-0007ZJ-Ap; Wed, 09 Sep 2026 13:53:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x4MUP-000441-H1; Wed, 09 Sep 2026 13:53:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689HVZJT458820; Wed, 9 Sep 2026 17:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0tBjhK
 eHxcQrO8ZzknMj/BTfmqLxBaWVca2Au3R8rgg=; b=pRPnwwDedWC+xxcmQmnOlC
 avYPHWvuhhMI8iGECNCPqmXa/aJVhDlyP/RCtj9JPCg8ZcOzRrllwYRRpASBT0Fs
 ByTCrNDS/3v6n2lsdc4WmE55HdYUKB2IOLWQFoB6mL2t8RqwyVY1HTtr6bLwbzn7
 loIA9W1klGbmHQL7vUu/Dlo1SE2MlXgC9T5T16K1/dvDHamtoVQ4JFIRcOK9pozu
 0SJN4G8cz1QYHBKtqHvTeXWPkF8lde8WutM/yIf0vaHCba2U2mbM4wOV0/BUGeEv
 r8C3OzeSlJCqg1noR1jnlAgMuo15JRW5oVkPi2oUaI3c3WNCcAkvF7BGXdaZkDBA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf47k7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 17:53:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689HfEC0026674;
 Wed, 9 Sep 2026 17:53:36 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdk3qy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 17:53:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 689HrZLI24576540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2026 17:53:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43E5658055;
 Wed,  9 Sep 2026 17:53:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDF0458059;
 Wed,  9 Sep 2026 17:53:33 +0000 (GMT)
Received: from [9.61.48.189] (unknown [9.61.48.189])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Sep 2026 17:53:33 +0000 (GMT)
Message-ID: <8cef8453-3c25-4e4f-a92e-2dc1c23d5c19@linux.ibm.com>
Date: Wed, 9 Sep 2026 08:49:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-2-zycai@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tNinnhJ9mbt8RxM1eQJt1_d6x_QainzO
X-Proofpoint-GUID: tNinnhJ9mbt8RxM1eQJt1_d6x_QainzO
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa19d22 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=_q_ucG0t3VmhI-TeMEQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE5NSBTYWx0ZWRfX+CQfEst9tRxP
 Dou+E2U8gaTOYqadBxhS+DN4rXZ5g6BnLhP3btMLB/GA2TkXi9/85IIP/O4v4D6nI5bZDahO+Lc
 mR7FigiAbNiwPjy70ok6u9cpFpokH1Pp4CZkEig+Vvc41Kz1AOU3zYnhp5PgxWPFceQ+Ceyd9+2
 butum/mTemJOx4Ig2Q3FVibsdVZCEEN2YBcKDxx/HbylATBp2M63+p2ERbIybNRfHgajIAFqGaU
 fG/CB0g/VOeDun9woLKsVZL/kD9X9NjNTL/eigljTOIuCQ7tvfZFdqiEKV+XpB5soxrQKd9uuep
 s+YkhxNiGMV9S6IbjT3IuP8/iOF4/P0F/3nDrbAfXqmZPpXSreONcGkD/6r0TPZ7AgFF/B23mCC
 b8lkggVdpIgEw2cCDVfVmm9dcbdt/op9vqz3MXbFLqBothyIBOfA0EG4p5j2J1BHuQ5LYmEdcNq
 4IiA8xagub4t9bTpsXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE5NSBTYWx0ZWRfXysgoIdBpEpl2
 O0H2Ed1Yt8IysCv6NEAHnyVPC9zaanc/pBfBb3GR3CCyQOrj6CvtdQ9vtmoYT1RQE6lm2fz8tgQ
 JrVrixgfRnFrROocUATOXku9haYy3t8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090195
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/3/26 12:24 PM, Zhuoying Cai wrote:
> Move CCW-specific virtio_setup() and find_net_dev() to virtio-ccw.c
> to decouple the generic net boot logic from the CCW transport.
> Also update the error message on failure to specify "ccw net device".
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/netmain.c    | 67 ++---------------------------------
>   pc-bios/s390-ccw/virtio-ccw.c | 62 ++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/virtio-ccw.h |  1 +
>   3 files changed, 66 insertions(+), 64 deletions(-)
> 
LGTM

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

