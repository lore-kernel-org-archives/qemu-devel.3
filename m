Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B295CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 21:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9VNq-0006iA-9D; Thu, 16 Oct 2025 17:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9VNn-0006hw-SL
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 17:19:35 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9VNj-0000Ou-Tb
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 17:19:34 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-781997d195aso987415b3a.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760649569; x=1761254369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+UKDGKjWjJBqntjTRi3qANBnod2i9sqIe8ONETLENio=;
 b=k7DoXP334ILvjJNSb3ekoKcH4Jb1FOwd+BNDqF9K2aEd6SMf6/Hk0KPaA4vPOcaP+X
 WmqTD/nwqyQhKcHC1e8j+4Co4DS4zJN4mBWBkMgPuAs13Afu8n78eUGaXW80XMfZuaw7
 jWresVhfKbQp3QuWb+EKZGZLsgE1WShgmS23mOksW6eojE+XdO9QD7iabsogw0Smbt2S
 SwW5cILY0LDvA7b04xnMrg8cepps89nxkSzAPPgxJEZHzC9cXm0ZKQII5vLigzqTke23
 nE5I8qrooiM9ImAkgexaQH32mMuX6k9WTYSoEXe23b2B85u2HzjO2Gbq79+upRjHRcaf
 T0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760649569; x=1761254369;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+UKDGKjWjJBqntjTRi3qANBnod2i9sqIe8ONETLENio=;
 b=ABBESwjui31dZFrEEWJQqUpAOyz8PVO0I9xIRF/BnGk3k5wJ3TCAW1fV113mz+v1S8
 WJh6SfhCW9V53fALEzkqAe62RjYcHlYEdy9BUOLbW9jqSEZ950Yk1StlY26cxqiG8wG2
 dx7pAEJtmdKy77dYwYeTmHoc4dGSgdFalOJzkZ8NWDwT4826ZDnpzlGyY22R6snZBiQc
 NhG30Eqk7j2xT7IHPxCi24zJ0/AyvmpYp/5LWXqFtH2rDm01j98PdP+pkvcDLK7/rOyY
 jprPA10bfqO389wk8UzVsInUG9L2K/9n4R6tfMWZHVFlqQmdG8fVCb0FakK3o3jIFF94
 BgPg==
X-Gm-Message-State: AOJu0YyZrT8/tPMfPtiJpW/PHu14AtjTJ7G5eQ5y92A+naATgBoS70+f
 Wi15CUrw12J8aY8f30dDEYxDvoCdXupMfWioe1DDjnRjconZ7MM7SvwquNry4IUeD98kCgRyvCa
 22xLGUYc=
X-Gm-Gg: ASbGncsXPRuoJ7sT3oNzdHi7974k5R7R6oRkGELwp49nBOj/Sn6nd/x2h0vyalRgFHQ
 xRV6kaM1Cdh4t8kEBCvWzcPJiqVKyjX1B/vinwdcZc5fx5YMYYffdDewLYOz/BL2I1xj8wN6GFG
 4CrK+2oJqvXrvRu+ZXrjA6Au/BgTNSbLmxavqFUG+lI+wCPJhHQ3A6UFSVXtRDToLcq3n0X9Pz4
 ySPbHIH+IpvocMFHE/zIaE62sYsR4luEvHcWAchHkRmz+x1523mDiiMK9CAd4EjffRJWWOagfg0
 WRx0zJbvFo7JGcT8XEKi2fy4CUmzYYx0lqyAxySAFePEtkJxqM9a+BTTgdP+C2LxtK5A3au3kLF
 RMVyPq6kYy8O56R1IFXTBoBQygefMZnKkRwugNMtcBTWxp08tihExTV2O/g8aYoZq7zzjo9SZPR
 QYpFRcLZp/ej6cuQ==
X-Google-Smtp-Source: AGHT+IGNDTx8peVNmsMOuAEsTE514wNVb6cnkNIg9ymyNhv/vELa+zZMt+xSyg9Uaa+9iH9u5HDqrA==
X-Received: by 2002:a05:6a00:1492:b0:781:1b91:8e34 with SMTP id
 d2e1a72fcca58-7a220af023amr1776285b3a.28.1760649569442; 
 Thu, 16 Oct 2025 14:19:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b060b59sm23918585b3a.2.2025.10.16.14.19.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 14:19:29 -0700 (PDT)
Message-ID: <46eac7ba-0253-4188-bb2d-4f73ef0061ee@linaro.org>
Date: Thu, 16 Oct 2025 14:19:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/aarch64: Add test case for SME2 gdbstub
 registers
To: qemu-devel@nongnu.org
References: <20251016122132.737016-1-peter.maydell@linaro.org>
 <20251016122132.737016-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251016122132.737016-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 10/16/25 05:21, Peter Maydell wrote:
> Test the SME2 register exposure over gdbstub, in the same way
> we already do for SME.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   tests/tcg/aarch64/Makefile.target      |  9 +++++-
>   tests/tcg/aarch64/gdbstub/test-sme2.py | 41 ++++++++++++++++++++++++++
>   2 files changed, 49 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/aarch64/gdbstub/test-sme2.py

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

