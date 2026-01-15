Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D84AD44C6F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgPm8-0004td-O2; Thu, 15 Jan 2026 11:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vgPm7-0004sb-67; Thu, 15 Jan 2026 11:00:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vgPm5-00084r-5Q; Thu, 15 Jan 2026 11:00:42 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60F67LvU025028;
 Thu, 15 Jan 2026 16:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vuaQhm
 6piBUjExMxTUmJhCGHOCR+J4bC0H7O+vSS0bs=; b=MzXFlra/PANX9DmRiDWWuJ
 A6l+SgfFX+dTzd1NecAdNqC+fd0gO17CF/Xy3yHKHBSu7+7Nzwkjf0KZJDzbxJ4u
 ftg0cdqzxKPmqa1AGDzBXVDD9XdeuiMMG78bvh58hbqC7dFJ0lCTO+uqggJJWI+/
 mS89GrAt/B3sitjGqbDlLU9OVflQaN3wQN8WSpa16cUDKQt5LUPZz8LteQNE42KM
 rPMg8yqq18pGkYtS0fMOVdFj3YgPTxcZtI1lOdHdneoyEn73O1o1dqZ0599VgC+1
 Qc/S+O/F7fSYNjrD9VXiwGGkFMjn3zhy/z9epyUE4RwqKFjRdRgk5+oCHTrPBNwA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4qd3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 16:00:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60FDDblW031255;
 Thu, 15 Jan 2026 16:00:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3t20kp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 16:00:35 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60FG0Y0C25166522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jan 2026 16:00:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA3775806A;
 Thu, 15 Jan 2026 16:00:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5156B58063;
 Thu, 15 Jan 2026 16:00:34 +0000 (GMT)
Received: from [9.24.20.72] (unknown [9.24.20.72])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 Jan 2026 16:00:34 +0000 (GMT)
Message-ID: <902d8110-b7c9-435b-84d3-d171faa555c8@linux.ibm.com>
Date: Thu, 15 Jan 2026 10:00:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 3/3] qapi/iothread: introduce poll-weight parameter
 for aio-poll
To: Halil Pasic <pasic@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 stefanha@redhat.com, fam@euphon.net, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 sw@weilnetz.de, devel@lists.libvirt.org
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260113174824.464720-4-jhkim@linux.ibm.com> <87qzrs4oud.fsf@pond.sub.org>
 <eb891295-5ffd-4613-bc37-56d8a07d1fff@linux.ibm.com>
 <87ikd3xrkc.fsf@pond.sub.org> <20260115110532.27cb1516.pasic@linux.ibm.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260115110532.27cb1516.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDExOSBTYWx0ZWRfX1wt+tVfDShff
 Hk/zvRmM42I1TOro5RU0pAxBxw21qAg+YYYOltV57lZHv9URtZgVIfpsojVkLA8f/tL9qVg6DES
 hQQNJ77q26fFr5V1vlyzOiGJxu4cUTM3RIFLKTtdSUAhpLvPkmIfmENW/xjPDid+KY/vWb2hPI0
 vX68C7uExmuYUYLXHJyfEnQ8Wo/hw9PkOWIyp3CEEif7Nc6uNWfwrn+jFEo3N93wy0OICaraf98
 4l7BMdyWjXhbxWos/8M8P1PKFGwLP1d3SHtctxljm/Zu372aay4JLndYkOfhbIEmw9VGYLv/dq1
 4YBb+l1rEQbZwBQqN9MamQIlA1RdKELRfaJjbsmjcwrXRI1/Td+H2xg7SQ0FCxUXvegOY1AtJvw
 zj7B34aRKMvracy8o5wE9pmj/sS/dgpCeUr7AL8+CNjCXHhWGyohEt+TvTV9goe8P+Xy2nKaieU
 5TpGmQYF5KDTdFhvymg==
X-Proofpoint-ORIG-GUID: H2DJ1l9kK1V1j8BZ5VNexrrGrEJQ5uvM
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=69690f24 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=RJ7VnkRXJxR4zq9O5SEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H2DJ1l9kK1V1j8BZ5VNexrrGrEJQ5uvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601150119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 1/15/2026 4:05 AM, Halil Pasic wrote:
> On Thu, 15 Jan 2026 08:28:51 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> I understand that you're mirroring how @poll-grow and @poll-shrink work,
>> but let's ignore that for a minute.
>>
>> Compare four possible interfaces:
>>
>> 1. Optional @poll-weight defaults to 2.  Values <= 0 are rejected.
>>
>> 2. Optional @poll-weight defaults to 2.  Value 0 is replaced by the
>>     default value 2.  Values < 0 are rejected.
>>
>> 3. Optional @poll-weight defaults to 0.  Values < 0 are rejected.  Value
>>     0 makes the system pick a value, namely 2.
>>
>> 4. Optional @poll-weight defaults to 0.  Values < 0 are rejected.  Value
>>     0 makes the system pick a value.  It currently picks 2.
>>
>> The difference between 3. and 4. is that 3. makes "system picks 2" part
>> of the contract, while 4. doesn't.
>>
>> 1. is the simplest.  Is 2.'s additional complexity worthwhile?  3.'s?
>> 4.'s?
> Isn't there more options? Like
>
> 5. Optional @poll-weight defaults to system-default.  Value 0 is replaced
> by the system pick the system default value. Currently the system default
> value is 2. Values < 0 are rejected.
>
> That would mean:
> * current value inspectable
> * system default not part of the interface contract
> * interface offers a "please go back to value not user specified:
>    operation
>
> BTW I like your approach with explicitly listing and evaluating the
> options a lot!
>
> Regards,
> Halil
>
Thank you both for laying out options 1-5 so clearly; the detailed 
breakdown was very helpful.
After considering the trade-offs, I agree that "Option 1" is the 
simplest and most robust interface. It ensures the value exposed to 
users always reflects the actual effect.
Option 5 is a clever way to reset values, but I'm leaning toward Option 
1 to keep the interface as predictable as possible.
Avoiding special meanings for '0' makes the logic easier for users to 
reason about.

I will update the next revision to follow "Option 1".
Thanks again for the feedback!



