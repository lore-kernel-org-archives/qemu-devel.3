Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B969C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBHd-0005ne-Mk; Wed, 12 Aug 2026 11:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBHc-0005nQ-Ci
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:54:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBHa-0004YJ-Bm
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:54:24 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbn4Z3971665
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9RiIQLNQNIpk+8ImTVvsyfvy34dmoBX5K5OHGEUgLKo=; b=Ot1X3Rtst5mOTQY4
 U/9phpKCjRZwsDdrf/3CCWhvtqf39iT/LjmwAS5SYHiCnAof21Mx8973eGFUL7OW
 rrH1S/62bwx5K8+Ti4a++GWLEmZsxL3WrY/5DD2yB26+VH6E1hPnfLEViE3XhWkD
 0BFwWiPnUWiNlONA5qdVGJCZXE/5k6VfgSpAYa4znV4pD5B3LLa1RafJsL8qbO3M
 GfZpfzsfSZPiBuzK19jwOXgGmEMUdhZLryOIyMayH4UGRQ0tVORQPcP37EueGu9F
 ZfzBcqJC0vV1mGUMhyqWsumsDOaB/Hm6SaiZ3Uw7Np3eBKSO99ZVayJPVoDKi8Ma
 GGtwDQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrjm9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:54:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so1566529a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786550060; x=1787154860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9RiIQLNQNIpk+8ImTVvsyfvy34dmoBX5K5OHGEUgLKo=;
 b=eRhMWisZCThV1O+FeBisjdY81a8fhWXOqlFtobbA4tWKXd4BpXMmpoMeSdw00hT6GZ
 Z1PyKSbO/kLLivt0jN5ADwK0UZOF1Mz4YuBoWkZCobZMnAoV+RjvxBA0YtdK1C7MJ97p
 dCtknFUHYb+gOFWnFXVAiMKWxMwRn+bn7BiXaAVt4fbohSf21K4Ci9eqMWfXTsxg2Q0I
 m2w+FbV6jDEt+SqGxP6X2U+9kPXc4Zk7vAF9tbqcey2p6y+k+vpcsVwyK4Hn6fVQxPg+
 Yku0/cG9YDSRVPwd4qXqA1xlVH64G1tNus0WQirRiZx7kWhvnGVl0AkOEiegmtx3KJAV
 b5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550060; x=1787154860;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9RiIQLNQNIpk+8ImTVvsyfvy34dmoBX5K5OHGEUgLKo=;
 b=DA5LfTQNkz+yFmgzCcLVf8K6r0v6FImD0GqSutnz1RLU5tW40PINBRhmpzd4ezxXde
 Uz1D3UXKlluHDmrAuzVWb93+UKqB9Ny45VQkxbXohIQ9qSGi9o0+qRtE7uhnwxHpPl1V
 t/XxEA5pvJqsW2VkOkkSj3qOtgCP7KcxLhHMhYzzVUjwf2yCM7mBzxi2nkdYciHBKOdS
 FWp1h2gUPda6mNKLxUIxjiFeHc3vM+DBW0mY7PIRv52c6yyezruaMEI1L5JrFzrMLF/u
 j/xwpv0s241OZFw59e7UIsbXhGWbpmKfTICINI0d9YUH8LjNsVMSU3NPcPCW/1KZVLHv
 yF6g==
X-Gm-Message-State: AOJu0Yz2gYINxf7WCbTqJFYQpRp+Bcxz/QEsUwOx/pzr/eicbUGrIeos
 njxUttdXhHISycVm/2wPtTK+ZTtJ0jeRvUblwqlYVGiIBK5CHgEqvh39ciLKQ69ihSlmvawqnX4
 ThWnd2SomeaumFlh5CbfNMTZy5TQRhvB3FI46J24nS4C+pevT3Nf3QsXjSQ==
X-Gm-Gg: AR+sD10nH/H5XoBeNrYin4wxME/uFFZvfWXM7DwzQXqX7su4YI7gHmH+L3mQwf0vaEw
 5bpHPjEYYUW+ArvwUibL5Hzq5kR316oEK6AX8hIG8A/7bR9CBq4wT6vVZ7LPuk3tUKbhvz4mdJG
 dDzz4gJFnY9lQHq9/09vnh1+HBG61sotgD2w6F6t//hF+4PI4cDUG4Cfeo0YB+QGAO9rKhuZ3pr
 BYJTqSg01rxBIJU5KstHGidtipYQHt4lavMVuMiMnkpU9BRJRLEutSUPCyNBQpvL3Sv+7sScdAi
 BzYuCl6lWSJt7mCIyF5imHvt4TqX7v3VVWdJU+Hkce7SMarLmV+WpwLe57B2xgJRbUSqfNwqyvI
 6Fnj7yvi7urggx2MgLRmRNIOkZIkq3BWIfAxZ7ktBH3c2Ti5HyCvUT6KXzKHPtyiPDOCP
