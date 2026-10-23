Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9A606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bA4SvZgA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bdxLaUdo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKAfA-0002s0-0R; Fri, 23 Oct 2026 04:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKAf8-0002qc-HM
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:30:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKAf6-0008QC-Ds
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:30:06 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7F9o62067801
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uRPtzOed2eut2LAi9V8d057urYaQFVRFtDDTS4Ca6yY=; b=bA4SvZgAUWz7DfdY
 E99TDDLuOgBe23M6jBc0zLG5MWZEEQAqwffExseOuvhXAGmsUkOvptUZ/zDJlHm3
 U2vFQiHqkMYfLsxISzxC06AK8vGO7eSYU8KNbydmahwRF9VwOMFEmYwDMsjOXPsV
 VS2tiTUsVCplgPy7sNtKiRd6eSro8a4mm66BndOK8roduaSKhP5MArgjYSmBS7Gu
 2bWOCppgHStZod9HPBgoAEfHx+s5o3RazvG2tSyxW5DzLpQ1aDMsszEpH1tTD1c4
 lMdJCYOWIpMYjPb+64aW6Q8ipwlSYZKOyDArO79r7DaD5jsyo1TqrZBdJK1YpOag
 s1jh6w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw389j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:30:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso77298085a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792744201; x=1793349001; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uRPtzOed2eut2LAi9V8d057urYaQFVRFtDDTS4Ca6yY=;
 b=bdxLaUdooRS2lwr2xV+rAHibCEWv7eig6+1HoaOVuzUkwB9onJIiHDDHw9ALaB/5Jw
 9C8AI+0QyqLmcxREV5iFTAHgkSy9ogn/qhKqB4l2fI9vUTzCcLr9yZ2XZoQcWbq6mOqR
 dkKmkw1Wr7YLdleVLr+aALHM92PqhwSd8raeA4LTUd8aB3nORpF0Rm/gZnRkQ3X0GYgR
 1qCCVaYAx7aEn2CSYU0jljDT9luoU3BYLE+psgkHWpzikBkFwZSzI1CJe8R10n00ifbI
 SvfpvDiOdiG9oE92DnBvpva2Zt8i9NNc9rb79lPANopyDxfEgI6B6DZmvGto/YF71KsH
 9kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792744201; x=1793349001;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uRPtzOed2eut2LAi9V8d057urYaQFVRFtDDTS4Ca6yY=;
 b=DbaRkGs8VthfaGAdd9H0CCe8DG1oYwpVHHrANEbArL/1fEg5U5fRrN3qnYaV3y2bmZ
 GbhJnJfNweQe42/HIjjK1qU0A2oUkNHvUNLjTAkD8e6wJ5I58KTcIFP4hCEUTa9qh6p3
 PTEW/SZEpjimTTW5RF26v8NEFRkddqKFhUKwfOA8w7A5v+MrmkM7D7bJmV/J09wRhATf
 HDc1/voUcz8QCA/Ok//xYYDCg+S702RWt7EjJNdRszqsgQImN6tTd7p/UNdEZyziaYhJ
 2zKc7MxmtdkBym0RU277jjJoMEZxgfOTTO9H86AeaqDVPTW8LajyjEnM8ggM6hkQmeXe
 voBw==
X-Forwarded-Encrypted: i=1;
 AKwUvByIeAPq6BHdIq5R9Ikgu750fTFPDIKhEG2txVdA0wxTZqIm3iotH9aLDmRchWibrN57BCoLH8y6VhGz@nongnu.org
X-Gm-Message-State: AFq9FYLUmp+dJ47HKscvQzRDMiYhptvusm+lvEyFdrJ0LMKppZQWqLpm
 6mWQV+aJGho2Z4REL5mlYsFIUmtYrXrvrsAs9O7+UxE4AHQ0f8Cn0linW8Yre/Q4ZyHdjNOvdWR
 oEJ3EZMZhx8tZPDFMH7wcl7yWGmNuXueLLPOKgEA/Q9XsGypSUPw+IWokAg==
