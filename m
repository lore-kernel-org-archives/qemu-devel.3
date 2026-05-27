Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E43CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 18:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSJJq-0002cq-4F; Wed, 27 May 2026 14:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSJJp-0002cB-0p
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:49:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSJJm-0000GX-Hc
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:49:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RHXsgk150054
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 18:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QGKKvBaqnLO4/P2Mvq43DQqX5MmpKdh0po/nawddi/M=; b=HYRO6BElFELgyoJS
 PoegewOe537Bwex0zSDwsdMnX3+nt+R7TnQq8kIMPvVg1koLCkWetSGVwMm/lXg9
 ndu51fMGd0zyaq8ZTMmRGi2hPVxDaSMYaihddyUf6/h96n9SiVB2nD1y8oDuP3Y9
 buVXNqUpowVDbZsa3o8Gs+6bPnhqt85KKZao4F3IaxTVUSFMA+2WFqWvW1uTfZQw
 Qi1/XFjM9tREN9uYykiNNnlt51Nfn6/OSuo0mGy9a720hVrjYRpjHY6Kx0Dro+EA
 ZvO5BhGM0xbS66Rgym/B1KHpmZ47/2+KeJxIbMjCnSjQkTek2upYPistgPiqu4+o
 JlyTMg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxxvsx9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 18:49:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b640ede74bso181426d6.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779907763; x=1780512563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGKKvBaqnLO4/P2Mvq43DQqX5MmpKdh0po/nawddi/M=;
 b=H8LtZwzi3qCg/Kavj8Ih7PdzM6TMlsKZ3jIq3feHJWK+174NbTTsKIIPTuHFQHxFqo
 EdbcCs+HpnDlcS8d4gR0RghUG4VAXsyVY1wWTry7SrcFXRJ+hQTvAPap3c0ZjokffgfM
 /cRQ0ZuoWCm33di6A2b7GgkH5c+pBbwadeqSnY4lu7I+Z8CdSd5MNzBgrvj2ex5xL4v8
 ZDPy8pHpJ8pI1vZl+g778gN/XlmbSRsYw4sDgjjzZckeeDsbJJaEehUqdPClsDFwzGqH
 L1WVa2lrpakderibabg1sJWOIAC4Chac4PlU5tftgLxNxCwTBj95PDSSB/cadOJde0zd
 6GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779907763; x=1780512563;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QGKKvBaqnLO4/P2Mvq43DQqX5MmpKdh0po/nawddi/M=;
 b=ZPqXr3pgxUl6iHF78ZEVvaaoqYE3/IK4J3ncCPK7LfSjsYk+/u/kTmu5burAZkaAtB
 ka2U8R5GfeyoYQj8Eatl/YYf5Viv/6cA5GHGBjMFkpvY/O1xQtehztfJ424HMGPeWsG3
 PZiBlDctd3B0Qnj1/izMLK7Lz+vbMX+cVVATY5ZIYLUwCt04ERPbYI3VH2vy1zzNTV1h
 MsfMCI581X59GwQfXSUQqkgHuILTl9HG//cm86gAQCYF0Rsy7TF1m1fHiKKzHBoshPLf
 gtH5+w/z+HgcmqJKFuKebPNEPZ9DEfd9w4tON/Od3OXZaj7U91bTnMhgO3ITRmbxIqcf
 4HQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QlWWOF7E6riTJogIdrCB6sd4dhIVrtzTXdlbGEREidVZ4FB/2hKjiIJxJRiQRYvhzqESOXBK40EZ8@nongnu.org
X-Gm-Message-State: AOJu0Ywu08dX81hFnvzKRIhuFjqc37kwv9pl3vY/WkduzjYR9RjkXHvQ
 puxvW3TG1MB5xRXNtxXhxrR8yl4dsv0wfE8YUlqpwhE8TMXUTeTaAwDJAZbXTNbPG6/t92Uvfyd
 dEoRiJyCEI6GyrEieWB/Po9PjaiV0lQXBljXyx5ZeopKgpo+uy54GYbzmfQ==
