Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CB5C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 15:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI9Jf-0005fX-8K; Fri, 14 Jun 2024 11:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sI9Je-0005dP-8k
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 11:58:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sI9Jb-0005RJ-RZ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 11:58:13 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f717b3f2d8so24894745ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718380688; x=1718985488; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pROhMX8EFkOfaeo96QLnG9QjNamjHH5TsrCTCMpZpZ4=;
 b=u9RniwL1aGr7R07KvP84LmP5MNaB5/Y7fH6KVv70eV8BBgTQU71rvdi5Jvxm0kydul
 w/otc3ie00BFSUSy0wdCZZwAjA0mKtNW75lxCbkC481L/lNRnNgQuIttnDrhD6lx7ckM
 EswnE6BiuJjF+5aFPKMvyC3deE0vv0QwPwtYsMDachgA0HE2kEhB848vV/okA3+pIhWj
 63gn4Zv+mqB60iWdzw6iZxdGTRl1Vrk0tKo/fcTqAdviIzVtsExsdmmHVxsJiaFarvGo
 qeo0yrmD0RaWbNc+gGCuMWnQcHXpfoJJj3sLOe/Qqqrh7BzqttQ9xKOzGW17qFL8uAqT
 ixsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718380688; x=1718985488;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pROhMX8EFkOfaeo96QLnG9QjNamjHH5TsrCTCMpZpZ4=;
 b=RUhGMv7zkc2lQWlxs59nqDeodSgPnENwSdikT6aVHazvKvkLVkDrwQs64WKDVzAphp
 g6GQZO5SxkklHZ/3DDKNLGFAWOTlHv0X89RmqdC52EAl+Z2bFoP0XioVBR/ruNuiWQpt
 uwOgRc2KW9CWWgOJl8UPiI2FeMOtbRKaXSZzF4E5iIAsGP96JuPCR40x6XCsKYiCN+wg
 uuUqSYxhgbbxgNm+THBJm60UOvxWrZ1wxMqG9YznNx+1FYwOtwvnvHbbNmHUJ7tFuEpF
 oaBGSWUkP665Mb7FOpccMhSiIq90EE5CwPI+0JAt42BvDryHboXI1yBbSbLUYMzg9EhZ
 Ymlw==
X-Gm-Message-State: AOJu0YzKdaq0oBUvrarecH8aF6wtWuArz3v7gGDRnef08ic1T21qBlWi
 szRAD9RmbQ/i9vmW8EYfAEclPQUKUG/OFuTxzqDQBL0ZtCAklo2YUD7ceMlRqps=
