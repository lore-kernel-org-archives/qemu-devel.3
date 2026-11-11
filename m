Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C9606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rrHYcRc2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQz29-0007oJ-Vc; Tue, 10 Nov 2026 22:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQz28-0007mH-CO
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:30:00 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQz26-0008IK-BZ
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:30:00 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc758830601so1729800a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 19:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794367795; x=1794972595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EwVY3HZgRYZh1309oimBv7jqOQf/3D5nVP/VQ9sMQwA=;
 b=rrHYcRc2pwOOE7zPPS+fBTeW3dgwW6V94VQBHu3JL2tsKF/U/QzXvVGdQzbDk27ry3
 EO8bQgnXr8lHDPixTuWArtYhFBqVnhgFulNaAgI5IZ3iNY39RKaLJ6gGsO//wJVhq5oB
 6ZlKeUwjjR+SMIIyN/Mb0WOC8xEPY5JlLGOjPikl/ZXwpuMXFnCLdRPxmXMCyiJ/6jQy
 5ph8RyjNLZzwYDYDPEDUocCOlwhIz4tcMRSC/n0nBx/VAn8jv064jN9pLfP6ghKNcNGF
 yVEDAAu2Uk6VYlI5j5/kvgPTIrQyg0x0M4/aF13Viu2ceVA4bCHMrKSU/YkrTJl+zbuT
 Y07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794367795; x=1794972595;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EwVY3HZgRYZh1309oimBv7jqOQf/3D5nVP/VQ9sMQwA=;
 b=JVRIILtKm9y8GBqg+N98qkfSB9DDLYOjxX9rURi8pCjM0JZH5zdLjJ+QrxZLI9L49J
 P+kyvFnZlHqZhCohU1ja3NFPYy/WhV+C1UZvZDd4aSeTfhtVqldztsd4r7u4QbLHazCk
 fg4vxwFNeLynojQMcAq38lL54gukbsp00lHnBiAX8Zzr63fqPdesm4A9UQuO9uNl5bAn
 X4n8nd7fG6Uo0RGtfJs/JOE2XM2N4fvMilJ9dTToeE8h03/XuzykMabJdu8PbKNYmEbj
 5BnXQqT6xIZYz+jMe787JUIHlFYlvqT0o+L1ginNdDwSdd7dGy2WRcxeweVRZhlCfPhy
 apRw==
X-Forwarded-Encrypted: i=1;
 AL+hErEpNU+Va8my4YUG0/8sb0w6GGEKhcearNGK8iBSoHKjHzIeD/639oEYf0gne8m5ctY0jAAISoB7JLAw@nongnu.org
X-Gm-Message-State: APuU4Z+qzX2kWUOonX9nOxn/fTdlYJeDCjmv4nDU3/01QcPbQyaQkR3y
 wX5lVSpF2GioOjQDi5ZZKpvGwfW2Evyu81o6BOnfN5HPHrIRrgwBewpSjbCZbyRJpu4=
X-Gm-Gg: AYBFou3SnLBZ/Jtn3gjbljFO8uEcSkql9TpgiiQmoSeuHY5pG4Ow3wqrCiSyfYUqCu9
 F2GwMS6rltbvYn0ImYDeg+Rt8Oul1rHPAd5n/WSEJGd3WQDG/MhAVZTV84/Kf+wpRbHoebhroPp
 ycNnmEXdvDfp/xxqf+/lZL6pnj27gJPSUkD+FOvSI/ShdpXs2+2DWZDXKu1gvKdAXp+xLqA3GfP
 orE0Ms1S2njLlLvC4QOdaPJM7N+t/pRv5VLnE8F93zdkPOB0q/YTnnEhgzVw33l0ydgU0eOJk8z
 mWd2Lf/rXczre2fbnFZEV8FRmvek5rTdfA82How4k1Af74TGRFOSHZql7iJCoR94q6tKMT/tGlB
 kYls8Z9l8xYMD/nH2rDDFQLDSOT9tN6xkxnwR1QUWJWk/+kkj6U+pByW+H4T7i4LtFF7PprS8Fw
 xMSqBO2mbJfveugpCevHQstjEhefAKnKzexwMOJWHPA0hrTHyrH2IHrbwKp1saUNS2mLB8+eoeV
 GEXJvKzo4VB9KgtI1YYk+QC7xwIquvrYfWk47j5aoOyg3Ek/J4t+ft7Or+Nr6BvodCBMH0lbX3Z
 iT53AQ28qdDPXsQgyLnYv49nSUwhCoNJWTXXc4biPvuMTwIHFsgAvAp/srlEtU7JjjCzyRY=
