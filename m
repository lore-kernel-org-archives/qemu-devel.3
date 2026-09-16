Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06061C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jF1-0008IZ-5P; Wed, 16 Sep 2026 02:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6jEs-0008Ap-Gv; Wed, 16 Sep 2026 02:35:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6jEp-0004u2-RN; Wed, 16 Sep 2026 02:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789540477; bh=YuRHpvnkrTWzoVNdwUwxBcaKOpAXO6ds+f3NOnPAiEA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=T/6Mb1GSpvyd+xWwvw18jhMIss2joWtCKIP8I8k2CJg5GY6zN+aT7uXV5hrEg5Xii
 bQtbuZj7UjcOQDrIISmBuBLv5grTeptk65XOb3aItfewZ5E4DSys9eFjQosvyxlEdu
 LDc+xRqOg0T8coLlxC5j1IBZbi2Um6p0xdcON8BLCm4BsQhAMhrL21Qfg67YkxBq8c
 WdbZ65ptiebmgBV0O20IrKSDAdXB1aGshGBxyCf5sWtuxoYWB9npvapA1vfnWn6Jnj
 Z5B/f5ARCMq5vFYeAsNxHxGHLviK8hZC2VYrq+Ja+2VpZVADwg9xDJa5SfIJEouWz8
 FKR8mAcg4vjLw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 472371D552E;
 Wed, 16 Sep 2026 09:34:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9C91D4299EB;
 Wed, 16 Sep 2026 09:35:19 +0300 (MSK)
Message-ID: <725cf200-8a28-4fc9-8d96-4d705213505d@tls.msk.ru>
Date: Wed, 16 Sep 2026 09:35:19 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v5 08/15] hw/riscv/virt.c: fix aclint soc/mtimer nodename
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-stable@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/28/26 23:39, Daniel Henrique Barboza wrote:
> Running 'dtc' to generate a readable fdt for the virt machine produce
> warnings:
> 
>   $ dtc -I dtb -O dts virt.dtb > virt.dts
> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"
> 
> This happens because the 'reg' field does not match the address in the
> nodename.  The right fix, pointed out by Chao in [1], is to make the
> nodename match the reg value:
> 
> "In the current QEMU implement, `addr` is the MTIMECMP base address,
> while the MTIME register is located at addr + RISCV_ACLINT_DEFAULT_MTIME."
> 
> In other words, the 'reg' value is correct but the nodename isn't.
> 
> We'll make the fix now, allowing the next patch to move the fixed version
> of aclint FDT to fdt-common.
> 
> [1] https://lore.kernel.org/qemu-devel/apHH1upnh8udUUT-@ChaodeMacBook-Pro.local/
> 
> Cc: qemu-stable@nongnu.org
> Suggested-by: Chao Liu <chao.liu@processmission.com>
> Fixes: 954886ea6d ("hw/riscv: virt: Add optional ACLINT support to virt machine")
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/riscv/virt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

This patch is Cc'd to qemu-stable, but there's an interesting rebase twist here,
it looks like.  This is commit v11.1.0-1035-g9d6ac47d318 in the master branch.

> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a6ec9def16..83a4b7710d 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -234,7 +234,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
>                  (s->memmap[VIRT_CLINT].size * socket);
>           size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
>       }
> -    name = g_strdup_printf("/soc/mtimer@%lx", addr);
> +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
> +                           addr + RISCV_ACLINT_DEFAULT_MTIME);

Before this commit, `add` variable is declared in this function as
unsigned long.  So this particular change is wrong, because now the
format string does not match its argument:

../hw/riscv/virt.c: In function 'create_fdt_socket_aclint':
../hw/riscv/virt.c:408:28: error: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'long unsigned int' 
[-Werror=format=]
   408 |     name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
       |                            ^~~~~~~~~~~~~~~
   409 |                            addr + RISCV_ACLINT_DEFAULT_MTIME);
       |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |                                 |
       |                                 long unsigned int
In file included from ../include/qemu/osdep.h:118,
                  from ../hw/riscv/virt.c:21:
/usr/x86_64-w64-mingw32/sys-root/mingw/include/inttypes.h:38:19: note: format string is defined here
    38 | #define PRIx64 "llx"

However, the very next commit, v11.1.0-1036-ge6ea6bec5a3
"hw/riscv/fdt-common, virt.c: add riscv_create_fdt_socket_aclint()",
moves this whole function to another file, *and* changes the type of
`addr` variable to hwaddr.  So now, everything fits.

But this single patch alone does not work.

Note also there's no mentions of this type change anywhere.

So, what was the actual issue ere?

I'm dropping this patch from the stable series for now, it is definitely
wrong.

It is also interesting that only win64 build of qemu detected this, all
other went just fine.

Thanks,

/mjt