X-Google-Smtp-Source: AGHT+IHOcCQKEBEIZnwlopykvsE1lbSwSs7bQHfeOGOgsAOG/g6Hd+8fXKpEY/Y2TU3pUTV9xiZftQ==
X-Received: by 2002:a17:902:ef50:b0:1f8:4a12:ed6e with SMTP id
 d9443c01a7336-1f84e42e34dmr101180755ad.25.1718380687914; 
 Fri, 14 Jun 2024 08:58:07 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5?
 ([2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e55f80sm33729105ad.50.2024.06.14.08.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 08:58:07 -0700 (PDT)
Subject: Re: [PATCH v2 9/9] tests/tcg/aarch64: Add MTE gdbstub tests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-10-gustavo.romero@linaro.org>
 <87o783u4wq.fsf@draig.linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <37625bc5-d13b-4f05-26a1-1626314d6869@linaro.org>
Date: Fri, 14 Jun 2024 12:58:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87o783u4wq.fsf@draig.linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.018,
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

Hi Alex!

On 6/14/24 8:42 AM, Alex Bennée wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
>> Add tests to exercise the MTE stubs.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/tcg/aarch64/Makefile.target     |  11 ++-
>>   tests/tcg/aarch64/gdbstub/test-mte.py |  86 ++++++++++++++++++++++
>>   tests/tcg/aarch64/mte-8.c             | 102 ++++++++++++++++++++++++++
>>   3 files changed, 197 insertions(+), 2 deletions(-)
>>   create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py
>>   create mode 100644 tests/tcg/aarch64/mte-8.c
>>
>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
>> index 70d728ae9a..d2e3f251eb 100644
>> --- a/tests/tcg/aarch64/Makefile.target
>> +++ b/tests/tcg/aarch64/Makefile.target
>> @@ -62,7 +62,7 @@ AARCH64_TESTS += bti-2
>>   
>>   # MTE Tests
>>   ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
>> -AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
>> +AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8
>>   mte-%: CFLAGS += -march=armv8.5-a+memtag
>>   endif
>>   
>> @@ -127,7 +127,14 @@ run-gdbstub-sve-ioctls: sve-ioctls
>>   		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
>>   	basic gdbstub SVE ZLEN support)
>>   
>> -EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
>> +run-gdbstub-mte: mte-8
>> +	$(call run-test, $@, $(GDB_SCRIPT) \
>> +		--gdb $(GDB) \
>> +		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>> +		--bin "$< -s" --test $(AARCH64_SRC)/gdbstub/test-mte.py, \
>> +	gdbstub MTE support)
>> +
>> +EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls run-gdbstub-mte
>>   endif
>>   endif
>>   
>> diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
>> new file mode 100644
>> index 0000000000..ec49eb8d2b
>> --- /dev/null
>> +++ b/tests/tcg/aarch64/gdbstub/test-mte.py
>> @@ -0,0 +1,86 @@
>> +from __future__ import print_function
>> +#
>> +# Test GDB memory-tag commands that exercise the stubs for the qIsAddressTagged,
>> +# qMemTag, and QMemTag packets. Logical tag-only commands rely on local
>> +# operations, hence don't exercise any stub.
>> +#
>> +# The test consists in breaking just after a atag() call (which sets the
>> +# allocation tag -- see mte-8.c for details) and setting/getting tags in
>> +# different memory locations and ranges starting at the address of the array
>> +# 'a'.
>> +#
>> +# This is launched via tests/guest-debug/run-test.py
>> +#
>> +
>> +
>> +import gdb
>> +import re
>> +from test_gdbstub import main, report
>> +
>> +
>> +PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
>> +PATTERN_1 = ".*(0x[0-9a-f]+)"
>> +
>> +
>> +def run_test():
>> +    gdb.execute("break 99", False, True)
>> +    gdb.execute("continue", False, True)
>> +    try:
>> +        # Test if we can check correctly that the allocation tag for
>> +        # array 'a' matches the logical tag after atag() is called.
>> +        co = gdb.execute("memory-tag check a", False, True)
>> +        tags_match = re.findall(PATTERN_0, co, re.MULTILINE)
>> +        if tags_match:
>> +            report(True, f"{tags_match[0]}")
>> +        else:
>> +            report(False, "Logical and allocation tags don't match!")
>> +
>> +        # Test allocation tag 'set and print' commands. Commands on logical
>> +        # tags rely on local operation and so don't exercise any stub.
>> +
>> +        # Set the allocation tag for the first granule (16 bytes) of
>> +        # address starting at 'a' address to a known value, i.e. 0x04.
>> +        gdb.execute("memory-tag set-allocation-tag a 1 04", False, True)
>> +
>> +        # Then set the allocation tag for the second granule to a known
>> +        # value, i.e. 0x06. This tests that contiguous tag granules are
>> +        # set correct and don't run over each other.
>> +        gdb.execute("memory-tag set-allocation-tag a+16 1 06", False, True)
>> +
>> +        # Read the known values back and check if they remain the same.
>> +
>> +        co = gdb.execute("memory-tag print-allocation-tag a", False, True)
>> +        first_tag = re.match(PATTERN_1, co)[1]
>> +
>> +        co = gdb.execute("memory-tag print-allocation-tag a+16", False, True)
>> +        second_tag = re.match(PATTERN_1, co)[1]
>> +
>> +        if first_tag == "0x4" and second_tag == "0x6":
>> +            report(True, "Allocation tags are correctly set/printed.")
>> +        else:
>> +            report(False, "Can't set/print allocation tags!")
>> +
>> +        # Now test fill pattern by setting a whole page with a pattern.
>> +        gdb.execute("memory-tag set-allocation-tag a 4096 0a0b", False, True)
>> +
>> +        # And read back the tags of the last two granules in page so
>> +        # we also test if the pattern is set correctly up to the end of
>> +        # the page.
>> +        co = gdb.execute("memory-tag print-allocation-tag a+4096-32", False, True)
>> +        tag = re.match(PATTERN_1, co)[1]
>> +
>> +        co = gdb.execute("memory-tag print-allocation-tag a+4096-16", False, True)
>> +        last_tag = re.match(PATTERN_1, co)[1]
>> +
>> +        if tag == "0xa" and last_tag == "0xb":
>> +            report(True, "Fill pattern is ok.")
>> +        else:
>> +            report(False, "Fill pattern failed!")
>> +
>> +    except gdb.error:
>> +        # This usually happens because a GDB version that does not
>> +        # support memory tagging was used to run the test.
>> +        report(False, "'memory-tag' command failed!")
>> +
>> +
>> +main(run_test, expected_arch="aarch64")
>> diff --git a/tests/tcg/aarch64/mte-8.c b/tests/tcg/aarch64/mte-8.c
>> new file mode 100644
>> index 0000000000..367768e6b6
>> --- /dev/null
>> +++ b/tests/tcg/aarch64/mte-8.c
>> @@ -0,0 +1,102 @@
>> +/*
>> + * To be compiled with -march=armv8.5-a+memtag
>> + *
>> + * This test is adapted from a Linux test. Please see:
>> + *
>> + * https://www.kernel.org/doc/html/next/arch/arm64/memory-tagging-extension.html#example-of-correct-usage
>> + */
>> +#include <errno.h>
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <sys/auxv.h>
>> +#include <sys/mman.h>
>> +#include <sys/prctl.h>
>> +#include <string.h>
>> +/*
>> + * From arch/arm64/include/uapi/asm/hwcap.h
>> + */
>> +#define HWCAP2_MTE              (1 << 18)
>> +
>> +/*
>> + * From arch/arm64/include/uapi/asm/mman.h
>> + */
>> +#define PROT_MTE                 0x20
>> +
>> +/*
>> + * Insert a random logical tag into the given pointer.
>> + */
>> +#define insert_random_tag(ptr) ({                   \
>> +    uint64_t __val;                                 \
>> +    asm("irg %0, %1" : "=r" (__val) : "r" (ptr));   \
>> +    __val;                                          \
>> +})
>> +
>> +/*
>> + * Set the allocation tag on the destination address.
>> + */
>> +#define set_tag(tagged_addr) do {                                      \
>> +        asm volatile("stg %0, [%0]" : : "r" (tagged_addr) : "memory"); \
>> +} while (0)
>> +
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +    unsigned char *a;
>> +    unsigned long page_sz = sysconf(_SC_PAGESIZE);
>> +    unsigned long hwcap2 = getauxval(AT_HWCAP2);
>> +
>> +    if (!(argc == 2 && strcmp(argv[1], "-s") == 0)) {
>> +        return 0;
>> +    }
> 
> Whats this trying to do? I would expect the test case to be able to run
> normally without being debugged by gdb, so why do we need a particular
> command line to shortcut it here?

