Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A25CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIHT-0007WC-PI; Tue, 02 Sep 2025 00:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIHM-0007Ci-Sj
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:05:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIHK-0007H3-UF
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:05:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822WgMH030916
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6KPs5nSDVgzDgAJ/I/rWSbrFpBMDltrFKxcZLTUQ2t0=; b=c7vqn3X8LL1RFnNQ
 Al7/yga+pca9RgrC/uwFAVyJmkpWSTjm6eAMdGhp5Ri7+BJLwzYv6ejF6R+Oflar
 8e/cJnORWAZPZBv6oMKkvTRoaiNVJJn/fWkWynTxyf9HeL7QQ1aqd7f1Aw6fk9oY
 n+C3shE/2VIqYE3Cfamau7mvoJ38NrLgULuXV7z0cWFBf0hhpokToW8QnRrMBD3N
 Rw3W+/npoLGbGUlUQBIhd4Ve9ivBXlPWUHyQgYLMcUUAiq5oZL8UkV6IbZUfGJwI
 4j0NHDN7+08q5ZUkuQALLB/D9Z6d25f9hkd+dCx8InQzvj5akGDy49qFJ7Fo3S5G
 0hnMzA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvw866n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:05:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b49da7c3ff6so2869975a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785952; x=1757390752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6KPs5nSDVgzDgAJ/I/rWSbrFpBMDltrFKxcZLTUQ2t0=;
 b=KeqkNks6iX3FOnl1WpnN0CEu+r6n05l6Mk8dM5elLZdEJK/revHTQRXCHbYgn+Zhal
 4pL0KK/YK2Qt4DGCockSEmBhmayHwrGKGoSdVh97MQXfu6DG9ohHPxfLw32raZg2t90W
 J1g17z8ebg48iSHlm6Jw8P6c+NTuoDEYwarNpcBG8KOoHH4X6aIKXH+WdGERQDgh3qMT
 CfpolW5jOup+kse002T266PmZZbHUSfqF0Nz6O+L1Wnelk/xUiYyMEdnTlDSkTTHxCjX
 2SnMvMpft/sDEowej2DAjFI8vlum47d9lfGitPfWFTgI7hlZjhBqia1IZy+JAXKDJykm
 cHeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuSNt6uSnVnBnNyGjy7x7Xwy8L9PsKmxhLoNBsNgAx4/hIux2JVs8uHiCyyQSGMhCwEwsOmkKl/JyF@nongnu.org
X-Gm-Message-State: AOJu0YwqPZzuCI3IlX3i15wEaIa1UnsMxHFlGyVLya1zEiHuy0Cxqu2p
 LEUsrHP2R1C2/0xjQ2KKpgGIrGXjeUeDaYHSPjHx3lDrUmhLEysefU7nWOgBhiQcmPKH2WAXSDc
 sYwJ+5oEeR0z0HgjRhEf+9NNK1FRSe1wnZf68cf/4dPGsDankGOeLosJZvw==
X-Gm-Gg: ASbGncuF3z+fWuov3C1RK892MkyIDfdcPr/Ing6xMS56DODBFKmv9Gz/ipGadvLPl2V
 vM0ARka3eBSUPUkPzXiaF/nPOLd+MjgoFTaCaql7wlIQXJciRWkCBZtl2qOklUtp0yE9uHN4QyE
 EGfqsJrlsQaP+HRZ7Sm8bBBv3twUndyYt7DXHq6zNPDOIBk9jS5e6TAN87gIbD7rSNnqu4qfHQz
 dySP6HN/voxuTdkpouaFiu80Wl78qDOj6zwb80UDFIoWyEacu4EbCXEGqb9ztQ9j3sr+3vJYo8F
 3w7qfGXvKdXROgk5u4+dlaE44EvHq+XoE49juvf9nhDRQPNBMMRyI8A2JzbT2g==
X-Received: by 2002:a17:902:e80d:b0:248:9b4f:f688 with SMTP id
 d9443c01a7336-2494485db43mr105087325ad.4.1756785951754; 
 Mon, 01 Sep 2025 21:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuLABcwxWHIF9l1V3YegVjZl5+CUGRinmJqezPIxTr2j2EAviIs4covCawyGqLRxGr7mOeKw==
X-Received: by 2002:a17:902:e80d:b0:248:9b4f:f688 with SMTP id
 d9443c01a7336-2494485db43mr105087035ad.4.1756785951280; 
 Mon, 01 Sep 2025 21:05:51 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119538555ad.45.2025.09.01.21.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:05:51 -0700 (PDT)
