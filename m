Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C4BD0E6D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2oAN-0006eT-H5; Mon, 21 Oct 2024 04:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cGEO=RR=kaod.org=clg@ozlabs.org>)
 id 1t2oAH-0006dO-Uy; Mon, 21 Oct 2024 04:53:25 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cGEO=RR=kaod.org=clg@ozlabs.org>)
 id 1t2oAF-00074g-Og; Mon, 21 Oct 2024 04:53:25 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XX8Gk00Q4z4x11;
 Mon, 21 Oct 2024 19:53:18 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XX8Gc4L81z4wb5;
 Mon, 21 Oct 2024 19:53:09 +1100 (AEDT)
Message-ID: <14c14099-440f-494f-9295-1781b60a4538@kaod.org>
Date: Mon, 21 Oct 2024 10:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 03/16] hw/block:m25p80: Support write status
 register 2 command (0x31) for w25q01jvq
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
 <20241018053112.1886173-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241018053112.1886173-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=cGEO=RR=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/18/24 07:30, Jamin Lin wrote:
> According to the w25q01jv datasheet at page 16, it is required to set QE bit
> in "Status Register 2" to enable quad mode.
> 
> Currently, m25p80 support users utilize "Write Status Register 1(0x01)" command
> to set QE bit in "Status Register 2" and utilize "Read Status Register 2(0x35)"
> command to get the QE bit status.
> 
> However, some firmware directly utilize "Status Register 2(0x31)" command to
> set QE bit. To fully support quad mode for w25q01jvq, adds WRSR2 command.
> 
> Update collecting data needed 1 byte for WRSR2 command in decode_new_cmd
> function and verify QE bit at the first byte of collecting data bit 2 in
> complete_collecting_data.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/block/m25p80.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 3f55b8f385..411d810d3b 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -430,6 +430,11 @@ typedef enum {
>       RDCR_EQIO = 0x35,
>       RSTQIO = 0xf5,
>   
> +    /*
> +     * Winbond: 0x31 - write status register 2
> +     */
> +    WRSR2 = 0x31,
> +
>       RNVCR = 0xB5,
>       WNVCR = 0xB1,
>   
> @@ -821,6 +826,15 @@ static void complete_collecting_data(Flash *s)
>               s->write_enable = false;
>           }
>           break;
> +    case WRSR2:
> +        switch (get_man(s)) {
> +        case MAN_WINBOND:
> +            s->quad_enable = !!(s->data[0] & 0x02);
> +            break;
> +        default:
> +            break;
> +        }
> +        break;
>       case BRWR:
>       case EXTEND_ADDR_WRITE:
>           s->ear = s->data[0];
> @@ -1280,7 +1294,31 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>           }
>           s->pos = 0;
>           break;
> +    case WRSR2:
> +        /*
> +         * If WP# is low and status_register_write_disabled is high,
> +         * status register writes are disabled.
> +         * This is also called "hardware protected mode" (HPM). All other
> +         * combinations of the two states are called "software protected mode"
> +         * (SPM), and status register writes are permitted.
> +         */
> +        if ((s->wp_level == 0 && s->status_register_write_disabled)
> +            || !s->write_enable) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "M25P80: Status register 2 write is disabled!\n");
> +            break;
> +        }
>   
> +        switch (get_man(s)) {
> +        case MAN_WINBOND:
> +            s->needed_bytes = 1;
> +            s->state = STATE_COLLECTING_DATA;
> +            s->pos = 0;
> +            break;
> +        default:
> +            break;
> +        }
> +        break;
>       case WRDI:
>           s->write_enable = false;
>           if (get_man(s) == MAN_SST) {