X-Received: by 2002:a17:90b:1dc6:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-393013c4248mr8561573a91.2.1786550059531; 
 Wed, 12 Aug 2026 08:54:19 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc6:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-393013c4248mr8561509a91.2.1786550059004; 
 Wed, 12 Aug 2026 08:54:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f94adf39sm3943934a91.11.2026.08.12.08.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 08:54:18 -0700 (PDT)
Message-ID: <a169bf77-bc23-4648-9381-7064bf7d5d68@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 08:54:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 047/103] tests/tcg/arm: system tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-48-pierrick.bouvier@oss.qualcomm.com>
 <878q6bz6zt.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <878q6bz6zt.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOSBTYWx0ZWRfX9NI5+c6zaYfd
 9iAm080XT6QpdW4ieX7d1dtGdl8W6Sqjbx9no1SMU0nWr0snmRt/Ddf53949RK/b/9AYQe8OYym
 LOO28Dse/+q4cXmUw0wMDA5nG+NZnb0eqvJw6GrRwSJeeOyOxaeDTJpIr7uNUwkiTCxzNkEsy0T
 q7B4dAKBRYGelYs0iiRFbLcyBQuRjByjQCw8UwKX9IPC0s9PEOophwcOjlEk4kkYen982NowTSb
 psxRPbnf5BQCmwQQq3+5dXylFOZt62e+ZL1dso6cKJDLkfdkYjx3CXiITaeXNWSCDsLfER4Ps5K
 N88OXuyKaSQNyxYbJ1odZwDBrYVlB/aUFEf+uFjDjYI0e7jeIvX//ayOesqykwI2R/zuQqZugtd
 PSZmueS5DlmTbTK8fwvfBXJ1JnEMn9fpAvz9dcbSGqp9fB79l5CQ8NhVlTt8ghpeaE+x+RtVMGn
 IJOYJ4R0Gl+bon4nAuA==
X-Proofpoint-ORIG-GUID: 0ssZWPUSr3M-akZKLBvrO6lpfXqbhOof
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c972c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=8wjV5V48YhLn6wfS8coA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 0ssZWPUSr3M-akZKLBvrO6lpfXqbhOof
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOSBTYWx0ZWRfX9JQBcNAk2E6J
 fCy8IOdWjbABe0lLoFUvtctSsX6RODxX6bMA4tU8nqzaolHgFliuzDewSPpUZrFe3s9YDi6KUG2
 PlMrhxP0E5uKU+9ovOTltybbmYMOCbs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 8/12/2026 8:35 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/tcg/arm/Makefile.softmmu-target | 80 ---------------------------