Message-ID: <a39b9269-f324-4f74-b7e7-3cab91aaeb11@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:32:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/39] target/hexagon: Implement ciad helper
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-2-brian.cain@oss.qualcomm.com>
 <016201db9756$cee11240$6ca336c0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <016201db9756$cee11240$6ca336c0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfX75gl8OBlA9xB
 1oVAIiTr7quU6PMYksFgEJ74Rgn7pkuyKZ61Zmz8xzbh8XY0stdgQiDYsGqt4qMexF9/mqnQ7f7
 rPNMv/gb0NiCjAXvYBKVtzZPxRNMu7Se1Ory6GrBvIxp2ZQUcklB0zorsX7rDFHyeeMCX4O0AqU
 ty26ea5a580N1OcX4hSLgtQm7bVJOJ0efyVYgiby/PXxtBE4hmxEjmmqT8DkoaSzdK1yyYlRImb
 si4ymUivthhuCcW8l/FFC0Q9Jb3ZemS+2Mwgyl6DnNTf9nqXOnDLUwVBDm0hF1mq6HMyyPNtc9Y
 KJy+g/LTKtiu7ZfpCWHrbeUNGUZySgEzmFWVqfe6WWZ4Q/3mtWqlVv3E3TvTGCWbVMD122H7cZX
 3vJqWCgd
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b66d20 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=9KwwpM_txVaIH9V4Q5kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qWEYlTb6y2a2ssxIS_mGSBGjncyj3ox2
X-Proofpoint-ORIG-GUID: qWEYlTb6y2a2ssxIS_mGSBGjncyj3ox2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024
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


On 3/17/2025 11:08 AM, ltaylorsimpson@gmail.com wrote:
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
>> Subject: [PATCH 01/39] target/hexagon: Implement ciad helper
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> ciad is the clear interrupt auto disable instruction.
>>
>> This instruction is defined in the Qualcomm Hexagon V71 Programmer's
>> Reference Manual - https://docs.qualcomm.com/bundle/publicresource/80-
>> N2040-51_REV_AB_Hexagon_V71_ProgrammerS_Reference_Manual.pdf
>> See §11.9.2 SYSTEM MONITOR.
> Put this reference in somewhere easier to find.  See prior discussion on this.
>
> If it's only in the commit comment, it will be lost quickly.

Fixed in v2.


>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/op_helper.c | 39 ++++++++++++++++++++++++++++++++-
>> -----
>>   1 file changed, 33 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>> index fd9caafefc..b28a18adf6 100644
>> --- a/target/hexagon/op_helper.c
>> +++ b/target/hexagon/op_helper.c
>> @@ -34,6 +34,11 @@
>>   #include "op_helper.h"
>>   #include "cpu_helper.h"
>>   #include "translate.h"
>> +#ifndef CONFIG_USER_ONLY
>> +#include "hex_mmu.h"
>> +#include "hw/intc/l2vic.h"
>> +#include "hex_interrupts.h"
>> +#endif
>>
>>   #define SF_BIAS        127
>>   #define SF_MANTBITS    23
>> @@ -1338,9 +1343,36 @@ void HELPER(vwhist128qm)(CPUHexagonState
>> *env, int32_t uiV)  }
>>
>>   #ifndef CONFIG_USER_ONLY
>> +static void hexagon_set_vid(CPUHexagonState *env, uint32_t offset, int
>> +val) {
>> +    g_assert((offset == L2VIC_VID_0) || (offset == L2VIC_VID_1));
>> +    CPUState *cs = env_cpu(env);
>> +    HexagonCPU *cpu = HEXAGON_CPU(cs);
>> +    const hwaddr pend_mem = cpu->l2vic_base_addr + offset;
>> +    cpu_physical_memory_write(pend_mem, &val, sizeof(val)); }
> Careful here - an int is different sizes on 32-bit and 64-bit hosts.  Change the type to int32_t or int64_t.

Not fixed in v2, will work on this for v3.


>> +
>> +static void hexagon_clear_last_irq(CPUHexagonState *env, uint32_t
>> +offset) {
>> +    /*
>> +     * currently only l2vic is the only attached it uses vid0, remove
>> +     * the assert below if anther is added
> What assert?

Fixed in v2.


>> +     */
>> +    hexagon_set_vid(env, offset, L2VIC_CIAD_INSTRUCTION); }
>> +
>>   void HELPER(ciad)(CPUHexagonState *env, uint32_t mask)  {
>> -    g_assert_not_reached();
>> +    uint32_t ipendad;
>> +    uint32_t iad;
>> +
>> +    BQL_LOCK_GUARD();
>> +    ipendad = READ_SREG(HEX_SREG_IPENDAD);
>> +    iad = fGET_FIELD(ipendad, IPENDAD_IAD);
>> +    fSET_FIELD(ipendad, IPENDAD_IAD, iad & ~(mask));
>> +    arch_set_system_reg(env, HEX_SREG_IPENDAD, ipendad);
>> +    hexagon_clear_last_irq(env, L2VIC_VID_0);
>> +    hex_interrupt_update(env);
>>   }
>>
>>   void HELPER(siad)(CPUHexagonState *env, uint32_t mask) @@ -1416,11
>> +1448,6 @@ static void modify_syscfg(CPUHexagonState *env, uint32_t val)
>>       g_assert_not_reached();
>>   }
>>
>> -static void hexagon_set_vid(CPUHexagonState *env, uint32_t offset, int
>> val) -{
>> -    g_assert_not_reached();
>> -}
>> -
>>   static uint32_t hexagon_find_last_irq(CPUHexagonState *env, uint32_t vid)
>> {
>>       g_assert_not_reached();
>> --
>> 2.34.1
>

