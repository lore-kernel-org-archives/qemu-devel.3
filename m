Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CB8E7DEF0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvLh-0000Gi-KJ; Mon, 02 Feb 2026 09:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vmvLg-0000GT-4p; Mon, 02 Feb 2026 09:56:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vmvLe-0004di-Ib; Mon, 02 Feb 2026 09:56:19 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 612EHR2f017333;
 Mon, 2 Feb 2026 14:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NOMZ/P
 q4LxMTJi08jNS+9WtSVOm0ii5Q/+0EKheSGj8=; b=tifSffFzAO0dgRTzQcMZSl
 UsCFNsFkwR4lspSjTlhur8V/7pdRvZYXAZLr6SjpUxVgQ1Dv2/jWhaX/BdL4feZG
 Uu8HKaft+CLdB8s/3oZirKExrLlFvBZRMJ/Cyrm3QBmdZKjoGWKSiSfmEqL1xNMF
 DcN2AIo82jqx+AdU6S0+843vNQQoCygjBYi0p49MiLO9dIcPjZAo+Qxt7UPGW07K
 fh1v0Sib3tWR381WILfY10e5Ck6HGLutsWS+a8DskwSV/kHkrQLKq7VtW1QTEUGb
 U7PBZ/HLdmJfKiiwP+ptj+uYwqRgaXI0MVgYlrh1WDFCIFHjK7ukP1lhjseT7BrQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt0vyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 14:56:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 612DZHUJ029052;
 Mon, 2 Feb 2026 14:56:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2s5kd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 14:56:14 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 612Etq9U16056962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Feb 2026 14:55:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 245805805E;
 Mon,  2 Feb 2026 14:56:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 958975805A;
 Mon,  2 Feb 2026 14:56:11 +0000 (GMT)
Received: from [9.61.91.248] (unknown [9.61.91.248])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Feb 2026 14:56:11 +0000 (GMT)
Message-ID: <08158c5d-b133-43c2-b7bd-5437f48a70ac@linux.ibm.com>
Date: Mon, 2 Feb 2026 09:56:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Replace backup for s390 PCI
To: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260202144702.1783102-1-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260202144702.1783102-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExNyBTYWx0ZWRfX+hbGdvWxCr4E
 0upGnhbcL5i4pAbP1N0b2mNhjH9FwrxORxA6b7EhVXNNUPMGtuPS70FH5JnIXOCkgES83cU7UrY
 u7lQQojMKPC4Hh54VrK1MW8firokogrW9bAX75ohTEcxVaQ1BAUXfJMwrPbxswqEFDZMvOuN6Af
 O1zeQt6orMoWA+7v1HokA/ButcYVQVo6PmmsF30pRiRxdGkI2IO3jplDFahfEdpaxj69/jXu9ZV
 soOzgr91Sdcr0zOhCHirmrcLazMgMhQJ0C2kYQf1jB6B5trt5mmx2vWuxep9JGEor6goua8UVXi
 caUh/REGnV5g9zDH02lj4mCnIsGU4CQMDgxtiKZgdCYpMibo6lVo6/9g+3ItLpLJ4UszXwVPa+w
 zZbRQP/1J1wFdD62MLpu/JcOoXDmT+fvUm6cJDKr/yhZtmGprSpoj/KHSU8fwTYCxbwHKT2ki+I
 9Y77IRk5Q7HpIyrrIaA==
X-Proofpoint-GUID: w7kE-ZmFDVjrYu482rZnbwSac_FZGfM0
X-Proofpoint-ORIG-GUID: w7kE-ZmFDVjrYu482rZnbwSac_FZGfM0
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=6980bb0f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=STK_0p3wlTkmVyiQI7oA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602020117
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/2/26 9:47 AM, Eric Farman wrote:
> Farhan has been doing a masterful job coming on in the
> s390 PCI space, and my own attention has been lacking.
> Let's make MAINTAINERS reflect reality.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Eric, thanks alot for all of your help with this area in the past.

Farhan, thanks for stepping up to help here!

Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b7ed4fccb..32d60dd673 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1862,7 +1862,8 @@ L: qemu-s390x@nongnu.org
>  
>  S390 PCI
>  M: Matthew Rosato <mjrosato@linux.ibm.com>
> -M: Eric Farman <farman@linux.ibm.com>
> +M: Farhan Ali <alifm@linux.ibm.com>
> +R: Eric Farman <farman@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/s390-pci*
>  F: include/hw/s390x/s390-pci*


