Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1474DE67801
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 15:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7FcO-0005LU-F1; Sat, 02 Nov 2024 11:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uVOK=R5=kaod.org=clg@ozlabs.org>)
 id 1t7FcL-0005BF-73; Sat, 02 Nov 2024 11:00:45 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uVOK=R5=kaod.org=clg@ozlabs.org>)
 id 1t7FcI-0004R3-4u; Sat, 02 Nov 2024 11:00:44 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Xggs06D86z4x7H;
 Sun,  3 Nov 2024 02:00:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xggrw3Frxz4x8R;
 Sun,  3 Nov 2024 02:00:32 +1100 (AEDT)
Message-ID: <6323f00d-1dcc-4873-a4d5-aa5b41f76570@kaod.org>
Date: Sat, 2 Nov 2024 16:00:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 4/8] hw/sd/sdhci: Fix coding style
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
 <20241029091729.3317512-5-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241029091729.3317512-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=uVOK=R5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/29/24 10:17, Jamin Lin wrote:
> Fix coding style issues from checkpatch.pl
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sdhci.c | 64 +++++++++++++++++++++++++++++++++------------------
>   1 file changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index ed01499391..db7d547156 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -234,7 +234,7 @@ static void sdhci_raise_insertion_irq(void *opaque)
>   
>       if (s->norintsts & SDHC_NIS_REMOVE) {
>           timer_mod(s->insert_timer,
> -                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_INSERTION_DELAY);
> +                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_INSERTION_DELAY);
>       } else {
>           s->prnsts = 0x1ff0000;
>           if (s->norintstsen & SDHC_NISEN_INSERT) {
> @@ -252,7 +252,7 @@ static void sdhci_set_inserted(DeviceState *dev, bool level)
>       if ((s->norintsts & SDHC_NIS_REMOVE) && level) {
>           /* Give target some time to notice card ejection */
>           timer_mod(s->insert_timer,
> -                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_INSERTION_DELAY);
> +                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_INSERTION_DELAY);
>       } else {
>           if (level) {
>               s->prnsts = 0x1ff0000;
> @@ -290,9 +290,11 @@ static void sdhci_reset(SDHCIState *s)
>       timer_del(s->insert_timer);
>       timer_del(s->transfer_timer);
>   
> -    /* Set all registers to 0. Capabilities/Version registers are not cleared
> +    /*
> +     * Set all registers to 0. Capabilities/Version registers are not cleared
>        * and assumed to always preserve their value, given to them during
> -     * initialization */
> +     * initialization
> +     */
>       memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintptr_t)&s->sdmasysad);
>   
>       /* Reset other state based on current card insertion/readonly status */
> @@ -306,7 +308,8 @@ static void sdhci_reset(SDHCIState *s)
>   
>   static void sdhci_poweron_reset(DeviceState *dev)
>   {
> -    /* QOM (ie power-on) reset. This is identical to reset
> +    /*
> +     * QOM (ie power-on) reset. This is identical to reset
>        * commanded via device register apart from handling of the
>        * 'pending insert on powerup' quirk.
>        */
> @@ -446,8 +449,10 @@ static void sdhci_read_block_from_card(SDHCIState *s)
>           s->prnsts &= ~SDHC_DAT_LINE_ACTIVE;
>       }
>   
> -    /* If stop at block gap request was set and it's not the last block of
> -     * data - generate Block Event interrupt */
> +    /*
> +     * If stop at block gap request was set and it's not the last block of
> +     * data - generate Block Event interrupt
> +     */
>       if (s->stopped_state == sdhc_gap_read && (s->trnmod & SDHC_TRNS_MULTI) &&
>               s->blkcnt != 1)    {
>           s->prnsts &= ~SDHC_DAT_LINE_ACTIVE;
> @@ -549,8 +554,10 @@ static void sdhci_write_block_to_card(SDHCIState *s)
>       sdhci_update_irq(s);
>   }
>   
> -/* Write @size bytes of @value data to host controller @s Buffer Data Port
> - * register */
> +/*
> + * Write @size bytes of @value data to host controller @s Buffer Data Port
> + * register
> + */
>   static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
>   {
>       unsigned i;
> @@ -595,9 +602,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>           return;
>       }
>   
> -    /* XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
> +    /*
> +     * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
>        * possible stop at page boundary if initial address is not page aligned,
> -     * allow them to work properly */
> +     * allow them to work properly
> +     */
>       if ((s->sdmasysad % boundary_chk) == 0) {
>           page_aligned = true;
>       }
> @@ -703,7 +712,8 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
>           dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
>                           MEMTXATTRS_UNSPECIFIED);
>           adma2 = le64_to_cpu(adma2);
> -        /* The spec does not specify endianness of descriptor table.
> +        /*
> +         * The spec does not specify endianness of descriptor table.
>            * We currently assume that it is LE.
>            */
>           dscr->addr = (hwaddr)extract64(adma2, 32, 32) & ~0x3ull;
> @@ -978,8 +988,10 @@ static bool sdhci_can_issue_command(SDHCIState *s)
>       return true;
>   }
>   
> -/* The Buffer Data Port register must be accessed in sequential and
> - * continuous manner */
> +/*
> + * The Buffer Data Port register must be accessed in sequential and
> + * continuous manner
> + */
>   static inline bool
>   sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
>   {
> @@ -1207,8 +1219,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>           MASKED_WRITE(s->argument, mask, value);
>           break;
>       case SDHC_TRNMOD:
> -        /* DMA can be enabled only if it is supported as indicated by
> -         * capabilities register */
> +        /*
> +         * DMA can be enabled only if it is supported as indicated by
> +         * capabilities register
> +         */
>           if (!(s->capareg & R_SDHC_CAPAB_SDMA_MASK)) {
>               value &= ~SDHC_TRNS_DMA;
>           }
> @@ -1280,8 +1294,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>           } else {
>               s->norintsts &= ~SDHC_NIS_ERR;
>           }
> -        /* Quirk for Raspberry Pi: pending card insert interrupt
> -         * appears when first enabled after power on */
> +        /*
> +         * Quirk for Raspberry Pi: pending card insert interrupt
> +         * appears when first enabled after power on
> +         */
>           if ((s->norintstsen & SDHC_NISEN_INSERT) && s->pending_insert_state) {
>               assert(s->pending_insert_quirk);
>               s->norintsts |= SDHC_NIS_INSERT;
> @@ -1397,8 +1413,10 @@ void sdhci_initfn(SDHCIState *s)
>   {
>       qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SDHCI_BUS, DEVICE(s), "sd-bus");
>   
> -    s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_insertion_irq, s);
> -    s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
> +    s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                   sdhci_raise_insertion_irq, s);
> +    s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                     sdhci_data_transfer, s);
>   
>       s->io_ops = &sdhci_mmio_le_ops;
>   }
> @@ -1446,11 +1464,13 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
>   
>   void sdhci_common_unrealize(SDHCIState *s)
>   {
> -    /* This function is expected to be called only once for each class:
> +    /*
> +     * This function is expected to be called only once for each class:
>        * - SysBus:    via DeviceClass->unrealize(),
>        * - PCI:       via PCIDeviceClass->exit().
>        * However to avoid double-free and/or use-after-free we still nullify
> -     * this variable (better safe than sorry!). */
> +     * this variable (better safe than sorry!).
> +     */
>       g_free(s->fifo_buffer);
>       s->fifo_buffer = NULL;
>   }


