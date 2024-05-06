Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A122C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t1C-0001sS-Nj; Mon, 06 May 2024 03:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3t0V-0001kA-MT
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:43:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3t0T-0004Zw-DF
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:43:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41ebcf01013so4223055e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714981406; x=1715586206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+odVLQyIQ14Y4ecHdFRZ+W3G2W23cwZs+13sGAxzQk8=;
 b=d2RYbnd4kZPKBMaCEBkkIgN/1bgKAFPFW4rWXuCNqu+q/A1jYs+sJhQmobRJ9cTykD
 eBBJRjVzaUUCIOIpAAHL12Nb+QCaGmxBpKPTp5YUhGheGrjD59VzO1Wc2dFsVA7RntQ/
 KlEs2yDkBGqOw0915oRzi5Crfjf5KxUfQzhmq7Y9pnYEc/pvQUwO7AyUhKpo9oV7bYY8
 m2RKsHS127zZNAwPDkatulBUHpd/gTUtJSFpVMjosYwrNUZsbfAbNah2YTgCc+yURUK1
 mzaElRNTSrPgAv9It29x0NUbZHnsEk5bD/HX0dRZDfducyhUE8RZNr5AQ6ZKYYOWOhbu
 G1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981406; x=1715586206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+odVLQyIQ14Y4ecHdFRZ+W3G2W23cwZs+13sGAxzQk8=;
 b=UJEfUZn6Pd6fIQKjbnpRvY5PIDdLcZbkcC5QT7OmR28T7CIR2spIeOg0nvCLzGRT/c
 OYflNyiSgQN3keFl5tSGTqU7ldG8U+pqh0OJlDIm710pRHlXiw95KNzLp5+hbaXGaeS5
 RSYIPSL3tSMf1NVJf5vmSSe6NgG9I4H0t43krCfcv4lAfAktwF4hPBFJyGGmPWbfEa8R
 0kmKfQQmMsW/0+nSvM6B8kuZvqmI5950rC2E/do2nm8iy7xsj2oa+5VHHsFUVKEXj3X2
 Q7WPuRh90ZTwe9cQ47iuA351wGm/RE8B+uqEnpLtx/qW5adSQKg6VDZH5cmMR0EEXNWe
 qvZQ==
X-Gm-Message-State: AOJu0YxCdlSaWRd2nKhFSdWpVxkpvfjZr0JHYnDX2nPD8/PjHKRxBsPG
 Bnum1t/DHHWD8c9cCwmcJzDN+ZxiqcrliEmyxW+IG25j1ImBOWxp2yiDPh7OPSdxo9AioNAAE8R
 a
X-Google-Smtp-Source: AGHT+IGFC+2VjQYMRErufMLQDKCbldZNSWQfC8otw8Vc3XG/0d/MzS5Qt+oYWNRnkS22mFT1zrKvng==
X-Received: by 2002:a05:600c:4703:b0:418:d3f4:677b with SMTP id
 v3-20020a05600c470300b00418d3f4677bmr8312787wmo.17.1714981406025; 
 Mon, 06 May 2024 00:43:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a05600c1c8800b00418a6d62ad0sm18948985wms.34.2024.05.06.00.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 00:43:25 -0700 (PDT)
Message-ID: <92e1322a-37a8-4980-b9e2-945819d4a247@linaro.org>
Date: Mon, 6 May 2024 09:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] net/can: Remove unused struct 'CanBusState'
To: "Dr. David Alan Gilbert" <dave@treblig.org>, peter.maydell@linaro.org,
 laurent@vivier.eu
Cc: qemu-devel@nongnu.org
References: <20240505171444.333302-1-dave@treblig.org>
 <20240505171444.333302-8-dave@treblig.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240505171444.333302-8-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 5/5/24 19:14, Dr. David Alan Gilbert wrote:
> As far as I can tell this struct has never been used in this
> file (it is used in can_core.c).
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   net/can/can_host.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



