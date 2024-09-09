Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05ACECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmXL-0001Ar-T4; Mon, 09 Sep 2024 18:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmXF-0000uF-FR
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:07:01 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmXD-0007lb-U8
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:07:01 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d60e23b33so176915766b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725919618; x=1726524418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7wcscUNHkb3kKDCJOpiuMEr+J0p/vY1EoHE/dzE2+PY=;
 b=mn8nUxWKBq+zxQuBaIkpOjRbKgxzKIBKB63Xw9OizZwuBEx3SFw9oWbEkfZZNyuBH9
 2xcF0jKa+wH+uM2v0h77Q0yAtVTBU4BV9bcpetNuyS0wa5Jpz8U4XPLAYfVrrW8xr4Yf
 jF2ieqmTneIgsPUhX9hnpHUi+siS3I9wNFwYr54cf0Dxco76rrdNg8e7rfA4SD9Tiq+V
 uCwq/NFogHEZm5jBdpwIK6fz/7L97B/UCqhspZ074QeYzaai/ibB87DU1EaRSUhi2LKQ
 vG1yNMx6JSwpw6DdRREr9j5KN355R0XW0lvjcIWvU86s/TFjPRP4T1JmettUeXk/W+rR
 qfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725919618; x=1726524418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7wcscUNHkb3kKDCJOpiuMEr+J0p/vY1EoHE/dzE2+PY=;
 b=aVXh8qK6rIOwYgRLmSYccq5xgiTbA3EmC7hboPy3b8G46dsKFT6IdqwH4Y7Pv/+Q8P
 mxvvUZoOhPSRw0Xh6+/g7Ngzy+t5Osl1nKeNRspauSu282xOSYHVc6xDULI4sGJnz3wG
 La9VRg4Utu/soNm7ilYl0eCMEFuulPhW2vVBJb0gPR1AbFXx64azcMeEa1M8JzV8Qi7s
 8JkwFW+4CW0l/e2wIj98Lu15Ra86staUfobPGlc1gb0sncBQZeDa4UGuLI5vrLSAC41V
 9zKqgFTiIwyZoIErC0DCTqrt+lJ0i1Gk/Eiii+nK0uJuHzwZKLPc0/seBEkeB0LNb67E
 s5dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6j91NI+7LPvlbCfnKZWGlOp1+ljRy3gkroADL0TJjEdnZT8Bla+IbaolKDXFScpqipU8ONyPa4Exw@nongnu.org
X-Gm-Message-State: AOJu0Yx78lGV9JUgp8BYDDzMvCHP8MejFi7fzBeGHJJbPu+FrylMq156
 Zk2ZxmmHZ6WjZmJkooM2OxnBmwwQrcD5QdTITRV44KtgxYtv3fdglRceiANP3tY=
X-Google-Smtp-Source: AGHT+IGy0ep9fKcYOuGaAqpiVbIZBQZn3gh/rZ9m2RSu4jNLMTHuvYLU+YXO68Jdl0n/S+Malnrsaw==
X-Received: by 2002:a17:907:3683:b0:a7a:952b:95b1 with SMTP id
 a640c23a62f3a-a8a885f95e8mr1400095366b.24.1725919618152; 
 Mon, 09 Sep 2024 15:06:58 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ce9277sm399925966b.149.2024.09.09.15.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:06:57 -0700 (PDT)
Message-ID: <411f68a1-c835-4953-a399-9e4382b70c7c@linaro.org>
Date: Tue, 10 Sep 2024 00:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/26] target/m68k: Remove env argument to
 gen_ea_mode_fp
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-19-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-19-richard.henderson@linaro.org>
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

On 9/9/24 19:28, Richard Henderson wrote:
> Use the env pointer in DisasContext.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


