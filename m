Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31142C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7BBi-0008Ia-Ig; Thu, 17 Sep 2026 08:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x7BBC-00088c-4P; Thu, 17 Sep 2026 08:25:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x7BBA-0006ku-Hn; Thu, 17 Sep 2026 08:25:29 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HA1ccv2232922; Thu, 17 Sep 2026 12:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ya1kD5
 6s1PuBPxVWc5qEGc0dm3UMazTNyyfJk+wlDHQ=; b=MGV2ipzeJmEeqbnVzH0D5N
 kBk9RVcUCcH+LCcPvLlcKpjTiEvEvh9s6Dl7jQcUZd+geQAyxshOJuKM804RC9XD
 NYgBPcW3e8VqDbqxpPDqNsyylYbsfaAamMzvLnrw5ivG8aCfyR6DSnoRY0zPWt1I
 /lU5aVDyWtcyQi5s9FcVcv/nqWa0xw6nJP+mZuXL6kx9Bxk6uj7B706FT576J2kQ
 L/r8lezipgHarqa95t+rbpWatXLKiNsbDFcbVV8UQoJHd3p7DVUhfU9OlvbFLbF5
 NXjlKVAHewiGiK/wa53UcF5Y7mcHrrAcnuOsezIt348PX+oNpi0Q91nKRDpdN7Dw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv9shn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 12:25:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H9aTwh2917896; Thu, 17 Sep 2026 12:25:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa28au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 12:25:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HCPMXr51511672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 12:25:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 063612004D;
 Thu, 17 Sep 2026 12:25:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8EBD2004B;
 Thu, 17 Sep 2026 12:25:21 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 12:25:21 +0000 (GMT)
Message-ID: <947ffb20-9823-4c77-8c9f-e05375ee583e@linux.ibm.com>
Date: Thu, 17 Sep 2026 14:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR
 ioctl
To: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-7-farman@linux.ibm.com>
 <a68f223a-8664-433d-96fb-16236aeaaf43@linux.ibm.com>
 <2964473a-740d-4ea0-8411-a36c8f9863f5@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <2964473a-740d-4ea0-8411-a36c8f9863f5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE2OCBTYWx0ZWRfX7Kgi0Q4FGhT4
 Ky6iMmdYARmdpuWJxFAtzsq9htMSHbRlHzh8otWrS/0dzYTHw0BDKt6waNIwjGWbDIlFSuNuedk
 4lqaEqPq0frkDC+qdStWf945xywgLmU=
X-Proofpoint-ORIG-GUID: dMs-2L19qWFPIb3sMmtSPZMktrgfuNjX
X-Proofpoint-GUID: dMs-2L19qWFPIb3sMmtSPZMktrgfuNjX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE2OCBTYWx0ZWRfX6dSL89YbNXk1
 HclS0G+jEdId8xOheJzD+u+IkiR+SYcPny+8Y/hWDsi7C+4ZbXXQigfatTU5ILCdM4bm4SLmX4a
 dlEij43zmYiqO/LxnxocF9rXTZz6w4x8tD00U/CjwapyEvLz1v6WEf2O0AjMtX6oTJ0UaFIVbvM
 j0l0PYMnt+/6Vuppz8NBdhDvGvxOsJ4lWg+hrkf8KON1ErN3HzNNR24QSJey8Av59uNqtB1pDss
 By6nadUs1+5Ax5eULoeG1df3t+ogTf1xSCKDzvMqQLGKLh6/WUwPcG6XYyoY/DcPt0IJPJ8En5X
 CChozIrum28Awpil4pe9XImEWXBJatX0eRSVNRiXTJuRqgkzdchM8xbspzNrTsI0ENpXqPhjsKo
 oIDoRQl+VoY7NhfxaUTgSCN4OUi31k/09OwF5xk7qdK1Yjd7/Ml4cTX10anY+HmLdnRfoS/deoM
 1A2Uui9WaMetxC4fDMA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aabdc36 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=hqWIp2CuJf0TTzAqDZ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170168
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 17.09.26 um 14:15 schrieb Eric Farman:
> 
> 
> On 9/17/26 3:45 AM, Christian Borntraeger wrote:
>>
>>
>> Am 16.09.26 um 22:32 schrieb Eric Farman:
>>> The ioctl to determine whether KVM_DEV_FLIC_CLEAR_IO_IRQ is present
>>> receives the contents of the attribute struct as its payload,
>>> rather than a pointer to the payload itself as is convention.
>>>
>>> This may result in erroneous errors from the ioctl, which would
>>> result in clear_io_supported being false when it otherwise could
>>> be used (which is helpful in device recovery).
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 9eccb8622c ("s390x/kvm: add interface for clearing IO irqs")
>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>> ---
>>>   hw/intc/s390_flic_kvm.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
>>> index f833a3996a..5e6d422fba 100644
>>> --- a/hw/intc/s390_flic_kvm.c
>>> +++ b/hw/intc/s390_flic_kvm.c
>>> @@ -633,7 +633,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>>>       /* Check clear_io_irq support */
>>>       test_attr.group = KVM_DEV_FLIC_CLEAR_IO_IRQ;
>>>       flic_state->clear_io_supported = !ioctl(flic_state->fd,
>>> -                                            KVM_HAS_DEVICE_ATTR, test_attr);
>>> +                                            KVM_HAS_DEVICE_ATTR, &test_attr);
>>>   }
>>>   static void kvm_s390_flic_reset(DeviceState *dev)
>>
>> Certainly a correct fix but maybe its not as bad. Aggregates > 8 byte are passed as
>> reference. Looks like the third argument is a pointer to a stack copy when testing, so
>> the old code might have worked by accident.
> 
> Ah, thanks for the assembler, I should have looked at that.
> 
> As I was testing this, I became worried that this whole part of error recovery was broken, but I was finding that clear_io_supported was already true even without this patch. I presumed ioctl magic, and that seems to be the case.
> 
> Maybe drop the stable tags from this one then, since it's working "by design"
working by accident, not by design. Yes we can drop cc stable.


> 
>>
>>       f8c:       d2 0f f0 a8 f0 d8       mvc     168(16,%r15),216(%r15) <--- stack copy
>>       f92:       b9 14 00 20             lgfr    %r2,%r0
>>       f96:       41 40 f0 a8             la      %r4,168(%r15) <-- pointer
>>       f9a:       c0 31 40 18 ae e3       lgfi    %r3,1075359459
>>       fa0:       d2 07 f0 b8 f0 e8       mvc     184(8,%r15),232(%r15)
>>       fa6:       c0 e5 00 00 00 00       brasl   %r14,fa6 <kvm_s390_flic_realize+0x136>
>>                          fa8: R_390_PLT32DBL     ioctl+0x2
>>                                              KVM_HAS_DEVICE_ATTR, test_attr);
>>
> 


