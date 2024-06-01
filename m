Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BC7C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 13:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDOuf-0001lG-Px; Sat, 01 Jun 2024 09:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sDOuf-0001l2-6S
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 09:36:49 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sDOud-0003wd-Hp
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 09:36:48 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-43de92e234dso26559441cf.1
 for <qemu-devel@nongnu.org>; Sat, 01 Jun 2024 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717249006; x=1717853806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=INpYFhFYyN8azrV1o6IjXgVgU1ek/6/QJQnDHmC/yoU=;
 b=kZVygHVWHPIz6rBX8KydYdfpF4dU1WQXRGEJt8lpb5+PC2FfJqpJVwU4mw7ZTqL7FL
 PyyoKtQtLDrr9QaVw4eWrC8iTMHFlNRLDwANS+daxr/nrBaStsIwWw++KKXodwKgflFk
 HbXnscJY12B00Plws8dwbdW/D/qrbfz4JNSzATCy7TQZlqc5/8r2NLC02jwg7cG8FdCI
 FfKf2dcGdC7N64PoqVbXF6kInxypElImGtQQeGhD9DfO+W7KuUu1J+44e4eTlHAyMed3
 BZwFoEke2p6P6enpfALLnACwkX+wyEY93dg/3x9xBN8tsb9nF7duvnhXU0mzOFt50TZi
 B07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717249006; x=1717853806;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=INpYFhFYyN8azrV1o6IjXgVgU1ek/6/QJQnDHmC/yoU=;
 b=CHSD0MM1cP1JjUIMig+LipqgwwSyjYSjMuNOL9ZPTY/Nzrmd06NLA/ZiJQuP7gX2Yu
 wDxFAIdR9j+11Db0jUHWj9IDJAT5+pBAt1E0YqoXBhXRuYqwWqXeoHJ6XCvEx3UZKFzj
 DmxiGCqLOH2f5uFM9PoG9UQafFh4DHfmMX86u7MUkLs6bC3Xwrs8YMh4ImU4EuU9RXGQ
 dHzL1N/ElnLVPzVwd8jIzz/TufixvHQnVk2m665z2Kl9Y3g8b3I1X1OGXcg9M8uCYqIT
 J6Rhns62/646809riDVWFfUbgn6rOyxvdHMyXVV012s3P53QnR+TFlKVp630U/AVCxpB
 L70Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWydnKomMj4aTJ7jkuSETBwrhM2IromEZC4hmcVc7D+H13M/0vB4sIoncuZqNiebaQA2WUbs5jT8MEIlI+D43DPxXzSb4=
X-Gm-Message-State: AOJu0YyWdP65O/s4ioYJ1O3oqdBDjshb5/K/vhjk7UjyQCFAohneVuDf
 9whBxWBjt++8p8W2j+XckS3PT3p9tp3WWm/1yS5e2J527N51E3eKAbtAc8jQ6oU5yXnPQNvPw6j
 s
X-Google-Smtp-Source: AGHT+IGqV5GNmnoZKkTtkf38V18Kbcf4Axxo0Q18+tlcvLHJ9rAcTd25EeTJK5yNm/r6QP5kggw38w==
X-Received: by 2002:ac8:7f4f:0:b0:43f:ed37:49f3 with SMTP id
 d75a77b69052e-43ff36597c3mr92357751cf.24.1717249006190; 
 Sat, 01 Jun 2024 06:36:46 -0700 (PDT)
Received: from [192.168.223.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44001a76adfsm5345011cf.82.2024.06.01.06.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jun 2024 06:36:45 -0700 (PDT)
Message-ID: <59f7895c-5975-4ca0-98fd-1600495e24bd@linaro.org>
Date: Sat, 1 Jun 2024 08:36:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: nochain should disable goto_ptr
To: niugen <niugen@loongson.cn>, qemu-devel@nongnu.org
References: <20240531101744.1683192-1-niugen@loongson.cn>
 <044af09d-4856-40f0-ae27-df6522e4dbb4@linaro.org>
 <042b0650-1fef-4730-a80a-abb7361cce29@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <042b0650-1fef-4730-a80a-abb7361cce29@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x831.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/1/24 00:57, niugen wrote:
> on 2024/6/1 01:32, Richard Henderson wrote:
>> On 5/31/24 03:17, NiuGenen wrote:
>>> Signed-off-by: NiuGenen <niugen@loongson.cn>
>>> ---
>>>   accel/tcg/cpu-exec.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>> index 2972f75b96..084fa645c7 100644
>>> --- a/accel/tcg/cpu-exec.c
>>> +++ b/accel/tcg/cpu-exec.c
>>> @@ -173,7 +173,7 @@ uint32_t curr_cflags(CPUState *cpu)
>>>       } else if (qatomic_read(&one_insn_per_tb)) {
>>>           cflags |= CF_NO_GOTO_TB | 1;
>>>       } else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
>>> -        cflags |= CF_NO_GOTO_TB;
>>> +        cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR;
>>>       }
>>>         return cflags;
>>
>> Why?
>>
>> The original intent of nochain was so that -d exec would log all blocks, which requires 
>> excluding goto_tb.  There is exec logging in helper_lookup_goto_ptr, so there is no need 
>> to avoid goto_ptr.
>>
>> You must provide a rationale, at minimum.
>>
>>
>> r~
> 
> 
> Sorry, my mistake. I thought nochain will disable all kinds of branches, including direct 
> branch and indirect branch, but I found that indirect branch still call 
> helper_lookup_tb_ptr to continue executing TB instead of epilogue-tblookup-prologue.
> 
> Maybe the exec logging can be removed from helper_lookup_tb_ptr and nochain can disable 
> all the chaining of TB?

Why?  You still haven't provided a rationale.


r~


