Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709AFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 18:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLoD8-0006bt-8M; Mon, 24 Jun 2024 14:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLoD6-0006aN-E2
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:14:36 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLoD4-0006Xn-6h
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:14:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70671ecd334so1483776b3a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 11:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719252873; x=1719857673; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6yl+plya1Sm/ppcZAiJ04vYdtuiMbua9vDWHIi4U3M=;
 b=kc2d3TPQ97gIJcBlvHVLdKdcLSPfd7KnkWJX9BBsjTHLDTZ7AncxA2XMpsZLbj+EEW
 W00atZmLZBL0PUn4JO53UgtIu+8jSjtRM5UWj4FL+tznAAMcWb0gv5IaDtVrV0KIYUYR
 8+LayAE7X47dSPWnXs7e0vfriaUOJehwgbN26sQgtYxFPVZPRYhJ9b0omSh41sf4hEjM
 NguHbs5yl/ftT9lBjhLgt2jumMOFq+/bo4RVGng2mAO5yxpvabu835syvatuY002M0AL
 u9vFhQ5xnGXM2c5/lznUlHJvqe9Y5L6W3GE4x8B3eJxbwdY9UITE7/akC8+HUp7IVVrW
 5aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719252873; x=1719857673;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/6yl+plya1Sm/ppcZAiJ04vYdtuiMbua9vDWHIi4U3M=;
 b=pE3eJdxM/e+VOX7fQokXLPwp9HS+xVwuiSqHXM11p2KERP0dPXUtHWKn7rb8JrFUEY
 my+lp7MjbWaOGBXF16OEpblHigwYuRH7+QDzR35LrJz1SmKbXaRmZtwUfrcuYkj6ASIJ
 iDiPy0aMeyyIwyKpoqfIPaa4DEcj5grLqj5/9lNblaTVabTU+Vb4aEgAQUEmmQiWRG7F
 6cB16HzOdr5zAKMoHlLuuGwytuV+1ybW9HILOhLDaWct7U9h13oVYAo7vmhp3YHPUVlY
 LdOIDEhOuJ8qXzxJdD2deUsvz13+W8aRuo7Eni36FkSpBVRbhuImGK4zFveLm9d+CiNT
 K1cw==
X-Gm-Message-State: AOJu0YzEeUWSvJ7y4gTleblU+naZM9n7/6K20C0z55npkBTmoe1x8np8
 DwtOmc44iOwvLN2v9lBgL4lkOWJxbnFASpDSllE4yaYl/qDddxBGcpwt1hxDhrc=
X-Google-Smtp-Source: AGHT+IHk8FX9VdIgRLnChDQZFEUlTmHtkZocxJsgwael2vHwND4DLihP1G6As8bdl7U7wvR6hzwx7Q==
X-Received: by 2002:a05:6a20:c18:b0:1bd:706:cca8 with SMTP id
 adf61e73a8af0-1bd0706cda1mr3412401637.6.1719252872729; 
 Mon, 24 Jun 2024 11:14:32 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b401:1758:f7d8:1e03:a6d:61a0?
 ([2804:7f0:b401:1758:f7d8:1e03:a6d:61a0])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4d54ea2sm5793276a12.54.2024.06.24.11.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 11:14:32 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] target/arm: Enable FEAT_Debugv8p8 for -cpu max
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org
References: <20240621143903.3598230-1-gustavo.romero@linaro.org>
 <20240621143903.3598230-3-gustavo.romero@linaro.org>
 <CAFEAcA_tNM7Oo+rHHTCBW=LpibieQNktczqv2R=34gPv5smD_g@mail.gmail.com>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <23a6ff61-2b30-dc45-ffe2-ed24e53a19f4@linaro.org>
Date: Mon, 24 Jun 2024 15:14:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_tNM7Oo+rHHTCBW=LpibieQNktczqv2R=34gPv5smD_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.232,
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

Hi Peter,

On 6/24/24 10:27 AM, Peter Maydell wrote:
> On Fri, 21 Jun 2024 at 15:39, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>
>> Enable FEAT_Debugv8p8 for max CPU. This feature is out of scope for QEMU
>> since it concerns the external debug interface for JTAG, but is
>> mandatory in Armv8.8 implementations, hence it is reported as supported
>> in the ID registers.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   target/arm/tcg/cpu32.c | 6 +++---
>>   target/arm/tcg/cpu64.c | 2 +-
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
>> index b155a0136f..a1273a73a3 100644
>> --- a/target/arm/tcg/cpu32.c
>> +++ b/target/arm/tcg/cpu32.c
>> @@ -82,8 +82,8 @@ void aa32_max_features(ARMCPU *cpu)
>>       cpu->isar.id_pfr2 = t;
>>
>>       t = cpu->isar.id_dfr0;
>> -    t = FIELD_DP32(t, ID_DFR0, COPDBG, 9);        /* FEAT_Debugv8p4 */
>> -    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 9);       /* FEAT_Debugv8p4 */
>> +    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
>> +    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
>>       t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
>>       cpu->isar.id_dfr0 = t;
>>
>> @@ -93,7 +93,7 @@ void aa32_max_features(ARMCPU *cpu)
>>       t = 0x00008000;
>>       t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
>>       t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
>> -    t = FIELD_DP32(t, DBGDIDR, VERSION, 6);       /* Armv8 debug */
>> +    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
>>       t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
>>       t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
>>       t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
>> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
>> index 71e1bfcd4e..fe232eb306 100644
>> --- a/target/arm/tcg/cpu64.c
>> +++ b/target/arm/tcg/cpu64.c
>> @@ -1253,7 +1253,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>>       cpu->isar.id_aa64zfr0 = t;
>>
>>       t = cpu->isar.id_aa64dfr0;
>> -    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 9);  /* FEAT_Debugv8p4 */
>> +    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* FEAT_Debugv8p8 */
>>       t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
>>       t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
>>       cpu->isar.id_aa64dfr0 = t;
>> --
> 
> We also need to add Feat_Debugv8p8 to the (alphabetically-sorted)
> list of emulated features in docs/system/arm/emulation.rst.

oh, I forgot it. Thanks, done in v3.


Cheers,
Gustavo

