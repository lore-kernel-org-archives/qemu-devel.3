Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1914DC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFip-0005Ir-Kk; Tue, 21 Jul 2026 15:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmFiZ-0005Ez-RM; Tue, 21 Jul 2026 15:01:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmFiX-0000W2-77; Tue, 21 Jul 2026 15:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784660463; bh=0KoN2Ti55u0GeS+Ipzctxr+zyfEVtZ0IHutiqKQtnt0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=L6B1jA6P8ml02O7LdkpjAsA4xo6B1p8EdRInG7J3GvUdMaX/OFVhU+WCs3dVsAkPu
 ozweeelV8nbT158ZmhU0xfbYKY9eIJu+4MLOY9be5p34gDihnsmdfwuwVQ+sYAmYR9
 Ad7/rODn25MaY7HXqccNx1eKgq7URhKpkywGBkqMgkF/pLZeyePqT33g4I4AemerOX
 vusIOFhXjx8CU1HTm+Ez7r0QcR3uqg7hb94Ij/kZ5GbwV/5mFcT/+k95jtnBJvgoF3
 8H6i335Bvwkv1eMgQPZLRMJnebwVnR4UCR6vT/YiqVmAwCZcNLvpT6vxiCTs6HaMJo
 IeARY7FIVJxSw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E82411C37B5;
 Tue, 21 Jul 2026 22:01:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 96A8E3F2B92;
 Tue, 21 Jul 2026 22:01:19 +0300 (MSK)
Message-ID: <63046247-5e3a-4943-852a-985ffdc1f087@tls.msk.ru>
Date: Tue, 21 Jul 2026 22:01:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/char: imx_serial: add missing migration state
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260715131819.14827-1-dingtao0430@163.com>
 <20260715131819.14827-2-dingtao0430@163.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260715131819.14827-2-dingtao0430@163.com>
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

On 7/15/26 16:18, Tao Ding wrote:
> Add ucr2 from imx_serial to vmstate, and increment the version_id.
> 
> Migrating on sabrelite can reproduce this issue:
> 1. Prepare the U-Boot required for sabrelite. (according to sabrelite.rst)
> 2. Compile qemu
>      $ mkdir build && cd build && ../configure --target-list="arm-softmmu" && make -j4
> 3. Start sabrelite and prepare for migration
>      $ ./build/qemu-system-arm -M sabrelite \
>      -smp 1 -m 1G -display none -serial null -serial mon:stdio \
>      -kernel ~/u-boot
> 4. Enter qemu monitor after uboot. (ctrl + a + c)
>      (qemu) stop
>      (qemu) xp /4wx 0x021e8084
>      021e8084: 0x00004027 0x00000784 0x00008000 0x00000a01
>      (qemu) migrate -d file:vmstate
>      (qemu) q
> 
> Load the migrated vmstate, before repairing:
> 
> $ ./build/qemu-system-arm -M sabrelite \
>      -smp 1 -m 1G -display none -serial null -serial mon:stdio \
>      -kernel ~/u-boot -incoming file:vmstate
> 
> (ctrl + a + c)
>      QEMU 11.0.50 monitor - type 'help' for more information
>      (qemu) xp /4wx 0x021e8084
>      021e8084: 0x00000004 0x00000784 0x00008000 0x00000a01
>      (qemu) q
> 
> It can be found that the data for address 0x021e8084 (register of usr2 in imx_serial of sabrelite)
> is not the data before the migration.
> 
> After being repaired:
> $ ./build/qemu-system-arm -M sabrelite \
>      -smp 1 -m 1G -display none -serial null -serial mon:stdio \
>      -kernel ~/u-boot -incoming file:vmstate
> (ctrl + a + c)
>      QEMU 11.0.50 monitor - type 'help' for more information
>      (qemu) xp /4wx 0x021e8084
>      021e8084: 0x00004027 0x00000784 0x00008000 0x00000a01
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>


Somehow, this grow Cc: qemu-stable@ in the final version which was
applied as v11.1.0-rc0-68-g8833ff95eaf.  I don't think this is a
good candidate for the stable series, since this fix changes the
migration stream format, which is very difficult to do in the stable
series.

FWIW.

Thanks,

/mjt

>   hw/char/imx_serial.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
> index 080b7f6331..fb41ee2ac5 100644
> --- a/hw/char/imx_serial.c
> +++ b/hw/char/imx_serial.c
> @@ -43,14 +43,15 @@
>   
>   static const VMStateDescription vmstate_imx_serial = {
>       .name = TYPE_IMX_SERIAL,
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
>       .fields = (const VMStateField[]) {
>           VMSTATE_FIFO32(rx_fifo, IMXSerialState),
>           VMSTATE_TIMER(ageing_timer, IMXSerialState),
>           VMSTATE_UINT32(usr1, IMXSerialState),
>           VMSTATE_UINT32(usr2, IMXSerialState),
>           VMSTATE_UINT32(ucr1, IMXSerialState),
> +        VMSTATE_UINT32(ucr2, IMXSerialState),
>           VMSTATE_UINT32(uts1, IMXSerialState),
>           VMSTATE_UINT32(onems, IMXSerialState),
>           VMSTATE_UINT32(ufcr, IMXSerialState),


