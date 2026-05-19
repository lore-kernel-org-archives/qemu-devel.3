Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03655CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 21:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSMG-0007kw-Kg; Tue, 19 May 2026 17:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSMF-0007kK-74
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:52:11 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSMD-0004wC-LL
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:52:10 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c8028fa6039so2814335a12.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779227528; x=1779832328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cjoyWxzcc+a2c9gHHTQ2sXqtL7HPTeJX2sYofxYKnSw=;
 b=Inv5RE8fKskK+Z1QD5LXEhe2XYS0UiYLmxO2nMe4xBwt5QaVWSTHgrmHLPiPEWIglX
 EK4j9VbdiKEtEEfiml4odiZHiz/qwHdeq77GE1/G2srgMybQIb/rd7u0kR0WD8oP70HQ
 p0nDQYFC/S9XJuKl+nNhZIXihR5QRRrd4fWSmNrCHf8mtbrcVdt4tSPn3SBNpSKQs11P
 Es2GJUb4ZZZQditS1KWtlRRWoalmZrSEVCY5t2F3GEdRgsKMyJHlN0PYk5Bnarbz9pom
 JV5n0UH+ZTFyljo8/tWfkKaILiLziDIn2SfZkK5lKsI/P6Nzus/l6q+fO3fW1amdpdR1
 3gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779227528; x=1779832328;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cjoyWxzcc+a2c9gHHTQ2sXqtL7HPTeJX2sYofxYKnSw=;
 b=jvfjCuqsZFrufLaikJW0FD2SIaLsFy4a7usPAHuoNELPGBX6xMPHBqEtlrU6Gxsxko
 vFQcTFwRQPAE8HEcfQiLDVdp7kYjABKoSE1bvGZ6EFbPQSVWS13HzEantQaLCDCEknS/
 a4MNecctJNXIx/QSQIwPFm/hR3mCEl9mw+vkWYgXbVWXWNk6+PPYjvlGaDERbthL8U53
 eQZ3XCOIoDFy+7a24datUN2MDg1eyiT5KOG7kcgbID1D11sLPwtpmOoWeiwpyF+FL2lQ
 i8FsqjAPbiHHV8tgqHH4b5U0X7QrE+ARDPMCcyLPQl6TSAfMoSBfafnx7EUzyi/OX4hH
 MPHg==
X-Gm-Message-State: AOJu0YzcMceaO8MY/bkiGG/dCAHGaupHiWUoa9rV7uFwX7NA55zoACnY
 chzsM+VnQz7skgAkohvpsGFbQvcu3IaGybQTadJ7LfM9f+sMQMD1x3mOyLapWcNZNvM=
X-Gm-Gg: Acq92OHLkpIWU8wEsl73AEbJvlsM+d81zF+EPOo7ZG05ZZXVbIwCBogzv23gEeGuVLy
 T+u/YC8hHBN5/0eJXcComG09GuUTgPBfBQ/WefKsdjMo8ERVGWYuBcRiVcDtTOTdzrIkwSW4bv3
 a94u8PY9Nzl3zmblh1GbdmQ6GEsiNQhdNNO9VoruDtALdCmdN+IQTOChhHrv074aKBGhHuVgEx/
 kqMGEBscEYD1MNNtHfms+LT4FfjDVfWg1jl2aaNfc+VXgnNmPbvhSAn9TEyA910MXXi98iujkO7
 K0+xlGpLD5PsdeHy8mybvOPZwmMXOHFTl6POjBKAAiE+rnJh7WHn6Py0voba2qyOGGwG3Z+sifF
 5ddkk8gEOXhPPPtbUYRvIimd3ItNWcDdVCbvGTZW5Nfv5J/ngxiMttV87eJt0MjX+oSLC6KFMgd
 y/17h+r0w15FyQ83rkiOPmH3IfLtBEL1dysmW7
X-Received: by 2002:a05:6a20:7486:b0:3a2:d79c:416d with SMTP id
 adf61e73a8af0-3b22ed6295emr25180204637.43.1779227527629; 
 Tue, 19 May 2026 14:52:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb07b007sm17563097a12.11.2026.05.19.14.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 14:52:07 -0700 (PDT)
Message-ID: <90811f89-79a0-4e34-b6a8-d349353620f0@linaro.org>
Date: Tue, 19 May 2026 14:52:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 45/63] target/arm: Implement FMLALB, FMLALT for AdvSIMD
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-46-richard.henderson@linaro.org>
 <CAFEAcA_4wU+wndbAqjnObpvnLit11OVDZvTZ1RWy_q0cNfH7uA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_4wU+wndbAqjnObpvnLit11OVDZvTZ1RWy_q0cNfH7uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 5/19/26 06:41, Peter Maydell wrote:
>> +static void fp8_mul_finish(CPUARMState *env, FP8MulContext *c)
>> +{
>> +    /*
>> +     * FP8 multiplies don't update FPSR.{IDC,IOC,IXC,UFC}.
>> +     * Since this is multiply-add, DZC does not apply and only OFC remains.
>> +     */
>> +    fp8_finish_fpst(&env->vfp.fp_status[FPST_A64], &c->stat,
>> +                    float_flag_overflow);
> 
> Looking at the A1.5.5 text a bit more carefully I don't think
> we should propagate OFC either for FP8 mul:
> 
> "When the rounded result with unbounded exponent has an absolute value that
>   is greater than the maximum normalized number for the output precision:
>   — Generate one of the following outputs with the sign of the result:
>   — When FPMR.OSM is 1, the maximum normalized number.
>   — When FPMR.OSM is 0, an Infinity.
>   — Do not update FPSR.OFC. "

Huh.  What an odd way to define things.  AFAICS, this means no exception bits are updated 
at all.  Why not just say that.

> Also, I realized that this squashing mechanic means we can't do
> the handling of invalid input formats the way we do at the moment.
> The float_raise() operations done by fp8_invalid_input() will
> get squashed for multiplies. I think the fp8_invalid_output() part
> is still OK because we only use it in the FP8 convert operations.
> 
> We could perhaps have fp8_mul_start() explicitly check for fmt1
> or fmt2 being fp8_invalid_input -- it has access to the real
> fp_status so can raise Invalid and InvalidSNaN there.

Here's the thing:

FP8Unpack doesn't raise an exception itself, just sets fptype = FPType_SNaN.

For FP8ConvertFP, we then explicitly raise invalid and return default nan.

For FP8DotAddFP, we notice nans within a loop, setting any_nan; after the loop, if any_nan 
is set, we return default nan but do not raise invalid.

So I guess we don't need to do anything special during fp8_mul_start.

One thing I could do that might be slightly clearer is

static FloatParts64 fp8_invalid_input(uint8_t x, float_status *s)
{
     /*
      * Invalid input format is treated as snan, then one of the uses
      * will convert to default nan and raise invalid.
      */
     return (FloatParts64){ .cls = float_class_snan };
}

What do you think?


r~

