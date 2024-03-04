Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9354C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhC0s-0004HG-Dx; Mon, 04 Mar 2024 12:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhC0q-0004H5-QL
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:22:04 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhC0p-0006rT-5j
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:22:04 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so4546463a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709572921; x=1710177721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R5ruznmM3OY0bC8o3BVg0gCa4UCMiapvj3tpFmEWu+g=;
 b=SzgO9V2Pt7NIsqw5w7HtWSpO/C95HmGFfARwA+pr9ceX/j8hlKOFvHfFsNJymlcQu3
 E39je08vMiz/84hVXIwwjGyp0coxodexg7xL+L3MPksXahy/4puXNcpINJ2HYZkMivP3
 SpYOwpouBvFjeIY81joaLWfE1qsNm8NrsT6Gkl2SPO5uqLudIwVHP8T+WMQo1NSf6JK1
 q8lXDWULF/eT266H8Zk0BKOJFbEr6AJNY7eFOM6Vks5HPZ5e0cyyzF/nu0j6RMlZ1q4S
 bvqgdT6QQBJv5KZcZh4hVwqzaGjg3ksjQB1hgY65ptGKUoKTapcTBmNCQwuj+pebpf+j
 mbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709572921; x=1710177721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R5ruznmM3OY0bC8o3BVg0gCa4UCMiapvj3tpFmEWu+g=;
 b=JgQl3obiPKzLdJW4aOZPSbfYLrq+WVVwJykJVFgQEH+D15eDqcm47Rl4l6zBTuRXmx
 VdTD+gc4r2v936eTztXZh0/awsdAN7L4RVnsSl6KmwUI2MCWX28K62/a8RbLIrp9RPtE
 568axsigVr/1+bnbkZrl9Sjk1UYiBGnSZDwfZN/TIezDVyfJsQmIjS3kqKGQ2SJmqEHH
 /cogN3mIxpkH7i2irJk6bpo0S008h4aDFyxJGaC2Hz5S/KVccau/mpHiD6V0p/SuCU/8
 pff2kPgHbuHb8dCLTny05t00dMCEU19hNEOTwjLkZay/DDG8fXTlXNtm0de8Y+WGu894
 Cu+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8rgNCwLxGI4JsR2Jon0OM69hZMsIonKgqS/gu01RoUnxnCF2F1wl3VQvFle7shGEhUuIkzLjYw83L9X0zQnxEu7xpVok=
X-Gm-Message-State: AOJu0YyF3EFIcVnFPDVk67Fx6/IySwYLjW6jD/bP06hqQhXcObF/xCeN
 yCKOKKUnxhqp0ooMLznxS0dSUnsC99g+C9+PhtkGSxtAM/14l+jPXqVwlnQ2e1I=
X-Google-Smtp-Source: AGHT+IG0zvT7pjU5l4EGhRIQ52Oe65bK6YKKGBtqoGoLFY6EOf9dbMhnc1TAuP8rZAItGyKsvjrVag==
X-Received: by 2002:a17:90b:4393:b0:29b:46f0:6f8e with SMTP id
 in19-20020a17090b439300b0029b46f06f8emr130508pjb.8.1709572920936; 
 Mon, 04 Mar 2024 09:22:00 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 oh5-20020a17090b3a4500b0029ab712f648sm10268079pjb.38.2024.03.04.09.21.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 09:22:00 -0800 (PST)
Message-ID: <e33ab9ae-e2d4-41ba-b053-e7e918572808@linaro.org>
Date: Mon, 4 Mar 2024 07:21:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg: Add multiarch test for Xfer:siginfo:read
 stub
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240303192610.498490-1-gustavo.romero@linaro.org>
 <20240303192610.498490-2-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240303192610.498490-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 3/3/24 09:26, Gustavo Romero wrote:
> Add multiarch test for testing if Xfer:siginfo:read query is properly
> handled by gdbstub.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/tcg/multiarch/Makefile.target           | 10 ++++++-
>   .../gdbstub/test-qxfer-siginfo-read.py        | 26 +++++++++++++++++++
>   tests/tcg/multiarch/segfault.c                | 14 ++++++++++
>   3 files changed, 49 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
>   create mode 100644 tests/tcg/multiarch/segfault.c
> 
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
> index e10951a801..61cda9640e 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -80,6 +80,13 @@ run-gdbstub-qxfer-auxv-read: sha1
>   		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-auxv-read.py, \
>   	basic gdbstub qXfer:auxv:read support)
>   
> +run-gdbstub-qxfer-siginfo-read: segfault
> +	$(call run-test, $@, $(GDB_SCRIPT) \
> +		--gdb $(GDB) \
> +		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> +		--bin "$< -s" --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-siginfo-read.py, \
> +	basic gdbstub qXfer:siginfo:read support)
> +
>   run-gdbstub-proc-mappings: sha1
>   	$(call run-test, $@, $(GDB_SCRIPT) \
>   		--gdb $(GDB) \
> @@ -122,7 +129,8 @@ endif
>   EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
>   	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
>   	      run-gdbstub-registers run-gdbstub-prot-none \
> -	      run-gdbstub-catch-syscalls
> +	      run-gdbstub-catch-syscalls \
> +	      run-gdbstub-qxfer-siginfo-read
>   
>   # ARM Compatible Semi Hosting Tests
>   #
> diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
> new file mode 100644
> index 0000000000..862596b07a
> --- /dev/null
> +++ b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
> @@ -0,0 +1,26 @@
> +from __future__ import print_function
> +#
> +# Test gdbstub Xfer:siginfo:read stub.
> +#
> +# The test runs a binary that causes a SIGSEGV and then looks for additional
> +# info about the signal through printing GDB's '$_siginfo' special variable,
> +# which sends a Xfer:siginfo:read query to the gdbstub.
> +#
> +# The binary causes a SIGSEGV at dereferencing a pointer with value 0xdeadbeef,
> +# so the test looks for and checks if this address is correctly reported by the
> +# gdbstub.
> +#
> +# This is launched via tests/guest-debug/run-test.py
> +#
> +
> +import gdb
> +from test_gdbstub import main, report
> +
> +def run_test():
> +    "Run through the test"
> +
> +    gdb.execute("continue", False, True)
> +    resp = gdb.execute("print/x $_siginfo", False, True)
> +    report(resp.find("si_addr = 0xdeadbeef"), "Found fault address.")
> +
> +main(run_test)
> diff --git a/tests/tcg/multiarch/segfault.c b/tests/tcg/multiarch/segfault.c
> new file mode 100644
> index 0000000000..e6c8ff31ca
> --- /dev/null
> +++ b/tests/tcg/multiarch/segfault.c
> @@ -0,0 +1,14 @@
> +#include <stdio.h>
> +#include <string.h>
> +
> +/* Cause a segfault for testing purposes. */
> +
> +int main(int argc, char *argv[])
> +{
> +    int *ptr = (void *)0xdeadbeef;
> +
> +    if (argc == 2 && strcmp(argv[1], "-s") == 0) {
> +        /* Cause segfault. */
> +        printf("%d\n", *ptr);
> +    }
> +}

Any reason SIGSEGV is interesting?
Perhaps just abort for SIGABRT instead?

A test using setitimer to raise SIGALRM would test the async path.


r~


