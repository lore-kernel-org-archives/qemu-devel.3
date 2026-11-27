Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A3606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WRC8EoPo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JPxDFGyV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzZR-0004rQ-IA; Fri, 27 Nov 2026 12:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWzZQ-0004rI-9O
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:17:12 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWzZO-0002nf-Dg
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:17:11 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFoual2923833
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OytOPGcRZO84huj9xqhWFnRNCu82Ls59YjYzb5PtJJA=; b=WRC8EoPo43nGBNOz
 CkiieTj4NQKjm88mGxrWtYbGy08XIl8ATgVPUPEdm5z+E7WLMHfRYMYyzEFryySC
 uoPGP9Nv5UoDNR1wq+uEINcPOdaKYPb+/RNXVOq/o8xOaU1Uop3aG9eO2Mzc6e+Y
 VL2HUoK7pQUx/mZOOjhypzxgLPaZAVjtW9cNWfUt86wZKyO0CQFYvQGpevE5b70e
 xy3Lh7kiQ3q77aIG/3yaf/4po/txT9iZ0PvhCAtNUnRHIP/QjcGyyGYcXRmIKtIP
 PlKuBkcSYAUj/W2/O5R/lsniADVgMnXIKgfKnU7b9V84xpF3w191ggNvwp73FenM
 8KetSw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhjm26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:17:07 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ecdfb84b68so5373341e0c.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795799825; x=1796404625; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OytOPGcRZO84huj9xqhWFnRNCu82Ls59YjYzb5PtJJA=;
 b=JPxDFGyVmkscWSHm1gez16WL4T3ZaABN8rC/DrSFkfdlAakqs/4x0NQOHBXuCkjTWV
 CMgFkLI4Oi1wi838d3VWDJOM1GcAW2R/ONB2Qwq7NfAyAo6nZTSMBxAM77nrQs/+1EqQ
 HBhPvaJWWuE5dN+/c2sM1UJii9R5wQq31wxyeoLGa4+REMzMn2PbRtt2qcXFGRWsyuHe
 dIJ6CTvHV+7vcysWRbaXSG/xl9G/tC4E+FVoLRQQJhbwmanCwpD087UmwDC/YzWCZWW+
 9FnlsFsrMFsadgVYnWEGu+z1a0L39K8CCpSvuAaQziYadfy8YmrKekz0OOKfkcAbYA28
 yhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795799825; x=1796404625;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OytOPGcRZO84huj9xqhWFnRNCu82Ls59YjYzb5PtJJA=;
 b=2I62wWi4NbDB5umQVu8jp5Z9EroT0esj+C/R4NZB4jxxV7K01MLdE3pIczNg27wzGV
 NWN+dLIB8j1JR0HkMQ+gPwSBVE7055fhkzphzNaWKkIpxBM6xlxiWYffM7JMM0tt3bSR
 KzyEHs92EhN+uQQbxBdOfzpRZPXjemVzFsO2XySq2TYaO1HkE30zCF7pzgFfgzsSga5r
 2V+zraK7Ti6PrXZ0iPJV6+oswTaIVTiPW9sbtLwzDjMfHy5rbks1s0y2BPkqXuJwzq/2
 2kt16hLWU3bKQm4vjAjncQnnkims4XXb7vVZgfNJchk4VMbK9o6zjiwj2ykXZb/4vcc0
 1FOQ==
X-Gm-Message-State: APuU4Z+9qpYxzQJrA60pKUXxxk+5yyLsTDZwp17Ab/gcz1XTqQOX+mdt
 Lx9dujNyk2oDO/4MxXyhBcZwpfdXzUsDF9BzbcBgVbTtRfOZs5lSq5Z2V2Lld+6N8Ac7pkgjgAH
 A+6CHtv2BAKP0CEswEd0reSD8qEaH12OvfjRMaCliielCPA0pVhiTRBeMWA==
X-Gm-Gg: AZFdTZcViFMb9bLt/RT9fEl2gvfiTFKgJj4eOAvphNdUt9jpsE2mz7Do3wreV3BkOsp
 ITFXy4lsX2d6fvEU8rta9gKzzAa9eBhlZ615FJ/yfTPgKQ5ySs7rwg2fP6D110o/XoXAidnqU8r
 xur0TLAnFikp8pj5BNcJRpxOvkunJCnf3oXQZwcwFteXTXrLiGExAgKqxosr2NxUpVQ80VGujzF
 yAvNKxm6p/FO7FsU3QUmzNBztXrVwCnVdKuFgj69C6TBaMtPKIBPCLgbErGFfgVmmjYf1/d2EAi
 4tONlehzdX2W0a0qLa2Sqae1OGW8lHprl3GAnzx9t5HH3TSdTtcmXSfB0BtEP4r/fPwHkvyJs6z
 cKBO9AlQMcwRT6WURf/5D7XfNQyhpcQgJotmI28mC/jVi6g1bxSj6HYEMf6knsframYhJFVS0ba
 5/8UMuYKUwCAjXZA==
X-Received: by 2002:a05:6122:4705:b0:5ea:be49:f93 with SMTP id
 71dfb90a1353d-5ee8272fcb8mr10494319e0c.11.1795799825305; 
 Fri, 27 Nov 2026 09:17:05 -0800 (PST)
X-Received: by 2002:a05:6122:4705:b0:5ea:be49:f93 with SMTP id
 71dfb90a1353d-5ee8272fcb8mr10494285e0c.11.1795799824833; 
 Fri, 27 Nov 2026 09:17:04 -0800 (PST)
Received: from [10.60.206.224] (192.89.66.37.rev.sfr.net. [37.66.89.192])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c51beef91efsm245074466b.14.2026.11.27.09.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:17:04 -0800 (PST)
Message-ID: <a22e29e5-09a7-48f5-8edc-8d3ff54546a7@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:17:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/oslib-posix: Have qemu_get_thread_id return the
 thread id on macOS
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20261126220001.58932-1-philmd@oss.qualcomm.com>
 <awlMhnDkT04Z-AeM@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <awlMhnDkT04Z-AeM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2OCBTYWx0ZWRfX2z2ERatUTMUj
 I8ff61MgwHv48qYYBzl8sgGkmAqzUYVhqD7hGMYi3anu1TzfvN4MuKte4VCVWIgx6ijfN3+UD9e
 kYR3E6k2coecqAgOalzJDj0xL3NJeF4=
X-Proofpoint-ORIG-GUID: sC4GJMTd0H3zDukgRqLYqKNycBsXgBi3
X-Proofpoint-GUID: sC4GJMTd0H3zDukgRqLYqKNycBsXgBi3
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b09bb13 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=2npb9OLYoFXsh95gv5+vWw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Oh8TtzQZdAi_rafBnUAA:9 a=rsE7kRql8lxrh_Yc:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2OCBTYWx0ZWRfX/SRuVq1bK0Ve
 cYGMJZw0B8n9Qlw7Gn4W8sww95izUMhqerzJ2ITjcbuCB6Whr2AZ7ciWycvE0J+D2/aDlLYdKBb
 vPIiBBLWY1xwFj1Sm0MWOmjxa8cSkP78R0ABgXbcnLzMvIuyU/C3zpOlG2TiNv8ujtt6vd8jbvw
 Q9TeNGsWBkVcQ7LAjyYIoBPV2ubirDi3x4FIyCIxr0hq4V6soGKThet231rOC2X9EV/bycE/NRT
 bXJIot1eYHs1CouUHrdTS+6NJulW/9r8UgabgGWOb8KXe4Y/IbGI68I3yoBQMVjpKlrF0L2cxxb
 DHiiidddItiP6X1CzbkL91cwHSFdC+Gq3EWnnYw79FoepQgBtSzl0BcnEcsj/mVZNkOh3fATfky
 rWzGrcwz0jkQx9AL1gMuV33xxeVIfvnmVLl9rZwxIeZJrhOZFtZKYsqgvCQTmh6mRpfnHvTl5cQ
 dupjA4W4LaqMBhjx7Cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270068
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

On 27/11/26 10:25, Daniel P. BerrangÃ© wrote:
> On Thu, Nov 26, 2026 at 11:00:01PM +0100, Philippe Mathieu-Daudé wrote:
>> qemu_get_thread_id() fell back to getpid() on macOS, so
>> every thread, including each vCPU reported by query-cpus-fast,
>> shared the process id. Use pthread_threadid_np(), keeping the
>> value positive.
>>
>> For example running '-M virt -smp 2 -accel tcg,thread=multi',
>> QMP 'query-cpus-fast' returned before:
>>
>>    {"return": [{"thread-id": 58412, "cpu-index": 0, ...},
>>                {"thread-id": 58412, "cpu-index": 1, ...}]}
>>
>> and now:
>>
>>    {"return": [{"thread-id": 75188616, "cpu-index": 0, ...},
>>                {"thread-id": 75188617, "cpu-index": 1, ...}]}
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   util/oslib-posix.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index dc001da66dd4..71fd369e42f1 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -107,6 +107,10 @@ int qemu_get_thread_id(void)
>>       return _lwp_self();
>>   #elif defined(__OpenBSD__)
>>       return getthrid();
>> +#elif defined(__APPLE__)
>> +    uint64_t tid;
>> +    pthread_threadid_np(NULL, &tid);
>> +    return tid & INT_MAX;
>>   #else
> 
> I wonder how likely it is that a thread ID would exceed 'int' ?

IIUC macOS thread ids come from one system-wide 64-bit counter that
started at boot, and it never reuses a value. A long-running host that
creates many threads could get there. Going past INT_MAX is possible
but still rare.


> IOW, do  we need to consider changing return type to uint64_t

Yeah I think so. The good news, QAPI thread-id is 'int', which is
int64 on the wire, so QMP needs no change.
Widening to int64_t is a separate cleanup across those structs, and
the mask is enough for now.

> 
>>       return getpid();
> 
> Separately, it is probably worth also adding
> 
>     warn_report_once("No qemu_get_thread_id() impl on this platform")
> 
> so that we nag people to fix remaining platform gaps they
> might care about.

OK.

> 
> With regards,
> Daniel


