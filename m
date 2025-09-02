Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B15CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIYC-0002XJ-Pl; Tue, 02 Sep 2025 00:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIY9-0002X4-Sa
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:23:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIY7-0000xk-P8
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:23:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S5JP021586
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fd6ozZRZ9e6A0HdsAdBkqdjXqLsv83O7o8FHI5Sq+N0=; b=MTTz5zHegjBOP2Km
 l5q2eDeh9PVLNpOEgtVHrJi8g9R8/s5dTqjtA6X1vwD3ft4MWXMetcHPv5GVTYHw
 0ctatbB7tVNA3j2YMY8rDsVxNWbI7+Aoy8voyOxW9Fh04FH75SjE8XRG8ZOMDlvg
 Y7HCt1gkVjZ0FTUgwBDRceRMNetuNnmxMk3J3iCHr8MaJiWL7DVHkRKFvOV6XeKj
 44QQSNN/2CF7riSWdjY/CFueZVUP1Bif6iDG0oEZOv24AsoijswspL2rFMLfG5Gw
 9h5XvGZ8/imaL1T0PfPVndTE0tNQyzNjqJWIZ09DET5Z1DGu/2EAODdPNx3B/e7K
 smH3RQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8rxhdt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:23:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b2f7851326so124344101cf.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756786991; x=1757391791;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fd6ozZRZ9e6A0HdsAdBkqdjXqLsv83O7o8FHI5Sq+N0=;
 b=S44vVG7Gf/NLuDTnVT5k9FZUMb735hg0+sSs2qXBUxTnESXqhn7qDbCQpSRY2HEzh1
 lW6XwTZvsYLKsfyfIrgcy8lpxhIW3+OJC6qDTffyqY3LehdH2SaJE2Hc0CKF5UM+grj5
 BM+ge3K5NF67wE57ryRIFuIi9yFlzsPHLdKz3emRDHqb9oV9l8FFAgATCFC1WrO2dpf3
 MP9n4uB5z/jX86mGxqBrAKYAqehutVkmN4sWR0YA1dtG98NTUdrrtctU0hMfa2JweVkX
 REQk1dNc1kH7yhwAMC7Ua7yt6JqBP94jMaDYI5t9L5VWVTZsKtIizjDTaUajAfNpwVR/
 QdvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgU4FiTAXeWuIt7neGUm8xjmWAq9stg13gr0vwrbdHQ8NhPsTnmFgpuyhs9giujmJZdnR/yqkcpNm/@nongnu.org
X-Gm-Message-State: AOJu0YxxK9DvJFqYY3xOHVhq2DKg8+YJVKkb5Jz4ALvP5IICFyKNahAX
 KoQF/50AEX/Np+ph8rGAovZ4P145Ao9mp/xIUt2p6xnwyOy8YWivt2d2Yc++Aw9whw7x946BhYU
 ho/1zm7s3Gl+U6uG7lz0y/0CaqZHBWu/TCi4Hb5MvG9ncav4VtM4lAA+iXA==
X-Gm-Gg: ASbGncupCJFccs36xuWBQ7YNG/Oukn8XwvR+IzlqiSHGTJuYzzN9UMr84ZxAp/dE79q
 j5xSN8eEl0g/hjXpvbiJLBs64WyRNT8IRryZIHD8kA9gayLOD7eeCyR+brfEmAl+ONscmuTFKEx
 DP1wv533tCCAckqi6C5WlnQfJDI68bx9pswEWB+YSSTl+AUTDtbUHW7JvgtYmup54xewKRkgn+b
 rczCs8FMDReWOxjLzgrUaIkXDYhb7Lh+jQmA4D/3ZNYWZgAV2WzVKT2e8ndRjXR6KHiIg//Vr8f
 n2uafiudXzDF+VwwY0+KA4YhueZQpQdbJUWCz0UCREie4PA6vMtaqrwdo7A6Tg==
X-Received: by 2002:ac8:594b:0:b0:4b2:eeed:6a17 with SMTP id
 d75a77b69052e-4b31db69339mr126536461cf.46.1756786991538; 
 Mon, 01 Sep 2025 21:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkMeYIgP+85w65gv1hEq/qQNnI9VC7sU3s/Saw3wx+2PrpPd23wWoUV6uIM8TABtY0cS2WHQ==
X-Received: by 2002:ac8:594b:0:b0:4b2:eeed:6a17 with SMTP id
 d75a77b69052e-4b31db69339mr126536211cf.46.1756786990869; 
 Mon, 01 Sep 2025 21:23:10 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm17958390f8f.27.2025.09.01.21.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:23:10 -0700 (PDT)
Message-ID: <2edceb98-ec8f-424d-849b-bb5543c00679@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:44:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/39] target/hexagon: Implement {g,s}etimask helpers
To: Sid Manning <sidneym@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng" <anjo@rev.ng>,
 "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "Mark Burton (QUIC)" <quic_mburton@quicinc.com>,
 Brian Cain <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-7-brian.cain@oss.qualcomm.com>
 <017301db9764$35236f00$9f6a4d00$@gmail.com>
 <IA0PR02MB94869B8845A4B698519DDFF9BEDB2@IA0PR02MB9486.namprd02.prod.outlook.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <IA0PR02MB94869B8845A4B698519DDFF9BEDB2@IA0PR02MB9486.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX+TuRiqZS1abA
 en8+VAwa6SzvbV6Bm2hOCATYLqFM0EaLl72DlXnKOeP9+GbTf600gqkC0lIG0fSLZoJP8A3r8AX
 upqIZYHuS6d7wI9fH2E1qgXpLnOvEv+/nOA+xKNXM/Y3FqNyDNYmUWU74kHquzUX6kXM24j2L72
 7fs/BNfEg3wp6fj28p5yhUvdxqmVw1/s7lrQBI5B/LRzIDHlvwZDTlhPON/+FI3YPYWCsyDOMNP
 xF4ftGgTlarN/poXcMTRk0snAy+JqLBiQDiuQqa0merorzzEC5u+Naz59wboUfykSu1pq5VusnD
 HE1u23DQNFxgeW0kpFXYS/jotoK2kP71MzXuJJj1/YjBXHNwvJjpVqYJfMZXalgl7e0C1uwP34H
 ZJ7vjMVK
