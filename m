Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AD9CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIZa-0003uu-32; Tue, 02 Sep 2025 00:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIZK-0003j9-QX
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:24:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIZI-000191-V8
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:24:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RtgY010115
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dB47joHzNGkZorVKrt6hLVNbLCLarokwAX2yAUg4wIM=; b=TbNCy3oOdI100nnm
 rqQWuZLMKYhPCwRAhEp4Kr+qTU5vqtJHq+Vn7brGJidDoF+J1GAMRIBO4WmyNtYI
 w0H732D4RtFOxJqZOhDi1WkyTw+YffM9AFkrSGmILC55XjWd2Smw9gbLNmj3XrdU
 cClZ6QRDg2K94tJr1J4Y5svQD420/zwEDMph4T5lf1yZOKnZ03BR/CuyiIMDnQS2
 VYHb3bk483Lce/YKvr0gvqkunh38ipt+KphD8RxpAuRN8+lLcLwngMAVPaXCDx1+
 XZFWXUTdWflwmWJaPXbZeShMvYN7AefmvrJ0d4K9FTv9V4CswZvWlRERGnulniNj
 RbsxEQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjefk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:24:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b2f7851326so124363411cf.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787067; x=1757391867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dB47joHzNGkZorVKrt6hLVNbLCLarokwAX2yAUg4wIM=;
 b=h+nIIIZ2NI/Urhick3rOFvxG7Z//NGsmeHIZBRm+5mcVf3z8tVjcuUA0GpV3Zbt03K
 /Yq1C8aDzmSn7E3ZtfEE8MKvNfoxv8d0OSuq7uA36El6aqU3KGrbhCb5C9f5wNV/22Cw
 HMikF/Z82hn37wCWROt2G3rzYsrkLFitEspsGWNqxfJJGTxp5wIUczPLnIc9SAPnjmBK
 ekL+96juZgmNc+byRSHRYFDkKwbS4/roQj9+f8gmB14pNmLA4M/Wei114eTHBCzL7cS+
 ThKpZz/mEKKwniscT2eRVvDfaOq3ZklWgjMk9pl0UsaUJXnXxSx7DgUd0B7cekC8i4LV
 C8rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpSspvThCD3hKSYkk0sxgmrvaXi7oknBEQqnoA/lQ8Avgi9DC+7vFnwbhO5DK1vYHlG3+DyD9cBddo@nongnu.org
X-Gm-Message-State: AOJu0YxPXroxHQJFZLLq6GSjmQKlJ4zSjZkOxqZi32JyCjIN52ICWIBo
 8kxlk9Xa68hhELUG/22G43pGH0Ls/D0Acj6dejgHRb7s5SPi+IU4G2se2t5WeY1HoHwHTzZBVPw
 OJ/3KWxP+XRokl6g8/QRCOvdIscU6uSimzUaIb0UKMl0dDVTLDD+d3UqneQ==
X-Gm-Gg: ASbGncuurFGWj2gzlfysI/ncwOMWXmErj3a4/Gc7A3/rL2pPjayllZ5hkmSgnprgO+2
 EDRBp6Nz/UV/rdc4TGdS0kxTjZ3MrvRdHEC/zDM6Sm0xMiyHD6U7xqesnXMyj4E4MO9QUMHZpp7
 NHtCDpaJEdwK3skjzjP4uuf8tyOzBhqenAC1Cd7NQ/sWY3bFkjAU5N90I1z6q2vaJMC0JFFDr2d
 Jm0oa0vW+20VfMUI+d0hOjuppGu8R3I1B2PPgrOv2ujwblEu6qLpB3sue6tNR/nvJRQhpyfhy8S
 y9pCH6Bc6g66/Ei/CFBpL4zb8x959lCoPd0o2WYUFinh2+U9W4leR2rhWjpNFQ==
X-Received: by 2002:ac8:7f44:0:b0:4b0:d8b6:dc5d with SMTP id
 d75a77b69052e-4b31d877260mr131849181cf.23.1756787066951; 
 Mon, 01 Sep 2025 21:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7+w53MNlhERT1BqSwmQCxPcgjwxh+REQr4i+S/eU72usSJiCWIzSKwNvOR++9yK7dHXrqCg==
X-Received: by 2002:ac8:7f44:0:b0:4b0:d8b6:dc5d with SMTP id
 d75a77b69052e-4b31d877260mr131849001cf.23.1756787066499; 
 Mon, 01 Sep 2025 21:24:26 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm17958390f8f.27.2025.09.01.21.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:24:25 -0700 (PDT)
