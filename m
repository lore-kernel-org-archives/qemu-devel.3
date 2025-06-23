Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C112C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjlO-0006aT-JA; Mon, 23 Jun 2025 12:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uTjlN-0006a2-2f; Mon, 23 Jun 2025 12:11:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uTjlL-0001dV-1Z; Mon, 23 Jun 2025 12:11:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9VRFd029832;
 Mon, 23 Jun 2025 16:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CdVjaE
 LSGOXE1/7oOjZtN7Iy+PpOu55VHvxfsFRrDQ8=; b=Kd4n4Pd3hvbrPkSBI28jo4
 nP5F755Oqvr9SgKwDassVHP8D4k1d29MZO9gjuTDWgpheG5twqL/2g4P6tQNF8lT
 +BqnGqscLnvPT0PspGmb1zVbW6Ya001tqc/mw6qSQFvjkwAryhMS7sTuj7xtXOaq
 pBiRCsPLGtyujMRZ+4/AzbvhIPm5Ro6CT00YsDOUDYUWyiVlQxuwo4dLKbSOQTrv
 rew4cyLCY7ZiYq3DY6cquww8wGDQnU0BJUZ53HQd6Yv37DnvbTOyStAD7rXuTKl5
 bdZUu1D5uKEu4mMjT8edGZllZgWjtu9VMLiBlUZk2J+Q/yYynGXwFxsdFphxTrNQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tker1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 16:11:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDKlnj015033;
 Mon, 23 Jun 2025 16:11:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72tfua0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 16:11:11 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NGB9Uo7078252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 16:11:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EFF158045;
 Mon, 23 Jun 2025 16:11:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F08C58050;
 Mon, 23 Jun 2025 16:11:08 +0000 (GMT)
Received: from [9.61.145.51] (unknown [9.61.145.51])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 23 Jun 2025 16:11:08 +0000 (GMT)
Message-ID: <85da221c-21b6-41fb-8f8f-d09fa234a65d@linux.ibm.com>
Date: Mon, 23 Jun 2025 12:11:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add reviewers for some s390 areas
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, alifm@linux.ibm.com, jjherne@linux.ibm.com,
 walling@linux.ibm.com, jrossi@linux.ibm.com, qemu-devel@nongnu.org
References: <20250623160030.98281-1-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20250623160030.98281-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eB22oANfGy-YDk6o_Y7zQCMrVTvYQYnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5NiBTYWx0ZWRfX/3Tg48f3WUCW
 gPekLO8pcJsn7Q67oDi/JObvyZ/F6qdXjs+OTVqU8J2fWoad9BmaKmQRhL444oI1N9I+SDxkfMF
 Cq3DJiJ6qMXUbaHm0eY23kDK9MIuagIhG/ajt0V1Ntf8HZJGpZdOD8gzDGAJO+0YzvM2PzYFDvz
 OdiO8r3S6RRjUc0+A5nsGso7RAimfUQm/62+uKTFHZk7c7rK6AY520uxicCTAb4s4x4fDPkqFjJ
 pQ/Dm7ukVO2PRJHqWS7zl5997kLn1DUA7nyqwDgnWmKS5XbUOBfOgbz4Ju3+dGJ9qR3C77Eqgo7
 EqIFV43VdumWOd2S1J01xPqFIwt2HkD50+NQCfkTAHT7va4sR50NzDAiu1HW/ioG1puktubj2V+
 KfEyAJqPpC/WCQaStQD/NemFKlyy9Q1xjPcUu4Ws6Oyy4fYzDbME98eBYz0kxKR32kPAvjzF
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=68597c9f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=20KFwNOVAAAA:8 a=Kf2Tvuw_2pJ0JA08flIA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: eB22oANfGy-YDk6o_Y7zQCMrVTvYQYnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230096
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

On 6/23/25 12:00 PM, Matthew Rosato wrote:
> To improve review coverage, assign additional people as reviewers for
> multiple s390 sections.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Acked-by: Zhuoying Cai <zycai@linux.ibm.com>

> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94c4076127..3ce6fce8ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -459,6 +459,8 @@ F: target/ppc/kvm.c
>  S390 KVM CPUs
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Eric Farman <farman@linux.ibm.com>
> +R: Matthew Rosato <mjrosato@linux.ibm.com>
>  S: Supported
>  F: target/s390x/kvm/
>  F: target/s390x/machine.c
> @@ -1771,6 +1773,7 @@ S390 Virtio-ccw
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  M: Eric Farman <farman@linux.ibm.com>
> +R: Matthew Rosato <mjrosato@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/
>  F: include/hw/s390x/
> @@ -1782,6 +1785,8 @@ L: qemu-s390x@nongnu.org
>  S390-ccw boot
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  M: Thomas Huth <thuth@redhat.com>
> +R: Jared Rossi <jrossi@linux.ibm.com>
> +R: Zhuoying Cai <zycai@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/ipl.*
>  F: pc-bios/s390-ccw/
> @@ -1802,6 +1807,7 @@ S390 channel subsystem
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  M: Eric Farman <farman@linux.ibm.com>
> +R: Farhan Ali <alifm@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/ccw-device.[ch]
>  F: hw/s390x/css.c
> @@ -1822,6 +1828,7 @@ L: qemu-s390x@nongnu.org
>  S390 SCLP-backed devices
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>  S: Supported
>  F: include/hw/s390x/event-facility.h
>  F: include/hw/s390x/sclp.h
> @@ -2809,6 +2816,7 @@ F: include/hw/timer/mips_gictimer.h
>  S390 3270 device
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Collin Walling <walling@linux.ibm.com>
>  S: Odd fixes
>  F: include/hw/s390x/3270-ccw.h
>  F: hw/char/terminal3270.c
> @@ -2818,6 +2826,7 @@ L: qemu-s390x@nongnu.org
>  S390 diag 288 watchdog
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Collin Walling <walling@linux.ibm.com>
>  S: Supported
>  F: hw/watchdog/wdt_diag288.c
>  F: include/hw/watchdog/wdt_diag288.h
> @@ -2826,6 +2835,7 @@ L: qemu-s390x@nongnu.org
>  S390 storage key device
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/storage-keys.h
>  F: hw/s390x/s390-skeys*.c
> @@ -2834,6 +2844,7 @@ L: qemu-s390x@nongnu.org
>  S390 storage attribute device
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/storage-attributes.h
>  F: hw/s390x/s390-stattrib*.c
> @@ -2843,6 +2854,7 @@ S390 floating interrupt controller
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  M: David Hildenbrand <david@redhat.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>  S: Supported
>  F: hw/intc/s390_flic*.c
>  F: include/hw/s390x/s390_flic.h


