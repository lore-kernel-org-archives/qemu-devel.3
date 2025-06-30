Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866CFC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 09:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWAWM-0000tO-Nc; Mon, 30 Jun 2025 05:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWAWL-0000sO-3c
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 05:09:49 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWAWI-0008D1-25
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 05:09:48 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7115e32802bso18840487b3.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751274583; x=1751879383; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8aLa30mfa1QZWGHp4Pv7l5Pn3jAcwhk8PsVesC+g/8o=;
 b=ThoWlhdxBRUhY/YRvOVa1RNmATAUU2GVtHlelUdH1HtMjtluVjiG9QccajJqASX5EV
 oL22od6N/VpEJdIedr658jP+SqNZBz65WWj1v3290Mgu7I+dirl94nL4RPlp8FicrPqt
 l58l8T28Ilj/xk50dxzW5R3GI/Wfr3C7YEaeJcnd4xleWON4I1kAvi8mLvvN0eQGy47B
 IPBu8cuQwFv+n2ENZv4YfNvYamneL8z2YKHlpH7RSTl8H9TGxHlOs4voMB9tmEe3s3wD
 QDwoZGBA9RlZ83bmTCVKwxy+B39Q628TXsGrIe0KocRXRm97qGXMGw+xRtuAdlaITopR
 PRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751274583; x=1751879383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8aLa30mfa1QZWGHp4Pv7l5Pn3jAcwhk8PsVesC+g/8o=;
 b=UgRU70Rheq5ZLgRhGI5DtbYO+AmncblBaaUXG5/scqO/G1VWW9+s0s4gn5dDvaZRc6
 OVu7K21GNzPLrxF8KjEjB5VlPL4Daz7rW99gAmPxTo1L1reMp0cHgsCSrdFM+qNSEEaq
 7mb5iGEWS7B3NR4O+4iyQPzhb1zq5Ct4t3MhEuP1LJDh0BPSDWTvOUzCDcOHTM+LY9YK
 kYyhh25bkL8Cvb/XmkRvxWrLW2DJ+ltLYh1yKL2gLtiagheqqDBFMX5m/kkQhrokMHOV
 q9qlI2hn04tngjDIKcU2VO77rX5+04DFKRgba+JQA6ypxdzNRLW8lW+Y9ZeCDMwP+gqa
 MBcQ==
X-Gm-Message-State: AOJu0YylbwsfjYH8tPz3ya+aWJbXeyScZs5kVePP+j5tqxPyQJdeuJU/
 MXt9bZ5ByIxWeu7Ld9aPMrTI8a1ZvHSQ4QlJPUOYtQeW6CzY1IzG4WMMd5ZR3zK56czzwgfDBPk
 gHhFSlWiE/NZGDN5gPqPINXpozkFqLX0xFPqGGX3SMA==
X-Gm-Gg: ASbGnct1s5pEMPTqxZb6NjUwY0QeKACQ42B3HthDqAMY2HXCWaqJrhnSW3Gpnnp9l7K
 GQXxNi3topIeTzp3JwWyIc8+8IhHBGGHRLdYPoH1nTjoVi9Vvz0YzBqQ78sOEUA2Oi6ktalqn5y
 Mshz6T3yPCoFiDIIXS1qwp1yKfet2qkBAlThTEdJevIMG8TzppFDmDo7E=
X-Google-Smtp-Source: AGHT+IG9lk7cGLYs8qxGXrJfAZKBDGyfdMPVr1EUXfZWndJ+UxwNlpR3r3+PDLiKrI+mqcZGHGL7X5I6UEhnFL0x6fE=
X-Received: by 2002:a05:690c:4d47:b0:714:349:583a with SMTP id
 00721157ae682-7151719c76fmr196612007b3.32.1751274582806; Mon, 30 Jun 2025
 02:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
In-Reply-To: <20250629204851.1778-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jun 2025 10:09:31 +0100
X-Gm-Features: Ac12FXzsrJq8SMsscGWNIw-g6uIlT--_s19vhIkbjNwE2ZQz6x2enyqrP0YbrV4
Message-ID: <CAFEAcA-HaQwySM1j7Cy_R1z0fM1D9ykiBiMKLYNVYF+Tm_mrPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sun, 29 Jun 2025 at 21:49, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Allows the imx8mp-evk machine to be run with KVM acceleration as a guest.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/imx8mp-evk.rst |  7 +++++++
>  hw/arm/fsl-imx8mp.c            | 33 ++++++++++++++++++++++++++++-----
>  hw/arm/imx8mp-evk.c            | 11 +++++++++++
>  hw/arm/Kconfig                 |  3 ++-
>  hw/arm/meson.build             |  2 +-
>  5 files changed, 49 insertions(+), 7 deletions(-)

This puts a lot of IMX device models onto our security boundary,
which makes me a bit nervous -- that's a lot of code which
wasn't really written or reviewed carefully to ensure it
can't be exploited by a malicious guest.

-- PMM

