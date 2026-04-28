Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1A8FF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbX8-0006Q7-Dd; Tue, 28 Apr 2026 02:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbX6-0006P1-Kw
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:02:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbX3-0005Qi-PP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:02:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so187149815e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356172; x=1777960972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ymNe8aFtzMdiDyvE3hiK44D3ftALf9RyZsoWojv1xHc=;
 b=goRtX+JDRbnm+eC/fuPuy1Qzg213EMElnBssdrwdQUlEaR0EeYaTdotqzBqsG+feEn
 cOU3uj1HaHr/ymLYUkjbS5ib4e+u7olC/D7o5l93whbUwYmBgYTjWM72A9eDkF97fXhG
 VR6VDfzmPM0qC28EqfpJlPOtWmgPuW/ysxZTi3CTcGwm8pJm+fFUL3aOWF+LsqIMsGRP
 Z+fztcVps3hh3gIunCzS9J9ZyhLc5ay5lIwqvmiVb1sNCmZ7QeZKAB3mH2OSVoN7cJdj
 W5W1lIgZnYyefanbOPzRCOMkJ2fK5RjDhGJC8ZeGNnnfPcJ8nfC6BeXOYevoCsskEXhX
 JxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356172; x=1777960972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ymNe8aFtzMdiDyvE3hiK44D3ftALf9RyZsoWojv1xHc=;
 b=CL4n4Ac9T2gA1gHObyGn+O90G+8fwu/oTKKeLn7YgS2/UiVA7hDJAKQo355cRKrXf/
 9chxLe8TdfjpQDbcxgXYYGrRZ55t6sUWEuvPBl4M3h4UvwPALqBpbUibN4LvOmjo/N/6
 cuub6S8wNG1NsrSwVd+dlFZ29F1MTIa4aO+Wnko7ljfMtAmkVsy+8in9NL/iDJ5g3quJ
 gPUEA+W8C9lva+Aax26ONZQ4TBwt/CAnGkaqOYsGMTpYLrVBWID8GRypIat9SlJCufo0
 VLTyDQ0XD6f3/6H8OhELlMNpJkSzNIq/FurzCLK1/pl1O1kT10MJZGyQno+JjkjMv4k8
 v2UA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/l+Trdi4PmC7joThJ3QoJx6smt8ak8y2qYtsJ+CHMiB+wJSnQCWqkfFkuw8YbQppIuvlN/+ksUHeqZ@nongnu.org
X-Gm-Message-State: AOJu0YzaNa2DgM2qUc8m5PvyaYsoYJtQ0u82Obmybr+v3mpRA8a9lLv8
 maa+mfnt8XXfWMticDIJEdoo/J1dgywKfO829Kj1Enj94tMVRyFhI8FzQI3zH/wVD8E=
X-Gm-Gg: AeBDievwyi6SuthI/CjMdqfmb7K8TnGYinkBUzRPWlHJxtyIyHO317h/YXbQmN70Wu6
 fJzLj2F9RDusuTXx23+c+bB/O7rksAdvagCa0D7trinSi6iiNUQkFE3muR+Q6SmsJvZR0kBx3st
 dA9kkXjbWF+Dvk4RyEk9PWXWeE4rCmtvQtFszDQXgH97sGalLT6mMer3DkPcH41IgHgX28H8rpc
 NmM++sngfScdlRX0WTZDC12sLIBeYKMz2UPRKMsvTYxslbz+cnRMT9uyppiav4zxl6JR6KZhC38
 FZW/dIvDmlG229JIvfQuKF3EoiYzVVB29Z0Ol+FZi5YcPQMSUY+/9QCZKXp2gHos71pYolO2L/q
 XR+ALYmIXHOGlacnAZA5iIgkiCFTc+dc3+JraQ4BsFml/AVDTvsghJCagbcoQwZXC/oX6jGeFNt
 4e2rFCLNTArhGLVa67xG3uh31r1Ho5J2UQugxcqlEnUiThDuiiCm7npqU95VCiLfztD+WpQvByA
 FC/
X-Received: by 2002:a05:600c:8b2f:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-48a77b19d6fmr25817865e9.23.1777356171630; 
 Mon, 27 Apr 2026 23:02:51 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773aeb49sm32962885e9.4.2026.04.27.23.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:02:51 -0700 (PDT)
Message-ID: <9b67234b-65b2-4960-a7bd-c5906a810ad3@linaro.org>
Date: Tue, 28 Apr 2026 08:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 83/84] target/arm: Drop oddstatus from is_ebf and
 bfdotadd_ebf
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-84-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-84-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 26/4/26 15:40, Richard Henderson wrote:
> This argument is no longer used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/vec_internal.h | 12 +++------
>   target/arm/tcg/sme_helper.c   |  6 ++---
>   target/arm/tcg/vec_helper.c   | 50 +++++++++++++++--------------------
>   3 files changed, 29 insertions(+), 39 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