X-Gm-Gg: Acq92OEWsTt3fzY0zoAnGpE0pF7qqcNOmZ3FiJ7toKe6lkOCgc/in94j7KuW1j0TBTl
 1UZ7ol8Fj6QtVJ5s7SNB/hMdIoBB6KrubwuKEpwuXJOZqGAtYLa50gxQ4DeNDMTsnybSOpHOLM7
 INaVF4efEewYxyE8V0zA9K45TI3fuAJQifWEEu+MfvEphkWtT5ysKLHwIsPq9GFezFikRik9LRG
 1T0VjKrCrkJGeboOU40XGYSmI38ItFtfSdHyopBi6j0iKyR38Qqj43WvYWrsK10bXg+ORkFKX9U
 XzaPhL6qTai6oM78ntbnj463YnuktIRE9jHQrX0aWZ6BjZ0zyKvFUrohkHrUSMMlltjnq+V4e05
 MUxG0p+Cs+M6DaQoReGZLYz7UoqgLvyEoj2SCqYMYjMg0nAvX6OR+LG0FEFGVqOWiDcSF
X-Received: by 2002:a05:6214:4990:b0:8be:7424:688e with SMTP id
 6a1803df08f44-8cc7b6b5c1emr388988906d6.50.1779907763124; 
 Wed, 27 May 2026 11:49:23 -0700 (PDT)
X-Received: by 2002:a05:6214:4990:b0:8be:7424:688e with SMTP id
 6a1803df08f44-8cc7b6b5c1emr388988226d6.50.1779907762550; 
 Wed, 27 May 2026 11:49:22 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc80dcf4a9sm173741166d6.2.2026.05.27.11.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 11:49:22 -0700 (PDT)
Message-ID: <d6aabc4d-32af-4746-94ca-31393608cabe@oss.qualcomm.com>
Date: Wed, 27 May 2026 15:49:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv, disas/riscv: add insn len encodings > 64 bit
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
References: <20260520173522.1794433-1-daniel.barboza@oss.qualcomm.com>
 <880c4587e5c17ef291d1342c900b014c243499c2.camel@wdc.com>
Content-Language: en-US
In-Reply-To: <880c4587e5c17ef291d1342c900b014c243499c2.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0cTPTx711IvGRu9Yxkv7HsBxn3ltVzmf
X-Authority-Analysis: v=2.4 cv=bJAm5v+Z c=1 sm=1 tr=0 ts=6a173cb4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=HwFc7jivAAAA:8 a=EUspDBNiAAAA:8 a=pFyQfRViAAAA:8
 a=Ep33rmZ8QvZ-mLzFKp4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=kr7TZk85JJIQSqC0cl8G:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE4OCBTYWx0ZWRfX8QzjaSlx1gFm
 F7n5+58zyI1EU7PUtWIk7mIJqBHVWHQEt49Op3PhRtYpIxoH/uUc7NMh36gGbCMmddXJd88c7Tt
 23847DbPZ89/TCRYvoiD1Q42Mv2B4ThdbYmCJs8s1vTjN6WVN15E0Z0h8sCqfEECgeJUdy7QZdM
 C0az1xC0182GfRLM52CmZ6Zu+vM8bHNQJlgXkUeGEtpJzipCQPxxNZwYYL/VfYf8AvyA8kbcj6Q
 I6o0dnJMu73Vu5FMtaJ/SwLoGXti/izgwGlhZl4lirCB39b7AymMGQowXMOpDW6bMuELNDAT40Z
 KpClQoouB7G8te3bXk7aCNUYZrXQ+ilf6xqPP7QmIJ7GCWsoaYsKuLtcUcjE9b2XCr/ztvnbWrt
 s4nXiQFKoCp27Vt/qyCWadOVQFhLRpjRa7Gg6fBrqMiedHVhmmAn0RkLAH6fKSSPmFd0cmSpy27
 r55BAS2kqtOA64uH80Q==
