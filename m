Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D40FC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGY9K-0003KM-Ni; Mon, 10 Jun 2024 02:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGY9I-0003Ja-Fc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:04:56 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGY9F-0000nj-Tw
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:04:55 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52bc27cfb14so2852516e87.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717999491; x=1718604291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mz5HlpAGy/kiQYJ3EPXYuRg/Ok6CveWjBpoGnYhVKsc=;
 b=DWmapxjgPhWmiMSSTRDZsqrro0d/wsJ5Re8URq0C3UdPsNdHY6l88ou1gq723xIZsn
 yi1eCtLzAx7Os02IClYe9Zg4F3oNZSEtv62KBUgNQaDq7Rzc6swN5DJe3s9XKHOH7f0O
 qYD7h15Nu3wiBReiOcl4Au1yPTxx2ldC9wG0oxW6+mhqYlzHfiRj55+hO+HUK2085AM/
 BC/Du6eiCLz73GfKQqKIiLwl5nj0mz3n0QzLVaalmiSWxu/oJ1gOfjOrl8MZnkeD1bsK
 YzhMnbfJrITL3dOWJVFEpNLHT/JzirdVbnePq7VDKxfezjb9xJiK+9rU0UhbN4E2cdwd
 VrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717999491; x=1718604291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mz5HlpAGy/kiQYJ3EPXYuRg/Ok6CveWjBpoGnYhVKsc=;
 b=dlxsxw3TaLXznv8AeRafYDiTnqFACRf0Mg9f0JlYIyGzm0m/peuRD3Kb/f7XploTES
 7bzGPjjn5D4rsM/hxTfgq+pEzjZ/CJoBdm8xvtJvlpD9s4RBWDXBGGO4U857jXJWcN5y
 KUtY3sB9zEWnEktGPL0upGkXXZ0qXTUSe1q7DQ2s9qa2ilOUFZ+B+nWsWJikSDLx0OOD
 ZNpsie+PpOfpAiVDAKG4hP4X1cM6imA8fAWoCKkBUBspoRMoKK6/dVSF5l9ZJcMdptvu
 K455WcXGZrcjOxZBSclp4EHyv2oPXdYTSyE89s/BXeBJPW2C+F6Ra6q4nfG+bxRBRXJz
 NcDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV+Pus4Pu/EoHu/8sqWbJOlP8m4lD4pEpLkFe9vQVCdVBB3b/0qwN34IuxJexbj83gNmCacxxkvkE4SnicSHxsifPWNO0=
X-Gm-Message-State: AOJu0YxLZiZjAkVeV0IpyXulKRbt7RRtka+fxdiSu3NOBSBqDDlZUJVQ
 lE/PXow8m0P/IcTOArkq247L0yswuCgpkXvfxsqQUvx4qi6cbsUl4gmBt94/eiU=
X-Google-Smtp-Source: AGHT+IE3DPW091Zobqtg9U9ontLqU++rU/wgCOjZ3OZdOTVeC9Xfbc7cRLyG3FaUYUO89fGuAGBKyw==
X-Received: by 2002:a19:8c42:0:b0:52c:7fbf:39f6 with SMTP id
 2adb3069b0e04-52c7fbf3b15mr3517744e87.26.1717999490722; 
 Sun, 09 Jun 2024 23:04:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1d8369casm119024066b.225.2024.06.09.23.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 23:04:50 -0700 (PDT)
Message-ID: <f04c5b61-2e73-4029-a614-a9c7686ec46d@linaro.org>
Date: Mon, 10 Jun 2024 08:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Fix IRQ/FIQ routing
To: Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240610052906.4432-1-sebastian.huber@embedded-brains.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240610052906.4432-1-sebastian.huber@embedded-brains.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 10/6/24 07:29, Sebastian Huber wrote:
> Fix the system bus interrupt line to CPU core assignment.
> 
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> ---
>   hw/arm/xilinx_zynq.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


