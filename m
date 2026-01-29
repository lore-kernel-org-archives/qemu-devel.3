Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8C7D73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 22:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlaH3-0002It-D2; Thu, 29 Jan 2026 17:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vlaGz-0002HV-Sk; Thu, 29 Jan 2026 17:13:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vlaGy-0000mF-5J; Thu, 29 Jan 2026 17:13:57 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEkvAK011220;
 Thu, 29 Jan 2026 22:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xy4lJG
 IGHoc7BAG7oEXnDFxp1kPzjY3C7kg7tFjZuQw=; b=rJLx9+qH2dX4b5JRHSSPiH
 GyYEQoFcjDdTsA/nYaW+4Yn3gRnbtSuui/eu6an2aSosJ19gM+876XBDiYqlVVBw
 D05Ocy4EVKje0L9UPHHv69hEcKDtOnzfrYpyqJ25tRilX5lhzTEw4xBCFDK11ddq
 iQtMRHfmqjwqiOxjEG+JKsiVx7mPYdb802vGnazBg1yFh3V8Gq8PRb3m955iKQTG
 0Mk77beEfv193wvVdLua6Zly2FnTsqhnE3seAiybO6Z5ASHC6EO7QEATvtFq/POm
 ND2n2b+40hBW1e02qMAI6amrRF+KFoIPwEV6Hygq7+RlijU2FXk9+pv5JUYjXLLw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg8fx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 22:13:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TIkXYM006772;
 Thu, 29 Jan 2026 22:13:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sykytm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 22:13:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TMDW8411862698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 22:13:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02B3258065;
 Thu, 29 Jan 2026 22:13:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CE0D58052;
 Thu, 29 Jan 2026 22:13:51 +0000 (GMT)
Received: from [9.61.243.220] (unknown [9.61.243.220])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 22:13:51 +0000 (GMT)
Message-ID: <871acd44-58fa-4d83-bed2-7738dcb3a571@linux.ibm.com>
Date: Thu, 29 Jan 2026 14:13:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] pc-bios/s390-ccw: Store device type independent
 of sense data
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-5-jrossi@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260127161547.459443-5-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697bdba2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=01Zzokg_jfJYVsKNeA4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y7iudif1X9gEnSobInqJUmIaJ_IG9w_d
X-Proofpoint-ORIG-GUID: Y7iudif1X9gEnSobInqJUmIaJ_IG9w_d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE1OSBTYWx0ZWRfX65yk7Jrmldu8
 yRRbPuepRovbUE0taqoozWglyfx2nvfAWOQui5RwdLVDXmo1CCqerrPaBVArKbI7otpMqwEXh5z
 e/+e4D6WHTH8151QZ1azdSzLYk00kgSOo0FYWtDFjhUhKlJZjOygUf+vyZTcOH4OEDp6tKyted6
 J5JwlHD4XcYUg+L9/RVEQZi2fwc4zWHpsoegr+yuBcwN4EnfcTcY1qxhcj9xS5FE2CObjxf0ihJ
 8r9LZbcwEJlzZtjBEVhwpUvRlB41QtYtkH4T1glDmpaJzmIrRqtHm4q9n1PpHGzZmrXNZokFOvl
 VVzXmXJqphTrIPxl5k5QnntA2EPLGD+94BqNDCP8KJf8EiySoSFCHbpWL9D2eeLq/n43QXMHrgc
 cQJqLF4nW8djrkJEtVN1GoHB0UVw09jrD26zs1fSVFicfNrwkj/kshMvVvS/Dx7FRR0NEGv0gA1
 uuUfG/CNBx24kezq+dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601290159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 1/27/2026 8:15 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi<jrossi@linux.ibm.com>
>
> Store the device type (e.g. block) directly and an attribute of the VDev rather
> than assume all devices can be identified by accessing CCW specific sense data.

I think it should be "as an attribute"?


> Signed-off-by: Jared Rossi<jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c          |  2 +-
>   pc-bios/s390-ccw/virtio-blkdev.c | 39 +++++++++++++++++++-------------
>   pc-bios/s390-ccw/virtio.c        | 11 ++++++---
>   pc-bios/s390-ccw/virtio.h        |  1 +
>   4 files changed, 33 insertions(+), 20 deletions(-)

The patch looks good to me

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



