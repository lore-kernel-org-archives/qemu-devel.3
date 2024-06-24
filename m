Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEF4C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLetp-0000kr-4n; Mon, 24 Jun 2024 04:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=voaC=N2=kaod.org=clg@ozlabs.org>)
 id 1sLetk-0000kM-6Q; Mon, 24 Jun 2024 04:18:00 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=voaC=N2=kaod.org=clg@ozlabs.org>)
 id 1sLeth-0002Dw-Qq; Mon, 24 Jun 2024 04:17:59 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W716g1Y99z4wqM;
 Mon, 24 Jun 2024 18:17:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W716c3TrFz4wbh;
 Mon, 24 Jun 2024 18:17:44 +1000 (AEST)
Message-ID: <a1896fdc-8a13-413d-9a6a-274330f3af03@kaod.org>
Date: Mon, 24 Jun 2024 10:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] hw/sd/sdcard: Accumulation of cleanups and fixes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=voaC=N2=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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
> Various SD card cleanups and fixes accumulated over
> the years. Various have been useful to help integrating
> eMMC support (which will come later).
> 
> Based-on: <20240621075607.17902-1-philmd@linaro.org> st24_be_p()
> 
> Philippe Mathieu-Daudé (23):
>    hw/sd/sdcard: Correct code indentation
>    hw/sd/sdcard: Rewrite sd_cmd_ALL_SEND_CID using switch case (CMD2)
>    hw/sd/sdcard: Fix typo in SEND_OP_COND command name
>    hw/sd/sdcard: Use HWBLOCK_SHIFT definition instead of magic values
>    hw/sd/sdcard: Use registerfield CSR::CURRENT_STATE definition
>    hw/sd/sdcard: Use Load/Store API to fill some CID/CSD registers
>    hw/sd/sdcard: Remove ACMD6 handler for SPI mode
>    hw/sd/sdcard: Remove explicit entries for illegal commands
>    hw/sd/sdcard: Generate random RCA value
>    hw/sd/sdcard: Track last command used to help logging
>    hw/sd/sdcard: Trace update of block count (CMD23)
>    hw/sd/sdcard: Trace block offset in READ/WRITE data accesses
>    hw/sd/sdcard: Have cmd_valid_while_locked() return a boolean value
>    hw/sd/sdcard: Factor sd_req_get_rca() method out
>    hw/sd/sdcard: Only call sd_req_get_rca() where RCA is used
>    hw/sd/sdcard: Factor sd_req_get_address() method out
>    hw/sd/sdcard: Only call sd_req_get_address() where address is used
>    hw/sd/sdcard: Add sd_invalid_mode_for_cmd to report invalid mode
>      switch
>    hw/sd/sdcard: Inline BLK_READ_BLOCK / BLK_WRITE_BLOCK macros
>    hw/sd/sdcard: Add comments around registers and commands
>    hw/sd/sdcard: Do not store vendor data on block drive (CMD56)
>    hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
>    hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first (ACMD22)
> 
>   hw/sd/sd.c             | 278 +++++++++++++++++++++++------------------
>   hw/sd/sdmmc-internal.c |   2 +-
>   hw/sd/trace-events     |   7 +-
>   3 files changed, 159 insertions(+), 128 deletions(-)
> 


Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



