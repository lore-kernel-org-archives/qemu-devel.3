Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27B1ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snia7-00044S-5F; Mon, 09 Sep 2024 13:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snia5-0003x9-QY
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:53:42 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snia4-000056-8q
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:53:41 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so507375566b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904419; x=1726509219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rk/B+o8bM64LQ2zN6Olk4GR5w1rhve390NIJauPKXfI=;
 b=LQBvQ6i1D0WbhQLjvs3uvuR2sq2vNCA3fJ5kz160jysGFAVGpABqLu0yzSWbmFtO1h
 uXY79OfuPIRkq3b3TcjqrrF4H2vacD0UPWEO/5i089jmfpVaEPY7wGKTsiZns2b2GZ9J
 a6L5PUnhn91Pkxns72l2fkel0/P7s4c05XqhY1pfXMWCHsrsxC4geo5ckXTk6dZMIlVQ
 FQw31Mm5QlBpvYx+8myFxwtgXlzwuSW15gviOMb323NuqWxCIIax8+FWFEk8ZB44MWg+
 GPBjARFYrVxKyHHLnfT0W47WZewBB1ir2Y1/Eb5M5fOrbD9e087oags38/9oYJuXzo6s
 cxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904419; x=1726509219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rk/B+o8bM64LQ2zN6Olk4GR5w1rhve390NIJauPKXfI=;
 b=KUiJRuxM8VhrPrT60U5R4bzEbELQQTa4vMvOhOV1GEQmDCDoxgrvSMSL6FCI8B/4ea
 Hv0bkDCfD9/UQQjMmJwMIoxiqdKqAocAcfpXH8s1P61G1oP/9jSe9H7xVNqMV3K7LZwJ
 oYhtu+DnC8n3nWUwhb71fTYASthIqClEgf6DV9Av/5jAzv8rhR2k/glyyiNz2eS8QUxs
 Z+vIctmrOGXe2sU9sktRkRki4WXQEAFUijKFPE5EwYX2omhq40jJgESD4e8WDVD3WWj3
 mYjifUrUep4He2nud7qSPawB2GYn+1siEJ/oq29v7tMA/9OKu2fqwTfFpSR3lJvIcI+y
 vXDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSpVmDvxGPLW+uSZwTCxnJ54oPgE7bp3UeNkjoCosXoNDoeY2BOUYx1pB9fsQYEfHCWWUJrmK9R9FZ@nongnu.org
X-Gm-Message-State: AOJu0Yy0+4VkI7jYR4eM9COoeNsjLo8lk7rP8Qy9b28SlSkgAB6+Z+FW
 L1juLRDLTfCLTV9nFV/bkA6Ms78YMbzqhgMDIRsnRTenKZXuuB8w9/Tuq5qti/Ub2XEPRvlexpw
 r
X-Google-Smtp-Source: AGHT+IFVYEF7yRbhRGTnaaA2aJ0qBnwtPWCBFohZTh6OXlLYviHBNRL+lG7jzLzd/aQAKP/k6TVZbw==
X-Received: by 2002:a17:907:60c9:b0:a8d:6921:e181 with SMTP id
 a640c23a62f3a-a8d6921e32dmr142794066b.16.1725904418529; 
 Mon, 09 Sep 2024 10:53:38 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d5dc8csm369435766b.206.2024.09.09.10.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:53:38 -0700 (PDT)
Message-ID: <b2c80cdb-f2e8-460b-8e34-19bf7a7790ad@linaro.org>
Date: Mon, 9 Sep 2024 19:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 42/53] hw/misc: Remove omap_sdrc device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-43-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-43-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> The omap_sdrc device is only in OMAP2, which we are removing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |   7 --
>   hw/misc/omap_sdrc.c   | 167 ------------------------------------------
>   hw/misc/meson.build   |   1 -
>   3 files changed, 175 deletions(-)
>   delete mode 100644 hw/misc/omap_sdrc.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

