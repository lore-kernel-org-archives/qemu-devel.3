Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E361ECA100D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI47-0001xD-5Q; Mon, 01 Sep 2025 23:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI45-0001uM-1t
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:52:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI42-0005Ch-Fs
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:52:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RmGx012352
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r4MaRpX8EF9o7MIq5Bqxmd8+XlT18JYswZtoTOVoCYs=; b=KjvfQRXxktadKZ1D
 Lyw+R+pv+xz85+LyMOY+hNYoj/GqvmgY79YsIJ+HAm9Q0rTvhmIqNpN+RpuBf4Sj
 XbjlXA6eRMA+v5CjH6fB9uxIeXiVXgnD1WYNAHoggIz2BIZv7dvA26QutdqnJt4w
 Sk8vR7an4plYkkEVcSbn3IHQOsOhOLCwgAcf/dhvIx7njZBhjQau5lEInL86qXeZ
 f5ZMfLbWAKTnhKDm3TXYwlyUWxl1cnI+us6G5OM55uGNpuLxXFn67wrT3YrTKZyn
 PfdpRQH0i0KRbjkCaH45rhJGh3DwJXdR+JSoP0M6XC73Pyq/RhkbkeyFaZLuvEoL
 JEHZGA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2feac6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:52:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2445803f0cfso63112905ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785128; x=1757389928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r4MaRpX8EF9o7MIq5Bqxmd8+XlT18JYswZtoTOVoCYs=;
 b=HpEkDghElGg3hiRTNNaDTpbIWc+5tWq9zOTektnoFMQ6clWYDJy+6uQisvRIE34yZT
 orT5rNRI3F5/PHFRMufZsAjZAEV57nw7AaO+OIpFTxzYREJ2TpnC6O5Fa68eQSWW73sU
 /NDE/TXDGmzwjDP/jC6pW298xdepRbcEvJnNnNIMNQtJRD/WSxSjnzUEy3MCSNlK0ade
 iH/yPZPmrKqzPVGIgcEMAxfvhr4btfWdkySMzZnoNkEkqgjV2T6i1NUx5FHLvhuDqmOj
 C/0EV+c0hcnj4rV92jLFx5N8xnN6Hh9qtT9oexo8Vdb4U2+CmmmoOsUCzG4Zdo66Ffl7
 0H6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeBY6wNO9pPsgnDqBIg9LVwcfZTFQbf//AtxqMjAKfauV1mR+kjOv5r7Am5HOYgQBH07OkgzrzTMiU@nongnu.org
X-Gm-Message-State: AOJu0Yw+eET9sX96sSIywqJehBk+4Qr3JvFn1LNC4YTJOSy/LvDBhKFC
 sr6reur+ptRQUBrk28sokmbpPV8jxkeP8/tpbAUXvQQDg9Bg5ETeJsFpowcrD464feyP54w2G3G
 1Yb5OF/5FZfk9ej2986eBPDLVLtD5ojOjqX07Pq6dUV/Y6cTa5M8dZuUAGQ==
X-Gm-Gg: ASbGncsQjmWSJ9zmu8NjkGvxE+IIh6d4rGPAls+GEn/ais0CRW/ePOt7JauV321faI8
 qZAxxm2/KxsOiiENv2ZG1V2KIYjWsANilxsDKhrs3HFP7YPikdxPgdxYpEx1J12qxGdv6xW4+2i
 i8YN7cxvuc9v3E6elwxp/aJTGSd3Y4ECkm2RxeLQ603vE30+NpIOXoHY+qwBOiqYAA99FgmTY/5
 SFHzW5ageI9V7bi5zD/2hSM76prPf6ut92fUvWPuPfanwRGueMDW8miWA7huUl60KlVY++8NJzt
 hu/3sqFiqn9wULASqVLAIi1FS1Nm7ye/dPIxJLVGHc9jlao+yJGZl9/4PWWlTw==
X-Received: by 2002:a17:902:ced2:b0:249:1440:59a6 with SMTP id
 d9443c01a7336-24944b0dc4dmr137619075ad.33.1756785128245; 
 Mon, 01 Sep 2025 20:52:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7WYoSeavLNZ39l6WFb9WxFsJArz/74jGytCTsF3hQSmLItqhrq7RGsytpTSha9avBw+yh2Q==
