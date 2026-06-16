Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B394CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVlv-0007m8-3b; Tue, 16 Jun 2026 11:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZVlt-0007lZ-Ll
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:32:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZVls-00043w-96
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:32:13 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c0c379e8ffso32838335ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781623931; x=1782228731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1SlUbXy3o5QJDBTtYZp+CfR36UvvgS7Zm4D6qMxfndk=;
 b=MiktfAFiI7opz9ZqYf4e2wUQmdF1qKn8teDXTzKNwniHs99kvLFXPQg5SQcXNIrO0I
 QwEkIi8H299yXuGr89p0d1yoEEsI7jDv0HvBp8yjdNkcwVTrKrn/9cKmm0fW4Haj4P9g
 AutKqDh20p9pl8zQVPwIDAyzy++wCrROyQpD0WoJMF1whP6rsmbmTAOtctPN+aNEJlGs
 D7c4d+G3Di+L9gvg4epDoDTRvDv7KPEMEb1cy3fGZSOKvUXnKTsMm/FviuvoHkr9CJMS
 2IBnsdhLUc04HTy5j7rrfCOA4VNsbWDFe5G32jv9qs3QM7c/Ro/IQifQwu78ygcMI8rU
 38Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781623931; x=1782228731;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1SlUbXy3o5QJDBTtYZp+CfR36UvvgS7Zm4D6qMxfndk=;
 b=XTEH6Gs8cZ1KkrEy4B+7dKpmMk14knSTVJJ9o5IPWhxv1vF/VfRf5xHU8PnItpWBgi
 Yv1l70GRpE8FyLL2ehSBrIOMRzFpstnTP8t+hla7O9aXcvsrtQ3WzT2Jvn3rodFmYBIc
 lAhlrO8hWfTZkJOwZX/9VlDIS8zXHAq9Cj44fRvI/28RV8KoKyzQapyF/674EWzvBR0y
 NRb3M0mMTmPlL7M4HJFhZxJGA2UyzDNVoucicK6SwtVAKmsk71DTolQdWkV/iIWz4OvA
 5ryr6vZ7Wrjj+1r7qXdoD8ADil+QWnx6DDClJKLTYxA2xxtHzsBl6GEtJc95y7Y4xGgI
 kU5Q==
X-Gm-Message-State: AOJu0Yx7VeYzw6crGqWMOX8rx4/orfLv/kWBptdPRnM7x4G6tthyf5Ip
 LV/65vPeAkJaqkHW7cWMkg2OYXFqGOaH216zQMPT+HAaPtcWNw18fG6lGur20jBSHvI=
X-Gm-Gg: Acq92OFbYCwqDURri4KY6I9D/XsL+6MtrRtas0jrBp8W7wWE/6+kEDFalLXp6j60oEP
 OcO2rR/UOiyAW115CcHjW7tn06wp/IJ1l6aso6pMYDMPCZwdgIm8lKfQF43GVxDsRXTBoBvDWqm
 pXI+cApAPRTHwhkKqcLhWkPcvBRe6HN9F/dm7rIhT6/Uy843WiV7QQrb35QWGPl0EYZeEXRACtD
 OUhbwbjkKm4ltBpZkDlEftgJf9UgiWxdBTA59qb7Fi0FUmBg5w1h6odCJRGTFrgs4nFOMlKYeR7
 JervyDay6kqMSMzxcRrrlMgURwoih2bc6ZIJKmFUii0RFVB3Ks+bWNwmDlP9lfEH4lpOrP8RkbM
 Bt8cmY3HvbKiv46sRbhn5gXLWHpZCtMokKgoYFCRsfuu99wMuQU4+1MVndSBamFwFK/SqGYnaZ/
 eHB+7GC45HOJdoRKqA9wg6YtEAmVvZC2mZN01j/fr1tSuiz+lkhtDYHbrJc8GU5JZFXDeB
X-Received: by 2002:a17:903:15c8:b0:2c1:ef9:4516 with SMTP id
 d9443c01a7336-2c664227c1emr175514445ad.35.1781623930521; 
 Tue, 16 Jun 2026 08:32:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f1f0a36sm131987775ad.15.2026.06.16.08.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 08:32:09 -0700 (PDT)
Message-ID: <827e0cfe-7d1d-460a-9fff-990d357a7e2d@linaro.org>
Date: Tue, 16 Jun 2026 08:32:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] target/arm: Implement FEAT_SSVE_AES
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-25-richard.henderson@linaro.org>
 <CAFEAcA-0VgXH7bZgbc730ZgHZ02ZR-jm300izcPDabgBCHAY=A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-0VgXH7bZgbc730ZgHZ02ZR-jm300izcPDabgBCHAY=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/16/26 07:51, Peter Maydell wrote:
> Do you think it's worth updating our feature function names to
> match the official architecture names, or shall we just leave it be?

My first thought was that this might have been a combo feature test, requiring both sve2 
and aes -- I've done that elsewhere with e.g. isar_feature_aa64_sve2_f8mm8.  But since 
that isn't the case here, it might be worth making the function match the (newer?) feature 
name.


r~

