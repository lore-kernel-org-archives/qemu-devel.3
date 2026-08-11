Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1120CC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtq6r-0007Pz-FA; Tue, 11 Aug 2026 13:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtq6F-0007NU-Fj; Tue, 11 Aug 2026 13:17:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtq6D-0004bS-Ui; Tue, 11 Aug 2026 13:17:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGVUaV933553; Tue, 11 Aug 2026 17:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JUCCKl
 rk0cGSEVj7PQurIQNWz3hwMaWsXIpMwJbZ14o=; b=MCbleiyohTfiaHYzF4deez
 1cPFw0H1BDLYhaT41vbtDfIJY8Q6Jlllt+BTJvo5w1p8SG+S8UzKzmrOc2im3reO
 iPllSayhnEPQ6LU58t+7wpFzCxm12xGDV5GbGNp5/kQa5txCAWc9YNarMlBIZcXY
 n557OCe0h54dbPZOduON8v2fgDDnoVK8WNLUhL5a6TXZT7kTcDxSGM0/egHDbcUp
 xfMSK+I2UUXkfQC0n/efAxixgJslcV6HuG/3uHcWvAwKJJO9j7h3ymAZQ03bhROC
 54m9p8azxYKM1Ugc4BU1/gYZeKM1xmPMtHlzvX/l8CjWebW7FF9JMQHJKtXwC5dw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9p67a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:17:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHBLu6010629;
 Tue, 11 Aug 2026 17:17:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w21vn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:17:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BHGR1Q9634438
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 17:16:27 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28ECA5805E;
 Tue, 11 Aug 2026 17:17:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6087158056;
 Tue, 11 Aug 2026 17:17:04 +0000 (GMT)
Received: from [9.61.240.229] (unknown [9.61.240.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 17:17:04 +0000 (GMT)
Message-ID: <b93e4d10-d6ec-4686-9819-0f18da4e2632@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:17:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/15] s390x/pci: Move iotlb from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260807170812.658820-1-kshk@linux.ibm.com>
 <20260807170812.658820-6-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260807170812.658820-6-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfXyXbF0k3k5oIn
 exmGe8m1AuhE+aZT2UWlwIEW/eZQ3C4BVfwOxQFkv3R4SzUrkPP5wExiFhLfdQHkJuB3jkl/HbR
 KLA9FMPWH9kOJYseb/RlRKkzVgniIy04qTyHWGzqI6hEd+86eos+Smf8rlC+nhFdf9qKB6F1pUx
 df0oE+iDqUyUEpnWsaWjt4wvm5lbxkEInMVYuEbQ168W4L2AKinV/VaLnYpB6JgvN9pg2lbHGgr
 CO/Yyi01a6qBfxpHlVKtly2Mx5ewULHEreoIpXt6aKwLI0oMch489+YPy87o67HCv3Z+a2ar41g
 PgBKNfEuBd6T0PzU473mRT0SXgOfpEgU4eUfK/ykef6kUn88rySVtxIP1kK/T3XOsUriNsUouv9
 8+LNpSJVbkyvYKpINkGn7DlN4k5ygI4u00IXdx2X+1S9JAv3Crvm57pEGJYkde+KxMVnEJSHGPp
 0SesID2qo1PWz2mUovQ==
X-Proofpoint-ORIG-GUID: OO5-oPNz1V52IOR8zGWlZgt4IvV3R2jm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX8dEVfpntgfDl
 huFlpSvCt1zTI7itjJ2Z6Dz8S+MGS1H8XXLppQsgemwd2Q0xQc0PZBMP3/rs0Bc5SLnKlvVV6XT
 fkfnSdvrLsfUvQd0ltpkR1LGu9GrUz4=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b5913 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=NT-D918DeMxGRRny-ogA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OO5-oPNz1V52IOR8zGWlZgt4IvV3R2jm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110142
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
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 10 +++++-----
>   hw/s390x/s390-pci-inst.c        |  6 +++---
>   include/hw/s390x/s390-pci-bus.h |  2 +-
>   3 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



