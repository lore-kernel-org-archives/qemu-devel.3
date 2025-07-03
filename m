Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ED6C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMUK-0006oM-0l; Thu, 03 Jul 2025 12:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMUH-0006lL-AZ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:08:37 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMUF-0006bO-9a
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:08:37 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71101668dedso83828137b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751558914; x=1752163714; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lCvU/m/7QnECpkclSu123WI8su8DE7lFRvsuZY4qDQc=;
 b=ovt2wfJLZXkb2jO1RwR8TwRktGJ8qKqyK/uKnScwtdQP8Gxfm062Uo4fPSB9G6J3KL
 eT5TPStcDTU+aG0gCFF7R7F68wLNnF1ELuFXqDNvkLt5A+DsLlK3KMbVPl1t0qOFa4JM
 78nmWnHKqacbbAPRs5HnjAhQVmJqn/HcNJkyTMplCZMZv94e9UoVhAU4GY9Te3kTmu1/
 Vz+AIR5D+aBZzsnbCADAbU8wStbFqhmxyQIus5kp7BiVJFcVtWTBc8wtspY3TP36lVbb
 NXb/fJIeylRUYMm+9T0xfx3OJeiCQ542P+yUVVL537Igz2hEY1fg7hBqNbuaKC8DSDO3
 5LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751558914; x=1752163714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lCvU/m/7QnECpkclSu123WI8su8DE7lFRvsuZY4qDQc=;
 b=Qh6XIH5z35BYhCF26ZY5qDc0z3Rha5CfPDQnQkLeFUgWYn75qVLN+/Ty1EGDZDut3D
 Lf0ZYQ59a+UJf6pxvCQXxma1iJqVAQCUCG6/QNAubAH5lSdd5h2lIUskn3Z9NqmI3lei
 oBl1FTN3k8ipKqIMbW1tfjCzbRfr438PGteA49PAJ6PALkKi4yT1bJGxgMSPQB3OQSJH
 7iBaHmXnohH6/zuvpRIVwMBanYMkvzs6DmR66M5q4/XZ5qzQo/b0xAiigRXwTBKnos2V
 lrcWGUuNpXoO7b/a8mHCIN9DAm7/WqZByAt7C7oFD8/jqpdIv/FYS5x5TgQEcVPHcpCj
 XrpA==
X-Gm-Message-State: AOJu0Yy73MvCaKXN4t0Ioz0b8f427Qu0Trnh8hr9CC7b9Ew5Rus9krDE
 MwjpqLUasJbVrv0FiyCeARmo55sXeSXhg1VMqAfiFwq77Dj/wQUN4OFbNiOfKNIe543FztRvQNv
 ocokekRx3yF2A0nDscvZQvuVKy2WPephlNREEorHwmw==
X-Gm-Gg: ASbGncu6J90M/Dh6+XTLgHBZFkUIIRMUPRGft8WDqp8kN9T4Gl6XzL+gPFNFymDAlS7
 EjosVp3t7VM4JbK15uJL2ag2uyE/SMYYsL9YCMF5NXacKMHiUH6z9W7qSLkP9xO6QEal6SbCbx3
 HjQUEsP+2LnxWW9DfV2GhiiQHPN3G8q0JEUB0A75RnlLC5
X-Google-Smtp-Source: AGHT+IFx0DCKfyIgRb2mdaTkK5oaiGsLkcfy1w3xy1yXLbvFBIB0ZcLcrzx37iWqt9DCZixI3+myjw9pc7bfi8yF8lI=
X-Received: by 2002:a05:690c:ec3:b0:70e:86a:ae1e with SMTP id
 00721157ae682-7164d4d0aa8mr105745637b3.22.1751558913557; Thu, 03 Jul 2025
 09:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-2-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-2-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:08:21 +0100
X-Gm-Features: Ac12FXwSVMnspAZ7PJaQSQiRwGkOnk_RpN31M6dI2KXO5ckblCezMpIsSAmEeAQ
Message-ID: <CAFEAcA-7u4eT_mah_0GGj3XGBVMZDaq-bQZ6Rr6wECk0cM5DoQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] MAX78000: Add MAX78000FTHR Machine
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Thu, 19 Jun 2025 at 00:05, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This patch adds support for the MAX78000FTHR machine.
>
> The MAX78000FTHR contains a MAX78000 and a RISC-V core. This patch
> implements only the MAX78000, which is Cortex-M4 based.
> Details can be found at:
> https://www.analog.com/media/en/technical-documentation/user-guides/max78000-user-guide.pdf
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/Kconfig                |  10 ++
>  hw/arm/max78000_soc.c         | 172 ++++++++++++++++++++++++++++++++++
>  hw/arm/max78000fthr.c         |  50 ++++++++++
>  hw/arm/meson.build            |   2 +
>  include/hw/arm/max78000_soc.h |  35 +++++++
>  5 files changed, 269 insertions(+)
>  create mode 100644 hw/arm/max78000_soc.c
>  create mode 100644 hw/arm/max78000fthr.c
>  create mode 100644 include/hw/arm/max78000_soc.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(in case you're not familiar with the email patch workflow, that means
that when you do a v3 of this patchset, you should include that
line in the commit message for this patch, unless you made changes
to this patch:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review
)

thanks
-- PMM

