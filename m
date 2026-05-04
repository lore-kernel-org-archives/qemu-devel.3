Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43094CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 20:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK00j-0006iO-3x; Mon, 04 May 2026 16:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wK00b-0006ZW-Le
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:35:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wK00Z-000101-2z
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:35:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644BQYf61920948; Mon, 4 May 2026 20:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4+4phm
 XbY9KT6SPGZgnpZK94sedMxq8c6/2lNfp4HmE=; b=eps6z8JBiVJCaHZyPV21Up
 gbTis3sle3+f0cPVn0cMBdAljPgyqovkjkA5Q+SM1hBfRR/fIwUs+ouB5oFdwtnY
 bIhAkCJutaY9JHdlaCizqU/lVoK4dTKGhn0SDfrSvHCsIoWrFCxxrr854edpzXEk
 Y/t91ECUF3XCth8W6deXTXeq36tf/6R20Ky0HL51XzT2oc5VhFrdz32kMCfj8YTn
 xEDVnrwdzZ+spQlSdX4gzg1OIgOwUnYsr3XIsuJRrH7pWLFIOFqM1SOw57Pk4PSM
 4smXnRFUjX5g+wGH76w07H+XsGXV0Rl8JRNAJqz7yHgha5yGWxFSszWRGgXLQqZg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v78udj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:35:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644KOOOx008263;
 Mon, 4 May 2026 20:35:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq6vuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:35:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644KZ1c428508708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 20:35:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D47358059;
 Mon,  4 May 2026 20:35:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 290125804B;
 Mon,  4 May 2026 20:35:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 20:35:01 +0000 (GMT)
Message-ID: <eeb33bf9-ac50-47aa-8f18-ef2703a76005@linux.ibm.com>
Date: Mon, 4 May 2026 16:35:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Dynamically allocate tpm-tis buffer
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20260427200134.453022-1-armenon@redhat.com>
 <765f0577-ee8f-4944-93fe-bb93e420668f@linux.ibm.com>
 <afBbLDmdYFY5feJx@fedora>
 <84607c2e-1da9-43d2-8a5b-e50e91c0f8ba@linux.ibm.com>
 <4b5c983e-8bbb-4851-bb0f-f478ad14121b@linux.ibm.com>
 <afJk9Lsn25UQOnwE@fedora>
 <43171c3b-339c-4335-b79b-387442048b11@linux.ibm.com>
 <0544d36a-89b4-4948-9fb5-8cb013842fc7@linux.ibm.com>
 <afjg-tqJ1zbkQNb6@fedora>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <afjg-tqJ1zbkQNb6@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE4NSBTYWx0ZWRfX6htBj14wCSUn
 KUBOMr/0Fq1xhBtBU/AI1ujoQZ2ochhoR91rA/NejCTe57MOPNjckaUe1ndoqoMkoDbv6e0V2ot
 4t4Yx84lOZ1kgWhE9NjhrwNDTM4Xu11EZr4tBO9RsvYW/3Fu4Yxc6l+A8B7iNlNY7gLhi0Wlj7a
 g5V8Y6nDOBf4vT27kxi4++Yg3OhPt39wt6peG6cd35LJfweUlYvvZ/Pkp1vzVaP3fQkIDifDUsy
 CTOyVo0Po+3u8BefFvfFLhmnmvF0hea3UiEbVrdXGgKgpYNOlZ78LGJv64BKupbranwOH8MSBA/
 7JhUuU83y8R3PXhCx2PQSB+S6r8qqHqDA6My9YQgpZcSzHCUGiUWFQyDoPRpZx/arQ5sOLolmX1
 qT6wfzzz3rKnGANn0FjMpZvNA0n1RsbMBzLEGgd9I4kRDAYEK/aVepn20dK5eOthvUAL4YiMQdp
 L9PuypqbwHjg668I4GQ==
X-Proofpoint-GUID: Q7R7o38aLoCbI2NCZgmQBbjKksSG3vXt
X-Proofpoint-ORIG-GUID: Q7R7o38aLoCbI2NCZgmQBbjKksSG3vXt
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f902f7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=15vJrr9YfUU3egPWT3gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040185
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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



