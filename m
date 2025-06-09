Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0030FC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 11:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOayc-0002u4-8t; Mon, 09 Jun 2025 07:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uOaya-0002tT-3u; Mon, 09 Jun 2025 07:47:40 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uOayV-0003tK-5U; Mon, 09 Jun 2025 07:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WQWw2lKQYSRsOOcfT7ZKX2n+8Gg0Mu7/0Gew0HXPBVU=; b=zPuD20rXZKIH6UBgWiKcWcryLJ
 v5XYkkPuqPs5vrc9147hti5JuHmAqbGxCK7HTB237w/gmlAcPnZ+UNYnIXbjalDce7KGhkHRJTkxk
 R4G1i5LcpqZMH/DpDdISs93U39aAECMT3U2AZxmUnzJFy7IPQT9ri+2xGQ2eTUOdX+GAsfU8mO6FK
 QeUFvX0N5RM53zFYLEUzZOohZLuRamibwEkkagDcqnYDmSBqKLTLeAiPA5VFoVoA3hINQl9dp7WIQ
 +/iB54H9zZ8Nhc5HWbr2LTu5YT4KLQoQ7GUyQsepdCkLKXYdyS47+/n8qGYpSehH7KmGpFNR+YQYs
 LNfg0Zqg==;
Received: from [63.135.74.212] (helo=[192.168.1.249])
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uOayL-00FMpK-Du; Mon, 09 Jun 2025 12:47:25 +0100
Message-ID: <a661eb0c-ba27-4348-93d2-dfb1a080c18e@codethink.co.uk>
Date: Mon, 9 Jun 2025 12:47:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: add cva6 core type
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250527112437.291445-1-ben.dooks@codethink.co.uk>
 <20250527112437.291445-3-ben.dooks@codethink.co.uk>
 <ef6c7b15-04a7-42cf-a89b-c2674388810f@ventanamicro.com>
 <06323162-66b9-4165-ab2e-86ec6272aca8@codethink.co.uk>
 <341224e9-d335-40ac-af98-6395b3aede84@ventanamicro.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <341224e9-d335-40ac-af98-6395b3aede84@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/06/2025 12:30, Daniel Henrique Barboza wrote:
> 
> 
> On 6/9/25 7:40 AM, Ben Dooks wrote:
>> On 07/06/2025 21:17, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 5/27/25 8:24 AM, Ben Dooks wrote:
>>>> Add TYPE_RISCV_CPU_CVA6 for the CVA6 core
>>>>
>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>> ---
>>>>   target/riscv/cpu-qom.h |  1 +
>>>>   target/riscv/cpu.c     | 11 +++++++++++
>>>>   2 files changed, 12 insertions(+)
>>>>
>>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>>> index 1ee05eb393..3daf75568c 100644
>>>> --- a/target/riscv/cpu-qom.h
>>>> +++ b/target/riscv/cpu-qom.h
>>>> @@ -34,6 +34,7 @@
>>>>   #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>>>>   #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>>>>   #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x- 
>>>> rv128")
>>>> +#define TYPE_RISCV_CPU_CVA6             RISCV_CPU_TYPE_NAME("cva6")
>>>>   #define TYPE_RISCV_CPU_RV32I            RISCV_CPU_TYPE_NAME("rv32i")
>>>>   #define TYPE_RISCV_CPU_RV32E            RISCV_CPU_TYPE_NAME("rv32e")
>>>>   #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index 629ac37501..fca45dc9d9 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -3009,6 +3009,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>>>           .misa_mxl_max = MXL_RV64,
>>>>       ),
>>>> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_CVA6, TYPE_RISCV_VENDOR_CPU,
>>>> +        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVS | 
>>>> RVU,
>>>> +        .misa_mxl_max = MXL_RV64,
>>>> +        .cfg.max_satp_mode = VM_1_10_SV39,
>>>> +        .priv_spec = PRIV_VERSION_1_12_0,
>>>> +        .cfg.pmp = true,
>>>> +        .cfg.mmu = true,
>>>> +        .cfg.ext_zifencei = true,
>>>> +        .cfg.ext_zicsr = true,
>>>> +    ),
>>>> +
>>>
>>> The CPU is being added inside a "#if defined(TARGET_RISCV64)" block, 
>>> meaning
>>> that it's a 64-bit CPU only. But the CVA6 board added in patch 1 is 
>>> being
>>> added for both 32 and 64 bit emulations in hw/riscv/Kconfig:
>>
>> Ah yes, it is possible to make a cva6 32bit, is it ok just to ove this
>> into a different place or is there anything else needed to allow 32 or 
>> 64bit?
>>
>> I've only been building a 64bit userland to test so didn't notice the
>> lack of 32bit was an issue.
>>
>>> config CVA6
>>>      bool
>>>      default y
>>>      depends on RISCV32 || RISCV64  <------------------
>>>
>>> This setup (after patch 3 is added) triggered a test failure in 
>>> 'check- qtest',
>>> when polling all available boards in qemu-system-riscv32, because it 
>>> didn't find
>>> a default 32 bit CPU for the cva6 board:
>>>
>>> # starting QEMU: exec ./qemu-system-riscv32 -qtest unix:/tmp/ 
>>> qtest-1683816.sock -qtest-log /dev/null -chardev socket,path=/tmp/ 
>>> qtest-1683816.qmp,id=char0 -mon chardev=char0,mode=control -display 
>>> none -audio none -machine cva6 -accel qtest
>>> ----------------------------------- stderr 
>>> -----------------------------------
>>> qemu-system-riscv32: ../hw/core/machine.c:1574: 
>>> is_cpu_type_supported: Assertion `cc != NULL' failed.
>>> Broken pipe
>>> ../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from 
>>> signal 6 (Aborted) (core dumped)
>>>
>>>
>>>
>>> We have 2 options here:
>>>
>>> - if the CVA6 board is supposed to run in RISCV32 and RISCV64, then 
>>> its default
>>> CPU must be 32 bit compliant too. The CPU declaration in this patch 
>>> must be moved
>>> outside the "#if defined(TARGET_RISCV64)" block (e.g right after
>>> TYPE_RISCV_CPU_SIFIVE_U);
>>>
>>> - if the board is 64 bit only then the CPU declaration is fine, and 
>>> we need to
>>> change the board hw/riscv/Kconfig entry to "depends on RISCV64".
>>>
>>
>> As long as it is just the #ifdef block I will move it.
> 
> I just read the CV6 documentation at:
> 
> https://github.com/openhwgroup/cva6/
> 
> 
> The README states right at the start:
> 
> 
> "CVA6 is a 6-stage, single-issue, in-order CPU which implements the 64- 
> bit RISC-V instruction set."
> 
> 
> So this means that CVA6 is a 64-bit CPU only. This means that we want 
> the second
> option: the CPU declaration is fine, but the CVA6 board must be built 
> only for 64
> bits. In patch 1, this line:


There do seem to be some build variants for cva32a6 deep in the docs
and the cva6-sdk has builds for both xlen==32 and xlen==64 so I am a
bit confused here.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

