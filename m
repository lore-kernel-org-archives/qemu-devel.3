Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752A2EB106D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyrF-00048m-Cp; Tue, 10 Mar 2026 11:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vzyqx-0003ih-QS; Tue, 10 Mar 2026 11:18:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vzyqw-0001G9-2o; Tue, 10 Mar 2026 11:18:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AAJHUS1572387; Tue, 10 Mar 2026 15:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wCwtlH
 MMUbmsx0X2S5xc1r86RjwP5eyy+OSrkJ7d19E=; b=dUtW8YBmsRm8LffJIFeU3p
 B+o5EAi1f6baoNNx6WYmv4BsdAYiHxMvr4SaXERFrMJNbwP63RIXjJ3pj2FJkrfc
 3eLTHVkmktL2Kd79MQqTEFNOmTeBZA9jUa6YK2oHPdlxikOEnAbqE7BsYSJbji0b
 St+7ESrrbAvMHxGZa9Ii6KLb+8648obxVnXWKW0aSZvPAHGvzBG1ZwQ/5KO/gDcV
 0zwhzARNKfEO4hYnIW06iQZhS9SKvc+4VJHLr8MEim+aLue786ETqOMiij5NZHDf
 VwWAognq/+t3SLW/u7bDiBLD11BeaFwoUSHVnHDD4WyTe04/AKup3d6X4WAmyLIA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuybghj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 15:18:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AF3gtq021181;
 Tue, 10 Mar 2026 15:18:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsss88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 15:18:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AFIQGc45089040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 15:18:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6620A2004F;
 Tue, 10 Mar 2026 15:18:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E78D2004E;
 Tue, 10 Mar 2026 15:18:26 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 15:18:26 +0000 (GMT)
Message-ID: <102f401f-b94e-4404-9802-7676eed6b8d8@linux.ibm.com>
Date: Tue, 10 Mar 2026 16:18:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update S390-ccw boot maintainers/reviewers
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com
Cc: mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260310142118.1120291-1-jrossi@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260310142118.1120291-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b03647 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=4hA0wTabLwGQ2Yy6IIIA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfX0ntJClxUlEhM
 WjXJmUXJVKL4nKkflUhShHT2+++Mng+Klx8j3PGtXoJvHvsGp8Ek0nw4CqtffCnGYOfNWskz84s
 u+DtRuV1X+PbUxLkeZ7S0ffM5QGMeLvIh2qrnvx6CV+9TM9Ml60Bte6/3G6HikhT/pyxqBfbu8H
 kRrIRD11+MR8o7CL7wAFh/ieu9r6s86dHAng8k66BXNQk1XTtSyfhV+gl+ICfgHqjt4Tw6sFe0W
 XUgkyiW9My/WEqqFmBWFO/KY/9JxpnpR0arEIJHl37h87qYLvc/nQx+FBV7ZJNP5f6NTjY4ojcP
 Qu7XHHyA4Fpv3XzaWXdSA8rk2f9MwwWco15P5gmJ/4jwx3i1hB3Pq+TA8ryCDH+lqPihWMNk/SL
 fB9OBvV3YbbL2fRbw7X09L7QY41DU7J10OxJhhdwvIXm+K7AfgTyHE8qA30Eh/Hqy4VeKFUA/Th
 FJs3FDR1R6iOYMWz7sg==
X-Proofpoint-GUID: XSlZcvatMZy30ZXv3bsXlZuh63OReCXA
X-Proofpoint-ORIG-GUID: XSlZcvatMZy30ZXv3bsXlZuh63OReCXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100131
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 10.03.26 um 15:21 schrieb jrossi@linux.ibm.com:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Christian Borntraeger is no longer active in this space.  Promote myself to
> maintainer and demote Christian to reviewer.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

Thank you for taking over. Highly appreciated.

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80e10e43b5..1012135dd4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1862,10 +1862,10 @@ T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
>   S390-ccw boot
> -M: Christian Borntraeger <borntraeger@linux.ibm.com>
>   M: Thomas Huth <thuth@redhat.com>
> -R: Jared Rossi <jrossi@linux.ibm.com>
> +M: Jared Rossi <jrossi@linux.ibm.com>
>   R: Zhuoying Cai <zycai@linux.ibm.com>
> +R: Christian Borntraeger <borntraeger@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/ipl.*
>   F: pc-bios/s390-ccw/


