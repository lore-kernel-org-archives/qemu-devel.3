Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3E7C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhs3I-0002e9-8K; Fri, 01 Aug 2025 11:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrL7-0004C2-MP
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:06:37 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrL2-0001aO-3f
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:06:33 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7183d264e55so24163937b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754060786; x=1754665586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=50Sb2zVSgiKAqTfxpXxH8bAZ5XfaspGMx5JwS450LOo=;
 b=ilsmMXsvLqKbE6uFyblrv7eM5F6beYvV4jvI/BxRRbP6iX48HbURM1G7KD101cnW7W
 f2OU8gpMwqpJe7fgsevGrPoTmqTFCs/th0L5uQoWWS3gq0xb+a+pAuZ0Apd+sX5xrbap
 BRH2D3I8z1gYXUsz0yjvk5E62cV7Ntg5b8ZY5gd4p59W55XqrZjxaHsccjYMdpcLCkcf
 cd7FPcVHmK0C2nDSkKdOpTXbASQkV/Rbvj/SABKdmwYtz05exYmCijF441Qlb6xQwccQ
 KldShG0KisnOmVvRfPO2PYcwdQrFgmtpDQu+dSoO7l+K4an+/4S+UH6MR93I6LIhKvyA
 hEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060786; x=1754665586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=50Sb2zVSgiKAqTfxpXxH8bAZ5XfaspGMx5JwS450LOo=;
 b=XtIZdhg9aKbWH/TM+3dNCm/noh2fdyJiRcll9r+JRC0hMBVcZzpCHR9BZcH+2ao5bM
 wROlbIPIZBVVkJT5OevJssZzep5dUaGiEs4zXgopU38xTYpn1S+1pvrKkSOX+zS2XbBC
 Jxby0LK/TTqdAYb0rYde1SqJahW8jevJirIpfMcvyF52nw/KFvsJxztWgqN0qZOCXTnu
 z1OXRMxOg5VK3bWIFvfYWe7Hji0KvXkGQsGGT1PUtsnGGuffgt2jBEXKV6GlFjhrqUEY
 T23qxisynIrPDaqGKJZ4upMy4tjI/3xdOApBm4KPiYzyomg0H88YjkhD/bL3AFNiR5sP
 iRpw==
X-Gm-Message-State: AOJu0Yz3Phze9t4ZdCwMN3vQTjE/u8iZTdQhBI12p91LWtd/Z2xtGQ6G
 khsQGnnIEoZ8J6+Db8+54hIClDKONEJvoXRinfF2S0E1c4uWCktuYUTtM7wjJK0LX6cbqnAIy0R
 1BN2SF7genhdDmoATQA/QXw7PbFLoo9HMEAUO/xTA9A==
X-Gm-Gg: ASbGncvZWH2o2Y/18WpUoHBh/2Inuix1x8w8xCjz7Q4KqC+9HOd0Tr0atn2lr8B26cR
 QfvjBkS9H2KnAcfd+7nk4KoXk47+E7GxjjhIUVTbI9McWHWZWrSwpKBVpLCiG5taBgr63P+90LQ
 xdgwcrC1izuB3HuIg4faKVm8ROfWAFFeyrLIg0xvBCCKsotRypTJNGxbcABOuaTiklXV+/OZwvY
 m3sQVs0
X-Google-Smtp-Source: AGHT+IEh8EaQdoycUu58fYJGWf9ujIZDjIcjxhitI6T/wXzVsLVz7uCi/H/p/UA+52UdJ4s5mJuLEYNWN3//Cidtjeg=
X-Received: by 2002:a05:690c:6f83:b0:71a:51f:81ba with SMTP id
 00721157ae682-71a466bdf92mr166918227b3.31.1754060785882; Fri, 01 Aug 2025
 08:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-12-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:06:13 +0100
X-Gm-Features: Ac12FXzlVGy2RXq0Ruz0tPuVC_1lAkeuYUaulDsKYV8az-tD1x1He9eQKa9w6u8
Message-ID: <CAFEAcA_3GbH+fMOA8Za7b=SxFdqTHEZJ9hJHKdncrcn-iUxWNQ@mail.gmail.com>
Subject: Re: [PATCH 11/89] linux-user: Remove ELF_HWCAP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 30 Jul 2025 at 01:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All real definitions of ELF_HWCAP are now identical, and the stub
> definitions are 0.  Provide a weak stub as a fallback definition.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)

> +/*
> + * Provide fallback definitions that the target may omit.
> + */
> +abi_ulong __attribute__((weak)) get_elf_hwcap(CPUState *cs)
> +{
> +    return 0;
> +}

We make very little use of the weak attribute elsewhere in the
codebase, so I'm not super enthusiastic about adding it, but I
guess for linux-user we don't have the portability problems
that it can create...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