X-Received: by 2002:a17:902:ced2:b0:249:1440:59a6 with SMTP id
 d9443c01a7336-24944b0dc4dmr137618295ad.33.1756785127108; 
 Mon, 01 Sep 2025 20:52:07 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119295495ad.45.2025.09.01.20.51.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:52:06 -0700 (PDT)
Message-ID: <82ff4ffc-a1a4-4dc6-837e-a319c803c9b8@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:27:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/38] target/hexagon: Add guest, system reg number state
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-10-brian.cain@oss.qualcomm.com>
 <802e6fe2-1c76-42c9-88ab-eb8239eef569@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <802e6fe2-1c76-42c9-88ab-eb8239eef569@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX2AvAwFISaKbr
 gz5oTO++hf2BHnTDwBV8wCOt3zmjYwl39udLr3FEGabXeUPpZpYTdegvwHdI5zeaivno+tqHaV5
 CV3voXNOePBCyyNa58vePWKu5HVHKxeHw7HyY3XNJJffLiiXMM/lbO9wrnFnSOQNKg9SX4YBPLp
 E77leHmyTM6XV8EfTK1bt8MsDJD7Kk3Riz72fCsXrrzl0LS5xcdj90UGqOJcjqiGE1aLLqXeNYm
 H4db7DaVEL+PeQOwFvg6J5eHXcoVYikfn7U1X1HLqYxlu0YIMqCjVhgSVOm1byXLYGKOBP4rOOc
 JVe3jNCK4BK6unJPR0XkLPbA3vx129RRkjI2qtDsu8s+GSvXPzQvCfONdh76txCusVjJDdfK5NH
 5OGjAvMj
X-Proofpoint-ORIG-GUID: BXpMZXnZgiOjPRB17FTrGB-mHsNRDous
X-Proofpoint-GUID: BXpMZXnZgiOjPRB17FTrGB-mHsNRDous
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b669e9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=_NB7oWaHVQA8DE6N4KcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 3/12/2025 2:15 PM, Philippe Mathieu-Daudé wrote:
> Hi Brian,
>
> On 1/3/25 06:25, Brian Cain wrote:
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.h |  8 ++++++++
>>   target/hexagon/cpu.c | 17 +++++++++++++++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>> index 20ea0adcca..b7789a3c90 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -82,6 +82,14 @@ typedef struct CPUArchState {
>>       target_ulong stack_start;
>>         uint8_t slot_cancelled;
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +    /* Some system registers are per thread and some are global. */
>> +    target_ulong t_sreg[NUM_SREGS];
>> +    target_ulong *g_sreg;
>> +
>> +    target_ulong greg[NUM_GREGS];
>> +#endif
>>       target_ulong new_value_usr;
>>         MemLog mem_log_stores[STORES_MAX];
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index 0b7fc98f6c..355e1eeef3 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -288,6 +288,14 @@ static void hexagon_cpu_reset_hold(Object *obj, 
>> ResetType type)
>>       set_float_detect_tininess(float_tininess_before_rounding, 
>> &env->fp_status);
>>       /* Default NaN value: sign bit set, all frac bits set */
>>       set_float_default_nan_pattern(0b11111111, &env->fp_status);
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +    if (cs->cpu_index == 0) {
>
> This doesn't scale to heterogeneous emulation.
>
>> +        memset(env->g_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>> +    }
>> +    memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>> +    memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
>> +#endif
>>   }
>>     static void hexagon_cpu_disas_set_info(CPUState *s, 
>> disassemble_info *info)
>> @@ -313,6 +321,15 @@ static void hexagon_cpu_realize(DeviceState 
>> *dev, Error **errp)
>>         qemu_init_vcpu(cs);
>>       cpu_reset(cs);
>> +#ifndef CONFIG_USER_ONLY
>> +    if (cs->cpu_index == 0) {
>
> Ditto.
>
>> +        env->g_sreg = g_new0(target_ulong, NUM_SREGS);
>> +    } else {
>> +        CPUState *cpu0 = qemu_get_cpu(0);
>> +        CPUHexagonState *env0 = cpu_env(cpu0);
>> +        env->g_sreg = env0->g_sreg;
>> +    }
>> +#endif
>>         mcc->parent_realize(dev, errp);
>>   }
>
Redesigned with an object to hold this common state instead, in the v2 
series.


