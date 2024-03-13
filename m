Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6D3C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMIQ-0008Fh-9o; Wed, 13 Mar 2024 06:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMIB-0007sJ-Rz
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:57:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMIA-0007PJ-5m
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:57:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4133100bccdso13158245e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327420; x=1710932220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uI+qRwlVDIo9kSWXVEYpTLUYDOqEaVIDLp1wmMxJwfE=;
 b=e5pMhoczBdQf4LasUWeQtj7NJYVWv3G1olc92nQ9QpPIGL4o38sU/Qkds0AnNjeNDp
 Xz9T064n0Z0lse5zEWtlsmr+NHiheBGtMs08XoOtPUrKVRakOOwCqe84QDy5Cf8g825z
 cjijQ7iPqAbhfl7ELFf60MbYk+nXFbwWtHjG6jGNsdYtXyr+mSNWMGnIRfF2Kv0lt6Gx
 zOvHOCKM8b60pCtk/JUqLSWO2dFkvQQ7yxEfDreOSvNLTvHtWhESHmlLkEGmr+eG3Vpk
 Be5QZuDFGJp52mHgXRTIrwXNZdpTna0oKtP7FYPo8IHls+TQ///hYuaqC/9g40i4dlmT
 cAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327420; x=1710932220;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uI+qRwlVDIo9kSWXVEYpTLUYDOqEaVIDLp1wmMxJwfE=;
 b=OokVc2GWCfAdql2vEd5I92AH6AX3c3Iu4UnlT1vvCEdBqIGFmluSEPl/Iht19HWPWJ
 MDBC+S470ByWTi5nlxsCPxdiNLsvSQpp4U03bxENo8EuWv2ZWegVgRMih0G/A+ow17OR
 dOl0nkFzPmYo+t0IbE30DpgcMbW2xISAkPkmgbOtVohTc07eUzb62PjvLi/bloREERlD
 nTXyiXI2Ru/wzW/2wDWbZcFnmPql18ZymWZ0rHFWlOQ4V+aQuT71z4IWH1yioNmf2uH9
 U48UPdTQaNi655gG+PumRYJe+Y70GgiGkFmzGR4es0cyQYOPZFH6FvYucWFMN4aPWvVt
 RTMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaEcnI/Z2vmclxGVikMru0ZGdhAeYx038fiYkPHHQOL+kxQSvxqFu6nVM34cXmBfzLIIqVgVWaKTkwwBLsArrl/DmoEyc=
X-Gm-Message-State: AOJu0YweuTy62pW2qjjQL6ZT3pbzHhgEBXT/Fpe5putut/C0ybjTQSvn
 h5bjydf5fvcsH0GlZrQAZeTO0LFRWteavog4IM/2YPS1ynmoDNUX6YhklPm1gAs=
X-Google-Smtp-Source: AGHT+IHjkhUJeMDysgNCo7j4PO35FLxnpKhdduZ/qqK9GowDpy0b0QtiSJG+mczz4Xy9ONVZIaXz8w==
X-Received: by 2002:a05:600c:4ecf:b0:413:1713:864 with SMTP id
 g15-20020a05600c4ecf00b0041317130864mr9799498wmq.33.1710327420299; 
 Wed, 13 Mar 2024 03:57:00 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b00412cfdc41f7sm1441780wms.0.2024.03.13.03.56.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:56:59 -0700 (PDT)
Message-ID: <6fb74b0f-2059-4490-9215-f0c7baca0ce0@linaro.org>
Date: Wed, 13 Mar 2024 11:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] esp.c: introduce esp_fifo_push_buf() function
 for pushing to the FIFO
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-9-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
> Instead of pushing data into the FIFO directly with fifo8_push_all(), add a new
> esp_fifo_push_buf() function and use it accordingly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



