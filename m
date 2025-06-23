Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435FBC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjzx-0003dl-VE; Mon, 23 Jun 2025 12:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uTjzu-0003dK-3Z; Mon, 23 Jun 2025 12:26:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uTjzr-0004ae-SI; Mon, 23 Jun 2025 12:26:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBAhOI009021;
 Mon, 23 Jun 2025 16:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rRGxeY
 8CqnPvFfS959nD4GYpNPkRIGqu3tk1c2c4Xe8=; b=bztgb+KpZajSYePEzt0zwb
 MGBo2jNIeX1iDiN4rXtbBL9oFlWfPYkm+J4DVazacF86U+rZXRXekxFXU0Bhqy6X
 /I23IpqRfdpsFNAzrz2V4JuTHaR78W/kVJzh+QgfklLL8WUt3BDOjrG64/Mw5EmX
 XxYxSvKP2Y87Wej8f+EiiPvze2fBX0uY9fafAAIR96TX4CQZL3btSYBOPBCKpzd7
 /DqrWTXwWFUFv26/6NTkQeQ79/jlq2UPtc4WBW/f4yAWRF06piYUPDgu/d3C2a8g
 Cx0ciVPS+qHPL6Boe2hL7MsY4maky2BKduCxvLqaAyexkRY71tAAKICOBEYv5DGQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tkheh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 16:25:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDQkQv030537;
 Mon, 23 Jun 2025 16:25:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eyqukd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 16:25:43 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NGPb2F13304490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 16:25:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66C9758058;
 Mon, 23 Jun 2025 16:25:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 445C95805B;
 Mon, 23 Jun 2025 16:25:41 +0000 (GMT)
Received: from [9.61.251.78] (unknown [9.61.251.78])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Jun 2025 16:25:41 +0000 (GMT)
Message-ID: <61dfcb77-df12-4b39-892a-a71d903d42b6@linux.ibm.com>
Date: Mon, 23 Jun 2025 09:25:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add reviewers for some s390 areas
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, jjherne@linux.ibm.com, walling@linux.ibm.com,
 jrossi@linux.ibm.com, qemu-devel@nongnu.org, zycai@linux.ibm.com
References: <20250623160030.98281-1-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250623160030.98281-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rtj4UH4GcQj6gobhBdrMI6H3YxqUTB2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5OCBTYWx0ZWRfX7xKnmzbX65JF
 l3vcPpoYOMMPPoaaTrpzkizsiyJQmZwsETFSRlVgbgotLoCYH4gAq3Fulmexmq1MbgQrjAxeWoN
 yJHsX5if6XbJngIF4Bjz9I3Qys7EPo4X7jnsyVBX8UhWn9fpuj/xcQNanRU0tlUziwCP87E5MnI
 9zyUDF5zj7kFu3Ui5V3fVg38ys5lIgphTQX/aTfDCAQ/ZJT8J5Ymc4c7JQJO9N4ToRv2HUD5zuR
 xMoXnIq49acTymFUpC4TC15El6pHDfEisOezvYh0og/BXDIQirZGCmk+b9TN+JjF7SOBoSsE38J
 YGG92HblQEk5RkIym2zwY2kxehGxy9A4s05Ufd6xypDepanC58nbmYVnKdakt0hf30PUUKh/QS5
 1plK8w1MX2awJvpZDap6CNnCOutb+FllN5/9/m3lzEdIxdOAyNBcgpvATANnjMbztEoC+PAb
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=68598008 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=20KFwNOVAAAA:8 a=pw3nJ7SLLKdmeAyoHEEA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: Rtj4UH4GcQj6gobhBdrMI6H3YxqUTB2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230098
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Acked-by: Farhan Ali <alifm@linux.ibm.com>

On 6/23/2025 9:00 AM, Matthew Rosato wrote:
> To improve review coverage, assign additional people as reviewers for
> multiple s390 sections.
>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   MAINTAINERS | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94c4076127..3ce6fce8ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -459,6 +459,8 @@ F: target/ppc/kvm.c
>   S390 KVM CPUs
>   M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Eric Farman <farman@linux.ibm.com>
> +R: Matthew Rosato <mjrosato@linux.ibm.com>
>   S: Supported
>   F: target/s390x/kvm/
>   F: target/s390x/machine.c
> @@ -1771,6 +1773,7 @@ S390 Virtio-ccw
>   M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
>   M: Eric Farman <farman@linux.ibm.com>
> +R: Matthew Rosato <mjrosato@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/
>   F: include/hw/s390x/
> @@ -1782,6 +1785,8 @@ L: qemu-s390x@nongnu.org
>   S390-ccw boot
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
>   M: Thomas Huth <thuth@redhat.com>
> +R: Jared Rossi <jrossi@linux.ibm.com>
> +R: Zhuoying Cai <zycai@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/ipl.*
>   F: pc-bios/s390-ccw/
> @@ -1802,6 +1807,7 @@ S390 channel subsystem
>   M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
>   M: Eric Farman <farman@linux.ibm.com>
> +R: Farhan Ali <alifm@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/ccw-device.[ch]
>   F: hw/s390x/css.c
> @@ -1822,6 +1828,7 @@ L: qemu-s390x@nongnu.org
>   S390 SCLP-backed devices
>   M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>   S: Supported
>   F: include/hw/s390x/event-facility.h
>   F: include/hw/s390x/sclp.h
> @@ -2809,6 +2816,7 @@ F: include/hw/timer/mips_gictimer.h
>   S390 3270 device
>   M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Collin Walling <walling@linux.ibm.com>
>   S: Odd fixes
>   F: include/hw/s390x/3270-ccw.h
>   F: hw/char/terminal3270.c
> @@ -2818,6 +2826,7 @@ L: qemu-s390x@nongnu.org
>   S390 diag 288 watchdog
>   M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Collin Walling <walling@linux.ibm.com>
>   S: Supported
>   F: hw/watchdog/wdt_diag288.c
>   F: include/hw/watchdog/wdt_diag288.h
> @@ -2826,6 +2835,7 @@ L: qemu-s390x@nongnu.org
>   S390 storage key device
>   M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/storage-keys.h
>   F: hw/s390x/s390-skeys*.c
> @@ -2834,6 +2844,7 @@ L: qemu-s390x@nongnu.org
>   S390 storage attribute device
>   M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/storage-attributes.h
>   F: hw/s390x/s390-stattrib*.c
> @@ -2843,6 +2854,7 @@ S390 floating interrupt controller
>   M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
>   M: David Hildenbrand <david@redhat.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>   S: Supported
>   F: hw/intc/s390_flic*.c
>   F: include/hw/s390x/s390_flic.h

