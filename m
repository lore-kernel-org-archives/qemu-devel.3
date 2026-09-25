Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1375C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8sF-0006il-76; Fri, 25 Sep 2026 12:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8sD-0006iA-4E
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:34:09 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8sA-0001my-UM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:34:08 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-3a0b0fa2055so663359a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790354045; x=1790958845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8k0GeIq/elNnRc8rE4A+91KWCyinznyHOoVU4iBo2cE=;
 b=AyqvuJLl9j+LUwLhCP0GcRBVAC1GeGRgHhpEBiXbkrmZgKOYGuwnSGeW79ec6jrlna
 Lu5A9vjSLJncOnuTb2m6eO5Qd2CpRYNJvtKmPdC3FHfrMqLW8QuhphfBFke1dJYk+F95
 DPbU2k0kzhvXBWLCAYGd/yRbP/DFWP3RaNFFnATThX8mvpagDXCvI1Do5z0hb+LBGn3A
 auHP5s+HWLg0GUF1QYyHrTGkh10+JlpxI3vYNdRYRJtqLa3lPA7pxs+9w5zG5AtppG+r
 WcF3RUyT9Wvl7UfgKeqOc7n3wRTzEJbbVIGOkL8hMqOjjbqJFj4e/OpnUgAPf6xiVW/9
 BU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790354045; x=1790958845;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8k0GeIq/elNnRc8rE4A+91KWCyinznyHOoVU4iBo2cE=;
 b=f6qqmWsh4aM95ZZ3G7utzTYJ92csa5hlbLIZPZ5umLsb/hRAJove+OWrKBDLC+msUb
 2mQbd3ljxJZXD2KhmklkmtCB9AVf95l2/1BP928jiGdd+jjNECeBU8YE/8OiBU3wOgIq
 IkwfW9wHKZWMhABnz7/7KU62Jju7b1B5W8htYUTYwQ2m8lTKOnVe+oZ4O3jTGzZoXe0p
 KBWqluE1TkYOuqa4y6bmyLglA+rZPFSKHmBsbnWL0fA6PPdoFyyIz/V5uwf3m5eiWm1T
 7AFYdV70ZtnjTKlDOkEWUqEBPyM9YzLT6dgIdR07XwMniC3vSmWVg7M1Wtv0BRlU6GOi
 2xkQ==
X-Gm-Message-State: AFuF++nCMtscx9QuIMqT70u8Inl4coLKIV5lZDJuubFyKRwnPOkZt5aw
 0y9ExISZVB0VRE5PXdsiq6V4TL3gpEXCfsCJXVtOJWOrd6PB1Wxe6V9cM6rYccFUZsWPByDhVE+
 r9tnD
X-Gm-Gg: AYBFou0eacHQma6IO8A1g6sFZ7Au2D0iIxb+nxPpYtRzewFqZZQFiYtXE3PEmeitL48
 fwRBSL7+l2GFyHOfPsMkW1EQsm2MdS7eJvHvhmxiJvbn/0k/tLNba6GKhzHY56COQPZAGJuv5Yp
 JF+31TFIyIIBnct5Io7Xtcmdida58hoof7Ovy+6ixIgtG8N55P0ivR18GbEa5OSp2uQDenuh7l7
 LbM9/xVvJNNeaXB69aUlSEx9py0gSTapM7ZeTZcrBQs61iGQq3gyE6BeHyujRjG4c/QDWVN2SBE
 uzRQRUpSJXoIqLyXjB5IpdUZe83ionYSI3SIMblXScGgGUpPw+vS7CHyS0F6lGpWT+QTHKfsHt8
 O8Ld63G0nkPHFXE8UkTTfX/5bG/ophzcsfA1uQE99bvhLEGy0FclHdv6GrSpiM8H0oZLTDOv8EC
 RbiSsFOdUTi4znxTA+hb/jbbU1HCW5FUBe5/55nwjLRpPOHdZ0Mbpp/HREsuEkEb8r5Cf1ZvHCt
 ZPkp6lP1ysdOhlWtxCSurbUNp206GuQb6y4OMGAGD1UHl/UFfg=
X-Received: by 2002:a17:90b:3888:b0:3a0:cc33:2287 with SMTP id
 98e67ed59e1d1-3a0cc3324ccmr1036590a91.6.1790354045069; 
 Fri, 25 Sep 2026 09:34:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0c719f86fsm3094138a91.7.2026.09.25.09.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 09:34:04 -0700 (PDT)
Message-ID: <ebd4f4af-b958-4d76-a671-6927fbea1d70@linaro.org>
Date: Fri, 25 Sep 2026 09:34:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/arm: Add PSTATE.UINJ to tbflags
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-12-richard.henderson@linaro.org>
 <CAFEAcA-9BWhLf2AagEcnacxMYKPYGKC=iKKoGRvPg4BW0PtbaA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-9BWhLf2AagEcnacxMYKPYGKC=iKKoGRvPg4BW0PtbaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/8/26 04:08, Peter Maydell wrote:
> On Fri, 28 Aug 2026 at 23:27, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
>> index 296ec8101ab..174f4aa746f 100644
>> --- a/target/arm/tcg/hflags.c
>> +++ b/target/arm/tcg/hflags.c
>> @@ -292,6 +292,9 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
>>       if (env->uncached_cpsr & CPSR_IL) {
>>           DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
>>       }
>> +    if (env->pstate & PSTATE_UINJ) {
>> +        DP_TBFLAG_ANY(flags, PSTATE__UINJ, 1);
>> +    }
>>
>>       /*
>>        * The SME exception we are testing for is raised via
>> @@ -513,6 +516,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>>       if (env->pstate & PSTATE_IL) {
>>           DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
>>       }
>> +    if (env->pstate & PSTATE_UINJ) {
>> +        DP_TBFLAG_ANY(flags, PSTATE__UINJ, 1);
>> +    }
>>
>>       if (arm_fgt_active(env, el)) {
>>           DP_TBFLAG_ANY(flags, FGT_ACTIVE, 1);
> 
> Could we do this just once in rebuild_hflags_common() rather than
> duplicating it in _a32 and _a64 ?
_common is also used with _m32.

We could probably reorg things so that we have a common _aprofile 
routine, which could also avoid the duplication from FGT.

I'll give it a shot.


r~

