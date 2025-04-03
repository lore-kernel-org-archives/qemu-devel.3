Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66D8C3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OWc-0004yd-8B; Thu, 03 Apr 2025 13:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OWU-0004rA-JP
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:38:39 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OWQ-0001G8-KQ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:38:37 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso1355370b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743701913; x=1744306713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=khXN5PzWMHrB0Jt/nFwh6uiqau8JOAjHaQrSaeYs8l8=;
 b=g8UiJ8w66HdwrLcBQxBcG96tHR67Mqp8yV6XnBkd9be6Cz8eYeoETuO2K3q+xnoTTA
 N2jJltH7nKqn7CoVEpHWqOT3X4XEWKrv97aDIk9njbapugeaQB6Amgmui76F/FKm4G0Z
 fCehrTQrfRzYygiAp55L3JmYDBQKqL670u3f1OllnQdfWeJIGc20nYFqYuRuxsCjWPjh
 VnlEqrKBJ4wVIIRXYgrPFGcRjRBAuFwchaPsFOBaXhq4Ac409/inZ8gsoQkre2e0e6AP
 Bqrz4b3BeUJUXv7VFxH2IxU37B/jG0c/DTxZRIg3xDOaBGWjZo4xLnB3qOIEmmFrTSlA
 w0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743701913; x=1744306713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=khXN5PzWMHrB0Jt/nFwh6uiqau8JOAjHaQrSaeYs8l8=;
 b=hW0sqaGQbjr+IY+R2M3eMu5Cz983pzVQdx+1KYT4j8tX83qHq2nh26MPxnvXACd4jz
 ZvG7Q5snT9hR3EXXWD7X1ailf8wRmobdrgZJ30FQT4ydao97L8ikgI/lC7dEgXe5flLW
 c6Y3B/cThnihXHwjLDe34YmgojKfwQ7msAoygjlKdJq+s2H0EOx/suP56bxGF66SK7+v
 T1p7ZhTp55g5UVfCPh99T/fJW/9/VAE8TxH+2OO0OdaUhuH62dcirtNrzLl8rWSL2h/I
 09qQ065v8AiZjMaexdSoNlYlNDOIB6hekb/9N1cXBkF2gFrbyX9tanVuF1ZRLovG91QD
 2a4g==
X-Gm-Message-State: AOJu0YyaQs6WRJ8/zr9+SnRV4c+S8EUFYUCPxEtsCXzPPnxDvJwb5sa/
 olqpbgABuV5leTE4x4p5HbDDqzBpXU6Qfnvg/23lxBX7hLvD5tgP302sfQuF4plHadwOeGaDgzB
 y
X-Gm-Gg: ASbGncvm/Fld6LyRusWhxWUM9vyv14xgXsx7wvVUu7irSSqxXTuAflNJBEQBcqchiR1
 b9Ma875LdSphvV70X4syJVcEF/RA09BfZg5U6TGps2cZpXBfu6hst7NPcw9mG5J6G0uAqIyAcLq
 vPep1LyB9wL78htmisAscVeaah1cArnM6g8qiDKK2rIqtMxONNd9C/KU3QZELdAaeGf+wj3wdZr
 50dLIu+M/Hn1bsEZnB6QTpE/LRZXMwBAipJyKyOrPjQDCbUsCyyt2WMWY0seAj2V9yQYQJzPWMH
 llkY2jH9lzxZdCNiOe2byurXy22KFQmzTVD13mqwbQseIV71/ROU08mvLiozJOYPIlzVD+6L5fb
 bOrjOZ5dN
X-Google-Smtp-Source: AGHT+IG4W9hJUqlSuKjwm/FA8D8ylz5yZUcqF4NQiGfn4nUH1tJsaeqUWV+6zrVpbl/56+as3sD//w==
X-Received: by 2002:a05:6a00:2e05:b0:736:a8db:93b4 with SMTP id
 d2e1a72fcca58-739e48f0d28mr506625b3a.2.1743701912890; 
 Thu, 03 Apr 2025 10:38:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee385sm1773172b3a.45.2025.04.03.10.38.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:38:32 -0700 (PDT)
Message-ID: <48a39edc-2863-441e-bc29-0042221d4214@linaro.org>
Date: Thu, 3 Apr 2025 10:38:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0? v2 09/14] hw/arm/virt-acpi: Factor its_enabled()
 helper out
To: qemu-devel@nongnu.org
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403151829.44858-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/3/25 08:18, Philippe Mathieu-Daudé wrote:
> GIC ITS is checked for the MADT and IORT tables.
> Factor the checks out to the its_enabled() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Gustavo Romero<gustavo.romero@linaro.org>
> ---
>   hw/arm/virt-acpi-build.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

