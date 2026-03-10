Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B552CEB1060
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyDa-0004Kl-PA; Tue, 10 Mar 2026 10:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzyDY-0004KQ-AI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:37:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzyDV-0004o1-A8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:37:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48535a0ef86so22140015e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773153467; x=1773758267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Y6ehQdG4BTbk5vOMRXdMo49BIxhMgxOuMYGpIhnvXo=;
 b=rCC3ziYI6xQo2T157D49byQLcYgPGQxBd/zHSGjQF/dqMsVfyRTBfCPDxX7hNvPYhk
 LtcrHAi1M8FNROktCl7RaOoNRC+a4TkhDwbU3+WiBJbovIxD8ajXdluO/LTMMFwBS5XL
 811M0k7XAIKEK8MIHLNJBfCsFpJki58RqivME9IMAH2u4+RNU9rjAM89iEEr+uK/Lqg0
 dsQYLstgmBXnY6uJbvUl8KJaL2/T5cq5RNCDCePuh6UNwTV2ApI5BKq6Gsi63cixnvG8
 IhxRX5A8j1XdYDFoqbaitVVV6Hbspyolxd6sH/dsvcLzdKzNa5NWpk8vGV4B3uj4FoDd
 f72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773153467; x=1773758267;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Y6ehQdG4BTbk5vOMRXdMo49BIxhMgxOuMYGpIhnvXo=;
 b=QuJCncjrqjjs5MNep9JLpwqi0JbZKUeRZJ7LtYU/KjaFDxaQK5f0un4g4Ri3Q0/NTo
 MbhoLoz8PHnjHKfiM15cxHlVe8Ud42lqNNvlCli42Y6hIGrw8c3oWiDt6pKL+7q4i1Io
 LnedTSbAsd7zupp9B9r4yQkBv+tGg6m/1s/8uEXoCXnN6MXtAvxA5Sxc4eSV/M4SRxwr
 f70ExaqItUUX5rbGqp8x5bxZg7R/5qYrZ1wMbcX6V6XoIwe+7ZsHOLvEvGSeEWH9cdyP
 Dq+ZJz6Ax9mXFMvEWj21d0L3ZULUSizCsbn5wXaBho23iC6b3//8PC6iE02YG1QVLNZF
 A7rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK868iTGOYESQPsXktCc5S8Z9C57PCxhidJuBqVvxxLR6AUEsdIB1Qe7RoAJUuWDv5Ir91qrXBwuWC@nongnu.org
X-Gm-Message-State: AOJu0YxZBkKdXACMX5mDbRxOeSIZXJ42Z7GQHWBM6qNey4iAzqL521Gp
 VlxJWHUt+u8pViqWvNo/gcaC/NaypU2jKXA7XgzY1kSb6Q2OuDbdGiAvz8hL6XD6iig=
X-Gm-Gg: ATEYQzwG91BiZjfnzSQspmKlcKroR3GLKXou4aRpLTfnYSTTDP8tz/FqEz2xAwVZdJN
 qk2hSGeUI5DspUP7jQkVjG7SQ5DD/2iK9d9+DP3618UGFrHtjjxA+53fjB80ur0KVTptKGa7lvT
 gXhG9itYXIuP/DC/DTqMiNbWHq3AhEyqz5toU0PsJFbjZ6uvO2sd7VpbP64g2vfFrbyPX1GxaP1
 wEjKuyax2dXoKsRnuFluk4r5WdlFgCFC2RAX5EjOi9FxPEbaefV1GWqZfv7iPfx9XZLou/FUhFP
 6g6brtvew4F7BQdrIRIAievPM2T8k4nk6pF7PDIbPSWGmW5GE8gLmg2DF8Ezf541FEtS0ZPSOtP
 3HLFm4jbypuBsJ7BLfKTnEIfVNx7G17HFoI5rZQGMM3PZFlWqP0uLntW3UR/kYW0caT+/D4rIKy
 cqXlQdjqVcsxCfnNmAEqJCEiPLw9L/AwOkdUXy97I8YGb4b6aKUKVHnxysV9WCOhEgBByF38xZ+
 2/C
X-Received: by 2002:a05:600c:8a0d:20b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-485438835f8mr35202075e9.11.1773153467343; 
 Tue, 10 Mar 2026 07:37:47 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48534c302fasm73414755e9.0.2026.03.10.07.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 07:37:46 -0700 (PDT)
Message-ID: <293fd9cc-5adb-4e14-8f92-37157888ca11@linaro.org>
Date: Tue, 10 Mar 2026 15:37:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 27/49] meson: Add -Wformat-overflow=2
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20260309155219.62400-1-philmd@linaro.org>
 <20260309155219.62400-28-philmd@linaro.org> <87h5qn23v5.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yubin Zou <yubinz@google.com>, Kane Chen <kane_chen@aspeedtech.com>
In-Reply-To: <87h5qn23v5.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Cc'ing more developers.

On 10/3/26 14:47, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>> https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/Warning-Options.html
>>> Level 2 warns also about calls that might overflow the destination
>>> buffer given an argument of sufficient length or magnitude. At level
>>> 2, unknown numeric arguments are assumed to have the minimum
>>> representable value for signed types with a precision greater than 1,
>>> and the maximum representable value otherwise. Unknown string
>>> arguments whose length cannot be assumed to be bounded either by the
>>> directive’s precision, or by a finite set of string literals they may
>>> evaluate to, or the character array they may point to, are assumed to
>>> be 1 character long.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Message-ID: <20260305-nvme-v4-4-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   meson.build | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 102f0cbb13e..f45885f05a1 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -694,6 +694,7 @@ warn_flags = [
>>     '-Wempty-body',
>>     '-Wendif-labels',
>>     '-Wexpansion-to-defined',
>> +  '-Wformat-overflow=2',
>>     '-Wformat-security',
>>     '-Wformat-y2k',
>>     '-Wignored-qualifiers',
> 
> This gives me:
> 
> ../tests/qtest/ast2700-sgpio-test.c: In function ‘test_output_pins’:
> ../tests/qtest/ast2700-sgpio-test.c:27:33: error: ‘sprintf’ may write a
> terminating nul past the end of the destination
> [-Werror=format-overflow=]
> 
> ../tests/qtest/ast2700-sgpio-test.c: In function ‘test_irq_level_high’:
> ../tests/qtest/ast2700-sgpio-test.c:85:33: error: ‘sprintf’ may write a
> terminating nul past the end of the destination
> [-Werror=format-overflow=]
> 
> ../tests/qtest/arm-cpu-features.c: In function ‘test_query_cpu_model_expansion_kvm’:
> ../tests/qtest/arm-cpu-features.c:578:35: error: ‘%u’ directive writing
> between 1 and 10 bytes into a region of size 5
> [-Werror=format-overflow=]
> 
> ../configure
> --target-list=x86_64-softmmu,i386-softmmu,aarch64-softmmu,arm-softmmu,ppc64-softmmu,s390x-softmmu,riscv64-softmmu,aarch64-linux-user,loongarch64-softmmu
> --disable-plugins --enable-modules --enable-werror
> --enable-trace-backends=log,dtrace --enable-debug --enable-docs
> --enable-rust --enable-strict-rust-lints
> 
> gcc version 7.5.0 (SUSE Linux)


