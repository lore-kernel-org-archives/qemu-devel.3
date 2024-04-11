Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB54CCD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 07:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rup9n-0001G9-4k; Thu, 11 Apr 2024 03:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9l-0001FD-AP
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:37 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9j-0000kO-Hl
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:37 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-22efc6b8dc5so3261743fac.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712821652; x=1713426452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uw76+n953sJlDol0pcpJf71gyUQa84+tdUxz9ZulaGI=;
 b=VHhiUzvEiSzegrB2BbUdEiAhO0kigvi/ALabbl65sFh37QXPleVgs4XQ5WvGNnnx7I
 yQxI/iwtSaAL1nUaBQicsH/AAQpIOBJuyJM5Llgr2KwMTEgTJBHq3GZxziFFbj7BkXtP
 GrDS4MK2QHRV1khADd3MboukbF42iwAQdAP2PQYx4ojXNN6oGzFvA4zrXqfzzrSk2lLS
 AbNjdlIitaLD/qwIR5SrIb+sCAcoRC15H9PclrVRSBt5gDUFasUXiGWDtSUPunYpdQtu
 Lo1KJm8sWGfEWuw38Zt0zMcp4ihVGTqgr4ZxKJ/9zL86+mbGBq2U3xazrt5kEwHneX/1
 nMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712821652; x=1713426452;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uw76+n953sJlDol0pcpJf71gyUQa84+tdUxz9ZulaGI=;
 b=bI2qIEoSVaogcz+DQvWmKz3sIxMEe9OmnUgDO0ocNQsznOW/uY291nXcJe6p726P0N
 wpgNsbtGyDY2oS+1A7W/LHny4j3LGo/u4FO5V5GFQ3Q64q8bzdW6xa43CIAyCLjE8q4o
 +ea4dQinxxIO//pI3lW/+6GWrDRIWWOxHQwU7mWx6dI3pJfYSlksXWrOtFKu3D9R9Cs+
 i20tTdBIPis/W869N3RBYvyRBQ67TunBVd9rprff04zSzROpQUwpiBBmj7zsz0RG6s/X
 xK20OCYeNeyIszi4jUdW2GkC8o9quLudjHDSPyhf/mWVt9pjZ6I9adCi6m/wCnBwGkT9
 7l7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpkY4IR0CR1yqtRb8V7iih1vbVvvks8FDIhwTnqXSDJQ4suA8asho9WQ5c82KyGR1BZlaDBYoMQeZKGOkMih4YpPtsyfE=
X-Gm-Message-State: AOJu0YwyvFd4uNx5+sxHxrPubGwXI/LbVpaxOGL4jw3vJqHrGHG1/0EW
 58wHm2MNky7GeSUTBrZVMAvbXaYLUVYzitOhEyliv+qihIRrZFJYGTd9ynb/A4g=
X-Google-Smtp-Source: AGHT+IEry9izyG67Yd481mJVdQerQ3xqUXlSCmY4s3ffEMOo+8Av6bo8Z/YOebqTqScwHbCQd/w2xQ==
X-Received: by 2002:a05:6870:55cd:b0:22a:5bae:9cd5 with SMTP id
 qk13-20020a05687055cd00b0022a5bae9cd5mr5019871oac.48.1712821652368; 
 Thu, 11 Apr 2024 00:47:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a656a82000000b005dbd0facb4dsm493803pgu.61.2024.04.11.00.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 00:47:31 -0700 (PDT)
Message-ID: <4f9ac251-4123-41a9-8ce0-4417ab7b7c09@linaro.org>
Date: Wed, 10 Apr 2024 23:02:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 11/19] target/i386: move C0-FF opcodes to new
 decoder (except for x87)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-12-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 4/9/24 06:43, Paolo Bonzini wrote:
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 05a1912f8a3..88653c4f824 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -105,6 +105,12 @@ typedef uint64_t TCGRegSet;
>   /* Turn some undef macros into true macros.  */
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
> +/* Define parameterized _tl macros.  */
> +#define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i32_valid
> +#define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i32_valid
> +#else
> +#define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i64_valid
> +#define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i64_valid
>   #endif

So far we have been localizing these to emit.c.inc.

In general I'm not sure how I feel about them.  It would be cleaner not to expose tcg 
backend details at all, but there are several points where we can legitimately produce 
better code knowing what the backend has, without having to have a strong optimizer.


