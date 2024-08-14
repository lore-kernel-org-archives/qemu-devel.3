Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E7DC52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 21:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seLhy-00031X-8T; Wed, 14 Aug 2024 17:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1seLhw-0002yH-1N; Wed, 14 Aug 2024 17:39:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1seLhu-00061s-5w; Wed, 14 Aug 2024 17:39:03 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 58B8F4E601B;
 Wed, 14 Aug 2024 23:38:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id qopeG03LmtOG; Wed, 14 Aug 2024 23:38:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4D95E4E600F; Wed, 14 Aug 2024 23:38:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 466F874577C;
 Wed, 14 Aug 2024 23:38:52 +0200 (CEST)
Date: Wed, 14 Aug 2024 23:38:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Stafford Horne <shorne@gmail.com>, 
 qemu-ppc@nongnu.org, Tyrone Ting <kfting@nuvoton.com>, 
 Joel Stanley <joel@jms.id.au>, Eduardo Habkost <eduardo@habkost.net>, 
 Sergio Lopez <slp@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Beniamino Galvani <b.galvani@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Jia Liu <proljc@gmail.com>, 
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org, 
 Aleksandar Rikalo <arikalo@gmail.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 qemu-riscv@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Song Gao <gaosong@loongson.cn>
Subject: Re: [PATCH 2/5] hw/char/serial: Remove unused funtion
In-Reply-To: <20240814181534.218964-3-shentey@gmail.com>
Message-ID: <22fa9014-2923-b501-e38d-f5dd1e53d15a@eik.bme.hu>
References: <20240814181534.218964-1-shentey@gmail.com>
 <20240814181534.218964-3-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 14 Aug 2024, Bernhard Beschow wrote:
> The serial port's frequency is set via the "baudbase" property nowadays.

Please keep it as some devices might have registers that set this freq and 
this function will be needed for emulating that even if it's not emulated 
currently.

Regards,
BALATON Zoltan

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> include/hw/char/serial.h | 2 --
> hw/char/serial.c         | 7 -------
> 2 files changed, 9 deletions(-)
>
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 6e14099ee7..40aad21df3 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -93,8 +93,6 @@ struct SerialMM {
> extern const VMStateDescription vmstate_serial;
> extern const MemoryRegionOps serial_io_ops;
>
> -void serial_set_frequency(SerialState *s, uint32_t frequency);
> -
> #define TYPE_SERIAL "serial"
> OBJECT_DECLARE_SIMPLE_TYPE(SerialState, SERIAL)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index d8b2db5082..6c5c4a23c7 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -951,13 +951,6 @@ static void serial_unrealize(DeviceState *dev)
>     qemu_unregister_reset(serial_reset, s);
> }
>
> -/* Change the main reference oscillator frequency. */
> -void serial_set_frequency(SerialState *s, uint32_t frequency)
> -{
> -    s->baudbase = frequency;
> -    serial_update_parameters(s);
> -}
> -
> const MemoryRegionOps serial_io_ops = {
>     .read = serial_ioport_read,
>     .write = serial_ioport_write,
>

