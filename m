Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3747C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 10:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgigD-0002PS-1N; Wed, 21 Aug 2024 06:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgig5-0002LY-OK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 06:34:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgig0-0006sy-FE
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 06:34:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42817bee9e8so51506985e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724236490; x=1724841290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q+pq73pqGOq8N20nLsNGCue8fwCoIcnvf3+ESLNEZp8=;
 b=eaQ3Qvrr3ky3lP6D1pSBNSY48r5MjWQVQPIzxJE0TY4iIVFiqzr/w+ManLdJW7lfDm
 OEb95XdTG+hGuhofmTpmU/mr3U88ae7xtEs4Vrje51ekdNc/kc9oxH75zsaTtz4/1i5A
 mx0GcZ6tDAF63s/DYRIjF6aTTSOXOn1RasvXzZrZFVt/1k+OAtJV+ta5J3HiQ1hqcX9o
 ub/WEx4gfgo6FDtStO1L0JoaM4cCslmqW6Rg9g2N8DpApqGoq2VYbVgPzP+SZ1bhZNBO
 Po5HgvAiKEiXgOOMu/BNu1l3rFT+0bakBUnXQpdhv0zGjWkSZeOU97Qlr4lMXjUEyYKi
 7ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724236490; x=1724841290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+pq73pqGOq8N20nLsNGCue8fwCoIcnvf3+ESLNEZp8=;
 b=PmJz4DCFwuiLFjXrIvkkG6mbaeKOC0bJvey5izOD62mYC2+82BrA826CNulJcGRhkb
 meNFG/y4jFk5/Ci14BW0MjBpOjvbWHBt4UODu2zYU5apMBN/h/w6V8nfL/IalNPbc9qt
 gdu/w1SJti5lBzFVVVDHevNriiUV2Az7UzX/7mp5cpInADq17dDB9X/BXvHPkldrKHGu
 WB2EfdyMTR9dmyZbriAW2VUkNcI205k0v9WuM6XxYdb8N/cbTqP6Z54ILGuc0XycDA4Y
 S37ry1QpCdrVy62xhy3pc+6YzqlaUES495BtFZPJQ7eAcgSAQ5WvMmfxEWZcDW0ToLIH
 1obg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB32y71wZvuRr6uIa+2pm3rVKfjEd/f4La+roHtXAGHwonlh5JRhqMk+O2ASsJYGRpnwu0cWqv2Snq@nongnu.org
X-Gm-Message-State: AOJu0YzLy+szeuK7PFTMsPzwmTSWoCSdFTnA6DgOpuAliqkNr4L/1R1f
 ydyvTp076K36x2F/WlPozMA/Ph//kHdh0DQtwKQtq7GvY+nCGgLQ2CY96O74wzk=
X-Google-Smtp-Source: AGHT+IFDOmoKbiZyCppykF9q5huMKZ0kRHCv1mA3RNcEES38+3DNILzLjfeFMPXoa+KL8wyIfH/YeQ==
X-Received: by 2002:a05:6000:a84:b0:371:8c7c:860d with SMTP id
 ffacd0b85a97d-372fd5c9728mr1167947f8f.18.1724236489274; 
 Wed, 21 Aug 2024 03:34:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a397sm15325514f8f.24.2024.08.21.03.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 03:34:48 -0700 (PDT)
Message-ID: <2b371db2-88c1-4c1f-8f1a-56c0cb6f8dde@linaro.org>
Date: Wed, 21 Aug 2024 12:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/35] Bump avocado to 103.0
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-5-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240821082748.65853-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 21/8/24 10:27, Thomas Huth wrote:
> From: Cleber Rosa <crosa@redhat.com>
> 
> This bumps Avocado to latest the LTS release.
> 
> An LTS release is one that can receive bugfixes and guarantees
> stability for a much longer period and has incremental minor releases
> made.
> 
> Even though the 103.0 LTS release is pretty a rewrite of Avocado when
> compared to 88.1, the behavior of all existing tests under
> tests/avocado has been extensively tested no regression in behavior
> was found.
> 
> To keep behavior of jobs as close as possible with previous version,
> this version bump keeps the execution serial (maximum of one task at a
> time being run).
> 
> Reference: https://avocado-framework.readthedocs.io/en/103.0/releases/lts/103_0.html
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Message-ID: <20240806173119.582857-2-crosa@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pythondeps.toml        | 2 +-
>   tests/Makefile.include | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

