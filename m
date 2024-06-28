Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61180C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6bW-00021u-Qn; Fri, 28 Jun 2024 04:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6bJ-0001lS-0m
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:04:57 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6bH-0006nc-4f
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:04:56 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Sdx0sm9z4wyQ;
 Fri, 28 Jun 2024 18:04:53 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Sdw0nBxz4w2Q;
 Fri, 28 Jun 2024 18:04:51 +1000 (AEST)
Message-ID: <2f8fa982-c81a-4a4e-a944-f8e14d8a831a@kaod.org>
Date: Fri, 28 Jun 2024 10:04:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v42 75/98] hw/sd/sdcard: Remove sd_none enum from
 sd_cmd_type_t
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-76-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-76-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
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
> All handlers using the 'sd_none' enum got converted,
> remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/sd/sd.h | 1 -
>   hw/sd/sd.c         | 7 +------
>   2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index 29c76935a0..c1a35ab420 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -76,7 +76,6 @@ typedef enum  {
>   } sd_uhs_mode_t;
>   
>   typedef enum {
> -    sd_none = 0,
>       sd_spi,
>       sd_bc,     /* broadcast -- no response */
>       sd_bcr,    /* broadcast with response */
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 6a9d611429..7f93d363c7 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -526,17 +526,12 @@ static void sd_set_rca(SDState *sd, uint16_t value)
>   static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
>   {
>       switch (s->proto->cmd[req.cmd].type) {
> -    case sd_none:
> -        /* Called from legacy code not ported to SDProto array */
> -        assert(!s->proto->cmd[req.cmd].handler);
> -        /* fall-through */
>       case sd_ac:
>       case sd_adtc:
>           return req.arg >> 16;
>       case sd_spi:
> -        g_assert_not_reached();
>       default:
> -        return 0;
> +        g_assert_not_reached();
>       }
>   }
>   


