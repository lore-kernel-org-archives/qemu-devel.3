Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32783CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqF6-0000jZ-SH; Mon, 05 Oct 2026 17:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDqF4-0000it-GX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:29:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDqF2-0001Rt-T3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:29:02 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KNGAb2990374
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 af+NkhFH36FwHYdOnFC9W4FkClMSN5WpJ4t9D+KxjDQ=; b=JwZJHrIahQBn+R8U
 JLn8pzNepSYvGubePH/a3Ls6ipDgYvUfc7xmXlg1sPsA+xx1FNv077DP0wOOsu+I
 xIzclbR3k8zNA1A+YIBh/y8iAZ8IRvomAk0Xpm+5vHfLvlCISHCaK0zGZ3Nw0W5r
 yFwt1Hcoxf7//C494gDAmp3FyZ9VOZaX1c7j6esFYsOdEAIkPun/YZMycTy6hdo1
 ZdeXVWFc8D/iB7intc8p4/XNt9WXy729Tjg/Ubtfx0FI1jzSyfLzZzyeUZXr16Da
 SQMtXLm8JpRdsNvPENGdAdlcXiYygtChlTJ4MdqNzFXZagghh78zRDRLVtDUM8pE
 YhjelA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr3gpuf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:28:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5351f1b26e6so32552341cf.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791235738; x=1791840538; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=af+NkhFH36FwHYdOnFC9W4FkClMSN5WpJ4t9D+KxjDQ=;
 b=dj7NqMVoO+zB/nH7Gs8grLQmZpQjsZTTY7x3952LysEWe7pF8NlrISBv9PShmtfgfV
 t6TGgk9Otb7BY+lel2N3Ig9Nfp7YUw2+Mnsp4qnIM3WGqQudGwU9hsFiThdt/FBeANd1
 Q+/jIjcmXSW51X/pfWU3UN7KE8IBEgZKoGwVL5C8Cg+B0VzVVqzx54caE4vk+7Eux7fg
 p5+jkEI6dDMwK4zeaQNitOWF7bf97ehBNrPh0/Rf038aeoYB9kqZSN1bpGTdYBAQUOMq
 urk6rwYvEqov+rZlJ8Rv61V2rhVCGJCAsnFs2XSD/r/luv6cw/AiamJJNkyOqchCJePV
 Lckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791235738; x=1791840538;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=af+NkhFH36FwHYdOnFC9W4FkClMSN5WpJ4t9D+KxjDQ=;
 b=Wm3J1UhsJ/v+Z2oe8H7wtQaoTIhxn4xoU5yPczQdUzLgE84YsSMEuLrSWyPa5TP5fa
 BAIn0vRZDOHj7lRAMENmdCybIOJot2LqD2g1svX+TiD/xyqljUgUYfjODGtsFo7haIt2
 nWA6uFrXexjyr4eKpwXSQ7uBlposVekmyTXEfWM1+BNn0qn5FNxVVWpJI1hSoQDQotkv
 x3KaO2Ca3S0bmcXIkr7eVkxIhM0d+KXfZ0OEVfkzGOLqOZTdi6AOPGFnE4O+Sc/EnElv
 94hHhIKMZgznyIS3Plt3JrLF4ZLZeB9lZq5HeOc4Q2R9nnJMrwy4dxCXVABWOF9/zPE8
 tXqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2asdH+ZiAQjhTlSE0+o4ShOVepkomSocjFLUPHYjAasxFcMduNwDpFS5fW37rSO2y+R8JQz66Fexf@nongnu.org
X-Gm-Message-State: AFuF++lLed/QCnY9IaqP9fqfLXuhvoOmuiRFgEmMvp9E3GGyBzTZbtnD
 hRoCpMiwugLGkecb3QiKRVgUYNvHd3UPKzJnn+6iYVFsIo2YAe0tU+wDbVGDV08RjcJdk0Y4kDM
 e+mV6Prk0hxaotsDq0celJTTys7v8LUiAJ06AgW/sEcfejt8wKFjUaLlZI1tpQGKfMQ==
X-Gm-Gg: AYBFou2ERUhV/qMGXPqcWwrUuQiq+VnNyaGGhz0EkVwaElW2el3PX8Qgiim9GfEe5ep
 /gEQvCO2T/QTVi03EOV1cEkc+GYo8mUmh3XZpViPmDbCLWFpJVOWF6CxQghEVY4tmNqmT+jnuhN
 2q+15EdTjdTWnSZrPTgZ/orXqgXAV4bIW72g+2iyHKhJxZbLeaWQvTJlvBsYjU0NTRNsJxRbiOj
 GjSW3gf2WXMJhH54MatxxFBLbkJo3/u2QggtKGHUzoi6HUEiFBhQ2CJ6ke/BVkpS/W8KtEeAT/c
 QQpDkILPbPlDYxRkMBeMMznFk3JTEnN4HLNrpEeX/novSSkJaI/7kwE+yrqvzOKltVYHxb7mzg4
 HgJCNJy7vgqnIj6e9cJXANK2/BSPEQdJWgbIR5yXCikmxuAYYAnBNJZT3Vm1cePL8A5lbZ5umkr
 U4VAM=
