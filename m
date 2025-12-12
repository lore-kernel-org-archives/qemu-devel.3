Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1450DD59D6F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU70W-0008G6-E1; Fri, 12 Dec 2025 12:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vU70V-0008FZ-1Q
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:32:43 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vU70S-00052D-EF
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:32:42 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7e2762ad850so1514796b3a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765560759; x=1766165559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gB5BecI3gnCVhlQyJ77/xZNlKac92qpuR5XsE0e1e/Y=;
 b=AKTzi79jBv9z32cC6nw6ryvcaKQ95m6qNC1D+QX2ZliIycbymLXNpKl1VUpHb+rrjY
 FJF/mJqwPDiWKM62v4nR6VDpDh8gSwHozH6G5hI+5k07FxcLSheQy3+P3unLZna64peb
 34UKxfn/J0jPiV1SWzoiMP3o4pcKd7pqZJ3tlydG+2znYPcaKAK2kItRxN1N4Qf5I0p8
 O4xXe4Jr5pGsi/9KRRohpUKgNidUJDp4ANC4PObJgDDe14zn0OZ3UF0BednPwmptHTXh
 3HyiPh0oxDPouhDRRur7spK40elTZLce8sOkqB/4L6K7SxK6XWa5TCTwDtWpe13LwiH+
 Tcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765560759; x=1766165559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gB5BecI3gnCVhlQyJ77/xZNlKac92qpuR5XsE0e1e/Y=;
 b=WVIMRX/MZvxQu3ES9jrXicTAlvWMqcJEUkTDDSEC4fYIJVmk3HbztaN7d/HmTNP/Ch
 RkFrLb4POZPnC8shVtlQx6ve1b4FypwgX47QnYalnut95cGQEIjTUlIQXaqdTUbUQheh
 BKCdayZ/XNaHcAthnNEgI1wD0EMosGuTip54T1xI4C8YmDOU9w3tZn6X9Sso+7RsIAyw
 PIVCgUn2dc+PnxYMeOiCOUPEx95DUmdRBxx6syjSlE7YOzGz/PdhwQBfYgbt0+Su+HIc
 +jXTctebny82CGHJD/fS9q4j5PXf80uV4vPichEVumsvVjCQQ9v4rFKaWw+v3vEa7Zzj
 3vog==
X-Gm-Message-State: AOJu0YzcHM5Po4gpFbWWBsGoqYlATogUrwZRPcava58FqysmHZfG1Xd2
 FagZMvEOeD2vfrJSj9D1EZzBLtfr6r0pRM9aqLZrNVdu2ZJGSh/Az7922HvmNtUjTnxaQ5D/zSv
 JFeEkaGRQfg==
X-Gm-Gg: AY/fxX5OHGrmrHO/z2QfMZVTlG3YLF/bCXeGNgNCXn7FmJTr9spUVZFBDA9RFrGJqBF
 E7X6ak1tdKdajBW3Aoy3m6LxHixjzdxEWGfJjfMLGauSbagu3wKF1zW+aEm4Rjsx9lp1PeyjeuX
 j3cZyn0DtWg2lg6YTY/cTvyYjJB4tixnfcVJh2e5jX6FhUIZbHnRb485lgxtLG2SmBkQ+pE9plm
 6hKMOk3GvXVOIJpGL3TYJf/qM4gBj/SuMLqSFktufQ2aD3+0Ap9kXFi5ctOAeUpE+BJCIHRFlYi
 FuQ5hXFqmvR+aeJHUzYlHi7w7y/XNPwlfNEbNcOkQY9db8Nk9sFlMIsda5wWiMlUZsCQgNRK67q
 5HMWISk1uYrd4gQH3BzyO3VW1jT/7H1NelnSFLdTslytORi3GEKjym0i2GMOlHWjzhSIF6Nl5WM
 T0OaxzFJ7tKDikZPvbBu2mxJXBwBUP0zs20flqKEDdQaa+DK5aN7fW8HvLKcvJn70UGw==
X-Google-Smtp-Source: AGHT+IEV2N31FySvnPWADkx14+kbMaK+vVKC88FuSyaAplT+MQS2I91+M0e7vFVNCkTv0jeIDYej1A==
X-Received: by 2002:a05:6a00:94f4:b0:7e8:4433:8fb7 with SMTP id
 d2e1a72fcca58-7f66a07ce19mr2155508b3a.63.1765560758892; 
 Fri, 12 Dec 2025 09:32:38 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7f4c4ab52aasm5757420b3a.38.2025.12.12.09.32.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 09:32:38 -0800 (PST)
Message-ID: <43ebfbb8-479c-420a-904e-5aba9532d823@linaro.org>
Date: Fri, 12 Dec 2025 09:32:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tcg tests: add a test to verify the syscall filter
 plugin API
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20251212141541.1792111-1-functioner@sjtu.edu.cn>
 <20251212141541.1792111-3-functioner@sjtu.edu.cn>
 <87ldj7sn9k.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ldj7sn9k.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 12/12/25 8:00 AM, Alex Bennée wrote:
