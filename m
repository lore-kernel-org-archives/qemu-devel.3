Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C12C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6cb-0006Hk-8X; Fri, 28 Jun 2024 04:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6cT-00068m-PD
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:06:10 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6cS-0007c7-2E
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:06:09 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SgL0fzRz4wb7;
 Fri, 28 Jun 2024 18:06:06 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SgK0TGVz4w2N;
 Fri, 28 Jun 2024 18:06:04 +1000 (AEST)
Message-ID: <8414a12f-ca85-4794-95fd-4e11dde82435@kaod.org>
Date: Fri, 28 Jun 2024 10:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v42 80/98] hw/sd/sdcard: Introduce set_csd/set_cid
 handlers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-81-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-81-philmd@linaro.org>
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
> index c1a35ab420..0d6d9e452b 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -127,6 +127,8 @@ struct SDCardClass {
>       void (*enable)(SDState *sd, bool enable);
>       bool (*get_inserted)(SDState *sd);
>       bool (*get_readonly)(SDState *sd);
> +    void (*set_cid)(SDState *sd);
> +    void (*set_csd)(SDState *sd, uint64_t size);
>   
>       const struct SDProto *proto;
>   };
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a0da06e017..b0ef252001 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -671,6 +671,7 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
>   static void sd_reset(DeviceState *dev)
>   {
>       SDState *sd = SD_CARD(dev);
> +    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
>       uint64_t size;
>       uint64_t sect;
>   
> @@ -691,8 +692,8 @@ static void sd_reset(DeviceState *dev)
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
> @@ -2472,6 +2473,8 @@ static void sd_class_init(ObjectClass *klass, void *data)
>       sc->enable = sd_enable;
>       sc->get_inserted = sd_get_inserted;
>       sc->get_readonly = sd_get_readonly;
> +    sc->set_cid = sd_set_cid;
> +    sc->set_csd = sd_set_csd;
>       sc->proto = &sd_proto_sd;
>   }
>   


