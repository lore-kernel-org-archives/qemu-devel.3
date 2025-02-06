Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C691C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5jI-0000y7-TJ; Thu, 06 Feb 2025 12:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5jG-0000w6-4m
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:31:54 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5jE-0002ZC-Kk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:31:53 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e5b32f64ffeso1032718276.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738863111; x=1739467911; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=idp8YagOT72BvAuzPg0RgX1NZKUc5vKVHQTzZYr8yAg=;
 b=XoVEuxB0Y3RgqsqnrbbwCy3HJBToBhQ/5g1ePSiSq60JLi+coc6EbiQKiaEey4opBz
 JNUbv2mj5r2ZV6msBwSo37sDDE47ou4Zy0Y/fGBckY99AUkYpDhBJ4DCfb4dzskEONtJ
 bPTFzmW5wX51T3GCy5CBd4WE/HNoLa74VvJxKzSt4NI4OF6U3fLhWtlatjKw6KSkaq38
 orXkpkRf3xJh6BUwTY4dKcqlRFYzeyEYX9q2F9oopiyKMuw6C5iObENY1PNRdwANzjK2
 lG6LVLRj3Fp19hI58ptogsbvyNux26ezDKqiagRn+74lfYmPz3wwYVDDw7GWgZp3zJcY
 YzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863111; x=1739467911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=idp8YagOT72BvAuzPg0RgX1NZKUc5vKVHQTzZYr8yAg=;
 b=wyuwyuXhuBen3Ak/M9CCkYfUfxcHz3sB2xGDExYakvMH0WvVYUSwltHAuj92hnXpih
 0TRpHhBTQMl0cJp59ENcwDUJH08RcszA3dv7IPIAj2qotibCvQyIUZYpKEHkB/WI6MEJ
 wyk1U+SUp01eHkgQkvUZqpfSfuYjEtLJZwNGvrVUnbzNzFDRjchuJ6MeJg7mWf+6dm4B
 gqTBGlrQCxHuifgF+Zwj2Vpkc3WB+5QdMO0RjPqUURRzv6qkUewBl79LfjH7v+ScEbBH
 0gCZrxhQyLhpTk29yTdSpivEOo4ZnN328rwLqDDYz+hHJMG8nxRQCbpvsgx2osiBvycN
 rIbA==
X-Gm-Message-State: AOJu0YzUSx8ImiZC1uVIXr07jVSp3UA66UARZhrEgJC3U40KuYdlqwKP
 ktm9n0+F62OCvS7dKj7Za+t9SzVeItv59RwL6SkTTwQt+h+jJdlDoDrEulLwkCRLwmuXZJk3JPm
 gKjZB9dDgYDBOCNv3SiF+qR2HV5ho+2GaoFjq8w==
X-Gm-Gg: ASbGncvxQ9Qbuau6ajQosww8JJn4jheh4gkwq44finAp/jTSySuTn3aThswnU/S2bnd
 n37TqhXQjc5lVS/jcPfsfivPBoGWYu+XFBTqh8ATgrYnaR7R5+7bPK9odgNeI2oWvpZS74KPQvQ
 ==
X-Google-Smtp-Source: AGHT+IE1nZLSX+P/4ihTYO5/YZFdgD7OmYyJjhGHhTJZjP/BWKOl2N4nrAvBizblccNqGdW6UJfV11gtLDQMEswKm+E=
X-Received: by 2002:a05:6902:2484:b0:e5a:e6eb:d44f with SMTP id
 3f1490d57ef6-e5b259cd477mr7119331276.6.1738863111469; Thu, 06 Feb 2025
 09:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-18-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-18-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 17:31:39 +0000
X-Gm-Features: AWEUYZkNvJQHpOvvbvz9bYLCSlaCYZZuFmWYkOzOsjd2fmF2SAGxMy1cBxklw_0
Message-ID: <CAFEAcA-U8dmCVfD8n+Gc1D7z1gGyUa8ZXqWN0cMmUG1cxHreWg@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] hw/arm/fsl-imx8mp: Add on-chip RAM
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/arm/fsl-imx8mp.h |  1 +
>  hw/arm/fsl-imx8mp.c         | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

