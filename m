Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AF3D3CCAF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 05:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFga-0000Kv-8L; Thu, 15 Jan 2026 00:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vgFgY-0000KK-SH; Thu, 15 Jan 2026 00:14:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vgFgV-0006jD-Fm; Thu, 15 Jan 2026 00:14:17 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60EIAxQn030620;
 Thu, 15 Jan 2026 05:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=foDgfz
 Rvfx6BnbX2Fe6VvYR4ev0e86Ddh8ypJzZv5sA=; b=Ij60k07DxGbSBnQb/ySxXZ
 YMnbDJi+XEott2HW4Xdfdq3hS+G8YWEnhdOsOwsqqvK6dfbC97snFj2XcPLdCIQt
 5K3959G9G1H3QfbKIQzC73r+1XbL8TBnoIfCm3wJ/0+9ILCW5hHLIOO0nHkuaC1Y
 C6qaDQF9bO7pUAJVG6v0+769Uq/sDxW0gZmB1rH43pLlq0iR6B+utm77yA5tfWmb
 VJZhwa6fc+M0ZOGzRq+tyW6LomZ+cDnvX3BlczMqk5P4vYid/8EOSdCJsPvS+Jp4
 bAf7OB47NmGrbWDFbhpZ8dzppW8W0oAiRXYKsTOy2fhhGfs/wUP2YBnMX9et2BAw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6hcnbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 05:14:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60F4qOo6031250;
 Thu, 15 Jan 2026 05:14:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3t1ww6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 05:14:10 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60F5E9gc28312248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jan 2026 05:14:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67C0658054;
 Thu, 15 Jan 2026 05:14:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC4D15803F;
 Thu, 15 Jan 2026 05:14:08 +0000 (GMT)
Received: from [9.61.255.133] (unknown [9.61.255.133])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 Jan 2026 05:14:08 +0000 (GMT)
Message-ID: <eb891295-5ffd-4613-bc37-56d8a07d1fff@linux.ibm.com>
Date: Wed, 14 Jan 2026 23:14:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 3/3] qapi/iothread: introduce poll-weight parameter
 for aio-poll
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 stefanha@redhat.com, fam@euphon.net, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260113174824.464720-4-jhkim@linux.ibm.com> <87qzrs4oud.fsf@pond.sub.org>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <87qzrs4oud.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YhPjKT2Kmku-ZshdQGHla_ZxMyF5_09k
X-Proofpoint-ORIG-GUID: YhPjKT2Kmku-ZshdQGHla_ZxMyF5_09k
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=696877a3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Pg_0jPdBt9vz6Qyl_R0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAyOCBTYWx0ZWRfX65K1say45viX
 6nUy6poU0cKaEHWt8DebPuQRMrcljLONxavMm3lg1LweoYijuYePV/OuG8j/uyOq4ZjXXtBtZub
 UaPzIuAPvzjrgQ3zCA6ISu5XUDhjSBiM1eYa+RRxw9BsYqGJYiFeDS1nqcgtqKvtJqX4YsORYSz
 hq2bF0UgslxlJpZP4rLAGb303nrNRymbYfUSmNF6Li59+M46oawxTWnkDUIEYS/ApuUNhpCJgwr
 mrlwJSm7vcbp2cqWp6tTF0W9sLX+LcY3DB07SPAuB8XCdN4ezrLW1BpIj1fTzyXOE/wKE6ZfqU2
 W3p35KRTrvGiaiJ+Lxg+cAdHYZn03aDG9QZJ0i7VGAqXAR4ImIBgKvV9p74dBDQsoBygc+QLfzB
 92E6n6j35tbJeE9cR5m22fnlnFcMgx2LqjYDSKrl+vKXd+8dfHamnT5BEwcjm6P4YCDGgWSHXJZ
 IyN0Ww3II9KBgwD0SQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601150028
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
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

On 1/14/2026 1:48 AM, Markus Armbruster wrote:
> Jaehoon Kim <jhkim@linux.ibm.com> writes:
>
>> Introduce a new poll-weight parameter for aio-poll. This parameter
>> controls how much the most recent event interval affects the next
>> polling duration. When set to 0, a default value of 2 is used, meaning
>> the current interval contributes roughly 25% to the calculation. Larger
>> values decrease the weight of the current interval, enabling more
>> gradual adjustments to polling duration.
>>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> [...]
>
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 28c641fe2f..b21cc48a03 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -85,6 +85,11 @@
>>   # @poll-shrink: how many ns will be removed from polling time, 0 means
>>   #     that it's not configured (since 2.9)
>>   #
>> +# @poll-weight: the weight factor for adaptive polling.
>> +#     Determines how much the current event interval contributes to
>> +#     the next polling time calculation.  0 means that the default
>> +#     value is used.  (since 10.1)
> When the default value is used, the actual value being used remains
> hidden.  Why?
Actually, I just followed the existing pattern of poll-grow, which also 
defaults to a factor of 2 when set to 0.
It wasn't my intention to hide the value; I kept this because the 
previous API has been working fine without issues.
If you think the actual value should be visible, I'll consider ways to 
make it explicit in the next version.
>> +#
>>   # @aio-max-batch: maximum number of requests in a batch for the AIO
>>   #     engine, 0 means that the engine will use its default (since 6.1)
>>   #
>> @@ -96,6 +101,7 @@
>>              'poll-max-ns': 'int',
>>              'poll-grow': 'int',
>>              'poll-shrink': 'int',
>> +           'poll-weight': 'int',
>>              'aio-max-batch': 'int' } }
>>   
>>   ##
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 6f5c9de0f0..d90823478d 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -606,6 +606,11 @@
>>   #     algorithm detects it is spending too long polling without
>>   #     encountering events.  0 selects a default behaviour (default: 0)
>>   #
>> +# @poll-weight: the weight factor for adaptive polling.
>> +#     Determines how much the current event interval contributes to
>> +#     the next polling time calculation.  0 selects a default
>> +#     behaviour (default: 0) since 10.1.
> This leaves the actual default behavior unspecified.  Is this a good
> idea?
I agree that the documentation should be more explicit.
I'll update it to clarify that the default factor is 2 and explain its 
meaning.
>> +#
>>   # The @aio-max-batch option is available since 6.1.
>>   #
>>   # Since: 2.0
>> @@ -614,7 +619,8 @@
>>     'base': 'EventLoopBaseProperties',
>>     'data': { '*poll-max-ns': 'int',
>>               '*poll-grow': 'int',
>> -            '*poll-shrink': 'int' } }
>> +            '*poll-shrink': 'int',
>> +            '*poll-weight': 'int' } }
>>   
>>   ##
>>   # @MainLoopProperties:
> [...]
>
>


