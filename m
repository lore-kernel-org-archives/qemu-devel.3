Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270B7F4BB89
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 20:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuz7v-0006kD-0A; Tue, 24 Feb 2026 15:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuz7t-0006k5-Lg
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:35:25 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuz7r-00032U-KD
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:35:25 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81df6a302b1so5768844b3a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 12:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771965322; x=1772570122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CzfKFnMMPpM0HZ0+i9W2F9LyQM8mt8ur7uNgPN74iB4=;
 b=hesV4WhLotQHa1GKB3az81uaX5RMj5VEH1fO31unwd9nnk410WlAmgCXHGdwtoAf3j
 9qoJUH0tgcYAy2IjqaQnZrdl4KC98iAInQck+yUWUkMjX6EKujiEUr69ZNgH5lZ5O6dd
 xGDYExXpl4yQ0iB4fKAvi5c9B/ZDwh2zyApwB5JGIfZGVZFFS/69hJfNWS03egW015zL
 v6LWJJRImWPUFirzxH6PpGCNG4X6++Zv7hvOuWYkmRWI3dE1pAzgCwd2NNttvJcFeCXJ
 7Blbn335oNO4g/PyTt8/h+62OKsnkOK7I6ycGhK1NNC9EDHmE7xyQ/exP+yT2EV0zhYk
 1QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771965322; x=1772570122;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CzfKFnMMPpM0HZ0+i9W2F9LyQM8mt8ur7uNgPN74iB4=;
 b=QxtO6n8CudvBGXAXdmJulTYDuXwupWWG51EjCORucm+IhGJ6mbA9F2hTbzS2m9vrmD
 xswCDC5fmEVxoIW0OeIcZROEIpWz9wnSi+hHUOyd1FgamsaRw3risu/9otzNT/Kz0kIm
 JWcv8//MyQfhLaGgwW4AN9xlkNDsYpiaRfIjvNfMGrWan+eMPmWCoyI3jTDFDiDk9+4o
 Yy3YSGAQcfwOhNRlAOpXmQ/+8g9vHyKUu2A4bTb8VO1SD3Moq60vGQUoUu2YklZUcJAs
 nMuiYBtRprBbpRQi19zcqbhDp5CAVWtFRu4CM/WY/IiUEWC0qbT/S6MQA5HMEYqNH5Dg
 tqDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfSsvDb1U6PcL1lxRYwqGbTXqtAnBhlO02iw0hEBP8tUSYhVGjfjY584MgdMJw1dXBtD5g8HHjOtpu@nongnu.org
X-Gm-Message-State: AOJu0YzygGdwQKWS06By+2Rwe8fm90mtZ8agkMmqxzPjUmDphbo8e4aM
 Qutw3N5I34wzJ0xcrxx6KU+WtKd/OCEjPngYKIajAIzAeuhikSqOtrFJVSl33e4U2vk=
X-Gm-Gg: ATEYQzzepdkUdrZ6Gt0qV10oR3KsYjjSzqY02MSdlf7X64MO33EX6bfGm6u8HJ4rsV3
 JQTeWffxRbh7LAqNqRzWl12ezoLr2a1ghJDRTwDs6UOP+agoGyKTF8odxxULuDvUuPWEL3N2Qtr
 mkdgiqQaF9RS98YujWPjCXzO4cnWoZ28oF+12FffS2mRSmvisu+fE1VZS8B+BI+JT63cNqYMn9E
 TRZB4Dvpdqx/V8xWqblorQPcoCaie60jq5o2Bwrxlf0kVcVKX53ajcOFY4umCT54ok+6npxnwsn
 rubP4L2YNof5oHWeoYyDzuzH0537xlb/1fJ7/qDuTsAU9EQEbGSu7vZL3kQnu+DP/wVW24R5ZQ7
 BmWtD43lCq0/qo2V19sUxrwwv3OoL78wB75nwDzXamdkrUI8PeJ4c8rICHuurgetOnnu/Ua1I8t
 Xkyt4MPvC4/uXLLG9PnJsJJg6gnrIqsaW3HH9HktnQWE4gRUFbOsTB5IF7daZLE7gvV/uaQFwfA
 U8b+A4=
X-Received: by 2002:a05:6a00:228c:b0:824:af7e:8c5e with SMTP id
 d2e1a72fcca58-826daa63dbemr13233214b3a.54.1771965321732; 
 Tue, 24 Feb 2026 12:35:21 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-826dd8d5d18sm11191478b3a.59.2026.02.24.12.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 12:35:20 -0800 (PST)
Message-ID: <193c4274-c79e-4b76-8502-312dd3ebeb64@linaro.org>
Date: Tue, 24 Feb 2026 12:35:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 2/24/26 7:52 AM, Florian Hofhammer wrote:
> The test executes a non-existent syscall, which the syscall plugin
> intercepts and redirects to a clean exit.
> Due to architecture-specific quirks, the architecture-specific Makefiles
> require setting specific compiler and linker flags in some cases.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   tests/tcg/arm/Makefile.target                 |  6 +++++
>   tests/tcg/hexagon/Makefile.target             |  7 +++++
>   tests/tcg/mips/Makefile.target                |  6 ++++-
>   tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>   tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>   tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>   tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
>   .../{ => plugin}/check-plugin-output.sh       |  0
>   .../{ => plugin}/test-plugin-mem-access.c     |  0
>   .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++++
>   tests/tcg/plugins/syscall.c                   |  6 +++++
>   tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>   12 files changed, 131 insertions(+), 3 deletions(-)
>   create mode 100644 tests/tcg/mips64/Makefile.target
>   create mode 100644 tests/tcg/mips64el/Makefile.target
>   create mode 100644 tests/tcg/mipsel/Makefile.target
>   rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
>   rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
>   create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>   create mode 100644 tests/tcg/sparc64/Makefile.target
> +++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
> @@ -0,0 +1,26 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This test attempts to execute an invalid syscall. The syscall test plugin
> + * should intercept this.
> + */
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +void exit_success(void) __attribute__((section(".redirect"), noinline,
> +                                       noreturn, used));
> +
> +void exit_success(void) {
> +    _exit(EXIT_SUCCESS);
> +}
> +
> +int main(int argc, char *argv[]) {
> +    long ret = syscall(0xc0deUL);
> +    if (ret != 0L) {
> +        perror("");
> +    }
> +    /* We should never get here */
> +    return EXIT_FAILURE;
> +}
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 5658f83087..b68e3cadf4 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -148,6 +148,12 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
>               fprintf(stderr, "Error reading memory from vaddr %"PRIu64"\n", a2);
>           }
>       }
> +
> +    if (num == 0xc0deUL) {
> +        /* Special syscall to test the control flow redirection functionality. */
> +        qemu_plugin_outs("Marker syscall detected, jump to clean exit\n");
> +        qemu_plugin_set_pc(0x20000);

An even better alternative is to use a value label, which is a gcc 
extension, and you would not even need another function. Just pass it as 
first parameter of syscall, and jump to this address directly from 
syscall filter.

int main(int argc, char *argv[]) {
     long ret = syscall(0xc0deUL, &&set_pc_dest);
     /* We should never get here */
     return EXIT_FAILURE;
set_pc_dest:
     return EXIT_SUCCESS;
}

More details:
https://www.amulettechnologies.com/boosting-bytecode-efficiency-the-power-of-gccs-label-as-value/
https://gcc.gnu.org/onlinedocs/gcc/Labels-as-Values.html

Regards,
Pierrick

