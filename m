Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D236CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1sY-0008B3-9u; Wed, 29 Oct 2025 04:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1sS-0008AO-8g
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:49:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1sP-0001JS-L6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:49:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-475dd559b0bso57306195e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761727789; x=1762332589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JR/Xxn1CIAcviQYlZNgeqIr10z6cSwhrag9QVZZm4io=;
 b=M7I3qG24knIHbpHn9ohfoVUvNuzG5IjNplTPNxiTZHFXbt2E1SdCXGlZeGR81bhjtN
 hU441PX1DJv/4vySeqxRwtqlePhF/WVltQUGd6Bx3HxdhmMzIbL3iSe4Q+b35TNlTkYF
 ntWfLo4B94Ce4m5At9hti55ifN81NzRE2zWhjuPjvnhY+3CKGemZphHs4/B+1UlWc0MK
 9Fa2GHa2hdMTOlfOHMbT3jRpvwtpWCMC9Z9nOjOv5s5K9KUZEir8pmQxsshhQJOBPVqv
 ebD9EgNE4kkmTlvUJleKDzuo6LMOKYcl/NfEDMvTeGiM4swFn/j9/SPJ0lu4xTNIMQPK
 iGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761727789; x=1762332589;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JR/Xxn1CIAcviQYlZNgeqIr10z6cSwhrag9QVZZm4io=;
 b=U90aNgF6RooO+8gTIB78TY60v6r2sd9GwpoHI0KyqkPRMkDxyVWgV9qtXJdjOYgVRE
 HJln/YWgcoh2iQA3lnZjtMihjqgav1eN/xnUU8MpZS2WrkwgIADyaIKlGUkWVvE0jF5U
 YOO81ao8oofzOtCY+fblLhPn3Tf/GQtaeec95BDD7LOgHz3pgzAM2rmoQ9OrOKmYCFJo
 nD+s5wQecH8+zpgOaWykKac5XgQnWIugQE/VtUWpCtrxuMJv6lMXJUstKhjCDGRvg2hc
 teIrkEHr4jOuglDtABPTRcwOIfmC+qBa9q4qXJB9pOCCTkg0ordi46cfkAQLEsLmmdMa
 a8vA==
X-Gm-Message-State: AOJu0Yy2C7MuqzjnpkwRcX4ri23ONwDRuMMjv59FMo+HxMYiO/Q7BXG6
 uViqEc6zZnE7LjY6OT2Aogpcad5r5JNQZKkF26t2fMXVpndTpGb0sJd4KKePDdEBOMSrwUZ2Mui
 e4C+FvG0=
X-Gm-Gg: ASbGncsYOG0rRSwC6XZhonA4XdhJ6kXHN9nq3Xp3JD9uufTossabwicPPk3MpGPrplZ
 PFDJT7RaYbwhzt64ykZiquq67Wp4M1EWX2Rg7z+Pz9GsZey5zBhg3V884ZgVV2xoITCYAo0SsyI
 J7bHaQ7sxDzw0KTEDnDlNwup9DUbFBHkcIcaE5O+XGFayfGuXQOdraLaTwsG4Lt05vaTcX1SVw5
 lItt1YECACg4OVf5jvwPvxLTUke7pJ9LvLatAcWEXiNuV2QoMGyegdQApajaTFPNm3qHfehrdJG
 omlXQrCdRxqBGN9/+Svs7+7M+i2P0gNkGIdNSWKjmtm8IvSosPlVm9OBjjT5oxv/JNaF/r4DllP
 VHCKd1iaYhQ3DuBo370lNmJG0HlUbZ4ZBeQXQQaMvxgsNsPcA0fbZ3HbUJnV+d00YUQ2zrf3h2S
 xbK4RrFZCF4k/KjFs6
X-Google-Smtp-Source: AGHT+IFwbr8NWMhU8Raa3qZL1whhoAtFmg/m+4NvDWn0+m4MvQDRtMCVDHhne13+ld48QDAQVr3sbQ==
X-Received: by 2002:a05:600c:1e1b:b0:46e:4499:ba30 with SMTP id
 5b1f17b1804b1-4771e1ed66emr19282145e9.30.1761727789445; 
 Wed, 29 Oct 2025 01:49:49 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e39379dsm36523855e9.6.2025.10.29.01.49.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:49:49 -0700 (PDT)
Message-ID: <09fb22fa-57d3-4e9a-b767-3b8cd22cac0c@linaro.org>
Date: Wed, 29 Oct 2025 09:49:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/25] system/ioport: Use memory_region_get_address()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-21-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/ioport.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

