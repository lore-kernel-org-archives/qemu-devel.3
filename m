Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9D5C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFPl-00028K-0y; Mon, 04 Mar 2024 16:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rhFPj-000285-8M
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 15:59:59 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rhFPh-0004I8-6d
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 15:59:59 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd10a37d68so12833275ad.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 12:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709585995; x=1710190795; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2O8hmbgoS/1Bpg9aup3OOAoP6AXj5m3+v/7AupaYkPQ=;
 b=TnrAB/lYtf9qsf5Rm2qCo2hHphmIlXx5eYHBXJRCZwuU/0waQWSAYVZa9wtndqqKNS
 S656MSE4JeoZ95/EDgS9GpVIv8Vp8pBNuYZjiPDnYEDZRBkruiCVwrJHW6qIzQo4Z1RK
 k267NWSkhdU3RLItA8uP4lfrwHqw/IlNQU2LiLYrW0DS97gxrR7d1waUzDMvzqWOj5lB
 8SnQDZbehBM981zMQqiWCqHQacmpRAdtF3erARWVdgEXHtdBb27HgX4wddApfbKhvDT0
 WGBrdo5e0M4SzHtlxe3WwHFEe8SdR6E7E3VSO9fbW/NnJWcZV9D+ejSxjykVuTiIBFP3
 8cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709585995; x=1710190795;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2O8hmbgoS/1Bpg9aup3OOAoP6AXj5m3+v/7AupaYkPQ=;
 b=IxoRghifxJplGtDPeoFgLxKUAuaDTvtCuulx34v3FkeEJYBX89qs+Ho5KV4WpP3SK2
 GWY3w9C3ZI4FINGXlX2/oIGwrG6nYabCm+6btGiuuIPURxVAPvVE7+gU19qbUvkcmiJE
 U3Zh9qllofrtNsGtK/UxTag/R4I9nqSvQGH6H/UxrQqhKqdzB8mC02zDc2mpixV8KkGz
 BhkvXn4LXy6/7/a/kBsYAVslztWg9IkoDHTQa688j1wQ3hfDCXIDXMBGYiwNLB0GKrkL
 6RlzeJvej+jfzFvSqrjuWfyCjKamBVJghKnBZliY0vn2iRoqZYpJQ7eqCZhmcwhll272
 UD0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZyrzVmGX1vVaVU4dNx2VzBZq3jcKZu75D7u10SvtrwHMnNpXrw26aXfJdWnKjcOAYI3mDOh0u6GAtr/xs5yTzgwIBuk0=
X-Gm-Message-State: AOJu0YyDRWzXc7r6P7U1fwdCQQsY3hyp9jxrYaGVeqq/g1Cg3KHdYEhC
 F4sQarf76Qs3cFikYtMbH6/D7cdOy7EaXCl7fHVPr6ggFXtfYohE1Io5+7goeV0=
X-Google-Smtp-Source: AGHT+IF0U8TZvg6KyPqH1TqDFSJ8k18su0D6ltuNPl9i7Q0nuDOL/r4mfc1qtFTlCWYhEVEGMSMryQ==
X-Received: by 2002:a17:903:124a:b0:1dc:63b2:7c2e with SMTP id
 u10-20020a170903124a00b001dc63b27c2emr11770350plh.31.1709585994967; 
 Mon, 04 Mar 2024 12:59:54 -0800 (PST)
Received: from ?IPv6:2804:7f0:b401:120f:a4b2:91d8:ce8:af88?
 ([2804:7f0:b401:120f:a4b2:91d8:ce8:af88])
 by smtp.gmail.com with ESMTPSA id
 im22-20020a170902bb1600b001dcd00165a6sm9112832plb.208.2024.03.04.12.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 12:59:54 -0800 (PST)
Subject: Re: [PATCH 2/2] tests/tcg: Add multiarch test for Xfer:siginfo:read
 stub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240303192610.498490-1-gustavo.romero@linaro.org>
 <20240303192610.498490-2-gustavo.romero@linaro.org>
 <e33ab9ae-e2d4-41ba-b053-e7e918572808@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <d98ef081-b25d-4dbf-7b67-fe27e09ff2f0@linaro.org>
Date: Mon, 4 Mar 2024 17:59:51 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e33ab9ae-e2d4-41ba-b053-e7e918572808@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.098,
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

Hi Richard!