> +static void decode_group2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
> +{
> +    static const X86GenFunc group2_gen[8] = {
> +        gen_ROL, gen_ROR, gen_RCL, gen_RCR, gen_SHL, gen_SHR, gen_SHL, gen_SAR,
> +    };

I think you need to keep a comment for /6 (currently OP_SHL1 /* undocumented */; I presume 
this to be the original SAL opcode, before some prehistoric documentation changed it to 
share /4 with SHL).

> +static const X86OpEntry opcodes_grp3[16] = {
> +    /* 0xf6 */
> +    [0x00] = X86_OP_ENTRYrr(AND, E,b, I,b),
> +    [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
> +    [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
> +    [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
> +    [0x05] = X86_OP_ENTRYrr(IMUL,E,b, 0,b, sextT0),
> +    [0x06] = X86_OP_ENTRYr(DIV,  E,b),
> +    [0x07] = X86_OP_ENTRYr(IDIV, E,b),
> +
> +    /* 0xf7 */
> +    [0x08] = X86_OP_ENTRYrr(AND, E,v, I,z),
> +    [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
> +    [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
> +    [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
> +    [0x0d] = X86_OP_ENTRYrr(IMUL,E,v, 0,v, sextT0),
> +    [0x0e] = X86_OP_ENTRYr(DIV,  E,v),
> +    [0x0f] = X86_OP_ENTRYr(IDIV, E,v),
> +};
> +
> +static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
> +{
> +    int w = (*b & 1);
> +    int reg = (get_modrm(s, env) >> 3) & 7;
> +
> +    *entry = opcodes_grp3[(w << 3) | reg];
> +}
> +
> +static const X86OpEntry opcodes_grp4[16] = {
> +    /* 0xfe */
> +    [0x00] = X86_OP_ENTRY1(INC,     E,b, lock),
> +    [0x01] = X86_OP_ENTRY1(DEC,     E,b, lock),
> +
> +    /* 0xff */
> +    [0x08] = X86_OP_ENTRY1(INC,     E,v, lock),
> +    [0x09] = X86_OP_ENTRY1(DEC,     E,v, lock),
> +    [0x0a] = X86_OP_ENTRY3(CALL_m,  None, None, E,f64, None, None, zextT0),
> +    [0x0b] = X86_OP_ENTRYr(CALLF_m, M,p),
> +    [0x0c] = X86_OP_ENTRY3(JMP_m,   None, None, E,f64, None, None, zextT0),
> +    [0x0d] = X86_OP_ENTRYr(JMPF_m,  M,p),
> +    [0x0e] = X86_OP_ENTRYr(PUSH,    E,f64),
> +};
> +
> +static void decode_group4(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
> +{
> +    int w = (*b & 1);
> +    int reg = (get_modrm(s, env) >> 3) & 7;
> +
> +    *entry = opcodes_grp4[(w << 3) | reg];
> +}

Did these tables need to be outside their functions?
Though this works, 0xff is named grp5.

> +    [0xF1] = X86_OP_ENTRY0(INT1,   svm(ICEBP)),
> +    [0xF4] = X86_OP_ENTRY0(HLT,    chk(cpl0)),
> +    [0xF5] = X86_OP_ENTRY0(CMC),
> +    [0xF6] = X86_OP_GROUP1(group3, E,b),
> +    [0xF7] = X86_OP_GROUP1(group3, E,v),

Not adding spacers as you were above?

> +static void gen_RCL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
> +{
> +    bool have_1bit_cin, can_be_zero;
> +    TCGv count;
> +    TCGLabel *zero_label = NULL;
> +    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
> +    TCGv low = tcg_temp_new();
> +    TCGv high = tcg_temp_new();
> +    TCGv low_count = tcg_temp_new();
> +
> +    if (!count) {
> +        return;
> +    }
> +

Delay all temp allocation until after the early return.


> +static void gen_rot_carry(X86DecodedInsn *decode, TCGv result, TCGv count, int bit)
> +{
> +    TCGv temp = count ? tcg_temp_new() : decode->cc_dst;
> +
> +    tcg_gen_setcondi_tl(TCG_COND_TSTNE, temp, result, 1ULL << bit);

tcg_gen_extract_tl.

It might be easier to read with only one if:

     if (count == NULL) {
         extract
     } else {
         temp = new
         extract
         movcond
     }


r~

