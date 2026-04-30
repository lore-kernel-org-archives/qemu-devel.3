Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F843CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVBU-0006b4-4n; Thu, 30 Apr 2026 13:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIVBO-0006Kp-0G
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:28:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIVBL-0006Dc-Gw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:28:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UFN26E2941670
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 17:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yoNygasC9LjDWqdRHBUJ1NtfRqsJp5lAdI/QnXT327w=; b=pbIoKAm9BmFyYbvP
 TfpreUNpVwXUA73a1TMPfKFRiukQKSLBRiNbzu/e4qdLf8uulwaYYX9rK5LLWxwc
 7TfDdGsfr8PTlSs9V2wzGw8wdj5cCSO+/L4BPK/yXLDlybdIfP1eGt3iatdk8kk6
 M52iWT0OalTyrW5TcAAS8qXNVe/UQztQ1EvtBGf/ubh+AckYyxpuY/CSJBHPxs7Q
 KwpKT1bUK9ds00x8mDqE7d9f9eoKjhJIUPDOYvxOiqL3+t7uVA2R7jdKxn8W6ki1
 5WRNUeigEIEltwg1U4u9J+2F4Xx03aY0OACaj2Kxc2P+XFfzVABK6dO0xheqXG0j
 TbOVuw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr43aw6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 17:28:09 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dece274b1so1340338c88.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777570089; x=1778174889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yoNygasC9LjDWqdRHBUJ1NtfRqsJp5lAdI/QnXT327w=;
 b=h7iXhFXFldmNOhws/19tNesUg9HVDwKw+hP2CfsTWmM0i+FU304RNgYSvECDF3ULnX
 QeZqObOV60Mu+q9yF7A/GipK/wVXMrt8dp2+AHPT1fuIlaAJ34nurs2MJUPD3WljdjS7
 EdyOoPvyCro2Bw7FD8HVxf1SJTIY87BQ/D2GopXIX/4Ze2exmrF6JCAgcrPGa4ulQU6F
 fBWy7ou2Ypn1Ikkg0eBhseleg+hNCjEsVWCeMP36gzaDNB2bs8E3LO8PuPHmgezHzU5s
 z9YUroN6q7cTO2/i3EJYXM6O/WMeujDP15h1iMWTF7CnIs11T2Ds7wbP7FZnLyb5Yafx
 MVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777570089; x=1778174889;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yoNygasC9LjDWqdRHBUJ1NtfRqsJp5lAdI/QnXT327w=;
 b=Crprvph+z9xuhtVAkvtkMMS1VaPZUIl3fkafQFKeEg+0gindo18vpLtUfZKNNruOv3
 Szpq6c+67fvTYcPu7gYHZ9Ta40yMnpStr9dM9+JpYCcG5hSZ/gxtZJfrmgqZFAIFLIEu
 +6alQ84ONMZeHjcnlXJJpFi1KdfVYAuCTOKQWCbn2v73B3iefG52aPl+0F9mH/63pKvs
 AtEfJ5yInJ1kHGlYWxUDg8FIvsEDEicZBPkas+Uv8z281uywPjWFfQw93KUD6IUCKvLQ
 qc6vPEk/hGtS/2sdwmSROkxt7Y+eC2pgx2/X5+wNSUeAYibMNYkKAJScg57fFSV8j8sd
 iTYg==
X-Gm-Message-State: AOJu0Ywex/L8RKMaUNDCs2wIjKn+geV1uD231z/1MmOjXwvi0+Dwqw5o
 xVrvPEipTlXBs1ucbAWc059Svt4zGf+cUzZnjOGcNAWtgPHCoOzrhpwKYuRc7MQBHKuSDjFZa4Z
 aMHygclHaYhMOp/Ekn4ffGRhyCVi1YeKnalvx241kJeOMmnYFtYXxQZcPGw==
X-Gm-Gg: AeBDiet+AD7S6ckqwvcyuIwh30EasrQh3DmduWHk3UO9kpYVGhSEcVyqhXY0BiIMAd/
 xjoEzWU/zTPfyGNUl8LomHKGxmknhVq2a7m5H4cHHMcBZQbXxErYvfPux5c+rebGE9Vh7je2rjY
 kNYs+5g22KaTnWxIY/+WyjaehU3a9v+1Acsu00u8P2r41KlldoVKNlhGfnbILsbbp9cOHEZ9YIO
 klblCmYFVfrE9dDmQ6qGp+9Nqu71jYqKZTs5r8xuHawiZbS3hwUxalLt7tth5UlIWtXaWs+1Sh2
 5zRHhp4uYeI3LTBIj8scCsu7PCTS1YddNLUWSW3+I0zdUy6T7XuKpgT4YUwhUXZKVxU/9ZsJvQN
 3DpuH68/EL+NZWS9+LUbQ9KkPpQVAVPGKKMuetaZ2AKVerM+zTFsqpfbjX6XeVlML4nhZzOgOwe
 NXvMUCMG7vvTbEyAfE0ektZwR5
X-Received: by 2002:a05:7022:1a85:b0:128:d752:e074 with SMTP id
 a92af1059eb24-12deac47e83mr1744801c88.1.1777570088661; 
 Thu, 30 Apr 2026 10:28:08 -0700 (PDT)
X-Received: by 2002:a05:7022:1a85:b0:128:d752:e074 with SMTP id
 a92af1059eb24-12deac47e83mr1744769c88.1.1777570087947; 
 Thu, 30 Apr 2026 10:28:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de3216e81sm11192808c88.4.2026.04.30.10.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 10:28:07 -0700 (PDT)
