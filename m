Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417F210AB830
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w686A-0000zK-BQ; Fri, 27 Mar 2026 10:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w6864-0000yQ-S2; Fri, 27 Mar 2026 10:23:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w6862-0008K7-FA; Fri, 27 Mar 2026 10:23:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RBtST63011996; Fri, 27 Mar 2026 14:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EdK/Jg
 SesEPPSCpTKYAfrXPVnFDdFRqRm4OJiHjrEgc=; b=Gjs/1DjUDQOPKQNLUeBf5L
 j9vRrpfl6I1JK8fPZcYlQz9/dA31/ENOiiCyKKLM1wz9pDaP02BBheHGSDGZ0Ni/
 YD6jWPfYMIeeMQJU9NJcwApc9ur5qNhp/kQIj4hayecdm5K1sWpXBc0RwtUtndqF
 /JDKpksMGhZvrpVdYGZnSHIsXr7/RWRhhuzMgM3WiGe04i8hQJ4+2qHeopi6pCcc
 +jcHnFgJR65N6XWpEe5kaQHoULBL9Ag0K99xfXH2HJW33RTzhN0S+XJL3XiQ5eew
 b4bNY8T6pIXZ5BwuETQV06R2047pmQZ9vWykJXVbddwlk8NDAlR4L0rVq3e+8hYw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqtmdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 14:23:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RA8hxv005972;
 Fri, 27 Mar 2026 14:23:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yywpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 14:23:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RENPta24183500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 14:23:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84AD058056;
 Fri, 27 Mar 2026 14:23:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26B1958052;
 Fri, 27 Mar 2026 14:23:25 +0000 (GMT)
Received: from [9.24.20.109] (unknown [9.24.20.109])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 14:23:25 +0000 (GMT)
Message-ID: <a091f567-d40b-4599-b152-300417566aee@linux.ibm.com>
Date: Fri, 27 Mar 2026 09:23:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/3] qapi/iothread: introduce poll-weight parameter
 for aio-poll
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pbonzini@redhat.com, stefanha@redhat.com,
 fam@euphon.net, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-4-jhkim@linux.ibm.com> <87o6kckntx.fsf@pond.sub.org>
 <738e8d90-b08f-4ded-bd8d-3155a665a725@linux.ibm.com>
 <871ph5ddpt.fsf@pond.sub.org>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <871ph5ddpt.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u6On1Wpb1GhLLMl5R3fMP98IMSFrdZt0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA5OCBTYWx0ZWRfX1W8mqbxGwk3Z
 rMcjcXo7kjf1DJgtIS5IOLqgccgO7o4BZszoN7cZz6qYPNKmv0eszrluVA82x6Qc0H9bUBcDyC9
 lZYFXvtYjc8I0q1g7apv2XO02k333LSvh8Kt6TFrXctF9/ZyYHvTSyXgwVe75PNUQvB4EsLhxlh
 ohVhIvMCE5UtetpdcsLklmWfN+P2r32aV/BjVZUC5zOQ2xvxYD9B4VQThNRjyIXmUqfwFhEkSKt
 n/e74H3oy8XUOTdT6ED83USkQdLCcKYXVsl/B0FMVIorKBn8xfWtJgJZdwtKAcFCdX2/DPAJyL1
 okbTzmMpPvZM7f8nzaGCe70rKGaPNNYjtcvoWAwqMiDI58pKk8pb6K3G5nVFNytSwby6O5M8jK8
 dzHIguo1mwN61Uhgv6YdFNyMeUkNmySrX+eolxewUVuZAIGZacgAcdAoFAHTQOqO0zeiMAsi0fL
 s8iQxL/NEY5Zflr6Rlg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c692e0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=la9hvUlag_OujclZBe4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: u6On1Wpb1GhLLMl5R3fMP98IMSFrdZt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270098
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

On 3/27/2026 12:49 AM, Markus Armbruster wrote:
> JAEHOON KIM <jhkim@linux.ibm.com> writes:
>
>> On 3/25/2026 9:04 AM, Markus Armbruster wrote:
>>> Jaehoon Kim <jhkim@linux.ibm.com> writes:
>>>
>>>> Introduce a configurable poll-weight parameter for adaptive polling
>>>> in IOThread. This parameter replaces the hardcoded POLL_WEIGHT_SHIFT
>>>> constant, allowing runtime control over how much the most recent
>>>> event interval affects the next polling duration calculation.
>>>>
>>>> The poll-weight parameter uses a shift value where larger values
>>>> decrease the weight of the current interval, enabling more gradual
>>>> adjustments. When set to 0, a default value of 3 is used (meaning
>>>> the current interval contributes approximately 1/8 to the weighted
>>>> average).
>>>>
>>>> This patch also removes the hardcoded default values for poll-grow
>>>> and poll-shrink parameters from the grow_polling_time() and
>>>> shrink_polling_time() functions, as these defaults are now properly
>>>> initialized in iothread.c during IOThread creation.
>>>>
>>>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> [...]
>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index c653248f85..feb80b6cfe 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
>>>> @@ -606,6 +606,11 @@
>>>>   #     algorithm detects it is spending too long polling without
>>>>   #     encountering events.  0 selects a default behaviour (default: 0)
>>>>   #
>>>> +# @poll-weight: the weight factor for adaptive polling.
>>>> +#     Determines how much the current event interval contributes to
>>>> +#     the next polling time calculation.  Valid values are 1 or
>>>> +#     greater.  If set to 0, the default value of 3 is used.
>>> The commit message hints what the valid values mean, the doc comment
>>> doesn't even that.  Do users need to know?
>>>
>>> Code [*] below uses it like time >> poll_weight, where @time is int64_t.
>>> poll_weight > 63 is undefined behavior, which is a no-no.  Please reject
>>> such values.  poll_weight == 64 results in zero.  Is that useful?
>>>
>>> Missing: (default: 0) (since 11.1)
>> I agree. I will update the doc comment to give users a practical hint,
>> for example like this:
>>
>> # @poll-weight: the weight factor for adaptive polling.
>> #     Determines how much the most recent event interval affects
>> #     the next polling duration calculation.
>> #     If set to 0, the system default value of 3 is used.
>> #     Typical values: 1 (high weight on recent interval),
>> #     2-4 (moderate weight on recent interval).
>> #    (default: 0) (since 11.1)
> Better, thanks!
>
>> I will also a check in the code so that values exceeding the maximum
>> allowed will revert to the system default.
> Don't silently "correct" invalid input, reject it!
>
> [...]
Hi Markus,

Thank you for the review.
I will change the code to reject invalid values instead of silently correct
them in the next version.

Regards,
Jaehoon.

>