On 3/4/24 2:21 PM, Richard Henderson wrote:
> On 3/3/24 09:26, Gustavo Romero wrote:
>> Add multiarch test for testing if Xfer:siginfo:read query is properly
>> handled by gdbstub.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/tcg/multiarch/Makefile.target           | 10 ++++++-
>>   .../gdbstub/test-qxfer-siginfo-read.py        | 26 +++++++++++++++++++
>>   tests/tcg/multiarch/segfault.c                | 14 ++++++++++
>>   3 files changed, 49 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
>>   create mode 100644 tests/tcg/multiarch/segfault.c
>>
>> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
>> index e10951a801..61cda9640e 100644
>> --- a/tests/tcg/multiarch/Makefile.target
>> +++ b/tests/tcg/multiarch/Makefile.target
>> @@ -80,6 +80,13 @@ run-gdbstub-qxfer-auxv-read: sha1
>>           --bin $< --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-auxv-read.py, \
>>       basic gdbstub qXfer:auxv:read support)
>> +run-gdbstub-qxfer-siginfo-read: segfault
>> +    $(call run-test, $@, $(GDB_SCRIPT) \
>> +        --gdb $(GDB) \
>> +        --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>> +        --bin "$< -s" --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-siginfo-read.py, \
>> +    basic gdbstub qXfer:siginfo:read support)
>> +
>>   run-gdbstub-proc-mappings: sha1
>>       $(call run-test, $@, $(GDB_SCRIPT) \
>>           --gdb $(GDB) \
>> @@ -122,7 +129,8 @@ endif
>>   EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
>>             run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
>>             run-gdbstub-registers run-gdbstub-prot-none \
>> -          run-gdbstub-catch-syscalls
>> +          run-gdbstub-catch-syscalls \
>> +          run-gdbstub-qxfer-siginfo-read
>>   # ARM Compatible Semi Hosting Tests
>>   #
>> diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
>> new file mode 100644
>> index 0000000000..862596b07a
>> --- /dev/null
>> +++ b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
>> @@ -0,0 +1,26 @@
>> +from __future__ import print_function
>> +#
>> +# Test gdbstub Xfer:siginfo:read stub.
>> +#
>> +# The test runs a binary that causes a SIGSEGV and then looks for additional
>> +# info about the signal through printing GDB's '$_siginfo' special variable,
>> +# which sends a Xfer:siginfo:read query to the gdbstub.
>> +#
>> +# The binary causes a SIGSEGV at dereferencing a pointer with value 0xdeadbeef,
>> +# so the test looks for and checks if this address is correctly reported by the
>> +# gdbstub.
>> +#
>> +# This is launched via tests/guest-debug/run-test.py
>> +#
>> +
>> +import gdb
>> +from test_gdbstub import main, report
>> +
>> +def run_test():
>> +    "Run through the test"
>> +
>> +    gdb.execute("continue", False, True)
>> +    resp = gdb.execute("print/x $_siginfo", False, True)
>> +    report(resp.find("si_addr = 0xdeadbeef"), "Found fault address.")
>> +
>> +main(run_test)
>> diff --git a/tests/tcg/multiarch/segfault.c b/tests/tcg/multiarch/segfault.c
>> new file mode 100644
>> index 0000000000..e6c8ff31ca
>> --- /dev/null
>> +++ b/tests/tcg/multiarch/segfault.c
>> @@ -0,0 +1,14 @@
>> +#include <stdio.h>
>> +#include <string.h>
>> +
>> +/* Cause a segfault for testing purposes. */
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +    int *ptr = (void *)0xdeadbeef;
>> +
>> +    if (argc == 2 && strcmp(argv[1], "-s") == 0) {
>> +        /* Cause segfault. */
>> +        printf("%d\n", *ptr);
>> +    }
>> +}
> 
> Any reason SIGSEGV is interesting?

I'm particularly interested in the SIGSEGV because that's the signal
generated on a MTE tag mismatch. GDB uses the si_code to show
additional info on the fault, for instance:

gromero@arm64:~$ gdb -q
(gdb) target remote amd:1234
Remote debugging using amd:1234
Reading /home/gromero/git/qemu/build/mte_t from remote target...
warning: File transfers from remote targets can be slow. Use "set sysroot" to access files locally instead.
Reading /home/gromero/git/qemu/build/mte_t from remote target...
Reading symbols from target:/home/gromero/git/qemu/build/mte_t...
Failed to read a valid object file image from memory.
0x0000000000400580 in _start ()
(gdb) c
Continuing.

Program received signal SIGSEGV, Segmentation fault
Memory tag violation           <============ (the info I'm keen on)
Fault address unavailable.
0x0000000000407290 in puts ()
(gdb)


> Perhaps just abort for SIGABRT instead?

Although this can make a simpler test, the test can't control
the si_addr value easily, which I think is interesting to be tested.

Why do you prefer SIGABRT?


> A test using setitimer to raise SIGALRM would test the async path.

SIGLARM doesn't generate any interesting siginfo?

gromero@arm64:~$ gdb -q ./sigalrm
Reading symbols from ./sigalrm...
(gdb) run
Starting program: /home/gromero/sigalrm

Program terminated with signal SIGALRM, Alarm clock.
The program no longer exists.
(gdb) p $_siginfo
$1 = void
(gdb)


Cheers,
Gustavo