>>  tests/tcg/arm/meson.build             |  2 +
>>  tests/tcg/arm/system/meson.build      | 66 ++++++++++++++++++++++
>>  3 files changed, 68 insertions(+), 80 deletions(-)
>>  delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
>>  create mode 100644 tests/tcg/arm/system/meson.build
>>
>> diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
>> deleted file mode 100644
>> index b66074b0b43..00000000000
>> --- a/tests/tcg/arm/Makefile.softmmu-target
>> +++ /dev/null
>> @@ -1,80 +0,0 @@
>> -# -*- Mode: makefile -*-
>> -#
>> -# ARM SoftMMU tests - included from tests/tcg/Makefile
>> -#
>> -
>> -ARM_SRC=$(SRC_PATH)/tests/tcg/arm/system
>> -
>> -# Set search path for all sources
>> -VPATH 		+= $(ARM_SRC)
>> -
>> -# Specific Test Rules
>> -
>> -test-armv6m-undef: test-armv6m-undef.S
>> -	$(CC) -mcpu=cortex-m0 -mfloat-abi=soft \
>> -		-Wl,--build-id=none -x assembler-with-cpp \
>> -		$< -o $@ -nostdlib -static \
>> -		-T $(ARM_SRC)/$@.ld
>> -
>> -run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,chardev=output -M microbit -kernel
>> -
>> -ARM_TESTS+=test-armv6m-undef
>> -
>> -# These objects provide the basic boot code and helper functions for all tests
>> -CRT_OBJS=boot.o
>> -
>> -ARM_TEST_SRCS=$(wildcard $(ARM_SRC)/*.c)
>> -ARM_TESTS+=$(patsubst $(ARM_SRC)/%.c, %, $(ARM_TEST_SRCS))
>> -
>> -CRT_PATH=$(ARM_SRC)
>> -LINK_SCRIPT=$(ARM_SRC)/kernel.ld
>> -LDFLAGS=-Wl,-T$(LINK_SCRIPT)
>> -CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
>> -LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
>> -
>> -# building head blobs
>> -.PRECIOUS: $(CRT_OBJS)
>> -
>> -%.o: $(ARM_SRC)/%.S
>> -	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
>> -
>> -# Build and link the tests
>> -%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
>> -	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
>> -
>> -memory: CFLAGS+=-DCHECK_UNALIGNED=0
>> -
>> -# Running
>> -QEMU_BASE_MACHINE=-M virt -cpu max -display none
>> -QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
>> -
>> -# console test is manual only
>> -QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
>> -run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST)  -kernel
>> -run-semiconsole: semiconsole
>> -	$(call skip-test, $<, "MANUAL ONLY")
>> -	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
>> -run-plugin-semiconsole-with-%: semiconsole
>> -	$(call skip-test, $<, "MANUAL ONLY")
>> -
>> -# Simple Record/Replay Test
>> -.PHONY: memory-record
>> -run-memory-record: memory-record memory
>> -	$(call run-test, $<, \
>> -	  $(QEMU) -monitor none -display none \
>> -		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
>> -		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
>> -		  $(QEMU_OPTS) memory)
>> -
>> -.PHONY: memory-replay
>> -run-memory-replay: memory-replay run-memory-record
>> -	$(call run-test, $<, \
>> -	  $(QEMU) -monitor none -display none \
>> -		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
>> -		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
>> -		  $(QEMU_OPTS) memory)
>> -
>> -EXTRA_RUNS+=run-memory-replay
>> -
>> -TESTS += $(ARM_TESTS) $(MULTIARCH_TESTS)
>> -EXTRA_RUNS+=$(MULTIARCH_RUNS)
>> diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
>> index 08a863699fb..1b491cea026 100644
>> --- a/tests/tcg/arm/meson.build
>> +++ b/tests/tcg/arm/meson.build
>> @@ -2,6 +2,8 @@ cc = 'arm-linux-gnueabihf-gcc'
>>  cc_dockerfile = 'debian-all-test-cross'
>>  cc_docker_host_arch = ['aarch64', 'x86_64']
>>  
>> +subdir('system')
>> +
>>  tests = []
>>  
>>  # Multi arch tests
>> diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
>> new file mode 100644
>> index 00000000000..d507cf980f6
>> --- /dev/null
>> +++ b/tests/tcg/arm/system/meson.build
>> @@ -0,0 +1,66 @@
>> +tests = []
>> +
>> +minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
>> +minilib_printf = files(minilib_dir / 'printf.c')[0]
>> +link_script = files('kernel.ld')[0]
>> +boot = files('boot.S')[0]
>> +cflags = ['-nostdlib',
>> +          '-Wa,--noexecstack',
>> +          '-I', minilib_dir, minilib_printf, boot,
>> +          '-Wl,-T', link_script,
>> +          '-lgcc']
> 
> Needs to be:
> 
>    cflags = ['-march=armv7-a+fp',                                                                                                                                               
>            '-ffreestanding',                                                                                                                                                  
>            '-nostdlib',
>            ...
>

I'll add it, thanks.

> 
>> +qemu_base_args = ['-display', 'none',
>> +                  '-semihosting-config', 'enable=on',
>> +                  '-kernel']
>> +qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
>> +
>> +# Multi arch tests
>> +multi_src = []
>> +foreach t: tcg_tests['multiarch-softmmu']['tests']
>> +  foreach src, setup: t
>> +    new_cflags = cflags
>> +    if fs.stem(src) == 'memory'
>> +      new_cflags += '-DCHECK_UNALIGNED=0'
>> +    endif
>> +    if src not in multi_src
>> +      setup += {'cflags': [new_cflags]}
>> +      multi_src += src
>> +    endif
>> +    tests += {src: setup + {'qemu_args': qemu_def_args}}
>> +  endforeach
>> +endforeach
>> +
>> +tests += {
>> +  'test-armv6m-undef.S': {
>> +    'cflags': ['-mcpu=cortex-m0', '-mfloat-abi=soft', '-nostdlib',
>> +               '-T', files('test-armv6m-undef.ld')],
>> +    'qemu_args': ['-M', 'microbit', qemu_base_args],
>> +  },
>> +  'semiconsole.c': {
>> +    'cflags': cflags,
>> +    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
>> +                  '-semihosting-config', 'enable=on,chardev=stdio0',
>> +                  '-mon', 'chardev=stdio0,mode=readline',
>> +                  qemu_def_args],
>> +    'wrapper': [prog_run_with_input, 'X']
>> +  },
>> +  '../../multiarch/system/memory.c': {
>> +    'test_name': 'memory-record-replay',
>> +    'qemu_args': qemu_def_args,
>> +    'wrapper': [prog_record_replay],
>> +  },
>> +}
>> +
>> +if 'qemu-system-arm' in emulators
>> +  tcg_tests += {
>> +    'arm-softmmu': {
>> +      'cc': cc,
>> +      'cc_dockerfile': cc_dockerfile,
>> +      'cc_docker_host_arch': cc_docker_host_arch,
>> +      'folder': 'arm/system',
>> +      'gdb_arch': 'arm',
>> +      'qemu': emulators['qemu-system-arm'],
>> +      'tests': tests,
>> +    }
>> +  }
>> +endif
> 


