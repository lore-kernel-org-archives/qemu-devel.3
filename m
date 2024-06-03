Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9CFC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6ql-0006kA-Eo; Mon, 03 Jun 2024 08:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6qj-0006jA-6e
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:31:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6qg-0005oL-MU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:31:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4212e341818so26499085e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717417896; x=1718022696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v62fg0IW1E0zSoDurmI/bumQF315vReASG+SxApwuI4=;
 b=L4TGI1VN2HIcs8MKgYRRX7HdRFh/qFlmPZqbqTFPpDvutuMDYpfYc6eR9MoqWV4O75
 HuXxgy6/wKfm+52GhKLraIkztPpTjRtDl7cyYXD1RuvzgvnqzHhKpzORKEOZ8iT2EBQW
 aV9r4UDfYDW+rmSurm7IfEVpBvLcwstf7QTl8ic7BMX3OWSm3eA6yBOX4aB+Wc6SzAMY
 W+vvP66tYpqMWB9N5FzWPoFVN3CeYxX5pSMLCmlYfJk5VgFqnrYqu/wWZJyuNr5AgZTb
 gFMR2EDSs+1tB6oh4j64H3tIAmwu0Sarp1k5zOvZ5nuxKGb+h8LQ59h1cL2xqLfBWcmi
 fORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717417896; x=1718022696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v62fg0IW1E0zSoDurmI/bumQF315vReASG+SxApwuI4=;
 b=JJxXv1HfXyLDJAmX8BurBJ/M+jM7UABy5gD9zlO/SOfCkPTNehJ/0C0Y1Bo2p1aebC
 jPUdpxCy7wCkCy1N3nN/v9dB12JxbsHH30aI0MkMMQ6PcAVzFjvlCzbwdIIsrdgOAR9V
 Pr0mecZBxOQEMlYbnUUypERobk0wbxiDDg8+qXUN8VAcYJCsfdGQXgLRlhXKHVzjGCsW
 9BYC+P3TXlEb/yUQ7hL19aEFWrDsK3JrFh3ktPFtC0GyBJnNx2clhXumQn1AFyEXgTta
 8617vHfKU++UcIHPlxpcTe564FVDgmY6uxk2m/rGqYEHOxA8oEPUZrQ9g+08UE/z4DgM
 x63g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2pGp9nkvKEj6n4JcvLQuQo5c7ZM4i7t/KTtyK5nNXMDtl4ijx2BSWgGeyfsVSTNDH5cxi7XMrPOraobt9371IVnn6P6o=
X-Gm-Message-State: AOJu0YyemMnbG1f9t3IB3qmahVO35/b4Rp6UoHHAme+emPkHeLTpNp7Y
 Sm1Lf7L7zO/vznEs7A7COgoexxJQq3hsqG8oAhoRqq0QShMF0peaNcUfnu0telk=
X-Google-Smtp-Source: AGHT+IHupWwGXoYWqDr69eEzLigI6PabZG+iiRufV3gITyYF6faPKchFs16YvKIchxriKmHLeL6MWg==
X-Received: by 2002:a05:600c:1550:b0:421:2ac2:d7c8 with SMTP id
 5b1f17b1804b1-4212e0622afmr77305295e9.18.1717417895791; 
 Mon, 03 Jun 2024 05:31:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42132471e01sm102781015e9.13.2024.06.03.05.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:31:35 -0700 (PDT)
Message-ID: <29f32aca-74d0-4562-bffa-4573124812bf@linaro.org>
Date: Mon, 3 Jun 2024 14:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/32] hw/sd: Subtract bootarea size from blk
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-25-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230703132509.2474225-25-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/7/23 15:25, Cédric Le Goater wrote:
> From: Joel Stanley <joel@jms.id.au>
> 
> The userdata size is derived from the file the user passes on the
> command line, but we must take into account the boot areas.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/sd/sd.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 6da17a8d0972..1df7c7ac9dae 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -674,6 +674,7 @@ static unsigned sd_boot_capacity_bytes(SDState *sd)
>   static void sd_reset(DeviceState *dev)
>   {
>       SDState *sd = SD_CARD(dev);
> +    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
>       uint64_t size;
>       uint64_t sect;
>   
> @@ -685,6 +686,10 @@ static void sd_reset(DeviceState *dev)
>       }
>       size = sect << 9;
>   
> +    if (sc->bootpart_offset) {
> +        size -= sd_boot_capacity_bytes(sd) * 2;

IMO this patch and sd_boot_capacity_bytes() definition
from previous patch should be squashed in patch 22 where
you add emmc_cmd_SEND_EXT_CSD.

> +    }
> +
>       sect = sd_addr_to_wpnum(size) + 1;
>   
>       sd->state = sd_idle_state;


