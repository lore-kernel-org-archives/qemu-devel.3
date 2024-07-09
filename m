Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748FCC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 16:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRDWk-00083j-B8; Tue, 09 Jul 2024 12:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRDWj-00082e-1G
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:17:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRDWg-0007uU-Ft
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:17:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4255fa23f7bso36297655e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720541829; x=1721146629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e5jTu8m0he4wvkUxHZKFE/0Z/w0sL1L0Ak74Z3qeqEw=;
 b=LLJI9e5VSZ4p866fw3yP9+qf0z9nOPjJoAC51Bpy4lpbTXZCV/UbeojyoL4sfJJmGo
 N+6+3C908/TFHChf7axgqOIZj4MmpR2RRTIXzSpTSDbbWxGSUDahFtGnvfIHj8/7C5dP
 ZDKUkFU0Pd8WMY7vROgsx9IVgSkr+S7jrVVk/FiDZ6zdPlmtvUcG800tGwKh6qfcVGTm
 khg4r5eX6iG8AgF0FIp78jiYh9yC9ncNPVqESASg6ybRLtcM8wsFfNyeqYqaHnXEyl3F
 e5Y2YjRg+XtUn+poYNuXVTyhrIgb76hnJKHzJd4gUyRYItuCuF0g67eu72Apyu+1hN/L
 KCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720541829; x=1721146629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e5jTu8m0he4wvkUxHZKFE/0Z/w0sL1L0Ak74Z3qeqEw=;
 b=nI7pRN860dvST0Oker6wYDJtO+/VSTM0HmjZW3/aM28ft8h3K3y8Hz2a4d72fEoJ0y
 zfMWOvc8toE5FluWISKhf8oVS3TycYOD8GyCuiZoucBGzTbeMi+/HfOWoS4PdNTCqE4i
 AGJU6k6HDqBTuNcQopfch7wM13dkpcBuhXDgPa3+4251KG8j64ucT4Kh0d3T4zy09Z66
 08lvpIXB7UjzwgsDRAe0gM6RFte25AUUlI/orOt1R65ed0hVlOmeIviwQIQN7BoT3ypH
 WAIdL279QZ4yZT/aUDcseKGDprRFfaWwb0yY4rhO6dtitsSNJIF1BnX6y+5pLqn7ednU
 cXLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRp9un07ToNO1ts2OiBQxWg8ISlCoLRLrh5F3JyvyETZkvdQrK/bWIuCZBFs9Q9xp1t5FGKG0nqcejqHWhHhR8PFZfNDU=
X-Gm-Message-State: AOJu0YzOuuNC3e+OqhhPco2KRn/7wFL5jSE8E98ZxZZV34AE3KEHxcAe
 WhAcx5+sAQt/CIzu3DKSMVO+BLf3GuqA3IAofLhN8oRal/7iryraHfiaovUCBIw=
X-Google-Smtp-Source: AGHT+IGEyZjYei068C9llvS82EqYyXF0+q97v0XgVw+pEzxbSkCVIAwtrMlbU548MEPsk21o2UkciQ==
X-Received: by 2002:a5d:5f48:0:b0:35f:1161:e1a3 with SMTP id
 ffacd0b85a97d-367cea46c6fmr2547807f8f.5.1720541828863; 
 Tue, 09 Jul 2024 09:17:08 -0700 (PDT)
Received: from [192.168.69.100] (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde891cesm2975832f8f.62.2024.07.09.09.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 09:17:08 -0700 (PDT)
Message-ID: <75a83c4f-aaad-462b-bf99-8bf3aef00d93@linaro.org>
Date: Tue, 9 Jul 2024 18:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Aspeed PATCH v47 18/19] hw/sd/sdcard: Add boot config support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
References: <20240709152556.52896-1-philmd@linaro.org>
 <20240709152556.52896-19-philmd@linaro.org>
 <77788eda-ee5c-4db0-a890-034dc4995502@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <77788eda-ee5c-4db0-a890-034dc4995502@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 9/7/24 17:52, Cédric Le Goater wrote:
> On 7/9/24 5:25 PM, Philippe Mathieu-Daudé wrote:
>> From: Joel Stanley <joel@jms.id.au>
>>
>> With this correctly set we can use the enable bit to detect if
>> partition support is enabled.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Also squash?
> 
> where is the "boot-config" property gone ?

Replaced by patch #15 "Implement eMMC 'boot-mode'".