X-Proofpoint-GUID: 0cTPTx711IvGRu9Yxkv7HsBxn3ltVzmf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270188
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
From:  Daniel Henrique Barboza via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/26/2026 9:35 PM, Alistair Francis wrote:
> On Wed, 2026-05-20 at 14:35 -0300, Daniel Henrique Barboza wrote:
>> We're missing the "Expanded Instruction-Length Encoding" logic from
>> the
>> unpriv isa, meaning we're not detecting missing insn len > 8 bytes.
>> This doesn't have impact in regular insn emulation because most (if
>> not
>> all) of the existing insns are 2 or 4 bytes.
>>
>> However, running with "-d in_asm" will cause QEMU to run an infinite
>> loop because our disas code can't handle the expanded length
>> encoding,
>> causing inst_length() to return '0' and target_disas() to loop
>> forever
>> since it's using the len to decrease the loop counter.
>>
>> Fixing just the disas code isn't enough.  target_disas() will do a
>>
>> "if (size < count) {"
>>
>> check, where size = the insn length from the translator and count =
>> the
>> insn length from disas, and will warn about it during disassembling.
>> We
>> need both places to use the same insn length logic.
>>
>> [1] https://gitlab.com/qemu-project/qemu/-/work_items/3479
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3479
>> Signed-off-by: Daniel Henrique Barboza
>> <daniel.barboza@oss.qualcomm.com>
>> ---
>>   disas/riscv.c            | 50 +++++++++++++++++++++++++++++---------
>> --
>>   target/riscv/internals.h | 33 ++++++++++++++++++++++++--
>>   target/riscv/translate.c |  7 +++++-
>>   3 files changed, 73 insertions(+), 17 deletions(-)
>>
>> diff --git a/disas/riscv.c b/disas/riscv.c
>> index d416a4d6b3..d32661c857 100644
>> --- a/disas/riscv.c
>> +++ b/disas/riscv.c
>> @@ -5057,26 +5057,48 @@ static bool check_constraints(rv_decode *dec,
>> const rvc_constraint *c)
>>       return true;
>>   }
>>   
>> -/* instruction length */
>> -
>> +/*
>> + * Note: basically a carbon copy of insn_len() from
>> + * target/riscv/internals.h.
>> + */
>>   static size_t inst_length(rv_inst inst)
>>   {
>> -    /* NOTE: supports maximum instruction size of 64-bits */
>> -
>>       /*
>> -     * instruction length coding
>> +     * "Expanded Instruction-Length Encoding" as in
>> +     * unpriv isa section 1.5.1.
> 
> This section was removed from the manual with commit
> 
> commit 4f05ffef4987213ddfb78b3e3aaf91b67892a664
> Author: Andrew Waterman <andrew@sifive.com>
> Date:   Tue Apr 1 18:02:36 2025 -0700
> 
>      Remove proposal for longer instruction encodings
>      
>      This is pursuant to making the manual contain only ratified
> content.
> 
> 
> So I don't think we should reference it. We should probably drop
> support for these as who knows what the ratified version will look like


Ooohhh good call. In the official RVI link:


https://docs.riscv.org/reference/isa/unpriv/intro.html#1-1-5-base-instruction-length-encoding


"All the 32-bit instructions in the base ISA have their lowest two bits set to 11.
The optional compressed 16-bit instruction-set extensions have their lowest two
bits equal to 00, 01, or 10."

So we'll support either 16 or 32 bits lengths only.  I'll send a v2.


Thanks,
Daniel


> 
> Alistair
> 
>>        *
>> -     *      aa - 16 bit aa != 11
>> -     *   bbb11 - 32 bit bbb != 111
>> -     *  011111 - 48 bit
>> -     * 0111111 - 64 bit
>> +     *               aa - 16 bit aa != 11
>> +     *            bbb11 - 32 bit bbb != 111
>> +     *           011111 - 48 bit
>> +     *          0111111 - 64 bit
>> +     * xnnnxxxxx1111111 - (80 + 16*nnn) bits, if nnn != 111
>> +     * x111xxxxx1111111 - 192 bits
>>        */
>> +    if ((inst & 0b11) != 0b11) {
>> +        return 2;
>> +    } else if ((inst & 0b11100) != 0b11100) {
>> +        return 4;
>> +    } else if ((inst & 0b111111) == 0b011111) {
>> +        return 6;
>> +    } else if ((inst & 0b1111111) == 0b0111111) {
>> +        return 8;
>> +    } else if ((inst & 0b1111111) == 0b1111111) {
>> +        uint32_t nnn = (inst >> 12) & 0b0111;
>> +
>> +        if (nnn == 0b111) {
>> +            return 24;
>> +        }
>> +        return (16 * nnn + 80) / 8;
>> +    }
>>   
>> -    return (inst &      0b11) != 0b11      ? 2
>> -         : (inst &   0b11100) != 0b11100   ? 4
>> -         : (inst &  0b111111) == 0b011111  ? 6
>> -         : (inst & 0b1111111) == 0b0111111 ? 8
>> -         : 0;
>> +    /*
>> +     * Returning 0 if we don't find the right insn length will
>> +     * cause an infinite loop in target_disas().  Return an
>> +     * unrealistic length value instead, making target_disas()
>> +     * trigger the "Disassembler disagrees with translator over
>> +     * instruction" error path.
>> +     */
>> +    return 1024;
>>   }
>>   
>>   /* format instruction */
>> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
>> index 8c24af0d85..80c2f8f5f8 100644
>> --- a/target/riscv/internals.h
>> +++ b/target/riscv/internals.h
>> @@ -245,9 +245,38 @@ static inline target_ulong
>> adjust_addr_virt(CPURISCVState *env,
>>       return adjust_addr_body(env, addr, true);
>>   }
>>   
>> -static inline int insn_len(uint16_t first_word)
>> +static inline int insn_len(uint32_t opcode)
>>   {
>> -    return (first_word & 3) == 3 ? 4 : 2;
>> +    /*
>> +     * "Expanded Instruction-Length Encoding" as in
>> +     * unpriv isa section 1.5.1.
>> +     *
>> +     *               aa - 16 bit aa != 11
>> +     *            bbb11 - 32 bit bbb != 111
>> +     *           011111 - 48 bit
>> +     *          0111111 - 64 bit
>> +     * xnnnxxxxx1111111 - (80 + 16*nnn) bits, if nnn != 111
>> +     * x111xxxxx1111111 - 192 bits
>> +     */
>> +    if ((opcode & 0b11) != 0b11) {
>> +        return 2;
>> +    } else if ((opcode & 0b11100) != 0b11100) {
>> +        return 4;
>> +    } else if ((opcode & 0b111111) == 0b011111) {
>> +        return 6;
>> +    } else if ((opcode & 0b1111111) == 0b0111111) {
>> +        return 8;
>> +    } else if ((opcode & 0b1111111) == 0b1111111) {
>> +        uint32_t nnn = (opcode >> 12) & 0b0111;
>> +
>> +        if (nnn == 0b111) {
>> +            return 24;
>> +        }
>> +        return (16 * nnn + 80) / 8;
>> +    }
>> +
>> +    /* Shouldn't happen, but ... */
>> +    return -1;
>>   }
>>   
>>   int riscv_monitor_get_register_legacy(CPUState *cs, const char
>> *name,
>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>> index 1e4f340256..bd28ed3fcb 100644
>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -1255,6 +1255,7 @@ static void decode_opc(CPURISCVState *env,
>> DisasContext *ctx)
>>   {
>>       uint32_t opcode;
>>       bool pc_is_4byte_align = ((ctx->base.pc_next % 4) == 0);
>> +    int insn_length;
>>   
>>       ctx->virt_inst_excp = false;
>>       if (pc_is_4byte_align) {
>> @@ -1279,7 +1280,11 @@ static void decode_opc(CPURISCVState *env,
>> DisasContext *ctx)
>>       }
>>       ctx->ol = ctx->xl;
>>   
>> -    ctx->cur_insn_len = insn_len((uint16_t)opcode);
>> +    insn_length = insn_len(opcode);
>> +    if (insn_length < 0) {
>> +        gen_exception_illegal(ctx);
>> +    }
>> +    ctx->cur_insn_len = insn_length;
>>       /* Check for compressed insn */
>>       if (ctx->cur_insn_len == 2) {
>>           ctx->opcode = (uint16_t)opcode;


