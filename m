Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4494DCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbvi-0007IH-8O; Tue, 29 Sep 2026 13:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xBbvg-0007Ho-GV; Tue, 29 Sep 2026 13:47:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xBbve-00059i-A0; Tue, 29 Sep 2026 13:47:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5f5l4017657; Tue, 29 Sep 2026 17:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oiS13+
 Qf10y2D/ogXakKvB5N1ccUkt7PPWqOLFvfB9g=; b=WxL5X+SPATSYT64nWLloUS
 PR/L0XGzifW1hvnrBKwNFBVqhGGdVswoqern/o8dyUnad6BKiX+d+hGy+YpMjeP/
 uduwFYR0XEO/AkO9Lbr0MiwByZiZoZqtP53Sbmsmf/oMLqgtT9bCjDjXR342Oy2Q
 XIon9dzY/Zi9q0PgZCq2MJTnpMxwFguzFKByWcHAFGDB9jJSD4yOUgZYXnQzcK6B
 x2uASoZMymvXDebueEvJNejxDMuIBD4CvYdrfBAXyLJwnFxAyGYkcpLe+l67gYx0
 j6X5INMCjEQtkEGqdF+8ngZ7I4jq7LrGZOJE038f2w5o18EdUCBhucv5EHe0PNUQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt7p2f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 17:47:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TF2DuI1667741; Tue, 29 Sep 2026 17:47:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhjr52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 17:47:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68THleVR10617350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 17:47:40 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10C4558056;
 Tue, 29 Sep 2026 17:47:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FAB65806D;
 Tue, 29 Sep 2026 17:47:39 +0000 (GMT)
Received: from [9.61.250.47] (unknown [9.61.250.47])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 17:47:39 +0000 (GMT)
Message-ID: <59acae34-dccc-4c9e-b76f-2c0e82d4a835@linux.ibm.com>
Date: Tue, 29 Sep 2026 10:47:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] s390x/pci: Reject apertures beyond IOAT capacity
 in translation mode
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260929153012.774530-1-mjrosato@linux.ibm.com>
 <20260929153012.774530-4-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260929153012.774530-4-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CXvxiogexYDCf9pE0hPsQ3k_Scbv6u4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3MCBTYWx0ZWRfX1KsQr5J5fYOi
 fcfkjGD6ajKNidRab9A+BwTe0FnzZ95/3Yarwjuatd/iaeQYBjKbdoXFrFb6r4LUWsTYEH47oJl
 hA55EqC73jBAvGyfysfFQuaxgwFZIJdjgKPzlvJlNwu/qtl9l02WIbFvjX0g/sHw6BksG+EHGgc
 VFg9muPad/dDMf6xfj9CScvtNQTDVBKeSljrG2rvR2M7WvsSQEsUQKFlGfW73cb7R4husfpsZeK
 /Iv69XTGFMuxFs02TFGh6/H95mZxfJQh1cOwzS/lMTB01wkLYiAS7pUGc0b4ImhkX0pX3nU9e8u
 58EiRtYzH/pVCFqqe38cb/QXJ6iXC7ChqUsWHrCLFdv1PIa01RmYX6TFQigTVnVPdwDIufDyJAx
 AwS85NYtA7o/sJONZhrOHzcrxss/GFkrvmXqIqjE7LKumziMlpxfk5QKjzkLuWrOJbHuz5LOaYt
 IpeexeC1bU/Mv/zhVKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3MCBTYWx0ZWRfX9IcKKirv/30M
 SoynOvG9cXvlkJL7YsYPikjh2/zluud2wtLfzjVSBl5HawEmj1MmuCo/1z3wZn0IkrDdD76/YNL
 u5YnzIs+Eb0AkPrSp5lR43MfFRGpXrQ=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abbf9be cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=umpNR0wbohg6356i9eAA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: CXvxiogexYDCf9pE0hPsQ3k_Scbv6u4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290070
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


On 9/29/2026 8:30 AM, Matthew Rosato wrote:
> In order to support direct mapping (which is only bound by the aperture
> size of the underlying host EDMA reported via vfio) QEMU reports the
> host-provided EDMA to the guest.  However, when using translation mode
> QEMU only supports up to 4 TiB currently (the size of a single RT
> table).
>
> Reject attempts by a guest to register a translation aperture that
> would exceed what QEMU can support by giving an operand exception on
> the MPCIFC instruction that requested the large aperture.  This
> restriction can be removed in the future if/when support for additional
> IOAT regions is added.
>
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c        | 15 +++++++++++++++
>   include/hw/s390x/s390-pci-bus.h |  1 +
>   2 files changed, 16 insertions(+)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>