> Ziyang Zhang <functioner@sjtu.edu.cn> writes:
> 
>> Register a syscall filter callback in tests/tcg/plugins/sycall.c,
>> returns a specific value for a magic system call number, and check
>> it in tests/tcg/multiarch/test-plugin-syscall-filter.c.
>>
>> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
>> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
>> ---
>>   tests/tcg/multiarch/Makefile.target           |  4 +++-
>>   .../multiarch/test-plugin-syscall-filter.c    | 20 +++++++++++++++++++
>>   tests/tcg/plugins/syscall.c                   | 15 ++++++++++++++
>>   3 files changed, 38 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
>>
>> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
>> index f5b4d2b813..4005e3a8a9 100644
>> --- a/tests/tcg/multiarch/Makefile.target
>> +++ b/tests/tcg/multiarch/Makefile.target
>> @@ -202,8 +202,10 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>>   	CHECK_PLUGIN_OUTPUT_COMMAND= \
>>   	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>>   	$(QEMU) $<
>> +run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
>>   
>> -EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so
>> +EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
>> +			   			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
>>   endif
>>   
>>   # Update TESTS
>> diff --git a/tests/tcg/multiarch/test-plugin-syscall-filter.c b/tests/tcg/multiarch/test-plugin-syscall-filter.c
>> new file mode 100644
>> index 0000000000..cc694e0a71
>> --- /dev/null
>> +++ b/tests/tcg/multiarch/test-plugin-syscall-filter.c
>> @@ -0,0 +1,20 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This test attempts to execute a magic syscall. The syscall test plugin
>> + * should intercept this and returns an expected value.
>> + */
>> +
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +
>> +int main(int argc, char *argv[]) {
>> +    long ret = syscall(0x66CCFF);
>> +    if (ret != 0xFFCC66) {
>> +        perror("ERROR: syscall returned unexpected value!!!");
>> +        return EXIT_FAILURE;
>> +    }
>> +    return EXIT_SUCCESS;
>> +}
> 
>    This breaks some arches:
> 
>    (gdb) r
>    Starting program: /home/alex/lsrc/qemu.git/builds/sanitisers/qemu-arm -plugin tests/tcg/plugins/libsyscall.so -d plugin ./tests/tcg/arm-linux-user/test-plugin-syscall-filter
>    [New Thread 0x7ffff37ff6c0 (LWP 63692)]
>    qemu: uncaught target signal 4 (Illegal instruction) - core dumped
>    syscall no.  calls  errors
>    45           5      0
>    338          1      1
>    256          1      0
>    191          1      0
>    398          1      1
>    125          1      0
>    384          1      0
>    332          1      0
> 
>    Thread 1 "qemu-arm" received signal SIGILL, Illegal instruction.
>    Download failed: Invalid argument.  Continuing without source file ./nptl/../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S.
>    __syscall_cancel_arch () at ../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S:56
>    warning: 56     ../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S: No such file or directory
>    (gdb) bt
>    #0  __syscall_cancel_arch () at ../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S:56
>    #1  0x00007ffff6a51668 in __internal_syscall_cancel (a1=<optimized out>, a2=a2@entry=8, a3=a3@entry=0, a4=a4@entry=0, a5=a5@entry=0, a6=a6@entry=0, nr=130)
>        at ./nptl/cancellation.c:49
>    #2  0x00007ffff6a516ad in __syscall_cancel (a1=<optimized out>, a2=a2@entry=8, a3=a3@entry=0, a4=a4@entry=0, a5=a5@entry=0, a6=a6@entry=0, nr=130)
>        at ./nptl/cancellation.c:75
>    #3  0x00007ffff6a0207d in __GI___sigsuspend (set=<optimized out>) at ../sysdeps/unix/sysv/linux/sigsuspend.c:26
>    #4  0x0000555555a49b80 in die_with_signal (host_sig=4) at ../../linux-user/signal.c:807
>    #5  0x0000555555a49ed0 in dump_core_and_abort (env=0x532000004300, target_sig=4) at ../../linux-user/signal.c:847
>    #6  0x0000555555a4c969 in handle_pending_signal (cpu_env=0x532000004300, sig=4, k=0x5250000029d0) at ../../linux-user/signal.c:1306
>    #7  0x0000555555a4d0e5 in process_pending_signals (cpu_env=0x532000004300) at ../../linux-user/signal.c:1386
>    #8  0x0000555555873930 in cpu_loop (env=0x532000004300) at ../../linux-user/arm/cpu_loop.c:479
>    #9  0x0000555555a3eca7 in main (argc=6, argv=0x7fffffffe588, envp=0x7fffffffe5c0) at ../../linux-user/main.c:1035
>    (gdb)
> 
>> \ No newline at end of file
>> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
>> index 42801f5c86..1323e18bc0 100644
>> --- a/tests/tcg/plugins/syscall.c
>> +++ b/tests/tcg/plugins/syscall.c
>> @@ -170,6 +170,20 @@ static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
>>       }
>>   }
>>   
>> +static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
>> +                                int64_t num, uint64_t a1, uint64_t a2,
>> +                                uint64_t a3, uint64_t a4, uint64_t a5,
>> +                                uint64_t a6, uint64_t a7, uint64_t a8,
>> +                                uint64_t *ret)
>> +{
>> +    if (num == 0x66CCFF) {
>> +        *ret = 0xFFCC66;
>> +        qemu_plugin_outs("syscall 0x66CCFF filtered, ret=0xFFCC66\n");
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>>   static void print_entry(gpointer val, gpointer user_data)
>>   {
>>       SyscallStats *entry = (SyscallStats *) val;
>> @@ -255,6 +269,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>   
>>       qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>>       qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
>> +    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
>>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>       return 0;
>>   }
> 

Looks like a simple issue with 32 bits target.

