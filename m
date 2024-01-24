Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8148C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSdHi-0003Vn-Lz; Wed, 24 Jan 2024 08:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>) id 1rSdHh-0003VN-9V
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:27:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>) id 1rSdHf-0007qH-LZ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:27:17 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F0C1761D3C;
 Wed, 24 Jan 2024 13:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556DFC433F1;
 Wed, 24 Jan 2024 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706102833;
 bh=6jxmAp1zkUQtEI+XN8+qv6JLl9dLMF3pdNtDq7xTVTo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=r8kmOHRpDdQ0+7Usk1dq7lVDkUk4I2aTI/cODDRFAkd1CtELpHpQg9iuvxLNTwM6X
 /STzbqXSZkxsVPIrWOBYoEZxqwcG4g6gWpfswvzP1b+Xh4JjUk/dOxGho+dR01YUDP
 uZFtzvjkpR0GT0pahRVGnIjjzanBSudyCXPR6Bmc3sAh6qFoXHLEt4RSytXG8evwqk
 hTs4K1UUWrLhV/eHQmw8B7lYA94lrVTV8PfbpjBZtwExt5ceo0gIXDp6giOAGjvLhl
 9AxDlMqKcJFyYftUHG5s4ld2dr9JIHRffNM/NZMW7NyBuRmZiZjSWXR8yFbDLwajsS
 uikS05a/QZOxw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Christoph =?utf-8?Q?M=C3=BCllner?=
 <christoph.muellner@vrull.eu>, linux-riscv@lists.infradead.org, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: qemu riscv, thead c906, Linux boot regression
In-Reply-To: <20240124-sliceable-atom-c87a10922d4b@spud>
References: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
 <20240124-sliceable-atom-c87a10922d4b@spud>
Date: Wed, 24 Jan 2024 14:27:10 +0100
Message-ID: <871qa6yi8h.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=139.178.84.217; envelope-from=bjorn@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Conor Dooley <conor@kernel.org> writes:

> On Wed, Jan 24, 2024 at 01:49:51PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> Hi!
>>=20
>> I bumped the RISC-V Linux kernel CI to use qemu 8.2.0, and realized that
>> thead c906 didn't boot anymore. Bisection points to commit d6a427e2c0b2
>> ("target/riscv/cpu.c: restrict 'marchid' value")
>>=20
>> Reverting that commit, or the hack below solves the boot issue:
>>=20
>> --8<--
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 8cbfc7e781ad..e18596c8a55a 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -505,6 +505,9 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>>      cpu->cfg.ext_xtheadsync =3D true;
>>=20=20
>>      cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
>> +    cpu->cfg.marchid =3D ((QEMU_VERSION_MAJOR << 16) |
>> +                        (QEMU_VERSION_MINOR << 8)  |
>> +                        (QEMU_VERSION_MICRO));
>>  #ifndef CONFIG_USER_ONLY
>>      set_satp_mode_max_supported(cpu, VM_1_10_SV39);
>>  #endif
>> --8<--
>>=20
>> I'm unsure what the correct qemu way of adding a default value is,
>> or if c906 should have a proper marchid.
>
> The "correct" marchid/mimpid values for the c906 are zero.

Ok! Thanks for clearing that up for me.

> I haven't looked into the code at all, so I am "assuming" that it is
> being zero intialised at present. Linux applies the errata fixups for
> the c906 when archid and impid are both zero - so your patch will avoid
> these fixups being applied.

I'm also assuming 0, -- will double-check. Hmm, that means that the
*previous* marchid was incorrect (pre d6a427e2c0b2).

> Do you think that perhaps the emulation in QEMU does not support what
> the kernel uses once then errata fixups are enabled?

Did a quick look at the c906 "in_asm,int" logs:

| 0x80201040:  12000073          sfence.vma              zero,zero
| 0x80201044:  18051073          csrrw                   zero,satp,a0
|=20
| riscv_cpu_do_interrupt: hart:0, async:0, cause:000000000000000c, epc:0x00=
00000080201048, tval:0x0000000080201048, desc=3Dexec_page_fault
| riscv_cpu_do_interrupt: hart:0, async:0, cause:000000000000000c, epc:0xff=
ffffff80001048, tval:0xffffffff80001048, desc=3Dexec_page_fault
| ...cont forever

So it looks like we're tripping over the page tables, when we're turning
on paging.

Hmm, maybe it's not qemu, but the c906 that has been broken for a while?

I'll disable it temporarily from CI anyhow, and will continue digging.


Thanks for the pointers/clarifications, Conor!
Bj=C3=B6rn