Message-ID: <727834b3-b4be-47b4-a14b-22473118dcca@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 10:28:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] qom/object: register OBJECT and INTERFACE QOM
 types before main
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430035626.3511676-4-pierrick.bouvier@oss.qualcomm.com>
 <afMA8SCcF9XJ8VUe@redhat.com>
 <d95d58da-764d-4967-ae93-2cb7418d8c5d@oss.qualcomm.com>
 <afOMOcbpEnjzfyj6@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <afOMOcbpEnjzfyj6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f39129 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=AlKH_gnXchsMo-B4ZccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE4MCBTYWx0ZWRfXxD26u7HaDfoN
 lQh38mp5/v4WV7zuvkW5netIRkOMGEqvzoSLYpXjzVX0Tnjt3JmIPFk1qlBG5DvLv4AY3CuU8HP
 AXQbQ4fu5ilhrdmGhwCEG3LsBTG7X82EtzRGJOoG0HVLguKfwNB3nxe0TZRTIIWTGPQiJloR6sA
 DlWraXrVJv+0T0DpDDqTsJmiDQ5KP6x5i1O3bEPUc+7zQazGMn3RqybUCjhinJsZOre2S49TEAc
 6BtS1rOTk3QU/i0cAooTcWsQUqcwGhXoUDHas4I6Jy98y6eZn5/8ENt86E1zeT8b/1q0vHROdkg
 Q68sXS1ulmz2UmeYVSofXoUwiTd4fZxEmrzpLur6PKuB80v/3XJAtoV/rnl6eRy/glIz6h4Ufwj
 zqzPpfSgkwALmJ0Zg5tyBtPcKd3FpvAzKXqV63pdUocVHQQYligZ194dsu3y2Z3HPI3joF2d6Le
 xvmJON3aKyf+hVJdtew==
X-Proofpoint-GUID: HEf4e2FSAGWFhe01x_r6hWlOFjlsTJr6
X-Proofpoint-ORIG-GUID: HEf4e2FSAGWFhe01x_r6hWlOFjlsTJr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300180
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/30/2026 10:07 AM, Daniel P. Berrangé wrote:
> On Thu, Apr 30, 2026 at 09:03:52AM -0700, Pierrick Bouvier wrote:
>> On 4/30/2026 12:12 AM, Daniel P. Berrangé wrote:
>>> On Wed, Apr 29, 2026 at 08:56:22PM -0700, Pierrick Bouvier wrote:
>>>> Those types are special, as they are the base of all other QOM types. In
>>>> next commit, we'll introduce an extra step in module initialization for
>>>> target-info-* types.
>>>>
>>>> However, those types depend on TYPE_OBJECT, which is only registered
>>>> at MODULE_INIT_QOM step.
>>>>
>>>> To avoid having to introduce another step, and modify all code calling
>>>> module_call_init(MODULE_INIT_QOM), we simply register those base types
>>>> directly in the static constructor, before anything else.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>  qom/object.c | 4 +---
>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/qom/object.c b/qom/object.c
>>>> index f981e270440..a5d268d0722 100644
>>>> --- a/qom/object.c
>>>> +++ b/qom/object.c
>>>> @@ -2839,7 +2839,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
>>>>                                    NULL);
>>>>  }
>>>>  
>>>> -static void register_types(void)
>>>> +static void __attribute__((constructor)) register_types(void)
>>>>  {
>>>>      static const TypeInfo interface_info = {
>>>>          .name = TYPE_INTERFACE,
>>>> @@ -2857,5 +2857,3 @@ static void register_types(void)
>>>>      type_interface = type_register_internal(&interface_info);
>>>>      type_register_internal(&object_info);
>>>>  }
>>>> -
>>>> -type_init(register_types)
>>>
>>> IMHO this should have been done using the MODULE_INIT_QOM_EARLY
>>> approach that I suggested on v1, rather than special casing both
>>> the base classes and MODULE_INIT_TARGET_INFO
>>>
>>
>> I'm ok to follow your approach if you really prefer it.
>> However, can you specify what should be the semantic to put in comment
>> for it? I have trouble finding to explain what is early vs non early,
>> while it's clear for me what is TARGET_INFO vs REST_OF_QOM.
> 
> I don't think we need to set our strong rules. It is just an early
> startup hook to be used by classes which are a dependency of other
> initialization code.  Conceptually this is similar to what we did
> in system/vl.c, where we have various stages for creating -object
> args. What goes in each stage is simply determined by a functional
> need at the point in time.
>

Ok!

>> As well, adding a INIT_QOM_EARLY implies we need to call it in all
>> locations where we already call INIT_QOM for future-proofing, which
>> seems very redundant. Should we had it or not?
> 
> Yep, that's true, but not the end of the world imho.
>

I'll go this route then, and initialize TYPE_OBJECT and TYPE_INTERFACE
in QOM_INIT_EARLY step along with target info.

> Ultimately an solution is a bit of a hack. Long term what we need
> to do is follow glib's approach from GType and have "just in time"
> initialization on first use which will make everything "just work"
> without having to think about ordering. I didn't want to suggest
> that now though, as it has potential to be a can of worms.
> 

This is kind of what we do already. First time we access a type, it's
initialized. The only thing done statically is registering types, which
does not trigger anything except adding them to the global type table.

The current issue is more a dependency issue between target-info VS
other types, which is why I thought Marc-André suggestion was better
than a generic QOM_INIT_EARLY. But I don't mind following this approach,
my goal is just to have something that works for our need.

Regards,
Pierrick


