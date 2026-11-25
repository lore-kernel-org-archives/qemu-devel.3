Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E44606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NjHrNyuK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Utx9A9IC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWGQT-0000Zl-F7; Wed, 25 Nov 2026 12:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWGQ8-0000SJ-4M
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:04:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWGQ4-0005Ss-0N
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:04:35 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APGQ8cF817604
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 17:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cMEDwW6GUi1EyHQxzcXllYycsha8CGandgZDybd+UHo=; b=NjHrNyuKTWgcJb6D
 gf3VlOobtBeL6axiA+bMIdIlJ+iuo05evvio7+O7Mfo48HzhcYVaS/F50q/VAF0F
 rfiC4P2TulRn6mYzlj6x1ceH9o0ZV8KKFsYeR5Dg0DT/NRZ1JxdxHNuNiH5Q56/S
 +yJv6myOy7GWSk5D8Go93NEVcP2b807Zl1gSzpNaWa10Sic3zhvqySCAtYPyvSzH
 BPtcplrG7vNCMyeIedujcj3xvbOVqFxNsvMcigM5JTguGRnYeFuJYR0vz6lQySqz
 HDGOHUuk5HAjJDJVCR1imAhryrElYO0053Nv14CEK0tSoRj+sclEtu3L0RDUW6aw
 +4+gPA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhsyg9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 17:04:28 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-836caf085e0so79100497b3.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795626268; x=1796231068; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cMEDwW6GUi1EyHQxzcXllYycsha8CGandgZDybd+UHo=;
 b=Utx9A9IC1n5HUcQ+h+ibpXeJ2APMM1KfF1je+qOqXIfqrz06DD2epv4yyxgPmS0V3h
 NVm9eBY9Zk0XzCvwZVF6LbwWCj+IY/rrf3E16svhCWhbBraNp9+PwsZyaFvefvywXPql
 oQJ3KAMGxtNyNRpi0xkqnjV7tXl8SOv2QHVmd0fxWJyIJHcrZ6tFddfx9xO1gyurqLJG
 ESyMvBEwRp/oLU5mSuYu63EGMN2juPpf7BW4x1KzeqrCww88ZSWVwi9sgMqaATXle4BH
 n+3DIiOzC6t6GSLiT3K0X4L8xQsAC5fInODryoak/utcCm/HznCbSnUbCo27TInmkZGe
 HwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795626268; x=1796231068;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cMEDwW6GUi1EyHQxzcXllYycsha8CGandgZDybd+UHo=;
 b=Pvd1iXv5hzGbgMdnOniX/Wgco4ZTiWwwsax1ype2z7acUWuccxikaKhKnxARV1SaKv
 Mznm8futhBPgZhxKgoaqkJYOQYxVGOICwwfaWciRWpnYfU841Xf2yLqUvMQwnD3Qusk4
 Wnt8YfESSM+iPPAys5SdNXsImRHrzY4M2AUNMrJ/nvCE1mf6vkiWVeY0q0weY+BK6d6u
 uYYaCa6DKMjAehonFABg1YgjSf2x2STMmW0Aj8dCu5ogeCnDKbinLvRFdWGmQsynWDoQ
 h4+IXpWVKhsYdCOTk+m0iC6vELYASoce/1lEvJ4SGXnll8r/BkUpMT8dPjKehxgSJdTe
 aDCw==
X-Forwarded-Encrypted: i=1;
 AL+hErHDZDTQrYHtSJ2Z1ycCRuH12x+dP0bFpSIldKvnulX+osC0QDL87VLcSJ0PrNuAjuFR50WBvbeiA+oG@nongnu.org
X-Gm-Message-State: APuU4Z/k6cnS+gjKS0GmM4AEKNxKNwwg3O9Mmo5B8lArGZkNHfHeyRvL
 QOSVQVy4r15Dkp3LvA8+qzO2T4nWIJrTRb+qG8BhEpSFF255ucrej0CXjx6OrW8lBlfZn/Jqzov
 NNctpBo2jQPc5eIAd3qeleD7bKdcobWKgNVjFVno7ffJfwLVMiNOcA5ob2g==
