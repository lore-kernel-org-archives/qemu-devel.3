Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B19C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6h0-0001sQ-Qn; Fri, 28 Jun 2024 04:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6gz-0001rh-AS
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:10:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6gx-00010X-CL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:10:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Smj36Lbz4wcr;
 Fri, 28 Jun 2024 18:10:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Smh32kvz4wcg;
 Fri, 28 Jun 2024 18:10:44 +1000 (AEST)
Message-ID: <d91f53b8-40bc-48bc-bd30-32627eeb1213@kaod.org>
Date: Fri, 28 Jun 2024 10:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v42 89/98] hw/sd/sdcard: Implement eMMC sleep state
 (CMD5)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-90-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-90-philmd@linaro.org>
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

On 6/28/24 9:02 AM, Philippe Mathieu-Daudé wrote:
> From: Luc Michel <luc.michel@amd.com>
> 
> The JEDEC standards specifies a sleep state where the eMMC won't answer
> any command appart from RESET and WAKEUP and go to low power state.
> Implement this state and the corresponding command number 5.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 0f9bab105e..bd77853419 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1182,8 +1182,19 @@ static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
>   /* CMD0 */
>   static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
>   {
> -    sd->state = sd_idle_state;
> -    sd_reset(DEVICE(sd));
> +    if (sd->state == sd_sleep_state) {
> +        switch (req.arg) {
> +        case 0x00000000:
> +        case 0xf0f0f0f0:
> +            break;
> +        default:
> +            return sd_r0;
> +        }
> +    }
> +    if (sd->state != sd_inactive_state) {
> +        sd->state = sd_idle_state;
> +        sd_reset(DEVICE(sd));
> +    }
>   
>       return sd_is_spi(sd) ? sd_r1 : sd_r0;
>   }
> @@ -1246,6 +1257,30 @@ static sd_rsp_type_t emmc_cmd_SET_RELATIVE_ADDR(SDState *sd, SDRequest req)
>       }
>   }
>   
> +/* CMD5 */
> +static sd_rsp_type_t emmc_cmd_sleep_awake(SDState *sd, SDRequest req)
> +{
> +    bool do_sleep = extract32(req.arg, 15, 1);
> +
> +    switch (sd->state) {
> +    case sd_sleep_state:
> +        if (!do_sleep) {
> +            /* Awake */
> +            sd->state = sd_standby_state;
> +        }
> +        return sd_r1b;
> +
> +    case sd_standby_state:
> +        if (do_sleep) {
> +            sd->state = sd_sleep_state;
> +        }
> +        return sd_r1b;
> +
> +    default:
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +}
> +
>   /* CMD6 */
>   static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
>   {
> @@ -1648,6 +1683,7 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
>       case sd_ready_state:
>       case sd_identification_state:
>       case sd_inactive_state:
> +    case sd_sleep_state:
>           return sd_invalid_state_for_cmd(sd, req);
>       case sd_idle_state:
>           if (!sd_is_spi(sd) && sd_req_get_rca(sd, req) != 0x0000) {
> @@ -1969,6 +2005,12 @@ int sd_do_command(SDState *sd, SDRequest *req,
>           req->cmd &= 0x3f;
>       }
>   
> +    if (sd->state == sd_sleep_state && req->cmd) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "SD: Card is sleeping\n");
> +        rtype = sd_r0;
> +        goto send_response;
> +    }
> +
>       if (sd->card_status & CARD_IS_LOCKED) {
>           if (!cmd_valid_while_locked(sd, req->cmd)) {
>               sd->card_status |= ILLEGAL_COMMAND;
> @@ -2420,6 +2462,7 @@ static const SDProto sd_proto_emmc = {
>           [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
>           [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
>           [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
> +        [5]  = {0,  sd_ac,   "SLEEP/AWAKE", emmc_cmd_sleep_awake},
>           [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
>           [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
>           [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},


