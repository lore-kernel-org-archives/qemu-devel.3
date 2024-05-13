Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B8CC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ve9-00031E-R8; Mon, 13 May 2024 09:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6Ve7-00030y-Up
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:23:15 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6Ve6-0004ou-AX
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:23:15 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2dcc8d10d39so50643581fa.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715606591; x=1716211391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=375ou3vYCc2NznAutfRQMVtAv5s2TWWI7vn5ubDH4rI=;
 b=NXv1bBLESmRJtuflsodQ6TqEFZzVJPx5Tc4FCRveq+5mJEJutJUfPqjtUpBotIbz6g
 5OYDBARAniPqOuTY4eRJD7zEwjV4336nwhaep3H25zkTlyFJzG7oLpDPS4QLkx/hdBYo
 UnHLzaEbxNYiMrZBkHFtJIH7PrOGc3gWDXQzCbv9hfdTTe3X4RzfTWaF4YTJzad+uryR
 zrAuR3EzOVbEv5cKCZrHZT5sFvyUlxLlCcu37NglMk7I0VjUnqUzD3Am2jVv+S/AOscm
 tG9Hb5eyWS+HjvNy4rvGJ9EBt7o1g0rRftmQkFzY1lL21uswfaMhrO+lfONy1KN2oTxD
 /SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715606591; x=1716211391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=375ou3vYCc2NznAutfRQMVtAv5s2TWWI7vn5ubDH4rI=;
 b=pnRrnmo9ZpPNy13tDVV2ifMnMKeaR0xwTfcnTA1ZS934JuO0nW5nG8kXnFNcVMyyOl
 eW0lAQWYupgJXJiiTGL+lzqAtbrGEuDNjUk8A5l4B5NWLduBHl8HFgT+M5g82E2BEqNv
 fSowlQ8ACT5jbUxcjY+8vDFjAAFijrUaseL8lM0hTm4W3uJ/os111xf9gx+3zSiR2zh+
 Jg7eWtEK9DyteE9OtRHvRzm3HEzWdKdCEpkRVafR6UnCP6yFhBiVwbrkYy+Gsif4cFzj
 Ejh72DxPq+d9qXCfGLGuYu57HxyNCVGgcJXU6LH18+X+M/hXtXivAyy1O7Nu2dI6K8f4
 f7Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnzItijrejiU8/K2uwt73Pvz8+dujsTrNmnI/ZrtezU+C0M9JVAJlQWKpL7aC33iB2zfp9fDU7cv3wYKMX/uPSYTr8WSc=
X-Gm-Message-State: AOJu0YwrlQMjXGI54kxdV/c09TBjQAV32h8TuXmmD2uLbuolXOg/8o1s
 bUEOLMtCF1znsWNVS2eml1DekkiYML2zJmh5L/t++I9zK2ZazP7zlinXw4nwwAtK4PKeoLuaUST
 ldWE=
X-Google-Smtp-Source: AGHT+IErSSH4FYciQtOpKOTxPvEUqE1VtltzHus0rYxJGWd9pcoVIBnpazPx0uJwdFxf59s4lZdGrQ==
X-Received: by 2002:a2e:8785:0:b0:2e2:802:7d5f with SMTP id
 38308e7fff4ca-2e51fe532c5mr67825461fa.15.1715606591553; 
 Mon, 13 May 2024 06:23:11 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733becfe87sm6210037a12.53.2024.05.13.06.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 06:23:11 -0700 (PDT)
Message-ID: <15733f35-f65a-4af3-9007-7a4e9e4b660f@linaro.org>
Date: Mon, 13 May 2024 15:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/45] target/hppa: Use umax in do_ibranch_priv
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-16-richard.henderson@linaro.org>
 <c9942efa-4f3c-46b0-b29d-9e4107314c58@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c9942efa-4f3c-46b0-b29d-9e4107314c58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
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

On 5/13/24 13:18, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 13/5/24 09:46, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/hppa/translate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index ae66068123..22935f4645 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -1981,7 +1981,7 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
>>           dest = tcg_temp_new_i64();
>>           tcg_gen_andi_i64(dest, offset, -4);
>>           tcg_gen_ori_i64(dest, dest, ctx->privilege);
>> -        tcg_gen_movcond_i64(TCG_COND_GTU, dest, dest, offset, dest, offset);
>> +        tcg_gen_umax_i64(dest, dest, offset);
> 
> Isn't tcg_gen_umax_i64(dest, dest, offset) equal to:
> 
>      tcg_gen_movcond_i64(TCG_COND_GEU, dest, dest, offset, dest, offset);
> 
> ?

Yes, but I think it is clearer to use max.
At some point we might add min/max opcodes to tcg too.


r~


