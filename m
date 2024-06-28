Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D624EC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN62r-0005YO-3Z; Fri, 28 Jun 2024 03:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN62p-0005VE-T2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:29:19 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN62n-00077h-Ny
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:29:19 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Rrq59M5z4wcg;
 Fri, 28 Jun 2024 17:29:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Rrp55Xpz4wc8;
 Fri, 28 Jun 2024 17:29:14 +1000 (AEST)
Message-ID: <a11f1b60-fc26-4d38-88be-e334987436a8@kaod.org>
Date: Fri, 28 Jun 2024 09:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 13/98] hw/sd/sdcard: Add direct reference to SDProto
 in SDState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-14-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-14-philmd@linaro.org>
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
> Keep direct reference to SDProto in SDState,
> remove then unnecessary sd_proto().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 37 +++++++++++++++++--------------------
>   1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 8f441e418c..aaa50ab2c5 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -116,6 +116,8 @@ struct SDState {
>       uint8_t spec_version;
>       BlockBackend *blk;
>   
> +    const SDProto *proto;
> +
>       /* Runtime changeables */
>   
>       uint32_t mode;    /* current card mode, one of SDCardModes */
> @@ -154,18 +156,11 @@ struct SDState {
>   
>   static void sd_realize(DeviceState *dev, Error **errp);
>   
> -static const struct SDProto *sd_proto(SDState *sd)
> -{
> -    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
> -
> -    return sc->proto;
> -}
> -
>   static const SDProto sd_proto_spi;
>   
>   static bool sd_is_spi(SDState *sd)
>   {
> -    return sd_proto(sd) == &sd_proto_spi;
> +    return sd->proto == &sd_proto_spi;
>   }
>   
>   static const char *sd_version_str(enum SDPhySpecificationVersion version)
> @@ -1044,7 +1039,7 @@ static bool address_in_range(SDState *sd, const char *desc,
>   static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
>   {
>       qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong state: %s (spec %s)\n",
> -                  sd_proto(sd)->name, req.cmd, sd_state_name(sd->state),
> +                  sd->proto->name, req.cmd, sd_state_name(sd->state),
>                     sd_version_str(sd->spec_version));
>   
>       return sd_illegal;
> @@ -1053,7 +1048,7 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
>   static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
>   {
>       qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong mode: %s (spec %s)\n",
> -                  sd_proto(sd)->name, req.cmd, sd_mode_name(sd->mode),
> +                  sd->proto->name, req.cmd, sd_mode_name(sd->mode),
>                     sd_version_str(sd->spec_version));
>   
>       return sd_illegal;
> @@ -1062,7 +1057,7 @@ static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
>   static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
>   {
>       qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown CMD%i for spec %s\n",
> -                  sd_proto(sd)->name, req.cmd,
> +                  sd->proto->name, req.cmd,
>                     sd_version_str(sd->spec_version));
>   
>       return sd_illegal;
> @@ -1073,7 +1068,7 @@ __attribute__((unused))
>   static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
>   {
>       qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
> -                  sd_proto(sd)->name, req.cmd);
> +                  sd->proto->name, req.cmd);
>   
>       return sd_illegal;
>   }
> @@ -1166,7 +1161,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>        * However there is no ACMD55, so we want to trace this particular case.
>        */
>       if (req.cmd != 55 || sd->expecting_acmd) {
> -        trace_sdcard_normal_command(sd_proto(sd)->name,
> +        trace_sdcard_normal_command(sd->proto->name,
>                                       sd->last_cmd_name, req.cmd,
>                                       req.arg, sd_state_name(sd->state));
>       }
> @@ -1185,8 +1180,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           return sd_illegal;
>       }
>   
> -    if (sd_proto(sd)->cmd[req.cmd]) {
> -        return sd_proto(sd)->cmd[req.cmd](sd, req);
> +    if (sd->proto->cmd[req.cmd]) {
> +        return sd->proto->cmd[req.cmd](sd, req);
>       }
>   
>       switch (req.cmd) {
> @@ -1632,12 +1627,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>                                       SDRequest req)
>   {
>       sd->last_cmd_name = sd_acmd_name(req.cmd);
> -    trace_sdcard_app_command(sd_proto(sd)->name, sd->last_cmd_name,
> +    trace_sdcard_app_command(sd->proto->name, sd->last_cmd_name,
>                                req.cmd, req.arg, sd_state_name(sd->state));
>       sd->card_status |= APP_CMD;
>   
> -    if (sd_proto(sd)->acmd[req.cmd]) {
> -        return sd_proto(sd)->acmd[req.cmd](sd, req);
> +    if (sd->proto->acmd[req.cmd]) {
> +        return sd->proto->acmd[req.cmd](sd, req);
>       }
>   
>       switch (req.cmd) {
> @@ -1928,7 +1923,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>       if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
>           return;
>   
> -    trace_sdcard_write_data(sd_proto(sd)->name,
> +    trace_sdcard_write_data(sd->proto->name,
>                               sd->last_cmd_name,
>                               sd->current_cmd, sd->data_offset, value);
>       switch (sd->current_cmd) {
> @@ -2083,7 +2078,7 @@ uint8_t sd_read_byte(SDState *sd)
>   
>       io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
>   
> -    trace_sdcard_read_data(sd_proto(sd)->name,
> +    trace_sdcard_read_data(sd->proto->name,
>                              sd->last_cmd_name,
>                              sd->current_cmd, sd->data_offset, io_len);
>       switch (sd->current_cmd) {
> @@ -2227,7 +2222,9 @@ static const SDProto sd_proto_sd = {
>   static void sd_instance_init(Object *obj)
>   {
>       SDState *sd = SD_CARD(obj);
> +    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
>   
> +    sd->proto = sc->proto;
>       sd->last_cmd_name = "UNSET";
>       sd->enable = true;
>       sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);


