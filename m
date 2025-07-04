Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80907C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXkAF-0002CH-CH; Fri, 04 Jul 2025 13:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkAE-0002C9-9J
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:25:30 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkAC-0003rZ-Gj
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:25:29 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71101668dedso8298447b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751649927; x=1752254727; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WtZeJrmJk9u0FGNZ8moIbXR2K+bgnaH8uMSkA6Ti51Y=;
 b=fZKge7l4FCO8RjxaIgzBphh2Yvhtm6dXDot08ZeWkSJh0ONDofzDXjCMn9DnnxD0yk
 7mPHvCrm9VdgBHqZphhzJnAyhjoWUMWlI32IAVdXeX1TPcuu9JF9oiIwyeIkp3CnllVl
 RYlWCtsXo/xpsnzZwFGBNmd1kG9Fctd+b5+PxWVn7zvNDqDubLgZwh3wLCx7bAQyQYiK
 lhY5x2pdRpJvvGe9N2TNR9k+68jlXj4kgH+wREvi0x7ZwUT/sCsnq3bGHvSPVM2qglu8
 YS6htvVSefDaNo+YgkkrhjbMONNrWDaTRg9Kc+Yx3ofDzpTyyUPTPRHp4oAMB0ElCLFW
 RmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751649927; x=1752254727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WtZeJrmJk9u0FGNZ8moIbXR2K+bgnaH8uMSkA6Ti51Y=;
 b=nysKHVSiNBC+wfmZXyf/CoDJe6wiyOp48w2PaQKqAFV/XuFKH8q0i0yHvY3MG3q4s5
 DL0g0Tsq263/weCP79zeaiDWsnnXXHwYLDlQK9TiPZ5umadBsbPKH3R8+KpVAh00d1hs
 wMHh1SIKrPY/2KPNCjG6Ks/lGGpfC2dKUA2yd6zXSd1DPozQQvNIdmgum/BGcbT0jfTn
 s8DA3JELnbfyNdtZ74rsoOjA4jbIiyRXBSd9LMX5qVReccV/9wsdPHH/U4ebvOgS/qDR
 hQDmGEEoKLAk/8I1h+MZ+920gA034YnUGMZpCMmna59gSFHRnv81x9MkAthpNFsB+rq+
 4aaA==
X-Gm-Message-State: AOJu0YwArPrlhf3E8TnOVXPxSVawwAKD2vC0OvcWlU2ntz23pn0ax9ma
 Iprh4S+dABYS1GWMCXYDUUIj+D4XNL0m6Y3vPd7jgvSUWiO8fDmEbJBS+0vos2gqB1Uj4TF+x2D
 seeujOW2i7PsTviPvDmKDd81XWOqgDz7xQ9C0u0FkDg==
X-Gm-Gg: ASbGncvgJ/eZGJY/Z86WdN8m3oDNm5UvTYD902cGWywNvZJYcGA8V6xRARApRRiigYU
 18kA/9T1d+l3eJXrQl5YgFdfK6OLohzsGI/M7mRSda/W0Abj0gwbZ/+72BrPSrg7N1bLH5lJcHs
 nppLox+LfC/+ELexQrCS1RCZsugdHwXLIjWidspu89FO+t
X-Google-Smtp-Source: AGHT+IFcz1yXFBQgQFbExKYN3T4TpBBFdj6u3xmujwzNW0dD1fT9c00Z6vIKkNjimr5nAqyOjXUxfUXnM1ulmKYgR+M=
X-Received: by 2002:a05:690c:7704:10b0:716:5986:e4c7 with SMTP id
 00721157ae682-71668c51b51mr34441617b3.11.1751649927139; Fri, 04 Jul 2025
 10:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250704165729.208381-1-jcksn@duck.com>
 <20250704165729.208381-4-jcksn@duck.com>
In-Reply-To: <20250704165729.208381-4-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 18:25:15 +0100
X-Gm-Features: Ac12FXxBh-OSGB8s1937FP0K9HBVvyW_79Zrt6o7zSz3Yffi-jpfpVqprGfSnVw
Message-ID: <CAFEAcA_FAeRqDqsLhv-1q4daBycoms3dGDtamoxCfQ=5huT_Tg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] MAX78000: Add ICC to SOC
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Fri, 4 Jul 2025 at 17:57, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit adds the instruction cache controller
> to max78000_soc
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/max78000_soc.c         | 20 ++++++++++++++++----
>  include/hw/arm/max78000_soc.h |  6 ++++++
>  2 files changed, 22 insertions(+), 4 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

