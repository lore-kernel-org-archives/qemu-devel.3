Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8067FC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhl0l-0005O3-EN; Wed, 06 Mar 2024 01:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhl0X-0005Lw-QN
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:44:07 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhl0V-0001CH-Bw
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:44:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412ea23a750so2830935e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709707442; x=1710312242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5N1nMGTNPxy9yu6PsxH4PAoHsefXw6NPGooODUAcpbs=;
 b=x/ijfWd6YxLhW+TczPgYjvpYeIZCqQGIpNBUKuRRmUNNQpBHEqm+oAk22ydec07aT5
 oAaw8eEy/JBKLb8FJx1cb5fma7HTifnstDbSlzuQw3YoDz6JZE7kbTMRLoCroQRB7SLB
 VTFl7Hcp4n9HUE3QrXFlcZzzbTWosbG+x1zKO1LyFBKAMBk55SF1tCv+6B7z/zMirYLX
 dWmMP+kR1KtAJ9tZ+lSAoFIHeBJtKlCEOpSSCJ7knYTZvMiDAigENZjes0hVvOv0Ma3w
 6oP9hFOfAC/XthT54vTmkJ329s4JFRXyRlr4d8MHnTv6uf/cFrP3UiFDFjy+mRSt6WGi
 x85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709707442; x=1710312242;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5N1nMGTNPxy9yu6PsxH4PAoHsefXw6NPGooODUAcpbs=;
 b=fL353r95kFiHjXLN5zA6wRksB86GdthFh08TeDHw7+gUWcFxPzKjpuRRFht/622XRF
 iNGZJFRN8+yU0tdqPSpaRCiU0HBrHMGcO62kmGen0o+705nZATJ18JQ8lmDxPlQEoOSr
 AxdGSvcHP8UO5odHwrneatGFAkq2IfZyhiOk9a6SE0HkKYRolfaJ04Td/Cs9sjkDsWBw
 +hY+MPuvc6y4hv5m5ma3yPuhiIJzLtZL15zTkyemMiywQQrqxz+mEKX/c66z78zJdJda
 mnAR6N0IaDFK7sNZJvEDudKlt5qOoZTIIVA6R0QhmArxicu6He2zaNt2IN5eL20aHCay
 JMrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpLao9NXtbuml89Nfgg/pcDJy+KCf/N+nUTFvd7liCZ/DTI5MzLO4nQtmZ/H2xhKS6EMwOKKabXruX3FVyfCKSPzxoknE=
X-Gm-Message-State: AOJu0Yxx1LM6sYBlw75vg2xp25xYrVZipdLzSOPe0TQkHOuzHXV4stUY
 ZQJJ/cMzMHEhqt/FyPx7arwEjC/BQhs9QluePQtejkFjXGd5sK4G79HR4Rfv2dB8+67cRh2lWpY
 4JZA=
X-Google-Smtp-Source: AGHT+IEhqKaSSyO4jkVELONBAHZ1Um2BrhfJ97y0dxHd8A4H07E6tUuvDBqVQSvkhw4Ietki51RBGQ==
X-Received: by 2002:a7b:c453:0:b0:412:ef3b:6f0e with SMTP id
 l19-20020a7bc453000000b00412ef3b6f0emr2803729wmi.11.1709707441843; 
 Tue, 05 Mar 2024 22:44:01 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.193])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c458900b00412b3bf811bsm19861767wmo.8.2024.03.05.22.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:44:01 -0800 (PST)
Message-ID: <6eb2498a-476d-4a45-87d0-c961436f4e0f@linaro.org>
Date: Wed, 6 Mar 2024 07:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user/elfload: Fully initialize struct
 target_elf_prpsinfo
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240305233931.283629-1-richard.henderson@linaro.org>
 <20240305233931.283629-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240305233931.283629-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 6/3/24 00:39, Richard Henderson wrote:
> Fixes Coverity CID: 1534962
> Fixes: 243c4706625 ("linux-user/elfload: Write corefile elf header in one block")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


