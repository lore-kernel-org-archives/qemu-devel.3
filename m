Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478FC606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WLHiu5bK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g934pxps
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKAJK-0004xT-3L; Fri, 23 Oct 2026 04:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKAJH-0004x1-W9
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:07:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKAJE-0003yi-Lj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:07:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FM7K1048165
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R0A656Y1+s0+aeKV5VIzISKXuk8vI1XyENwBBYpaifM=; b=WLHiu5bKfOepq8tK
 bHnto3tg5Um1ZapcGwLRKnYc3AX0JYEsB2DFPazMn8FyHCtCWpfv3knF2GCm4Wq9
 sXRs2Rq0RZROCO8CS36lJDn4Tc6utO79YFPaOc/ghv1CK49zfxMKO0hxp2oYeqMs
 +7hkXxwSVVPVk32zq1XZ7LLJshlOKDnWyD1sk9HoqjtKKmht9wMbkslXzPbzNOKq
 /0/0mCSG85XHwx5iLih8lqioUbn4dq/sqSHiFrdrdGXK1XzkbHzjXUdDSORfABkm
 J/Cj7hOBMAX0LwwPv8lBVPXdfxnlMdTo2lG6KLJQhP837t2r0asxztdeJpzuku5T
 4kNXqQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbjpes-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:07:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2c0e6653so113504185a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792742846; x=1793347646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=R0A656Y1+s0+aeKV5VIzISKXuk8vI1XyENwBBYpaifM=;
 b=g934pxps9qOrNfWVX0h0xZeEUWmP6F3ft+fSNXQ+n43sAP+IQhYwhCn/DnaVzpBssw
 1YBXS7Yy/5j2XBO1E8TY+ISzVMRXYj+vX3P/B/2Q8J3bdtlzwLdQZGYvOFwFFVH74DSR
 deBAodfTv3Cv4x1673h86qATtsjVJen/NrziufigLe8yl3GuyuYWSGSEph30PdXX4/un
 B7z/XPRxJm5UTCkqo7fkK1rAEt7SXFJfUAKituDVY/7t91y8ekmEwv+Qhea3t5plhEAC
 ByT077reUt6ssB0QpJzqu/Ce/G8NOqimDjTL+D2hn0lSLo5/stWfEAGX51GTEFJIL5kn
 xSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792742846; x=1793347646;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R0A656Y1+s0+aeKV5VIzISKXuk8vI1XyENwBBYpaifM=;
 b=Nqw+zeN6aFwNzuw2Btmvo+Kx6yZ6cBinZQoJ14mzP0ehF2CJTT+cBLWL/XFWa/JHv0
 ge7TrwbO5xT5pQc9nyuc+5aP3Uh4FE+taYS7S6+Tup9+LMBwqOSq9TooMtej0EpIig3u
 9y8UV77dI5DRLxzomLxmMZ7ShFfn/XPPVDzl03gLD+7k73/6Z9XAvDchwrHsv90bT622
 SvperU832oXSDO7JNVqFmvVQ+knedX7XTeVHU3ytwnklOsmb1pviWud2JpQ6Cih5q2X/
 di8L1Ug5sHAQpH1+uUPpY0AZ0x+qbxoBAuTL9fKmDVCcMc/jzwVqdb6X5yZOMVQFc21u
 vE2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeFkkXe/15yI3/XL7SFLr5eWkq2Ik6jC48kN9jnuTSmTx5g/ooMRELFvasSQXFQwuTonf31rvkc40d@nongnu.org
X-Gm-Message-State: AFq9FYIHMBwsTSX378LECjoXsQMWDCeyauSYAWGZj09BPeWUlr/S+fWt
 hm1e6yw7rvjyin/J9o81sim7+eeyU2/wQDpmmA/VXHY2kGwQKM+GfXVOVCbgKedvPGqAX37cOkA
 o5gHwADVe+NRuWH8vhJDK2kaG5a/EgxuCg6fQjTsWeWoS5JSukxwOtlo3jQ==
X-Gm-Gg: AYBFou3tkvZdMjKKdPeOGwm8O8Ozz5RRX5Peg3ohp63J/y1j+M/NFAJHx4Mw4xyK7O/
 n5xjkh55Qim5VdXHlu2a2q6Gm2MBKeeHlGAE/Y6ITsNBU16MKy0hpK1lx74t2+Cj/Q0slPOjih+
 Uv7dhRRhjhs51Zoe2e+H109WCalXJRHl42OENGgSaRNrW7ddGDkxWpLBC18P2tokwpQ/jdtYPWy
 a8a3C4m2RcjPqSTc/uPeNCngN+jlH0IUKqsZo5YSu7cs20EN4SZbpmSr4nqn0vWt307jegfT6Ae
 sCbZv6J053aRZ6yBASPh8NOC5jVkeiSn4oGkSklVXOeZ7yhCwrN9DHqo+EzLlvsnO7SJtt/KLki
 YL+yagwsVIcBqZt+Q50+Vg+xGJzSwDELv2w==
