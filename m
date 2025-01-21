Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE3DC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 23:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taNRz-0007ac-At; Tue, 21 Jan 2025 18:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNRx-0007U8-TI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:14:25 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNRq-0005Y4-Lv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:14:25 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216728b1836so106912565ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 15:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737501256; x=1738106056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t3z33tv6jwE/6TT4f++Ndz6EAuuOnCB38tAEgKhA4PE=;
 b=fAsAbtG1bdJ7mvRV+YKmzhnxnCiEIpaUPnyeDd95FXak0fcB/WsF2geZkFaIt0TGyM
 B1FRyZ0tB0hf8Y3jRBz0uPw8JyLTEsKpxLF1bgaVdMuBQNCulOYmN+QMRp/HAvJ0QNsE
 gk6xgqJbkOTtP7u4/6mvVJFKoUdwH9yPcKtQGCBFugj+qhiajl//ANuY52AI10MHm3bC
 Shak3MUoIsl8skblbtKiDOQiLMlB9twRTKGHUBPz/ISYXNoMgYm9OJnBXVnGHNtIK0mi
 a9t9aF5buQYdsbQF9ZSbiwUG0uVf3HvOg4kQq6v8lRIqX+aBzSKI/+CQkJHHOezIM4WD
 nshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737501256; x=1738106056;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t3z33tv6jwE/6TT4f++Ndz6EAuuOnCB38tAEgKhA4PE=;
 b=l/cfNw/hmphzs4oTL8wWhbK8F5xgzboDJtg+nPzMIwjzg6wVuNAP+KCWkSqBvvBkeC
 U+aSnvPcs/i2OKwTVD2X8Zjss5JaMzZ6IiaMNQDUvECW2Q7H7Aa66q8T0PfKUn5+lgCF
 b1l6+Aw/mCc68yOzZrwef/Ox7lUrYFMXKzEvUtif/8Ub2fksQ94X73ph6MJYadYKRqiV
 MsX2zuNKsMnGfjDP67olm0R9QGVLODTEmXgh9O1uZ2GoYrTLt1n95y0aaOTQDNFQZIbf
 DMx8GQUU4r9HdBPB+Wnj/6h0uxc0MCLKC1U9BSkFrbJIxboMKxtl3K47ZRTCoUfTajHf
 hV4A==
X-Gm-Message-State: AOJu0Yxw1o/VhpfqFN7OGfCCiW6qfGfM1o6hL/knFEJmbipCIuqW5/mX
 xHG7OJFo5AGyUoLc5oJAgvyQwtwJFcCd5zAOBU9lpfg3QDmVSEosDNFfTz6jJbngGaXceIcYt27
 6
X-Gm-Gg: ASbGncvixW6UYhNBKLzWTp4+mcmkU/mhr47aPn+bXR7EFidp4HJIsl3jEnbOstJNzFY
 EQw81dHDJaRLn8h3dV6fuNLVCwwBhvnox/Elu/n16X+z9jzWHjMv1JS1p8tOHOKmVkrn5kCL4EA
 YDOLuDTzEBrDjLVZZkjksOw6iNorwmcMS8KOPuWWYsBVISWx4DpZHYm9gJ09ElSP1r5vDoNN3WK
 jrgmQXP/O3HG9Xr1+Nv0uGfzNFyxuH05mobwfUX/2kyy5cMUOXNr1vZBRUpFQQOTTBk2KMo93jw
 /5Jp11E/oBvEe4dOwM/j5/r1r7K2csnPvZIO
X-Google-Smtp-Source: AGHT+IFkohuns2B0SiqJtzSBD9bZSHB1s3kR/r0eikNiKwtK2LXkawRILnBYUDugWeZP4bUoN9uQGw==
X-Received: by 2002:a17:902:d4c8:b0:216:725c:a11a with SMTP id
 d9443c01a7336-21c352c8145mr320367875ad.10.1737501256348; 
 Tue, 21 Jan 2025 15:14:16 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea2c9fsm84071985ad.43.2025.01.21.15.14.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 15:14:16 -0800 (PST)
Message-ID: <5f244bf1-f2f7-4c03-92fd-9542db7d412e@linaro.org>
Date: Tue, 21 Jan 2025 15:14:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sh4/r2d: Convert legacy qemu_allocate_irqs() to
 qemu_init_irqs()
To: qemu-devel@nongnu.org
References: <20250121182445.35309-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121182445.35309-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/21/25 10:24, Philippe Mathieu-Daudé wrote:
> The FPGA exposes a fixed set of IRQs. Hold them in the FPGA
> state and initialize them in place calling qemu_init_irqs().
> 
> Move r2d_fpga_irq enums earlier so we can use NR_IRQS within
> the r2d_fpga_t structure. r2d_fpga_init() returns r2d_fpga_t,
> and we dereference irq from it in r2d_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Based-on:<20250121155526.29982-2-philmd@linaro.org>
>            "hw/irq: Introduce qemu_init_irqs() helper"
> ---
>   hw/sh4/r2d.c | 38 +++++++++++++++++++++-----------------
>   1 file changed, 21 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

