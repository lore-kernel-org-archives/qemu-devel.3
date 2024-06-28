Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9097EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 06:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5OG-0005Li-6z; Fri, 28 Jun 2024 02:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN5OA-0005Kl-NW; Fri, 28 Jun 2024 02:47:21 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN5O8-0007aI-HF; Fri, 28 Jun 2024 02:47:18 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Qw72x2Wz4wcg;
 Fri, 28 Jun 2024 16:47:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Qw30XvCz4w2K;
 Fri, 28 Jun 2024 16:46:58 +1000 (AEST)
Message-ID: <fcd13412-906d-49c3-b892-33ca49fc0f5e@kaod.org>
Date: Fri, 28 Jun 2024 08:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] hw/sd: Add support for eMMC cards
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
References: <20240627171059.84349-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
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

On 6/27/24 7:10 PM, Philippe Mathieu-Daudé wrote:
> Trying to land what Vincent Palatin started 13 years ago!
> https://lore.kernel.org/qemu-devel/1311635951-11047-5-git-send-email-vpalatin@chromium.org/
> with fixes from Sai, Joel and Cédric.
> 
> I reviewed Cédric patches but still plan to review the EXT_CSD
> layout and Joel "boot config" patches.
> 
> In order to avoid deviation with the spec, the experimental
> 'x-aspeed-emmc-kludge' property is used.

Adding Aspeed people for feedback.


Thanks,

C.



> 
> Based-on: <20240627164815.82606-1-philmd@linaro.org>
> 
> Full series for testing:
> https://gitlab.com/philmd/qemu/-/tags/emmc-v4
> 
> Including Aspeed branch from Cédric on top (aspeed-9.1):
> https://gitlab.com/philmd/qemu/-/tags/aspeed_emmc-v4
> 
> Cédric Le Goater (5):
>    hw/sd/sdcard: Basis for eMMC support
>    hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR() handler
>    hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument on eMMC (CMD23)
>    hw/sd/sdcard: Adapt sd_cmd_ALL_SEND_CID handler for eMMC (CMD2)
>    hw/sd/sdcard: Adapt sd_cmd_APP_CMD handler for eMMC (CMD55)
> 
> Joel Stanley (3):
>    hw/sd/sdcard: Support boot area in emmc image
>    hw/sd/sdcard: Subtract bootarea size from blk
>    hw/sd/sdcard: Add boot config support
> 
> Luc Michel (1):
>    hw/sd/sdcard: Implement eMMC sleep state (CMD5)
> 
> Philippe Mathieu-Daudé (6):
>    hw/sd/sdcard: Introduce set_csd/set_cid handlers
>    hw/sd/sdcard: Cover more SDCardStates
>    hw/sd/sdcard: Register generic command handlers
>    hw/sd/sdcard: Register unimplemented command handlers
>    hw/sd/sdcard: Add mmc_cmd_PROGRAM_CID handler (CMD26)
>    hw/sd/sdcard: Add experimental 'x-aspeed-emmc-kludge' property
> 
> Sai Pavan Boddu (3):
>    hw/sd/sdcard: Add emmc_cmd_SEND_OP_COND handler (CMD1)
>    hw/sd/sdcard: add emmc_cmd_SEND_TUNING_BLOCK handler (CMD21)
>    hw/sd/sdcard: Add mmc SWITCH function support (CMD6)
> 
> Vincent Palatin (1):
>    hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler (CMD8)
> 
>   hw/sd/sdmmc-internal.h |   3 +
>   include/hw/sd/sd.h     |   6 +
>   hw/sd/sd.c             | 419 ++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 420 insertions(+), 8 deletions(-)
> 


