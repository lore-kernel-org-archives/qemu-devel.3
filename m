Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB11606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YJwqSaDm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=blnN8M73
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnH4-0001UI-3N; Tue, 24 Nov 2026 04:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnH1-0001Tm-EN
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:15 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnGz-0007dX-J2
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:15 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8KjEu4128835
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 09:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VD2svOiIUx/gKVqHTVydZr+gxI47g55xk0ZUqcBPUWs=; b=YJwqSaDmLJTLEW55
 bnj/M6dRTCwqBqNlg0Gcciw65hbuMeoHZ8Huw95AdFwaY2k25n983jBCE2BxdvIF
 PuVLxx/dnI6blST3FcL97XGnNOjGliVfY/bdboOUX5WeqsgRlSZct3g35dIQkvmN
 uIgY5hw6dSNc9y70Vdoo+y3a2si9koWlsHrW/dKs67wb8ZF7mtKJ2yiz+Wf0BKoS
 EjIDGg6v1B6SIFEfEsYa8tSfoTApI1rNWtX4oVCy6Le9xYUin7089OhGWO0qyTyM
 HjRdTeV7Pd963TAmGLz21v1Ze7E3Pv2fmnx6/foVYBXGerx9ZYIIUHxseaNuwWFD
 uhSyMQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yyt22ak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 09:57:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9493e89d4f9so637317985a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 01:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795514230; x=1796119030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VD2svOiIUx/gKVqHTVydZr+gxI47g55xk0ZUqcBPUWs=;
 b=blnN8M736s8vDwyhLQGycYTXp5U7KBkpalopoMm6fJj7Pny77JjiRo4qPEaS38WV/e
 x5ACyJUaXeVty8axRDJclwl0qu2w+lwKvwVsNcslP3eTrjA5//9VkJQLgcD441r9d2EQ
 zK9WGYpXcGwWIsZsIhadwtWXIITtUa4EPuzMBeAwSHzXRQ0qZyJjJ0c4XCUGpyOiQClS
 nKAVFuF9r49wr7c3cPt0PnfzSowJ6ukoyXEQlh9nCeR1ldBzb215gnCBO0FnlZvjzVRh
 6Y5D7TA2ADlRIHYheBnHg2+7+9zY4sz4PSlSosEMcpDqmBq70YIwBKy+F9vW08fT2G87
 6vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514230; x=1796119030;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VD2svOiIUx/gKVqHTVydZr+gxI47g55xk0ZUqcBPUWs=;
 b=SGK7HphqACqxqRWvS7dU3RF3IqteZWzQpikWMjWSwExQOas3U18Qa1aq+fZeczsa9Q
 OcsReddtr5yh/B9SmRqE1on1gDeU9MlQ4xRauYOJ7ZcvCrOPYCQbYt4ImY60ottty+6h
 8HScGFNbrfJiLInW1zdZ34EDW9WdrdTDkUlfyvWLwcpTtWj4uukupPTliuXVOYJvnwpm
 QoVz5j4XxJqDgOctKK6SEqGBne99HgtThW+2Psy3HN7TwXZ5zwQPM4n4+hAovkBwh28b
 Sqzjt3WsQ2Ty8I9pETmjCVtpjF7mlSrt7OMXs/TTYd22x85QvY6iVpeDv2rhoi+gx/RF
 EYeA==
X-Forwarded-Encrypted: i=1;
 AL+hErFi56+gbFsdO847RJJ1Tt67rJqqFVm4Vu+C0VdrW2q81+gNVcX8WLyH/epnN6O0ZjHH6MUWGLhKwz7h@nongnu.org
X-Gm-Message-State: APuU4Z+hw94Xa6xNn3YdnPocyh161CcqSNogXEdf4NmzeD/+210Rk7Ln
 aiSIE3egn5AKtOiYW0x1rtXlgudE313tv8u+1g6DnOMKxuofyKWJXgMTmRDS/IjGLMp75B8A+MG
 wXQQd6NbbZlzgXoT09EvwdhKH067bIRvL7c9aAPMn73MaqoQxkpwxRHJGu0q7fFXJNzMV