X-Gm-Gg: AZFdTZeeXA8TPgB9jq1EkZzWYoedFpl8Qx59dLLXoekxvBwoj1gXqFuWxnJKSML9Hzx
 iWOgqkUscCrV9Zq+BaE/tqbcbb4oMILV2it8drB36uBlSdpJQ+vVa6FAKeg1Zw/qkULtP1EVgeu
 96+HJkD+r1aPjBVYYdyoMFOGe8chzyrVSP+rLtP6OJ1XloOy4ox0B52Ci2zLjMnOong3FIb3Lc0
 NGmUr0fq7Eb+QpCure/OLvjljrYHwVuYhGzIa0OQnNBCJTMRMtM0efhT7m0htKqQmIWEQ6EbP7j
 J4e6bsKqA2YpFT6NMP4c83bz3VKA+8gwZ+pqIV3+bmuN7SDXwmYpAfHtWjTmFXW6C1qcWXAZ+qJ
 XDcMDGEDBEg34CVbPe2c7WLoAa6WipcrUV3FoBa0V3dzKipPKCrL8zGa3dKMqNb/Bey9oMbcEa+
 +Aht/xiUY=
X-Received: by 2002:a05:690c:e255:10b0:8b5:6584:ae8e with SMTP id
 00721157ae682-8b56584b1a7mr15387127b3.6.1795626268419; 
 Wed, 25 Nov 2026 09:04:28 -0800 (PST)
X-Received: by 2002:a05:690c:e255:10b0:8b5:6584:ae8e with SMTP id
 00721157ae682-8b56584b1a7mr15386907b3.6.1795626267849; 
 Wed, 25 Nov 2026 09:04:27 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61e53asm37483023f8f.59.2026.11.25.09.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 09:04:27 -0800 (PST)
Message-ID: <b1190b25-f3a6-4c2c-afa6-e44041d5eef5@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 18:04:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: fix abort when a rate-limited event races with
 its timer
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>,
 Markus Armbruster <armbru@pond.sub.org>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-stable@nongnu.org
References: <20261123212957.242482-1-den@openvz.org>
 <dec9aea7-8fc9-419b-8178-8e61917f02e2@oss.qualcomm.com>
 <87o6be4o8f.fsf@pond.sub.org>
 <d9137705-39f0-4a72-bafc-ea483183cecf@oss.qualcomm.com>
 <5b13cf6f-0222-4029-96de-0464299f6bab@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <5b13cf6f-0222-4029-96de-0464299f6bab@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b07151c cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=3WJfbomfAAAA:8
 a=69wJf7TsAAAA:8 a=G6Hd_34uCP4GvlyY85kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=Hx1yvPaMooE3kwe23bt7:22 a=1cNuO-ABBywtgFSQhe9S:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: MOXhKiZazFl3l4P1DnfsGFkmFNnrHqER
