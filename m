Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B83CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPZe-0000Jh-8b; Thu, 15 Oct 2026 13:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPZc-0000JQ-Nu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:49:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPZb-0007k6-18
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:49:00 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFDPba4126286
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sQZFKfVBjEeacFkdSGAZaT5LOyHECxVP58lQbJLCTHc=; b=fwjlNG8LLm1QW7Im
 s1OIKSmoqynC9Y1qB732NxOEECgiBcJXR61+hVVsulCodFQsB6h9p9czU42SC/MC
 cUAD/D2kN1b5VMRRGzj+3gT0Sf7wOV381wYc7tVMgL80lmPL0IIvZhlVIp/hbI9A
 GN9ZnUA1peQaYRFbRq09Np0qhuEPz3oKhrrdfNaUl8xKVhI9POBUqiqjfTtoeLHx
 38KySLc36jcB3KU1vCd47UGXOR9PChUup9M8XZhRm1jrlsBUiy0u1nfI48BKUqUd
 b2iKYBX35+dWMbagwCeB5AaTLpsK0RlGsn390XsE5VmQAZ7r+ytVQ7Bsc4jiUOC+
 gUDswQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m0mdy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:48:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ae8e7e546so1183967585a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792086536; x=1792691336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sQZFKfVBjEeacFkdSGAZaT5LOyHECxVP58lQbJLCTHc=;
 b=LZJX4eGOzEyWseUzoV6OZLYeNWchYQfVIdnw9kX2NDj+euasLJdP/SSe8pOC0GuFF6
 dobALxJLQjWZ333Q7PGZE1zqcIJwXTIcxSPTFo0S+RJf1yS/JdeWlDNtakpQi695LLAw
 1WJRKaUEj0+3stzCJfFDJNNvjRqO8T52kgW8Dv7GzV5mG8u31eV+KyLF7MPf9TB7hI6s
 OAkehu5EtktKMnjsnYiaYwURvYvOXz3JnwRwefyW9hPki8i+w8Unmr28C6uoIXfQVkAv
 4dBd2H83kvhnlh24ZbxlfXStb7yuoXcRiUvD/hR4A72MfBrvri5jwlj2VqYDa2sH5vsi
 3a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792086536; x=1792691336;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sQZFKfVBjEeacFkdSGAZaT5LOyHECxVP58lQbJLCTHc=;
 b=V80+/EZFoJe+gIpJUPmV2KY9YkikxjrnxsusGDYXqYPDXG1Bu/OSu78m/BEf9JcKO9
 dl0XK0gWZQET5z4mNbNQQSXss7WOmTn9JgllItEwoUO+roAEY76keCIFUB7MbxUexlny
 lr3ILqLJ3wHfyycViu2JZeRpoFx5ea6EqFjLzE1j5DT4rvm/Xlzd3GlRMkg0F81v8plH
 RV8V5HXFeLBFmAYTX0bQvBYo8s8DneKI7DxyDC/3a9aSMhWe2tNEcJIFBCREzD0dkb3Q
 ByavNCbtvV8MvWZ8wC3nBjT8FaTWQie1evbm932ZKyvmpc5LpOyJ7ZLNnnPh1MyduoUL
 rXgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByj2kzzYFgjv39WrJHOiJG1/QS+HAXDTESy+6GNzOwakpoYEYtohsGOlx72X2riJebEnIemS53YCtS6@nongnu.org
X-Gm-Message-State: AFq9FYLWlhiUPAhcWmcWuT5I1IApZT/XaKjnP1SIqM5rgRMNH12Pyb7F
 SPYbWGrTftf9Fh71CiyKH8gHcoNon7swgQq55sp1Yex3cf7kNkRjO2TwwstdcLqgC6h6as6e4Gz
 KX8Z7C7BlCTfljZk2tVj7PBGwhwcfL5L78UkBZMu5kTM5nAusS9IeuO2yRQ==
X-Gm-Gg: AYBFou1wa55KMWHKY3HVNoWKATwGZ5XowPhpu2rtXbp78YOftsdOYFLTCFNT1McZjnv
 Yr+1lQvv+6vV4ZNCPkPwmqBdRKlsdI7ifrNbQ0UHqEESMddeSGwgfAMGRL6+twhZk+hRdqqV+WP
 v6IoTOu+Wf036Xh8iuU1BRs+t6eRy4fqsxVgHLYlOMsbUjyGdjMvnl8QfD0MeZ0sL4AI/Ir5FR0
 b8DjGgVhFv6XrxgYf9xndRX0f4p3Cyhc16Us+2n2SMLfjxuIfrQrX3zuardzh1rRLKP2ED3GjUp
 cQCOGAI1+QFi8zoq/CXQjZSxhBo7p0CowgSl3zo5X9yc5GQJ8fdgTe9T598Mdv36/Upd4a+roK2
 V9R4wT7hdQ5icAN4HYUiYUUZTc9F9MvnREQ==
