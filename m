Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D8BD6CFA3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 19:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj0mR-0004WL-PG; Thu, 22 Jan 2026 14:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vj0m5-000416-Vl; Thu, 22 Jan 2026 14:55:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vj0m3-0006Dg-Sk; Thu, 22 Jan 2026 14:55:25 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEAb6V006258;
 Thu, 22 Jan 2026 19:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZzIxxc
 pOowtP9Cg9xF65MExbWNwCiVP7l6k1dUO+xs0=; b=gN55gVT8kIprFLASY0JZPJ
 J8yAVva0++VbcchtK49LcgGN9MO57Zumwwnja3Q8uH1+CgUBQGiaoWlK6mhtXhrf
 daz63bGt+NIONV5UZzVkdVsxQp2d/pKYgdKDEekbtxJ3Y6CxknatwwXMqzV5ZJwJ
 nNloThWCsXTj1LKvAHPN7kNlL0wqkMCNwgOhtYwdGB2XTOI5LDcka2hGhMKYqIF0
 Piag3dY1EoZZj5i+uj8m3TWo/d3nCjkBlQ1VLpFnA90CPSRNT471fxW/1r3jFjWo
 FCit2XYAA6+tqANjN9l7JqVkZ0jF65nrpwHwCwFqcML8W/lcK8XDAWLYZhQpGS1Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sbxf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 19:55:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MIAv33016636;
 Thu, 22 Jan 2026 19:55:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4ycppv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 19:55:14 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60MJtCKo1704616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jan 2026 19:55:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDAEC58051;
 Thu, 22 Jan 2026 19:55:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 584F358065;
 Thu, 22 Jan 2026 19:55:11 +0000 (GMT)
Received: from [9.61.19.244] (unknown [9.61.19.244])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Jan 2026 19:55:11 +0000 (GMT)
Message-ID: <61995f25-7589-48a1-b0bc-1ed027514ee8@linux.ibm.com>
Date: Thu, 22 Jan 2026 14:55:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/29] pc-bios/s390-ccw: Introduce IPL Information
 Report Block (IIRB)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 brueckner@linux.ibm.com
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-14-zycai@linux.ibm.com>
 <e5a34764-4fa2-40c8-af80-8bd5aefd1e63@linux.ibm.com>
 <137ae89c-ddc0-44ae-a9bc-2b6cb0a62953@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <137ae89c-ddc0-44ae-a9bc-2b6cb0a62953@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 15MSgKitybW3CQQ_VSa3X0RsqQl2_Zje
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE1MSBTYWx0ZWRfX4/lnRxxIx411
 Cnv/ym+sB25/sb5IV/c2rNPKdFmzVoT95OEktH3kYi7UZGbY1Zu8klriyquGghY7zJh/F7SrdMN
 k+7opgUUVciagv2QGk0sYjjUcG6EOOdUGD2jaJid4dCKa9Qwh6WNL9irYFFeM+UeJRUqbSZRCJ5
 0y13UC5LVkntwc33QHoQGGUkvVIsWR0RXag5lmwdLNafVQ7lI24GXRfpaNkCs4f+mP9IkFdAi1r
 TA0Y3HKiPU4EE88Gzba/ys6EqsWVA43VPuJEehF7BymYBJ9ovI2wJhGXrGBL34NpHY71kiPH2dD
 cacH1HVLUmHvKb7Dz4UwHYmeDWf5uRAW+X+wqLFTavoGaH4GT8l4VCK/t8nW+oKhL+qg3ZRgyqE
 +WNEkjKnUAuqRVzElIqbcN7kn21D+2RDgpOhbRcDVIrcm9bR+2hH23ZAUAZnPdYf/x/Xdp0t7bY
 fgk/PbLqwpMt3ULVU2Q==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=697280a3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=NGKnF7tViZnYGXs3alYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 15MSgKitybW3CQQ_VSa3X0RsqQl2_Zje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220151
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/21/26 4:29 PM, Zhuoying Cai wrote:
> 
> 
> On 1/15/26 4:34 PM, Collin Walling wrote:
>> On 12/8/25 16:32, Zhuoying Cai wrote:
>>> The IPL information report block (IIRB) contains information used
>>> to locate IPL records and to report the results of signature verification
>>> of one or more secure components of the load device.
>>>
>>> IIRB is stored immediately following the IPL Parameter Block. Results on
>>> component verification in any case (failure or success) are stored.
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>  docs/specs/s390x-secure-ipl.rst | 13 +++++++
>>>  pc-bios/s390-ccw/iplb.h         | 62 +++++++++++++++++++++++++++++++++
>>>  2 files changed, 75 insertions(+)
>>>
>>> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
>>> index be98dc143d..29c5d59b99 100644
>>> --- a/docs/specs/s390x-secure-ipl.rst
>>> +++ b/docs/specs/s390x-secure-ipl.rst
>>> @@ -86,3 +86,16 @@ Subcode 1 - perform signature verification
>>>      * ``0x0302``: PKCS#7 format signature is invalid
>>>      * ``0x0402``: signature-verification failed
>>>      * ``0x0502``: length of Diag508SigVerifBlock is invalid
>>> +
>>> +IPL Information Report Block
>>> +----------------------------
>>> +
>>> +The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
>>> +IPL Information Report Block (IIRB), which contains the results from secure IPL
>>> +operations such as:
>>> +
>>> +* component data
>>> +* verification results
>>> +* certificate data
>>> +
>>> +The guest kernel will inspect the IIRB and build the keyring.
>>
>> This needs more elaboration.  Is the data listed above used in
>> the keyring?  Maybe rewording to "The guest's kernel will use this data
>> in the IIRB when building its keyring." ?
>>
> 
> Thanks for pointing this out. The data in the IIRB is not used to build
> the keyring. I'll update the text as:
> 
> "When secure boot is enabled, the guest kernel will inspect the IIRB."
> 
> [...]
> 

Apologies for my previous reply. I reviewed my notes and realized that
the guest kernel uses the certificate data in the IIRB to build the
keyring. I'll update the documentation accordingly.