X-Proofpoint-ORIG-GUID: MOXhKiZazFl3l4P1DnfsGFkmFNnrHqER
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2NyBTYWx0ZWRfX2OulwGnm+8Uw
 1xFfpWTVXYAU9k3MRihx8KA8Oe010FNtSkAL4zbRmypjhFu6CMNnd308deCtG2TUa88eok8sOuC
 yFgA1MMRy66ZKCFRGjBKeEla2uPc1rE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2NyBTYWx0ZWRfX4kw9ZpsuB3+I
 yi7RK2m6ouvJyR4DPPPLdvEG8t/TwLXfssKxGoP/cu9oebqwFkij2KIM9FSa3HcLdpJNinTwy+n
 xDIRaYzb1lHswYeKD90dlQkLl4DRkPN43KugtCMF4QzEREDLppXuJ6idXpNQAjtd9hCOLUfMdJa
 Es4S7IepcuP5HpchOi34Blj/4r1ZQZc2cQWsc3XdrufnhSc+JF9oRxwL+lCTZegetWzBJbU1ES7
 8Zz5rcX9roHg6/+p9XEeLb3pPHVp6ViznXXSKxVprzd6CjjuQ4Im5bjtW6ys+Afd/zrgLTgSDsR
 MWFgrDlu+d50CnWv5cRV0lhTrIfKeAL/A5yFTh83w0FnHUGImP2YuQe/bMp8GpP6/17pWR3iq5e
 zJm7f/oMr+7zNi8X4T2xushWrJdORxJ6d/OI1bGPTTMy11xZ07xkUcQ3kdeTOWZ/CaEjfXwF2rl
 ptbxiiqhZMQMh4GQQ1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250067
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 25/11/26 17:58, Denis V. Lunev wrote:
> On 11/24/26 10:57, Philippe Mathieu-Daudé wrote:
>> On 24/11/26 09:39, Markus Armbruster wrote:
>>> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
>>>
>>>> On 23/11/26 22:29, Denis V. Lunev wrote:
>>>>> From: Denis V. Lunev <den@openvz.org>
>>>>> Rate-limited events can be raised from iothreads, outside the BQL.
>>>>> QUORUM_REPORT_BAD always could be. Since 2155d2dd7f73 BLOCK_IO_ERROR is
>>>>> rate limited too, and any disk on an iothread raises it.
>>>>> The rate-limit timer runs in the main loop. timerlist_run_timers()
>>>>> takes it off the active list before it calls the handler, and only then
>>>>> does the handler take monitor_lock. An iothread raising the same event
>>>>> for the same device in between finds the rate-limit entry with a timer
>>>>> that is no longer pending, and QEMU aborts with:
>>>>>      Assertion `!evstate || timer_pending(evstate->timer)' failed.
>>>>> This hits virtio-blk on an iothread with an error policy other than
>>>>> stop when the storage goes away and every guest request fails.
>>>>> The state is fine, the assert is wrong. Once the timer has fired, the
>>>>> handler is committed to run: it takes the lock as soon as the iothread
>>>>> drops it, sends the stored event and re-arms the timer, exactly as for
>>>>> an event stored while the timer was pending. The event goes out at the
>>>>> same moment it would have had the iothread come in after the handler.
>>>>> The entry is only created, re-armed and freed under monitor_lock, so it
>>>>> cannot go away under the iothread. Drop the assert.
>>>>> Fixes: a24712af5425 ("monitor: Turn monitor_qapi_event_state[] into a hash table")
>>>>> Fixes: 2155d2dd7f73 ("block-backend: per-device throttling of BLOCK_IO_ERROR reports")
>>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>> Cc: Dr. David Alan Gilbert <dave@treblig.org>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> ---
>>>>>     monitor/monitor.c | 7 ++++---
>>>>>     1 file changed, 4 insertions(+), 3 deletions(-)
>>>>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>>>>> index 2654b81890..22c00b6195 100644
>>>>> --- a/monitor/monitor.c
>>>>> +++ b/monitor/monitor.c
>>>>> @@ -360,13 +360,14 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
>>>>>            MonitorQAPIEventState key = { .event = event, .data = data };
>>>>>
>>>>>            evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
>>>>> -        assert(!evstate || timer_pending(evstate->timer));
>>>>>
>>>>>            if (evstate) {
>>>>>                /*
>>>>>                 * Timer is pending for (at least) evconf->rate ns after
>>>>> -             * last send.  Store event for sending when timer fires,
>>>>> -             * replacing a prior stored event if any.
>>>>> +             * last send, or it has expired and its handler has not
>>>>> +             * taken monitor_lock yet. Either way the handler will
>>>>> +             * send what is stored here. Store event for sending
>>>>> +             * then, replacing a prior stored event if any.
>>>> How about:
>>>>
>>>>    +             * last send, or its handler has not taken monitor_lock
>>>>    +             * yet (the timer may have fired, or not been armed yet).
>>>>    +             * Either way the handler will send what is stored here.
>>>>    +             * Store event for sending then, replacing a prior stored
>>>>    +             * event if any.
>>>>
>>>> ?
>>> I find this version harder to understand.  What scenario exactly is
>>> missing from Denis's version?  And is it important here?
>> The issue Denis fixed also exists in the gap before the first
>> timer_mod_ns() under monitor_lock and between timer_mod_ns() calls
>> after later sends, now described as "or has not been armed yet":
>>
>> "the timer has fired [, or has not been armed yet], and its handler has
>> not taken monitor_lock."
> We hold monitor_lock from the hash insertion through the first
> timer_mod_ns(), so another thread can't see the entry before the timer is
> armed. The handler holds the same lock while it sends the event and rearms
> the timer.
> 
> Another thread can see the entry with the timer no longer pending only after
> the timer fires and before the handler takes monitor_lock. I'd keep the
> posted wording.

Fine by me.