X-Received: by 2002:a05:620a:838b:b0:93c:aff9:52c with SMTP id
 af79cd13be357-93ebd28176fmr3016826185a.60.1792086536103; 
 Thu, 15 Oct 2026 10:48:56 -0700 (PDT)
X-Received: by 2002:a05:620a:838b:b0:93c:aff9:52c with SMTP id
 af79cd13be357-93ebd28176fmr3016824085a.60.1792086535601; 
 Thu, 15 Oct 2026 10:48:55 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd99faf3sm86463025e9.14.2026.10.15.10.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 10:48:54 -0700 (PDT)
Message-ID: <56883c4c-dd87-41f2-8e71-1bb8fb65844d@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 19:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] target/riscv/cpu: constify cpu parameter for
 riscv_cpu_mxl
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com>
 <b99355a2-a424-41b2-978b-8938de06cbda@oss.qualcomm.com>
 <9218a003-b19d-480e-ae11-cf3ed2b9e592@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <9218a003-b19d-480e-ae11-cf3ed2b9e592@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad11208 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dtVPj9mvjZ9FIdNcov8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 3iDV3G7ATSUuGUyIGmfvPOghCBRMG9Vc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX9tpxPmamu+/R
 GzLoRvFET6HYObfw8NlEsa3ShSr9sGm57SRpvnN9zLPqKuWLIb2CBdYyoTDNg1x9q0tmvlgXNCo
 1ee7EZMbTnZ3dAVZVnjH2N9xo65HOg8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX8rBP3oUI43wy
 kr/tqy9rjABuaKK4b/L/ssfp+dKjZz2uOuGCZ2KIj9hVVrEikX4pJRiTZnG0MuvunpX19NccyzT
 s8O73gCgabdpBlYKuMnzKyNXCK8WKAIof6zT/9IvT4ZRc6BxYW+1YERBh6HOvyWcBkmZ3VVblQO
 sQ5cy2JUbZrDExNaHogwV8zqNm6/M9uhj7J93akbivWCC3DNWGE6c/u6H2mhNUvlZHXKZxyzIkM
 VbagOj0CBdDTr7YLocAT9L8qCqgrwefB26MA7nQvGasXPktWKh9l/ajPE9ULFDfCelKM/zQgt+r
 PTa+3CXMSeM6cb9UPAlgGbpGiHr/MvJaayAnxy/EpI6qrnisckvlRnRIb1HDFKI0UnHOZ+5NqEW
 Sl0BKqhVXvsnmFtI5Oghimpq0nhay30524wqCAgRFu7qnskK/VGhmM0/0bQv8PVuWJct0BWcRps
 qx/ff7STkzvrn1xyIog==
X-Proofpoint-GUID: 3iDV3G7ATSUuGUyIGmfvPOghCBRMG9Vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150070
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/10/26 19:42, Pierrick Bouvier wrote:
> On 10/15/2026 10:37 AM, Philippe Mathieu-Daudé wrote:
>> On 14/10/26 23:05, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    target/riscv/cpu.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>> index 8c8ffe94cd8..00650a66dcb 100644
>>> --- a/target/riscv/cpu.h
>>> +++ b/target/riscv/cpu.h
>>> @@ -755,7 +755,7 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
>>>    #ifdef TARGET_RISCV32
>>>    #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>>>    #else
>>> -static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
>>> +static inline RISCVMXL riscv_cpu_mxl(const CPURISCVState *env)
>>>    {
>>>        return env->misa_mxl;
>>>    }
>>
>> Reviewed 6 weeks ago and in Alistair riscv-next queue IIRC:
>> https://lore.kernel.org/qemu-devel/20260901095229.72018-17-
>> philmd@oss.qualcomm.com/
>>
>> Anyway,
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>
> 
> Did you flush the rest, or is it going through all submaintainers trees?
> 
> I feel that system wide series like this should be sent on their own at
> once to avoid having a state spread across multiple people with
> different latencies.

No, Alistair queued patches I'm depending on, and I consider a
maintainer sending the "patch queued" message a lock on the
patch. I'm stuck waiting for preliminary riscv-related patches
to get merge to reduce conflict with Alistair tree. Meanwhile
my tree grows so I'm not sure anymore it is a good process,
maybe I should have posted a PR and let Alistair deal with
the rebase conflicts. We still have 10 days until the freeze
so I guess we are still in time.

