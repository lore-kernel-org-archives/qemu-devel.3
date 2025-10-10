Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F595CCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 02:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v73JO-0006HJ-3m; Thu, 09 Oct 2025 22:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v73JM-0006HA-4d
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 22:56:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v73JF-0001kJ-6W
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 22:56:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so18748255e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 19:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760065000; x=1760669800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lcY/56VJ8b9tiERvGPI7f1dYWKOqbJy45Kwg8QaOX1k=;
 b=y0WQht23yf0aZxZ2zi8INNKmTiA6JXUJERtQaTRiKpI2cVwvAuboS/3vLPNNrDZaHT
 SPm9pVu1t5BsX/tGO9dRRluf1ClRnFbxx25IVJZ/qCVVdLsLLRTnfVIBQ14ACMz8w68H
 aK3BQ6ltACy0TlaDZCR2LWud4vKJhsmRQTm8IoIEESWoNznlhVOfNM/VHrRwUU2P5WHH
 wNIb/gyjFXTrLtvjxziCOjsBOYrf7aIeBbgT8xPIzhG1bm5wtiICqypyCJyGv+7gh+hA
 2wjIzpNK1PDOUOr9nkqhgvStC+VvZBoKyHoDWKqiwQImGI0l77bbPYR2wEr5NTNFAK0w
 7iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760065000; x=1760669800;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lcY/56VJ8b9tiERvGPI7f1dYWKOqbJy45Kwg8QaOX1k=;
 b=u8k/gbzRXvRnXwZgaf1Tnn2CW11yos1zdoz2wQSgScbnwKD8aXIt48AIAN4A5JjF5t
 A4pNiREIv48+jOCSncVc27KHbuMu68w61GO/csMKjlpxZzXOo4LdTU+8z1g61I5qBNKY
 NkBHwcVcpLs33oqcHXIOmFAQXR9lHXpVjEF2GFtE5xa+/4v0A3/61GSw6hrleXEX2Gdn
 JlerfMelHhcNybO+RkherKT4QYix4hbIudJwJNWVOVGSK9sU3ms/Rw3pX/WPSJD8tVSm
 MuenSgXeWcyXDAmKtLdruuBAXtdCUsxjDnQ8d/0S2l/D7d+ED3mFmofn4AFSI/6Z+Bog
 KrqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhhC60t4HVYuouyT0A5NKqqiTzfFtLZ32drg07SH4a4PgeIWsQpTou+9qoHnqgkUrN+8f0u+7U3BMB@nongnu.org
X-Gm-Message-State: AOJu0YyoG0VkUIr+hMAmMxeObWh+n4GpSoPBaV9U0Qg69g4w0Zwyzi5t
 iCu9lLCWSW1MqMvjDBBBrgRE51tIDahs9GCzKcBmjqZB8lJQD1r4eHqKqtBknxmr7JI=
X-Gm-Gg: ASbGncuH1Ed547zNhaolU6qW0sZ465nDa7aIrUPnQImbRtqG6rbZvmDCjRQJ0ivYMYG
 BWcmB1PYcL3gx4cMM1evgeCjm6YqDad7Xl3V2ICIM2oMiHMQOChhEexdjI5RTsN1gW9GtHvg8XE
 FjUMAfZKJLBF6DwCm8pea1GLpmn5M/+wzNMhk5Q8Ixme8WyaBz+K2uoQTr2W3gMxYXslp8vFYAX
 8qk2xiMji8ublr+wwXjfOK1iM8+iMJtWONus7+5sku9WVBYKD2AH/Nb7T1GgVKMZwFZopZnV/Sy
 n/l5Q7+NTE1DdX9yZ33J8LOBhuDcEssgUIq+sNDzxWTOOseV4/va4jFLhg8uwzSNYzltlBXNa0W
 crUdoAKNTjZ5nYcUKXWoz/h7OVI0aERtfGCy9crCaTFOlIUgsgSlF9xQx0MWDI0xNa/DD+NRAPs
 TDGDV5G32DZJYo1tv0CzSMqWg=
X-Google-Smtp-Source: AGHT+IGotSL+4T08nNdItuMy0Sq1VsJk7rSYLuN3aKB/APH0tYZAwymYcuhxHln9FHng26vXek1FSw==
X-Received: by 2002:a05:600c:83ce:b0:46e:394b:49b7 with SMTP id
 5b1f17b1804b1-46fa9b16597mr61536225e9.37.1760064999929; 
 Thu, 09 Oct 2025 19:56:39 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0e70sm1799837f8f.40.2025.10.09.19.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 19:56:39 -0700 (PDT)
Message-ID: <78a13e96-1404-484d-a985-6b403fd1462c@linaro.org>
Date: Fri, 10 Oct 2025 04:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/avr: Use vaddr type for $PC jumps
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251009200525.33987-1-philmd@linaro.org>
 <3460610b-5c1a-4189-8f0a-fd04897effb5@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3460610b-5c1a-4189-8f0a-fd04897effb5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/10/25 23:42, Richard Henderson wrote:
> On 10/9/25 13:05, Philippe Mathieu-Daudé wrote:
>> translator_use_goto_tb() expects a vaddr type since commit
>> b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
>> translator*()").
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/avr/translate.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/target/avr/translate.c b/target/avr/translate.c
>> index 804b0b21dbd..20191055861 100644
>> --- a/target/avr/translate.c
>> +++ b/target/avr/translate.c
>> @@ -87,7 +87,7 @@ struct DisasContext {
>>       CPUAVRState *env;
>>       CPUState *cs;
>> -    target_long npc;
>> +    vaddr npc;
> 
> Ah, here's where proper typing might have saved us a bug.
> 
> npc is not a virtual (or physical) address in the normal sense, it is a 
> *word* address (i.e. byte address / 2).
> 
> So I think you should just use uint32_t here.

IIUC the field is 24-bit wide, OK.

> 
>>       uint32_t opcode;
>>       /* Routine used to access memory */
>> @@ -981,7 +981,7 @@ static void gen_pop_ret(DisasContext *ctx, TCGv ret)
>>       }
>>   }
>> -static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
>> +static void gen_goto_tb(DisasContext *ctx, int n, vaddr dest)
>>   {
>>       const TranslationBlock *tb = ctx->base.tb;
>> @@ -1004,7 +1004,7 @@ static void gen_goto_tb(DisasContext *ctx, int 
>> n, target_ulong dest)
>>    */
>>   static bool trans_RJMP(DisasContext *ctx, arg_RJMP *a)
>>   {
>> -    int dst = ctx->npc + a->imm;
>> +    vaddr dst = ctx->npc + a->imm;
> 
> And here...
> 
>>       gen_goto_tb(ctx, 0, dst);
> 
> ... and therefore also in the gen_goto_tb argument.
> 
> The bug can thus be said to be within gen_goto_tb, where we don't 
> convert from word address to byte address.

Oh I see. Then avr_tr_insn_start() is also buggy?


