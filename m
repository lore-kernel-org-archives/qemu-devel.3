Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0954BC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtq84-0008Ja-2Q; Tue, 11 Aug 2026 13:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtq81-0008Hz-Ub; Tue, 11 Aug 2026 13:19:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtq80-0004xf-Eq; Tue, 11 Aug 2026 13:19:05 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGWFPl965413; Tue, 11 Aug 2026 17:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=upkg8g
 cf2rPFrf+krmG4hzps6hY/YPvNjAB9lHs9PK4=; b=BQ9WYBE6jk/RIDmXuRbhYV
 7aYsqq+oRtZcBgZmPI+DU9/9OchBfsSf/uMnCZG926luK0WkkM4Div2SgBA0wJtQ
 uGEAZlFOB8KEeUnvt595fJyU/MtqvRl/ZKw2AuRM8JBqhLvCIFPyhA6fO6WLUIFG
 sWzPixwtn0khagEvFqzuEx3QuadKdpSfxL+hX/C7skEKj7K3el5kzmRnMJo/cXaL
 U5lmvMGHGmTEMXuEbbcrsFUa/M0c+X78oYtKO52KzRS0cxyI4Olm5KJQGIigm5Q1
 9fEF7CUvQkrDIfRXiu3v8Xz8D/AvDQI3Smu81V2Of0ThQx4bOl/rIOb6LEf2r43A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw5g0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:18:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHBUfn028428;
 Tue, 11 Aug 2026 17:18:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjsy6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:18:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BHIvfH30278192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 17:18:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DBCD58056;
 Tue, 11 Aug 2026 17:18:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3D0D58052;
 Tue, 11 Aug 2026 17:18:56 +0000 (GMT)
Received: from [9.61.240.229] (unknown [9.61.240.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 17:18:56 +0000 (GMT)
Message-ID: <5d600672-98de-4016-98bd-8f2bfd2e6bce@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:18:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/15] s390x/pci: Move/rename enabled from S390PCIIOMMU
 to S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260807170812.658820-1-kshk@linux.ibm.com>
 <20260807170812.658820-8-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260807170812.658820-8-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b5983 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=NT-D918DeMxGRRny-ogA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HQJuSUjuPn9u4I_NRiYqE4iWOOY_Wq3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX9X6QKyiyoxxP
 b2P/oL2qZtd+W2s3KsdbkYxi7+AXhsakI6o5aPdrJtq4g9mLSdVwZdT7DackabsaKRKgyQBS/72
 bdmHye5WEAEd2VSw0J6MsxeantX4wlwmjHaJ3HTnsr/Hf9HW1hhKltl4TgFa68LOUuu6O7FUQ0+
 x/gBbzLLVsEdBrM8lOwiEySABqBe/w2yQnVSHOEku9L4H3bNGwzQaMLut9lU07o3d+fnPjVVMcm
 MDv7lreCK3L/vBn776Vcke7WUzvRv1H3UTakjelQlbAquJFCNE9EMKrg9xOAjio39xK+Jx+fqMf
 7xZUUZFlA9YWTjcqSUsUXN9NDv2dctGW5WY2mkzqRt2ff5gKvD4Z7sXBMvlaBshhCnFedgG1Q0/
 66HSvTiOHnowaUErGnIgu/R+VECqflPlTPcdMG7V6WYB4QDw37Hadezdiw/jqKZ+26DItgtyXfX
 rcdzUuaFKn9M35TDbaw==
X-Proofpoint-ORIG-GUID: HQJuSUjuPn9u4I_NRiYqE4iWOOY_Wq3Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX/zuivMbkQNoG
 WnF8TL4FbV9xvZy1UCjgT6u5aNXlMP04D6IK3uYcePu4ik4oGYd0TL7coTr9F8BH9JOnt4c2PJ8
 fa4sCmGXFJDkgdBgZ1XHD6gNG2Li2uo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110142
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 8/7/2026 10:08 AM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.
>
> This also allows to save/restore this field during migration.
>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 14 +++++++-------
>   hw/s390x/s390-pci-inst.c        |  8 ++++----
>   include/hw/s390x/s390-pci-bus.h |  2 +-
>   3 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



