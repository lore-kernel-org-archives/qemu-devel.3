Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E90C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMQT-0008UL-77; Wed, 13 Mar 2024 07:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMQ9-0008D4-4C
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:05:20 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMQ5-0000Ye-Iw
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:05:15 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-513c1a82b30so1841535e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327912; x=1710932712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p57XbAcFRojEylFXWn7yt3dKJGEyIA0bh+cWlBluBV8=;
 b=ANyPa3wVkRJ2rvEgd6oI0eD3/a+PdJSrzoEyfRsBTf8Yt/TPhKUd3qRIq3+OHK5ipE
 hx1Iz0EzbtS63BdYDqGrnMpOdz4KufrXZihkyxMKsWsFMTgm2Hpkm9q8fp4/BB6zag14
 MkGiSSN4X7Ogq4yGjsu8VjIWHqRCfh5AopYEU9tXISdLc0W1cY5m+sMEKcJW5SnJg8xm
 5oxl5KvCouaBof1qGkO3YIanhr6ndYxFmcDEZHmmY6suIKg2j11BDXg/AJCf1f6tQvGi
 q2GqFJZtr8jTlo4FLBfubtRFlwpM7LMdeUfp29oiEQiuAbciP7OYcGCqykhN5ghfHp7O
 kngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327912; x=1710932712;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p57XbAcFRojEylFXWn7yt3dKJGEyIA0bh+cWlBluBV8=;
 b=LsEQqoqwoVr23Ko0l5hfh4ncjifbDU6uu+aI6aIa7LxKFKvX8rQIPKvdvTc2GaqxZf
 SvnAEMr8xvvL9im+3lWgeoLCWA7DUBDopYvmba1aUBQcMTA3OLHofSBUls9z5/cJANid
 xvNCJbbJY3mgTGQRTudh/2aVsLsZEcR9NBsbkZtozDPcMSHyVmQF0bF36wNiCF8PvmqR
 Sm0qS3J8BKzJAOiHBz2+Q641ILTxaNHwuJYh0MgOBgcQqiHXE3sLGvEb6FHPhuZO4nr8
 8bgssn9Nrc3lgaSgH98uaoiHym8qaqYxUT/i5QC7l+1KF7CW8q8lGNn73wm9t8uSGrd/
 b8gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB3C/N6LUIhUw0NCUMRfjNreekCS71DAiyxFXBqGerzRzsuvoy/tx/r9zaKur+h6fixdZNn74dNsxpvcz8PNLVqIvyULU=
X-Gm-Message-State: AOJu0Yz/URw++A4Yr0axPT/AwHo3Sh7XJ6iQBbywXJ0SqVgjpmkKfRq8
 ElUCQ/s922Pmi+1uK2mkASXvKxQXG0s8EOnWXFcuHqNNe/NPN2emVWWV0VgJa/s=
X-Google-Smtp-Source: AGHT+IFUJ+PCvM+vLZJDS1LB/UAPH5pQGu/zPJHPZznIe0uklEqzYUpl+MGFnv3qLj8B3FrWe9DAjw==
X-Received: by 2002:ac2:5457:0:b0:513:c9ea:67 with SMTP id
 d23-20020ac25457000000b00513c9ea0067mr749482lfn.24.1710327911696; 
 Wed, 13 Mar 2024 04:05:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a05600c470f00b004128fa77216sm2004694wmo.1.2024.03.13.04.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 04:05:11 -0700 (PDT)
Message-ID: <6a9cf3bc-57d3-4fbd-8a62-fd607cf24a23@linaro.org>
Date: Wed, 13 Mar 2024 12:05:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] esp.c: ensure esp_pdma_write() always calls
 esp_fifo_push()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-16-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-16-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 13/3/24 09:58, Mark Cave-Ayland wrote:
> This ensures that esp_update_drq() is called via esp_fifo_push() whenever the
> host uses PDMA to transfer data to a SCSI device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



