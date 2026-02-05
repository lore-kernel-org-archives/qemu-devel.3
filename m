Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A134DECD9A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6AT-0005uT-UA; Thu, 05 Feb 2026 15:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6AS-0005uJ-Mc
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:41:36 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6AR-0002Jr-Bz
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:41:36 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43621bf67ceso781592f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 12:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770324093; x=1770928893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UbAITpIltBlq2geT1pXCh6rITRqeTeJAV4K3copBTAE=;
 b=i2nU/VnbAsnJp+2Ma6J2XheiyrquyVrqoRcrYA7QZBzrtgTlTCY/GEaY3zpJKoyaSz
 3hn15RKjz/+xzDzdJq1UOlD3MEd8t9xccXHlhGoNTAovRo2u5Bkk7Tv74HfcLrLu8nMJ
 RYR+5eq79wCNXzjOHXQk94iUGHoYDM2BOrN33gmk2aSqnENCSkEbQRCpAbap1w0OObUj
 3dEjle7rozlhZmtlMrWCL1tCb9RHIvcmwNa5YQ5POAgHggQQkVA77ww67rX/fdU2Gq2k
 GWa6ewoTV6fogJuKvfDQVlq5qEb8yIlXeE7GZqsSbunekAff7GV/AFJUy3Qrvcz4z2rG
 LLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770324093; x=1770928893;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UbAITpIltBlq2geT1pXCh6rITRqeTeJAV4K3copBTAE=;
 b=vHezKXhbDcQGRbHDMIP1rPfdPe47UC4Nf+AJA5Ilc6CGTfa7pEkBxJ3Pqy/FDCpqAi
 WxiQhrgtvmGqSyhReS0AuBkDwAoBgHD92LN0o3A44mzrjgyw5L2w4D89wwlK28xpPl3A
 pugaexb5GoC03VSXLowHnPDBadPaI0zKqQ4L4YdxFv9LnCKgddka9J8pivgi+LCIH+ge
 IuMnmhCukOSGOEBoHhu0COcTeBMuSQromru9HKp8Ag3yIZuuTnCQCxFftQVAJ1PzwT1b
 qE0Bo2ZoYWtpvmXzOjp6uUismi99s7trb4NN9/gG4v9BGKSaccXKWTLtizMe+Itq1d2z
 4fCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU4MzgpHyR0fcGoax5/VKxGibnnVaifRuxtZrTDfJ/sYYDAN80WrsutyunxZY97Nc35m7/XoYl+xmK@nongnu.org
X-Gm-Message-State: AOJu0Yya5h8cNB9v0IaZ+yAZLcKGWlTRUc2lDoCGmtvrq91TRIAMZwlw
 q3Jd33Q3obAjYZFlLOdCGSZLIjk5gS2TZULZmvNvzXXoK1eLTAUuyyBUVxRuwJsynJvgB4SlOJw
 srcwCIEo=
X-Gm-Gg: AZuq6aJ5FOrToAWj8MMcrG+S93pIFl9ghSOmbLyy5xtgkLXweu/tLLQnogifKrtfM1f
 ZE5H6NBt5wr0mnHyvCaamJTnaw0uOQUXYaBrtERz6Y1eCx7s9zYvR1PNjYPJEvj73NnzDp5ZGCD
 F2rYIOCQZkUBz3Ic1MiSfgtIBZn8a3GLAp4Yjo4nutB/pfoDbTUJzCzKo6tLrfXcKJSqvQa/I8k
 QeBJIQYX1uVCGlol2CNJOfdLx2FRUCyJDF/VDi5CjQ7S4QOH1hhFLlxlK4HHQDvooVOWYWlv5Oq
 J0buh/qxayGqmwx6ouCNZIr8c2lrmFpKmPAicIh42pUb9GCd2gz6i6e4/o6J4F8xrjE8iBaNy9X
 WtHujWYYHgq2+8gF/5uKN8NJDhr/1HWeHO+JSgwCnseIsA32rc8ZhHn2gFH67SY9UUJOY1JEwfv
 BO1m0yuNX+7ugKgnX+czcXMDgnBTnEVQLkVnHEU11IzJVXozSXIinIAw==
X-Received: by 2002:a05:6000:1a8c:b0:435:e436:2f81 with SMTP id
 ffacd0b85a97d-4362934a034mr784602f8f.2.1770324093352; 
 Thu, 05 Feb 2026 12:41:33 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629730992sm664412f8f.21.2026.02.05.12.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 12:41:32 -0800 (PST)
Message-ID: <d13eeccf-1b82-4b97-998e-6efdb390c56f@linaro.org>
Date: Thu, 5 Feb 2026 21:41:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] meson: Add TARGET_ARCH to config_target_data
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260205030617.266625-1-richard.henderson@linaro.org>
 <20260205030617.266625-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260205030617.266625-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/2/26 04:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

