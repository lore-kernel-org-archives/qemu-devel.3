Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F7BE7DEF0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvI1-00078A-Rd; Mon, 02 Feb 2026 09:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vmvI0-00077l-Jl; Mon, 02 Feb 2026 09:52:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vmvHz-0003sJ-3t; Mon, 02 Feb 2026 09:52:32 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 611NXhun013535;
 Mon, 2 Feb 2026 14:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GWKoLv
 BLEkp3Mw3sVWMlA7G9ssmq4Ah2TzhOFUQfpaE=; b=B1bpGa+PA9f0LDKuVlwDAX
 fJgYgqaZojlsmrFMc2+Vl0gmz1AOrcBiKW510BowJK1u+qeKInMGbQqvtKhVniiF
 x8jMhJxsxGJNnVjQdcZrR+wkkPYCKfqI+zd4uc/BZndjIfmeeOfbmZUZgyHDVqY0
 L655K/u9gZ9suyDn4pX9cWBPlNbKQRt+gwLHtJQBLySIQt7Dqt0zILcZ3i4zslJv
 p9aVMGk+zLBCoUafaPfZkmzKYrv0VZ/uBy8NSUauuj4ZAv++4HF4byth0SeZyxNJ
 biH0fnyvSg4g8sW0ZCTIB2+QPFbWIbWmHiGZ5GnM3MQjXXKwF3AXhd6CSIMzmAVw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cvyams-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 14:52:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 612DYkKT009198;
 Mon, 2 Feb 2026 14:52:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1vexwhtt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 14:52:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 612EqNEm28836264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Feb 2026 14:52:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88EA320043;
 Mon,  2 Feb 2026 14:52:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2912620040;
 Mon,  2 Feb 2026 14:52:23 +0000 (GMT)
Received: from [9.52.200.54] (unknown [9.52.200.54])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Feb 2026 14:52:23 +0000 (GMT)
Message-ID: <6b8fb5ec-5c12-4fee-b808-88198b6312f0@linux.ibm.com>
Date: Mon, 2 Feb 2026 15:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Replace backup for s390 PCI
To: Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260202144702.1783102-1-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260202144702.1783102-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExNyBTYWx0ZWRfXwp03ba50iXeD
 Euu1Ef9UrcdqMcfoL7dZjkeatUBd5/spV1teVb5eaORB6LKgyDxyXw9q5GnXf5m5JNTc/C3dK1v
 kvPytfzEW1e4qguoC0sUSeKizBPfWhCtwpWAwUH2B7KUrfRwafxG9XTKKHdzGxpbQ7DZd+6hPcw
 KOwqhhBdAhDU6GAIaCWPJzIn+bSj5gMrwXhMqgdXS9g4bJrkglDT1k7xH92VZ+V3inTLzWxpQ1C
 wEKLWB0cb4aS/iA3wF9WyMFQbzQfy7p4uea0Lx4o2fi4HVvo7SigNgekyslFWMlbDkfNYdfSg1z
 a8BO6o9i1zeByBvhkcZwof/dnBIPet04s3R/IjN6OobCMshiJ4wIOU61XXb8Mxo32IjBym1GVGN
 IiJomEZYVS9G6LniWFOzR+VsSk7QRwaLfYDh4fP3wnVjXBT7+10ZgO+FZH3ua22RkzuNgBKQdX+
 ctSEBjBO9wqQUt1SaZQ==
X-Authority-Analysis: v=2.4 cv=UuRu9uwB c=1 sm=1 tr=0 ts=6980ba2c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=STK_0p3wlTkmVyiQI7oA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: Ru6UNJt4hccsMX2es8WBMkmNr-IdOLE6
X-Proofpoint-GUID: Ru6UNJt4hccsMX2es8WBMkmNr-IdOLE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1011 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602020117
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



Am 02.02.26 um 15:47 schrieb Eric Farman:
> Farhan has been doing a masterful job coming on in the
> s390 PCI space, and my own attention has been lacking.
> Let's make MAINTAINERS reflect reality.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
Thank you both

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b7ed4fccb..32d60dd673 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1862,7 +1862,8 @@ L: qemu-s390x@nongnu.org
>   
>   S390 PCI
>   M: Matthew Rosato <mjrosato@linux.ibm.com>
> -M: Eric Farman <farman@linux.ibm.com>
> +M: Farhan Ali <alifm@linux.ibm.com>
> +R: Eric Farman <farman@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/s390-pci*
>   F: include/hw/s390x/s390-pci*


