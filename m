Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342B3E88D72
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 23:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8nkh-0007dm-Pf; Fri, 03 Apr 2026 19:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nkg-0007dN-1M
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:16:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nke-0008CB-KF
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:16:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82ce09b61beso1054743b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 16:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775258190; x=1775862990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L2mtlTrpYfLhQMIh8FDI4ghcEctL3zHqAP1YPDVDbRI=;
 b=QLtMPr0PYrMttGexrwbSnckqLIxz7LUigh9ng8CJ7s3KOi2fHS6J9I67Vy6ZxkIbWZ
 Da2KC5Vm7z8SNhCSjmLZxQaUPD1ZddLSM5OYF7u00di94GW36OVJLD7o8xsKgWPfpDq+
 8zKwvG426eLCJqBopyFRj4XZdynNOFq3skFussjfZvzju0TaS6cHjiiZ/iVCp6DGRNRv
 65jB6a5uJL8E9rCFMGJCDGxA3/P6bhQMQuHvscPtweyf4SqrRiegMR9HH1FF6qK0pTGf
 vvFmZsUH6WZjeKEGenHWvfkPg8pVbgGbnBxNLZSkq+ads56Zv4pHKMp7wRKIbhBuqnZo
 5OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775258190; x=1775862990;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L2mtlTrpYfLhQMIh8FDI4ghcEctL3zHqAP1YPDVDbRI=;
 b=bV34BiaZFyIqzmRCdEcBLrzUNnGjo30a91AC4DJ3r5gzq1OcmqP55kjpCSBrY9xxfU
 PIhyqGV3L1VbbnLdknr4yT8Uo0cmaEA8U8Gs3NLRUFydYDMEXpjvBsjXxOAQsvyfZT9i
 BTdkwTp+aff3dgEGC0dldm62bmgXD6RPkc/Sk7brjwgEFlajzfhAz4u3mgVUUZ+eWNAN
 VJMojknRE/Kd/2Vm4SLtf9U/5wE8MJPQ5KIrOCO3FU63ngyWpaTuz8Xm3YoI0Mk5esy/
 79dOIEBcfHp8CD9gPM7M5ReKrAXOwILMGedzbf0ddQB6PR70TEK427bu+jaaEmsPnMfG
 aDFw==
X-Gm-Message-State: AOJu0YzcT6MX+co/+2HMiZsQ70skAFaesA+FNNJ0Oexl/2LLlfBziFx9
 sUs3wQsyeQT+TEjM75HsFYk2xVZmBNoqYAH/xfnAlFCPZwXI3RFuF2FuCq3HVBbevcLAibn8GgT
 iTW8lPeQ=
X-Gm-Gg: AeBDievzceOGUNNUbQXNVJ1kDLLBOmCTxfNQm0hK1aEA4n17An3SY30ryrwpvcC7OuX
 GV6Atn5yvNmhht5VlnwO7t84A7XW2+C7LSsLffElKa7qZhKDTEfHKxx5vIQCFDyfKpHXX9qKOOh
 MDg1b1hCpsKVj5Sr4TBVIlv5RJIMha8eqbkh5yjQzvnOuUG7MtkUMNmjcEJlzbUKSF9qYDMI2Ej
 huDDD/MuEa+OGgHEFIpnZ+IiOUOB1LvnpAQNj5hmeXkSBumFyOvXXe8c97O1AE+qLWcl9s//ivo
 UTQUuBkMMxmm0fwvkKQx+nd70dJkzdxdUkw9e9iy6c2Aj0Xe4Hw4hfeEIK5lsndGMhJLtxbBN93
 STiPHnFQw8rWEzm0RV3NRO/HWcNtRONNrj7yLSVg3mA20yobTxix+61jSoZSHvVXqZ40A7KgTYE
 st6Z1DntkQXFd13DXcI/Jnzpa0+d3woWl2TZodVU6pE3Xp7mqKVI88Qfjd39mXX5Nk3sU=
X-Received: by 2002:a05:6a00:4189:b0:82c:e775:d42a with SMTP id
 d2e1a72fcca58-82d0dbc089bmr4295164b3a.49.1775258190460; 
 Fri, 03 Apr 2026 16:16:30 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3dcbesm6818146b3a.22.2026.04.03.16.16.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 16:16:30 -0700 (PDT)
Message-ID: <93aff196-b436-4c8c-aa76-3d58785e5c04@linaro.org>
Date: Sat, 4 Apr 2026 09:16:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 2/6] hw/core: Move compat_props_add() to
 'hw/core/boards.h'
To: qemu-devel@nongnu.org
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <20260403104327.1163942-3-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260403104327.1163942-3-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/3/26 20:43, Michael Tokarev wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> compat_props_add() is only used by board models, no need
> to expose it to any device model. Restrict by defining it
> only in "hw/core/boards.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   include/hw/core/boards.h | 10 ++++++++++
>   include/hw/core/qdev.h   | 10 ----------
>   2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

