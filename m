Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87BEC2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKh2E-0005vY-Jc; Fri, 21 Jun 2024 12:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh1r-0005Lk-DB; Fri, 21 Jun 2024 12:22:25 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh1p-0003lO-AW; Fri, 21 Jun 2024 12:22:23 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5N165yGgz4wcJ;
 Sat, 22 Jun 2024 02:22:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5N140wJDz4w2Q;
 Sat, 22 Jun 2024 02:22:15 +1000 (AEST)
Message-ID: <2de8cc2c-8eb6-4b9c-ad98-38b8c974fd90@kaod.org>
Date: Fri, 21 Jun 2024 18:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/23] hw/sd/sdcard: Add comments around registers and
 commands
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-21-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=9ak7=NX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 6/21/24 10:05 AM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index ca2c903c5b..95e23abd30 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -317,6 +317,8 @@ static uint8_t sd_crc7(const void *message, size_t width)
>       return shift_reg;
>   }
>   
> +/* Operation Conditions register */
> +
>   #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
>   
>   FIELD(OCR, VDD_VOLTAGE_WINDOW,          0, 24)
> @@ -366,6 +368,8 @@ static void sd_set_ocr(SDState *sd)
>       }
>   }
>   
> +/* SD Configuration register */
> +
>   static void sd_set_scr(SDState *sd)
>   {
>       sd->scr[0] = 0 << 4;        /* SCR structure version 1.0 */
> @@ -388,6 +392,8 @@ static void sd_set_scr(SDState *sd)
>       sd->scr[7] = 0x00;
>   }
>   
> +/* Card IDentification register */
> +
>   #define MID     0xaa
>   #define OID     "XY"
>   #define PNM     "QEMU!"
> @@ -413,6 +419,8 @@ static void sd_set_cid(SDState *sd)
>       sd->cid[15] = (sd_crc7(sd->cid, 15) << 1) | 1;
>   }
>   
> +/* Card-Specific Data register */
> +
>   #define HWBLOCK_SHIFT   9        /* 512 bytes */
>   #define SECTOR_SHIFT    5        /* 16 kilobytes */
>   #define WPGROUP_SHIFT   7        /* 2 megs */
> @@ -482,6 +490,8 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>       sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
>   }
>   
> +/* Relative Card Address register */
> +
>   static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
>   {
>       if (sd_cmd_type[req.cmd] == sd_ac || sd_cmd_type[req.cmd] == sd_adtc) {
> @@ -490,6 +500,8 @@ static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
>       return 0;
>   }
>   
> +/* Card Status register */
> +
>   FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
>   FIELD(CSR, APP_CMD,                     5,  1)
>   FIELD(CSR, FX_EVENT,                    6,  1)
> @@ -620,6 +632,8 @@ static void sd_reset(DeviceState *dev)
>       sect = sd_addr_to_wpnum(size) + 1;
>   
>       sd->state = sd_idle_state;
> +
> +    /* card registers */
>       sd->rca = 0x0000;
>       sd->size = size;
>       sd_set_ocr(sd);
> @@ -1052,6 +1066,7 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
>       return sd_illegal;
>   }
>   
> +/* CMD0 */
>   static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
>   {
>       if (sd->state != sd_inactive_state) {
> @@ -1062,6 +1077,7 @@ static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
>       return sd_is_spi(sd) ? sd_r1 : sd_r0;
>   }
>   
> +/* CMD1 */
>   static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
>   {
>       sd->state = sd_transfer_state;
> @@ -1069,6 +1085,7 @@ static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
>       return sd_r1;
>   }
>   
> +/* CMD2 */
>   static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
>   {
>       switch (sd->state) {
> @@ -1080,6 +1097,7 @@ static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
>       }
>   }
>   
> +/* CMD3 */
>   static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
>   {
>       switch (sd->state) {
> @@ -1094,6 +1112,7 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
>       }
>   }
>   
> +/* CMD19 */
>   static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
>   {
>       if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
> @@ -1110,6 +1129,7 @@ static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
>       return sd_r1;
>   }
>   
> +/* CMD23 */
>   static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
>   {
>       if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {


