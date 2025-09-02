Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67CCCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIYu-0002tj-AW; Tue, 02 Sep 2025 00:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIYr-0002rU-4V
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:24:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIYp-00016x-9v
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:24:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Ro1f029965
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BlRcy4ZxieFQ44suBlgaViaeJ+U8ll/tYwZA+brZVLo=; b=TpDLDeRySGiKxsy9
 RGOXkFOmxUO6I8NifCUvBLu83VDYG+wv8vvDFCqxcSg5q6mcGlQqfXrHORHDSbJQ
 0qR1qxcSDKIIzwq8l6WgwqagwDW0MgNRwN1NpoTAu7ARanjcY7iowd6Rec/pjacd
 ZuWei8/hl/uevHh+UtSCpXk7LD4y9A1mHMPOa03rtJvB2v0uH35f3DsKxH8MWDJE
 EcyWASk6FYfFdHbkobCpLwuRLN+8C0qJomi5QjpGkUr3T907JCHAy55CfZ9gt6lm
 seLVGgaF2miNKYU1WLbRJk4TSwXpEj8SHXs4e5XqSBDK7ZtGUAoQ3MIMB7MZ55cI
 gfzz+A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy292c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:23:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70deaa19e05so129839576d6.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787037; x=1757391837;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BlRcy4ZxieFQ44suBlgaViaeJ+U8ll/tYwZA+brZVLo=;
 b=UuIap26oEhPQEo5AZtZH4CIWEm7nzFaEuvWoUzDODtmAwZ3znqo3cNtnBhynXHI7Lz
 ZOEmhouWNJRR/nqqzskVB2r2zARhMuq/p+yXX0FCypBaK1Gjc0FzF9ONZoDIHcSuskyf
 vy3Nw0Vd3ZPfw4dAXINBfcWawXFt4v0UkirHcVH2G6bUdpBEawIQb8o9HjHRkuVjUtYI
 XrzIiqUfWxWF6cX6wGp3B1huqzy5+7nPNXvfbkJP7NV5Cb/cBlI8r7nhTzi3riji33ZN
 7nuqq9O/jk4DJCX3k39O1lGWVrSVKQBhvp65CRJnlv5bg9YQgRvYhFkSMOrIADKMjS6x
 Vh9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAIYn4UlLfuYlAuyFLJWslOFaQHO8JDjAvNIeMH3ELfzzStvOxk2vcxM9PqPjybCoPX8hBF75qfwMs@nongnu.org
X-Gm-Message-State: AOJu0YwHq/txea8vxG0sb+zuQ17aqG1CKiOYKC5DKgtFttTG6EzS4G0j
 cprFXXYVE9V18FgIh7ag+o0uhfvnD9xT3gn3RPTNg1DZI4vp1RgT+BV6UNetKaS/djmEYoGS2CQ
 pOi5SK8c3Wi307/3sSHrycX6TiBAgo3uwLCyvD083ktFHjJwC4ez7i2LdUg==
X-Gm-Gg: ASbGncsOoadLUEFU16uHQPYeof1rihwVh8s0ZQZ+htHLlnjeik8aXvjG8elvg1CRVST
 1UIn6/OlWZtPe+Bh1vaIZgV3ILusttH5SHjNbuLEZHYAqs9Q/Wf19/WUwv2ioA2nsy5ttxbv7gi
 +CoZBVIfz3KEPvBcNeGiPKmtk5ztlyHsW5q+VlLacuuoZ4ulKG5YLLbjlJUFKzhhkL8AQ2VmpaM
 +4A0fWPR/0uzWcwbmLghTq59woUXbqoxgLcZG/fbpPq7Nj//xsgL8n3k3GDnA6avUj8SKBxHD7T
 o3FFEf/MEuE6QnGdfRvFkBDE09igKLpC5fwsqtlrgxxpBDTDhr6Cw8RSLXmtdg==
X-Received: by 2002:ad4:5cac:0:b0:714:f5b1:7c0f with SMTP id
 6a1803df08f44-714f5b17dc6mr96949526d6.45.1756787036760; 
 Mon, 01 Sep 2025 21:23:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb03p3XiJxY7UiOLWKDj41v8LgSqsQ+/5nTloDn7kKXyZhOMZzsxjH4aUaecC+XjxxMu7Udg==
