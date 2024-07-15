Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7DCC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 01:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTAaf-00066i-UJ; Sun, 14 Jul 2024 21:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sTAae-00065h-3u; Sun, 14 Jul 2024 21:33:20 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sTAab-00057I-Vi; Sun, 14 Jul 2024 21:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1721007193; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=ObAsYTxWauE4NRBUtRwdGM7Yi+guC0pd/RDbRLa7Y4k=;
 b=Ud/xINOtMIFE1tIKlsnnQbgbfj/DO36GFZ9YBDdtP1bO2V3nBDCuX8zOzszWbkuo58s4Ad5opBeycTvjCxryJXhKW7HaUDw20KiF4Cdxv85OtdPmOu+zfy0IsB44XehIzxQMk348kSHNzZeHGeP3+acZX+vNDLudaB7xoNKJ0vo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032019045;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WAUQTA7_1721007191; 
Received: from 30.166.64.89(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WAUQTA7_1721007191) by smtp.aliyun-inc.com;
 Mon, 15 Jul 2024 09:33:11 +0800
Message-ID: <15738b4e-a014-40ba-9152-659afee5dc3f@linux.alibaba.com>
Date: Mon, 15 Jul 2024 09:31:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] target/riscv: Expose RV32 cpu to RV64 QEMU
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com, =?UTF-8?B?55Sy5LiA?=
 <lzw194868@alibaba-inc.com>
References: <20240710022430.1306-1-zhiwei_liu@linux.alibaba.com>
 <d46477b2-b0f0-4bf4-8c20-2ff2466d4d5f@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <d46477b2-b0f0-4bf4-8c20-2ff2466d4d5f@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/7/12 17:57, Daniel Henrique Barboza wrote:
>
>
> On 7/9/24 11:24 PM, LIU Zhiwei wrote:
>> From: 甲一 <lzw194868@alibaba-inc.com>
>>
>> This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
>> qemu-system-riscv64 can directly boot a RV32 Linux.
>>
>> This patch set has been tested with 6.9.0 Linux Image.
>> And add an avocado test in tests/avocado.
>
> Thanks for this work and sorry for the late review.
>
> One thing to look out as a follow-up is the 'max' CPU. It has the same 
> name
> in both 32 and 64 bits so it'll result in a conflict with the 'max' 
> CPU for
> rv64.
>
> One easy way out is to add a new 'max32' bit CPU for riscv32, which 
> would be an
> alias for the 'max' CPU, then adding 'max32' support in rv64.

I think it is good. One question is if we should also add any32 cpu for 
rv64, which has the similar conflict of 'max' CPU.

Thanks,
Zhiwei

>
>
> Thanks,
>
> Daniel
>
>
>>
>> # make check-avocado 
>> AVOCADO_TESTS=/home/jenkins/git/qemu/tests/avocado/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i
>>    VENVPIP install -e /home/jenkins/git/qemu/python/
>> /home/jenkins/git/qemu/build/pyvenv/bin/python3 -B 
>> /home/jenkins/git/qemu/python/scripts/mkvenv.py ensuregroup --online 
>> /home/jenkins/git/qemu/pythondeps.toml avocado
>> mkvenv: checking for avocado-framework(>=88.1, <93.0)
>> mkvenv: checking for pycdlib>=1.11.0
>> mkvenv: installing avocado-framework==88.1, pycdlib>=1.11.0
>>    AVOCADO tests/avocado
>> Fetching asset from 
>> /home/jenkins/git/qemu/tests/avocado/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i
>> Fetching asset from 
>> /home/jenkins/git/qemu/tests/avocado/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i
>> JOB ID     : 8c2e1ff918d3111d078a52eba9956893afaf9e1d
>> JOB LOG    : 
>> /home/jenkins/git/qemu/build/tests/results/job-2024-07-10T09.55-8c2e1ff/job.log
>>   (1/1) 
>> /home/jenkins/git/qemu/tests/avocado/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i: 
>> PASS (17.50 s)
>> RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 
>> 0 | CANCEL 0
>> JOB TIME   : 29.50 s
>>
>> v5:
>>    Rebase to master and add tags
>>
>> v4:
>>    Drop UL completely in PATCH v3 2/7, 4/7, 5/7.
>>    Avocado: Add "if=none" to "-drive" option in QEMU command line
>>
>> v3:
>>    Rebase to the master branch
>>
>> v2:
>>    Remove the line that was inadvertently left in PATCH v1 4/6.
>>    Add an avocado test.
>>
>> v1:
>> https://mail.gnu.org/archive/html/qemu-riscv/2024-06/msg00501.html
>>
>> TANG Tiancheng (7):
>>    target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
>>    target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
>>    target/riscv: Correct SXL return value for RV32 in RV64 QEMU
>>    target/riscv: Detect sxl to set bit width for RV32 in RV64
>>    target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
>>    target/riscv: Enable RV32 CPU support in RV64 QEMU
>>    tests/avocado: Add an avocado test for riscv64
>>
>>   configs/targets/riscv64-softmmu.mak |  2 +-
>>   hw/riscv/boot.c                     | 35 +++++++++++++++++---------
>>   hw/riscv/sifive_u.c                 |  3 ++-
>>   include/hw/riscv/boot.h             |  4 ++-
>>   include/hw/riscv/boot_opensbi.h     | 29 ++++++++++++++++++++++
>>   target/riscv/cpu.c                  | 17 ++++++++++---
>>   target/riscv/cpu.h                  |  5 +++-
>>   target/riscv/cpu_helper.c           | 25 +++++++++++++------
>>   target/riscv/pmp.c                  |  2 +-
>>   tests/avocado/boot_linux_console.py | 38 +++++++++++++++++++++++++++++
>>   10 files changed, 132 insertions(+), 28 deletions(-)
>>

