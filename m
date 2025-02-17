Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E750BC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk3Hu-0007SW-Oo; Mon, 17 Feb 2025 10:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk3Ht-0007Rz-3q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:44:01 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk3Hr-0004no-8T
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:44:00 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e5ddd781316so998793276.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739807037; x=1740411837; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZhaA44eEXDUwObb4QOA7d1Iu1Es0Cz6k4D4/ctTUhI=;
 b=D19EaSY0qL4+yihXocJrg8CWNrlDwO+f4EvqCWsfbvI+sryKlJLGNu7vpYGuIxTTaS
 QAAmwqh7vBvcly+yT2vMY6P3otNpj92Wz5ZMt5pwh4CXrYcg3cicSXAoXKth9TKCOsJK
 OgthU3xroMr3k/qbUAMZMDaKkckg6YkNlNQA+mp45QNUaMNEB7X2GTj9pERTir5RWDTd
 w/0cm3wweb8ZFpfIq97n0oH0ML224ljWG/FmATDTt2soJHL6CaDcCbRNrEKIPL2z9hg+
 oWs8dkYcto+pxIQbxJX8ocl9V8gJPZKYJphQpwix3o5ZUclbfsnz1uysvdExAX6yHhoj
 LC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739807037; x=1740411837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ZhaA44eEXDUwObb4QOA7d1Iu1Es0Cz6k4D4/ctTUhI=;
 b=ipSNF4jynTlQjsTISgYrQsWvhmVtMa4w526jiI78BAHZMQEbdVBBHTmKIZdW1RCUMO
 +xOeoMgsYG2rpTRhvnw3/VvacRkF09PBMjwrgZmYpiB7J1bmi7iK/LuMrISnXIimPDW0
 7eVPhPuvz0iXGpyXRh+B49jBSh6tWPhohAGlM4l86DP12jE+GGCxVa0o5A1UZKlWlsXs
 SpjZGklivoyzhZF/dVO/oZhiG06ZkHo2cYvUAs0svGqYHI8OUJ9Lh8dnvQMQ9YXkJYAx
 JSOobP2+e0kjhVvlF0MfShSvbNGGIXrqKJ3seB8O5YmMfmLORUlFnb43xJD7S81epZ7a
 2PJg==
X-Gm-Message-State: AOJu0YwB3FMwJsVQ/cxaKt/li+5WhRCs8lPVK2E+l+lPCehoHVhdgqma
 cUaAlJ/brm1d81/j82d06r0A960WYz/7dee1HQv5kAv1vGu2YJfMaPwoHF+7JlDOW4KNj8htjpz
 fHNKfM9hGPIvxUSpDneZhjh04igxVlhFfg5suJg==
X-Gm-Gg: ASbGnctAKlwjX6aOo8qD/IbbKWS2pxrquuiu0QgYjVIP1zmy+KRD5mT/b+d8JQ7kcUH
 SKRkKL1lvao6hUSyEGKId9JMHElT+TY+YjeeJrg/CI+Mr5uXhLv9fmEiblOzUQe5JytlJoAlYsA
 ==
X-Google-Smtp-Source: AGHT+IGOzWVXwFQJA/8baRe/V5gOSsryBdIDyXfPSKlkbFCaL2kHImxuthotVbLHymUVk9X4Go+8iQqiNy+TPl2ZkYY=
X-Received: by 2002:a05:6902:230f:b0:e58:dbf:ed09 with SMTP id
 3f1490d57ef6-e5dc9038eaamr8213890276.3.1739807037523; Mon, 17 Feb 2025
 07:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20250212154333.28644-1-philmd@linaro.org>
In-Reply-To: <20250212154333.28644-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 15:43:46 +0000
X-Gm-Features: AWEUYZl_10_fWPu_ufGPbFmphxTHwnwPtq3k43WitvsAD-kUI4E1WUYoZZo1HWk
Message-ID: <CAFEAcA-4rdTWsBYKL05OKBQc2pLWoPsYm+Qdhb-ZD0qs0t8MQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] hw/arm: Explicit number of GIC external IRQs for
 Cortex A9/A15 MPCore
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, Rob Herring <robh@kernel.org>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Wed, 12 Feb 2025 at 15:43, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Some boards based on Cortex-A9MP / Cortex-A15MP do not explicit
> the number of external GIC IRQs, using some (implicit) default value,
> not always trivial to figure out. Change that by removing the default
> value, requiring MPCore objects to be created with the "num-irq" set.
>
> Since v1:
> - Remove generic comments (Peter)
>
> Philippe Mathieu-Daud=C3=A9 (8):
>   hw/arm/exynos4210: Replace magic 32 by proper 'GIC_INTERNAL'
>     definition
>   hw/arm/exynos4210: Specify explicitly the GIC has 64 external IRQs
>   hw/arm/realview: Specify explicitly the GIC has 64 external IRQs
>   hw/arm/xilinx_zynq: Replace IRQ_OFFSET -> GIC_INTERNAL
>   hw/arm/xilinx_zynq: Specify explicitly the GIC has 64 external IRQs
>   hw/arm/vexpress: Specify explicitly the GIC has 64 external IRQs
>   hw/arm/highbank: Specify explicitly the GIC has 128 external IRQs
>   hw/cpu/arm_mpcore: Remove default values for GIC external IRQs



Applied to target-arm.next, thanks.

-- PMM

