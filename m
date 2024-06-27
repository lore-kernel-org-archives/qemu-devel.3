Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE1AC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 07:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMjyb-0002Q4-KT; Thu, 27 Jun 2024 03:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sMjyY-0002OZ-6W
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sMjyW-0006KK-Jn
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719474924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UFVi7tIqCJqUt6Few8J4eFOWvmS86O+fOV8zgeVLXg=;
 b=YC2Bd7/NEG7z8v76exJYAnKoiUe97cvrG7WOP4TqS1pe+o/QpMAfEPPux+NeHP+u/FYmP4
 yXUgLPhpOioLGd/+fJBGlhj1q6AfSUO+sXt8RjKH5Qkjiib5ceIrJ8yoZABYEmGk/ipeXy
 0GZQTMdXIHataYQ7IwGW727wwcBzXQ8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-bVikkcAHPYmiPD15UrQY4A-1; Thu, 27 Jun 2024 03:55:17 -0400
X-MC-Unique: bVikkcAHPYmiPD15UrQY4A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52cdbeaafcdso4348690e87.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 00:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719474916; x=1720079716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8UFVi7tIqCJqUt6Few8J4eFOWvmS86O+fOV8zgeVLXg=;
 b=EPvZmj7YyX8Uc/Mbjf6GLDCMUIQSKcXRFsVA97W+j3NFbDgctUrGkqP127zcE75Yzk
 HV1xnVqwFy9wdsgM2vkeL2ioCrHZC1gDPNFV7QmGolMjyEpwgV7HYdsYiVHoMRdMbPmS
 eRAg7EC45aooBK3XCazavwebWsGTsfudTxyS1VNZL3QW4BV/maIiXW8yI5SqTbSe2+xn
 Zwg+/9wswFfYL29e1Vms45y4fR9G0FS4it7Hc8Ajc34XGcr9+Cq7ZNWBETOAMcgggcBY
 0E0sJWU9jvxVWvCTzTyDMkkK5WVsdRLfqfq9C1bKt6lB7lJ5LkkvZnCz2936vaQyDXsC
 AboQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpL2G+BJov7iLEZvWE2NranwP/jWYDjexfJ7PUQdyNUMJXsA7ZGqh/u4rBlUqamXyV/yQdKFtOkiOK01xPGRyeHou7iQ8=
X-Gm-Message-State: AOJu0Yzo94WN6B6vMujhJE91F8ht9A6glJHNyhSCfefcDBJ+WrCbJPR9
 GFtd2OJl98BCOayddistSttU9PzHA8dAt3yNPpmcLkD012YjY57OoOplIMNElZvwDse/1DWy9Mv
 OTfWBwHqbT2nJc5yxvfl9Nwis81aT+sxShK/8TTkxALneGzMTwfiG
X-Received: by 2002:a05:6512:2394:b0:52c:d84c:1182 with SMTP id
 2adb3069b0e04-52ce1862c12mr9324588e87.64.1719474916123; 
 Thu, 27 Jun 2024 00:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxRCvwykpGaRMc6oIeC3Flb7jSfbQzZQOJDefdOdbYRFxVZyR4vQTRj9A8ayHFOIfTw4sEOg==
X-Received: by 2002:a05:6512:2394:b0:52c:d84c:1182 with SMTP id
 2adb3069b0e04-52ce1862c12mr9324575e87.64.1719474915798; 
 Thu, 27 Jun 2024 00:55:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8245da9sm52854285e9.1.2024.06.27.00.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 00:55:15 -0700 (PDT)
Message-ID: <9fde994b-8f1a-44b0-b491-18dcb553c2cf@redhat.com>
Date: Thu, 27 Jun 2024 09:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/sd/sdcard: Use spec v3.01 by default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 devel@lists.libvirt.org, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
References: <20240627071040.36190-1-philmd@linaro.org>
 <20240627071040.36190-3-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240627071040.36190-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/27/24 9:10 AM, Philippe Mathieu-Daudé wrote:
> Recent SDHCI expect cards to support the v3.01 spec
> to negociate lower I/O voltage. Select it by default.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

	
> ---
>   hw/sd/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a48010cfc1..d0a1d5db18 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2280,7 +2280,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
>   
>   static Property sd_properties[] = {
>       DEFINE_PROP_UINT8("spec_version", SDState,
> -                      spec_version, SD_PHY_SPECv2_00_VERS),
> +                      spec_version, SD_PHY_SPECv3_01_VERS),
>       DEFINE_PROP_DRIVE("drive", SDState, blk),
>       /* We do not model the chip select pin, so allow the board to select
>        * whether card should be in SSI or MMC/SD mode.  It is also up to the


