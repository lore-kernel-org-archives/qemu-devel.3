Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5293D17128
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 19:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2xlN-0000X7-Uj; Mon, 21 Oct 2024 15:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t2xlK-0000Wk-JV
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:08:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t2xlI-0006HO-UX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:08:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-207115e3056so39473075ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729537695; x=1730142495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LyEo/yBiRCCh6vu9a2yHnzdVVuVO6WqniHs107zzNcY=;
 b=tdVFZyuRgrbGruppJFt0NRcR85is/ljL7y8IzDu6WNroxi60jRMqzDNzk3jSEDjhMe
 mqlM4Tn4N16D9Ljzx2G9L6iQ8J0OtjbR3rw6R/3TtJWWpHnWedkpS0h9TumCpfqyM0R6
 xfd44an6z+kAdOInsEjjjSEVQl2nXjcVTNsprR49frh8sYoODqgFXh3XV10CW9/824RY
 QUEGPqh9of2waXdldOjq9VajtRrSyO5RV0L2nAp7aSfRZSE3VsRfo8bmXhB2oI1BiEf7
 +TD+DmDEZFxaQcHRHkubvHZIJff8F80J7KKU6lJJXaiI4XNkO4DTvuSKE2EarwxqdH0r
 C6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729537695; x=1730142495;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LyEo/yBiRCCh6vu9a2yHnzdVVuVO6WqniHs107zzNcY=;
 b=ZXmv4uHshxqnehGjtebei3xVZwjCn1V9xrfqgdauCmjYyFmG+VLe/iejzeVJHAKEDf
 x5xHJPsdl7XqJLOxsO5eVnCA8JGC9eONaPsOWIeipsEktM9Cd1ovIl+kynTqT2IV+Ltf
 sc8z9vRP704Q4q4cqDXY1mXVCsbxFJTK5zw0nyyFJ+c0ApeEyQ4CBlj7ILsXGDQS7rlm
 TRqx+21lywh9GgXgALIYjCGAUQHt6vknbCNmIzzEWmz0WUjAvZ28tzNwVfyoeIDxGqrI
 yOvZYGOaXMsRlcmxiM1ER5E0hKAsWxRk2NM1/vYLj7gFrxfmOPmUkgfIQMh1jQ75YeDQ
 9zkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQQ7CAncjk7QJKAsktJZTZ70vGJV2mcD08xU00Zxzc5VJ+suHyDWU/fu1QCpopXJc+COT6iEZXHQRs@nongnu.org
X-Gm-Message-State: AOJu0YxHu4FqkocN0h85oZz/14Xq4Kfy7SiMRgNSgEhLmvS20W3sg+xl
 lAD6nOL3jVjFT3LiiBhz9CZXPR4Ua9FiBGRT/yEE79OXX41BrUkkg4zpT8gRJwQ=
X-Google-Smtp-Source: AGHT+IFGK3KT2jfAEF4aQSzNJv7tHzhNelyc19tkfxMWZkFURJpYzUsR8ze7Bdh34Idxsox0DYI0TA==
X-Received: by 2002:a17:902:ec85:b0:20d:27fa:1911 with SMTP id
 d9443c01a7336-20e5a71aebdmr197003065ad.8.1729537695001; 
 Mon, 21 Oct 2024 12:08:15 -0700 (PDT)
Received: from [192.168.0.102] ([187.121.94.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0dd499sm29345915ad.223.2024.10.21.12.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 12:08:14 -0700 (PDT)
Message-ID: <e22adb4e-86a2-43aa-a9f4-2e9f40bb4d87@linaro.org>
Date: Mon, 21 Oct 2024 16:08:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Stop using exit() in the gdbstub testcases
To: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241021150153.487057-1-iii@linux.ibm.com>
 <CAFEAcA9W6Fb-gvCx268xV+CV7LyWJwCQGqkKFpGQjdT+WiAEUQ@mail.gmail.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <CAFEAcA9W6Fb-gvCx268xV+CV7LyWJwCQGqkKFpGQjdT+WiAEUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x633.google.com
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

Hi,

On 10/21/24 12:08, Peter Maydell wrote:
> On Mon, 21 Oct 2024 at 16:02, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>
>> GDB 15 does not like exit() anymore:
>>
>>      (gdb) python exit(0)
>>      Python Exception <class 'SystemExit'>: 0
>>      Error occurred in Python: 0
>>
>> Use the GDB's own exit command, like it's already done in a couple
>> places, everywhere.
> 
> This is the same bug that commit 93a3048dcf4565 is
> fixing, but it looks like we didn't catch everywhere.

Yep.

So maybe now change in test_gdbstub.py this line:

     gdb.execute(f"exit {fail_count}")

to use the new gdb_exit()?


BTW, last news from this issue is that it seems to be fixed
in GDB 15.2 [0] (I haven't tried it). However, the fix using
gdb.exit(n) is still correct.

Acked-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

[0] https://sourceware.org/bugzilla/show_bug.cgi?id=31946

