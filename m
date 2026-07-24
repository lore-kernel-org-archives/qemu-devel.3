Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEADC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 19:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnLXC-0000ZN-SN; Fri, 24 Jul 2026 15:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wnLXB-0000Ym-8H; Fri, 24 Jul 2026 15:26:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wnLX9-0000yO-M4; Fri, 24 Jul 2026 15:26:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OHCvsg2451556; Fri, 24 Jul 2026 19:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mstfAa
 iuNlvB8q+o0QTcEj/BATRmOqAqTFMSyrHwDfY=; b=h5O9y55hxtPoMVxZf32gEk
 GieReLYI5hR9b/4CgaUcfQ4e1B+yHnJNj95+drKgQMSuc/VJYb/D1jB/NDuEPWBu
 gmtnN9/Ex4cgxGJJNcWIiCgl1LsJk8jVDpu5GECTw/szy5PiJs3mp0DJK947+CHV
 NahVCGI2JLeWaSuSlcOYBmn5PFIX4fNDAL8Aech8ifugwf/+xopdDi+azoohGBQz
 e8HwgMUZa2svY9b4TA+ayeJuD+mKW5e/irWwEHbFjPsJyob+hUm6HvkyHLwGlg1J
 cN+MeBI1fjqwWaxbRlAtUxLv2VS5CxTPq2SKRag7Fgoqp2jB54XMdT17uRYjKsaw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h01kfb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 19:26:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OJJes0006906;
 Fri, 24 Jul 2026 19:26:06 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtkab8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 19:26:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66OJQ5MZ30802616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 19:26:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19F7158056;
 Fri, 24 Jul 2026 19:26:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E96958052;
 Fri, 24 Jul 2026 19:26:04 +0000 (GMT)
Received: from [9.61.253.58] (unknown [9.61.253.58])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 19:26:04 +0000 (GMT)
Message-ID: <e04d3e9a-3a57-499c-978e-84f6dac39267@linux.ibm.com>
Date: Fri, 24 Jul 2026 12:26:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] s390x/pci: Move iommu_mr from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260724030919.123733-1-kshk@linux.ibm.com>
 <20260724030919.123733-4-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260724030919.123733-4-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a63bc4f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Z_9tqueNEkMZuojxhz4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VepS1r-ilhaM0DDnBCjbtmETQsUNG69Q
X-Proofpoint-GUID: VepS1r-ilhaM0DDnBCjbtmETQsUNG69Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE3MyBTYWx0ZWRfX4e/JD2QIMisa
 xHZl0LAnY30MaBgYfi5S69A2zClKzvSiF4RYJutMw2v6pcDYo4YJ0+AIMV/CcgFFIFuFScTTlhx
 3QHqq8yivL7FA6TkWEDQipoaz/T7uX1R3I+ITyv5dZxKTFM2ObXaLLUwAhlnitn9FvOeh53IYx2
 Z307kWlExFbsHBEB3abihLZQfJHuDpjWxqeNz61DSWXYlwLEMrCA7JV1nR0G0ylaS7l9NkvECVx
 OMh//wvY4G6l2Y1YwBq40/5AbQBoG5+rnhIyO1ZBk8ryNqFFp3aK0UuwUEJIaaei7SBdTzj60rG
 DTul4gOQ2iI99msQBl+cy2cW5mlT7Qw/kxswokHFmG/Ii9GquHUQ1CjVyCN9X6rBNhkEFei8D+A
 HPzSrKSnYfm1yb2SqVAOGxe4FCCoHWqQvoiPM9Xk/cl3kqEK3lesXZ0x7+s0mNXFY63O6aiXqVq
 RIUpOQz7VNvfc6Yh44w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE3MyBTYWx0ZWRfXxwYGs+2jnjaB
 GBT5bWA4YCkm3v+r8E8lLFEw2a5EcXOa5CgOhrcokwhjG9zkQ+CW4J4N5Dj5NkBUAL8kuhnMcdv
 EEB2AqQ2qjcgwXteSSoe13h4OxkNveI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240173
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


On 7/23/2026 8:09 PM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.
>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c          | 32 ++++++++++++++++++--------------
>   hw/s390x/s390-pci-inst.c         | 28 +++++++++++++++-------------
>   include/hw/s390x/s390-pci-bus.h  |  6 +++---
>   include/hw/s390x/s390-pci-inst.h |  4 ++--
>   4 files changed, 38 insertions(+), 32 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



