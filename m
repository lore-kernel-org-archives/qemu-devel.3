Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFDFC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6cv-0006hB-By; Fri, 28 Jun 2024 04:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6cm-0006Ma-Cj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:06:29 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6ch-0007nH-6m
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:06:25 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Sgb54pCz4wb7;
 Fri, 28 Jun 2024 18:06:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SgZ4t3Cz4w2N;
 Fri, 28 Jun 2024 18:06:18 +1000 (AEST)
Message-ID: <00a09a8c-c480-4ff3-a65b-50cdd4485794@kaod.org>
Date: Fri, 28 Jun 2024 10:06:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v42 81/98] hw/sd/sdcard: Cover more SDCardStates
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-82-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-82-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GU6n=N6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/28/24 9:01 AM, Philippe Mathieu-Daudé wrote:
> So far eMMC will only use sd_sleep_state, but
> all all states specified for completeness.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index b0ef252001..92ac57a648 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -76,7 +76,9 @@ enum SDCardModes {
>   };
>   
>   enum SDCardStates {
> +    sd_waitirq_state        = -2, /* emmc */
>       sd_inactive_state       = -1,
> +
>       sd_idle_state           = 0,
>       sd_ready_state          = 1,
>       sd_identification_state = 2,
> @@ -86,6 +88,9 @@ enum SDCardStates {
>       sd_receivingdata_state  = 6,
>       sd_programming_state    = 7,
>       sd_disconnect_state     = 8,
> +    sd_bus_test_state       = 9,  /* emmc */
> +    sd_sleep_state          = 10, /* emmc */
> +    sd_io_state             = 15  /* sd */
>   };
>   
>   #define SDMMC_CMD_MAX 64
> @@ -205,13 +210,19 @@ static const char *sd_state_name(enum SDCardStates state)
>           [sd_standby_state]          = "standby",
>           [sd_transfer_state]         = "transfer",
>           [sd_sendingdata_state]      = "sendingdata",
> +        [sd_bus_test_state]         = "bus-test",
>           [sd_receivingdata_state]    = "receivingdata",
>           [sd_programming_state]      = "programming",
>           [sd_disconnect_state]       = "disconnect",
> +        [sd_sleep_state]            = "sleep",
> +        [sd_io_state]               = "i/o"
>       };
>       if (state == sd_inactive_state) {
>           return "inactive";
>       }
> +    if (state == sd_waitirq_state) {
> +        return "wait-irq";
> +    }
>       assert(state < ARRAY_SIZE(state_name));
>       return state_name[state];
>   }


