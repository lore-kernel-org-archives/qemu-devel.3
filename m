Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B40606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nRV25Hqn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cVFZV+8E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZRX-0007tH-ET; Mon, 23 Nov 2026 14:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVZRV-0007ss-Hw
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:11:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVZRT-0000iT-PG
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:11:09 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGnlC1861249
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iJq3OB5B3ew6+MB9F2MgMAj3j3brynZUXmpO8WZqmCQ=; b=nRV25HqnWvS6d4sO
 HBoL85IR1+XAYdL7DlrL4TsWJNxGMmJyFmPis4R5ZmYZFn0u6rFxqZfrFrHCWY2v
 aLjEjUhh3UTOUpd8wx6vLZzfsrPhauyRPmqvg9yLkamN6MFHUt2k72GnLK0Hh5Ql
 b5AlTNZnZvDXHJgrwehH003A2uwgbKt0ZUdDl1ECXNaO2kc9wF62Au754J0vjknQ
 FJrQAhzEoqFg5t2tH5FrBcULJrum5RL3GfxQ2zgiPH1Y5xTScDY94UJM16yJQCXg
 XOXatgx8G7GSZaUAfRpLujFwQVKrjT2Ny897cNsQRzEtO47cf1WYEZ3hGEa641IZ
 hmBApA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g9a30h4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:11:06 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-921052e3e92so71950226d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 11:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795461065; x=1796065865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iJq3OB5B3ew6+MB9F2MgMAj3j3brynZUXmpO8WZqmCQ=;
 b=cVFZV+8Eg5s39gKeyMJ3QgKWOl8NwwSD66LSRVsEhng/oJr2sUQ6EILog/4el7YN5T
 C4KUg7XAs1gXXbJXMAL50hrhYR4A9uo0p66PMsGMoG7dqs1VoZAggbsQLbXk0SVBBgax
 SCMw/lPEX50fYxuTpYTRfiQjqpEcM+8Zl9kgukAwLAiMJxB2pI9Cr2oY3DIuBfLfa5vk
 moZy5j5Mmt/L30lVEANQ5PzTre4uIrjZLTId43JfEx8AHSHx6KQuPYZjwlQneAWF6C6F
 XrhHzN5N+CsBnFVQB7kSdfJtV5RCnfgHCcpFPdXQmICSXKhZdgPUeojdQji47JjDgC0v
 rgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795461065; x=1796065865;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iJq3OB5B3ew6+MB9F2MgMAj3j3brynZUXmpO8WZqmCQ=;
 b=mmysPGBl5w/Nu8n3RtY8zfNIRvlRKBUvxFafjG49O3j0sK7SA+pXqKKLjWoJt9za/7
 oNeX9wXgAnqAIkbmvn+UrsVD2y45l80WS1nNQGT96IPDv8Vf01qAp5Uam3NeMzJsyRqF
 A1oyOVTZxRYXH97BgIL0EyVmsf9j33HAVEP8TrwgzbakMw9d3X/p4U9Cd2QqX4kDv3Tu
 R707DEGlVtiuFira5Bi6UhGo85F+DJgg18I8EjgwbU3hogt3DTbXHW6YWa/TSN8Zyfm5
 HuWtP2TeZS0zIUW5Es/ecslcMmdkFvQO3hMroqLGPJsy+5uM1uuMUxpVyG3YreRyYsxo
 gCyA==
X-Forwarded-Encrypted: i=1;
 AL+hErG9EnAyzWsAagUYacIrADceSU7jl682A/mWvnOEvW7w1OUcWclgaU64364ntLwYaqL3ad84a3B8aG88@nongnu.org
X-Gm-Message-State: APuU4Z9pV1zzE5aay+8bKAo5gf7xDFX663fTYfn4R9L+9jvk53O8IKOt
 sHS3Qt2vNvbumU7zy5YkT3FMjadddDQtQLDu3OoHNOLH8ju6XlGj3v6V0oWinLAACkpn0gsqMfw
 qrt+WwveVjQHozkfQ/LOImNzZ11BjDEA96oXGHCtkm1Y1HwcwKWGwpcI9rQ==
X-Gm-Gg: AZFdTZfZLD+81WJSL4RXofXPxTdF0iq2Y/R3AShvXca2kaxJwkg5hYIOC+KrtsurBwm
 YmI9CNvX3KyR+jErilFbmtZoUVbyKnYI1UB4UL4FDeU8E0B5rGZMWDQk5ifYhIhx4RSvrADXchw
 JcCVqV3aq2yEMgOQuusVihi1aekzyDUqolrMmAHeqAI51v327pGeWuKgymH1lmUCIndrr1Juk8K
 D9QFivu6wpFjYebyDrlWRAWO8MA9T97+4U1T1MHUeLl6LeoKG66TUWvNkHxYMMZZ2QHRdQ5JKjX
 w5LGpNZBLhs7ChrJY0KynXYFRU80ZoT61JOnjm4FSA1ndD75FO3/Ag9WLLuRb7Me6vPiJUgvR85
 CrjZpH7tl1tf9kezIjGiKUnviaIZsQR85RWzh8xBEHtVSLP3yFOT3aOBbbnHiqlId/5NvWK1RFK
 WCyT0FvU9Nex/osHqLe2C0w3mnYloMuuVxbF36gA==
