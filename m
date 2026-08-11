Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B917EC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqPn-0003yq-Fj; Tue, 11 Aug 2026 13:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtqPl-0003yM-SI; Tue, 11 Aug 2026 13:37:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtqPj-0000Bd-Qw; Tue, 11 Aug 2026 13:37:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGVQGp3260508; Tue, 11 Aug 2026 17:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xOSe2s
 fHx43hwbcxhIq9JDxS3aXGAYUKGCXBL1qzdMM=; b=KIfdqRb9aMZrbXGeBUcprU
 zT/da4a33cjnPY657YwY5nOzZcdvVR/DDvQphFBaBPHgUrzBXi8E5JPO/htUZOC0
 IJ2XA3ES802an9GShvEM25eOCniwykzeRWutJRrcP3L8ln/HFFqa31kMh898aNxy
 aqksQLBgeOUBojO8rBCRJUPi+ky5Dw/RbWGNG6qMD/SPvROAFNtFpf5zZXfF+qlZ
 8a84y25kxlUxV7kq0aD9G6wrxjoiT11k1Zj/nGc621893aLLfOQvgWmrjucLYf3s
 MfnRQX7UYiZ5zis+D1f55P8RZmEB8cWiNAQUEnhKL8sWCv3rhjihFDA4zPPcK9cw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyx7am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:37:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHQFqn000639;
 Tue, 11 Aug 2026 17:37:18 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1t0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:37:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BHbGqr17367762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 17:37:16 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B6DF5805E;
 Tue, 11 Aug 2026 17:37:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 987CC58056;
 Tue, 11 Aug 2026 17:37:15 +0000 (GMT)
Received: from [9.61.240.229] (unknown [9.61.240.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 17:37:15 +0000 (GMT)
Message-ID: <22a22779-ddc4-4c46-89e8-a15945412f7e@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:37:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/15] s390x/pci: Move pal from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260807170812.658820-1-kshk@linux.ibm.com>
 <20260807170812.658820-12-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260807170812.658820-12-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0NyBTYWx0ZWRfX2IGF3mzywyfr
 y40wECyHXiS6VlA7NQsYHTsgd+9Yj0qwDyyl4aQJBIVmDaKVtS33hy8QOvwlkajazScdomlyWaM
 R9kN9tdo3x0DkgeLpQxYlaqsJwMriy9h9YVrpGy/MjA3BlYQXqTYZd++VWgmueiocqv26JUx0SW
 6vx7qkK0jvJt5FRUeG7t33bSsD0fyaZc83bZLsILEOPoMnJ/ie06opfSOalJY7RJTQcuaI3qDJo
 +on0t+nRP5fWypkDAOv5oPpd3iur22bIZmagPxUVHjR/WLmJOJzhHDIPMTNaPpxDJyH6G77EZcK
 lrKYxpVIrq2OwU13LR/+OoqmrgnRQnxKYcugX13h4w8yEW6dQkSeB/Z/PsJLoG9Xmx9vtCGKInm
 oYuVMvrr/xpDmX3fTKIdRqVO0nw1/VALr9D5/UK5ijuw9jyn6+5oUe1vWh0kGUEiHpdGtSBtEzc
 qFgkVAyEjZa97S9yIMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0NyBTYWx0ZWRfX605LnyHXo/ZR
 46no7wQEqwiW1CE7Z5p2+6iF9ItIHLRqqa30otGqf4eqnTwo0C3w50TZA585xNq7SOxUgtKAfqj
 CCcxP+HlsDrZQCikAidz4MjRuCp3JBc=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b5dcf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=NT-D918DeMxGRRny-ogA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qOs2CcXCIJSRRHApgS-sZa1bsHZGSyPG
X-Proofpoint-ORIG-GUID: qOs2CcXCIJSRRHApgS-sZa1bsHZGSyPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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
>   hw/s390x/s390-pci-bus.c         |  8 +++-----
>   hw/s390x/s390-pci-inst.c        | 14 +++++---------
>   include/hw/s390x/s390-pci-bus.h |  2 +-
>   3 files changed, 9 insertions(+), 15 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



