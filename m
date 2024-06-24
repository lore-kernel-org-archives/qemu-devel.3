Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C79C3064D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjTP-0006mH-9m; Mon, 24 Jun 2024 09:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjTN-0006kw-3h
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:11:05 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjTK-000405-9S
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:11:04 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ec002caeb3so55419601fa.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234660; x=1719839460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ca/j5lYq2nn8e1I6CyXYK+okG+eIPRXYPxMcR6xeFjo=;
 b=zRL7k6qYx0Nj9cw/DJcOe0WMQDefFF5d8usHmzalwUPnzKbn/9b35Bzz2GyoZxN+pB
 I9PjOQZXcFFucqq8BgO2mdyO+XvlvbtXpE5uaii2HJRAhP9Lx3SYWuwvIvzZCtkZ0F+4
 IM7Pcs1/Y7kWtAV87WmIoN3tdoHZi6r2tcBMZ4+JLp6Fxgskzof9dsGCNl9TsW5DXrhr
 jXUCRnc8fR5RiFiXRLYEJdvwTozMXTKYYQ2EH4n0xZy50XwakyjKWnOBpTmX0DLwvC9C
 2wusccGzBbjPCA3FjegzecpC/7MFH+aQfOAibE5HHjnMEGVeOwsARDtKqTYoNSpgYcUS
 WSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234660; x=1719839460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ca/j5lYq2nn8e1I6CyXYK+okG+eIPRXYPxMcR6xeFjo=;
 b=FANoAYIa56fDSX+ouAtupqr0b9V2jmSNJHx+YZjYt2pCEskvxGmrykpOrpyFtCht1n
 W7vjsOkfAty1zrIq/VmmKUWhAoY6Ey9uOEk7HbaLo9aK0RYb6x19hRDNUi4tiItO3eEb
 A7HR2Pb77B5upTAkqAzzuwRRVG5Bk13j+PMwLbw7M6gizFl0fsimySo0i8B/UkGDbbs6
 zpjCPLC6uHjmkMGe1B/9hPeWyesaSDUl6NRWfZYgTSgqANlmnm2TdpDN0IJPygqSq7vn
 X60Iu6kSzYoEWKmU2N4j5rvUhbL/IaGtUkaNn7w86KZNHWXklsU1GBeV+LKqGIIUW1+C
 njjg==
X-Gm-Message-State: AOJu0YzvTKK0F/jDb9J2kZAOmlO+kQW6QMYxJHaEay45tmI+8T/8JCB0
 a0a5QEgFLEIxwQrO5CYKuvRLNHytEx0E1BaDKslQraZp/5HNht4gtVed2JcxpSCAPH6kneivY2l
 B
X-Google-Smtp-Source: AGHT+IHqRaMklYkGg06LPTWSk+XohDEv/k+pAVZ25lTr8pZTYZbj/vF8frY9PFer8gEFvBgxSRoCpg==
X-Received: by 2002:ac2:456b:0:b0:52c:df6e:9517 with SMTP id
 2adb3069b0e04-52cdf7e66dfmr3173083e87.11.1719234659691; 
 Mon, 24 Jun 2024 06:10:59 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481922428sm130529895e9.43.2024.06.24.06.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 06:10:59 -0700 (PDT)
Message-ID: <f87db622-f6c9-4f13-b285-ddb4ea38a1c5@linaro.org>
Date: Mon, 24 Jun 2024 15:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] hw/sd/sdcard: Accumulation of cleanups and fixes
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 21/6/24 10:05, Philippe Mathieu-Daudé wrote:
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

>    hw/sd/sdcard: Have cmd_valid_while_locked() return a boolean value
>    hw/sd/sdcard: Factor sd_req_get_rca() method out
>    hw/sd/sdcard: Only call sd_req_get_rca() where RCA is used
>    hw/sd/sdcard: Factor sd_req_get_address() method out
>    hw/sd/sdcard: Only call sd_req_get_address() where address is used
>    hw/sd/sdcard: Add sd_invalid_mode_for_cmd to report invalid mode
>      switch
>    hw/sd/sdcard: Inline BLK_READ_BLOCK / BLK_WRITE_BLOCK macros
>    hw/sd/sdcard: Add comments around registers and commands

Patches 1-8, 13-20 queued.