X-Gm-Gg: AZFdTZeAQQ1TlRrNeXiRhHncwIMm8rgKDSo00ZWzZ2B5HHJnqshwQEx9dwTqOc4D+T/
 l0boSzGJvT92PL+z+G3KpSUqB01rKZadPPLhmIzsrmUKNhZVd7rXVc4dU1YPOTPvUTZv3pAgj66
 dcDtnMFkYriNFptQHm0fDc0t4gIJnzrA1Nb2bA0mViKCwOvGLjIcsrH4+R3dT43QVh1kCdxaEza
 +5k/xiZfrj8HlhKKaUKzeyed6r4qHXA1vWsfh2CX8MRV1xT5cMDxDre/7A073rONO5ex300uzL3
 GnmFOJLasM7rUA5E7k698fI+ta1vpSv7SrLhmXYneu5DN9JP4iKEhcsJ19yJWScbz/IjrkBKJRq
 rBXx118SQX0O/sYrk03oHeQMyVJIXlR8b7QaGhCgrROx+eGSHPr+xSRavve5iFu8SLFEcFDLyFi
 k9rhUXjtc=
X-Received: by 2002:a05:620a:460d:b0:947:90cc:f151 with SMTP id
 af79cd13be357-949ba81a582mr2328329085a.7.1795514230448; 
 Tue, 24 Nov 2026 01:57:10 -0800 (PST)
X-Received: by 2002:a05:620a:460d:b0:947:90cc:f151 with SMTP id
 af79cd13be357-949ba81a582mr2328327085a.7.1795514230007; 
 Tue, 24 Nov 2026 01:57:10 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa397asm27784349f8f.48.2026.11.24.01.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 01:57:09 -0800 (PST)
Message-ID: <d9137705-39f0-4a72-bafc-ea483183cecf@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 10:57:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: fix abort when a rate-limited event races with
 its timer
Content-Language: en-US
To: Markus Armbruster <armbru@pond.sub.org>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-stable@nongnu.org
References: <20261123212957.242482-1-den@openvz.org>
 <dec9aea7-8fc9-419b-8178-8e61917f02e2@oss.qualcomm.com>
 <87o6be4o8f.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <87o6be4o8f.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzOCBTYWx0ZWRfX3iOnDEvSlZbr
 ZfChBLW478cmtHqfKc1LpJ3aD4aAQbWP8PVhT7TujI1APGX1rQOmmRDO9i/1VqGi5FDoCk1aBkj
 0G2q7Sf11aCqyyTZB+pk2Ijj8rxAcaQ=
X-Proofpoint-GUID: A4_ajKU1uJnr4uMA-djtdbHBRN8SxO92
X-Proofpoint-ORIG-GUID: A4_ajKU1uJnr4uMA-djtdbHBRN8SxO92
X-Authority-Analysis: v=2.4 cv=W9OtxhWk c=1 sm=1 tr=0 ts=6b055f77 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=3WJfbomfAAAA:8
 a=69wJf7TsAAAA:8 a=0XwWD_aOQ1QaGFxQu2AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Hx1yvPaMooE3kwe23bt7:22 a=1cNuO-ABBywtgFSQhe9S:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzOCBTYWx0ZWRfXyPP4JQEFnGyV
 0cUziI/VEy3ZUqmajzO4c1aM+tAnU/pz5mWZtdiik78BM9wz7Q2zjO9VMRltyK9tKgNNBFE1JiD
 R5boFVD1mT6KN0ybmAaoewDtLFRFRbL3rqH6AWxIzvNH1/0myEK8ENjaabvj4b45RgtQeOU8ZXM
 y1fflFSjgGo55LB32mtSiMKM/Y/9pZOzZQ9VySNlyr+JS9L55JObC5pSK/eexOspzQBeqPA0Fek
 Vo92xJZgmAigk6+ZrU4raK6AoF8thmW7zUyAPtrGMUVLctBDve/t0nfX9RsCXdJXjjfwQdAoyzX
 SEntJ4OSpRolSy8EY8QXKEVH0ycYfIE1bk7foZbupXzYrZIOlRtOPKJcxT7VTJWIbk7UYNQNiIf
 HPbFjD5h3PRaLfWZ2WxtJ3RQdq/5AjVADd43ulONQmRkVBCxYWF8JESRZXITr7RMkamK4K5jYBp
 +RCYXTg81TDE0wLz/gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/26 09:39, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
