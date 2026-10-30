Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD818606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DDp+9NYY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WY4m2YRv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMlMe-0006GN-M7; Fri, 30 Oct 2026 08:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMlMZ-0006G4-7T
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:05:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMlMT-0006jD-Dd
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:05:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBG1vw2071544
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0tOqz4q5cJ0me8Aht+mI5y4Rrt/WKPLHLJvPB5iIYWI=; b=DDp+9NYYP7ufTxy6
 /VlDBBb1sPFx3tFtndIiVz9Y/2JNmrnyEpYmAlsZ/GkFixz6qNNWjJsGWU3sSfpC
 GcU9MVjGRlr3DPOeP3PiaHRtTDQcnYiCX5pmcIQ/QhNPJbSA3Ne2uUvKciDdrlgH
 k+8nNkDudb7ntaEFj2BlTRRfRpJ2f/u6BcTf3zT3UUmFK4cCpSNuhZKvb9QJrSGs
 X4JfvbQzIdJ/3eFkNOBKkHHVYa/1PsFdLUZ14YT/Bds+KmUU0HeJ+fMqL04WZC4q
 weGPvghGWLuKfWT7S/IN+5Q4vp4GcgHJBDPd9oo2MIe5Q5voASAFSsCbGQeaA2ID
 UqwUmA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p2yqe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:05:30 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-98c73709b84so468349241.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793361929; x=1793966729; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0tOqz4q5cJ0me8Aht+mI5y4Rrt/WKPLHLJvPB5iIYWI=;
 b=WY4m2YRvYQvuiQBjy9txa8yt2wUIH5VIwuBI/pK+cUj177iGXtyuO13Apl4WQpaJTw
 e34sPAzex5ZBXP7RGMi6Wpkd7HYe2dNy0kBQyZbSaSSgr92Djgk3hTN7pdjTadEDEwDk
 zVF28hLv0+0TC5j3Pz473HL1XlvnqBTkHsnnwvUvto/0zLq5SW4lC1+Yj20sVw0NC6yD
 NRdsQ1bblxbypgyKCXXSt+sadbfPBAhNcUD8GSbqRJTTeRODy2lfUZb5NUlvOZcFccrl
 v9onn5iNiwVbBhB5gEn7Ql4mlOFTnJIiilQccrf1mNbtnjbmkNQSnKKVRrTzmCsz/t6h
 rwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793361929; x=1793966729;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0tOqz4q5cJ0me8Aht+mI5y4Rrt/WKPLHLJvPB5iIYWI=;
 b=BsS0bAmb2ostC5+19XTrIy94jYfsPe3+fJTEKChVD11ULD6mdyE5U+MnxmH+gTvjHj
 J4ARGlNqopewqm/KwLcJWa++8ztOn3K06p6jQBSxaQYewmDRTOMYPOtRg51dz35jqeyS
 BvTCvUW7XdDbxEFOKwmykknuTuLCSuIC2DGAi9ekPgu6l9AjEj7lPnAghU4dBQF9zz39
 KvpYpBCXkEhS9h1gZC024sZlL2ErdP4whxI/rux2Ylkzmo1PffkOiDfiB7+yupvWYslH
 SydfjynXCoXpl3IClk0KztZGfm96wJMOnp+C+KByixTwFAAhOR88Jllxqxc9hoJ2cf1s
 vEoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4th3yCHZaK1ha9IkQUogE/mgUkZkcbVY8fQ47mvlE/ftNlbw/1d2J7gAFF+dw2P11o1HXFOv4n0Sq@nongnu.org
X-Gm-Message-State: AFq9FYKrhn4aZNdnvmgr4DZ8qtFXMnbxfJ5PEESfN97bebXRyIg3IIek
 d9Znyq4odU2TMvD9KugQq1vnyECsqwqNPqtuh9r544ozdf9BsXf/OYYYj0Sf1r8cbfs8rUbk4I5
 bZTWX/X0S8ATR6y8W3RQMTAABUIe0a9CyWw9F+cRsDDNVWckU/J6DiXR2vQ==
X-Gm-Gg: AYBFou0NPQkVzRipsUmXcK/3MlY1dWgjbsk9WNJpt8s5MIESJUe59yENANDaiGzMqbz
 ElcvRBjCD37ydGpZh5f2bZv7nQWT/8ePNeXdzPlQIeVov/9s0VG8So61537HYQVM4GneKLqF9qj
 qlxoxwB3Wumbf5dX0N5iK7hP3aubam2EkdGUIFZf729jVd7ki1U5bMSMziPLq/JhvE5QNZhGqbT
 o1uVAyd8pf33bsBUkY3BWeWzS5JAR6LEDDFk1w2Dr7TPGJt6HJnfYkN8xO6bll4HjnRKMNh/VIj
 8ILBFwcH12z6RERboYsDtQB+UC6T3MQL4DQCfLkixfbQgLWM8fRkBOB5jvdhtm7W9MpODjnil9a
 HpxEVfZIUjcVEA6XgEmluVXKS5ENpx1TEG7JwKrRHPEyrrdxwf5OwMICVznbZCE2hDr5YSN/zla
 AzoR4/4SspoCLnf0NvEXNo48I=
X-Received: by 2002:a05:6102:6881:b0:7a8:1837:9eb9 with SMTP id
 ada2fe7eead31-7d07273b428mr984883137.27.1793361929407; 
 Fri, 30 Oct 2026 05:05:29 -0700 (PDT)
X-Received: by 2002:a05:6102:6881:b0:7a8:1837:9eb9 with SMTP id
 ada2fe7eead31-7d07273b428mr984873137.27.1793361928881; 
 Fri, 30 Oct 2026 05:05:28 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm134908995e9.4.2026.10.30.05.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 05:05:27 -0700 (PDT)
Message-ID: <6f58917e-6632-4642-baf9-c1009fe8574a@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 13:05:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/31] tests/tcg/mips: Group MSA bit-count tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
 <20261029172319.25766-15-philmd@oss.qualcomm.com>
 <13e2766d-cff0-4aca-950d-8f8b182d2b7f@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <13e2766d-cff0-4aca-950d-8f8b182d2b7f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0OCBTYWx0ZWRfX03LklhHDKkhy
 EnzblGFQDO9s15jyj7YxdyXSRM6Lats3icKTfaquoHakRbJGE6hjaRuVfLH+9IM8ueOau5J8PKQ
 O3ZbuJVcrrSki3QbXzuU403izpeUVL5FWZ1iNNo61oVzxCPuNBsLPt3q70bRiTb52R1MU+PMKH8
 Pb63LNk469xo74QZCLMmVp3yVzG35dhZKd+7R057rCxhraaeK5mWOHWkKqSbLEY6gvEKLEboLA9
 QRJDfvS8pYHWQl1PMMYnG7aRZ7U9OBJhhvhKySIk6taV61WYcPpz2qjGx6/7ZTBsPsIwX3cnj5+
 hMh2XQODg8UoSsng22PvMsK183d8Rid+PKWPclQx5jRYuqtWNRx0D0Vpa8wWFNrCRZ0mB1C8PQV
 vqLcaXH5GkETMhwvwEiUBOs8o3GjqDfNcnWBgd8nxJLuk7nGoHVFOFYTslVUvFXNmIgqUAYF2wU
 JKP3fJRyV/pgg/GIC/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0OCBTYWx0ZWRfX3ObArwOV3ebT
 LQJHy6ZmRp3RrzQQ9kJtumd02gYk8jzpOI6IA3mBzQTOUGU6Vzj/CAXQ07zkrEZLI/jWgGrz9HO
 5Wk444Seam+MK/VVW1mj0Eb76p8xmaE=
