Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3342C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 18:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1VbT-00031Q-0Y; Mon, 29 Apr 2024 14:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1VbQ-000311-CQ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:19:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1VbN-0003KU-PE
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:19:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e40042c13eso32446395ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714414783; x=1715019583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dbzX4RcDuf5W/uRZRmZ8G3pIg6G9IqNxr/wUr+47yx4=;
 b=q2zh+aX8cTPKqm3v23tKuv52dSGFkO6mFHZCbQKMWOrAqiKNND7ue3aLGWg2eCpbwl
 C517fu3koYtpgXrHSR5PPIqHG4CtX2mXk8bPE8PgbFjmiManWIEBXXnDVHhEbhrNkEuv
 tSMet/2oAxd7gLHXIKiVyld8erepL5ScwMI/mjoxnIsl8kI8VYgRvrmhOCxBnFd/CZBP
 yJtEX92oduX9zDAXGNrHIpVGTJE2IhQe41R0M5EKqkQrEIUiXRfpPSHa+7hDVmu/hxax
 3Ya2RdmD/UtNfgbSPpywEHoJDp4KtWnGkdwkos+UkgGdCOxJpbbmPWwkgh+JtnrQpCTR
 /JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714414783; x=1715019583;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dbzX4RcDuf5W/uRZRmZ8G3pIg6G9IqNxr/wUr+47yx4=;
 b=DszcwE1SpF2CgKTLzTkV4qjM2aMb9pLfPG3fmETbreRcwpDchHG1VZW0Gm6pc8va8r
 ZpUcCnPFPmmr8YQt4cJsMUJeZ5dfJ09aHQw8WMNOs9A9GDs6F1N6plyci7lKwkZpxgcR
 /dsKW6okvcFFs6lYHlIKIWCQlo1cuRvGF0GkEzfKLHxKIjKjZHiJobD9UXeIDmBq4byb
 h+TPjpixGRseOSTNjfeDAmTje7dqw9JvCKKnwFvyyp8o1jSWMMB9G6tr0gX0UXPtlyak
 Us0ftVpZZKdB8L2YWTnLQKgPvsNnQn9n0gYYrLfRBxt8cBkuWgL+GZ2Zp1bUdn1xQE/P
 Hfxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTQQsQYKQQQCFJvVoMUDlzneiYb71emPFVYdsYxj0M/HLoc7gc6RfgutRb1Vj2CyzgbpIhH/5QWqBhABhB/ddY/FiHJBw=
X-Gm-Message-State: AOJu0Yz7SMy4lCwS1e1Rf5OZtdoygfAj+Mq85NXCmXcVCA4fNIPPDWEz
 6dmPDcZTkhWuqDHok82cWW+T6IwosB2Uej5zvPTVc5i75q/oCjYVntFCCRWR/qE=
X-Google-Smtp-Source: AGHT+IFzhtrQXL8qu7tsCLzv6oVN8OpIVIGxzm9mY2g80jUQaqINtEtrhaQ6i+ZwsXnIV7dVNWdtGQ==
X-Received: by 2002:a17:903:2447:b0:1e7:d482:9e09 with SMTP id
 l7-20020a170903244700b001e7d4829e09mr13569681pls.7.1714414780737; 
 Mon, 29 Apr 2024 11:19:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a170902680f00b001e89e7b2b74sm20199723plk.235.2024.04.29.11.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 11:19:40 -0700 (PDT)
Message-ID: <88594e43-22b8-4b5d-9bb8-eb77fafefaad@linaro.org>
Date: Mon, 29 Apr 2024 11:19:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon: add PC alignment check and exception
From: Richard Henderson <richard.henderson@linaro.org>
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: bcain@quicinc.com, sidneym@quicinc.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
References: <c7af62451b02ffdc1d68bc00093b40a8080bc3ff.1714155331.git.quic_mathbern@quicinc.com>
 <121029ce-d106-4eb2-bbcb-6b65bd595813@linaro.org>
