Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40A8CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU6UT-00015i-GM; Mon, 01 Jun 2026 13:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU6UP-000134-G6
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:31:49 -0400
Received: from smtpout6.mo536.mail-out.ovh.net ([51.210.91.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU6UN-0006EL-Ff
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:31:49 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.68.80.175])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4gTgxX6J7kz81j7;
 Mon,  1 Jun 2026 17:31:44 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon,  1 Jun 2026 17:31:44 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.119])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTgxX3dWRz5vXs; Mon,  1 Jun 2026 17:31:44 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 4CB7112E3044;
 Mon,  1 Jun 2026 17:31:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S0073d795e70-4a3d-4259-bbd1-f05299338181,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ca3b5a5b-7b5f-4523-8bb2-2b3470b05abb@kaod.org>
Date: Mon, 1 Jun 2026 19:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/21] hw/block/m25p80: Implement volatile status
 register write enable for Winbond
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <20260417032837.2664122-15-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260417032837.2664122-15-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13979173244891606155
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFfZCFCu5ND42soV+aQlFBxabNg+Caircb3rhXyPamCAzUtQ2GCI9NPkt47EGb9DGzkPd9yazr4Wm9UG826eu5C7I2LSqlohooUrAfxkEo5avQfqJjwGHTWjPbmaGn3WCO34F7wSlBfUMDi0rhUyX/wIWWUki+Lym+8bHUaFpz416jkhKBIK/UqdMZ5DvcRYzH/Cy4g4aXF+EFbm6fo8ge/OydgUpWraEGlyv8fFMnsXqQAYt3pBUNgM11U8hafjgQ1Q6vbnSWhv7nkoH+JMuC9O4CRV7WCZJC5pE2CwI05RoibEeQ5XsMVfncPDVvjGKwTi5+Pmj08e7pAja+BmXXScKaoc6R2b1vg6Q1znrSDUM9br2OFfErSDmDJZOYuftZums/yuBKV0AynNFvpRy4H3Oh1ALE/F/ai259s0qBqy2RwEq52C+xYRgZeiVb/UPZ/V6gfQAGpfdMyoXVye4PGEq8uOJxlYYNZMRF7MJzo4gPDq+0R7fuG/HB1cGgLVD47v0+Jtn3lIp0/lBtlZ19ve85PCqq8asXXvNYNHd/pX+RsprFnnQx+guzLJxW/dAkV8LoSJ48KIcX5fu007Ra1CDyy3uT1f/gw9MAI0SO32kvzebaGvnF4tU+en+3tLv4kce8HyrLgS3AIsY9g0w9mi5nzzMe/tL+bUgGsXnEqdQ
DKIM-Signature: a=rsa-sha256; bh=79jTjyyH+gHZ01h76WwSVz2USXO8N/t6BBDE5d75AZA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780335105; v=1;
 b=mrW+ATG0/bwfHmANY6UuALcGBypASTB1RcTT6MGI1eC6JZiTnsoVbKLC59jzQ9NCOaXjOdDU
 d85USOW7sk1rlg8B2TZNWOuBbGQHDPTMpx7edMXwiRj/FkrXoRDN0No8tO3NwVek/D5W2zYF3Bv
 Saoma8t+yKNrpqherWtU5H9f6bynhnLF0bShFG4DS7M6/oMaL/Hs5ieAP91I//kCFoAbwaHABQj
 1ea4dAnuUUtcts9lCV+Tvc+jEgtGWmyG6Xcq2DWZuDbqiIQHz7bhA57+Ec/RZJ2MmWnp5S8g7LM
 zuZ17iU4+0xhxYvGFORivCZbMOcu5aGq46OdpWtcoslaQ==
Received-SPF: pass client-ip=51.210.91.15; envelope-from=clg@kaod.org;
 helo=smtpout6.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/17/26 05:28, Jamin Lin wrote:
> Winbond SPI NOR flashes require the Volatile Status Register Write Enable
> (VSR WREN, opcode 0x50) command to be issued before updating volatile
> status register bits, such as those accessed via the WRSR2 command.
> 
> Currently, WRSR2 handling only checks the standard write enable latch,
> which does not fully model Winbond hardware behavior.
> 
> Add support for the volatile write enable mechanism by introducing a
> separate volatile_write_enable flag. For Winbond devices, WRSR2 writes
> that update volatile status register bits are gated by the VSR WREN
> command. If the volatile write enable latch is not set, such writes are
> rejected.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Please send independently.

> ---
>   hw/block/m25p80.c | 36 ++++++++++++++++++++++++++++++++----
>   1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index b8a2543c0b..5bb8b8efa9 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -438,6 +438,11 @@ typedef enum {
>        */
>       WRSR2 = 0x31,
>   
> +    /*
> +     * Winbond: 0x50 - Write Enable for Volatile Status Register
> +     */
> +    VSR_WREN = 0x50,
> +
>       RNVCR = 0xB5,
>       WNVCR = 0xB1,
>   
> @@ -510,6 +515,7 @@ struct Flash {
>       uint8_t spansion_cr4v;
>       bool wp_level;
>       bool write_enable;
> +    bool volatile_write_enable;
>       bool four_bytes_address_mode;
>       bool reset_enable;
>       bool quad_enable;
> @@ -897,6 +903,7 @@ static void reset_memory(Flash *s)
>       s->pos = 0;
>       s->state = STATE_IDLE;
>       s->write_enable = false;
> +    s->volatile_write_enable = false;
>       s->reset_enable = false;
>       s->quad_enable = false;
>       s->aai_enable = false;
> @@ -1305,8 +1312,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>            * combinations of the two states are called "software protected mode"
>            * (SPM), and status register writes are permitted.
>            */
> -        if ((s->wp_level == 0 && s->status_register_write_disabled)
> -            || !s->write_enable) {
> +        if (s->wp_level == 0 && s->status_register_write_disabled) {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "M25P80: Status register 2 write is disabled!\n");
>               break;
> @@ -1314,6 +1320,17 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>   
>           switch (get_man(s)) {
>           case MAN_WINBOND:
> +            /*
> +             * Winbond requires VSR WREN (0x50) prior to updating volatile
> +             * status register bits. VSR WREN does not set WEL.
> +             *
> +             * Accept either standard WEL (0x06) or VSR WREN (0x50).
> +             */
> +            if (!s->write_enable && !s->volatile_write_enable) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "M25P80: Status register 2 write is disabled!\n");
> +                break;
> +            }
>               s->needed_bytes = 1;
>               s->state = STATE_COLLECTING_DATA;
>               s->pos = 0;
> @@ -1332,6 +1349,16 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>           s->write_enable = true;
>           break;
>   
> +    case VSR_WREN:
> +        switch (get_man(s)) {
> +        case MAN_WINBOND:
> +            s->volatile_write_enable = true;
> +            break;
> +        default:
> +            break;
> +        }
> +        break;
> +
>       case RDSR:
>           s->data[0] = (!!s->write_enable) << 1;
>           s->data[0] |= (!!s->status_register_write_disabled) << 7;
> @@ -1824,8 +1851,8 @@ static const VMStateDescription vmstate_m25p80_block_protect = {
>   
>   static const VMStateDescription vmstate_m25p80 = {
>       .name = "m25p80",
> -    .version_id = 0,
> -    .minimum_version_id = 0,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
>       .pre_save = m25p80_pre_save,
>       .pre_load = m25p80_pre_load,
>       .fields = (const VMStateField[]) {
> @@ -1837,6 +1864,7 @@ static const VMStateDescription vmstate_m25p80 = {
>           VMSTATE_UINT8(cmd_in_progress, Flash),
>           VMSTATE_UINT32(cur_addr, Flash),
>           VMSTATE_BOOL(write_enable, Flash),
> +        VMSTATE_BOOL(volatile_write_enable, Flash),
>           VMSTATE_BOOL(reset_enable, Flash),
>           VMSTATE_UINT8(ear, Flash),
>           VMSTATE_BOOL(four_bytes_address_mode, Flash),