X-Proofpoint-ORIG-GUID: iZp1LovYLqG9SiC2F1m6rhb0vqqf3ebq
X-Proofpoint-GUID: iZp1LovYLqG9SiC2F1m6rhb0vqqf3ebq
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4880a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=lc_gtqdLSLcpAXMhqBMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300048
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

On 29/10/26 20:22, Pierrick Bouvier wrote:
> On 10/29/2026 9:22 AM, Philippe Mathieu-Daudé wrote:
>> Build the 12 per-opcode bit-count tests as a single executable,
>> test_msa_bit_count.c, to reduce the number of test binaries.
>> Each opcode reports one TAP line.
>>
>> Prefix the per-instruction summary of test_utils_128.h with '# '
>> so TAP parsers treat it as a comment.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   tests/tcg/mips/include/test_utils_128.h |   2 +-
>>   tests/tcg/mips/test_msa_bit_count.c     | 103 ++++++++++++++++++++++++
>>   tests/tcg/mips/meson.build              |  12 ---
>>   tests/tcg/mips64/meson.build            |   6 +-
>>   tests/tcg/mipsel/meson.build            |   6 +-
>>   5 files changed, 114 insertions(+), 15 deletions(-)
>>   create mode 100644 tests/tcg/mips/test_msa_bit_count.c
>>
>> diff --git a/tests/tcg/mips/include/test_utils_128.h b/tests/tcg/mips/include/test_utils_128.h
>> index 0dd38684cf33..9ba877d84b5c 100644
>> --- a/tests/tcg/mips/include/test_utils_128.h
>> +++ b/tests/tcg/mips/include/test_utils_128.h
>> @@ -59,7 +59,7 @@ static inline int32_t check_results_128(const char *isa_ase_name,
>>       uint32_t pass_count = 0;
>>       uint32_t fail_count = 0;
>>   
>> -    printf("| %-10s \t| %-20s\t| %-16s \t|",
>> +    printf("# %-10s \t| %-20s\t| %-16s \t|",
>>              isa_ase_name, group_name, instruction_name);
>>       for (i = 0; i < test_count; i++) {
>>           if ((b128_result[2 * i] == b128_expect[2 * i]) &&
>> diff --git a/tests/tcg/mips/test_msa_bit_count.c b/tests/tcg/mips/test_msa_bit_count.c
>> new file mode 100644
>> index 000000000000..dacfb619f8fc
>> --- /dev/null
>> +++ b/tests/tcg/mips/test_msa_bit_count.c
>> @@ -0,0 +1,103 @@
>> +/*
>> + * MIPS MSA tests: Bit Count instructions
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#define main test_msa_nloc_b
>> +#include "user/ase/msa/bit-count/test_msa_nloc_b.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_nloc_d
>> +#include "user/ase/msa/bit-count/test_msa_nloc_d.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_nloc_h
>> +#include "user/ase/msa/bit-count/test_msa_nloc_h.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_nloc_w
>> +#include "user/ase/msa/bit-count/test_msa_nloc_w.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_nlzc_b
>> +#include "user/ase/msa/bit-count/test_msa_nlzc_b.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_nlzc_d
>> +#include "user/ase/msa/bit-count/test_msa_nlzc_d.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_nlzc_h
>> +#include "user/ase/msa/bit-count/test_msa_nlzc_h.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_nlzc_w
>> +#include "user/ase/msa/bit-count/test_msa_nlzc_w.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_pcnt_b
>> +#include "user/ase/msa/bit-count/test_msa_pcnt_b.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_pcnt_d
>> +#include "user/ase/msa/bit-count/test_msa_pcnt_d.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_pcnt_h
>> +#include "user/ase/msa/bit-count/test_msa_pcnt_h.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +#define main test_msa_pcnt_w
>> +#include "user/ase/msa/bit-count/test_msa_pcnt_w.c"
>> +#undef main
>> +#undef TEST_COUNT_TOTAL
>> +
>> +
>> +static const struct {
>> +    const char *name;
>> +    int32_t (*fn)(void);
>> +} msa_tests[] = {
>> +    { "nloc.b", test_msa_nloc_b },
>> +    { "nloc.d", test_msa_nloc_d },
>> +    { "nloc.h", test_msa_nloc_h },
>> +    { "nloc.w", test_msa_nloc_w },
>> +    { "nlzc.b", test_msa_nlzc_b },
>> +    { "nlzc.d", test_msa_nlzc_d },
>> +    { "nlzc.h", test_msa_nlzc_h },
>> +    { "nlzc.w", test_msa_nlzc_w },
>> +    { "pcnt.b", test_msa_pcnt_b },
>> +    { "pcnt.d", test_msa_pcnt_d },
>> +    { "pcnt.h", test_msa_pcnt_h },
>> +    { "pcnt.w", test_msa_pcnt_w },
>> +};
>> +
>> +int main(void)
>> +{
>> +    int fail = 0;
>> +    unsigned i;
>> +
>> +    printf("TAP version 14\n"
>> +           "1..%u\n",
>> +           (unsigned)(sizeof(msa_tests) / sizeof(msa_tests[0])));
>> +    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
>> +        int r = msa_tests[i].fn();
>> +
>> +        printf("%s %u - MSA %s %s\n", r ? "not ok" : "ok", i + 1,
>> +               "Bit Count", msa_tests[i].name);
>> +        fail |= r;
>> +    }
>> +
>> +    return fail ? 1 : 0;
>> +}
>> diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
>> index 88d598a4f89b..40984e9b4fcf 100644
>> --- a/tests/tcg/mips/meson.build
>> +++ b/tests/tcg/mips/meson.build
>> @@ -93,18 +93,6 @@ tests_mips_msa = [
>>     '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
>>     '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
>>     '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_pcnt_h.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_pcnt_b.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_nloc_h.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_pcnt_w.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_nlzc_h.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_pcnt_d.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_nloc_d.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_nloc_w.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_nloc_b.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_nlzc_d.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_nlzc_w.c',
>> -  '../mips/user/ase/msa/bit-count/test_msa_nlzc_b.c',
>>     '../mips/user/ase/msa/int-add/test_msa_addv_d.c',
>>     '../mips/user/ase/msa/int-add/test_msa_adds_a_h.c',
>>     '../mips/user/ase/msa/int-add/test_msa_add_a_h.c',
>> diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
>> index 894f8e9e23e1..bcc02d955436 100644
>> --- a/tests/tcg/mips64/meson.build
>> +++ b/tests/tcg/mips64/meson.build
>> @@ -39,7 +39,11 @@ foreach src: tests_mips64r6
>>     tests += {src: {'cflags': '-march=mips64r6', 'protocol': 'tap'}}
>>   endforeach
>>   
>> -foreach src: tests_mips_msa
>> +tests_mips_msa_groups = [
>> +  '../mips/test_msa_bit_count.c',
>> +]
>> +
>> +foreach src: tests_mips_msa + tests_mips_msa_groups
>>     tests += {
>>       src: {
>>         'cflags': ['-march=mips64r6', '-mmsa'],
>> diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
>> index 9e446eed0f6e..8b4e665634ab 100644
>> --- a/tests/tcg/mipsel/meson.build
>> +++ b/tests/tcg/mipsel/meson.build
>> @@ -40,7 +40,11 @@ endif
>>   
>>   tests = []
>>   
>> -foreach src: tests_mips_msa
>> +tests_mips_msa_groups = [
>> +  '../mips/test_msa_bit_count.c',
>> +]
>> +
> 
> For this, and all MSA tests, any reason to duplicate this array between
> mips64 and mipsel?
> 
> I can hear the "self-contained" meson.build argument, but in this case,
> it really feels like duplication.

Good point, I didn't notice.