X-Received: by 2002:ad4:5cac:0:b0:714:f5b1:7c0f with SMTP id
 6a1803df08f44-714f5b17dc6mr96949036d6.45.1756787035537; 
 Mon, 01 Sep 2025 21:23:55 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm17958390f8f.27.2025.09.01.21.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:23:55 -0700 (PDT)
Message-ID: <b39c6e1a-c8d6-4a73-aeda-d455ae840030@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:52:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/39] target/hexagon: Add representation to count cycles
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-12-brian.cain@oss.qualcomm.com>
 <017e01db9773$6ac9e0d0$405da270$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <017e01db9773$6ac9e0d0$405da270$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b6715d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=znjme_8SHt_api_xSp4A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4wRzdVD4ASNWBkMZUwErqlJtyFcjQLfV
X-Proofpoint-ORIG-GUID: 4wRzdVD4ASNWBkMZUwErqlJtyFcjQLfV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX8W9j0S0aznWy
 uuTzaoFXPTawVJLdzgXf/hBPrhBOfRq7g4nEoEJhAxmNmbNuKPoyF5seK8FpjaS8kZCY/p7D/3M
 1Qe0CuFLau4Tm8VF99kzwixoiArgSRRRvKoM58nI6QkoZYuVqT2NasCm6hu7/dVSY0BSjtgDZ0N
 uzcs/xJEF0lJzXVZsHZ4+k1l/Txi6ErwgmnHoMxSHqrbsdi08rnDoqS4bnIrcywueAln/YmNiuW
 KKv9R+cHtiEJyGlEp1FhibJfv5PkFytDibw3pibU+sZGcUmW187Eu+pF7+H5urxktr3CdP4odf7
 7sX3jmUH+Wi9gP5asIH9iVc0L5FrLhGQoTJuW/qHSxsGwr0GIB33HlT5HHMoM68yNIB4BUwPyvl
 mcSsNsOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
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


On 3/17/2025 2:33 PM, ltaylorsimpson@gmail.com wrote:
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
>> Subject: [PATCH 11/39] target/hexagon: Add representation to count cycles
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> The PCYCLE register can be enabled to indicate accumulated clock cycles.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.h     |  3 ++-
>>   target/hexagon/cpu.c     |  3 +++
>>   target/hexagon/machine.c | 25 ++++++++++++++++++++++++-
>>   3 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
>> 1549c4f1f0..4b9c9873dc 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -113,7 +113,8 @@ typedef struct CPUArchState {
>>       target_ulong stack_start;
>>
>>       uint8_t slot_cancelled;
>> -
>> +    uint64_t t_cycle_count;
>> +    uint64_t *g_pcycle_base;
>>   #ifndef CONFIG_USER_ONLY
>>       /* Some system registers are per thread and some are global. */
>>       target_ulong t_sreg[NUM_SREGS];
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
>> 84a96a194b..89a051b41d 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -335,6 +335,7 @@ static void hexagon_cpu_reset_hold(Object *obj,
>> ResetType type)
>>
>>       if (cs->cpu_index == 0) {
>>           arch_set_system_reg(env, HEX_SREG_MODECTL, 0x1);
>> +        *(env->g_pcycle_base) = 0;
> See discussion on shared resources.
>
>>       }
>>       mmu_reset(env);
>>       arch_set_system_reg(env, HEX_SREG_HTID, cs->cpu_index); @@ -396,10
>> +397,12 @@ static void hexagon_cpu_realize(DeviceState *dev, Error
>> **errp)  #ifndef CONFIG_USER_ONLY
>>       if (cs->cpu_index == 0) {
>>           env->g_sreg = g_new0(target_ulong, NUM_SREGS);
>> +        env->g_pcycle_base = g_malloc0(sizeof(*env->g_pcycle_base));
> Shared resource ...
>
>>       } else {
>>           CPUState *cpu0 = qemu_get_cpu(0);
>>           CPUHexagonState *env0 = cpu_env(cpu0);
>>           env->g_sreg = env0->g_sreg;
>> +        env->g_pcycle_base = env0->g_pcycle_base;
> Shared resource ...
>
This is captured by the global registers object in v2 and only the 
thread-local count is introduced here.