X-Received: by 2002:a05:6214:3a84:b0:921:3171:b604 with SMTP id
 6a1803df08f44-92134b48c88mr209363686d6.54.1795461064954; 
 Mon, 23 Nov 2026 11:11:04 -0800 (PST)
X-Received: by 2002:a05:6214:3a84:b0:921:3171:b604 with SMTP id
 6a1803df08f44-92134b48c88mr209362696d6.54.1795461064264; 
 Mon, 23 Nov 2026 11:11:04 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349d0e35sm112643736d6.20.2026.11.23.11.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 11:11:03 -0800 (PST)
Message-ID: <b8e121de-e8b8-423b-9956-a2a603661a5e@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 13:11:02 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 06/12] target/hexagon: take exceptions for
 cache operations
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-7-brian.cain@oss.qualcomm.com>
 <e2002096-3dcd-48e6-9b3e-4fba96222894@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <e2002096-3dcd-48e6-9b3e-4fba96222894@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3NiBTYWx0ZWRfX3vob5FEakB2h
 h8nuIPuR33ucQJJrQArgt+cZdybjHQ88axaN+XNHgHA4J5QSUwwM2G852wpMF9+8nieXc9dnYbF
 tG56sXgMENRgfaQh+9N9P5STklCDaeU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3NiBTYWx0ZWRfX8LqDWsHS9Xqm
 E/RvwEveu3igDOt0+KjXn4u2G8YI0uD+TQW3nVEQlksULRf/+lgYPJyeN/vHEyCqeWClKlslU+G
 s0Emh1M/5PIBA85Xq6MlhqvocuT3mSGgraillgq0qf+ZmXJybmLB2mxVgaR2LfBDOy3MUVhPWVR
 ZUIDZ9u1GgqlqCwIeqxoO07vqQQePlfZu5PzQb+ZLewtVSP2J5JqwAq6+xi3vphAexjRld3cs3q
 FpB1rq0WHET0HkZWEiaKfF7xps9amcZDRBXoy9yyMzTyBTw3akvb6vB+KQZBvvFJtaDTvVgJYM3
 Jsu+k3wCouhdRYC4pW0XwwCVerp/OLuYaZTwpMMAWO5kfVI8wF/5VZ6MRah7Fy6Yo0e/6pwQkBB
 P7rJtEBkIRJkQ4oV39Vak9TDfTgMQJ3y5RJOkaKbhInrzDe4ERDFp2oLMS5dZJx04lCb1F5JluN
 FwEJFGi1ndm3aWdnasA==
X-Proofpoint-ORIG-GUID: ncJ8OHUuK3I_h8JKeG5RUoz5BxiZC2cF
X-Authority-Analysis: v=2.4 cv=cYJHPXDM c=1 sm=1 tr=0 ts=6b048fca cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SJ7SESo309w2I3wKx_sA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: ncJ8OHUuK3I_h8JKeG5RUoz5BxiZC2cF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 11/23/2026 12:02 PM, Pierrick Bouvier wrote:
> On 11/20/2026 10:20 AM, Brian Cain wrote:
>> The dcinva, dccleaninva, dccleana and icinva instructions did nothing
>> in system mode, but the hardware translates their address.  A data cache
>> operation takes a TLB miss exception if the address is unmapped, and a
>> privilege exception if the mapping can be neither read nor written.  An
>> instruction cache operation only takes the TLB miss exception.
>>
>> Probe the address through the normal TLB fill path, which also reports
>> the packet that faulted.
>>
>> This enables the mmu_cacheops systest.
>>
>> Link: https://lore.kernel.org/qemu-devel/20261117183629.2002840-7-marco.liebel@oss.qualcomm.com/
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/gen_tcg.h                  | 18 +++++++---
>>   target/hexagon/helper.h                   |  2 ++
>>   target/hexagon/op_helper.c                | 42 +++++++++++++++++++++++
>>   tests/functional/hexagon/test_systests.py |  4 +++
>>   4 files changed, 62 insertions(+), 4 deletions(-)
>>
> This looks like new feature more than a bug fix.

Ok - seemed like incomplete buggy behavior from sysemu but I will 
concede that it's more new code so makes sense to re-target this for 12.0.


>
> Regards,
> Pierrick

