Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF465C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgvh-0004n2-GG; Fri, 21 Jun 2024 12:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgve-0004mH-2N; Fri, 21 Jun 2024 12:15:58 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgva-0002e3-1h; Fri, 21 Jun 2024 12:15:55 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5MsZ1lxBz4wcJ;
 Sat, 22 Jun 2024 02:15:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5MsW3tfHz4w2Q;
 Sat, 22 Jun 2024 02:15:43 +1000 (AEST)
Message-ID: <ad15d9ce-9701-4be1-b552-c419ad846442@kaod.org>
Date: Fri, 21 Jun 2024 18:15:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] hw/sd/sdcard: Correct code indentation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-2-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-2-philmd@linaro.org>
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
> Fix mis-alignment from commits 793d04f495 and 6380cd2052
> ("Add sd_cmd_SEND_TUNING_BLOCK" and "Add sd_cmd_SET_BLOCK_COUNT").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sd.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 16d8d52a78..626e99ecd6 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1069,33 +1069,33 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
>   
>   static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
>   {
> -        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
> -            return sd_cmd_illegal(sd, req);
> -        }
> +    if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
> +        return sd_cmd_illegal(sd, req);
> +    }
>   
> -        if (sd->state != sd_transfer_state) {
> -            return sd_invalid_state_for_cmd(sd, req);
> -        }
> +    if (sd->state != sd_transfer_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
>   
> -        sd->state = sd_sendingdata_state;
> -        sd->data_offset = 0;
> +    sd->state = sd_sendingdata_state;
> +    sd->data_offset = 0;
>   
> -        return sd_r1;
> +    return sd_r1;
>   }
>   
>   static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
>   {
> -        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
> -            return sd_cmd_illegal(sd, req);
> -        }
> +    if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
> +        return sd_cmd_illegal(sd, req);
> +    }
>   
> -        if (sd->state != sd_transfer_state) {
> -            return sd_invalid_state_for_cmd(sd, req);
> -        }
> +    if (sd->state != sd_transfer_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
>   
> -        sd->multi_blk_cnt = req.arg;
> +    sd->multi_blk_cnt = req.arg;
>   
> -        return sd_r1;
> +    return sd_r1;
>   }
>   
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)


