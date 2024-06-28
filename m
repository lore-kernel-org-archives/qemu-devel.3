Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D060C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNEny-0000T7-EQ; Fri, 28 Jun 2024 12:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNEnw-0000Qf-Mb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:50:33 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNEno-0005gw-Q2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:50:27 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d55e2e0327so469531b6e.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719593423; x=1720198223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ELVTI/N5D3MWmzOvRVDf5qXVVV/RIV0l4ceNBegRSc=;
 b=pjG2PebX0MvSRCSk6fD5Wie8dIaKRqU/KtTD7YR/oPdyl0qVWfdf9OHcQ6RHlKq345
 q9ANqLXv5F1yNYZiVZ6BHwrjXiOPIE/M4N8Soze3Q7rZDSpWk6me2eFFFaLAJQ3DFUkb
 4JOfmULJsLZMIJIgfcA4Dh7/M3bwOP90dDe8zsIa1NJA3rjvuhwcJoS+X1fVeN/6jW2P
 0/mNM+WxX3sk3UKUJk6y7u1Lyjxx/uq4CVWEww3WZLW9/mSc6+f+xvaB69WhiZYt7nes
 lsIugj+zZ9jhCb1Gu4TRXWDNL4xUE0oEr2j1d+3yER90wPCWQsNVzcmUryhj+I6RNJUQ
 8CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719593423; x=1720198223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ELVTI/N5D3MWmzOvRVDf5qXVVV/RIV0l4ceNBegRSc=;
 b=FNPzioLnkFsEAmAHZz6brOJv8FbBkjQghr1W2Lny3whM49qdcVLK3sJdP6CDg3yC4d
 kiRzjMV/P/VcW1rcwDgp3LO3EPq7GsAJK4DynaY7c/gvBy7bMoxKOEsDUQWcvjxuRz4n
 LalxzPPtwTDisuJsRXWcvdkqxh6e9lXP/6RIBTWDR6NJJ9xbOnfwc9AWXrzaWF0tN2ju
 HxA64j9IsVFVqSdSuWhAebG7qsLihtNr7s9+5MPS6H9A6MXvETQB3CIfHd0lQ4P03bh6
 EM9oQCbdPzBTO3yoXgJ/oTQi1FGEzRZ37A56rL5A3hFBtx6vTC9UveGEKvn81bNcf9Xs
 aL/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwOrf9Xfd4C9yyExWFC5Vh2Fdm08/MSgIYDYvhcuvyWqdcRG1VDYwPHzLgtIgK9XNtQhhS3bY4N3VA2JcOBr4o2+iLUfM=
X-Gm-Message-State: AOJu0YyIkw/rNmuqoIXB7NnJPZq94soAgXU0tA1d0ePE346Y+m12sjiq
 cvCXyyyvZq9eDCI1FYb8eSzs4g/5HB+6gOFVs4zYELgmzjkfUQF26gYB0SjzJ0Y=
X-Google-Smtp-Source: AGHT+IGwrQ0eadjxCjbsJAmSam/L30iNq+60LdrG95bT7zFLS2gKD7t9Ep1ORg2RLuI2no5jBdFnmw==
X-Received: by 2002:a05:6808:1824:b0:3d5:1f50:188b with SMTP id
 5614622812f47-3d543adb0e9mr21641775b6e.23.1719593423179; 
 Fri, 28 Jun 2024 09:50:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080256af87sm1840122b3a.70.2024.06.28.09.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:50:22 -0700 (PDT)
Message-ID: <ebfa6ca6-d93e-45b3-8786-cb52505e2d7c@linaro.org>
Date: Fri, 28 Jun 2024 09:50:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Always build Aarch64 gdbstub helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>
References: <20240619124903.56898-1-philmd@linaro.org>
 <42de8f25-3624-4e7c-b38c-ad8e3b8e61a4@linaro.org>
 <83667101-daba-43ea-ba33-1df547020cd9@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <83667101-daba-43ea-ba33-1df547020cd9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 6/28/24 09:37, Philippe Mathieu-Daudé wrote:
> On 28/6/24 16:31, Richard Henderson wrote:
>> On 6/19/24 05:49, Philippe Mathieu-Daudé wrote:
>>> Merge gdbstub64.c in gdbstub.c and remove uses of
>>> target specific TARGET_AARCH64 definition.
>>> Small step toward single ARM/Aarch64 binary.
>>>
>>> Philippe Mathieu-Daudé (2):
>>>    target/arm: Merge gdbstub64.c within gdbstub.c
>>>    target/arm: Always build Aarch64 gdbstub helpers
>>>
>>>   target/arm/cpu.h       |   8 +-
>>>   target/arm/internals.h |   2 -
>>>   target/arm/gdbstub.c   | 363 +++++++++++++++++++++++++++++++++++++-
>>>   target/arm/gdbstub64.c | 383 -----------------------------------------
>>>   target/arm/meson.build |   1 -
>>>   5 files changed, 364 insertions(+), 393 deletions(-)
>>>   delete mode 100644 target/arm/gdbstub64.c
>>>
>>
>> Are we attempting a single binary for user-only as well?
> 
> No, due to ABI constraints, right? I did a user-emulation
> smoke build, no failure, did I miss something?

Well, no.  But qemu-arm does not need gdbstub64.c.
Given TARGET_AARCH64 will be set on a combined build, I'm not sure what is the fix?


r~

