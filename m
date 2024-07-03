Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC2BC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0Xj-0006g5-TA; Wed, 03 Jul 2024 10:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sP0Xf-0006eb-9b; Wed, 03 Jul 2024 10:01:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sP0Xb-0003cv-DN; Wed, 03 Jul 2024 10:01:01 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WDhJQ2RSyz4wcC;
 Thu,  4 Jul 2024 00:00:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDhJL1rTjz4wZx;
 Thu,  4 Jul 2024 00:00:49 +1000 (AEST)
Message-ID: <662ef65b-5b41-48d5-a914-b97fe953462f@kaod.org>
Date: Wed, 3 Jul 2024 16:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v46 3/5] hw/sd/sdcard: Rename sd_cmd_SEND_OP_COND handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240703134356.85972-1-philmd@linaro.org>
 <20240703134356.85972-4-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240703134356.85972-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/3/24 3:43 PM, Philippe Mathieu-Daudé wrote:
> The correct command name is 'SD SEND_OP_COND',
> rename accordingly.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 04e8fdb262..10f2764a53 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1701,7 +1701,7 @@ static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
>   }
>   
>   /* ACMD41 */
> -static sd_rsp_type_t sd_acmd_SD_APP_OP_COND(SDState *sd, SDRequest req)
> +static sd_rsp_type_t sd_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
>   {
>       if (sd->state != sd_idle_state) {
>           return sd_invalid_state_for_cmd(sd, req);
> @@ -2378,7 +2378,7 @@ static const SDProto sd_proto_sd = {
>           [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
>           [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
>           [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
> -        [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
> +        [41] = {8,  sd_bcr,  "SEND_OP_COND", sd_cmd_SEND_OP_COND},
>           [42] = {8,  sd_ac,   "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
>           [51] = {8,  sd_adtc, "SEND_SCR", sd_acmd_SEND_SCR},
>       },