X-Received: by 2002:a17:90b:574e:b0:3a8:10e2:ad08 with SMTP id
 98e67ed59e1d1-3b182f298dfmr1155497a91.48.1794367794880; 
 Tue, 10 Nov 2026 19:29:54 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b17db321dfsm2315840a91.5.2026.11.10.19.29.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 19:29:54 -0800 (PST)
Message-ID: <548258ad-0e51-458a-827e-6b9c7d0f15d3@linaro.org>
Date: Tue, 10 Nov 2026 19:29:52 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg/riscv64: Fix vector constant matching for logical
 ops
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20261010174742.3552498-1-aurelien@aurel32.net>
 <9ca6f711-e886-46a5-80ea-a6c750696a93@oss.qualcomm.com>
 <auEeif_51q1K9XOz@aurel32.net>
 <d230ae93a44b63138389d07c355c2e8d3154acd7.camel@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <d230ae93a44b63138389d07c355c2e8d3154acd7.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/10/26 18:36, Alistair Francis wrote:
> On Tue, 2026-10-27 at 22:58 +0100, Aurelien Jarno wrote:
>> Hi Philippe,
>>
>> On 2026-10-24 19:00, Philippe Mathieu-Daudé wrote:
>>> On 10/10/26 19:46, Aurelien Jarno wrote:
>>>> For logical vector operations (in the case of the RISC-V backend
>>>> that
>>>> corresponds to and_vec, or_vec and xor_vec), VECE is unused.
>>>> However,
>>>> tcg_target_const_match() always treat it as an element size to
>>>> extract
>>>> the corresponding constant element from the whole constant.
>>>>
>>>> This causes the following aarch64 instruction
>>>>     bic v4.8h, #0xf0
>>>> to be translated into the following op:
>>>>     ...
>>>>     and_vec v128,e8,tmp5,tmp4,v128$0xff0fff0fff0fff0f
>>>>     ...
>>>> which is then translated to the following RISC-V instruction:
>>>>     vand.vi v1,v1,15
>>>>
>>>> Fix that by, when VECE is 0 aka MO_8, only extracting the element
>>>> if the
>>>> it can actually be represented as a duplicated constant.
>>>>
>>>> Fixes: 5a63f5998791 ("tcg/riscv: Add support for basic vector
>>>> opcodes")
>>>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>>>> ---
>>>>    tcg/riscv64/tcg-target.c.inc | 11 +++++++++--
>>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> Changes v1 -> v2:
>>>> - Use dup_const() instead of open coding the constant
>>>> duplication.
>>>>
>>>> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-
>>>> target.c.inc
>>>> index 14a397117a..1262b71a62 100644
>>>> --- a/tcg/riscv64/tcg-target.c.inc
>>>> +++ b/tcg/riscv64/tcg-target.c.inc
>>>> @@ -392,8 +392,15 @@ static bool tcg_target_const_match(int64_t
>>>> val, int ct,
>>>>            return 1;
>>>>        }
>>>>        if (type >= TCG_TYPE_V64) {
>>>> -        /* Val is replicated by VECE; extract the highest
>>>> element. */
>>>> -        val >>= (-8 << vece) & 63;
>>>> +        /*
>>>> +         * For vector logical operations, VECE is unused and
>>>> equals to 0, so
>>>> +         * we need to check that the constant can properly be
>>>> represented after
>>>> +         * replication.
>>>> +         */
>>>> +        if ((vece != MO_8) || (val == dup_const(vece, val))) {
>>>> +            /* Val is replicated by VECE; extract the highest
>>>> element. */
>>>> +            val >>= (-8 << vece) & 63;
>>>> +        }
>>>>        }
>>>
>>> This fixes the BIC case, but I don't think it is sufficient.
>>>
>>> I tested with qemu-aarch64 built for a riscv64 host, run under
>>> qemu-riscv64 -cpu max, guest -cpu max,sve-default-vector-length=16.
>>>
>>> NEON bic v0.8h, #0xf0 // fail on master, now OK
>>>
>>> add z1.b; and z0.d, #0xf // FAIL
>>> add z1.d; and z0.b, #0xf // FAIL
>>> add z1.b; orr z0.d, #-16 // FAIL
>>> add z1.d; eor z0.b, #0xf // FAIL
>>
>> This indeed doesn't work. The problem is that while the constant
>> matching is being passed VECE = 0 (as it is unused for logical ops),
>> the
>> code generation is still being passed a 64-bit size. Therefore for
>> the
>> eor, it emits:
>>    vsetivli                zero,2,e64,m1,ta,ma
>>    lui                     t6,3
>>    addiw                   t6,t6,-448
>>    add                     t6,t6,s0
>>    vle64.v                 v1,(t6)
>>    vxor.vi                 v1,v1,15
>>
>> It would make more sense to use 16 e8 elements like in the original
>> ARM
>> SVE code, but it seems that info is lost at this stage.
>>
>>> Not accepting constants for and/or/xor_vec at all
>>> (using C_O1_I2(v, v, v) to get them loaded into registers)
>>> makes all five cases pass (I'm not sure we want to keep
>>> the .vi forms):
>>>
>>> -- >8 --
>>> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-
>>> target.c.inc
>>> --- a/tcg/riscv64/tcg-target.c.inc
>>> +++ b/tcg/riscv64/tcg-target.c.inc
>>> @@ -2779,15 +2779,15 @@ static void tcg_out_vec_op(TCGContext *s,
>>> TCGOpcode
>>> opc,
>>>       case INDEX_op_and_vec:
>>>           set_vtype_len(s, type);
>>> -        tcg_out_opc_vv_vi(s, OPC_VAND_VV, OPC_VAND_VI, a0, a1, a2,
>>> c2);
>>> +        tcg_out_opc_vv(s, OPC_VAND_VV, a0, a1, a2);
>>>           break;
>>>       case INDEX_op_or_vec:
>>>           set_vtype_len(s, type);
>>> -        tcg_out_opc_vv_vi(s, OPC_VOR_VV, OPC_VOR_VI, a0, a1, a2,
>>> c2);
>>> +        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a1, a2);
>>>           break;
>>>       case INDEX_op_xor_vec:
>>>           set_vtype_len(s, type);
>>> -        tcg_out_opc_vv_vi(s, OPC_VXOR_VV, OPC_VXOR_VI, a0, a1, a2,
>>> c2);
>>> +        tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2);
>>>           break;
>>>       case INDEX_op_not_vec:
>>>           set_vtype_len(s, type);
>>> @@ -2976,15 +2976,15 @@ tcg_target_op_def(TCGOpcode op, TCGType
>>> type,
>>> unsigned flags)
>>>       case INDEX_op_rotli_vec:
>>>           return C_O1_I1(v, v);
>>>       case INDEX_op_add_vec:
>>> -    case INDEX_op_and_vec:
>>> -    case INDEX_op_or_vec:
>>> -    case INDEX_op_xor_vec:
>>>       case INDEX_op_ssadd_vec:
>>>       case INDEX_op_sssub_vec:
>>>       case INDEX_op_usadd_vec:
>>>       case INDEX_op_ussub_vec:
>>>           return C_O1_I2(v, v, vK);
>>>       case INDEX_op_sub_vec:
>>>           return C_O1_I2(v, vK, v);
>>> +    case INDEX_op_and_vec:
>>> +    case INDEX_op_or_vec:
>>> +    case INDEX_op_xor_vec:
>>>       case INDEX_op_mul_vec:
>>>       case INDEX_op_shlv_vec:
>>>       case INDEX_op_shrv_vec:
>>>       case INDEX_op_sarv_vec:
>>>       case INDEX_op_rotlv_vec:
>>>       case INDEX_op_rotrv_vec:
>>>       case INDEX_op_smax_vec:
>>>       case INDEX_op_smin_vec:
>>>       case INDEX_op_umax_vec:
>>>       case INDEX_op_umin_vec:
>>>           return C_O1_I2(v, v, v);
>>
>> I believe that until TCG is able to propagate VECE even for logical
>> ops,
>> this is the thing to do. It generates suboptimal code, but correct
>> one.
> 
> Are you able to update this patch and send a v3 that include these
> fixes, or ideally what Richard said?

https://lore.kernel.org/qemu-devel/20261028143330.6518-1-philmd@oss.qualcomm.com/

I thought there would be some more review, but if there's no more 
comment I can merge it sometime this week.


r~

