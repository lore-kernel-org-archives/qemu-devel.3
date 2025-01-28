Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3F8C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmTl-0007mW-Pe; Tue, 28 Jan 2025 09:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmTk-0007m4-QT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:12 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmTi-0002KG-Eb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:12 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so8961286276.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074129; x=1738678929; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kaHVxl7vuByWpkORZ5+/TJjUTPhuNzyYYiswskPNg9A=;
 b=PHxMzgdACBQ1j+hkbv+pG5d6U6FCnlA01JNdqWQaIOxXZn7WVTiJp/6xFA8Ms5rLyv
 JgYDcCauAICFaCcCrmJYc1z/hA3Xh56Sm7YnkJqAB5kSVeLSwUIKsqxHSzhSQ2i7TOFC
 8uZEKC4KUcj9rgTk4wwYiZP++WAv62zxrqpm7KdvdDofKIGXaYFNdrm4fYte5xNp9cQ/
 JAE1J31K9Y4RXGwhcM6VBvR/A0ZZWwW6mU1JJDVEWULQlDZSa0k3p3HnlJ7rYETUGYEj
 cIftdxbOgEu5enV9fcH7eEZ6JDhNrZ6FYSyq3J47ykZ2sLEClFlz8FzUNHEVDKk468kt
 vduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074129; x=1738678929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kaHVxl7vuByWpkORZ5+/TJjUTPhuNzyYYiswskPNg9A=;
 b=JIuotbT3JAs/LI8SnLLd8iuKFvo7aBpgTwlSHi4+EfDlh9jM3UWkvnOfBOss6Jo7Uu
 HLXLaiCRMfH17lTE7CmY1JEZZfHhXh2aF8TcVuzjAntyGQhEnUECA8CQu/dcj5OkwL0q
 qEX1f/UhhIn4b4b08ZqobWW4N9P0kiv8Kgft33qUGnt9X5IAmsgCjtaWY5OVMnXVjyWj
 Sfwcczpe1hGD850jbojW1v+PS7yXmqFG2lbO9XtqHi5/K9pOkb+bOy+jRkyX7I6TFsro
 Bj3t4cBzLMj2VlXy72tXTBv1m5G01vA1rMMfqqtb1llCjXf9keINlPKM3wj+i/AwjTkG
 a6gw==
X-Gm-Message-State: AOJu0Yyf0qAb9QlXk+fe2IshRWBX4SvNzhkiCdzinfTYB5DIaycwtS36
 e4euAjIhkIrn1qqUpjo5yucieV1LbJx7s0MFVOdQYMJD/UVNbKvHwpbAYXeFm/iDYAgN/A/+pBf
 aiH2v7GbFwyMqcedwwS4agEW19audlBZsgy5QoQ==
X-Gm-Gg: ASbGncvLQzIrh0sUruH52fgD5c/poDlxBgyfR5kXBaeiEYzjirAgEZGUjOvsxZTJ1nD
 pFhQSq/LWe9vxIin03ozDUxiv2VMA1gCPifaUw2pxfXKW2n2y6LicNxeUHrc8zFjDjAGs8qb1Zg
 ==
X-Google-Smtp-Source: AGHT+IHAaxYO42OHGoMLQlf/73c/OjV0RAeuDh7eWlXaYi8Orjf2seIyuKAO5bkHjr+vqP32pZ9iVuyZfrfKi99k4XE=
X-Received: by 2002:a05:6902:280a:b0:e57:fed9:4c75 with SMTP id
 3f1490d57ef6-e57fed94e07mr20864599276.31.1738074129234; Tue, 28 Jan 2025
 06:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-5-shentey@gmail.com>
In-Reply-To: <20250120203748.4687-5-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 14:21:57 +0000
X-Gm-Features: AWEUYZmi9lXA-sG-VLB_GFQV822NzwUmoAzAShj_Yg_oxOpUN_S3sWM0brgr1ss
Message-ID: <CAFEAcA_8wekDxQr8i-Yn1rkY_35awVyGSxXGs3UEuE4G9_NyXw@mail.gmail.com>
Subject: Re: [PATCH 04/21] hw/usb/hcd-dwc3: Align global registers size with
 Linux
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 20 Jan 2025 at 20:38, Bernhard Beschow <shentey@gmail.com> wrote:
>
> While at it add missing GUSB2RHBCTL register as found in i.MX 8M Plus reference
> manual.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