On 5/4/26 2:10 PM, Arun Menon wrote:
> On Thu, Apr 30, 2026 at 04:43:27PM -0400, Stefan Berger wrote:
>>
>>
>> On 4/29/26 11:40 PM, Stefan Berger wrote:
>>>
>>>
>>> On 4/29/26 4:07 PM, Arun Menon wrote:
>>>> Hi Stefan,
>>>>
>>>> On Wed, Apr 29, 2026 at 02:15:16PM -0400, Stefan Berger wrote:
>>>>>
>>>>>
>>>>> On 4/28/26 8:57 AM, Stefan Berger wrote:
>>>>>>
>>>>>>
>>>>>> On 4/28/26 3:01 AM, Arun Menon wrote:
>>>>>
>>>>>>>>
>>>>>>>> With MAX() it can now be bigger than TPM_TIS_BUFFER_MAX if the
>>>>>>>> backend says
>>>>>>>> so -- hm...
>>>>>>>
>>>>>>> TPM_TIS_BUFFER_MAX is still 4096.
>>>>>>
>>>>>> Oh, I had still based my patches on your TPM_TIS_BUFFER_MAX increase to
>>>>>> 8192 bytes. Let me fixes this along with a few other things. I will let
>>>>>> you know.
>>>>>>
>>>>>> I have another series that I will post now that can be applied to
>>>>>> master. It's adding a test for TIS over I2C but I will need to extend
>>>>>> that one also with the large transfer test case then.
>>>>>>
>>>>>>
>>>>>
>>>>> So I have resolved this issue now along with a few other things.
>>>>> My branch
>>>>> is here: https://github.com/stefanberger/qemu-tpm/tree/work-tpm-for-11.1
>>>>>
>>>>> - I have applied the i2c swtpm test case series first since it could be
>>>>> easily upstreamed first
>>>>> - Then your patch "migration/vmstate: Add VMState support for
>>>>> GByteArray"
>>>>> - Then the CRB chunk + TIS extended buffer support series. I modified my
>>>>> patches (last 4 in that series) to
>>>>>     - increased MAX_TIS_BUFFER_SIZE to 8192
>>>>>     - added migration blockers dynamically for TIS whenever >4096
>>>>> bytes are
>>>>> either in the request or response; remove them later on again
>>>>> when device
>>>>> goes into ready state for example
>>>>>     - added large transfer test also for i2c
>>>>>
>>>>> Please pick up those patches for v6 posting, or otherwise you
>>>>> can split your
>>>>> v5 series up into CRB-only support for v6 and I post my (last 4) patches
>>>>> later on.
>>>>>
>>>>
>>>> Thank you. I agree. I will post v6 as CRB-only support. The GByteArray
>>>> patch is already accepted. The complex TIS changes can be posted
>>>> separately later.
>>>>
>>>> Regarding the TIS buffer: I saw you implemented the migration blockers
>>>> and 8192-byte increase in your branch. Should I discard my
>>>
>>> It's quite dynamic with the blocker being set when 4097 bytes of a TPM
>>> command were received or when a TPM response with > 4096 bytes is
>>> received. The blocker is removed when the device goes into ready state.
>>> The intention is to allow a user to choose an old machine type with a
>>> PQC-enabled swtpm+libtpms and be able to migrate to an older version of
>>> QEMU unless the blocker was set. Correct me if I am wrong in my
>>> thinking...
>>
>> Another solution would be to limit the 8kb buffer to 4kb for 11.0 and older
>> machines.
> 
> Yes, I have limited this using the post_load hook for the extended part.
> 
> +int tpm_tis_ext_buffer_post_load(TPMState *s)
> +{
> +    /*
> +     * Calculate the maximum extension buffer size allowed, by comparing
> +     * the destination VM's backend capacity with TPM_TIS_BUFFER_MAX.
> +     */
> +    uint32_t max_ext = s->be_buffer_size > TPM_TIS_BUFFER_MAX ?
> +                       s->be_buffer_size - TPM_TIS_BUFFER_MAX : 0;
> +
> +    if (s->ext_size > max_ext) {
> +        /*
> +         * Source buffer size is greater than what the destination backend
> +         * allows
> +         */
> +        g_clear_pointer(&s->ext_buffer, g_free);
> +        return -EINVAL;
> +    }
> +    if (s->ext_size > 0) {
> +        memcpy(s->buffer + TPM_TIS_BUFFER_MAX, s->ext_buffer, s->ext_size);
> +        g_clear_pointer(&s->ext_buffer, g_free);
> +    }
> 
> We may use this patch in future if we want to change static to dynamic
> buffer array allocation.

I posted now what I have beyond your v6 CRB patches and we can see in 
which order we want to switch to dynamically allocated buffers.

> 
> 
> Regards,
> Arun Menon
> 
> 