> 
>> On 23/11/26 22:29, Denis V. Lunev wrote:
>>> From: Denis V. Lunev <den@openvz.org>
>>> Rate-limited events can be raised from iothreads, outside the BQL.
>>> QUORUM_REPORT_BAD always could be. Since 2155d2dd7f73 BLOCK_IO_ERROR is
>>> rate limited too, and any disk on an iothread raises it.
>>> The rate-limit timer runs in the main loop. timerlist_run_timers()
>>> takes it off the active list before it calls the handler, and only then
>>> does the handler take monitor_lock. An iothread raising the same event
>>> for the same device in between finds the rate-limit entry with a timer
>>> that is no longer pending, and QEMU aborts with:
>>>     Assertion `!evstate || timer_pending(evstate->timer)' failed.
>>> This hits virtio-blk on an iothread with an error policy other than
>>> stop when the storage goes away and every guest request fails.
>>> The state is fine, the assert is wrong. Once the timer has fired, the
>>> handler is committed to run: it takes the lock as soon as the iothread
>>> drops it, sends the stored event and re-arms the timer, exactly as for
>>> an event stored while the timer was pending. The event goes out at the
>>> same moment it would have had the iothread come in after the handler.
>>> The entry is only created, re-armed and freed under monitor_lock, so it
>>> cannot go away under the iothread. Drop the assert.
>>> Fixes: a24712af5425 ("monitor: Turn monitor_qapi_event_state[] into a hash table")
>>> Fixes: 2155d2dd7f73 ("block-backend: per-device throttling of BLOCK_IO_ERROR reports")
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Cc: Dr. David Alan Gilbert <dave@treblig.org>
>>> Cc: qemu-stable@nongnu.org
>>> ---
>>>    monitor/monitor.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>>> index 2654b81890..22c00b6195 100644
>>> --- a/monitor/monitor.c
>>> +++ b/monitor/monitor.c
>>> @@ -360,13 +360,14 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
>>>           MonitorQAPIEventState key = { .event = event, .data = data };
>>>
>>>           evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
>>> -        assert(!evstate || timer_pending(evstate->timer));
>>>
>>>           if (evstate) {
>>>               /*
>>>                * Timer is pending for (at least) evconf->rate ns after
>>> -             * last send.  Store event for sending when timer fires,
>>> -             * replacing a prior stored event if any.
>>> +             * last send, or it has expired and its handler has not
>>> +             * taken monitor_lock yet. Either way the handler will
>>> +             * send what is stored here. Store event for sending
>>> +             * then, replacing a prior stored event if any.
>>
>> How about:
>>
>>   +             * last send, or its handler has not taken monitor_lock
>>   +             * yet (the timer may have fired, or not been armed yet).
>>   +             * Either way the handler will send what is stored here.
>>   +             * Store event for sending then, replacing a prior stored
>>   +             * event if any.
>>
>> ?
> 
> I find this version harder to understand.  What scenario exactly is
> missing from Denis's version?  And is it important here?

The issue Denis fixed also exists in the gap before the first
timer_mod_ns() under monitor_lock and between timer_mod_ns() calls
after later sends, now described as "or has not been armed yet":

"the timer has fired [, or has not been armed yet], and its handler has 
not taken monitor_lock."

> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>
>>>                 */
>>>                qobject_unref(evstate->qdict);
>>>                evstate->qdict = qobject_ref(qdict);
>>> base-commit: 8f66cb79044c370e3813c56ceb7a75a5ca2d0a0e
> 


