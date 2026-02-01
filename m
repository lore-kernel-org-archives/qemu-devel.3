Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15339E65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmfX8-0002ya-S9; Sun, 01 Feb 2026 17:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vmfX7-0002xh-EI; Sun, 01 Feb 2026 17:03:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vmfX5-000293-TO; Sun, 01 Feb 2026 17:03:05 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 611HUQ6Z017333;
 Sun, 1 Feb 2026 22:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FZMyIe
 FSC+HCQRCxbBG0fzgFdRcieo6d8mSrYiM/h1c=; b=WjoA06hKt1RrdTLbiYo2vI
 guLBLTnqqXxKMPQOuyDaG5mt626c1unszVx9H+O5CjSC5EGiQz4BYhsUh89tnk1c
 CUwdZW83ptPeyX2Cq/YJEtfNqk+Dpzz3NjJK+YBLWSwSGOS77krLowyacJOwjOmE
 GXe8gLrJ2nWEiwPBl0Hj9u7E2zoOMfDnT3RopXLoCOc3yD6bOhABxFJwacABQlkZ
 4VHsEFbvdnv2ADHRkdDxtGU2Wro6n4PtTHE7ufyYTFBHxen4O2IRUQRcM9eeJFVq
 h5m4HXjTcvNTB6UbIAc/QArMgE0WCUJDErdlK0+HXy0X8P1RDCkgbrfgnI/vNaPQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dswnh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Feb 2026 22:03:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 611L47Wc009600;
 Sun, 1 Feb 2026 22:03:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1vextsth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Feb 2026 22:03:01 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 611M2enJ25035300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 1 Feb 2026 22:02:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2EA45805D;
 Sun,  1 Feb 2026 22:02:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D610758043;
 Sun,  1 Feb 2026 22:02:58 +0000 (GMT)
Received: from [9.61.23.27] (unknown [9.61.23.27])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Sun,  1 Feb 2026 22:02:58 +0000 (GMT)
Message-ID: <6a749f07-1cca-4a64-b94a-a104bc0c825d@linux.ibm.com>
Date: Sun, 1 Feb 2026 17:02:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] include/hw/s390x: Move CLP definitions for
 easier BIOS access
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-7-jrossi@linux.ibm.com>
 <1c899641213407613647adcc10ce1d5b10f3fce9.camel@linux.ibm.com>
 <9afdd5c9af9540609542814d9a583437589db4bf.camel@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <9afdd5c9af9540609542814d9a583437589db4bf.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDE4OCBTYWx0ZWRfXzRgfd+uN5kAZ
 mAYc7N0GJs7T+3kvx21lieECRUpjqUoF2vFdDvlD5ayGLdui0UJ85JYSaYIyZ5Ijz6NCr4LDBp7
 tXdo09gh1PuljC9f3/Eh3EmmT3NfqIPldq6gxltTR5eG331MfYpUVnIuZSLNXMlSX8yvTBOhjAN
 2CARxQOTohhr7+3XFqgVuR4unlHSa2dURIWf3JJFmwG+EqRtTHnmjzBLJJWVnIbVarTXdqBUb8n
 wZV6MzSN78zfj/88/taLedwqRFZ9LXtgRvr1YP3wZhY/KLkwJEGojZaC7qsiqFMlEOGaQcb6xEF
 u0Bj98eMRtESQesvvHyt03BLnfRyKr4GFqxgInpNcNR7N3OcqGsPzyVGy+3JtF9hTcEEtm+DAk1
 LG6qzuFI91JOPno0Yd61WoPBJZ8lwcUPewUF8aeti+9KvsI/VMcMS2RMTW4djJ75bCQ/QvuGvR7
 4KGQSF4kBgR20FClhtA==
X-Proofpoint-GUID: pczTJS7DaRwBwe6oxsQ3g-Z6WoWKX8TN
X-Proofpoint-ORIG-GUID: pczTJS7DaRwBwe6oxsQ3g-Z6WoWKX8TN
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=697fcd96 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=bttWFdE6PSH9UWTk3ogA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_07,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602010188
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



On 1/29/26 8:50 PM, Eric Farman wrote:
> On Thu, 2026-01-29 at 16:46 -0500, Eric Farman wrote:
>> On Tue, 2026-01-27 at 11:15 -0500, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> Move the s390-pci-clp definitions into the "ipl" sub-directory, which is visible
>>> to the s390-bios.  This allows the bios to reuse the architected definitions and
>>> prevents code duplication.
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>> ---
>>>   hw/s390x/s390-pci-vfio.c                  | 2 +-
>>>   include/hw/s390x/{ => ipl}/s390-pci-clp.h | 0
>>>   include/hw/s390x/s390-pci-bus.h           | 2 +-
>>>   3 files changed, 2 insertions(+), 2 deletions(-)
>>>   rename include/hw/s390x/{ => ipl}/s390-pci-clp.h (100%)
>> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Actually, small nit that popped into my head on the drive home... Could you update MAINTAINERS so
> that we don't lose the PCI CLP header file from the S390 PCI group?

Sure thing, will do.

Thanks again for the reviews,
Jared Rossi

