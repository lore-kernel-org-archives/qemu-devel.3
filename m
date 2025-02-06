Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E72C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5eV-0004cA-QJ; Thu, 06 Feb 2025 12:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5eO-0004SP-M1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:26:54 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5eM-0000SQ-An
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:26:52 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so1061707276.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738862808; x=1739467608; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RU2PjHyEPiA4JQafdV9M8McwAIpy1aq34IklMRgPs8o=;
 b=sXCRrNrNjHPCgJPv3ESTAPBrkkqLDdlmecXLNRKvVX04fYWkS6mLw7TAXfnfmYJT0l
 tddKpR8AI2IIY/HphjGMrV6rF0DonVGbSmhYFnpfFaoU3sJYTrzP8UKUvDL/9s6Xeo1k
 QdflAJElqL1FX5c/JDM0F0IyNZbp1U3RtBpn78Ezviea954/Z1fXenPKQY26NZDIFhgD
 yZ1HstyK9x6w9MoEIsz529WuqQ88/IL6g6iJc+yVdX5RmKbayNWYpP79Inf+PjFQYWls
 8IuY+KmxcOfih+ihm7Y2JGHfwpuIPe0XFsXdTRimrlHrFyPjA/6k9d4QgLvgVgRS+KW6
 C9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738862808; x=1739467608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RU2PjHyEPiA4JQafdV9M8McwAIpy1aq34IklMRgPs8o=;
 b=o2uZ7aZ4wZJE+wzHo89XdgV0Isx+HvFJJxQoXq7mklXQ/dyGH5h9H2GvXaTs59RhYp
 EtUGVof9gcZFIbd8IGysO3nUSgr5ZDBQbWQtaSgUcaeRXsaPFJMoafe1AbKQ0/zHcWQm
 6W03a4IoOBjCFDuEjZbU3Vj28Nezlc0k2Hc9sN3MAQBqfUgvbirx7Vj/R8jtA7lnheZM
 lJlIG/lH6rnqmNY5YhJAuqWozOm6ilkuuX8FVjIq6q8yEepGUoB78eZ4o8QlehGckWgK
 e7M2p4yOlHHKEeK2AhjbErzJ/o6XMg34HCOMFnyzBXQ6npDLk22vlickHzJ6VbL6Inig
 rybQ==
X-Gm-Message-State: AOJu0Yxp/ipOPVnaNShlMepF0gr25JZbg9C4nGyh3X6+WVLjY8xvV7PK
 XmLEekZlNQ7A3QjwKECzYV+l7IukCf4r4OJi6Q0UArc+k/TYU9GOf1X8aXxSd00J61OfHescjX3
 /cKks1060tXDgXVTdCm+f6kyikiqJcSNUJkJozA==
X-Gm-Gg: ASbGncsULPgs1zYmRtGCA0h1gfRJ2G7vfwr5IsZBNEw9yESm9KlpvOyRD+gLO85NlhB
 wwCAEIE1vGp603mkJNJ3O+7I1i2v5ZoeZ2Kn6umMqWZMlNGmgYMy0kMFDcTONQIjPpvwyi6H4Yg
 ==
X-Google-Smtp-Source: AGHT+IFSaFm5DVNdZSexqCDe82jU1yapPPJxpjRQUDWv5jNRdHd4Ua2yEV48yX7qgY3p7d+8YPlhHY75o21U2OgQMek=
X-Received: by 2002:a05:6902:844:b0:e57:caaa:fe60 with SMTP id
 3f1490d57ef6-e5b25c59369mr6539321276.30.1738862808299; Thu, 06 Feb 2025
 09:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-11-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-11-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 17:26:36 +0000
X-Gm-Features: AWEUYZlt-E9b9_dhVLc8xYIu3q4g17NqEySlit4XbSwIzdZka4g8C-5RGkNB2ms
Message-ID: <CAFEAcA8abT21kO1=Ym3AbE+A52BR5LKw--jiLwEJRLXEjGnRsg@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] hw/arm/fsl-imx8mp: Add I2C controllers
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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
>  docs/system/arm/imx8mp-evk.rst |  1 +
>  include/hw/arm/fsl-imx8mp.h    | 11 +++++++++++
>  hw/arm/fsl-imx8mp.c            | 29 +++++++++++++++++++++++++++++
>  hw/arm/Kconfig                 |  2 ++
>  4 files changed, 43 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

