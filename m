Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F96C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN63C-0005xD-Ni; Fri, 28 Jun 2024 03:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN63B-0005ro-BR
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:29:41 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN639-00078s-MG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:29:41 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9RsF0qBQz4w2N;
 Fri, 28 Jun 2024 17:29:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9RsD04Ztz4w2K;
 Fri, 28 Jun 2024 17:29:35 +1000 (AEST)
Message-ID: <3a2ebe53-de19-47c0-b09a-c4fb9f80a4fb@kaod.org>
Date: Fri, 28 Jun 2024 09:29:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 10/98] hw/sd/sdcard: Assign SDCardStates enum values
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-11-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-11-philmd@linaro.org>
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

On 6/28/24 9:00 AM, Philippe Mathieu-Daudé wrote:
> SDCardStates enum values are specified, so assign them
> correspondingly. It will be useful later when we add
> states from later specs, which might not be continuous.
> 
> See CURRENT_STATE bits in section 4.10.1 "Card Status".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 135b7d2e23..fbdfafa3a6 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -75,16 +75,16 @@ enum SDCardModes {
>   };
>   
>   enum SDCardStates {
> -    sd_inactive_state = -1,
> -    sd_idle_state = 0,
> -    sd_ready_state,
> -    sd_identification_state,
> -    sd_standby_state,
> -    sd_transfer_state,
> -    sd_sendingdata_state,
> -    sd_receivingdata_state,
> -    sd_programming_state,
> -    sd_disconnect_state,
> +    sd_inactive_state       = -1,
> +    sd_idle_state           = 0,
> +    sd_ready_state          = 1,
> +    sd_identification_state = 2,
> +    sd_standby_state        = 3,
> +    sd_transfer_state       = 4,
> +    sd_sendingdata_state    = 5,
> +    sd_receivingdata_state  = 6,
> +    sd_programming_state    = 7,
> +    sd_disconnect_state     = 8,
>   };
>   
>   typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);


