Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAB8C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Zr-0005v9-7z; Fri, 28 Jun 2024 04:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Zp-0005tW-Pw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:03:25 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Zn-0005rz-V8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:03:25 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Sc96rTvz4wqK;
 Fri, 28 Jun 2024 18:03:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Sc86WgHz4w2Q;
 Fri, 28 Jun 2024 18:03:20 +1000 (AEST)
Message-ID: <d7a386e1-600f-4cc5-b5e0-57f2bbfcdfc9@kaod.org>
Date: Fri, 28 Jun 2024 10:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 69/98] hw/sd/sdcard: Add sd_acmd_SD_STATUS handler
 (ACMD13)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-70-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-70-philmd@linaro.org>
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 0310a5a3a1..5323a42df2 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -260,7 +260,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
> -        [13] = "SD_STATUS",
>           [14] = "DPS_spec",                  [15] = "DPS_spec",
>           [16] = "DPS_spec",
>           [18] = "SECU_spec",
> @@ -1683,6 +1682,13 @@ static sd_rsp_type_t sd_acmd_SET_BUS_WIDTH(SDState *sd, SDRequest req)
>       return sd_r1;
>   }
>   
> +/* ACMD13 */
> +static sd_rsp_type_t sd_acmd_SD_STATUS(SDState *sd, SDRequest req)
> +{
> +    return sd_cmd_to_sendingdata(sd, req, 0,
> +                                 sd->sd_status, sizeof(sd->sd_status));
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint64_t addr;
> @@ -1791,18 +1797,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>       }
>   
>       switch (req.cmd) {
> -    case 13:  /* ACMD13: SD_STATUS */
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            return sd_cmd_to_sendingdata(sd, req, 0,
> -                                         sd->sd_status,
> -                                         sizeof(sd->sd_status));
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
>           switch (sd->state) {
>           case sd_transfer_state:
> @@ -2329,6 +2323,7 @@ static const SDProto sd_proto_spi = {
>           [59] = {0,  sd_spi, "CRC_ON_OFF", spi_cmd_CRC_ON_OFF},
>       },
>       .acmd = {
> +        [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
>           [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
>       },
>   };
> @@ -2386,6 +2381,7 @@ static const SDProto sd_proto_sd = {
>       },
>       .acmd = {
>           [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
> +        [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
>       },
>   };
>   


