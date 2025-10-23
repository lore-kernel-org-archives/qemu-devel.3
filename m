Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF1ECCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBnBU-0002eD-2p; Thu, 23 Oct 2025 00:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1vBnBS-0002dv-M3; Thu, 23 Oct 2025 00:44:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1vBnBQ-0002Dy-QD; Thu, 23 Oct 2025 00:44:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MI0VuR031838;
 Thu, 23 Oct 2025 04:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=Rr/wDTA59TEXj9Qbc8z9aD4UIoCh
 KlJmRLMy8rh50DY=; b=YcJIJjG+5gUAOAvSpUSzLJysbpplvZZG/3ccAuAj8m+A
 wOKHD1s9UTMXtFb3SRndyox1DAJqhquW5tivZLmaWlWnjteIamCP/z8Y7goKFhaT
 qGSodIB9KVQvfHloUJ/8iRLJFu5UYJyf01+HgUhGnWzq+Dayrd3VaL/btvzu4PQu
 3JyrL1JOm8qAkOy2f356xkLPKHmaYrsezFA7A0z1c6xY5sQe5ZTfOCfsDRWVSHL5
 ry6ZLkbOQOtl4CY4bcfkBdXJW21lYuk+z0fbEVGny8psWqonLZ+E7q0HMMRzkBfh
 DIp/m/Ay8XyBf0cHt8Aqq8+2GeZvGeNoMUIQ67e3QQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fgbqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 04:44:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N2v1rJ011030;
 Thu, 23 Oct 2025 04:44:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1bpcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 04:44:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59N4i8Na20906540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 04:44:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8A9020043;
 Thu, 23 Oct 2025 04:44:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D4DA20040;
 Thu, 23 Oct 2025 04:44:05 +0000 (GMT)
Received: from [9.87.141.36] (unknown [9.87.141.36])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 04:44:05 +0000 (GMT)
Message-ID: <e8688ff0-5665-4ba6-9c9a-7cfc4adcdcdf@linux.ibm.com>
Date: Thu, 23 Oct 2025 10:14:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ganesh G R <ganeshgr@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: clg@redhat.com, Glenn Miles <milesg@linux.ibm.com>, harshpb@linux.ibm.com, 
 gautam@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, kowal@linux.ibm.com,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [DISCUSSION] Reworking remote controller access
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f9b29d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=DOs_RDtfQgoeyEurnsoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Tepot0Ej3Xp8JZsDvwUb6wpk43Z37TN4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxwzDiQGj1r6R
 6ZukC+D6n+h4QKnWWTcLZLcdyGMlhGvVaeXjX7/+9SO9UEJ3V2ap3vLViGGkfgV8x82TNJwLIUI
 wogxMnKA2vA6JcM45v0yJgMyyXwti+kR1AwhsZcrc/059dYcAcmU4KcZDJR/fs5wtwf6mUoyweP
 xJtiZcHV1VMp57yb++CW+QtBYxpHrroQtz2gMWGvvlWb965rLBly6mdFEsGW2mXziwHRhfyBUds
 T8AVmyemGQPp5u4nsKVFusAxBZGF7X4cy0IaWp/9YKrE/H6D3V+uBB2gLMuhx63QlNcDuq59aIc
 0gr/uiZjk7fHykeB/G7Sho8Xe/4+o/KTnFl0fzagZZNBzLy/o5fbGj1BlVpnAIh5uEp0R5cqCLp
 8hoibqygCYR4qK6VvANr1kn144Xs3w==
X-Proofpoint-ORIG-GUID: Tepot0Ej3Xp8JZsDvwUb6wpk43Z37TN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=ganeshgr@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi all,

A few days ago during the review of the P11 patches, Cedric suggested 
removing the use of qdev_get_machine() 
[https://lore.kernel.org/qemu-devel/3456f764-616b-412c-839c-aaef4bf1e47c@redhat.com/] 
and instead using MMIO to obtain the address of remote virtualization 
structures. However, it wasn't feasible to implement this change 
alongside the P11 updates, so we opted for a temporary workaround to 
eliminate the use of qdev_get_machine().
[https://lore.kernel.org/qemu-devel/900db31c-54d5-410d-934e-347ca0b22ec2@redhat.com/]

Now, we are planning to revisit and improve the way we access remote 
controllers. We have considered a couple of approaches:

1. Implement MMIO operations for all BARs
Redirect all remote access through the BARs instead of iterating over 
all XIVE instances to retrieve the virtualization structure addresses.

2. Use a dedicated MMIO offset to return the address of the 
virtualization structure:
This is a simpler solution, similar to what Cedric implemented for P9, 
the idea is to define a special MMIO offset that when accessed returns 
the address directly. This avoids the need for qdev_get_machine() and 
keeps the design simple.

Any suggestions or feedback on these approaches.

Thanks
Ganesh

