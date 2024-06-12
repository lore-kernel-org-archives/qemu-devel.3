Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F53C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNKb-0000fH-QC; Wed, 12 Jun 2024 08:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sHNKa-0000f4-OG
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:44:00 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sHNKY-0004w2-JS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:43:59 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57a44c2ce80so2918699a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718196236; x=1718801036; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a6Z9l4OM12s+y3i5qYzl3jFyyWGAXUxR/En1lgW6sh8=;
 b=SVhOCSLSG9MCe6If1hbZeC2qOIIsVmIstatskSKfWuVK0JG1R4vzML846Mb9IkARvQ
 2XNrwnOjCdbDYcrbaJXSJZFnYh8DJUtNvTe9h9+qulldaieei+m9z9ugBYexJBRKRGom
 WJGhtEYeJ63OU9obvWmVZyUJ0tGH08xU7HSeJaD6i/eqzYqj0+HtCL8pfVl0GJp9JtxY
 c5IDClnRW6/vz8xBf6+8s8/tDJ0CQkEhXbHFyC33bjlTIy33IkMeQJf5gVJIz6J+UOe0
 7QRfy+kFPMURd3adZjQxHmTxyiS1Lv8dEZER3xBuM/bASSYuGx1lzH9Id6AXLMpQ1fHv
 m2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196236; x=1718801036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a6Z9l4OM12s+y3i5qYzl3jFyyWGAXUxR/En1lgW6sh8=;
 b=kMG+AqVVssfI6J1tGH3GezJE5aFgn7EP+H87Sxf6DdqgfJTx7Y18HYEuV20QVdshyb
 eSbKJVw1UoW7mqnIb4xBdwhBa2zTsV4m/wJpmB0N/K0lSszNoPn7nQcGqyoxS8QyJiJ7
 em/GL6Mf1MnncBvYBPOCp7ja9GgcNNgiWIIjF0QwVDVShFaLw7QBlVeG4l3f/BVur74X
 2IHrX5B5m0JIP0qbi/L0Ei7Xu6cN/44/W3jJreY8qzTeeJHdvoZy0erkq+KdWtqa7RWQ
 yjHZIyoJ3ouuKlyVL44/roUxl5rPPjJeUeojREGRWnEFcJjHz5l/R5y+89+yjIikmCaS
 H7Gg==
X-Gm-Message-State: AOJu0YzGZmbTESbgc83pZpb2ZEjrQaeU0xhZjBknA2aJGhFCXiYr7ftK
 DVtlAzpzTaOrNh2NUUPWlto22XjyVknSus6Ui23IU0ODB6gwvbahbrXbWTn6MNZo2mPZZXdwge8
 L3CvuiXyqwC5TL0C2jqhKU2HQtSldEyaBysnHvw==
X-Google-Smtp-Source: AGHT+IEVFTa0J7FzA8z/q1yfEDiaYFIx4zsP4w4sphAGh0Dl2jGlloudNK8e3pOgBhMHWNgXCCNWrQlSlrmkC1klAvk=
X-Received: by 2002:a50:9348:0:b0:57c:8105:b9a7 with SMTP id
 4fb4d7f45d1cf-57caaaba16bmr1044406a12.29.1718196235879; Wed, 12 Jun 2024
 05:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240612090132.3522566-1-ethan84@andestech.com>
In-Reply-To: <20240612090132.3522566-1-ethan84@andestech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Jun 2024 13:43:41 +0100
Message-ID: <CAFEAcA9W1EN7eO+qa6s9a870s8Zm-mD3T0mxRUY5hjY_-ZE4bQ@mail.gmail.com>
Subject: Re: [RFC PATCH] memory: Introduce memory region fetch operation
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 12 Jun 2024 at 10:02, Ethan Chen via <qemu-devel@nongnu.org> wrote:
>
> Allow the memory region to have different behaviors for read and fetch
> operations.
>
> For example RISCV IOPMP will raise interrupt when cpu try to fetch a
> non-excutable region.

It actually raises an interrupt rather than it being a permissions fault?

> If fetch operation of a memory region is not implemented, it still uses the
> read operation for fetch.

This patch should probably be part of the series with the device that
needs it.

thanks
-- PMM

