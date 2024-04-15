Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC5DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 14:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwNcc-0007DK-CE; Mon, 15 Apr 2024 10:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNcY-0007Bi-31
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:47:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNcU-00019r-Rj
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:47:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41869c1a95aso5061635e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713192461; x=1713797261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xjZ3Rspq8QEGVUkMI0bH+lmZ28HUYTtxTCCx8oa14t4=;
 b=W0eRr9HUMISGmknPPxuuYaEEEEZvzeWpIEYj0FoB/P6xWX20FkI8rHrtawA5MX1NPn
 Mlwui7y/W6+IsEMP8cM/aPynuykAaLe3ns0FmUWHdV38NCjgeNpZuIIw8EMKZEOwquF+
 sCSkEtfKqfrFPoERDNkqXKaejpBYM3xdTSO4xciXT4VcaTUfFeNQ/9u2Rg2eJSkEl/Zt
 95YKSHGpiBdjiN3RB2bzYN6MDEDbyBEMcUaF6cryCuUlXqHv1tjMlDIvFa+UNlKolp60
 pV2EMr0tcPxkYB/0pH4iUC8Ae/+kn5OIIxnoiG4H49SUSuogNXSRsEcqZ3vpplQMXFSx
 7xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713192461; x=1713797261;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xjZ3Rspq8QEGVUkMI0bH+lmZ28HUYTtxTCCx8oa14t4=;
 b=HLr8ULd6JJ31sG1WGDF2Vem9IpQwGkEm9b+pbxuTzb+8OEmdrdnPBPzQa+MvXz/yK7
 ShMBkvoXaWad4sHsjWsoCZvWAWYJGKpguvG5qPVT08WCj1CSKzbK8tqxghUlG1XDdtVW
 w/h2iavytmjBo5Y1wb3OMCyBPW8fsiUTnkiM2IHpifN+Izygk7Y9jbPoqFV3LKey2vzN
 ydKZTnkFh6R53Qgr7Tf+sF2rMLXp5wBKhLih3yZ2hlIChdoI7JQbwRxGxLxj7nmebiyX
 RGe1NZfnsyX7Y1AfjNScXeZU3Pk6VL7bWl9G2eGvUrgKSp5OV61eG4ZPtWpoxNqBnWBB
 1alg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUglEOOx7o1yzb1c6hu6zoKg1Frp3gmZpesP9f60L04xVvJ13/DZ5XU46UNB2gIDnIpx3RozMAz/GFDGHY523NUDqgCfo=
X-Gm-Message-State: AOJu0YyKvR4YLHOLRNhDjM7aXMTbZbjFL1PaJaEmHj54CbwbT/qS006Z
 8aytUzEol4aXUPX9emoUd32txc7AYCt3zTtXYV+p07gj5sqfOXqWLmksHd0bv7k=
X-Google-Smtp-Source: AGHT+IE6xPJsfS2TxlrqORWQi/SiPefdKjdrpIgxW6JAiqeWPTW5qnkYXQMYsU4r/Y472vMbfrpeHw==
X-Received: by 2002:a05:600c:5011:b0:418:677d:cded with SMTP id
 n17-20020a05600c501100b00418677dcdedmr1911869wmr.0.1713192461422; 
 Mon, 15 Apr 2024 07:47:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a05600c4f4600b0041875ff29adsm2201511wmq.2.2024.04.15.07.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 07:47:40 -0700 (PDT)
Message-ID: <05baa627-64ee-41b7-a206-3b05f694c2f5@linaro.org>
Date: Mon, 15 Apr 2024 16:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/isa/vt82c686: Keep track of PIRQ/PINT pins separately
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240410222543.0EA534E6005@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240410222543.0EA534E6005@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/4/24 00:25, BALATON Zoltan wrote:
> Move calculation of mask after the switch which sets the function
> number for PIRQ/PINT pins to make sure the state of these pins are
> kept track of separately and IRQ is raised if any of them is active.
> 
> Fixes: 7e01bd80c1 hw/isa/vt82c686: Bring back via_isa_set_irq()
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Preferably for 9.0 if there will be another RC.
> 
>   hw/isa/vt82c686.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Queued, thanks.

