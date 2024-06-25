Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF2FC3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7jH-000051-Pl; Tue, 25 Jun 2024 11:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM7jG-0008WK-3v
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:05:06 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM7jE-0005g1-2i
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:05:05 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52cdfb69724so3417924e87.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719327902; x=1719932702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3FhJcRjoxZaa4C2bk86UtDepdaKuxxoqEBhkQt60dlE=;
 b=J+JVmmfUC8yw/gYEkqCWhw4h0fWF+TF3bXVhZoVyM/eVXttobKViDHPCZi/RnNlHHE
 eAbkZW0Q/tvRDW2bVej4ebU4OmXFjDhiH886vPcVk8uHHAXpRDqaljMDKxuNt5b2vt9Y
 UHxRZLxCvyYZHtqNhiAwvIrXHK1aVtLgaOzzw3g4XUCC6OOoR6yK7GFUznp2QKt8uNg7
 xKyiTeeyZSljHrJEaaNGNMuMBmvoOWIlCrt0ty6Tff4oDJWjEm1XIXjDhFd+MqCw36zB
 OhDO6J/qVijoAtjxV1SsVCMzsPSq6o1GTj/Jaof5MbC6LmLVnx07BGovaqvppxjc2lgF
 Rezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719327902; x=1719932702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3FhJcRjoxZaa4C2bk86UtDepdaKuxxoqEBhkQt60dlE=;
 b=qoWla8kAl1VcXwk1b8O6BFydARmM1fzikQRtmG9+PfmhHUc1Z6nFFWI/FPcMvF1p5s
 2NCpNrK88x93+AEENtxBUnKZ4gm/ACtLaRCQe6wTnXL6D8J7UwIRJWzsHq3BPuXytIXR
 vUgnisF91oZczI4lu5xFMgmS3peAprenfTJt8deaYT8FJL6MOxqZ0JwjCXyxXnSehe08
 /Z6eKavetKeH8sN4bE9WwEKvY268UJEP2f3bZbFTh+d2707HO2/O4bvvXGJnKv3o+nKI
 4tt7hlk2VowgfYiYQNrLNdUzPuVhjKFHmlOq75T9+r9kDvzizXEGv7MtBnXzE2a4CXfT
 B5Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUSvco3PEE/3xDx8Hdgd1GnIDeAuToC+zyTHzkuNAvmi8zl8FI7ubEq3ptBooPbE1xww0e7AxLvcJPFHZc8/konKBCxzM=
X-Gm-Message-State: AOJu0YxaXSBFgQoGD1rVqSUUNZqyPfZEN8lVDxFtUgM3vng2hNNrTSgC
 YEYaTig9J4uwJSFOhc1gFOH/l5zO09+aXczqxRVzvd9pwXW7Z32l8le/W1/fTjk=
X-Google-Smtp-Source: AGHT+IFNeJhFYWfPGb9rygzRxlnu4YchagV7WaEQq7PPJg1bj4o0TFb2RlaRzqMHqtQnzydmqEAvgg==
X-Received: by 2002:a05:6512:3ef:b0:52d:582e:8093 with SMTP id
 2adb3069b0e04-52d582e817dmr117622e87.23.1719327901654; 
 Tue, 25 Jun 2024 08:05:01 -0700 (PDT)
Received: from [192.168.69.100] (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817a9f11sm172638885e9.18.2024.06.25.08.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 08:05:01 -0700 (PDT)
Message-ID: <1dd454c4-d7cd-4e8f-a824-e7743360b853@linaro.org>
Date: Tue, 25 Jun 2024 17:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/32] hw/sd: Add emmc_cmd_APP_CMD() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-19-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230703132509.2474225-19-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Cédric,

On 3/7/23 15:24, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/sd/sd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 5ff132139ea9..95cb46b87519 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2207,6 +2207,11 @@ static sd_rsp_type_t emmc_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
>       return sd_r2_i;
>   }
>   
> +static sd_rsp_type_t emmc_cmd_APP_CMD(SDState *sd, SDRequest req)
> +{
> +    return sd_r0;

Why are you returning R0? This is invalid, only R1 can be
returned by APP_CMD.

> +}
> +
>   static const SDProto sd_proto_emmc = {
>       .name = "eMMC",
>       .cmd = {
> @@ -2219,6 +2224,7 @@ static const SDProto sd_proto_emmc = {
>           [23]        = sd_cmd_SET_BLOCK_COUNT,
>           [41]        = sd_cmd_illegal,
>           [52 ... 54] = sd_cmd_illegal,
> +        [55]        = emmc_cmd_APP_CMD,
>           [58]        = sd_cmd_illegal,
>           [59]        = sd_cmd_illegal,
>       },


