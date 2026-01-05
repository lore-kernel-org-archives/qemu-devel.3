Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10ABC2A099
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 11:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcj5K-0004Rq-61; Mon, 05 Jan 2026 06:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vcj5E-0004Q9-G6
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:49:12 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vcj5A-0005b9-83
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:49:11 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c1e7cdf0905so10459825a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 03:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1767613744; x=1768218544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iER4t5/MGcuA0jUOCw7RZKhxoEYE4NOXiwEELaUDpvc=;
 b=Btmhim/deW97JQBcUygYqphIitOKfe03Adc1KxqNFBn8YLAIrrLy+fJQ9VXGRJU5zN
 fIEO3M9vQT5OCGwi0PbpCDYvqM290Og02jlVZnxbNiASWO+UewAMz1TI36ff/0sg5PqH
 fwItALu1caw58xzLqKI0BV5NFtwDNNLXyh5uCDV+5QROvVA9vltedjeJvv50R9/QuE7a
 z/Gzq2AXHAADk1tumKfqW9kKnEoWNvqnitshsW6G6wx8mngX+wpl6CzxBrwvc+ujCwmL
 KJobukyEVS8xihjTcEbeM6FT0X1B64TjNMyLVNxatmRT0TsFogPMrZlzyP5cw+Z53BzZ
 JgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767613744; x=1768218544;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iER4t5/MGcuA0jUOCw7RZKhxoEYE4NOXiwEELaUDpvc=;
 b=Cip8bGizP8lJaWHLi2/0R4DbOgwHh0lbUUo6GrXQpw82Lvxt3BhVd/o1+QKjIsnE8a
 St3zYCxwG2yVZYlrXDOHxC66DYm043aeW46gJ7a+wZWKly9nzdjtRikhE03WauyG9yjy
 t2xy2+qZRVRdYa1+6D8I2f3p1+S5c99c2RtVRB0D86mtvjvkdAp43jUtJfTL+Q0NHltg
 Wy3BwmEa9BiPDxaq5oVpuLNsWAGC8K4p+12Pb+G+TfaDeHNFPjdpcAoA/5exuIo/lXhm
 Ua7GcYCgtwZeepYkP3jQmdCaEHFq857PnMpOaK866ToU1o3YvXYvW7fp5A0JZpNkGpaS
 5ySA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUCA5EdDvGrNhzdvLze+0wTin3yUjcgiOEum6GzzTU5YJgW4xP/RtHEaQLkopqjVS6r+Fg05ZYeAFF@nongnu.org
X-Gm-Message-State: AOJu0YxuCXYUCm51aUHppBzXwnoR3w61KnQA3mzgGBqMOCwy/6dI3Wv9
 lvI+tqYAcq9XH+nSsh9YUeTNRP1SaT4/FaD6j9wsMieZF5EEYyOSgvjTKxuRi7MpOjk=
X-Gm-Gg: AY/fxX5wALGJvMuZ2EJLRNhKQcWkq6d/g1B31mARe4O+KEt2q+GofM6ru+p0eVRHJ50
 ffx5rIBDcFbHWUrsFjUy0Ap4QOEpigmWMJDxZ/Q8kHOnR8ykXQO2MqGWvxc/adbQ2ljGWwLCDWh
 TFZEyyy+mchpV81+v6Ej1tbyd0ISKyXwpV+EDv+BbE/NtbjAdOKjKGf/GiBMHPFnZ9SQUk6Au+Z
 qGv+RFBB/5whxrWFB9pBDw58KZdVRFaeNPNzjZvLPnwc4/tF3piNxxayJjn7XpyLC515plBLfvV
 f1PuWncGmItTARhy17EuoNt2npNdW4E8zT+XoBqXiNlFduH2rd2f/+xRfshX+q0unKSuFhpbsoX
 P77dqmMmdw8wACepXO92ujHC1hbT6fv8fbiavGdbhRDB74bkF9m1sVvSGyrYP2Fwt6DbYjC8XHP
 CyVEYRJdpmwPWsltQ/gCX3vpFpjwB77lkZ95YQuvy1ELHuYZmfj7up7+dlW4i+3PRbVBYQ3847
X-Google-Smtp-Source: AGHT+IGEQnWrBGyhe9hzeHyHmMy/vzRshi62IzVb/je091Yz8e9j/tDEklgyHyrTTjfCI518rpQLJA==
X-Received: by 2002:a05:7300:7255:b0:2ae:6109:9d77 with SMTP id
 5a478bee46e88-2b1456be987mr4768226eec.40.1767613744087; 
 Mon, 05 Jan 2026 03:49:04 -0800 (PST)
