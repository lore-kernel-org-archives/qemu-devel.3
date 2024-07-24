Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5831EC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 07:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWW4p-0001PN-3U; Wed, 24 Jul 2024 03:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWW4i-0001K9-05
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 03:06:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWW4g-0004ui-4l
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 03:06:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-427cede1e86so46451825e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 00:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721804768; x=1722409568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0VOEf4SMR7NWJjVOU5A+IGYdFZ9IHLih+hGfTZfAK3c=;
 b=nscFkSwX7iw21zsUUC+CKgnhMkSlPcM20Do+Q+T54r1Ix0dEPs7sQPf/5jatuqe8hs
 NRkZ64T2COGuxr/uIjQvsrDmwFiDkxNnKsh4WCrmFN5/HgBcb1m5ArKDFAj7vwYIEG6b
 ypwrRENpgFScuw7AC33u3b7D/l7mpKPQ/MwytnsIfhjCuuUpa7GE8vqG1yKkC/XjMqir
 jPyyDyE1nlJSAM3nKPFOcelzfUJlXnudbrUT0RFkmlK4d8Cyo/oGWhu4R2bZtF+L03Iq
 J3fwUcPmVftpn0uEDjufTxENYmc6qtP1jr48z2H0D65OWANOdo1ILZOeExqdKxDPl1oT
 HyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721804768; x=1722409568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0VOEf4SMR7NWJjVOU5A+IGYdFZ9IHLih+hGfTZfAK3c=;
 b=hbXOrdwv7QooPP0VLuqgI+ZmWgZ1php1l1QCUd920RR9cw1PwCU2sndwmms691eClV
 c1xlbPWirBeVEOc505M87WTAdkwmAZUYgddDxlf2U5e7mcqAe5L66d/jw0BofFOwOuNp
 ZmVQw7nb0NAWrZrEmgKCQN5E8q8Q9Ik3xw9HzX/jyvy3mDnERS1D0onZXCS8bKYKXMz6
 xUVbeWTpLoR6jJZER11knnnu2Ks+l1lJMjxfqLlr8xpCTiKH5aTMbhWfqcNqJkv3aUWM
 3vciVYeGkFXzgfhpTkk22sPAFg7HqPt9dr26fEZHt9coEq6wL2NpXDP9qRX4EcTo/MO9
 oUKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzftoTrJjxK3tZow0p7Q5hTNyjYR7lXq9W6KUG1vlHiqQr6yhnkKpcgg9rRKJfmsQWJkGrdxZ/aTFdXPSja/3UGEkNNbY=
X-Gm-Message-State: AOJu0YzLdYnN2RxJYqG4CkJVse6jsRrVoWy6F/NouXRXmhupbq1i0qmF
 y0t64WwSfmQyq1zsgJ1ov1cCyuhSHePFvNNsINlgOCM9MHAPnbtdXNJsNgrbiczSpP+Misae+0r
 gIVY=
X-Google-Smtp-Source: AGHT+IESCFNMbpSUF+dYvae92whb6oLc6nV9U1PnA7vQawJj/5BSZiddAIY3BEVKSpGzLeXpRirM4g==
X-Received: by 2002:a05:600c:198c:b0:426:6f81:d235 with SMTP id
 5b1f17b1804b1-427dc527e16mr90070065e9.15.1721804768147; 
 Wed, 24 Jul 2024 00:06:08 -0700 (PDT)
Received: from [192.168.69.100] (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr.
 [176.184.50.4]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f935dd8esm15461365e9.2.2024.07.24.00.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 00:06:07 -0700 (PDT)
Message-ID: <a8291990-e161-4a43-a1c9-69040f1f6f93@linaro.org>
Date: Wed, 24 Jul 2024 09:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/misc/bcm2835_property: Avoid overflow in OTP
 access properties
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240723131029.1159908-1-peter.maydell@linaro.org>
 <20240723131029.1159908-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723131029.1159908-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Peter,

On 23/7/24 15:10, Peter Maydell wrote:
> Coverity points out that in our handling of the property
> RPI_FWREQ_SET_CUSTOMER_OTP we have a potential overflow.  This
> happens because we read start_num and number from the guest as
> unsigned 32 bit integers, but then the variable 'n' we use as a loop
> counter as we iterate from start_num to start_num + number is only an
> "int".  That means that if the guest passes us a very large start_num
> we will interpret it as negative.  This will result in an assertion
> failure inside bcm2835_otp_set_row(), which checks that we didn't
> pass it an invalid row number.
> 
> A similar issue applies to all the properties for accessing OTP rows
> where we are iterating through with a start and length read from the
> guest.
> 
> Use uint32_t for the loop counter to avoid this problem. Because in
> all cases 'n' is only used as a loop counter, we can do this as
> part of the for(), restricting its scope to exactly where we need it.
> 
> Resolves: Coverity CID 1549401
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   hw/misc/bcm2835_property.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index e28fdca9846..7eb623b4e90 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -30,7 +30,6 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>       uint32_t tot_len;
>       size_t resplen;
>       uint32_t tmp;
> -    int n;
>       uint32_t start_num, number, otp_row;
>   
>       /*
> @@ -337,7 +336,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>   
>               resplen = 8 + 4 * number;
>   
> -            for (n = start_num; n < start_num + number &&
> +            for (uint32_t n = start_num; n < start_num + number &&
>                    n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {

I find not making the counter size explicit and use 'unsigned'
simpler, since using 32-bit in particular doesn't bring much here.
Is there a reason I'm missing?

Thanks,

Phil.

