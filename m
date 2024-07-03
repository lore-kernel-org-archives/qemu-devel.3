Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D999FC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0Xn-0006h6-Et; Wed, 03 Jul 2024 10:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sP0Xl-0006gH-7D; Wed, 03 Jul 2024 10:01:09 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sP0Xi-0003eJ-OV; Wed, 03 Jul 2024 10:01:08 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WDhJY5qM5z4wcJ;
 Thu,  4 Jul 2024 00:01:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDhJV2nKyz4wZx;
 Thu,  4 Jul 2024 00:00:58 +1000 (AEST)
Message-ID: <6dd6eab4-843a-44f8-80d5-4ba14b9bbbb9@kaod.org>
Date: Wed, 3 Jul 2024 16:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v46 4/5] hw/sd/sdcard: Introduce set_csd/set_cid handlers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240703134356.85972-1-philmd@linaro.org>
 <20240703134356.85972-5-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240703134356.85972-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
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
> In preparation of introducing eMMC support which have
> different CSD/CID structures, introduce a pair of handlers
> in SDCardClass.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/sd/sd.h | 2 ++
>   hw/sd/sd.c         | 7 +++++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index 29c76935a0..bfbc83c110 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -128,6 +128,8 @@ struct SDCardClass {
>       void (*enable)(SDState *sd, bool enable);
>       bool (*get_inserted)(SDState *sd);
>       bool (*get_readonly)(SDState *sd);
> +    void (*set_cid)(SDState *sd);
> +    void (*set_csd)(SDState *sd, uint64_t size);
>   
>       const struct SDProto *proto;
>   };
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 10f2764a53..d46be50760 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -689,6 +689,7 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
>   static void sd_reset(DeviceState *dev)
>   {
>       SDState *sd = SD_CARD(dev);
> +    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
>       uint64_t size;
>       uint64_t sect;
>   
> @@ -709,8 +710,8 @@ static void sd_reset(DeviceState *dev)
>       sd->size = size;
>       sd_set_ocr(sd);
>       sd_set_scr(sd);
> -    sd_set_cid(sd);
> -    sd_set_csd(sd, size);
> +    sc->set_cid(sd);
> +    sc->set_csd(sd, size);
>       sd_set_cardstatus(sd);
>       sd_set_sdstatus(sd);
>   
> @@ -2485,6 +2486,8 @@ static void sd_class_init(ObjectClass *klass, void *data)
>       sc->enable = sd_enable;
>       sc->get_inserted = sd_get_inserted;
>       sc->get_readonly = sd_get_readonly;
> +    sc->set_cid = sd_set_cid;
> +    sc->set_csd = sd_set_csd;
>       sc->proto = &sd_proto_sd;
>   }
>   


