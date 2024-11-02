Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E84E67801
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 15:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Fdd-0007C4-6W; Sat, 02 Nov 2024 11:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uVOK=R5=kaod.org=clg@ozlabs.org>)
 id 1t7Fd5-0006hq-7N; Sat, 02 Nov 2024 11:01:31 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uVOK=R5=kaod.org=clg@ozlabs.org>)
 id 1t7Fd3-0004Ul-3V; Sat, 02 Nov 2024 11:01:30 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Xggsw2C8Tz4x7H;
 Sun,  3 Nov 2024 02:01:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xggsq6vtwz4x9D;
 Sun,  3 Nov 2024 02:01:19 +1100 (AEDT)
Message-ID: <59097579-c7de-4871-a8c3-da5c1b4dd3b1@kaod.org>
Date: Sat, 2 Nov 2024 16:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 2/8] hw/timer/aspeed: Fix coding style
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
 <20241029091729.3317512-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241029091729.3317512-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=uVOK=R5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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
>   hw/timer/aspeed_timer.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> index b1f860ecfb..5af268ea9e 100644
> --- a/hw/timer/aspeed_timer.c
> +++ b/hw/timer/aspeed_timer.c
> @@ -276,7 +276,8 @@ static void aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
>           old_reload = t->reload;
>           t->reload = calculate_min_ticks(t, value);
>   
> -        /* If the reload value was not previously set, or zero, and
> +        /*
> +         * If the reload value was not previously set, or zero, and
>            * the current value is valid, try to start the timer if it is
>            * enabled.
>            */
> @@ -312,7 +313,8 @@ static void aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
>       }
>   }
>   
> -/* Control register operations are broken out into helpers that can be
> +/*
> + * Control register operations are broken out into helpers that can be
>    * explicitly called on aspeed_timer_reset(), but also from
>    * aspeed_timer_ctrl_op().
>    */
> @@ -396,7 +398,8 @@ static void aspeed_timer_set_ctrl(AspeedTimerCtrlState *s, uint32_t reg)
>       AspeedTimer *t;
>       const uint8_t enable_mask = BIT(op_enable);
>   
> -    /* Handle a dependency between the 'enable' and remaining three
> +    /*
> +     * Handle a dependency between the 'enable' and remaining three
>        * configuration bits - i.e. if more than one bit in the control set has
>        * changed, including the 'enable' bit, then we want either disable the
>        * timer and perform configuration, or perform configuration and then
> @@ -582,7 +585,6 @@ static void aspeed_2600_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
>       case 0x3C:
>           aspeed_timer_set_ctrl(s, s->ctrl & ~tv);
>           break;
> -
>       case 0x38:
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
> @@ -623,7 +625,8 @@ static void aspeed_timer_reset(DeviceState *dev)
>   
>       for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
>           AspeedTimer *t = &s->timers[i];
> -        /* Explicitly call helpers to avoid any conditional behaviour through
> +        /*
> +         * Explicitly call helpers to avoid any conditional behaviour through
>            * aspeed_timer_set_ctrl().
>            */
>           aspeed_timer_ctrl_enable(t, false);