X-Proofpoint-GUID: SwFm-Qb70L10EkzGH0MFhpmphPFNVQES
X-Proofpoint-ORIG-GUID: SwFm-Qb70L10EkzGH0MFhpmphPFNVQES
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b67131 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=gr_Q40nmJAwP1si43coA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/21/2025 4:48 PM, Sid Manning wrote:
>
>> -----Original Message-----
>> From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
>> Sent: Monday, March 17, 2025 12:44 PM
>> To: 'Brian Cain' <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; philmd@linaro.org; Matheus Bernardino
>> (QUIC) <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng; Marco
>> Liebel (QUIC) <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; Mark
>> Burton (QUIC) <quic_mburton@quicinc.com>; Sid Manning
>> <sidneym@quicinc.com>; Brian Cain <bcain@quicinc.com>
>> Subject: RE: [PATCH 06/39] target/hexagon: Implement {g,s}etimask helpers
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary
>> of any links or attachments, and do not enable macros.
>>
>>> -----Original Message-----
>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>>> Sent: Friday, February 28, 2025 11:28 PM
>>> To: qemu-devel@nongnu.org
>>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng;
>> anjo@rev.ng;
>>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com;
>>> Brian Cain <bcain@quicinc.com>
>>> Subject: [PATCH 06/39] target/hexagon: Implement {g,s}etimask helpers
>>>
>>> From: Brian Cain <bcain@quicinc.com>
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/op_helper.c | 31 +++++++++++++++++++++++++++++--
>>>   1 file changed, 29 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>>> index 9f79b1a20c..83088cfaa3 100644
>>> --- a/target/hexagon/op_helper.c
>>> +++ b/target/hexagon/op_helper.c
>>> @@ -1468,12 +1468,39 @@ void HELPER(resume)(CPUHexagonState *env,
>>> uint32_t mask)
>>>
>>>   uint32_t HELPER(getimask)(CPUHexagonState *env, uint32_t tid)  {
>>> -    g_assert_not_reached();
>>> +    CPUState *cs;
>>> +    CPU_FOREACH(cs) {
>>> +        HexagonCPU *found_cpu = HEXAGON_CPU(cs);
>>> +        CPUHexagonState *found_env = &found_cpu->env;
>>> +        if (found_env->threadId == tid) {
>>> +            target_ulong imask = arch_get_system_reg(found_env,
>>> HEX_SREG_IMASK);
>>> +            qemu_log_mask(CPU_LOG_INT, "%s: tid %d imask = 0x%x\n",
>>> +                          __func__, env->threadId,
>>> +                          (unsigned)GET_FIELD(IMASK_MASK, imask));
>>> +            return GET_FIELD(IMASK_MASK, imask);
>>> +        }
>>> +    }
>>> +    return 0;
>>>   }
>>>
>>>   void HELPER(setimask)(CPUHexagonState *env, uint32_t pred, uint32_t
>>> imask)  {
>> The name pred sounds like a predicate register.  Use tid instead.
> [Sid Manning]
> In this case pred is referring to the predicate register.
>
> setimask(Pt,Rs)
> The setimask instruction writes the IMASK for the thread indicated by the low bits of
> predicate Pt. Register Rs contains the 32-bit mask value to be written. For Pt values outside of
> [0-NUM_THREADS-1], the results are undefined.
>
>>> -    g_assert_not_reached();
>>> +    CPUState *cs;
>>> +
>>> +    BQL_LOCK_GUARD();
>>> +    CPU_FOREACH(cs) {
>>> +        HexagonCPU *found_cpu = HEXAGON_CPU(cs);
>>> +        CPUHexagonState *found_env = &found_cpu->env;
>>> +
>>> +        if (pred == found_env->threadId) {
>>> +            SET_SYSTEM_FIELD(found_env, HEX_SREG_IMASK, IMASK_MASK,
>>> imask);
>>> +            qemu_log_mask(CPU_LOG_INT, "%s: tid %d imask 0x%x\n",
>>> +                          __func__, found_env->threadId, imask);
>>> +            hex_interrupt_update(env);
>> Shouldn't this be found_env?
> [Sid Manning]
> It could be either, hex_interrupt_update is just using env to get the global ipend register.
>>> +            return;
>>> +        }
>>> +    }
>>> +    hex_interrupt_update(env);
>> Do you need to update if the thread wasn't found?
> [Sid Manning]
> This may not be strictly needed since the only way to reach this line is for setimask to pass a predicate that is outside the range of valid htids.  We can remove this and add a guest error.
>

Fixed in v2 but I see now that we used the wrong format specifier - will 
fix it for v3.


>>>   }
>>>
>>>   static bool handle_pmu_sreg_write(CPUHexagonState *env, uint32_t reg,
>>> --
>>> 2.34.1