X-Received: by 2002:a05:622a:1b8d:b0:535:14f9:3f02 with SMTP id
 d75a77b69052e-53514f94888mr147142841cf.58.1791235738248; 
 Mon, 05 Oct 2026 14:28:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1b8d:b0:535:14f9:3f02 with SMTP id
 d75a77b69052e-53514f94888mr147142541cf.58.1791235737705; 
 Mon, 05 Oct 2026 14:28:57 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398a5c100sm104538791cf.7.2026.10.05.14.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 14:28:56 -0700 (PDT)
Message-ID: <6c2b3716-e2cb-487d-97ec-af4951eaf8b6@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 16:28:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: yield on system-mode pause
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
 <20261005194519.2945862-2-brian.cain@oss.qualcomm.com>
 <c87183cf-bb24-42be-a51c-d700ff6b8a1f@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <c87183cf-bb24-42be-a51c-d700ff6b8a1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lNc0ENEU2Mz_Tb53LO3LEpJNJucpY4uu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfXxLkCui6VY4N6
 YbpT2W6efewKYnhou/G0s6RFHr3Ucikk97E3sIHuJxN3zloMCJr9e2DeWVITS6XqlUfKB54iO3t
 +0NLxjMQJQXtoDeTafnJb59r2H2Qo+E=
X-Authority-Analysis: v=2.4 cv=PNWaavqC c=1 sm=1 tr=0 ts=6ac4169b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ed72H_7bWkcdhNqR0LUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX4Tcd5T7+PQJe
 WQkW56BfiZo6OZZv3KoC12wLX5VsMb/qj8sehb86/rfycATv6ZQCdEuU2yv/S9s6CRHzr2bu/pj
 fgV7FCPDKMVdGWSB8e6jIth6tRHxAvEQ/l6D4fp6ovNZMPSzvUfBdpHczvK5RdtkPf1VrpKg++w
 iA5WAZ6FMYE0hTHG3gZ3oBwYogvDt2ZddhJsHc30uBf+gaRyOScCeIonMa8SsVMsUyZLVI6tg0+
 2xDSm+GTP/LKcPli1Z7OCS/5Q1oOsd/cMSKFSiiD4k/3YthDvwBkkZ8DmCnC2EBVZfGre7+x0j5
 eaTZnFEX9mERxj+2j6ighK/DXcFMbirFjYd/exK0qL/t5ji5IjFvZER621OxjqqQNRGaPbQywmQ
 0UUcCo8NsizMcotj+slkQJSJMchImt4u17A5Cj2jN9N/N/46bGnKo5Ied9NQYO/qIr8+UN0xm1C
 Y3IOTZsSxjHaFX+z0Ng==
X-Proofpoint-GUID: lNc0ENEU2Mz_Tb53LO3LEpJNJucpY4uu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050084
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 10/5/2026 4:10 PM, Pierrick Bouvier wrote:
> On 10/5/2026 12:45 PM, Brian Cain wrote:
>> System-mode pause currently advances the PC and continues execution instead
>> of yielding the vCPU. Raise EXCP_YIELD with the next packet PC so execution
>> returns to the CPU loop and another hardware thread can run. Keep the
>> linux-user behavior unchanged.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/gen_tcg.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
>> index 5f7df66ae67..80d8a7b6bac 100644
>> --- a/target/hexagon/gen_tcg.h
>> +++ b/target/hexagon/gen_tcg.h
>> @@ -1125,11 +1125,21 @@
>>   #define fGEN_TCG_Y2_break(SHORTCODE)
>>   #define fGEN_TCG_J2_unpause(SHORTCODE)
>>   
>> +#ifdef CONFIG_USER_ONLY
>>   #define fGEN_TCG_J2_pause(SHORTCODE) \
>>       do { \
>>           uiV = uiV; \
>>           tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->next_PC); \
>>       } while (0)
>> +#else
>> +#define fGEN_TCG_J2_pause(SHORTCODE) \
>> +    do { \
>> +        uiV = uiV; \
>> +        gen_helper_raise_exception(tcg_env, \
>> +            tcg_constant_i32(EXCP_YIELD), \
>> +            tcg_constant_i32(ctx->next_PC)); \
>> +    } while (0)
>> +#endif
>>   
>>   /* r0 = asr(r1, r2):sat */
>>   #define fGEN_TCG_S2_asr_r_r_sat(SHORTCODE) \
> How is this working at the moment?
> In system mode, if a given cpu never really yield, a given "thread"
> could keep it spinning with a busy loop forever.

The wait() instruction is the instruction that 
halts-until-an-interrupt.  That instruction has a working implementation 
already.

This instruction, pause(), resembles the x86_64 pause / arm yield 
instructions.  It delays a number of cycles (based on the reg operand) 
before continuing execution.  The baseline's nop behavior is arguably 
fine/correct.  But this behavior is better - especially for round-robin.

In practice, few if any of the tests we're running so far make use of 
the pause() instruction or spin loops.  But some of the 
soon-to-be-enabled tests do use it, so that's some of the incentive to 
implement it here.


