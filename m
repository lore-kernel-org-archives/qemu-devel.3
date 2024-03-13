Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6F0C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 07:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkJVO-0007An-GU; Wed, 13 Mar 2024 03:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkJVJ-00078B-UL
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:58:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkJVH-0006Oe-BN
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:58:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-413eab9580dso1349635e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710316701; x=1710921501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JdIcNR5lNMB9GcP+OKcTtZm0QJ/4rKL7oOYMo/oV814=;
 b=D561cbZeiFd7TrlaobDU0f68vh4e+4qj6yxQ1styNEPEuoBu+7waWnmOaQg2AHe2Xb
 9OJiCxeaIQ02xi5L36LH04miP2qDMLLOnhniL9g5APg6DBu+KpH16l5q6VOmLAFk2lh3
 SzPE3WE5CTuzzx9Phak9f2TSZjbtnFDNTYDqtcNtlONtfgQHpvcc2wWa4SCqdF2WEKCM
 iBR/yiFmqKAaFlKZWqiP9TFP78BL7+WtFHYjtBwrsquUjeldpIdxiacDQbBW6F1yszib
 AjmZSmOrRAi9HUk8x8D4i69CtYsx6aXnY1+AOLZ22xaollrunTm5nAOS6sJp0Du09sK9
 YmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710316701; x=1710921501;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JdIcNR5lNMB9GcP+OKcTtZm0QJ/4rKL7oOYMo/oV814=;
 b=bU5BlnPljaBF1ZLzWK4o7dsTVKwCblJZRoox9vGmkJWXEzpKKWZiWkRU772rnM0yfR
 B8sfVrO186o7rd1K/lwO7YLkV3zYEsrOK2g8X+CIQl/PLsk8ekPRT852Nd7R9u+QGbpu
 +z2hAYtABQV+ybMMu0Mbzebae93eQm3hbej28gG/P3uO3I1atQjE6L1lDR/7fBgCuZkh
 k9brmbk+ROSugVo4JDo3PKCDKyDPMBdT7jLocV28nYZuYVuSWF34B7fC6XHH8uXh3bB7
 EmvJJVEL1A88OXPDqTSE2wIRZJ+/QhM/DH57cRS6jjCSxWfdZe9eusfWf/QWuibCUCV+
 hkPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIeZ5ccJFZx+RpPXYiBLr2KnOHsH/NrJLvg4KzmIR8ebkVZyswkj8Lu2/X/Z6ODlES1MkOdO8comzByXn2vJI8uhwOdL8=
X-Gm-Message-State: AOJu0YzsSiHJ1q26WCPgwZf3NsaqMDJKJUV+G8oEsPG5tcXBJoWMpxZd
 CZpS9Hb9czyy3uo0Q+aGxyJ5nc4aJu5HKAOmWPnjGD17caLT4Kobi4Xb0bkJ1PjXykMauZdGnp3
 rb44=
X-Google-Smtp-Source: AGHT+IH9Usu+Res8VshTSCDYDH/hWhVyC4G4BupzOvZ5G+yV7PPuutL7FekYBbg7dyLAX0qbT/H1bw==
X-Received: by 2002:a05:600c:4f92:b0:413:3160:841d with SMTP id
 n18-20020a05600c4f9200b004133160841dmr3513616wmq.8.1710316701007; 
 Wed, 13 Mar 2024 00:58:21 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c154700b004131035d28csm1468874wmg.23.2024.03.13.00.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 00:58:20 -0700 (PDT)
Message-ID: <b672aaf5-61c3-4bfe-a457-574571d08b8b@linaro.org>
Date: Wed, 13 Mar 2024 11:58:17 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] plugins: add new inline op STORE_U64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
 <20240312075428.244210-3-pierrick.bouvier@linaro.org>
 <24e8c6ce-589b-44d3-92e1-887916aff709@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <24e8c6ce-589b-44d3-92e1-887916aff709@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/13/24 01:15, Richard Henderson wrote:
> On 3/11/24 21:54, Pierrick Bouvier wrote:
>> +static void gen_empty_inline_cb_store_u64(void)
>> +{
>> +    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
>> +    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
>> +    TCGv_i64 val = tcg_temp_ebb_new_i64();
>> +    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
>> +
>> +    tcg_gen_ld_i32(cpu_index, tcg_env,
>> +                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
>> +    /* second operand will be replaced by immediate value */
>> +    tcg_gen_mul_i32(cpu_index, cpu_index, cpu_index);
>> +    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_index);
>> +    tcg_gen_movi_ptr(ptr, 0);
>> +    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
>> +
>> +    tcg_gen_movi_i64(val, 0);
>> +    tcg_gen_st_i64(val, ptr, 0);
>> +
>> +    tcg_temp_free_ptr(ptr);
>> +    tcg_temp_free_i64(val);
>> +    tcg_temp_free_ptr(cpu_index_as_ptr);
>> +    tcg_temp_free_i32(cpu_index);
>> +}
> 
> I was never fond of this full pattern generate...
> 

I agree with you. Didn't want to start this discussion, but yes, 
implementing this feels clunky and error prone (especially the replace 
part, that depends on architecture bitness for which you execute).

>> @@ -352,6 +385,20 @@ static TCGOp *copy_st_i64(TCGOp **begin_op, TCGOp *op)
>>        return op;
>>    }
>>    
>> +static TCGOp *copy_mov_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
>> +{
>> +    if (TCG_TARGET_REG_BITS == 32) {
>> +        op = copy_op(begin_op, op, INDEX_op_mov_i32);
>> +        op->args[1] = tcgv_i32_arg(TCGV_LOW(tcg_constant_i64(v)));
>> +        op = copy_op(begin_op, op, INDEX_op_mov_i32);
>> +        op->args[1] = tcgv_i32_arg(TCGV_HIGH(tcg_constant_i64(v)));
>> +    } else {
>> +        op = copy_op(begin_op, op, INDEX_op_mov_i64);
>> +        op->args[1] = tcgv_i64_arg(tcg_constant_i64(v));
>> +    }
>> +    return op;
>> +}
> 
> ... followed by pattern match and modify.  I think adding more of this is fragile, and a
> mistake.
> 
> (1) This encodes knowledge of the order of the parts of a mov_i64 for 32-bit host.
> (2) You shouldn't use TCG_LOW/HIGH of tcg_constant_i64, but two separate calls to
> tcg_constant_i32 with the parts of @v.
> 
> But all of this would be easier if we simply generate new code now, instead of copy.

I'm open to work on this kind of change, and simply have a single pass 
that generate tcg ops, just before optimizing step, and translation to 
target arch. I would like to hear what Alex opinion is on doing this.

> 
>> +static TCGOp *append_inline_cb_store_u64(const struct qemu_plugin_dyn_cb *cb,
>> +                                       TCGOp *begin_op, TCGOp *op,
>> +                                       int *unused)
>> +{
>> +    char *ptr = cb->inline_insn.entry.score->data->data;
>> +    size_t elem_size = g_array_get_element_size(
>> +        cb->inline_insn.entry.score->data);
>> +    size_t offset = cb->inline_insn.entry.offset;
>> +    op = copy_ld_i32(&begin_op, op);
>> +    op = copy_mul_i32(&begin_op, op, elem_size);
>> +    op = copy_ext_i32_ptr(&begin_op, op);
>> +    op = copy_const_ptr(&begin_op, op, ptr + offset);
>> +    op = copy_add_ptr(&begin_op, op);
>> +    op = copy_mov_i64(&begin_op, op, cb->inline_insn.imm);
>> +    op = copy_st_i64(&begin_op, op);
> 
> You'd also be able to fold offset into the store.  This would allow the scoreboard address
> to be entered once into the constant pool and have multiple uses.
> 

The problem is that several callbacks can operate on several scoreboards 
(with different entries offset), so I'm not sure what we can precompute 
here.

We would need to keep a set of all target scoreboards, pre-compute final 
pointer for everyone of them, and emit this before any callback code. 
This sounded more complicated than just emitting all this.

> 
> r~

