Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E93F436B0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkHl-0002T8-Ik; Fri, 17 Apr 2026 10:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wDkHf-0002SW-9H
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:35:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wDkHd-0004Ru-2x
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:35:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HDdOED1842914; Fri, 17 Apr 2026 14:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7SxXh9
 LHJGOLlskTv4FuaoIlaNuBH4oq3/vSVWyOgGc=; b=qMZcPkmpDKN7qDa/Se2sVm
 3yfCkLpQAwneNWXEi2YyE3aS0ggvOAEMzNkgC+R/pQsu8HxX11T2vsnZgGdjRxCf
 cf8TfKLkgzUgpX+Z8plnGmEFhY3eLYwqMCgLFeGsQWlo689Y7bW4siMhVwdzyJmA
 WO1y6iMnbNVVJ7PnYhZgEsl8C0h2/DtdVYyg0NF2mDsB64wtvU5yICF6Dr6inywU
 wlBCuXODrfA4x09vtIHPvCL6LXNqSMpfcFyvInFvJJ5vOoUKavt82zZ+V0wzc1uJ
 jsqSkWJasa+suOmQ/w+KCzchsRWTKNSj0SKa0UwlF7VFMtENjoVBuj0psr0JRrUA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89n31g2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 14:34:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HAturT015153;
 Fri, 17 Apr 2026 14:34:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msyrkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 14:34:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63HEYm6l31195674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2026 14:34:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C67158054;
 Fri, 17 Apr 2026 14:34:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 214435803F;
 Fri, 17 Apr 2026 14:34:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Apr 2026 14:34:47 +0000 (GMT)
Message-ID: <923e81c9-fec4-4526-945d-e4b1b354a416@linux.ibm.com>
Date: Fri, 17 Apr 2026 10:34:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] hw/tpm: Add TPM CRB chunking fields
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260414082915.112122-1-armenon@redhat.com>
 <20260414082915.112122-2-armenon@redhat.com>
 <CAMxuvaw2=uupgJFynh_-2Nkj2VV+V6CqeOOB02A_p0LkOCFy9A@mail.gmail.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAMxuvaw2=uupgJFynh_-2Nkj2VV+V6CqeOOB02A_p0LkOCFy9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0NCBTYWx0ZWRfX5EG12g0JkAfb
 1EwVl0DvW9hVkTBisaLjZqTIZrSKzlqUG9w8OKLLMezjoaQUs2FjmwX7yv9pBtWFE+EUEeMAi0V
 mIw9zcdNZxK/ao26ENQAmVMRhsFN9lRjjill6IRVMFAnTfl5KuyZz7wv5093ttGCLN9TxDGXZjp
 asrv4yhcJQTl+ot5voZWKD/8V7aUEMUK0CD01tX68E2V7/+b88ea0AcKhq3XI2NHrgtJQn/pEt5
 qVkvpVEsQhf4aNCuk9TT9JzSMmsrlay3dvnPQ/XIc2X+2HLKadL8AlN6OknZ47F0I4a6HTLEZzP
 bgqkZql9H6+swO3weXtZFsWNo4UkMw8GlVesqubd9xCbPGfoNSF5zoUQYHHGDYzvA2QxpJK8epq
 poiDvZktTaxKwaLP8B5i13qyW0wPRM+ArDS+tho+spXUYQiOwsk8hXv4oEh/UZn93xCjBJDc7Cn
 2mOk1aOkC2Funs8XZnA==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e2450a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=xt6ew7UTAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=o9JcgEiIe0jxKjj7qAYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-GUID: DQAKJ4XZiHxNvEpoAwsQTZHZUcy80xex
X-Proofpoint-ORIG-GUID: JuIM9esKmBzjbLqCK4xaio4iBR-dPNMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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



On 4/17/26 6:05 AM, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Apr 14, 2026 at 12:30 PM Arun Menon <armenon@redhat.com> wrote:
>>
>> From: Arun Menon <armenon@redhat.com>
>>
>> - Add new fields to the CRB Interface Identifier and the CRB
>>    Control Start registers.
>> - CRB_CTRL_START now has 2 new settings, that can be toggled using the
>>    nextChunk and crbRspRetry bits.
>> - CapCRBChunk bit (10) was Reserved1 previously. The field is reused in
>>    this revision of the specification.
>> - Refer to section 6.4.2.2 of [1]
>>
>> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf
>>
>> Signed-off-by: Arun Menon <armenon@redhat.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/tpm/tpm_crb.c      | 3 +++
>>   include/hw/acpi/tpm.h | 5 ++++-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>> index 8723536f93..0a1c7ecdc6 100644
>> --- a/hw/tpm/tpm_crb.c
>> +++ b/hw/tpm/tpm_crb.c
>> @@ -59,6 +59,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
>>   #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
>>   #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
>>   #define CRB_INTF_IF_SELECTOR_CRB 0b1
>> +#define CRB_INTF_CAP_CRB_CHUNK 0b1
>>
>>   #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
>>
>> @@ -262,6 +263,8 @@ static void tpm_crb_reset(void *dev)
>>                        CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
>>       ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>>                        InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>> +                     CapCRBChunk, CRB_INTF_CAP_CRB_CHUNK);
> 
> We should not expose that new capability to guests without an explicit
> "cap-chunk=on".

You mean put this on the QEMU command line? This new capability is 
really only needed if the user chooses PQC algorithm support (but then I 
was also going to allow for 7kb writes to NVRAM spaces rather than 1kb 
writes so far) and if the user chooses a swtpm profile with such support 
but then fails to set this flag, some transmissions won't work. What 
would be the problem if we exposed this new feature all the time and if 
we can avoid state backwards-incompatibilities, which IMO is the most 
important aspect, if we detect that chunking was not used by the driver 
and only write additional state if found absolutely necessary? I would 
prefer to untangle the user's choice of enabled algorithm from the 
choice of such a flag. But then there's the aspect of OS drivers that 
could use chunking even when not absolutely necessary (?).


