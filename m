Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2182DC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkSWG-0004z9-67; Thu, 16 Jul 2026 16:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wkSVg-0004ui-Pl; Thu, 16 Jul 2026 16:16:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wkSVd-0003gS-Sh; Thu, 16 Jul 2026 16:16:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GKBpid021744; Thu, 16 Jul 2026 20:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=phvh1e
 r0LibAnWbpDiN/82scQNhDpi63i/Q6JAfsSdQ=; b=CJFOddUNI8+WyIHoTC3MnM
 2q5C5MjqNu2+56fyUSIdhqRrHam+amBpEzfSLmokndJNHqUu33kDs1yTzwWaB0t6
 rIpKmefbWnKrx1UkBsBS6CxA3m7Jn41NT1EWYV2vh8q6d/qoAwb7q0smxntlCdF1
 H0Ldq0b5ahIjMHSyvmyBA+rPpI5Flkt0/EgHA2hmpN9KMZULZtJHwjVwhjjsiDxd
 fwteWY0tagc30TwCJHg0x3Sz+S+UCUHu1OmHmADS/WrJXMEJB4J+SQINdFSbeHMf
 xRHqz/WnJJSmG6o9d3j7JYY9SizIs1zdNAWp8k1cuo3qjHCbmQ2MYGIJOEfn8HiQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtjy66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 20:16:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GK4jnb001226;
 Thu, 16 Jul 2026 20:16:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwetd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 20:16:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GKGEEG21561860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 20:16:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F259F58062;
 Thu, 16 Jul 2026 20:16:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C47945805E;
 Thu, 16 Jul 2026 20:16:12 +0000 (GMT)
