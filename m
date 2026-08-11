Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F643C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqRk-0004az-Ux; Tue, 11 Aug 2026 13:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtqRW-0004YM-FR; Tue, 11 Aug 2026 13:39:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtqRU-0000Sb-Dx; Tue, 11 Aug 2026 13:39:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGW229890268; Tue, 11 Aug 2026 17:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=921nNk
 Sr5MqsoxS+g9JCBxW6JuKPuyFlzsdIjArBhq0=; b=GAFYvihtHb07J7uYpVYchA
 HJkTDGBrhTMV4RsHkRdEzKU7SpZ303pwsiMXASoZTlyBm/jgCZ8Iha6PpfWc3yQZ
 +9sOT7yKeKmLdo6JEwP9NtfvP9XM0Te97zSoCogeUOwxR9tFzkKEj8ays9FAH4el
 HWq1lNboDImZUrd4Ij6hNDumir0RVOnq+5cN0w0O3PM58lZ7Nlcz5/2dHdCFx32k
 h5ZKH9HLFwUF52U3hmAM5A54RT0VrIQRoQFkxgIauUP2dQeTqok+Enwel+aAathI
 B3pE6mYvntQU7niWo1VfjLOqEeRLCpuuz9R/TgtNu5IvNFGsAWgZ9Ep+RFI9xVSg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9e7cj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:39:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHQHen015205;
 Tue, 11 Aug 2026 17:39:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g9vfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:39:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BHd6XY9700042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 17:39:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C443B5805A;
 Tue, 11 Aug 2026 17:39:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E658E58056;
 Tue, 11 Aug 2026 17:39:05 +0000 (GMT)
Received: from [9.61.240.229] (unknown [9.61.240.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 17:39:05 +0000 (GMT)
Message-ID: <20e98555-db6e-402c-96b4-c90a329709e0@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:39:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/15] s390x/pci: Move max_dma_limit from S390PCIIOMMU
 to S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260807170812.658820-1-kshk@linux.ibm.com>
 <20260807170812.658820-13-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260807170812.658820-13-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I_VKvQzWRBkT_YtTznM5TfusorEpEEZE
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b5e3c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=NT-D918DeMxGRRny-ogA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0NyBTYWx0ZWRfX8lp5w5Ru0uj+
 KLhU6cAwYssG2UxCJBhaPTv84ZoOisLPeOTKNf6TNTBAat8q4BeQThvJOT24DXwZZ4EqFWTsuDF
 2HJnIXiZfmwRJo30O8u/qhLRbiLK8eZo2TYJPrQVOhcR8+NaxkqBuyL7TS5U5cSGgGOSGmu1E8g
 V7uL/OHuvdAKqwxPY6Csie/Mct8EXMzSm8uUV/YrfO8jTTa9CNiDWtDSBJYXA02Sv5okhgvoSUC
 h/jzcF6hcCwsTUFYoQjj/+J3OTaFQI3+j2viEs9L8jnKr5pMoWzM2VdDCenDDp7OodbxiXX0Eex
 ltNJBcB/+CvPRBgWMgBlfSu5ioS6I05ThQ4GaJRyvqd8rU31uxILfPCP5t1unMIeOPAD7SHahAR
 bC1Bfoh4i/eBB3/4kIGZp8A6UeUoY4vcSIzYn2b0xP9LU1FWBmxtvLiJSWDGls+XgAZoDsCkq4u
 UoRwcqUyfrY1CDhWxnw==
X-Proofpoint-ORIG-GUID: I_VKvQzWRBkT_YtTznM5TfusorEpEEZE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0NyBTYWx0ZWRfX1uQeyUIXuXtw
 QWlmC5On/rGYYSvmJtFH+9G5HXhIHUux2fIjL6wz9IncXr8ku+s3mFPF3YfZSo1c1e6o4rV/TUt
 CHJkjyqX8x4lg35Npbe32zJw0/UjSrk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110147
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 8/7/2026 10:08 AM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.
>
> This also allows to save/restore this field during migration.
>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-vfio.c        | 4 ++--
>   include/hw/s390x/s390-pci-bus.h | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



