Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D227EF531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQQi-0001aA-GA; Mon, 13 Apr 2026 19:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQQX-0001Sb-JI
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:10:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQQT-0007pE-BQ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:10:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ad135063so47641045e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776121838; x=1776726638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MHyI/6O0K+5so/EsQYExOJN2KDvFgpDlCHLvEUdwEUI=;
 b=tQMlbEU45t4pKPEruIoM4ZC+367avMQPg48o4pI6knnwwr9wjQ8vU9u0qgZELYNFot
 DUE5tLwBuNMeW0IjVM0shb9wXWq6xjkD4GOnd2lgBVvIizzriHUWKjGGvRayNrezAO19
 jorUtZxkNoNxy86NAFaCMR5LzujHIOlRw8xt1QR754UdyBr4Ze5UXIYA7XyN65Lsp/O3
 iIvD/WLEU67GOmWO8grqCfHrPIfsR+8oopQGpbsnG/oWU2qnCH9TormvWpYVzvCGT0oy
 8SVeD1ru+NmjGzCdEvlkTB+8hvaOZo+muyGCROk0DbMaymsafy2xbwCM5X6vAhm6sdKE
 4HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776121838; x=1776726638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHyI/6O0K+5so/EsQYExOJN2KDvFgpDlCHLvEUdwEUI=;
 b=YHzR5hCHZX5HHGbQor4lPKCpuvAdpVy9cbBtEGDRvtkBAkHX7dmT7jDGYtsIuueLpy
 Xcl/1JviSyE9vJ7GBio7kJpqod8Ef3choA4dnAzsGm7asCXxj3emvxIPk/B1UcN512JX
 DZDsCcIqIpB2Kz+I1kbtZWuL6kpITp4NQ0F86vTbXcRV0Yqd2q7ed9T2fQUg7PMB0Zj9
 QvcvTblOWhTxzDrvPD5GUg2/tt7LsmnjO7k4ZJOffHcEQ4gY4p2yrSfogAqKQxnaD6Fg
 Hjj/Zx4B6ivotEC1T14D5+M5+qUtigbwqnQJCBdgfYlGdlUx4u//RAxtXLsDVcZQGLhN
 Pzhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2h/KN3zqzS6aJBi61RdlC2EkqPBbOSLst/eFtoBfLv0UUp9vbqfbfeIwYmFis8KQ+xvXCwuEpZP06@nongnu.org
X-Gm-Message-State: AOJu0YwWCVkFjmBDak1NqCoLyLJOuaiwHifyMR+RYYL3a3ChHwWROlSY
 skLNIysMqQd1I5rgHKV+zSICLERgvPblPG4ebXSPQdkLSKRy731eVQ/0ph1rDgrrFHI=
X-Gm-Gg: AeBDieve8H6fbmb6PId1VJ7KbD0hOhpFrnCgBUa247gBC5Wo77d1J8G4l2pyTmmhf7l
 rV/Ne8B3in9MoJ6JszKQeAlr2uf7xvErYZ2sBIZMczQ7Q4gJlrPbWwwTa5ayWHTBGTiOOMTR23o
 QB9GmDExuSrpPjFClqrsih3Dz5CYQEZvjsEn3EUssxj5+xFH+KnWSoJWpIkduaWg2EoxctptPDd
 dNb5XZeb7VZNElXP/aR+ojjC1v6JxPARuevUCzMxmSUe8+Bu3nNqPlNw8LO2mCoPNMk/Gg3iunK
 RwFqexH66TFiMFLKEtxLyEPjfFY/wedyoqft5CRAhlWcG4bTELl49B+qHuwrtYCB9GQOhD7M/sy
 TqzWI5676mckxgqlzrzjIPHpnvxW0q6KP4CYUO68fRQtcsXkbN0QNneSgM3i3UFN2VZPcfdYt4s
 jBnFAVJAQa64d75ZrfG6I/Oi/ItV5IiycTbetHnF59rtV53DOJqIEXNnplmlIeNIgqQQ==
X-Received: by 2002:a05:600c:3f16:b0:485:3f30:6250 with SMTP id
 5b1f17b1804b1-488d6894bf6mr222055925e9.20.1776121838578; 
 Mon, 13 Apr 2026 16:10:38 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede15694sm3087225e9.3.2026.04.13.16.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:10:37 -0700 (PDT)
Message-ID: <43a16b17-1770-4699-9f09-c38556076cc6@linaro.org>
Date: Tue, 14 Apr 2026 01:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/65] hw/intc/arm_gicv5: Add link property for
 MemoryRegion for DMA
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-12-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-12-peter.maydell@linaro.org>
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

On 27/3/26 12:16, Peter Maydell wrote:
> The GICv5 IRS keeps data structures in system memory.  (Notably, it
> stores per-interrupt configuration information like the interrupt
> priority and its active and pending state in an in-memory data
> structure.) Add a link property so that the board or SoC can wire up
> a MemoryRegion that we will do DMA to.  We name this property
> "sysmem" to match the GICv3's equivalent property.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   hw/intc/arm_gicv5_common.c         | 8 ++++++++
>   include/hw/intc/arm_gicv5_common.h | 4 ++++
>   2 files changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