X-Gm-Gg: AYBFou3dY2ZHKCEnH2H8lNjoJiUr6qCQ/PEsx0+IQIpcwcO/gck5A8eZ4a7Lgf47h9U
 XhCTKS6zjJpDlinNopR0Xk9xCvEucVU+fJeZBn63vqWcyh4Y5kt2eRqwRpl2Nnh4t3wyE0jfWGF
 ho//l8Y/GDulUMUHjs3u7Dme75dy0jZ2eO9fV17NRpq+laxLeaatbaRvqjvi4BHGxISXktFeLLR
 BE7Bkcsc2VRQxJhGInUEonx09fhch0f5H8DDiRCA1nJg344SZ7TPbOKgbz/v6F/7mzGKuTa4ugy
 oaN/BgxOstUO2g97CthYxT3YwmEaNxl+4c62up8sz6s7Oybs9cMbcVo/Hozacg+ha7uMRG03cPK
 y3kQ3u7Z1Pn0wYXR7+nJALmHuKthJFQoW2A==
X-Received: by 2002:a05:620a:4042:b0:93f:47fa:b72d with SMTP id
 af79cd13be357-93f6f950d44mr274320885a.35.1792744201305; 
 Fri, 23 Oct 2026 01:30:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4042:b0:93f:47fa:b72d with SMTP id
 af79cd13be357-93f6f950d44mr274317585a.35.1792744200729; 
 Fri, 23 Oct 2026 01:30:00 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21046b92esm53830965e9.10.2026.10.23.01.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 01:30:00 -0700 (PDT)
Message-ID: <fd74aa6b-9724-40a5-8a6a-54d7927307f8@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:29:58 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix CPU state access on big-endian hosts
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261022130657.6449-1-anjo@rev.ng>
 <3d9baf66-d412-439a-b9db-099124af6625@oss.qualcomm.com>
 <8299629b-7033-485c-8204-521e14e2f1d8@oss.qualcomm.com>
 <a7eb7b51-55ec-49e4-a4cc-209c41236c91@oss.qualcomm.com>
 <ee2dfd4c-b3aa-4157-a918-560895048422@oss.qualcomm.com>
In-Reply-To: <ee2dfd4c-b3aa-4157-a918-560895048422@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qfl_HKJ4Lvc33IUm0MvN5UQrT_Ix7Hep
X-Proofpoint-ORIG-GUID: qfl_HKJ4Lvc33IUm0MvN5UQrT_Ix7Hep
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb1b0a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=DmNT2s-IBJwF5WHCG1AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX2YZfDCsWGfkh
 v5FNPjekFoDASROMO7s9ZNFYsQyN14hslhobjN/gZO7IcvkHNf6hZFyJSyWEZmk/9cIrOVB8p8N
 8Y29Wxtn3mhdN2+5YRTafC1E0BqmaNE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX0qWvkM/h0KIr
 NbxlgJL7vxi0122yWvZV708U8b3YWM+jj2d10WuZk5UBG5gUqJN+NCiYBXXk2A7shXATyZGlm6e
 lOafryi4yKRXF7jEIaBQavL79opAMCYFHNBj3aQCI87W2evc/YRSW6g7mm5Tk9Wh8SkUO5HgtAP
 UOt2IHu/8lr+/eA4nJca31JHH/PdEqRUDnDuw4D4DS/Sx1tRmXLkT0eUNbKMidsZmkXr0mCZb0n
 HOemKHTAlahaZJrHXhQ4chwQ+0wtNe728+3nyAs2/cBPfDauW3HaCSja2gQwhF49Yk4+Ko0CNJu
 u4VMffCfhDD4eDvvrDJWo5h4349fNpBAJ90NhDEkbThPd2uwGYiFQT/8lxLILEsqjBesK4mtjQz
 QWTK6vz5N2s+43tKIENMQETncMpTh8U+os8YFCJWI1OlibAeES2yW1AMH2SeTyEspHI6ZR5ZHvs
 pUigRDjevtH888ofAtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26 10:10, Philippe Mathieu-DaudÃ© wrote:
> On 23/10/26 10:07, Philippe Mathieu-DaudÃ© wrote:
>> On 23/10/26 09:53, Philippe Mathieu-DaudÃ© wrote:
>>> On 23/10/26 09:37, Philippe Mathieu-DaudÃ© wrote:
>>>> On 22/10/26 15:06, Anton Johansson via qemu development wrote:
>>>>> mstatus and mstatus_hs are uint64_t but accessed through
>>>>>
>>>>>    tcg_gen_[ld|st]_tl(..., offsetof(mstatus))
>>>>>
>>>>> which on a big-endian host running riscv32 incorrectly accesses the
>>>>> top 32 bits rather than the lower bits.
>>>>
>>>>    mstatus and mstatus_hs are uint64_t, but mark_fs_dirty() and
>>>>    mark_vs_dirty() update them with tcg_gen_[ld|st]_tl().
>>>>    On big-endian hosts with 32-bit target_ulong, this modifies
>>>>    the upper half instead of the lower one, so the FS/VS dirty
>>>>    bits are never set. Use 64-bit accesses instead.
>>>>
>>>> Cc: qemu-stable@nongnu.org
>>>> Fixes: 284d697c74e ("target/riscv: Merge m/vsstatus and m/vsstatush 
>>>> into one uint64_t unit")
>>>> Fixes: 8e1ee1fb571 ("target/riscv: rvv-1.0: add translation-time 
>>>> vector context status")
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>>
>>>>> Widen the operations to 64 bit so the lower bits are modified.
>>>>>
>>>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>>>> ---
>>>>>   target/riscv/tcg/translate.c | 32 ++++++++++++++++----------------
>>>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/ 
>>>>> translate.c
>>>>> index ede9c2563f..79b0f444ef 100644
>>>>> --- a/target/riscv/tcg/translate.c
>>>>> +++ b/target/riscv/tcg/translate.c
>>>>> @@ -693,7 +693,7 @@ static TCGv get_address_indexed(DisasContext 
>>>>> *ctx, int rs1, TCGv offs)
>>>>>    */
>>>>>   static void mark_fs_dirty(DisasContext *ctx)
>>>>>   {
>>>>> -    TCGv tmp;
>>>>> +    TCGv_i64 tmp;
>>>>>       if (!has_ext(ctx, RVF)) {
>>>>>           return;
>>>>> @@ -703,15 +703,15 @@ static void mark_fs_dirty(DisasContext *ctx)
>>>>>           /* Remember the state change for the rest of the TB. */
>>>>>           ctx->mstatus_fs = EXT_STATUS_DIRTY;
>>>>> -        tmp = tcg_temp_new();
>>>>> -        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, 
>>>>> mstatus));
>>>>> -        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
>>>>> -        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, 
>>>>> mstatus));
>>>>> +        tmp = tcg_temp_new_i64();
>>>>> +        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, 
>>>>> mstatus));
>>>>> +        tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
>>>>> +        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, 
>>>>> mstatus));
>>>>>           if (ctx->virt_enabled) {
>>>>> -            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, 
>>>>> mstatus_hs));
>>>>> -            tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
>>>>> -            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, 
>>>>> mstatus_hs));
>>>>> +            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, 
>>>>> mstatus_hs));
>>>>> +            tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
>>>>> +            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, 
>>>>> mstatus_hs));
>>>>>           }
>>>>>       }
>>>>>   }
>>>>
>>>> Wondering about being safe (or catching other bad uses)
>>>>
>>>> #define TCG_ENV_OFS_(f)     offsetof(CPUArchState, f)
>>>> #define TCG_ENV_SIZE_(f)    sizeof_field(CPUArchState, f)
>>>>
>>>> #define tcg_gen_ld_env_tl(ret, f)                               \
>>>>      do {                                                        \
>>>>          QEMU_BUILD_BUG_ON(TCG_ENV_SIZE_(f) !=                   \
>>>>                            sizeof(target_ulong));                \
>>>>          tcg_gen_ld_tl(ret, tcg_env, TCG_ENV_OFS_(f));           \
>>>>      } while (0)
>>>>
>>>> #define tcg_gen_ld_env_i64(ret, f)                              \
>>>>      do {                                                        \
>>>>          QEMU_BUILD_BUG_ON(TCG_ENV_SIZE_(f) != 8);               \
>>>>          tcg_gen_ld_i64(ret, tcg_env, TCG_ENV_OFS_(f));          \
>>>>      } while (0)
>>>>
>>>> or even using _Generic:
>>>>
>>>> #define TCG_ENV_FIELD_(f)   (((CPUArchState *)0)->f)
>>>> #define TCG_ENV_OFS_(f)     offsetof(CPUArchState, f)
>>>>
>>>> #define tcg_gen_st_env_i32(arg, f)                              \
>>>>      _Generic(TCG_ENV_FIELD_(f),                                 \
>>>>               bool:     tcg_gen_st8_i32,                         \
>>>>               uint8_t:  tcg_gen_st8_i32,                         \
>>>>               int8_t:   tcg_gen_st8_i32,                         \
>>>>               uint16_t: tcg_gen_st16_i32,                        \
>>>>               int16_t:  tcg_gen_st16_i32,                        \
>>
>> Hmm tricky (dangerous?), this also change our current uses of
>> target-long accesses to smaller fields. This is how I'd expect
>> the uses but not always what we have now. For example, commit
>> ebc9401a406 ("target/hppa: Split PSW X and B into their own
>> field") reduced CPUHPPAState::psw from uint64_t to uint32_t,
>> but both accessors -- trans_rsm() and trans_ssm() -- keep
>> accessing with tcg_gen_ld_i64() instead of tcg_gen_ld32u_i64().
>> Likely buggy wrt endianness.
> 
> Noticed because the coccinelle conversion now triggers:
> 
> ../target/hppa/translate.c:2367:5: error: controlling expression type 
> 'uint32_t' (aka 'unsigned int') not compatible with any generic 
> association type
>   2367 |     tcg_gen_ld_env_i64(tmp, psw);
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:30:14: note: 
> expanded from macro 'tcg_gen_ld_env_i64'
>     30 |     _Generic(TCG_ENV_FIELD_(f),                                 \
>        |              ^~~~~~~~~~~~~~~~~
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:15:29: note: 
> expanded from macro 'TCG_ENV_FIELD_'
>     15 | #define TCG_ENV_FIELD_(f)   (((struct CPUArchState *)0)->f)
>        |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/hppa/translate.c:2387:5: error: controlling expression type 
> 'uint32_t' (aka 'unsigned int') not compatible with any generic 
> association type
>   2387 |     tcg_gen_ld_env_i64(tmp, psw);
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:30:14: note: 
> expanded from macro 'tcg_gen_ld_env_i64'
>     30 |     _Generic(TCG_ENV_FIELD_(f),                                 \
>        |              ^~~~~~~~~~~~~~~~~
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:15:29: note: 
> expanded from macro 'TCG_ENV_FIELD_'
>     15 | #define TCG_ENV_FIELD_(f)   (((struct CPUArchState *)0)->f)
>        |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 2 errors generated.
> 
> 

And using these macros on tcg_global_mem_*, another issue on Hexagon
(slot_cancelled is u8 but registered to be accessed as u32):

FAILED: [code=1] libqemu-hexagon-softmmu.a.p/target_hexagon_translate.c.o
../target/hexagon/translate.c:1472:26: error: controlling expression 
type 'uint8_t' (aka 'unsigned char') not compatible with any generic 
association type
  1472 |     hex_slot_cancelled = tcg_global_mem_new_env_tl(slot_cancelled,
       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1473 | 
"slot_cancelled");
       | 
~~~~~~~~~~~~~~~~~
/Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:160:37: note: 
expanded from macro 'tcg_global_mem_new_env_tl'
   160 | # define tcg_global_mem_new_env_tl  tcg_global_mem_new_env_i32
       |                                     ^
/Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:52:14: note: 
expanded from macro 'tcg_global_mem_new_env_i32'
    52 |     _Generic(TCG_ENV_FIELD_(f),                                 \
       |              ^~~~~~~~~~~~~~~~~
/Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:15:29: note: 
expanded from macro 'TCG_ENV_FIELD_'
    15 | #define TCG_ENV_FIELD_(f)   (((struct CPUArchState *)0)->f)
       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.