Received: from [9.67.41.202] (unknown [9.67.41.202])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jul 2026 20:16:12 +0000 (GMT)
Message-ID: <9b4e79c8-6b57-46e1-94ab-919a16798b13@linux.ibm.com>
Date: Thu, 16 Jul 2026 16:16:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 23/33] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
 <20260707234047.2499921-1-zycai@linux.ibm.com>
 <20260707234047.2499921-4-zycai@linux.ibm.com>
 <17778d69-9860-4713-9321-a1293064fc06@linux.ibm.com>
 <89882b65-07c4-4b26-85ad-7c1638a829cf@linux.ibm.com>
 <a869dade-8b64-4d70-8fe5-fd1347c84559@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <a869dade-8b64-4d70-8fe5-fd1347c84559@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Brsf-ErUKp7XhTBl6vk37bWXhVQe4GIH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX5TMBh4sjrtRp
 n7DC00M3F2MvKHH33eNbaSSZPHlJPo6KFDt9m9d0XyB9DGi1tLLTfk7vK3NrhfwufUPT9CRGPAj
 RbkRIvcNEdoUdiQWY9xqLsE8UNdtiq8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX2DkcFtDT4TUM
 SPmLICAlTquP+JmDnv6S+H6qHK+XhTeGlg6qrwftuLI01SaG1xsM+OYqBHhxgh727W6vwU7cBZM
 QgZdtyMdkjH/kJNrxSk4S9ynZOeE8I9W3eogpyy0iAw/AyytJRkjDv3vZqjKUsh14KzE/bNkXF4
 YU/nwtjpqZmgRKFRqsPv12h0Ukje9L6mvuClnEGBbM2KclsFrdlhIMiAQPHQDLvbleKKgSIQ735
 cXv1b3orJQCFFpp2QjzemrFwCT+IMlBuei+ewJziWgWNPleaLq6rKwupePgumGUHWDRq591LAre
 FMA8LdOe8eihge40U/DbZqlDES+sIvjxFWsfiDK1NXbOaYxtTqR0/OgtrEkj1kawIBkziljx7hG
 r5z1N/YRyVuBSqtJJVKB3PS8eiD5pDLPZxxKctY+Gm3QP4B5GqxARojssOFTymMLBmPk6T1Gu+M
 eeN+w5OHBwzhavgUxqQ==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a593c10 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=tdMvfBfS8nACWcF_XGIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Brsf-ErUKp7XhTBl6vk37bWXhVQe4GIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160206
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 7/16/26 12:36, Zhuoying Cai wrote:
> On 7/16/26 10:05 AM, Jared Rossi wrote:
>>
>>
>> On 7/15/26 4:37 PM, Collin Walling wrote:
>>> On 7/7/26 19:40, Zhuoying Cai wrote:
>>>>       /* should not return */
>>>>       write_reset_psw(entry->compdat.load_psw);
>>>> +
>>>> +    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
>>>> +        update_cert_list(&cert_list);
>>>> +        update_iirb(&comp_list, &cert_list);
>>>> +        free(tmp_cert_buf);
>>>> +    }
>>>> +
>>> Sorry if I missed this from the previous rounds of review, but why was
>>> this moved outside of `zipl_run_secure()`?  It seems out of place here.
>>>
>>> If there is justification for it, I'd suggest at least moving this chunk
>>> a few lines up to before the `write_reset_psw` call to keep the "IPL
>>> jump" code together.  The comment above is meant for the following chunk:
>>>
>>> ```
>>>      /* should not return */
>>>      write_reset_psw(entry->compdat.load_psw);
>>>      jump_to_IPL_code(0);
>>>      return -1;
>>> ```
>>>
>>> Otherwise the comment is a bit misleading.  I suppose one could argue
>>> the comment should actually be placed abouve `jump_to_IPL_code`, but
>>> let's not bother with that change.
>>>
>>
>> This was something I had asked for, but I don't recall if it was in a 
>> review comment or internal discussion, but a brief summary for the sake 
>> of posterity...
>>
>> Moving the call to update_iirb() was necessitated by a different change, 
>> which was to use a specific memory address range for storing the cert 
>> list.  The fundamental issue is that we wanted to store the cert list at 
>> a calculated address to ensure it is not clobbered before the kernel 
>> reads it.  My idea was to reclaim the space previously used for chained 
>> IPLBs.  The chained IPLBs and the cert list are never needed at the same 
>> time, so that isn't an issue; however, the impact of reclaiming the 
>> space is that we destroy our IPLB chain, meaning, once we write the cert 
>> list, if the IPL subsequently fails, we no longer have the fallback IPLB 
>> to try the next device in boot order.  To deal with this we delayed 
>> updating the cert list and IIRB until we are committed to boot from the 
>> selected device, that is to say, once we have progressed through the IPL 
>> far enough that there is no longer any possibility of falling back to a 
>> different device.  As such, we wait until we are ready to actually hand 
>> over control to the kernel before overwriting any of the IPL data.
>>
>> There is some flexibility with exactly where the calls can be placed, 
>> but the idea is that there should not be any paths that return for retry 
>> on error after we update the cert list.  By placing the update calls 
>> directly before the jump we know the only two outcomes remaining are to 
>> either successfully hand over control and never return, or for the jump 
>> itself to fail, which would be a catastrophic error and necessitate that 
>> the IPL is aborted entirely anyway.  There is no condition such that we 
>> may update the cert list or IIRB and then realize we actually should try 
>> booting from a different device instead.
>>
>> Regards,
>> Jared Rossi
> 
> Thanks for the clarification, Jared.
> 
> I think moving the update_iirb chunk before write_rest_psw() should
> work, as long as it is invoked after committing to the current IPLB and
> does not return for a retry afterward.
> 
> 

Gotcha, I see the "retry" loop now, and why with the changes to reusing
the qipl.ipl_data necessitates moving this code out of run secure.  Had
to look at the greater scope to understand.  Thanks.

How about just move the /* should not return */ to the same line as the
`return -1` line so its placement is more accurate.  Either in this
patch or in patch 20, where zipl_run is refactored (latter is more
preferable).

With that change as well as an update to the comment in
update_cert_list, I'd feel comfortable with:

Reviewed-by: Collin Walling <walling@linux.ibm.com>

No need to change where you placed the chunk of code above. The rest of
my comments are nits.

-- 
Regards,
  Collin

