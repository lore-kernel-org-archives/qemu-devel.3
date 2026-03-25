Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B652FEA83B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5L3a-0003r7-2N; Wed, 25 Mar 2026 06:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5L3V-0003qp-Rb
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:01:41 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5L3T-0000GU-9t
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:01:40 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso3479304f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774432897; x=1775037697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fjq4qaSm2IJyF4iuo1WIa15QF+BvbcTPQUswLNfIyqM=;
 b=vu3yvT0W6dXmeyK1RK0G/Y2+sd5R7CxNbKrRTveBBdSzMMqkEJVMsNY/1ftdV4BMPp
 ASIRbQAhhgF1MQw9bs5JSBLDKXD7VOpWThHQ2rZEFrrcyEZ94Hjp0Cu9Eb2c8kMGjJSg
 CkUfEXEYInvF6ic/bLBs/dryQUQ/t2IgoTLhgZN8OXzHuAaRgLvXlRYor8y/8PhoAumW
 ZoKzdhqPZJ8bf5roJWoG2ZWBKnr+ltGJ1NhfJyi39JCce13kQBMCTorNDkLzZxnGxSMg
 eetMhEk8LBeSFB27AQt9tMKxb+TokBn5zdlcZDrDa2Qpz8BixoUO467UDRVd09jFRqv/
 lmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774432897; x=1775037697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fjq4qaSm2IJyF4iuo1WIa15QF+BvbcTPQUswLNfIyqM=;
 b=VRuPZcd6Goae7kUzw9reKZgZKfJCJ+h67alNivkAvc99j/M4HXVAksPyUcJHB8k8RW
 YtrFuDM1Fuzkxg+uXttaLaXqORsMBokUPyQMVkV0qnU3BUjVrABtyKn+0ZSCW4Qiltqb
 f2yqOGuDdlzAt2/Tfznp/hDkPswHj6tHS0UjPaqMMv7ED4TSUgCWEhOBPdZb3vYFAOKD
 WRGNop5L2AXHh8sN5hNDVP7HrDB4et7Qomu8cPNVEIOeng6wLL/+2W9/WtFuMsBAKjwM
 qzL2rbknQvyi6SPVUNPbAdSL+3G5nLSiPpU9e5HiyKOkbfz/QZN4sS0xiY1GBQ7Y0QKc
 JZow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyVvmj+xhOatxnfbL28W2S7Thn3SSbSumX3fl5FZskg0nYYhRkZs6O5pbVyW4FszTDHrfxsD+7oUPq@nongnu.org
X-Gm-Message-State: AOJu0Yw9syMqIDffl5kyPjnfuL1VAhkJnq+i4tw5/IPC3df5n/3e2KHj
 ebkcxaxt47/EP7J5D5DnRwZG5+9x5a5p5gs85BgP4okdLC4GW/n8IxXEFeRJ1QdnNDQ=
X-Gm-Gg: ATEYQzwZr5YnIs7KbBl70BS3aDH9aOpoQO0ct5iUkF3/VEzozjvgi1cDeues7fX64R1
 74KchpE0BbZTANZNIzSJGHF0jsFPWWva62Ro+S7Xkr8rr8RYKc/eiuBlnUIVuaQ7eQ8bbgXzW74
 TXjpDbTD4aTVGL3Fs6PGIifLTKDd9Bz6hniUEAePZ0fc25PRjEF+ENT1moyMeHj4UpkQdVe2W0j
 th9L3G3rdOvAtwyZXrkNLb/bcj4bHkwnBwFT6tjhH7cezaMWft+QpM2WaWd9U8odn1BKKFJ3ebA
 F1IHxvT6QBvV0f5/CGPCM8D9y8bPzL1OOILSega6jLW+2ULNwpi/b/Q5x9B85Vkpojq+DzMv3bM
 nsZuIXhGYJdcU84zXUl0TvWO2HfEhTBiUYDYpsNlzd2B6Bsq2N2v9lUsWPvoeBJpy29n+uKOr2k
 /2WI1iZgQNjeoP8Yo/M3BjCYj7pG+Mck92WS60ONYuSjzKxMHBmh2MFLMyqatdScfQ7w==
X-Received: by 2002:a5d:64c4:0:b0:43b:4469:d31b with SMTP id
 ffacd0b85a97d-43b889a49d4mr4104029f8f.15.1774432895323; 
 Wed, 25 Mar 2026 03:01:35 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8567b2e2sm9756592f8f.33.2026.03.25.03.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 03:01:34 -0700 (PDT)
Message-ID: <f5e3cea6-71d8-4df0-a81f-049a18a92d60@linaro.org>
Date: Wed, 25 Mar 2026 11:01:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/functional/qemu_test: Silence warnings from
 pylint in tesseract.py
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260324163543.55503-1-thuth@redhat.com>
 <20260324163543.55503-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260324163543.55503-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 24/3/26 17:35, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains:
> 
>   tesseract.py:1:0: C0114: Missing module docstring (missing-module-docstring)
>   tesseract.py:12:0: C0116: Missing function or method docstring (missing-function-docstring)
>   tesseract.py:15:11: W1510: 'subprocess.run' used without explicitly defining the value for 'check'. (subprocess-run-check)
>   tesseract.py:12:30: W0613: Unused argument 'tesseract_args' (unused-argument)
> 
> Thus add the missing bits and remove the unused tesseract_args argument.
> While we're at it, also add a SPDX identifier instead of the weird three
> dots at the beginning of the file.

I'm OK to remove the boilerplate if possible.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/tesseract.py | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
> index ede6c6501e2..1f955d32b76 100644
> --- a/tests/functional/qemu_test/tesseract.py
> +++ b/tests/functional/qemu_test/tesseract.py
> @@ -1,19 +1,24 @@
> -# ...
> +# SPDX-License-Identifier: GPL-2.0-or-later
>   #
>   # Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
>   #
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later. See the COPYING file in the top-level directory.
> +'''
> +Tesseract is an program for doing Optical Character Recognition (OCR),
> +which can be used in the tests to extract text from screenshots.
> +'''
>   
>   import logging
>   from subprocess import run
>   
>   
> -def tesseract_ocr(image_path, tesseract_args=''):
> +def tesseract_ocr(image_path):
> +    ''' Run the tesseract OCR to extract text from a screenshot '''
>       console_logger = logging.getLogger('console')
>       console_logger.debug(image_path)
>       proc = run(['tesseract', image_path, 'stdout'],
> -               capture_output=True, encoding='utf8')
> +               capture_output=True, encoding='utf8', check=False)
>       if proc.returncode:
>           return None
>       lines = []


