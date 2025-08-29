Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A64CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN43-0002X9-CP; Sat, 30 Aug 2025 11:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1urqMm-0002WK-Dz; Fri, 29 Aug 2025 00:05:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1urqMj-0000um-FW; Fri, 29 Aug 2025 00:05:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SGNR1h030697;
 Fri, 29 Aug 2025 04:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YE0vAc
 6tHOOzI8pZbXmU2yfB1+pAZIKBMib0sUHaMpo=; b=VGC1BL4jl0nh7Zw53/6ut5
 yOXakRWogLURd6URxA94rfUM+I2JFCCmZ5rmqfblSsZQMIehXEPzcv/ORCk+1Ycu
 nr1HPjLXaY6Yd4FDDPvB3t0+0rTLBC14999SYOzC/IXZE9faD/G/Jt3SguejdZtN
 QNkBMdESK/KvMTjjBKwJdrwhBgyeRj2meZzOaqQrGNeMqINk65WnybITtQZ+5whz
 /wQ2JdsHclC7/8Zi06sib43BuQOTzRxqVvnutI/RDDkYOmAcsi+CyZw/Wcs50wKj
 /H05mV4GYY1stqdWyFkslM14TTflyN8wWnsRI/qP9tMXFlB+fH5UMsh8nBUgVfVQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avwj06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Aug 2025 04:05:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57T20AsM020891;
 Fri, 29 Aug 2025 04:05:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrc10723-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Aug 2025 04:05:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57T45IrU54395322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Aug 2025 04:05:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A37C220043;
 Fri, 29 Aug 2025 04:05:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B04120040;
 Fri, 29 Aug 2025 04:05:17 +0000 (GMT)
Received: from [9.39.26.140] (unknown [9.39.26.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 29 Aug 2025 04:05:17 +0000 (GMT)
Message-ID: <112c5fa8-65e4-474c-9e4c-87322e6259d8@linux.ibm.com>
Date: Fri, 29 Aug 2025 09:35:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix typo in xive doc
To: Thomas Huth <thuth@redhat.com>, Gautam Menghani <gautam@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20250827053228.519707-1-adityag@linux.ibm.com>
 <cd274edb-fd19-4e06-806c-cc8f30b6f32f@redhat.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <cd274edb-fd19-4e06-806c-cc8f30b6f32f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZYbXXOU6DxHwXuUq36Jn9XIbm7HfMkES
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX1uGbNzarkpAk
 +8eSQbIz2KH3P0O+YS7ta07rF9x4hdBAbfT69etoYcD4WE3XHbsVpUBMZh9UcGbXaPu/+G5XhO4
 +LWZZBOTOtNZIjbQc+y/cRt2cyrllkgJxztKZ5pT9dWqs0U64WJkUNEzVh3fPz3TA8A7mm4dU11
 Xo9leoNPASlyjbbCV1YlVqhVJ2OC2Nro3fPjxMGEEb2xFRezj1/7aPUkFwRf/9MBBp0K9so+UES
 TLjKrIWhu0yiMiz7dSVQkK/po+luIcqxNgJBVt+hAhAHKqyOFFwxN56Syszrv+9VoHVKqcgQSLs
 KOs/EPhdejEOVJXvyjN10ye+qxjq5pHfJWa2W4ql5Ak0xQRSmCpshb6JLVwEQPXZHQR6I++kPrv
 9EQdQ6WR
X-Proofpoint-ORIG-GUID: ZYbXXOU6DxHwXuUq36Jn9XIbm7HfMkES
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68b12704 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=eTPrqzJAs8bK_CCXa_kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 27/08/25 13:33, Thomas Huth wrote:

> On 27/08/2025 07.32, Aditya Gupta wrote:
>> "Interrupt Pending Buffer" IPB, which got written as IBP due to typo.
>>
>> The "IPB" register is also mentioned in same doc multiple times.
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   docs/specs/ppc-xive.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
>> index 83d43f658b90..968cc760d466 100644
>> --- a/docs/specs/ppc-xive.rst
>> +++ b/docs/specs/ppc-xive.rst
>> @@ -157,7 +157,7 @@ Interrupt flow from an O/S perspective
>>     After an event data has been enqueued in the O/S Event Queue, the 
>> IVPE
>>   raises the bit corresponding to the priority of the pending interrupt
>> -in the register IBP (Interrupt Pending Buffer) to indicate that an
>> +in the register IPB (Interrupt Pending Buffer) to indicate that an
>>   event is pending in one of the 8 priority queues. The Pending
>>   Interrupt Priority Register (PIPR) is also updated using the IPB. This
>>   register represent the priority of the most favored pending
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>


Thanks for the tag, Thomas !

- Aditya G


