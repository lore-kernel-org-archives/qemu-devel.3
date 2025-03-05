Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA43C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd3C-0000b1-JC; Tue, 04 Mar 2025 19:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd39-0000ah-HC
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:55:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd37-0007we-E1
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:55:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bcb1a9890so1841185e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741136148; x=1741740948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uAGo3NGmikpZkIcE56ZMcshiOURcTU0IOT+kWtxbtXU=;
 b=YOdG7gMeHD9x9/Fyi7vRdsOVREQ0HlD4LIR45fyl9nczmaJJWmCvdqEBBam+9xAxlO
 xbX/rHqVbtGiWkzNtSQQ1PBkQ8gJ/dW+US2U6vQ1avHs53la+FA23I9VP+xSN4yRIjjo
 pPAFw7FCAtVCOHzWY8zpnicYvvOgC/hUCu2x8FxC0S3bjaVr2zqL7Gn0Qlpe1XpWM0+J
 m0kIPDMrss+4JfbzC8bmcpdG3kRiGzOiiQRJD/DNSs5lDeNJsarFsQLpOg77XaPFtlux
 CWtLkEk3KN9eNpgNsRuQ+0lpT+OQweGbEWWgiQ58Q+Iu46AVtoMGgG8PiqvsXrro7FB7
 PKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741136148; x=1741740948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uAGo3NGmikpZkIcE56ZMcshiOURcTU0IOT+kWtxbtXU=;
 b=rUsfv9FSYs0ixOez3MNtCXa1ETw5mFC2kwxNcBQUpCcOOgo99/o8pyU88hkz3Mv1cV
 yWxdiBaQYsdl8oUG8vk6Jy+/wIyEGxXxEhNWrJGt6uXjrQlNEXBPSJ+AewGUL2AKBdd5
 DA3JwJNLyHBvq2JZ5ZJHTZ5Y7PaQYShuoWnLt731eiE0RFavGlRAKBx2W/SM3XvITJjL
 w9rg+U4KN7tErvsVYwblaN1lRMRmWGfvmVjqtXRaCe0rI3603sVz2pjiE7PvD5MCPYWR
 JXN0d3urXRbE4tDwC66DIx0ZARPnpUGpVVum/YIK1MouIzXFrtTFQlsVBB35M03iVqZk
 ysxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTpflBuiFjHTXsqbHvePjTvu7beTEdLn4vsQOOr9QjoYWo6GmRj7vIn7Wo8JIGoSh+wEcInk0eVu7a@nongnu.org
X-Gm-Message-State: AOJu0YwbXToAjFo8Qb+jb2fwprs0i9HdeK/twPg7VIH9NH3DH6FToTvs
 /2u6LsAktOwkenK4cT2nKtRnL03LdwRYo5iuhYg2aWFDJCAkoj+s94uNI40zjGg=
X-Gm-Gg: ASbGncuJ1GBF8Nr1DVZUhccoucldH57xhL7FJDif1qfkwJ7tTFukpaPnwHlKpEvb5Y4
 WkbadOQ8Kt1hPIborbF516TjkTd9kF/chiDzxTlXgpzBANbGTF/i2NXCTuVefL50SNvXsNwtDzC
 AJwvIsoQ5WVj3R3bbVEwal9BJ8I1Wd2KkeJYJi0lRnBE7rlUgSbOhis+1dGzBkGOl/JfxsujcYO
 jKDBvJb3FB5+fPq5CdkXZ3IDsvJGoSYYBRJ9BUkzgckFKl3sinNRRQfBwCwzFYMaNWdLSQmRZvt
 hnLMkhjaV2rT1u/64Gu9IKuMg42Ey+RloVKQv/vNNptgDMcl4WJ/ScAcxp1Y0b6Kmi2bPNrl79z
 LrY3iye1OB8NU
X-Google-Smtp-Source: AGHT+IHXHXfcF5sV17aFqBCr+sTudEFeVdAtVcHm+K/dp3+EdymoUHy5rrydaoWjM5c6CzOspZPbAw==
X-Received: by 2002:a5d:47a5:0:b0:391:1218:d5f4 with SMTP id
 ffacd0b85a97d-3911ea411f0mr738235f8f.23.1741136147684; 
 Tue, 04 Mar 2025 16:55:47 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a7473sm19505109f8f.38.2025.03.04.16.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 16:55:47 -0800 (PST)
Message-ID: <d4f22c7c-66cd-4dc3-b024-7f6e9626b72e@linaro.org>
Date: Wed, 5 Mar 2025 01:55:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/24] target/m68k: Implement FPIAR
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
 <20250224171444.440135-25-richard.henderson@linaro.org>
 <81d01563-8a5d-4002-81e0-1b34108bfce3@linaro.org>
 <34beaac3-405b-47bb-b12a-91a0dd3e9f5b@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <34beaac3-405b-47bb-b12a-91a0dd3e9f5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 3/3/25 21:40, Richard Henderson wrote:
> On 3/3/25 10:39, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 24/2/25 18:14, Richard Henderson wrote:
>>> So far, this is only read-as-written.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2497
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/m68k/cpu.h       |  1 +
>>>   target/m68k/cpu.c       | 23 ++++++++++++++++++++++-
>>>   target/m68k/helper.c    | 14 ++++++++------
>>>   target/m68k/translate.c |  3 ++-
>>>   4 files changed, 33 insertions(+), 8 deletions(-)
>>
>>
>>> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
>>> index 6e3bb96762..bc787cbf05 100644
>>> --- a/target/m68k/helper.c
>>> +++ b/target/m68k/helper.c
>>> @@ -45,8 +45,8 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, 
>>> GByteArray *mem_buf, int n)
>>>           return gdb_get_reg32(mem_buf, env->fpcr);
>>>       case 9: /* fpstatus */
>>>           return gdb_get_reg32(mem_buf, env->fpsr);
>>> -    case 10: /* fpiar, not implemented */
>>> -        return gdb_get_reg32(mem_buf, 0);
>>> +    case 10: /* fpiar */
>>> +        return gdb_get_reg32(mem_buf, env->fpiar);
>>>       }
>>>       return 0;
>>>   }
>>> @@ -69,7 +69,8 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t 
>>> *mem_buf, int n)
>>>       case 9: /* fpstatus */
>>>           env->fpsr = ldl_be_p(mem_buf);
>>>           return 4;
>>> -    case 10: /* fpiar, not implemented */
>>> +    case 10: /* fpiar */
>>> +        env->fpiar = ldl_p(mem_buf);
>>
>> Should we consider target endianness?
> 
> I am.  Are you suggesting that the TARGET_BIG_ENDIAN shorthand be 
> eliminated entirely, even from target-specific code?

As we figured earlier, while ldl_p() is expanded as ldl_be_p() for
m68k, it is easier to review using the expanded form, as done
previously in this file in commit 3a76d302047:

commit 3a76d302047ce4518cedef7a9feca1238a00f97b
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Fri Oct 4 13:30:34 2024 -0300

     target/m68k: Use explicit big-endian LD/ST API

     The M68K architecture uses big endianness. Directly use
     the big-endian LD/ST API.

So using ldl_be_p():
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Regards,

Phil.