Good catch. This is a leftover. The first versions of the test
would cause a sigsegv, but I simplified it on this final version,
so it runs normally now.

Removed in v3. Thanks


>> +
>> +    /* check if MTE is present */
>> +    if (!(hwcap2 & HWCAP2_MTE))
>> +            return EXIT_FAILURE;
>> +
>> +    /*
>> +     * Enable the tagged address ABI, synchronous or asynchronous MTE
>> +     * tag check faults (based on per-CPU preference) and allow all
>> +     * non-zero tags in the randomly generated set.
>> +     */
>> +    if (prctl(PR_SET_TAGGED_ADDR_CTRL,
>> +              PR_TAGGED_ADDR_ENABLE | PR_MTE_TCF_SYNC | PR_MTE_TCF_ASYNC |
>> +              (0xfffe << PR_MTE_TAG_SHIFT),
>> +              0, 0, 0)) {
>> +        perror("prctl() failed");
>> +        return EXIT_FAILURE;
>> +    }
>> +
>> +    a = mmap(0, page_sz, PROT_READ | PROT_WRITE,
>> +             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +    if (a == MAP_FAILED) {
>> +        perror("mmap() failed");
>> +        return EXIT_FAILURE;
>> +    }
>> +
>> +    printf("a[] address is %p\n", a);
>> +
>> +    /*
>> +     * Enable MTE on the above anonymous mmap. The flag could be passed
>> +     * directly to mmap() and skip this step.
>> +     */
>> +    if (mprotect(a, page_sz, PROT_READ | PROT_WRITE | PROT_MTE)) {
>> +        perror("mprotect() failed");
>> +        return EXIT_FAILURE;
>> +    }
>> +
>> +    /* access with the default tag (0) */
>> +    a[0] = 1;
>> +    a[1] = 2;
>> +
>> +    printf("a[0] = %hhu a[1] = %hhu\n", a[0], a[1]);
>> +
>> +    /* set the logical and allocation tags */
>> +    a = (unsigned char *)insert_random_tag(a);
>> +    set_tag(a);
>> +
>> +    printf("%p\n", a);
>> +
>> +    return 0;
>> +}
> 

