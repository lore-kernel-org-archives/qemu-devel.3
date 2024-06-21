Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EFDC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgy0-0000TA-Dh; Fri, 21 Jun 2024 12:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgxy-0000Rt-2J; Fri, 21 Jun 2024 12:18:22 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgxw-00032U-Do; Fri, 21 Jun 2024 12:18:21 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5MwT74jXz4wcq;
 Sat, 22 Jun 2024 02:18:17 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5MwR4yPjz4wc5;
 Sat, 22 Jun 2024 02:18:15 +1000 (AEST)
Message-ID: <9483a0a4-6da3-461b-b251-e67a9b0dba05@kaod.org>
Date: Fri, 21 Jun 2024 18:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/23] hw/sd/sdcard: Remove explicit entries for illegal
 commands
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-9-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-9-philmd@linaro.org>
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
> NULL handler is already handled as illegal, no need to
> duplicate (that keeps this array simpler to maintain).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index e9af834a8c..30239b28bc 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2146,12 +2146,6 @@ static const SDProto sd_proto_spi = {
>       .cmd = {
>           [0]         = sd_cmd_GO_IDLE_STATE,
>           [1]         = spi_cmd_SEND_OP_COND,
> -        [2 ... 4]   = sd_cmd_illegal,
> -        [5]         = sd_cmd_illegal,
> -        [7]         = sd_cmd_illegal,
> -        [15]        = sd_cmd_illegal,
> -        [26]        = sd_cmd_illegal,
> -        [52 ... 54] = sd_cmd_illegal,
>       },
>       .acmd = {
>           [41]        = spi_cmd_SEND_OP_COND,
> @@ -2162,15 +2156,10 @@ static const SDProto sd_proto_sd = {
>       .name = "SD",
>       .cmd = {
>           [0]         = sd_cmd_GO_IDLE_STATE,
> -        [1]         = sd_cmd_illegal,
>           [2]         = sd_cmd_ALL_SEND_CID,
>           [3]         = sd_cmd_SEND_RELATIVE_ADDR,
> -        [5]         = sd_cmd_illegal,
>           [19]        = sd_cmd_SEND_TUNING_BLOCK,
>           [23]        = sd_cmd_SET_BLOCK_COUNT,
> -        [52 ... 54] = sd_cmd_illegal,
> -        [58]        = sd_cmd_illegal,
> -        [59]        = sd_cmd_illegal,
>       },
>   };
>   


