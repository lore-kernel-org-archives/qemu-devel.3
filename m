Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF628C5DF94
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 17:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxT81-00067i-78; Fri, 21 Aug 2026 13:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxT7y-00067D-TC
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 13:34:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxT7w-0004kh-SS
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 13:34:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84fa3b14ee1so926185b3a.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787333639; x=1787938439; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PCHyY24BhFmHYhBa2138tZyvo8GKjMdgl4rFWVMnGgw=;
 b=fHic+tJB8TCgye0tGgO14fYpSWcLMd8ffHf2FYaFcnK/Z4SFeR0ysi03wRSd2lrDDm
 dBoLlgb7Wj3EavblFK8W5M/eq6umzAdDcMJu7S2nRbZ3bOtW/hBoEwAZv55fI8Yv/f8c
 KjyMRj8xzwN026SVNe1RIQKi5QISiRZ+VOwzLmhKnUu1rfluka43xZH25BaIfzf/xcea
 AcECHdacvdYipsxMSzlXl+49JtJhKGMbIJ7e1dTRtX9/EYyxhse8L3sUFV5EDHbPpSCu
 AUOioa5mzGl9+y3B8H8cvdNhrEJLDJyrHVgbMb6lJW35+GhlB0pMiNFOtCSFb98VAMHG
 TmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787333639; x=1787938439;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCHyY24BhFmHYhBa2138tZyvo8GKjMdgl4rFWVMnGgw=;
 b=lDSmmUk4cPGw+02mOY065DSkpSwVdULmfnMGAoioQuL0H5tDkKhWDIo2R+ppPSBu2Y
 LlJEZwrz4pzuwnJnggYdKGHfIOYSG2K3Cc+pKHgBLSSYeYCqYVwzoEKsZ3QEW/QrVccN
 3jFHDyhR8agFanoRzY2s3j2RRwPcML3oxJZJNrC+UhOOoOnDPT25bFjPDf5MBKi1+Lui
 Ewoi5GhILAcF3+1k87vMQ0+b2dY9mCJxoT8Zw/KiNSaW6ZL26C/2qQJChDxAzS4qcYuQ
 roZCJMoVt4O71T+bwzo3ZvX3+2zSvSEbAeuxRrjCn/X0NP3tcxYdYvV++lvSYRZT+0vQ
 TCmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rres/IY7fPbhIGnTdNm0m/eIRjnLpaQZxVrhcDZKJlS2I2Xqg0egIiMCM9Aak+Q8wKBZnHOixnDkFs+@nongnu.org
X-Gm-Message-State: AFuF++kFGr6pKOxWD6rsP6aQo49r1o66m+QGy5Ys9/OlRDOE0YjHrD0C
 GUp81B00iOwRXxWs2zRXNGxdY38gx3qw/eCejXeG1vX0CsL6XWmjIn0eq12ER0mnBrE=
X-Gm-Gg: AR+sD11oGKtQ7acVF9VCdAU7IaCORhyZyxTcAcO8Ce6ykHNLY2Yd2Zziu+vSLTwaDqW
 zoa754B17Yqe6K7ZQAnZdbLibZXVqqUmOT3CjODDtf6k+M8rO6TFAEa4D5Am1taSY4kWM+dF9Gv
 FJInwkh1CM9Ras21nUC0t4u5KvxMrFlrxh1fYo27V2Q1g/vFgu6mznxCeAnch8uhZ5BlRcPtLBU
 y9GAvkSTtcCapKPpFXdafIBCsfC3+AHf8x8Vl1p6TLdmKfSY8kmQyfzD6JxYmvCpsucYyk2/+2c
 0XEqVmflnbKhubgz/rfOLfvuIwzE++sO1AvY4M9sPWEiLdowXM70UArvWfXyDyWalchDqxmRir4
 sHjFFDpYTiDRxiv11t5RwFCMkJKW7J4Y2eK6IlmigANbOt5h9YpAjzIwBg//mhehcBWq9cgru7e
 n3xgEGfQbweIeADUUXwi+ODYHA9hdowucVicta9xyrECbbav91n4eLeNKNpbQngtWcMJyKv2eXs
 87UL3ESoJPD4Os3
X-Received: by 2002:a05:6a00:4088:b0:842:708f:39be with SMTP id
 d2e1a72fcca58-851f9aa2acfmr13693555b3a.5.1787333639244; 
 Fri, 21 Aug 2026 10:33:59 -0700 (PDT)
Received: from [172.20.6.168] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3671af8sm3247546b3a.56.2026.08.21.10.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 10:33:58 -0700 (PDT)
Message-ID: <60ddd59e-0f7a-4ad5-b62d-3c6c9fd01e46@linaro.org>
Date: Fri, 21 Aug 2026 10:33:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/38] tcg/optimize: Fix s_mask computation for shifts
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jacob Young <jacobly@ziglang.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
 <20260818170155.1907006-3-richard.henderson@linaro.org>
 <0c4e3399-5539-4840-876e-1844ae9122e6@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <0c4e3399-5539-4840-876e-1844ae9122e6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/21/26 09:51, Michael Tokarev wrote:
> On 8/18/26 20:01, Richard Henderson wrote:
>> Skip s_mask computation for logical right shift.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 93a967fbb57 ("tcg/optimize: Propagate sign info for shifting")
>> Reported-by: Jacob Young <jacobly@ziglang.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/optimize.c                     | 11 ++++++++++-
>>   tests/tcg/i386/test-i386-opt-shr.c | 21 +++++++++++++++++++++
>>   2 files changed, 31 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/tcg/i386/test-i386-opt-shr.c
>>
>> diff --git a/tcg/optimize.c b/tcg/optimize.c
>> index ed2ff32ed2..d12babad88 100644
>> --- a/tcg/optimize.c
>> +++ b/tcg/optimize.c
>> @@ -2656,8 +2656,17 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
>>           z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
>>           o_mask = do_constant_folding(op->opc, ctx->type, o_mask, sh);
>> -        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
>> +        if (op->opc == INDEX_op_shr) {
>> +            /*
>> +             * Logical right shift will force the sign bit zero.
>> +             * Don't bother computing s_mask and let fold_masks
>> +             * recompute from z_mask.
>> +             */
>> +            return fold_masks_zo(ctx, op, z_mask, o_mask);
>> +        }
>> +
>> +        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
> 
> In 10.0.x, things are (were) a bit different.  Does this back-port look sane? --
> https://gitlab.com/mjt0k/qemu/-/commit/77ad6491326b4d0b2907f0ed9d504d6f490e245c
Perfect, thanks.

r~