Message-ID: <6db767b9-0ad2-42d9-be0a-ba1e18dbcd9d@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:58:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/39] target/hexagon: Implement modify_syscfg()
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-14-brian.cain@oss.qualcomm.com>
 <02db01db9913$afa44b90$0eece2b0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <02db01db9913$afa44b90$0eece2b0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b6717b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=J4iFxCsNUzYdllYh6KkA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kDVrSYN3vNFVocJZg5xgklIpXajuWTCa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX9tm70100ZePk
 qLCSa4ZK+s3rKDQhOHNc7aUI5hoo1HV3ZmaldF0nosEoiCurEf7uR4YgkqpcS6zlw5NDQ9Unxak
 0eHM2fjPNDDOSAWE5vpUq1doogz/A839cknveSDVHN9F0Kjd42+keuD324XIWrjRDn5rdT02j+q
 SNCkuEfN5tROh0e5x+9kDgo0PFMsAXqsNa/H0C6B2n4io3xLFVivrVK6ARsVRGEUWo6ChsyzzCd
 tsppH21lJXqlBDAgs5iAb0qe0pCRBOnviQoWpJO9hUXupgErpBueeu2d6fLQ0yY0enS76XgW2vs
 H+fVJVeFwu6KGpBDS96td4vdWtzMuU6gAgrlVp3zV39+cz+bZBdKzQW8WGa2PUEeE0a7+tZaETQ
 PpD842Ex
X-Proofpoint-ORIG-GUID: kDVrSYN3vNFVocJZg5xgklIpXajuWTCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 3/19/2025 4:12 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:28 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 13/39] target/hexagon: Implement modify_syscfg()
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/op_helper.c | 51
>> +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>> index 03bed11f6e..42805d0f1d 100644
>> --- a/target/hexagon/op_helper.c
>> +++ b/target/hexagon/op_helper.c
>> @@ -1522,7 +1522,56 @@ static bool
>> handle_pmu_sreg_write(CPUHexagonState *env, uint32_t reg,
>>
>>   static void modify_syscfg(CPUHexagonState *env, uint32_t val)  {
>> -    g_assert_not_reached();
>> +    g_assert(bql_locked());
>> +
>> +    uint32_t old;
>> +    uint32_t syscfg_read_only_mask = 0x80001c00;
>> +    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
>> +
>> +    /* clear read-only bits if they are set in the new value. */
>> +    val &= ~syscfg_read_only_mask;
>> +    /* if read-only are currently set in syscfg keep them set. */
>> +    val |= (syscfg & syscfg_read_only_mask);
>> +
>> +    uint32_t tmp = val;
>> +    old = arch_get_system_reg(env, HEX_SREG_SYSCFG);
> This is the same as syscfg declared above
>
>> +    arch_set_system_reg(env, HEX_SREG_SYSCFG, tmp);
> Why is tmp needed?  Just use val here.
>
>> +
>> +    /* Check for change in MMU enable */
>> +    target_ulong old_mmu_enable = GET_SYSCFG_FIELD(SYSCFG_MMUEN,
>> old);
>> +    uint8_t old_en = GET_SYSCFG_FIELD(SYSCFG_PCYCLEEN, old);
>> +    uint8_t old_gie = GET_SYSCFG_FIELD(SYSCFG_GIE, old);
>> +    target_ulong new_mmu_enable =
>> +        GET_SYSCFG_FIELD(SYSCFG_MMUEN, val);
> Move these declarations to the beginning of the function.
>
>> +    if (new_mmu_enable && !old_mmu_enable) {
>> +        hex_mmu_on(env);
>> +    } else if (!new_mmu_enable && old_mmu_enable) {
>> +        hex_mmu_off(env);
>> +    }
>> +
>> +    /* Changing pcycle enable from 0 to 1 resets the counters */
>> +    uint8_t new_en = GET_SYSCFG_FIELD(SYSCFG_PCYCLEEN, val);
>> +    CPUState *cs;
> Move the declarations to the beginning of the function
>
>> +    if (old_en == 0 && new_en == 1) {
> You could put declaration of cs here if you prefer
>
>> +        CPU_FOREACH(cs) {
>> +            CPUHexagonState *_env = cpu_env(cs);
>> +            _env->t_cycle_count = 0;
> I'm not a fan of _env as a variable name.  Just do
>      cpu_env(cs)->t_cycle_count = 0
>
>> +        }
>> +    }
>> +
>> +    /* See if global interrupts are turned on */
>> +    uint8_t new_gie = GET_SYSCFG_FIELD(SYSCFG_GIE, val);
> Move the declaration to the beginning
>
>> +    if (!old_gie && new_gie) {
>> +        qemu_log_mask(CPU_LOG_INT, "%s: global interrupts enabled\n",
>> __func__);
>> +        hex_interrupt_update(env);
>> +    }
>> +
>> +    if (qemu_loglevel_mask(LOG_UNIMP)) {
>> +        int new_v2x = GET_SYSCFG_FIELD(SYSCFG_V2X, val);
>> +        if (!new_v2x) {
>> +            qemu_log("HVX: 64 byte vector length is unsupported\n");
>> +        }
>> +    }
>>   }
>>
>>   static uint32_t hexagon_find_last_irq(CPUHexagonState *env, uint32_t vid)
>> --
>> 2.34.1
Fixed in v2.