Content-Language: en-US
In-Reply-To: <121029ce-d106-4eb2-bbcb-6b65bd595813@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/27/24 07:56, Richard Henderson wrote:
> On 4/26/24 11:15, Matheus Tavares Bernardino wrote:
>> The Hexagon Programmer's Reference Manual says that the exception 0x1e
>> should be raised upon an unaligned program counter. Let's implement that
>> and also add tests for both the most common case as well as packets with
>> multiple change-of-flow instructions.
>>
>> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>> ---
>>   target/hexagon/cpu_bits.h                  |  1 +
>>   target/hexagon/translate.h                 |  2 ++
>>   target/hexagon/genptr.c                    | 21 ++++++++++++++++-----
>>   target/hexagon/translate.c                 |  2 +-
>>   tests/tcg/hexagon/Makefile.target          | 13 +++++++++++++
>>   tests/tcg/hexagon/unaligned_pc.S           | 10 ++++++++++
>>   tests/tcg/hexagon/unaligned_pc_multi_cof.S | 13 +++++++++++++
>>   7 files changed, 56 insertions(+), 6 deletions(-)
>>   create mode 100644 tests/tcg/hexagon/unaligned_pc.S
>>   create mode 100644 tests/tcg/hexagon/unaligned_pc_multi_cof.S
>>
>> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
>> index 96fef71729..d6900c8bda 100644
>> --- a/target/hexagon/cpu_bits.h
>> +++ b/target/hexagon/cpu_bits.h
>> @@ -23,6 +23,7 @@
>>   #define HEX_EXCP_FETCH_NO_UPAGE  0x012
>>   #define HEX_EXCP_INVALID_PACKET  0x015
>>   #define HEX_EXCP_INVALID_OPCODE  0x015
>> +#define HEX_EXCP_PC_NOT_ALIGNED  0x01e
>>   #define HEX_EXCP_PRIV_NO_UREAD   0x024
>>   #define HEX_EXCP_PRIV_NO_UWRITE  0x025
>> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
>> index 4dd59c6726..daf11eb584 100644
>> --- a/target/hexagon/translate.h
>> +++ b/target/hexagon/translate.h
>> @@ -75,6 +75,8 @@ typedef struct DisasContext {
>>       TCGv dczero_addr;
>>   } DisasContext;
>> +void gen_exception_end_tb(DisasContext *ctx, int excp);
>> +
>>   static inline void ctx_log_pred_write(DisasContext *ctx, int pnum)
>>   {
>>       if (!test_bit(pnum, ctx->pregs_written)) {
>> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
>> index dbae6c570a..c96edd9379 100644
>> --- a/target/hexagon/genptr.c
>> +++ b/target/hexagon/genptr.c
>> @@ -473,6 +473,7 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TCGv addr,
>>                                     TCGCond cond, TCGv pred)
>>   {
>>       TCGLabel *pred_false = NULL;
>> +    TCGLabel *branch_taken = NULL;
>>       if (cond != TCG_COND_ALWAYS) {
>>           pred_false = gen_new_label();
>>           tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
>> @@ -480,12 +481,22 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TCGv addr,
>>       if (ctx->pkt->pkt_has_multi_cof) {
>>           /* If there are multiple branches in a packet, ignore the second one */
>> -        tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[HEX_REG_PC],
>> -                           ctx->branch_taken, tcg_constant_tl(0),
>> -                           hex_gpr[HEX_REG_PC], addr);
>> +        branch_taken = gen_new_label();
>> +        tcg_gen_brcondi_tl(TCG_COND_NE, ctx->branch_taken, 0, branch_taken);
>>           tcg_gen_movi_tl(ctx->branch_taken, 1);
>> -    } else {
>> -        tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);
>> +    }
>> +
>> +    TCGLabel *pc_aligned = gen_new_label();
>> +    TCGv pc_remainder = tcg_temp_new();
>> +    tcg_gen_andi_tl(pc_remainder, addr, PCALIGN_MASK);
>> +    tcg_gen_brcondi_tl(TCG_COND_EQ, pc_remainder, 0, pc_aligned);
>> +    gen_exception_end_tb(ctx, HEX_EXCP_PC_NOT_ALIGNED);
>> +    gen_set_label(pc_aligned);
>> +
>> +    tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);
> 
> I am suspicious that the exception is raised without the pc being assigned.
> How does the exception handler see the incorrect value?

S390x does not check this with the branch, but when beginning to translate the next 
instruction, in cpu_get_tb_cpu_state.

ARM does not check this with the branch, but just before translating each block, in 
aarch64_tr_translate_insn, just before reading the instruction itself.

Alternately, RISC-V, whose exception handler expects to see pc still pointing at the 
branch, but raises a special misaligned-pc exception, and places the branch target in 
BADADDR where the exception handler can see it.

All of these arrange for the target address to be seen.
The hexagon manual I have at my fingertips is instructions only, and doesn't have any 
exception handling details...


r~


r~

