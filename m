Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A158AF4181F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeER-00013t-H4; Mon, 09 Mar 2026 13:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vzeDx-0000ob-Q9; Mon, 09 Mar 2026 13:17:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vzeDv-0005oh-Tx; Mon, 09 Mar 2026 13:16:57 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629FulVr1671245; Mon, 9 Mar 2026 17:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=T3CeZv
 mncQG4rYjUXfsz3qQQfCjx32KbrYY/HapIO+8=; b=LlcObbOeKNLuxFhEkZuiO5
 r9p091euM+KUbeK2nfePLVx9Mxk/4mmTkDtF0Xle558RvDeuguzaw+HrLvNvfXwG
 ATZ/ObRh60HcWOmkx/kwV//meWOQCNwqPueVFsNfMkB1GiWfnEAXzCA8Xs4obR9V
 nuhWfI9QRjtG8C4hODMLVVf3qv0NE+dj9f59/CU+K+jx8vuAbzDRx8dGlORMSMYO
 OQgfX41XC54fWgtf5QNDaf273nI+V5sq3fY/atHp112hSb+kvfhcSMRDv1izmTVS
 NDUph/xcTXZ7t+QNgx/T02v3nvWaRwaLXSIl3X4SsvNVoxaxUA5CdBBzNbj/QQJQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm7pc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 17:16:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629FaNwD015761;
 Mon, 9 Mar 2026 17:16:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs121wke4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 17:16:52 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629HGpLp33030844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 17:16:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B92A55805E;
 Mon,  9 Mar 2026 17:16:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9A7958059;
 Mon,  9 Mar 2026 17:16:50 +0000 (GMT)
Received: from [9.61.251.111] (unknown [9.61.251.111])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 17:16:50 +0000 (GMT)
Message-ID: <04ef82fc-c748-4c39-80eb-105c1a2c826d@linux.ibm.com>
Date: Mon, 9 Mar 2026 10:16:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] pc-bios/s390-ccw: Introduce CLP Architecture
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
 <20260309003601.242634-9-jrossi@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260309003601.242634-9-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ah7YEhoXCdQ-4ACV7_9p7Iv_0Z3CKAk8
X-Proofpoint-ORIG-GUID: Ah7YEhoXCdQ-4ACV7_9p7Iv_0Z3CKAk8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1MyBTYWx0ZWRfX3LoczS6ik6Mo
 Yhl3G9C3y1HThA3KuOOVPSE01D0ZLjx1TYAOx4l5G/y5WLrZ/4ML4nQzrnrcFeM7kNSjb+HPs3l
 H0r96LqrTb5T6c0PfOC8/uWrJYnA/fQwYpNAfbQTtxqHvm2DyAlPAZUVq8kNIDDVsvQkuXLM7W6
 HlYjJDWlkbHIUh5LdIb1zFsQMmquiKzMHrZrxQSvCbCXXE1F+CVPcqpqJGrweaQK6WPlVpwzYk4
 /O+bfpbFPaU9cf2tI/Spp3iGoVL8W1RzZnQb07LWAo5nXOIMnlKydyDJqWtKlftQz5fKA6yHVJT
 xPHhKfFY6FwYpH5bHLa+nerF9C1KACrTLZR4gF+F6b3pCFv96nDxjeUW+HjFrr8egBN4+5SvBBX
 Rzece/6kN0Wy5jmtqtVJoXEuxGA7907vvYHEPwe93LnkHdnoykGDCCy7oxN6vIfuLiXX96/gG9i
 +bJRi2rNqlBlbqYCeXg==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69af0085 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=loGuO3k-H2d5Vv0PgG8A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090153
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 3/8/2026 5:35 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi<jrossi@linux.ibm.com>
>
> Call Logical Processor (CLP) Architecture is used for managing PCI functions on
> s390x. Define and include the structures and routines needed to interact with
> PCI devices during IPL.
>
> Acked-by: Thomas Huth<thuth@redhat.com>
> Reviewed-by: Eric Farman<farman@linux.ibm.com>
> Signed-off-by: Jared Rossi<jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/Makefile |  2 +-
>   pc-bios/s390-ccw/clp.c    | 99 +++++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/clp.h    | 24 ++++++++++
>   3 files changed, 124 insertions(+), 1 deletion(-)
>   create mode 100644 pc-bios/s390-ccw/clp.c
>   create mode 100644 pc-bios/s390-ccw/clp.h

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



