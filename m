Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859EEC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6YJ-0000dO-Dd; Fri, 28 Jun 2024 04:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6YH-0000UT-BQ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:01:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6YE-0004lR-Ur
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:01:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SZJ6lZSz4w2Q;
 Fri, 28 Jun 2024 18:01:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SZH6g7xz4w2N;
 Fri, 28 Jun 2024 18:01:43 +1000 (AEST)
Message-ID: <8aa768b1-c5a4-45b7-b483-12bcfab4073a@kaod.org>
Date: Fri, 28 Jun 2024 10:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 58/98] hw/sd/sdcard: Add sd_cmd_PROGRAM_CSD handler
 (CMD27)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-59-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-59-philmd@linaro.org>
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 4650d20ee7..9d33113f11 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -243,7 +243,7 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>           [18]    = "READ_MULTIPLE_BLOCK",
>                                               [21]    = "DPS_spec",
>                                               [25]    = "WRITE_MULTIPLE_BLOCK",
> -        [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
> +        [26]    = "MANUF_RSVD",
>           [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
>           [30]    = "SEND_WRITE_PROT",
>           [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
> @@ -1514,6 +1514,12 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
>       return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
>   }
>   
> +/* CMD27 */
> +static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
> +{
> +    return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint16_t rca;
> @@ -1603,9 +1609,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>       case 26:  /* CMD26:  PROGRAM_CID */
>           return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
>   
> -    case 27:  /* CMD27:  PROGRAM_CSD */
> -        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
> -
>       /* Write protection (Class 6) */
>       case 28:  /* CMD28:  SET_WRITE_PROT */
>           if (sd->size > SDSC_MAX_CAPACITY) {
> @@ -2310,6 +2313,7 @@ static const SDProto sd_proto_spi = {
>           [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
>           [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
>           [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
> +        [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
>           [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
> @@ -2347,6 +2351,7 @@ static const SDProto sd_proto_sd = {
>           [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
>           [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
>           [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
> +        [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
>           [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},


