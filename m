Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EA5D2ED0A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7wDS-00042s-La; Wed, 01 Apr 2026 10:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w7wDO-00041i-GG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:06:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w7wDJ-0003ZW-Kv
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:06:38 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6316RGQn3329573; Wed, 1 Apr 2026 14:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EPv9sm
 PA3K+e9gqYAH88z0TZADK75w/Yzm1iwY2TcoM=; b=gLy0MHZ7FyZsGHPSw2R74c
 V1bk3qn7psS5FVD3J2795VUvmGwvaHoVJGSWUUrFS37DzaslNaE71QlDaQ8KXP99
 eTTNA86rOvvjMCJUCpmFqG7tG8r9jZn3fRm2JbcN9+qz38WfPWAQd+T+Wcla4R7B
 /iJD9XBlvlAowFR/UEbOaUdGgZ0M4A7fFQQz5qDEvGLEab+G3yZJTyZ8O/jThJxI
 ShJ2u2qbFDzIa985hRrkyO2//eoHXOFm703QEUARDEnzIARy8AdfPOo9Y7HgL20L
 5+8AToVWeMAu2t8+0DN5EaSCOCS3Po9JlFCu3sJLaVW5JAJa73TR/HjJiIF9zeSA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcft9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2026 14:05:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631BK4Cu005757;
 Wed, 1 Apr 2026 14:05:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy606a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2026 14:05:22 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 631E5Lkb11600386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Apr 2026 14:05:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C92058065;
 Wed,  1 Apr 2026 14:05:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3AB55804B;
 Wed,  1 Apr 2026 14:05:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Apr 2026 14:05:19 +0000 (GMT)
Message-ID: <2a137ad7-1033-446c-895d-0f91b3acba23@linux.ibm.com>
Date: Wed, 1 Apr 2026 10:05:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 7/7] hw/tpm: Increase TPM TIS max buffer size to 8192
From: Stefan Berger <stefanb@linux.ibm.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-8-armenon@redhat.com>
 <1334de4e-710c-4daf-aefd-3eee855aa35b@linux.ibm.com>
 <b6aed41c-c5fe-415f-8523-fb1b34ff77ec@linux.ibm.com>
 <acywxssfdmBqCIM3@fedora>
 <90bb955a-c951-4bf0-a77f-084096f12423@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <90bb955a-c951-4bf0-a77f-084096f12423@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cd2623 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=xt6ew7UTAAAA:8
 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=1y_Mo7BOKx3cEM7mvqcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-GUID: jukGuAC96LlPlrdhETzISw_wU5KbXyQX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEyOCBTYWx0ZWRfX0iKO28xtMctT
 dSy/j+PDZ8TGJhDib0v6bN3h8pL7qbQY2tcEBjOD9s3KiWA9gRsw2jsGbs63hNkZmowEWHxLB7N
 wvRHdNOKWCUTpuKSD6mSXm2Ku720fQeCBIzHrZXP1Y4u5eUAn33o3fIDTUoSVge3pA56J6ksQgq
 itQEOPcB9+eX/30+oMtaDvN9jEefwCQVcYpUyyy0ih3f0bIb0q64zeNM564/JBYjpZ2dZUKUotE
 vR3bAM73sW8zwvdQ85YEWlQcfuDKs4GNTIeJjF8+/DvzgxZeljvARWWGuAkdt1SHbLAW57W/xzp
 I02l2w+d5LCvVnBXveqc0+My3VImyQUekTCBm/XZw+prN6NvqaVi2QFNwt81DbpEZEE3UzUnvbZ
 EOldFfsZr+0EuFNbAAcYp4beeHi+sO+JskCqcLQKMwRv1IYFz9/v1FmgqJ0kEEd0NQVNfo13iZm
 Xk/TTjqxw0PORtJrNwg==
X-Proofpoint-ORIG-GUID: o0Xw8y8z8EdeRBj2EFglgONsOr1yq5Do
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010128
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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