X-Received: by 2002:a05:620a:1b9b:b0:93f:2158:9c4a with SMTP id
 af79cd13be357-93f6f787103mr293977785a.15.1792742846276; 
 Fri, 23 Oct 2026 01:07:26 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9b:b0:93f:2158:9c4a with SMTP id
 af79cd13be357-93f6f787103mr293974585a.15.1792742845668; 
 Fri, 23 Oct 2026 01:07:25 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a215437d4asm20271145e9.3.2026.10.23.01.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 01:07:24 -0700 (PDT)
Message-ID: <a7eb7b51-55ec-49e4-a4cc-209c41236c91@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:07:23 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix CPU state access on big-endian hosts
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261022130657.6449-1-anjo@rev.ng>
 <3d9baf66-d412-439a-b9db-099124af6625@oss.qualcomm.com>
 <8299629b-7033-485c-8204-521e14e2f1d8@oss.qualcomm.com>
In-Reply-To: <8299629b-7033-485c-8204-521e14e2f1d8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX3Iye3xkH1g0w
 4hLY6e1VusuvGDMcqVecDUwxZg5T2qGD576HpqM1Fl3OfZ2CZM/1GYdo0Leij4pJLKjpsjnCozN
 jDDiRusMlpL/fPUBkXnVnuYJgKOyPwI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXyJMp4Wr4MYbL
 4yaTcdMH97+1aPWytUBRabPV2+lsK/KlCxHeE68vI5j99iJQgD13FZFhSlLgFuAMN4M96ZgmsTR
 X6FFXoH9M7zQYAM/ispHNBA+4Pfoc0+AJADICt8YL55H5zZ/uPKVS3QeyrSjKqOIYzHOaAP8hie
 aGqnfenCrHkpKT4PXl1E7FdH9rrIC8PCwIni2Kk3wIsz1VubHtrIQqty0OUT9dAqFzW9Ud6yimC
 ORd53wSCxY4CoEiBUqbWPxHT6O128TcLVBWO/GdcJoHbubgYTcN4ywpbc3X3RdbXxQGolFA0hrs
 ZsWHJvTPye5qRW3l+onxgz8TjKRjgHLdmDhrlp1AtNYpi9KSg1yGh9jlmzz5/sayKw0fJMBlWpR
 ZHhHSgal0brP/s3NL2EQvAqFbxTCCeEKRffSD5vIrU7fK2OcmGRPUUxMJN6BZ4K0lY4kp8qNXlT
 EIm9YwhDm/52s4tqiHA==