I suppose we now need an ultra wide monitor and set the terminal
COLUMNS to a value >= 512 to not make sense of the spaghetti console
now (my laptop terminal is 48x150 full screen, I might need new
eyes). (Compare with commit 44055caaa5 description). See for example
some lines are 267 columns wide:

$ make check-avocado AVOCADO_TAGS='machine:ppce500 machine:mpc8544ds' 
AVOCADO_SHOW='app,console'
   AVOCADO tests/avocado
Fetching asset from 
tests/avocado/replay_kernel.py:ReplayKernelNormal.test_ppc64_e500
JOB ID     : 793c892e4e11736f8ed5a7f8450bdba1c0b6187f
JOB LOG    : 
/Users/philmd/source/qemu/build.mac/full_clang/tests/results/job-2024-08-21T12.24-793c892/job.log
  (1/3) 
tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
STARTED
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,186 console __init__         L0151 DEBUG| MMU: 
Supported page sizes
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,186 console __init__         L0151 DEBUG| 4 KB as direct
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,186 console __init__         L0151 DEBUG| 4096 KB as 
direct
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,186 console __init__         L0151 DEBUG| 16384 KB 
as direct
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,187 console __init__         L0151 DEBUG| 65536 KB 
as direct
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,187 console __init__         L0151 DEBUG| 262144 KB 
as direct
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,187 console __init__         L0151 DEBUG| 1048576 KB 
as direct
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,187 console __init__         L0151 DEBUG| MMU: 
Book3E HW tablewalk not supported
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,187 console __init__         L0151 DEBUG| Linux 
version 4.16.13 (thuth@thuth.remote.csb) (gcc version 6.4.0 (Buildroot 
2018.05.2)) #6 SMP Sat Dec 15 14:53:04 CET 2018
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,188 console __init__         L0151 DEBUG| Using QEMU 
e500 machine description
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,188 console __init__         L0151 DEBUG| 
bootconsole [udbg0] enabled
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,188 console __init__         L0151 DEBUG| CPU maps 
initialized for 1 thread per core
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,188 console __init__         L0151 DEBUG| 
-----------------------------------------------------
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,188 console __init__         L0151 DEBUG| 
phys_mem_size     = 0x8000000
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,189 console __init__         L0151 DEBUG| 
dcache_bsize      = 0x40
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,189 console __init__         L0151 DEBUG| 
icache_bsize      = 0x40
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,189 console __init__         L0151 DEBUG| 
cpu_features      = 0x00180400181802c0
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,189 console __init__         L0151 DEBUG| possible 
      = 0x00180480581802c8
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,189 console __init__         L0151 DEBUG| always 
      = 0x00180400581802c0
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,190 console __init__         L0151 DEBUG| 
cpu_user_features = 0xcc008000 0x08000000
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,190 console __init__         L0151 DEBUG| 
mmu_features      = 0x000a0010
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,190 console __init__         L0151 DEBUG| 
firmware_features = 0x0000000000000000
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,190 console __init__         L0151 DEBUG| 
-----------------------------------------------------
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,190 console __init__         L0151 DEBUG| 
qemu_e500_setup_arch()
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,191 console __init__         L0151 DEBUG| Zone ranges:
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,191 console __init__         L0151 DEBUG| DMA 
[mem 0x0000000000000000-0x0000000007ffffff]
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,191 console __init__         L0151 DEBUG| DMA32    empty
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,191 console __init__         L0151 DEBUG| Normal   empty
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,191 console __init__         L0151 DEBUG| Movable 
zone start for each node
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,192 console __init__         L0151 DEBUG| Early 
memory node ranges
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,192 console __init__         L0151 DEBUG| node   0: 
[mem 0x0000000000000000-0x0000000007ffffff]
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,192 console __init__         L0151 DEBUG| Initmem 
setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,192 console __init__         L0151 DEBUG| MMU: 
Allocated 2112 bytes of context maps for 255 contexts
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,193 console __init__         L0151 DEBUG| percpu: 
Embedded 22 pages/cpu @        (ptrval) s51672 r0 d38440 u1048576
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,195 console __init__         L0151 DEBUG| Built 1 
zonelists, mobility grouping on.  Total pages: 32320
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,195 console __init__         L0151 DEBUG| Kernel 
command line:
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,196 console __init__         L0151 DEBUG| Dentry 
cache hash table entries: 16384 (order: 5, 131072 bytes)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,196 console __init__         L0151 DEBUG| 
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,220 console __init__         L0151 DEBUG| Memory: 
41876K/131072K available (10088K kernel code, 1988K rwdata, 3292K 
rodata, 4312K init, 320K bss, 89196K reserved, 0K cma-reserved)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,223 console __init__         L0151 DEBUG| SLUB: 
HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,229 console __init__         L0151 DEBUG| 
Hierarchical RCU implementation.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,229 console __init__         L0151 DEBUG| RCU event 
tracing is enabled.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,229 console __init__         L0151 DEBUG| RCU 
restricting CPUs from NR_CPUS=24 to nr_cpu_ids=1.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,229 console __init__         L0151 DEBUG| RCU: 
Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,231 console __init__         L0151 DEBUG| NR_IRQS: 
512, nr_irqs: 512, preallocated irqs: 16
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,233 console __init__         L0151 DEBUG| mpic: 
Setting up MPIC " OpenPIC  " version 1.2 at fe0040000, max 1 CPUs
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,233 console __init__         L0151 DEBUG| mpic: ISU 
size: 256, shift: 8, mask: ff
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,233 console __init__         L0151 DEBUG| mpic: 
Initializing for 256 sources
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,236 console __init__         L0151 DEBUG| 
clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 
0x5c4093a7d1, max_idle_ns: 440795210635 ns
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,237 console __init__         L0151 DEBUG| 
clocksource: timebase mult[2800000] shift[24] registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,240 console __init__         L0151 DEBUG| Console: 
colour dummy device 80x25
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,241 console __init__         L0151 DEBUG| pid_max: 
default: 32768 minimum: 301
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,242 console __init__         L0151 DEBUG| 
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,242 console __init__         L0151 DEBUG| 
Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,262 console __init__         L0151 DEBUG| e500 
family performance monitor hardware support registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,263 console __init__         L0151 DEBUG| 
Hierarchical SRCU implementation.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,265 console __init__         L0151 DEBUG| smp: 
Bringing up secondary CPUs ...
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,266 console __init__         L0151 DEBUG| smp: 
Brought up 1 node, 1 CPU
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,266 console __init__         L0151 DEBUG| Using 
standard scheduler topology
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,272 console __init__         L0151 DEBUG| devtmpfs: 
initialized
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,275 console __init__         L0151 DEBUG| random: 
get_random_u32 called from .bucket_table_alloc+0x9c/0x234 with crng_init=0
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,277 console __init__         L0151 DEBUG| 
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 7645041785100000 ns
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,277 console __init__         L0151 DEBUG| futex hash 
table entries: 256 (order: 2, 16384 bytes)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,282 console __init__         L0151 DEBUG| NET: 
Registered protocol family 16
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,284 console __init__         L0151 DEBUG| audit: 
initializing netlink subsys (disabled)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,297 console __init__         L0151 DEBUG| Found FSL 
PCI host bridge at 0x0000000fe0008000. Firmware bus number: 0->255
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,298 console __init__         L0151 DEBUG| PCI host 
bridge /pci@fe0008000 (primary) ranges:
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,298 console __init__         L0151 DEBUG| MEM 
0x0000000c00000000..0x0000000c1fffffff -> 0x00000000e0000000
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,298 console __init__         L0151 DEBUG| IO 
0x0000000fe1000000..0x0000000fe100ffff -> 0x0000000000000000
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,299 console __init__         L0151 DEBUG| 
/pci@fe0008000: PCICSRBAR @ 0xdff00000
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,299 console __init__         L0151 DEBUG| 
setup_pci_atmu: end of DRAM 8000000
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,302 console __init__         L0151 DEBUG| Machine: 
QEMU ppce500
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,302 console __init__         L0151 DEBUG| SoC 
family: QorIQ
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,302 console __init__         L0151 DEBUG| SoC ID: 
svr:0x00000000, Revision: 0.0
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,306 console __init__         L0151 DEBUG| audit: 
type=2000 audit(0.040:1): state=initialized audit_enabled=0 res=1
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,309 console __init__         L0151 DEBUG| fsl-pamu: 
fsl_pamu_init: could not find a PAMU node
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,318 console __init__         L0151 DEBUG| PCI: 
Probing PCI hardware
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,319 console __init__         L0151 DEBUG| fsl-pci 
fe0008000.pci: PCI host bridge to bus 8000:00
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,320 console __init__         L0151 DEBUG| pci_bus 
8000:00: root bus resource [io  0x8000080000010000-0x800008000001ffff] 
(bus address [0x0000-0xffff])
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,320 console __init__         L0151 DEBUG| pci_bus 
8000:00: root bus resource [mem 0xc00000000-0xc1fffffff] (bus address 
[0xe0000000-0xffffffff])
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,320 console __init__         L0151 DEBUG| pci_bus 
8000:00: root bus resource [bus 00-ff]
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,325 console __init__         L0151 DEBUG| pci 
8000:00:01.0: BAR 6: assigned [mem 0xc00000000-0xc0003ffff pref]
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,326 console __init__         L0151 DEBUG| pci 
8000:00:01.0: BAR 4: assigned [mem 0xc00040000-0xc00043fff 64bit pref]
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,326 console __init__         L0151 DEBUG| pci 
8000:00:01.0: BAR 1: assigned [mem 0xc00044000-0xc00044fff]
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,327 console __init__         L0151 DEBUG| pci 
8000:00:01.0: BAR 0: assigned [io  0x8000080000010000-0x800008000001001f]
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,349 console __init__         L0151 DEBUG| HugeTLB 
registered 4.00 MiB page size, pre-allocated 0 pages
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,349 console __init__         L0151 DEBUG| HugeTLB 
registered 16.0 MiB page size, pre-allocated 0 pages
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,349 console __init__         L0151 DEBUG| HugeTLB 
registered 64.0 MiB page size, pre-allocated 0 pages
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,350 console __init__         L0151 DEBUG| HugeTLB 
registered 256 MiB page size, pre-allocated 0 pages
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,350 console __init__         L0151 DEBUG| HugeTLB 
registered 1.00 GiB page size, pre-allocated 0 pages
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,352 console __init__         L0151 DEBUG| Freescale 
Elo series DMA driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,352 console __init__         L0151 DEBUG| vgaarb: loaded
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,353 console __init__         L0151 DEBUG| SCSI 
subsystem initialized
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,355 console __init__         L0151 DEBUG| usbcore: 
registered new interface driver usbfs
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,356 console __init__         L0151 DEBUG| usbcore: 
registered new interface driver hub
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,356 console __init__         L0151 DEBUG| usbcore: 
registered new device driver usb
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,356 console __init__         L0151 DEBUG| pps_core: 
LinuxPPS API ver. 1 registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,356 console __init__         L0151 DEBUG| pps_core: 
Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti 
<giometti@linux.it>
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,356 console __init__         L0151 DEBUG| PTP clock 
support registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,357 console __init__         L0151 DEBUG| EDAC MC: 
Ver: 3.0.0
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,364 console __init__         L0151 DEBUG| 
clocksource: Switched to clocksource timebase
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,419 console __init__         L0151 DEBUG| NET: 
Registered protocol family 2
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,423 console __init__         L0151 DEBUG| 
tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,423 console __init__         L0151 DEBUG| TCP 
established hash table entries: 1024 (order: 1, 8192 bytes)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,423 console __init__         L0151 DEBUG| TCP bind 
hash table entries: 1024 (order: 2, 16384 bytes)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,424 console __init__         L0151 DEBUG| TCP: Hash 
tables configured (established 1024 bind 1024)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,424 console __init__         L0151 DEBUG| UDP hash 
table entries: 256 (order: 1, 8192 bytes)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,425 console __init__         L0151 DEBUG| UDP-Lite 
hash table entries: 256 (order: 1, 8192 bytes)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,426 console __init__         L0151 DEBUG| NET: 
Registered protocol family 1
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,428 console __init__         L0151 DEBUG| RPC: 
Registered named UNIX socket transport module.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,428 console __init__         L0151 DEBUG| RPC: 
Registered udp transport module.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,429 console __init__         L0151 DEBUG| RPC: 
Registered tcp transport module.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,429 console __init__         L0151 DEBUG| RPC: 
Registered tcp NFSv4.1 backchannel transport module.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,582 console __init__         L0151 DEBUG| Initialise 
system trusted keyrings
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,584 console __init__         L0151 DEBUG| 
workingset: timestamp_bits=62 max_order=15 bucket_order=0
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,598 console __init__         L0151 DEBUG| NFS: 
Registering the id_resolver key type
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,598 console __init__         L0151 DEBUG| Key type 
id_resolver registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,598 console __init__         L0151 DEBUG| Key type 
id_legacy registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,599 console __init__         L0151 DEBUG| Installing 
knfsd (copyright (C) 1996 okir@monad.swb.de).
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,599 console __init__         L0151 DEBUG| ntfs: 
driver 2.1.32 [Flags: R/O].
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,599 console __init__         L0151 DEBUG| jffs2: 
version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,606 console __init__         L0151 DEBUG| 
jitterentropy: Initialization failed with host not compliant with 
requirements: 2
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,606 console __init__         L0151 DEBUG| Key type 
asymmetric registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,606 console __init__         L0151 DEBUG| Asymmetric 
key parser 'x509' registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,606 console __init__         L0151 DEBUG| io 
scheduler noop registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,607 console __init__         L0151 DEBUG| io 
scheduler deadline registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,607 console __init__         L0151 DEBUG| io 
scheduler cfq registered (default)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,607 console __init__         L0151 DEBUG| io 
scheduler mq-deadline registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,607 console __init__         L0151 DEBUG| io 
scheduler kyber registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,609 console __init__         L0151 DEBUG| virtio-pci 
8000:00:01.0: enabling device (0000 -> 0003)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,612 console __init__         L0151 DEBUG| Serial: 
8250/16550 driver, 6 ports, IRQ sharing enabled
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,617 console __init__         L0151 DEBUG| console 
[ttyS0] disabled
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,639 console __init__         L0151 DEBUG| 
serial8250.0: ttyS0 at MMIO 0xfe0004500 (irq = 42, base_baud = 25000000) 
is a 16550A
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,640 console __init__         L0151 DEBUG| console 
[ttyS0] enabled
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,641 console __init__         L0151 DEBUG| console 
[ttyS0] enabled
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,641 console __init__         L0151 DEBUG| 
bootconsole [udbg0] disabled
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,641 console __init__         L0151 DEBUG| 
bootconsole [udbg0] disabled
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,642 console __init__         L0151 DEBUG| ePAPR 
hypervisor byte channel driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,660 console __init__         L0151 DEBUG| brd: 
module loaded
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,669 console __init__         L0151 DEBUG| loop: 
module loaded
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,682 console __init__         L0151 DEBUG| st: 
Version 20160209, fixed bufsize 32768, s/g segs 256
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,689 console __init__         L0151 DEBUG| libphy: 
Fixed MDIO Bus: probed
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,695 console __init__         L0151 DEBUG| e1000: 
Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,695 console __init__         L0151 DEBUG| e1000: 
Copyright (c) 1999-2006 Intel Corporation.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,696 console __init__         L0151 DEBUG| e1000e: 
Intel(R) PRO/1000 Network Driver - 3.2.6-k
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,696 console __init__         L0151 DEBUG| e1000e: 
Copyright(c) 1999 - 2015 Intel Corporation.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,696 console __init__         L0151 DEBUG| igb: 
Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,696 console __init__         L0151 DEBUG| igb: 
Copyright (c) 2007-2014 Intel Corporation.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,702 console __init__         L0151 DEBUG| ehci_hcd: 
USB 2.0 'Enhanced' Host Controller (EHCI) Driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,702 console __init__         L0151 DEBUG| ehci-pci: 
EHCI PCI platform driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,702 console __init__         L0151 DEBUG| ohci_hcd: 
USB 1.1 'Open' Host Controller (OHCI) Driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,702 console __init__         L0151 DEBUG| ohci-pci: 
OHCI PCI platform driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,703 console __init__         L0151 DEBUG| ehci-fsl: 
Freescale EHCI Host controller driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,703 console __init__         L0151 DEBUG| usbcore: 
registered new interface driver usb-storage
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,704 console __init__         L0151 DEBUG| mousedev: 
PS/2 mouse device common for all mice
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,705 console __init__         L0151 DEBUG| i2c /dev 
entries driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,706 console __init__         L0151 DEBUG| mpc-i2c 
fe0003000.i2c: timeout 1000000 us
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,714 console __init__         L0151 DEBUG| rtc-ds1307 
0-0068: registered as rtc0
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,716 console __init__         L0151 DEBUG| 
Freescale(R) MPC85xx EDAC driver, (C) 2006 Montavista Software
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,717 console __init__         L0151 DEBUG| EDAC PCI0: 
Giving out device to module MPC85xx_edac controller mpc85xx_pci_err: DEV 
mpc85xx-pci-edac.0.auto (INTERRUPT)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,717 console __init__         L0151 DEBUG| 
MPC85xx_edac acquired irq 24 for PCI Err
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,717 console __init__         L0151 DEBUG| 
MPC85xx_edac PCI err registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,718 console __init__         L0151 DEBUG| sdhci: 
Secure Digital Host Controller Interface driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,718 console __init__         L0151 DEBUG| sdhci: 
Copyright(c) Pierre Ossman
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,718 console __init__         L0151 DEBUG| 
sdhci-pltfm: SDHCI platform and OF driver helper
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,721 console __init__         L0151 DEBUG| mmc0 
bounce up to 128 segments into one, max segment size 65536 bytes
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,744 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,776 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,792 console __init__         L0151 DEBUG| mmc0: 
SDHCI controller on fe002e000.sdhc [fe002e000.sdhc] using DMA
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,794 console __init__         L0151 DEBUG| usbcore: 
registered new interface driver usbkbd
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,794 console __init__         L0151 DEBUG| usbcore: 
registered new interface driver usbmouse
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,794 console __init__         L0151 DEBUG| Freescale 
hypervisor management driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,794 console __init__         L0151 DEBUG| fsl-hv: no 
hypervisor found
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,795 console __init__         L0151 DEBUG| ipip: IPv4 
and MPLS over IPv4 tunneling driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,796 console __init__         L0151 DEBUG| 
Initializing XFRM netlink socket
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,797 console __init__         L0151 DEBUG| NET: 
Registered protocol family 10
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,806 console __init__         L0151 DEBUG| Segment 
Routing with IPv6
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,807 console __init__         L0151 DEBUG| sit: IPv6, 
IPv4 and MPLS over IPv4 tunneling driver
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,808 console __init__         L0151 DEBUG| NET: 
Registered protocol family 17
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,808 console __init__         L0151 DEBUG| NET: 
Registered protocol family 15
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,808 console __init__         L0151 DEBUG| Key type 
dns_resolver registered
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,809 console __init__         L0151 DEBUG| drmem: No 
dynamic reconfiguration memory found
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,810 console __init__         L0151 DEBUG| Loading 
compiled-in X.509 certificates
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,831 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,856 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,857 console __init__         L0151 DEBUG| rtc-ds1307 
0-0068: setting system clock to 2024-08-21 10:24:15 UTC (1724235855)
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,898 console __init__         L0151 DEBUG| Freeing 
unused kernel memory: 4312K
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,899 console __init__         L0151 DEBUG| This 
architecture does not have kernel memory protection.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,920 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:15,959 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:16,007 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:16,055 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:16,111 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:16,155 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:16,196 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:16,245 console __init__         L0151 DEBUG| mmc0: 
Internal clock never stabilised.
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:16,568 console __init__         L0151 DEBUG| Starting 
logging: OK
console: 
1-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
2024-08-21 12:24:16,761 console __init__         L0151 DEBUG| QEMU 
advent calendar 2018 - log in as 'root' and run 'asciijump' to play the game
  (1/3) 
tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc64_e500: 
PASS (1.81 s)

Failing downloads are over verbose, a pain when you get multiple of
them. A single failure produces:

Fetching asset from 
tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_initrd
Process Process-9:
Traceback (most recent call last):
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/urllib/request.py", 
line 1344, in do_open
     h.request(req.get_method(), req.selector, req.data, headers,
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/http/client.py", 
line 1336, in request
     self._send_request(method, url, body, headers, encode_chunked)
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/http/client.py", 
line 1382, in _send_request
     self.endheaders(body, encode_chunked=encode_chunked)
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/http/client.py", 
line 1331, in endheaders
     self._send_output(message_body, encode_chunked=encode_chunked)
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/http/client.py", 
line 1091, in _send_output
     self.send(msg)
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/http/client.py", 
line 1035, in send
     self.connect()
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/http/client.py", 
line 1470, in connect
     super().connect()
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/http/client.py", 
line 1001, in connect
     self.sock = self._create_connection(
                 ^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/socket.py", 
line 853, in create_connection
     raise exceptions[0]
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/socket.py", 
line 838, in create_connection
     sock.connect(sa)
TimeoutError: timed out

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/multiprocessing/process.py", 
line 314, in _bootstrap
     self.run()
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/multiprocessing/process.py", 
line 108, in run
     self._target(*self._args, **self._kwargs)
   File 
"/Users/philmd/source/qemu/build.mac/full_clang/pyvenv/lib/python3.12/site-packages/avocado/utils/download.py", 
line 69, in _url_download
     src_file = url_open(url, data=data)
                ^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"/Users/philmd/source/qemu/build.mac/full_clang/pyvenv/lib/python3.12/site-packages/avocado/utils/download.py", 
line 48, in url_open
     result = urlopen(url, data=data, timeout=timeout)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/urllib/request.py", 
line 215, in urlopen
     return opener.open(url, data, timeout)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/urllib/request.py", 
line 515, in open
     response = self._open(req, data)
                ^^^^^^^^^^^^^^^^^^^^^
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/urllib/request.py", 
line 532, in _open
     result = self._call_chain(self.handle_open, protocol, protocol +
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/urllib/request.py", 
line 492, in _call_chain
     result = func(*args)
              ^^^^^^^^^^^
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/urllib/request.py", 
line 1392, in https_open
     return self.do_open(http.client.HTTPSConnection, req,
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"/opt/homebrew/Cellar/python@3.12/3.12.4/Frameworks/Python.framework/Versions/3.12/lib/python3.12/urllib/request.py", 
line 1347, in do_open
     raise URLError(err)
urllib.error.URLError: <urlopen error timed out>
Fetching asset from 
tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_initrd

Anyway I don't mind much and don't ask/expect anyone to fix that.

On macOS:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


