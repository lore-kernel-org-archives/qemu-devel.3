Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AFAD3B990
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3MY-00080O-CJ; Tue, 09 Dec 2025 14:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3MW-000807-Jz
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:27:04 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3MU-00084A-P8
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:27:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso79847565e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 11:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765308420; x=1765913220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RxX5M9DUADuXo7XN/vlE+Nt5Qex2T8ShtQb2FlbF4N0=;
 b=AgJuHi1XCqo5LJC8HDg35m1wQfOJn8Wju7O519dVySNlLm4xCDiROgm/iAwwLxpW0p
 bZ2C7fn54mlaY8K63jXAnNlYpwzB9pe0NlyWHTWKNPVFB41yHm4oeyq5sZuuLpUOxLql
 EXvOSyjM8qDUniKwO+sTMtbhu9WIouaN9Oht0nKtw66V/n6TBHaF7qIwU/2jbdeBynkP
 TD3slFvbJ+4EtJPDbeHPKZUIcNlr2sluL0WNUpFGX7kD+Bldl0sDfXGgiRWWItElNCsp
 bjOG7KGmf5DVgj3BIZKWQrfGbUpBxinQaJIO0FTgY8hV0mERlIixfOYJjTe4DLV93TDL
 UxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765308420; x=1765913220;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RxX5M9DUADuXo7XN/vlE+Nt5Qex2T8ShtQb2FlbF4N0=;
 b=KNeeef3pko3I5LEQpf00aLTwxKHadkSPDNJ3GwB7jJsTs/rlLeL82qH2eSx74oFjJx
 7Rd32qYgm8LedYDMcjiCzoJ3mrgt4MfOWQuJQgUt0EKH/24EkcsBZmqw5hE3da9bzoCn
 hs7QBwjG/x9G4CThNAY4rfP4QupZ0CejD3BI1AM/1ADQ04dzp+rIpZB0MpdlwBSvbDct
 K+a8IidtH4BDHqFGt/fnW+aDSKpwtYxhxDUlvJjNcAUdWKF4zMq0GqdiCw3xCY9cvM/+
 ImscHyINMoKh/dxGYtpR8Eo7wprQ2fongG9MvOc2dUo/ZxA7E3bD4fPxvnG43MLImcq5
 /fHQ==
X-Gm-Message-State: AOJu0Yz2OA+k96KWh98+/EgEtG57cy7iHdkS2PQ7pgOpWqXlTSLRniW+
 JywRvg1umZMh4O6B2AyoznNSkAiAPn2ctbJSa7RTMAwlHr3xcbJNdTQ/5KSOYE9CGibpUXXfbqH
 k++y7n5c=
X-Gm-Gg: ASbGncvrjJuez5Ag66Ggb36HxI2e6ZYi5M2nV21fNdSVBXVWYc0PLGK6nCByVsZztsq
 hREwakvtEGNtabKN1bAcXjQiYrbx1WTfKglFaa/4MEJn/Yw305xbnM1EIg0gX7FylFtGFUo+D2T
 E0ZKSv8MfUniYK32NvwDU3kw54WnOrMItFI8lj7legFP+1/N7CfGRpEPNr9TPuwaBnNO+qdIbHY
 5P68ORVd24nJJBHmCBLu75uKda1h7PlluPBuNsl3oaRMW6v1EE8HV/pWGM0vvmS5bXSTWfTnyfU
 8Bcf8KPG+6parWUncfrrpjQ4ppfLTUcQIAPmeBmF+gUcBZ/jRPsoVkO8RoSVDRhQ2By40GINuRc
 aoPAjev62guMg90uBZZpnzIiHRXESTcKhDGFjnoKCjGmuN4pHG0xZjIIP3vMoVT2MrbBToQSOO8
 17FtJiwdubDz9WaJM9oBL8MQswM/3tvslWmAgd9LBTVuNFMZCWlrPiOA==
X-Google-Smtp-Source: AGHT+IH95GxHRwwFQaXNLIf4O6/uCidCUsCVjNKcQa0zFyv9PuUU/mbwDgecmm3910XEBwCUylrtZg==
X-Received: by 2002:a05:600c:8b0c:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-47939df1b02mr116569885e9.1.1765308420333; 
 Tue, 09 Dec 2025 11:27:00 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d930dffsm28791775e9.2.2025.12.09.11.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 11:26:58 -0800 (PST)
Message-ID: <eee34d92-3c8d-4ae9-93fc-66bff89d279f@linaro.org>
Date: Tue, 9 Dec 2025 20:26:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.2? v2] tests/tcg: Skip syscall catchpoint test
 if pipe2() syscall not available
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20251203143755.65535-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203143755.65535-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

ping?

On 3/12/25 15:37, Philippe Mathieu-Daudé wrote:
> Avoid the following errors testing i386 and ppc64:
> 
>    $ make check-tcg
>    ...
>      TEST    hitting a syscall catchpoint on i386
>    warning: File transfers from remote targets can be slow. Use "set sysroot" to access files locally instead.
>    Traceback (most recent call last):
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
>        main(run_test)
>      File "tests/guest-debug/test_gdbstub.py", line 53, in main
>        test()
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
>        gdb.execute("catch syscall pipe2 read")
>    gdb.error: Unknown syscall name 'pipe2'.
>    qemu-i386: QEMU: Terminated via GDBstub
>    ...
>      TEST    hitting a syscall catchpoint on ppc64
>    warning: File transfers from remote targets can be slow. Use "set sysroot" to access files locally instead.
>    Traceback (most recent call last):
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
>        main(run_test)
>      File "tests/guest-debug/test_gdbstub.py", line 53, in main
>        test()
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
>        gdb.execute("catch syscall pipe2 read")
>    gdb.error: Unknown syscall name 'pipe2'.
>    qemu-ppc64: QEMU: Terminated via GDBstub
>    ...
>      TEST    hitting a syscall catchpoint on ppc64le
>    warning: File transfers from remote targets can be slow. Use "set sysroot" to access files locally instead.
>    Traceback (most recent call last):
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
>        main(run_test)
>      File "tests/guest-debug/test_gdbstub.py", line 53, in main
>        test()
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
>        gdb.execute("catch syscall pipe2 read")
>    gdb.error: Unknown syscall name 'pipe2'.
>    qemu-ppc64le: QEMU: Terminated via GDBstub
>    make: Target 'check-tcg' not remade because of errors.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC because I have no clue whether SYS_pipe2 should be present
>      on these targets, I just want the CI to pass full green.
> 
> v2: Drop extraneous 'if'
> ---
>   tests/tcg/multiarch/gdbstub/catch-syscalls.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/multiarch/gdbstub/catch-syscalls.py b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
> index ccce35902fb..79c8d532d1f 100644
> --- a/tests/tcg/multiarch/gdbstub/catch-syscalls.py
> +++ b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
> @@ -22,7 +22,8 @@ def run_test():
>           gdb.execute("catch syscall pipe2 read")
>       except gdb.error as exc:
>           exc_str = str(exc)
> -        if "not supported on this architecture" in exc_str:
> +        if "not supported on this architecture" in exc_str \
> +                or "Unknown syscall name 'pipe2'" in exc_str:
>               print("SKIP: {}".format(exc_str))
>               return
>           raise