On 4/1/26 9:43 AM, Stefan Berger wrote:
> 
> 
> On 4/1/26 1:44 AM, Arun Menon wrote:
>> Hi Stefan,
>>
>> Thank you for looking into this and providing with the additional
>> patches to handle TIS interface.
>>
>> On Tue, Mar 31, 2026 at 03:31:43PM -0400, Stefan Berger wrote:
>>>
>>>
>>> On 3/20/26 2:57 PM, Stefan Berger wrote:
>>>>
>>>>
>>>> On 3/19/26 9:53 AM, Arun Menon wrote:
>>>>> - Double the size from 4096 to 8192 so that we can have bigger buffer
>>>>>     enabling support for PQC algorithms in the TPM TIS interface.
>>>>> - v185 of TCG TPM rolls out PQC algorithm support. [1]
>>>>>
>>>>> [1] section 46 https://members.trustedcomputinggroup.org/wg/TCG/
>>>>> document/previewpdf/45151
>>>>>
>>>>> Signed-off-by: Arun Menon <armenon@redhat.com>
>>>>> ---
>>>>>    hw/tpm/tpm_tis.h | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
>>>>> index 184632ff66..0df35d5a54 100644
>>>>> --- a/hw/tpm/tpm_tis.h
>>>>> +++ b/hw/tpm/tpm_tis.h
>>>>> @@ -33,7 +33,7 @@
>>>>>    #define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
>>>>> -#define TPM_TIS_BUFFER_MAX          4096
>>>>> +#define TPM_TIS_BUFFER_MAX          8192
>>>>
>>>> Unfortunately TIS uses a fixed-size buffer that would now become 
>>>> bigger:
>>>>
>>>> typedef struct TPMState {
>>>>       MemoryRegion mmio;
>>>>
>>>>       unsigned char buffer[TPM_TIS_BUFFER_MAX];  <-- now 8192; 
>>>> before 4096
>>>>
>>>>
>>>> static const VMStateDescription vmstate_tpm_tis_isa = {
>>>>       .name = "tpm-tis",
>>>>       .version_id = 0,
>>>>       .pre_save  = tpm_tis_pre_save_isa,
>>>>       .fields = (const VMStateField[]) {
>>>>           VMSTATE_BUFFER(state.buffer, TPMStateISA),    <-- now 8192;
>>>> before 4096
>>>
>>> This will have to become VMSTATE_PARTIAL_BUFFER and the rest is saved 
>>> with
>>> VMSTATE_BUFFER_START_MIDDLE if necessary.
>>>
>>>>           VMSTATE_UINT16(state.rw_offset, TPMStateISA),
>>>>
>>>> Problem would be if an older version of the TIS (with size 4096) then
>>>> receives this 8192 buffer, we would (probably) get a buffer overflow.
>>>
>>> I created 2 more patches for the TIS. It's now also in my branch here:
>>>
>>> https://github.com/stefanberger/qemu-tpm/commits/crb-chunking/
>>
>> Looks good to me.
>>
>>>
>>> Both TIS and CRB can now transfer >4096 bytes packets.
>>>
>>>>
>>>>
>>>>
>>>>>    typedef enum {
>>>>>        TPM_TIS_STATE_IDLE = 0,
>>>>
>>>>
>>>
>>
>> Is it okay if I incorporate your commits, including the tests and
>> profile enabling support into my next revision of this series?
> 
> Yes, that's okay. Unfortunately the test will not work for most people 
> right now. The default-v2 profile is available via swtpm in git master 
> but it doesn't support ML-DSA since libtpms code with PQC is not public, 
> yet...

I added a 2nd search criterion for the profile content to check whether 
'ml-dsa' is supported. Fixed the style mistakes. Pushed. You can take 
them from there now.


> 
>>
>>
>>
>> Regards,
>> Arun Menon
>>
> 
> 


