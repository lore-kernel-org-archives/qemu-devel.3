Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BFBCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU6KF-0005tG-Ph; Mon, 01 Jun 2026 13:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU6KE-0005oa-80
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:21:18 -0400
Received: from smtpout1.mo539.mail-out.ovh.net ([51.210.91.40])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU6KC-0003JL-FY
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:21:17 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4gTgjN5dmLz4bqY;
 Mon,  1 Jun 2026 17:21:12 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon,  1 Jun 2026 17:21:12 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.74])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTgjN4VY1z1yhg; Mon,  1 Jun 2026 17:21:12 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 87A641B400A7;
 Mon,  1 Jun 2026 17:21:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001414dee38-bee1-4712-9440-2ac73aedc57f,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <89fdb3d4-edf4-43f6-a489-076863325d0c@kaod.org>
Date: Mon, 1 Jun 2026 19:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/21] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG
 control and data registers
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
 <20260417032837.2664122-18-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260417032837.2664122-18-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13801281058122607755
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG11xkYjVc7pQ60C4X1ARPNSR7czKXT9p5cn/Wl47NcnaLYjmQ0sJleCnDEkzILpt+51H+z8nEQyYie+WIQDHUUaH8vO3ZyjUVJbH9NPmqon+b+IEwi8U7XM8MpTaUlf25NrcB28mcLjlnzsdFregVxhhcaFjwkdSgWIsn9hOrXKFe//sMxr5srWqMa4MfX23z/U6zN7756WTAp6MyFeoHx4MB+t6+luLf8D/q0xPS5BTkoK+JwEpidoBAk2+qEuE/+GbgD8dreWx3jHPNf0/40yxCbePNcMH7pNwCRYIUyq1/QHsJht01NlYO8RC0DyEJcdflqGhdjcvOgP4+FYuTkqzutxy+er4s/uHi9oP2nC4tADZcmb95zhwUDIh/kiUol7FlShm4eBfjd5sijnK1kt8+gLAndgDWZ0iWD4QV6HNiy22OrOrCiaEY3JGBsNoldKX+HT2sxUwvR6UktsVRqaDOf0idQTgShwyjfC91I+rkxrHBh2zqTrStjbPP9+NP2yto5bSpVsIxPPnsRQAe7GAWJjlNSTU0Gq20Zay2UGMp/NFMKc0sOGc5TY5BAXG/bb2gO7ivd8Custc8c8EMYZaEvIlWS7E86CYBCX7vRLxJHu4w717LIYL7W7k/DPMoAD4Q2KSJCdgL2Z9hdwM9JyXH+A9Y6oOtzqll6g7iCDg
DKIM-Signature: a=rsa-sha256; bh=12jL3lkKFZ2gMDX5Y49x2WIvODFed+Iz7zpVbsxVU/o=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780334473; v=1;
 b=lm58+xTyrLq6ogIbahWXCGBDUU8LzD/z85kUBXqlfCdExE1auGjDrNGBevzkYkOyzPQcHIzc
 OKx4fpsRf3QzT2FUX1FX4qRbur195hX4PXXbSOsif6LEJu/Z9DTGN8wdKsX4/GcfgXRSzki211G
 S3ccHIMbBbwvAR0H1Kmz9maAbXP8rwGX55J/Ft365LuhmsROh6H+t65DNEMzh1yr8rQvDj7qewO
 ByYfAJq1gliDlvAZpX+x9vngFG/bksIYadw4Syc/sKuxhS5mkJYFBYDNlVikv0nndQLxZ66NP5F
 pYYzo7OrC6QEzKGMuZTyYXTiABpZTVZ8fUE0QCjoNZyVg==
Received-SPF: pass client-ip=51.210.91.40; envelope-from=clg@kaod.org;
 helo=smtpout1.mo539.mail-out.ovh.net
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

On 4/17/26 05:29, Jamin Lin wrote:
> Implement basic behavior for RNG_CTRL and RNG_DATA:
> 
> - RNG_CTRL allows guest to enable/disable the RNG via the DIS bit.
>    Only bits [0:3] and bit 5 are writable; other bits are masked.
> - The VLD bit (bit 31) is updated by the model to reflect the RNG
>    enable state, and is not writable by the guest.
> - When RNG is enabled, reads from RNG_DATA return a newly generated
>    random value.
> - When RNG is disabled, RNG_DATA return 0.
> 
> This provides a minimal functional model of the RNG sufficient for
> software that expects readable random data without modeling full
> hardware behavior.

please send first.

Thanks,

C.


> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/misc/aspeed_scu.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 362733ba11..f9ae65d83c 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -187,6 +187,11 @@
>   #define AST2700_SCU_CPU_SCRATCH_1   TO_REG(0x784)
>   #define AST2700_SCU_VGA_SCRATCH_0   TO_REG(0x900)
>   
> +#define AST2700_SCUIO_RNG_CTRL          TO_REG(0xF0)
> +#define AST2700_SCUIO_RNG_CTRL_MASK     0x2F
> +#define AST2700_SCUIO_RNG_CTRL_DIS      BIT(0)
> +#define AST2700_SCUIO_RNG_CTRL_VLD      BIT(31)
> +#define AST2700_SCUIO_RNG_DATA          TO_REG(0xF4)
>   #define AST2700_SCUIO_CLK_STOP_CTL_1    TO_REG(0x240)
>   #define AST2700_SCUIO_CLK_STOP_CLR_1    TO_REG(0x244)
>   #define AST2700_SCUIO_CLK_STOP_CTL_2    TO_REG(0x260)
> @@ -1257,6 +1262,14 @@ static uint64_t aspeed_ast2700_scuio_read(void *opaque, hwaddr offset,
>           return 0;
>       }
>   
> +    switch (reg) {
> +    case AST2700_SCUIO_RNG_DATA:
> +        if (!(s->regs[AST2700_SCUIO_RNG_CTRL] & AST2700_SCUIO_RNG_CTRL_DIS)) {
> +            s->regs[AST2700_SCUIO_RNG_DATA] = aspeed_scu_get_random();
> +        }
> +        break;
> +    }
> +
>       trace_aspeed_ast2700_scuio_read(offset, size, s->regs[reg]);
>       return s->regs[reg];
>   }
> @@ -1280,6 +1293,18 @@ static void aspeed_ast2700_scuio_write(void *opaque, hwaddr offset,
>       trace_aspeed_ast2700_scuio_write(offset, size, data);
>   
>       switch (reg) {
> +    case AST2700_SCUIO_RNG_CTRL:
> +        data &= AST2700_SCUIO_RNG_CTRL_MASK;
> +        if (data & AST2700_SCUIO_RNG_CTRL_DIS) {
> +            data &= ~AST2700_SCUIO_RNG_CTRL_VLD;
> +            s->regs[AST2700_SCUIO_RNG_DATA] = 0;
> +        } else {
> +            s->regs[AST2700_SCUIO_RNG_DATA] = aspeed_scu_get_random();
> +            data |= AST2700_SCUIO_RNG_CTRL_VLD;
> +        }
> +        s->regs[reg] = data;
> +        updated = true;
> +        break;
>       case AST2700_SCUIO_CLK_STOP_CTL_1:
>       case AST2700_SCUIO_CLK_STOP_CTL_2:
>           s->regs[reg] |= data;


