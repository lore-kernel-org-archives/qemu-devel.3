Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD11EC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqwp-0002li-BL; Mon, 08 Jul 2024 12:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQqwi-0002OD-19
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:10:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQqwg-0000fz-EJ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:10:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so28738735ad.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720455029; x=1721059829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TIE1GX86AU06PoYm/EZa45ZjEI/WjbWvTbpO9pYcyVw=;
 b=OtAqeKW4+6fEFT2kcF2uhzU8Rer4x54aznR4p3CeOiGzub+WPDUZBQz+2cWIA0ErfU
 kXbSmXCKQTb9eIZGNwkrA+3gNk9+UF94yg5j0u03JRQsOizI7/YcyBRymgDSH0w5wUV9
 e+Y6KqoFZzSABP8aVpyXeYxLOSOtDsUzc4odFBhOk7IorXekoBQ8XTIhqLGfYS2BGvfN
 ZqhmeZ8ab5R53RM+GIY95i3WssnIwzsfMiRs4nSy583G19dmBjczywFlDujLjTmJ8IEb
 nSSWGtWWikMteefho6j3mXZ8ZSCfDPHJYl7CV66x5HDRyP0GVHbibVJ6R1nzgXUpqbWf
 oTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720455029; x=1721059829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TIE1GX86AU06PoYm/EZa45ZjEI/WjbWvTbpO9pYcyVw=;
 b=tQ12RbZk85sxYpzupD9GkYGmvLe83aGbZxVhRKyQHykqP2wV2Ai81Z6KWjJ7sCTpAq
 zJs3tOA6dFFIg2bdIEdV320ZNbuAm3Xo3UrIo+r4ouG+fz1M9qjonpUs+C/3PL++bUWB
 0/RNBDMaZl99W3uvF/ZDL7FWlpiimyNtPX4jv152keloNi2BjHPBeBnPvLuzisiVqJlE
 i420HYJv5qEDD3Nhfy4eX8m0XTFvAJebtuaoP1FT4vwuyk23ygNKLO6QfDlpAKIpl41e
 EDxTuKRXwj/4CazrBc3JSiq4voNCsuC4onAgdIT9ngkR6UyCX0rx/rhWTciWkZwgKJu9
 6WNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoIGn7HOSQNXw9mYu9ZUGw0jMknZeAKdDGtrpuBB174wJtnYC6Z6/GAgwldw2cOHopnul5iOJJ4QQIe9kFF4Ssh3xTvc0=
X-Gm-Message-State: AOJu0Yy0UXgOvX70Ol3FmbrplUsSQnRb9Y/6GGoXZV9NsOOeubUYI0e/
 JWbLXDjeS/V2j5dWo4w6gwDiJpC5xi+yQKeabipI9udvkYqKJZ2bIyYktM0tC6tzmnPNQ8hYBjD
 IdDU=
X-Google-Smtp-Source: AGHT+IG8xD6PXn9yC/XGEDt8Z2FjW7fDXLoIcQgMbS85mL445Kr/dbZ/nEXWEYGPWSwc4qrO0qQuPw==
X-Received: by 2002:a17:902:e88a:b0:1fb:a2c0:53b4 with SMTP id
 d9443c01a7336-1fba2c0578fmr15734755ad.18.1720455028795; 
 Mon, 08 Jul 2024 09:10:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ab6c53sm370375ad.153.2024.07.08.09.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 09:10:28 -0700 (PDT)
Message-ID: <f3112277-a69f-4135-ae5b-1272109345f5@linaro.org>
Date: Mon, 8 Jul 2024 09:10:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] bsd-user:Add set_mcontext function for ARM AArch64
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240707191128.10509-1-itachis@FreeBSD.org>
 <20240707191128.10509-8-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240707191128.10509-8-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 7/7/24 12:11, Ajeet Singh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> The function copies register values from the provided target_mcontext_t
> structure to the CPUARMState registers.
> Note:FP  is unfinished upstream but will be a separate commit coming soon.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/signal.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

