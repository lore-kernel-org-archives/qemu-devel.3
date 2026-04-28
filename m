Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CC8FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 18:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHnOU-00029z-A2; Tue, 28 Apr 2026 14:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wHnO0-00027m-3S; Tue, 28 Apr 2026 14:42:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wHnNy-0000TJ-Et; Tue, 28 Apr 2026 14:42:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SHdoRK2992108; Tue, 28 Apr 2026 18:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uPyD0/
 R3065csntNifwWBiYyTkiZwiG4VzLtrPZ3v5U=; b=ScGJ7dVqXBVn/KNcGDVB4d
 Wf3MevC4Uie25/FANp3dgwxcPMmSYwsaCS3SxI5rvvh8ZXJWZHBDKCMrMZEaCe9u
 0KlGnnpIFk9M/WojByXKAgVH7DV/UfYwQUjUGcFoojHZkf/oiU2Q7XKWIgA1Ajwv
 OzUqjGlWsgMfM7CNUxeXyhmfoaMNUqTt8r6leq0jqKKucyTKirkxN/n9bFOUmOej
 sWFwTrjUGOeG0sMVd9dxHXSvvL7Ov68TPU7oFwSkLhhTjx6pl9YPyVRjLTKoy4sX
 NISfj0nowipSEiHEpYeDOUsS/OaPRu+MJr6sn5wXcJoMQv3QO1ceEsybmxSYpWew
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44q787-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 18:42:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SIcitw027103;
 Tue, 28 Apr 2026 18:42:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqb6xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 18:42:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SIgB7Q29491758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 18:42:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3882A58056;
 Tue, 28 Apr 2026 18:42:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7450E58050;
 Tue, 28 Apr 2026 18:42:09 +0000 (GMT)
Received: from [9.61.117.177] (unknown [9.61.117.177])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 18:42:09 +0000 (GMT)
Message-ID: <efe0260f-a428-4a45-b62b-f9060a108e45@linux.ibm.com>
Date: Tue, 28 Apr 2026 14:42:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-21-zycai@linux.ibm.com>
 <d2aff9be-2597-4d58-9185-0c805114669a@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <d2aff9be-2597-4d58-9185-0c805114669a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WNhpLRXYFj3D410SuoHhrzI4WHwEM5f6
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0ff85 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Wv7c5jHNMYNyHBlV5jsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WNhpLRXYFj3D410SuoHhrzI4WHwEM5f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE3NyBTYWx0ZWRfXxNx9zwCpWCpq
 tAZrAiVeGiHJKI2pnMESuRQoRl8A7C1ei6o2SeM8ErjGBc7v1Z8VMfhVoOepgS43o/Nj61Z6vWF
 H9L9XAsgzD8IgsSsk469DP8jwCMavnBZ8+oCC7IviiIRfQaS1AjiH7FOdfEj39G8M94/UdvwM6n
 MM5cIvjA3N030MnCXlnU9tzZlwtQs8pz3qQUkmGks+lxoRskUehavNZDQzTToDtSAu0DRoLogsJ
 dwuFabzlVLQxctL8RqqZKFcVBR00oc4Ap4u/Q6bngbvucqPG+LUPAFXFM3Hq3WZhQpa/2pZGF/J
 cxOtDC9a0ddAKoxpKkWLA6fMID7X05yTh7n+H/cnjyNEHWRaSzES1vBY87wnEAmQVTE0EiUdog6
 UXGrMMKx6wzOGHI9n7yVrRUOnNU8uPVqgLQ1xU72RPkoSIuSMUmLEioRyGAyCXapWh9ETXx0EiM
 2oyFBmqsjtbaXQEoDLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280177
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 4/15/26 12:36 PM, Jared Rossi wrote:
> 
> 
> On 4/2/26 6:14 PM, Zhuoying Cai wrote:
>> Add address range tracking and overlap checks to ensure that no
>> component overlaps with a signed component during secure IPL.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/secure-ipl.c | 58 ++++++++++++++++++++++++++++++++---
>>   pc-bios/s390-ccw/secure-ipl.h | 15 +++++++++
>>   2 files changed, 69 insertions(+), 4 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>> index b66ca9ca7e..d2079e19bc 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.c
>> +++ b/pc-bios/s390-ccw/secure-ipl.c

[...]

>> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
>> index 6d65cd5596..c625ac2e3a 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.h
>> +++ b/pc-bios/s390-ccw/secure-ipl.h
>> @@ -24,6 +24,21 @@ typedef struct SecureIplCompEntryInfo {
>>       uint8_t  flags;
>>   } SecureIplCompEntryInfo;
>>   
>> +typedef struct SecureIplCompAddrRange {
>> +    bool is_signed;
>> +    uint64_t start_addr;
>> +    uint64_t end_addr;
>> +} SecureIplCompAddrRange;
>> +
>> +/*
>> + * Custom struct for managing a list of secure IPL component address ranges.
>> + * Tracks up to MAX_CERTIFICATES address ranges with an index counter.
>> + */
>> +typedef struct SecureIplCompAddrRangeList {
>> +    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
>> +    int index;
>> +} SecureIplCompAddrRangeList;
> I don't think 'index' is the correct name for the variable. Something 
> like 'num' would be better, since it is the total number of address 
> ranges, right?
> 

“index” refers to the index used to access comp_addr_range, but I agree
that num could be a better name since it represents the total number of
address ranges. I’m happy to rename it if preferred.

>> +
>>   static inline void zipl_secure_handle(const char *message)
>>   {
>>       switch (boot_mode) {
> 
> Regards,
> Jared Rossi


