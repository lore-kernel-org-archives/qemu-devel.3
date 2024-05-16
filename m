Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6F8C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 07:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7VDF-00087T-5i; Thu, 16 May 2024 03:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7VDE-00087L-J0
 for qemu-devel@nongnu.org; Thu, 16 May 2024 03:07:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7VDC-0000mk-VM
 for qemu-devel@nongnu.org; Thu, 16 May 2024 03:07:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-420180b58c5so28937005e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 00:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715843253; x=1716448053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=klKClyMgZsVg295NryEC7cjn6b5bVm0lpNGsirjEurU=;
 b=Fvgot86z/FI3UUTtmfKuSQ/xZo25YQieRJFbnpI0V4pRgDy0AfRzMNzc9MLhfsiAf5
 /WtXyvLObUgWe1nHbNRJ3v68ylA43XsU7fKADM1R9vj8bdHQcYtzTem9X7OaVWDaXhTS
 XkiRXylawQYA70VSUsKmKvXwN6rlihB0Dd2VqwzxLM5gbm45jCfZv641XkNNiPMukZCY
 bwD8JIuePFaLsijbmX4fzs6vsNA3CpJTveKBpmtm29iTEWO12Rr97y20QoFtIXO3YjAU
 YU9qpZhXj4vhDt4VQt+tPCYHUlUZqniYW81dzIQkZuTxwLCh9307Cx2sBcGRxCX16Th0
 1J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715843253; x=1716448053;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=klKClyMgZsVg295NryEC7cjn6b5bVm0lpNGsirjEurU=;
 b=NnXi7hQU+Dgw1SrfU+MeML6KRpFxZW16crH7MVXetI0PiMW9ZF60he7p8Vgdlx/kbW
 4SrUuE6F7GkbTgEltTzAm4+NeH4yl79MvE+hTx3d8u6ERGiFx8wHKWeY9qDucuL++6S2
 75Fvqse2BBantCekh2VbMEguhwaVhTpJojVyERPdU2ixWQ306WazzBEdsxq9cWe0RVoV
 v/CZQq+3/3plG1hqLOoVY3CXrgT+4C4qVdIo1BXrwk6+K+Z0DOUJLwYEaJkUBP64ks8r
 aQF0AFkSo3aRZOuQojuPbqdIzdLEHg5228IJqzfLMILupuxF0OfxORRUxrzwNA5FXmTH
 P2Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYHu4MLVxGWO8l7vFjNtGAobupX01KIEvhdaB6TO3NeUkP0XIfuS1oj+EUTSEMnDb+sDyI9dElBEwMgAJW89AecyqOcUM=
X-Gm-Message-State: AOJu0YzSZKvcO9navh1KpwpLfO9vLRIT5VZgQzXhVrcIu78lhXIcyUOV
 eqAxwjGEyInAugArzw+50Becu86MLPpa5zQUZ4aJPiBh/ixUhz8oEKpt3Zeiu/8=
X-Google-Smtp-Source: AGHT+IHDpTwwDigjM/bGqEQb1ppaiwZV8GtYd6WuGhj3cQjTf4KsxkuGHPRPrzmk2eOz21phWqNoQQ==
X-Received: by 2002:a05:600c:470f:b0:41b:fd63:1981 with SMTP id
 5b1f17b1804b1-41fead6f2e2mr116274025e9.41.1715843253302; 
 Thu, 16 May 2024 00:07:33 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee962esm256871535e9.31.2024.05.16.00.07.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 00:07:32 -0700 (PDT)
Message-ID: <ff7b8585-d838-45bb-aec0-bcbf6900b7c8@linaro.org>
Date: Thu, 16 May 2024 09:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests: Gently exit from GDB when tests complete
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
 <20240515173132.2462201-4-gustavo.romero@linaro.org>
Content-Language: en-US
Cc: John Snow <jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240515173132.2462201-4-gustavo.romero@linaro.org>
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

On 15/5/24 19:31, Gustavo Romero wrote:
> GDB commit a207f6b3a38 ('Rewrite "python" command exception handling')
> changed how exit() called from Python scripts loaded by GDB behave,
> turning it into an exception instead of a generic error code that is
> returned. This change caused several QEMU tests to crash with the
> following exception:
> 
> Python Exception <class 'SystemExit'>: 0
> Error occurred in Python: 0
> 
> This happens because in tests/guest-debug/test_gdbstub.py exit is
> called after the tests have completed.
> 
> This commit fixes it by politely asking GDB to exit via gdb.execute,
> passing the proper fail_count to be reported to 'make', instead of
> abruptly calling exit() from the Python script.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/guest-debug/test_gdbstub.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_gdbstub.py
> index 7f71d34da1..46fbf98f0c 100644
> --- a/tests/guest-debug/test_gdbstub.py
> +++ b/tests/guest-debug/test_gdbstub.py
> @@ -57,4 +57,4 @@ def main(test, expected_arch=None):
>           pass
>   
>       print("All tests complete: {} failures".format(fail_count))
> -    exit(fail_count)
> +    gdb.execute(f"exit {fail_count}")

Yay!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


