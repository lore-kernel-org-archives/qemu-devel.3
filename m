Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E994CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 16:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuaGn-0007AB-DI; Tue, 18 Mar 2025 12:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuaGk-00077u-W1
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:58:23 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuaGi-0002tV-S5
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:58:22 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6fd80f30ba5so39327627b3.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742317098; x=1742921898; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FIGb67/7AZLB1KuL7OpgzdcNpN7qc0dd1bxQgjTt6FA=;
 b=aXH2u7yFmwt0txxpHeaBseS8XYq/w5pv+IwgbONZSSR/QYOLf20M8nEweMCL1nd6hK
 dCnrLQkhRSUvCJUAZbZmBBbGR+oXxym8M5avmxHxT4rQOjIHhLtIWdJexury1y981ZE0
 ed3T0Tzr9nd8/4rLa/Fo9VlZKKE5n4ClBTzL7ZlCbs0dRcA2g2+Vo+6OhtvNjhhZJd4n
 Q5aLwWF+tY3zsZnT8ULWxKrmGHuQKxOXs4wKOYVVIh76ys24P3HqYQMHqat49C9tJgM9
 O+ah1ezXRofiTCMVcVloYqdteUYpP85liRVPbHxDnso3eV1x9lWkxUgpgANb5gPyI7eQ
 2z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317098; x=1742921898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FIGb67/7AZLB1KuL7OpgzdcNpN7qc0dd1bxQgjTt6FA=;
 b=oPCHaEmZfsrgvqP4JRSyVh9bJkHJwkrxO5P8l5NYiNjiY4GqRkiVnU4So2ANyBnOiS
 Z7PIEnhFzU48210sgFrw3zhno9RdT42KHvOPpF7UCZEjxKbXAgoJyKWM0h4d4UidOE3o
 +qtNwcPGPOpnjHecuWBWECeBjXklzUfFVfQwQkS06mPHeeczgPXGJpVoOaQGvBQgDQk5
 +l5Kht48khVE7C2/8sl/w0ssjw4l5/u6xjiLKIeDK26x5qn/zxtbCiake1i7TZzm1xh/
 IAgFe/34wDO0nIoj0Wq0zSgfcSozRpOpBz2JW0JHH/ei2sFnpMK+DdXOxdDWqwBAj8Jw
 DKQg==
X-Gm-Message-State: AOJu0YzxVNHExW13KStdNrZIhQhth0wUWIQccu+Z+HoUJHeguGQKgP3z
 qPSpY+7dN1Oipzc4NMqscMkt3UDzguIR8opYHZjxPhNG+Kpu2NKPE8h7ND1VbQq3sXpZY18Jw49
 3OR6lrq763gAR5rDZfpw18XpqVqG23vN/XQIjUQ==
X-Gm-Gg: ASbGncsHuTuvoSSknZA0dDVujo8ejFfehPxKgi6JUKjDcpnXuAWqh63kh3vOE57MIDf
 BgtKE2FpgFvm21Ix4Q4uEuLViTXoBvgbZlRDNDdY+Jxgavkx94OpZegRy+hp3GpRxGZXwLjAHdj
 MrPMN4xUcV4vue94iJ+4xmmuEabhQ=
X-Google-Smtp-Source: AGHT+IGXkSMUjsjYWl8UotirLAjeslelAvZhn0nz109CIadVq69i25YU27jXJ5c4/994S8WbUw6OlZwATSdubenj2Kk=
X-Received: by 2002:a05:6902:220d:b0:e5d:b9a0:a14a with SMTP id
 3f1490d57ef6-e63f6533d03mr19926023276.24.1742317097852; Tue, 18 Mar 2025
 09:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250318061420.20378-1-thuth@redhat.com>
In-Reply-To: <20250318061420.20378-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 16:58:06 +0000
X-Gm-Features: AQ5f1JrMe_AZqZ2w4wIPUxyKBCnMWSAad3ROqzh2YR5L9GxQZI9LPBxcPcRXknI
Message-ID: <CAFEAcA8+5pdLYeXGP7orv1cH6AscuJ-tDadQUAdSEcVptWtuXA@mail.gmail.com>
Subject: Re: [PATCH] docs/system/arm: Use "functional tests" instead of
 "integration tests"
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 18 Mar 2025 at 06:14, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> We don't use the term "integration tests" for these kind of tests
> anymore, it's "functional tests" nowadays.
>
> Suggested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/arm/bananapi_m2u.rst | 6 +++---
>  docs/system/arm/orangepi.rst     | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


thanks
-- PMM

