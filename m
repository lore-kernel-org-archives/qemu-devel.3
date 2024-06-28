Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA146C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 22:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNKC4-0008Rz-3c; Fri, 28 Jun 2024 18:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNKC2-0008Rc-Dx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 18:35:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNKC0-0000FE-LR
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 18:35:46 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-706b53ee183so1617836b3a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 15:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719614143; x=1720218943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abZdrPF4hCSE+1ih2xnR0XS6lZMK3zxSdKv8uCz3k8I=;
 b=H09UScjoswCA6W0soGWViyx/oeTF/obtsHSVH9jBtdURWhEakMyj922ZZ2bi88FAdJ
 /p9dud6dDhqcYlcVNWPSHiYMqgayapJq5VrCjsIcM2PZdYLhvuXdcfZ6SZTu8S8d1Fha
 OaGruyl+mh9y14tcNDvGsvvvgcJNZ/uN+iybcVwl0llpEvJ4JKiwmzxjXEijXtC/9T/R
 C6WeLKeGp9/8MCIeg6RNloNFTVZuMyYJSfl2Xl7+oiYzJC+KrPeoFjshBCCWOm4OrXF2
 AT+Sh//5X+jTWbHn0h5MJzJNW2MTIMM/3Mi70zwFLngZvU6f05HNrI4EriaRt9RUbzFx
 2LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719614143; x=1720218943;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=abZdrPF4hCSE+1ih2xnR0XS6lZMK3zxSdKv8uCz3k8I=;
 b=gfhj3IaCq/BljRoNcoIA3+wPQtJ3V54mUvxag7Uxe0EySVf0hBxFXpNMrDG4PJZ6xt
 eJcXeV/brMwNfUejxi5Jcs7OmgnBiLv9y5fMoa0TmklfhLkcVelNgrU2uDJyMyUy0scx
 moziLpoO1154hyCtrAb6dQmNthdPYl1byxp99BsxPJ/DV2YO393sbD2oeasxN4mHV9Um
 My2OhnyY4GfTp+o2THPYIDaT+HdGw8kpkN1209W8d55vWC2dVXwQPKUmuNxyGb0JSmqb
 rPwu0ZjPiwOmKcejhBOnnBzsIx2Cr5WFPw+QkN5ynK1iYHoqMcPQs6db25CX7wO0fRhk
 2zDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY7q+l2kz7Deejfi2gGpZse7fGTm/9KjkrqR/C3sTqk/7hYokqnakJjkhToaCw73o5BFGc1gWNfw4IgJKxNmCgVuU3Eqo=
X-Gm-Message-State: AOJu0YxqrOssFZeFy+WNe1FF3mOdX9Q9yOIV13wK/TruCzYMif13GUjf
 t9EVrQNvBO/rxiRy9BAaqR82ksYIMUnypVgkHXRS8qRMJbwmrX2pOwi0Qgca+3w4qXXxhYvOn4t
 P
X-Google-Smtp-Source: AGHT+IFTGOfr2lOmUyU2DCWIQrEqEwnalRGWdhY9mRVeqCWWmRfDkmyhwiZr+xsyYS+YtcvC3FSilw==
X-Received: by 2002:a05:6a20:5512:b0:1bd:2656:4e64 with SMTP id
 adf61e73a8af0-1bee4910ac2mr3790009637.11.1719614142497; 
 Fri, 28 Jun 2024 15:35:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6afb9042sm1751994a12.41.2024.06.28.15.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 15:35:42 -0700 (PDT)
Message-ID: <b681af9e-608e-4c21-a9cf-7fdf717c1d30@linaro.org>
Date: Fri, 28 Jun 2024 15:35:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] target/i386: fix gen_prepare_size_nz condition
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
 <20240628124258.832466-3-alex.bennee@linaro.org>
 <627f05b5-7abe-423f-829e-4215bcf1bccd@linaro.org>
Content-Language: en-US
In-Reply-To: <627f05b5-7abe-423f-829e-4215bcf1bccd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/28/24 10:54, Richard Henderson wrote:
> On 6/28/24 05:42, Alex Bennée wrote:
>> Incorrect brace positions causes an unintended overflow on 32 bit
>> builds and shenanigans result.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2413
>> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   target/i386/tcg/translate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
>> index ad1819815a..94f13541c3 100644
>> --- a/target/i386/tcg/translate.c
>> +++ b/target/i386/tcg/translate.c
>> @@ -877,7 +877,7 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
>>           return (CCPrepare) { .cond = TCG_COND_LT, .reg = src };
>>       } else {
>>           return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = src,
>> -                             .imm = 1ull << ((8 << size) - 1) };
>> +                             .imm = (1ull << (8 << size)) - 1 };
> 
> This is incorrect -- we want only to test the sign bit.
> Perhaps MAKE_64BIT_MASK((8 << size) - 1, 1) would make this more explicit?
> 
> I'll have a quick look at the issue and see if I can reproduce.

I can't get the cdrom test to run at all; I have no idea why.

1/1 qemu:qtest+qtest-x86_64 / qtest-x86_64/cdrom-test        SKIP            0.00s

But

QTEST_QEMU_BINARY='./qemu-system-x86_64' ./tests/qtest/bios-tables-test -v -p 
/x86_64/acpi/q35/mmio64

fails for me, and is resolved at 15957eb9e by reverting

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4735f084d4..022469845e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1084,13 +1084,8 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
      default:
          {
              MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            if (size == MO_TL) {
-                return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst,
-                                     .mask = -1 };
-            } else {
-                return (CCPrepare) { .cond = TCG_COND_TSTEQ, .reg = cpu_cc_dst,
-                                     .mask = -1, .imm = (1ull << (8 << size)) - 1 };
-            }
+            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
+            return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0, .mask = -1 };
          }
      }
  }

I fought all afternoon to try and debug this, but was defeated by qtest.
I really wish we could change our tooling to simplify debugging.


r~

