Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DE6E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 13:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMSMy-00052i-AS; Sat, 14 Dec 2024 08:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tMSMv-00052O-7U
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:39:42 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tMSMs-0008Oc-W4
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:39:40 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso3178373a12.0
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 05:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734183575; x=1734788375; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EMBHIQkG4m2krJUW5sPQ9UuXOL5SIA2WgXPyp2MJb3k=;
 b=JHKQ8Q5AV7li36tTnrp1TuabA7dSjuT7VyKed/Bept6XJFpPzYni7qPqJdhWzEz1ju
 xBHJwbWdkLGmzUDmtlGLMwqz/At6XveEGX1rIagdUgzaGzrKYMqQ9RIdfbMUAYi1TZ5B
 BJuRfh0RPyEcY+qH2O4u9WkCtpx3khj4Y/ZMkXrI5WcPtzl1ywnKPLPBGsBklHNybhB3
 US52G10+4dOIHdBs7fxnmetkBWWJWa1GcvsY0n5eAWE+TPMPTtuBgsCfp9MTuPCunEOX
 N0WqOsf0CDEAuWMERsUUUSoMBhwx7YGY1/wIwYGSwY4SRp9LTFXQkwFI6qAzIpZXLAcZ
 V4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734183575; x=1734788375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EMBHIQkG4m2krJUW5sPQ9UuXOL5SIA2WgXPyp2MJb3k=;
 b=psp4IO/wjJvnwvj2F19yS066sG4wjEaKxk4YsO+TJjqvqho1x49vUtD6nA6jUcF6Lj
 apdcHufvPt4HXUQs8vUmt3HIL9Y3emFtI0aNDlAFgR9vGGJnISJtEc278f7qY5H0u/P7
 RrxXgzRgN2vKgunWkOPadLsYH6cqsaLt8iJejD6GUziQ+rls9QMJW6xLbUtHBpedF1jl
 mQbJl+lxL1yqjoyQW9h6vha8reTUBkLHDylfZsNjbE0h4Z4oohVbcMf9d1+sCSee56Yq
 aR7am5nzeylPgE/s2IeT6BK44tTMzRaaj8Sm++Yp7UXDj8k95NaB5NriT7bIQrjz1Rj0
 vP5A==
X-Gm-Message-State: AOJu0Yz7um1wkf/3QyeUJn3X3epQCdiPmVryIIOzKwIKx2hg4MxlQpYq
 vnWv72X3QovQyIypb5roGBikAy6nwwAXqh3qNSLPuL7SP8M409RWC/aVy3ARWZXYH/cWFpU4CJZ
 kzfznR9TAgcQN2LmuKT36DLiY0QQ=
X-Gm-Gg: ASbGncuqqm9jGuLBp0DlNL1EUGGUNakrp92nRnby0UxBmZ0JEo8ElPYKj+Y0sq5Ap59
 +FPA3Vgdp1b70iEQ7Yaw7TGmNw1ZSURV2IDbp
X-Google-Smtp-Source: AGHT+IFgkFWOFgbdHC26pCIuPDIApJY5C+i6QbbyNaLWPZTG5vMK6L8vDdS8yBN1hegUHZS3LrdzjUh+iD6dy1nt6bw=
X-Received: by 2002:a05:6402:1e96:b0:5d0:d491:2d5e with SMTP id
 4fb4d7f45d1cf-5d63c300d72mr14419135a12.7.1734183575010; Sat, 14 Dec 2024
 05:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20241213094027.1732484-1-maobibo@loongson.cn>
In-Reply-To: <20241213094027.1732484-1-maobibo@loongson.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 14 Dec 2024 08:39:23 -0500
Message-ID: <CAJSP0QWwaqbA26mDEM+-y0-rGicFgrSDH0n+EAN8d9LTWsbm0w@mail.gmail.com>
Subject: Re: [PULL 00/18] loongarch-to-apply queue
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 13 Dec 2024 at 04:42, Bibo Mao <maobibo@loongson.cn> wrote:
>
> The following changes since commit a5ba0a7e4e150d1350a041f0d0ef9ca6c8d7c307:
>
>   Merge tag 'pull-aspeed-20241211' of https://github.com/legoater/qemu into staging (2024-12-11 15:16:47 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bibo-mao/qemu.git pull-loongarch-20241213

This tag is not in the repository. Did you forget to push it?

Thanks,
Stefan

>
> for you to fetch changes up to 78aa256571aa06f32001bd80635a1858187c609b:
>
>   hw/intc/loongarch_pch: Code cleanup about loongarch_pch_pic (2024-12-13 14:39:39 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20241213
>
> ----------------------------------------------------------------
> Bibo Mao (8):
>       include: Add loongarch_pic_common header file
>       include: Move struct LoongArchPCHPIC to loongarch_pic_common header file
>       hw/intc/loongarch_pch: Merge instance_init() into realize()
>       hw/intc/loongarch_pch: Rename LoongArchPCHPIC with LoongArchPICCommonState
>       hw/intc/loongarch_pch: Move some functions to file loongarch_pic_common
>       hw/intc/loongarch_pch: Inherit from loongarch_pic_common
>       hw/intc/loongarch_pch: Add pre_save and post_load interfaces
>       hw/intc/loongarch_pch: Code cleanup about loongarch_pch_pic
>
>  hw/intc/loongarch_pch_pic.c            | 106 +++++++++++----------------------
>  hw/intc/loongarch_pic_common.c         |  97 ++++++++++++++++++++++++++++++
>  hw/intc/meson.build                    |   2 +-
>  hw/loongarch/virt.c                    |   2 +-
>  include/hw/intc/loongarch_pch_pic.h    |  70 +++++-----------------
>  include/hw/intc/loongarch_pic_common.h |  82 +++++++++++++++++++++++++
>  6 files changed, 230 insertions(+), 129 deletions(-)
>  create mode 100644 hw/intc/loongarch_pic_common.c
>  create mode 100644 include/hw/intc/loongarch_pic_common.h
>
>