Received: from [192.168.68.110] (200-162-225-127.static-corp.ajato.com.br.
 [200.162.225.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b140c42dfdsm10754008eec.33.2026.01.05.03.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 03:49:03 -0800 (PST)
Message-ID: <bc812773-1a09-4541-ae6d-7a6d7327b6a5@ventanamicro.com>
Date: Mon, 5 Jan 2026 08:48:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/riscv: Add arch= CPU property for ISA
 configuration
To: Kito Cheng <kito.cheng@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, kito.cheng@gmail.com
References: <20260105105940.3567112-1-kito.cheng@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260105105940.3567112-1-kito.cheng@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
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



On 1/5/26 7:59 AM, Kito Cheng wrote:
> Motivation
> ==========
> 
> Here is the motivation for this patch set. Please try to answer the
> following 3 questions without checking QEMU source code:
> 
> 1. How do you run RISC-V QEMU with a specific extension configuration?
>     Please try to configure an rv64im user mode QEMU before you answer
>     this question.

I would use the 'rv64i' bare CPU that we introduced a few releases ago
and enable just 'm':

qemu-riscv64 -cpu rv64i,m=on


It gives you a bare bones CPU with only "RVI" enabled. We added this CPU
specifically to support the use case you mentioned: users that want to
have full control of what is enabled in the CPU.

> 2. How do you know which extensions are supported in RISC-V QEMU?

You mean all available extensions? We don't have an user friendly way of
knowing that. I usually grep the code.

> 3. How do you know which extensions are enabled in the current RISC-V QEMU?


We can fetch them using query-cpu-model-expansion from QMP. But that's
not exactly user friendly.

> 
> And here are my answers to those 3 questions:
> 
> 1. It's hard to configure RISC-V QEMU with a specific extension. The
>     correct way to configure rv64im is:
> 
>       qemu-riscv64 -cpu rv64,a=false,d=false,f=false,zfa=false,zawrs=false,\
>         c=false,zifencei=false,zicsr=false,zihintntl=false,zihintpause=false,\
>         zbb=false,zba=false,zbs=false,zbc=false,zicbom=false,zicbop=false,\
>         zicboz=false

As I said above:

qemu-riscv64 -cpu rv64i,m=on


> 
>     I've seen 4 different QEMU wrappers to handle arch string to QEMU CPU
>     option: 3 in-house scripts, 1 open source script in riscv-gnu-toolchain,
>     and I guess some vendors/developers may have their own scripts to do
>     that as well...

We can't control how riscv-gnu-toolchain and others implement their scripts and
wrappers. These are the kind of thing that people write once and never look it
back, and that's fine.

That said, we have 'rv64i' and other bare CPUs since QEMU 9.0, released in April
24. We don't need to do this kind of massive extension disablement to get a
clean CPU for almost 2 years.

I advise to not take QEMU wrappers, scripts and etc from other projects as a sort
of proof of what QEMU is currently capable. They're usually outdated.
  

> 
> 2. I don't know a better way other than reading the QEMU source code.
> 
> 3. I don't really know the answer...
> 
> So how do other tools/simulators address these problems? Toolchains like
> Clang and GCC use -march with an arch string to configure, and Spike uses
> --isa=<ISA-string> to configure.
> 
> Could we introduce a similar way to configure QEMU? Yes, I think we can.
> That's what this patch set does.
> 
>    -cpu rv64,arch=<ISA-string>

I don't mind the 'arch' property if users find it easier to enable extensions with
it rather than the boolean properties, but it should be used on top of bare CPUs
only. Otherwise the 'arch' property would include the already enabled extensions
from 'rv64' and others.

And we would need to be okay with the fact that this is redundant to what we already
can do with bare CPUs + manual extension enablement.

> 
> to configure QEMU. And also introduce arch=help and arch=dump to show
> which extensions are supported, and which extensions are enabled/disabled.

arch=help and arch=dump is indeed a nice addition.


> 
> Also supported:
> 
>    arch=<profile>["_"optional-ext]*
> 
> to specify configuration with RISC-V profiles like the toolchain convention[1].


We have profile CPUs for this use case:

$ ./qemu-riscv64 -cpu help
Available CPUs:
   max
   rv64
   rv64e
   rv64i
   rva22s64
   rva22u64
   rva23s64
   rva23u64
(...)


So 'qemu-riscv64 -cpu rva23u64'  creates an user mode QEMU with RVA23.


> 
> [1] https://github.com/riscv-non-isa/riscv-toolchain-conventions/blob/main/src/toolchain-conventions.adoc#specifying-the-target-profile-with--march
> 
> Overview
> ========
> 
> This patch series introduces the arch= CPU property for RISC-V, providing
> a convenient interface to configure ISA extensions similar to GCC/Clang's
> -march option.
> 
> The arch= property supports the following modes:
> 
> 1. arch=dump
>     Print the current ISA configuration and exit. Shows the full ISA string
>     and the status of all supported extensions.
> 
>     Example:
>       $ qemu-riscv64 -cpu rv64,v=true,arch=dump /bin/true
> 
> 2. arch=help
>     Print a list of all supported ISA extensions and exit. Lists standard
>     single-letter extensions, multi-letter extensions, vendor extensions,
>     profiles, and vector length extensions.
> 
>     Example:
>       $ qemu-riscv64 -cpu rv64,arch=help /bin/true
> 
> 3. arch=<ISA-STRING>
>     Configure extensions using a standard RISC-V ISA string. The format is
>     rv{32|64}[single-letter-exts][_multi-letter-ext]*.
> 
>     Key features:
>     - First extension must be i, e, or g (base ISA requirement)
>     - Single-letter extensions can be concatenated (rv64imafdc)
>     - Single-letter extensions can use underscore separators (rv64i_m_a_f_d_c)
>     - Multi-letter extensions are separated by underscores (_zba_zbb)
>     - Single-letter can transition directly to multi-letter (rv64imazba)
>     - Extensions i, e, g can only appear as the first extension
>     - When arch= is specified, all extensions are first reset to disabled
>     - G expands to imafd_zicsr_zifencei
>     - B expands to zba_zbb_zbs
> 
>     Examples:
>       $ qemu-riscv64 -cpu rv64,arch=rv64gc_zba_zbb /bin/true
>       $ qemu-riscv64 -cpu rv64,arch=rv64imafdc_zba_zbb_zbc /bin/true
> 
> 4. arch=<PROFILE>[_extension]*
>     Configure the CPU using a standard RISC-V profile, optionally with
>     additional extensions. Available profiles (64-bit only):
>     - rva22u64, rva22s64, rva23u64, rva23s64
> 
>     Examples:
>       $ qemu-riscv64 -cpu rv64,arch=rva23u64 /bin/true
>       $ qemu-riscv64 -cpu rv64,arch=rva23u64_zbkb_zkne /bin/true
> 
> 5. zvl*b extensions
>     Specify vector length (VLEN) in bits using zvl<N>b where N is a power
>     of 2 (32-65536). Requires v or zve* extension.
> 
>     Examples:
>       $ qemu-riscv64 -cpu rv64,arch=rv64gcv_zvl256b /bin/true
>       $ qemu-riscv64 -cpu rv64,arch=rv64i_zve64f_zvl128b /bin/true

We already have vlen and elen properties. Not sure if we need another way to set
the same stuff.

I'll give a closer look later at the first 2 patches (arch=dump and arch=help)
since these are nice additions for the user experience.

I would like to hear other opinions about arch=<ISA_STRING> because it would be
just another way (probably an easier way) of doing what we already support with
bare CPUs + manual extension enablement.

I don't see the need to support arch=PROFILE given that we have profile CPUs
that does exactly that. Same thing for the 'vlen' setting.





> 
> Individual extension properties (e.g., zba=true) can be combined with
> arch= and will override the ISA string settings when specified after arch=.
> 
> Kito Cheng (5):
>    target/riscv: Add arch=dump CPU property for ISA introspection
>    target/riscv: Add arch=help to list supported ISA extensions
>    target/riscv: Add arch=ISA-STRING to configure extensions via ISA
>      string
>    target/riscv: Add arch=PROFILE to configure CPU using RISC-V profiles
>    target/riscv: Add zvl*b extension support in arch= property
> 
>   docs/system/target-riscv.rst              | 144 ++++++++
>   target/riscv/cpu.c                        | 226 ++++++++++++
>   target/riscv/cpu.h                        |   1 +
>   target/riscv/cpu_cfg_fields.h.inc         |   3 +
>   target/riscv/tcg/tcg-cpu.c                | 424 ++++++++++++++++++++++
>   tests/functional/riscv32/meson.build      |   4 +
>   tests/functional/riscv32/test_cpu_arch.py |  94 +++++
>   tests/functional/riscv64/meson.build      |   4 +
>   tests/functional/riscv64/test_cpu_arch.py | 411 +++++++++++++++++++++
>   9 files changed, 1311 insertions(+)
>   create mode 100644 tests/functional/riscv32/test_cpu_arch.py
>   create mode 100644 tests/functional/riscv64/test_cpu_arch.py
> 
> --
> 2.52.0
> 


