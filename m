Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A02DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgAub-0002tz-7s; Mon, 19 Aug 2024 18:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgAuZ-0002tS-GN
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:31:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgAuX-0006oG-U9
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:31:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-36d2a601c31so2790944f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724106695; x=1724711495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jRkYKZKyY8LoZ2T6m4TBbq48qrkJCL9KAisPDYpd4eM=;
 b=AL1sHM1ax/iBZm0AeHeOxaLNApaE7SAivUIsivUCfsYJHUOElEf3L6ijW9dFkJi7pi
 LI9m/w5/UzV6o5FNWGn/UwvPSciFWfhpBZOjBjkT7ARSAyHTDkSPZEOl7VFnFD2vjJFu
 vT1AInKa0n3eIR3ZXk+lBkc2pI+Nj4/tqC0oYaVvrSekNR0zEC8FOYCN0ejMlM21pfYB
 ceYwbuaw9nYisJ43av9TkE2PUtz3Q1POWOiDbA8+URQPOAr9Y570Gkk3Cx2r5+p3oEtd
 exd60tYMmNygFGE2AlN7qihjkOuAFoNsqJYzEkTY9ygbIXpT6nUT3don/O5x8xxHomJl
 VZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724106695; x=1724711495;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jRkYKZKyY8LoZ2T6m4TBbq48qrkJCL9KAisPDYpd4eM=;
 b=mhywZOebEpBzEuiUyPCT6zq+f6kxjqGt3OdEkZqgl1TSQUmKUIKuLSspDGWgvYX3Nm
 RpwW2rzi9AETSxrPZ8mBZdFiBXzblEoj+ssIBmRmoMYt5FV0frhm9A/ger4z9VRZHImW
 jIyz27e/i9ZcB0jz/Jm38AeMXVIL5khTBKOdyHNS2wjZXdrYu0IJa17rG73Zh2bgpJc7
 7uv9maBbKrD3jnbdjpZuic8I2j0ss1gEk8FSgXK61gg6oWQOAqOFbcNKSmZN08oAv67A
 wLGfZt8fHxskvYINFKrFg9pfDELCvvMCtQnaJDeqrY2upTTHeDF6qjOCDC1Wb+/7uFys
 tKgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8BJvkoJaE5z8RI/P8EuaDJyZgoqTq2ERmeomoVN7YRwNZe6EfsTUxJR3818XzYGCuPLm435Z1JpHKwhDcUcjsPDEFt64=
X-Gm-Message-State: AOJu0Yy8NrF2sdm+rnwAtMuWJsJxvv13wEhhboix1cybyaueq9cctgoX
 t5ZjRcrd14LgGg9Pp9YYUyi+3+FUF5/nnOESAJP7AB8UMdVX+4Fpx+vc9wDu2nQ7g0dXPCvLz5n
 ihVg=
X-Google-Smtp-Source: AGHT+IFRY8qBS1w3OL52RKhhGoYXG+4WZDe4+3wS7/QqUJYduslxhU/pNbznQecttoSTSVmIPPnSCw==
X-Received: by 2002:a5d:654d:0:b0:367:8ff5:5858 with SMTP id
 ffacd0b85a97d-371946cc6dbmr6970494f8f.56.1724106694783; 
 Mon, 19 Aug 2024 15:31:34 -0700 (PDT)
Received: from [192.168.1.67] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189897034sm11586249f8f.67.2024.08.19.15.31.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 15:31:34 -0700 (PDT)
Message-ID: <300b1324-a527-49af-bf62-ebd5c72368a2@linaro.org>
Date: Tue, 20 Aug 2024 00:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/5] tests/avocado: apply proper skipUnless decorator
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240816072218.27125-1-thuth@redhat.com>
 <20240816072218.27125-4-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240816072218.27125-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/8/24 09:22, Thomas Huth wrote:
> From: Cleber Rosa <crosa@redhat.com>
> 
> Commit 9b45cc993 added many cases of skipUnless for the sake of
> organizing flaky tests.  But, Python decorators *must* follow what
> they decorate, so the newlines added should *not* exist there.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Message-ID: <20240806173119.582857-3-crosa@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/boot_linux_console.py | 1 -
>   tests/avocado/intel_iommu.py        | 1 -
>   tests/avocado/linux_initrd.py       | 1 -
>   tests/avocado/machine_aspeed.py     | 2 --
>   tests/avocado/machine_mips_malta.py | 2 --
>   tests/avocado/machine_rx_gdbsim.py  | 1 -
>   tests/avocado/reverse_debugging.py  | 4 ----
>   tests/avocado/smmu.py               | 1 -
>   8 files changed, 13 deletions(-)


> diff --git a/tests/avocado/machine_rx_gdbsim.py b/tests/avocado/machine_rx_gdbsim.py
> index 412a7a5089..9a0bec8a6e 100644
> --- a/tests/avocado/machine_rx_gdbsim.py
> +++ b/tests/avocado/machine_rx_gdbsim.py
> @@ -49,7 +49,6 @@ def test_uboot(self):
>           #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
>   
>       @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> -
>       def test_linux_sash(self):
>           """
>           Boots a Linux kernel and checks that the console is operational.

For some weird reason a part of this patch is missing...

