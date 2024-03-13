Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4EDC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMEO-0002Oq-Ej; Wed, 13 Mar 2024 06:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMEL-0002Hk-AT
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:53:06 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMEJ-0006j6-Oe
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:53:05 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-513b022a238so3258733e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327181; x=1710931981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BnnV6TEiW4KqNs7c/cCbTDvAE0TV6kR6b46GndTFjQQ=;
 b=g6A+yGNez33bVNT4UIZBtZ47iGzJMZzUVHjKveTgJqmP1jan51tAL8VApfAJxOLwVH
 8P/90Gqh4/lLRc7X41ca/n7QrGFa4S2Py3c/FPp5Tj/rxIhzNiRT5THsUrBUobyeuk5c
 9ukHjOOaUtTDQVGFH7zuJn6kTtHd6aeoH9DKkIPY5Q18+0nCXxul1z/2BDYWlBIFzK+X
 ZtaFt9HfrDsCWiOHbNC1SrJ4UpDf32f+urm/5PwqayLNTOWPTXoz9VQX7EDXT/kNAx5R
 A2cT5z+CDYhV9uGew7WF1cy5WmBSft9atj8YXBnfF1huUKzG2MYRyZ9ts/QpvtixSfco
 dD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327181; x=1710931981;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BnnV6TEiW4KqNs7c/cCbTDvAE0TV6kR6b46GndTFjQQ=;
 b=JZlRdrO7fW1bTJxtapMZQQ77bSEdmxYOCh2xjS5pHS7RJnGiJg4TJGaz8oI2K+rhNq
 boi+xuwksn/FNAQjCG9LI99se4WN+lripwmkzxW3HS4qpHddAHCMchBIctY6fCUH67y4
 77P6W1p/42CGf7qtXn/c3A4fL8hFrQIf+XN2LkLtLV9HWSGD+pKGQ1dHcdtRgd4n08p2
 0Cv1ibgE6Wd3Z0DNjrAUrdP3H6K6IcFZiMdZDe48VnyATaKtGiXuS7eZNstLrYi5zAjH
 8hbvK1oCFrFhEebel+bDxbmBbppTa+4g87yh1TDB9J/+qmJO7Hmr7xnijfus015dh0IL
 2iLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuefPG8Vcn4ZONpbMhv5Qp+70QjBXOnJm9OVyDrLjbPvtYue0hpLxnaJ1GvGwZ73rwK4uz2f5dbAoGAqxdlI86i2Eah0M=
X-Gm-Message-State: AOJu0YzvsWDMe1AMZfg2K2JovWVmCP82lPg72g8N4t0p9Nz84DjFC4ml
 KJQua74i4QwS3kt6vvr25qn+K82UvacVaAHMKkFFYzVJWJVWRAMU9evfREGknAQ=
X-Google-Smtp-Source: AGHT+IHdKTCweQ41EKYY+59m4koFgFL8UwryylLNNF0af7GPONjLZOaJX209RaFqQ+Zfk6xOref3LA==
X-Received: by 2002:ac2:518c:0:b0:512:ab58:3807 with SMTP id
 u12-20020ac2518c000000b00512ab583807mr3104823lfi.9.1710327181261; 
 Wed, 13 Mar 2024 03:53:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d4a07000000b0033e5c54d0d9sm11371978wrq.38.2024.03.13.03.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:53:00 -0700 (PDT)
Message-ID: <358a9670-d084-448d-a8ae-4d156361dfc9@linaro.org>
Date: Wed, 13 Mar 2024 11:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] esp.c: change esp_fifo_push() to take ESPState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 13/3/24 09:57, Mark Cave-Ayland wrote:
> Now that all users of esp_fifo_push() operate on the main FIFO there is no need
> to pass the FIFO explicitly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