X-Proofpoint-ORIG-GUID: XJNuo1wwo55esnf8Q1l3_xsn_ArQe496
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb15be cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=NNJIofpBleYf-0x90UEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: XJNuo1wwo55esnf8Q1l3_xsn_ArQe496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26 09:53, Philippe Mathieu-DaudÃ© wrote:
> On 23/10/26 09:37, Philippe Mathieu-DaudÃ© wrote:
>> On 22/10/26 15:06, Anton Johansson via qemu development wrote:
>>> mstatus and mstatus_hs are uint64_t but accessed through
>>>
>>>    tcg_gen_[ld|st]_tl(..., offsetof(mstatus))
>>>
>>> which on a big-endian host running riscv32 incorrectly accesses the
>>> top 32 bits rather than the lower bits.
>>
>>    mstatus and mstatus_hs are uint64_t, but mark_fs_dirty() and
>>    mark_vs_dirty() update them with tcg_gen_[ld|st]_tl().
>>    On big-endian hosts with 32-bit target_ulong, this modifies
>>    the upper half instead of the lower one, so the FS/VS dirty
>>    bits are never set. Use 64-bit accesses instead.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 284d697c74e ("target/riscv: Merge m/vsstatus and m/vsstatush 
>> into one uint64_t unit")
>> Fixes: 8e1ee1fb571 ("target/riscv: rvv-1.0: add translation-time 
>> vector context status")
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>
>>> Widen the operations to 64 bit so the lower bits are modified.
>>>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>> ---
>>>   target/riscv/tcg/translate.c | 32 ++++++++++++++++----------------
>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
>>> index ede9c2563f..79b0f444ef 100644
>>> --- a/target/riscv/tcg/translate.c
>>> +++ b/target/riscv/tcg/translate.c
>>> @@ -693,7 +693,7 @@ static TCGv get_address_indexed(DisasContext 
>>> *ctx, int rs1, TCGv offs)
>>>    */
>>>   static void mark_fs_dirty(DisasContext *ctx)
>>>   {
>>> -    TCGv tmp;
>>> +    TCGv_i64 tmp;
>>>       if (!has_ext(ctx, RVF)) {
>>>           return;
>>> @@ -703,15 +703,15 @@ static void mark_fs_dirty(DisasContext *ctx)
>>>           /* Remember the state change for the rest of the TB. */
>>>           ctx->mstatus_fs = EXT_STATUS_DIRTY;
>>> -        tmp = tcg_temp_new();
>>> -        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>>> -        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
>>> -        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>>> +        tmp = tcg_temp_new_i64();
>>> +        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>>> +        tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
>>> +        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>>>           if (ctx->virt_enabled) {
>>> -            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, 
>>> mstatus_hs));
>>> -            tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
>>> -            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, 
>>> mstatus_hs));
>>> +            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, 
>>> mstatus_hs));
>>> +            tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
>>> +            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, 
>>> mstatus_hs));
>>>           }
>>>       }
>>>   }
>>
>> Wondering about being safe (or catching other bad uses)
>>
>> #define TCG_ENV_OFS_(f)     offsetof(CPUArchState, f)
>> #define TCG_ENV_SIZE_(f)    sizeof_field(CPUArchState, f)
>>
>> #define tcg_gen_ld_env_tl(ret, f)                               \
>>      do {                                                        \
>>          QEMU_BUILD_BUG_ON(TCG_ENV_SIZE_(f) !=                   \
>>                            sizeof(target_ulong));                \
>>          tcg_gen_ld_tl(ret, tcg_env, TCG_ENV_OFS_(f));           \
>>      } while (0)
>>
>> #define tcg_gen_ld_env_i64(ret, f)                              \
>>      do {                                                        \
>>          QEMU_BUILD_BUG_ON(TCG_ENV_SIZE_(f) != 8);               \
>>          tcg_gen_ld_i64(ret, tcg_env, TCG_ENV_OFS_(f));          \
>>      } while (0)
>>
>> or even using _Generic:
>>
>> #define TCG_ENV_FIELD_(f)   (((CPUArchState *)0)->f)
>> #define TCG_ENV_OFS_(f)     offsetof(CPUArchState, f)
>>
>> #define tcg_gen_st_env_i32(arg, f)                              \
>>      _Generic(TCG_ENV_FIELD_(f),                                 \
>>               bool:     tcg_gen_st8_i32,                         \
>>               uint8_t:  tcg_gen_st8_i32,                         \
>>               int8_t:   tcg_gen_st8_i32,                         \
>>               uint16_t: tcg_gen_st16_i32,                        \
>>               int16_t:  tcg_gen_st16_i32,                        \

Hmm tricky (dangerous?), this also change our current uses of
target-long accesses to smaller fields. This is how I'd expect
the uses but not always what we have now. For example, commit
ebc9401a406 ("target/hppa: Split PSW X and B into their own
field") reduced CPUHPPAState::psw from uint64_t to uint32_t,
but both accessors -- trans_rsm() and trans_ssm() -- keep
accessing with tcg_gen_ld_i64() instead of tcg_gen_ld32u_i64().
Likely buggy wrt endianness.


>>               uint32_t: tcg_gen_st_i32,                          \
>>               int32_t:  tcg_gen_st_i32)                          \
>>          (arg, tcg_env, TCG_ENV_OFS_(f))
>>
>> #define tcg_gen_st_env_i64(arg, f)                              \
>>      _Generic(TCG_ENV_FIELD_(f),                                 \
>>               uint64_t: tcg_gen_st_i64,                          \
>>               int64_t:  tcg_gen_st_i64)                          \
>>          (arg, tcg_env, TCG_ENV_OFS_(f))
>>
>> #if TARGET_LONG_BITS == 32
>> # define tcg_gen_ld_env_tl  tcg_gen_ld_env_i32
>> # define tcg_gen_st_env_tl  tcg_gen_st_env_i32
>> #else
>> # define tcg_gen_ld_env_tl  tcg_gen_ld_env_i64
>> # define tcg_gen_st_env_tl  tcg_gen_st_env_i64
>> #endif
> 
> I added that to "tcg/tcg-op-env.h".
> 
>>
>> Then replacing (a cheap replacement that can be done with coccinelle
>> spatch):
> 
> -- >8 --
> @@
> expression R;
> identifier F;
> symbol tcg_env;
> type T;
> @@
> (
> - tcg_gen_ld_tl(R, tcg_env, offsetof(T, F))
> + tcg_gen_ld_env_tl(R, F)
> |
> - tcg_gen_st_tl(R, tcg_env, offsetof(T, F))
> + tcg_gen_st_env_tl(R, F)
> )
> 
> @@
> expression R;
> identifier F;
> symbol tcg_env;
> identifier T;
> @@
> (
> - tcg_gen_ld_tl(R, tcg_env, offsetof(T, F))
> + tcg_gen_ld_env_tl(R, F)
> |
> - tcg_gen_st_tl(R, tcg_env, offsetof(T, F))
> + tcg_gen_st_env_tl(R, F)
> )
> ---
> 
> Converting i386:
> 
> -- >8 --
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index dd417cb5341..abdf9b61ad1 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -25,2 +25,3 @@
>   #include "tcg/tcg-op.h"
> +#include "tcg/tcg-op-env.h"
>   #include "tcg/tcg-op-gvec.h"
> @@ -706,5 +707,5 @@ static void gen_set_eflags(DisasContext *s, 
> target_ulong mask)
> 
> -    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
> +    tcg_gen_ld_env_tl(t, eflags);
>       tcg_gen_ori_tl(t, t, mask);
> -    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
> +    tcg_gen_st_env_tl(t, eflags);
>   }
> @@ -715,5 +716,5 @@ static void gen_reset_eflags(DisasContext *s, 
> target_ulong mask)
> 
> -    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
> +    tcg_gen_ld_env_tl(t, eflags);
>       tcg_gen_andi_tl(t, t, ~mask);
> -    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
> +    tcg_gen_st_env_tl(t, eflags);
>   }
> @@ -2447,4 +2448,3 @@ static void gen_x87(DisasContext *s, 
> X86DecodedInsn *decode)
>                                offsetof(CPUX86State, fpds));
> -            tcg_gen_st_tl(last_addr, tcg_env,
> -                          offsetof(CPUX86State, fpdp));
> +            tcg_gen_st_env_tl(last_addr, fpdp);
>           }
> @@ -2756,4 +2756,3 @@ static void gen_x87(DisasContext *s, 
> X86DecodedInsn *decode)
>                            offsetof(CPUX86State, fpcs));
> -        tcg_gen_st_tl(eip_cur_tl(s),
> -                      tcg_env, offsetof(CPUX86State, fpip));
> +        tcg_gen_st_env_tl(eip_cur_tl(s), fpip);
>       }
> @@ -3200,6 +3199,4 @@ static void gen_multi0F(DisasContext *s, 
> X86DecodedInsn *decode)
>                       tcg_gen_mov_tl(s->T0, cpu_seg_base[R_GS]);
> -                    tcg_gen_ld_tl(cpu_seg_base[R_GS], tcg_env,
> -                                  offsetof(CPUX86State, kernelgsbase));
> -                    tcg_gen_st_tl(s->T0, tcg_env,
> -                                  offsetof(CPUX86State, kernelgsbase));
> +                    tcg_gen_ld_env_tl(cpu_seg_base[R_GS], kernelgsbase);
> +                    tcg_gen_st_env_tl(s->T0, kernelgsbase);
>                   }
> ---
> 
> triggers:
> 
> ../target/i386/tcg/translate.c:2449:13: error: controlling expression 
> type 'uint64_t' (aka 'unsigned long long') not compatible with any 
> generic association type
>   2449 |             tcg_gen_st_env_tl(last_addr, fpdp);
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:65:29: note: 
> expanded from macro 'tcg_gen_st_env_tl'
>     65 | # define tcg_gen_st_env_tl  tcg_gen_st_env_i32
>        |                             ^
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:47:14: note: 
> expanded from macro 'tcg_gen_st_env_i32'
>     47 |     _Generic(TCG_ENV_FIELD_(f),                                 \
>        |              ^~~~~~~~~~~~~~~~~
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:16:29: note: 
> expanded from macro 'TCG_ENV_FIELD_'
>     16 | #define TCG_ENV_FIELD_(f)   (((CPUArchState *)0)->f)
>        |                             ^~~~~~~~~~~~~~~~~~~~~~~~
> ../target/i386/tcg/translate.c:2757:9: error: controlling expression 
> type 'uint64_t' (aka 'unsigned long long') not compatible with any 
> generic association type
>   2757 |         tcg_gen_st_env_tl(eip_cur_tl(s), fpip);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:65:29: note: 
> expanded from macro 'tcg_gen_st_env_tl'
>     65 | # define tcg_gen_st_env_tl  tcg_gen_st_env_i32
>        |                             ^
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:47:14: note: 
> expanded from macro 'tcg_gen_st_env_i32'
>     47 |     _Generic(TCG_ENV_FIELD_(f),                                 \
>        |              ^~~~~~~~~~~~~~~~~
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:16:29: note: 
> expanded from macro 'TCG_ENV_FIELD_'
>     16 | #define TCG_ENV_FIELD_(f)   (((CPUArchState *)0)->f)
>        |                             ^~~~~~~~~~~~~~~~~~~~~~~~
> 2 errors generated.
> 
> Both CPUX86State::fpip/fpdp fields are uint64_t, so the same class of
> bug on big-endian hosts.
> 
> FAILED: [code=1] libqemu-i386-softmmu.a.p/target_i386_tcg_translate.c.o
> 
> 


