Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754B606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJW5B-000570-BW; Wed, 21 Oct 2026 09:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xJW57-00050H-M6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:10:15 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xJW54-0003iD-Vh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1792588205;
 bh=ez43FLwGGbmkicKn282nunA53mSZJ9hujWJxFJgoGOc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tTPim7sPMenb521iypmaGHO/oUSr18vctaO6RDYiCa68hawgixzfJX+8n+zSfilNQ
 neJwE1P92pFRrPIBSIu7dIdWeps9iSD3qILntulL78kAXqGGuGGrbG0Mx9NOa89Crp
 b9N+p5fU/l5jSDycV5DODf83xnn1puuxy/8m/TWCXx+ny5Ip4sInJ5iDSPAcq4vtae
 J/2vD8tASEeGf2k5xMzjY3PZJVtInRoojnE6dwULunnoBrOV1O228bWIosBQrqgUAb
 u1EiZxU9rXEZxCYdF4ZYGPYTc1QtykERtJFBc4NrFgl9Afu3Xa0k3OjFZG5otGRpUi
 TNWdUG78UpzHw==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id B5F4D4022E;
 Wed, 21 Oct 2026 15:10:05 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id B2B07FF853;
 Wed, 21 Oct 2026 15:10:05 +0200 (CEST)
Received: from [147.171.132.150] (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 8026A140049;
 Wed, 21 Oct 2026 15:10:05 +0200 (CEST)
Message-ID: <6645e971-3fd3-48f8-93b7-bfe996b37608@univ-grenoble-alpes.fr>
Date: Wed, 21 Oct 2026 15:10:05 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/47] tests/tcg/riscv64: Add tests for rv128 [ms]status
To: Peter Maydell <peter.maydell@linaro.org>, alistair23@gmail.com
Cc: qemu-devel@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
 <20260904051943.799041-14-alistair.francis@wdc.com>
 <CAFEAcA8O9afywUSoju8ozvSP0q-TG2A1Y0Daij-LLhJFRy-dzg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <CAFEAcA8O9afywUSoju8ozvSP0q-TG2A1Y0Daij-LLhJFRy-dzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 16:58, Peter Maydell wrote:
> On Fri, 4 Sept 2026 at 06:23, <alistair23@gmail.com> wrote:
>>
>> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
>>
>> Adding asm tests to check that mstatus and sstatus are updated as
>> expected in an rv128 cpu.
>>
>> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Message-ID: <20260824174246.202150-1-frederic.petrot@univ-grenoble-alpes.fr>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Hi; this test case provokes undefined behaviour which trips the
> clang sanitizer if you run 'make check-tcg' on a build with it enabled
> (i.e. configure with "--cc=clang --cxx=clang++ --enable-ubsan").
> 
> Running the test case on its own:
> 
> $ UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> ./build/riscv-san-dbg/qemu-system-riscv64 -cpu x-rv128 -M virt
> -display none -serial stdio -semihosting -bios
> ./build/riscv-san-dbg/tests/tcg/riscv64-softmmu-test-rv128-sstatus.test
> ../../target/riscv/tcg/pmp.c:572:25: runtime error: shift exponent 64
> is too large for 64-bit type 'target_ulong' (aka 'unsigned long')
> /usr/bin/llvm-symbolizer-18: error: '/memfd:tcg-jit (deleted)': No
> such file or directory
>      #0 0x5ab9d5e8b569 in pmpcfg_csr_read
> /home/pm215/qemu/build/riscv-san-dbg/../../target/riscv/tcg/pmp.c:572:25
>      #1 0x5ab9d5f91440 in read_pmpcfg
> /home/pm215/qemu/build/riscv-san-dbg/../../target/riscv/tcg/csr.c:5588:12
>      #2 0x5ab9d5f79085 in riscv_csrrw_do64
> /home/pm215/qemu/build/riscv-san-dbg/../../target/riscv/tcg/csr.c:5889:15
>      #3 0x5ab9d5f7a274 in riscv_csrrw_i128
> /home/pm215/qemu/build/riscv-san-dbg/../../target/riscv/tcg/csr.c:6046:11
>      #4 0x5ab9d5fb7b11 in helper_csrw_i128
> /home/pm215/qemu/build/riscv-san-dbg/../../target/riscv/tcg/op_helper.c:117:26
>      #5 0x77568c0008ba  (/memfd:tcg-jit (deleted)+0x8ba)
> 
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../target/riscv/tcg/pmp.c:572:25
> Aborted (core dumped)
> 
> What happens is that in pmpcfg_csr_read() we do this:
> 
>      int pmpcfg_nums = 2 << riscv_cpu_mxl(env);
> 
>      for (i = 0; i < pmpcfg_nums; i++) {
>          val = pmp_read_cfg(env, (reg_index * 4) + i);
>          cfg_val |= (val << (i * 8));
>      }
> 
> For the x-rv128 CPU pmpcfg_nums comes out as 16, and then
> we try to assemble 16 bytes into an 8-bit target_ulong variable,
> and for bytes 8..15 the shift amount is larger than the
> type, which is UB.
> 
> I'm not sure how this is intended to work; could you have
> a look at it, please?

   Outch!
   This unfolds a dark side of x-rv128: the absolute minimal csr support
   as of now (hence the x-).
   Most csrs can live with 64-bit, but the pmps, [ms]cause, and probably a
   few, others cannot.
   In essence, this boils down to introducing the "_i128" version of these
   csrs getter/setter for the instructions, but then it raises later issues
   on implicit accesses done within riscv_cpu_do_interrupt in which we have
   to set the upper bit of [ms]cause.
   Here we'll have to check [ms]xl at runtime, I'm afraid.

   I'll send an RFC patch that solves the issue you raised, to see if this
   seems like a proper path to follow for larger csr support.

   Thanks,
   Frédéric
> thanks
> -- PMM

-- 
+---------------------------------------------------------------------------+
| Frédéric Pétrot, Pr. Grenoble INP-UGA@Ensimag/TIMA, MADMAX UGA/CNRS/Inria |
| Mob/Pho: +33 6 74 57 99 65/+33 4 76 57 48 70      Ad augusta  per angusta |
| http://tima.univ-grenoble-alpes.fr frederic.petrot@univ-grenoble-alpes.fr |
+---------------------------------------------------------------------------+


