Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A72BC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhn6-00044I-QR; Fri, 22 Mar 2024 12:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnhn4-0003zV-4R
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:30:46 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnhms-0003yn-4E
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:30:45 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51588f70d2dso2698796e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711125032; x=1711729832; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uPweuQzZHN3q2pc8FHLfq/14jl+TvULObztzvlgzcFs=;
 b=FrGKDeEyFWtIwj8d/naMAJNqeeix1nk3/A5oXvWu41Rx786ULB9t6oE3lLUHfRmtvt
 W/BuX37mJI00rPOs25zlyl1DdZJ1NsMQqqFD/jlK6Ks/+Iqo9lLFNbb8ViGH+IHIoxB2
 x0Sadx1IdxaoLNyl3iY8sr1YuPCvS3b1zUTu9KDMWnDoGIbJLOsvylvno685YIO4z0Iv
 bl8+lZRD5JXc97g0fjYXdaZlkUb2R8DIZolOXsxlSRYVgsfd79Gz5CX8WYtYPx+OTO7r
 UWa9oqex80y13Jx8cgtwGPHoPHlr7qm4d+YiPBuD9AudisrAzHCxJyCESMPe2extlsSk
 vK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711125032; x=1711729832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uPweuQzZHN3q2pc8FHLfq/14jl+TvULObztzvlgzcFs=;
 b=LO23YdgIzic+R+zpxOZUYnOOXC4tOMPGVvMll017JygGZiGzyq3P47I0f+pDiziHg6
 psyIJHq8KkE4dx1+NsEuvwPqOOc89zWIUL8/v+5fWgBt/2OBexVrmvpzlADms+/tAdLW
 8p0ZQEuJT+QYQPNIlXZKEN6a2tH42MEz0jndBVJ99AK2ZCrd1333v+8XOxcI7S2cNsW4
 XT57hHb89zx1hUdt6zTTMo7NpsJ9MFqcWJ+8QL6uzErJUUteYsPbagUKtxst5Pk5/TnG
 OrTXufyn2DGUly3797B02JUg1RUhSUlGX/VN5oL/EGuGIUoaY9zpZbrLPCTcLAJb87PL
 cldA==
X-Gm-Message-State: AOJu0YzwWpYwqdrmSebkGsEBDr8T3ZCVyxjGgOMDQT1lgXPOhb4/ilBD
 qWD7hEVIu/8MIxWy+3IkedckMmrBurB96hcBt1DXQ+XEdk2c623eRp6FCI2i7/r4CGw31vZDNO1
 g3OdvBLJrGHiH5E7eag0VLCJiGLGhWxXqLK6lPg==
X-Google-Smtp-Source: AGHT+IHJuDCUZoF/JNYMwvSwigfJ1T/APDQjpvroUuSPK1lk8PWw7MIQDve5DNYduDoz4RvDp0EOTQ6qDnxmPTTr0/Y=
X-Received: by 2002:ac2:5b84:0:b0:515:9b0f:1235 with SMTP id
 o4-20020ac25b84000000b005159b0f1235mr1406003lfn.67.1711125032094; Fri, 22 Mar
 2024 09:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240320202100.820228-1-balbi@kernel.org>
In-Reply-To: <20240320202100.820228-1-balbi@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 16:30:21 +0000
Message-ID: <CAFEAcA9+JVFJROVGj=8RkfmBGqjODdWgE0Qw6HrZrHjhefSf1g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for STM32G0 SoC family
To: Felipe Balbi <balbi@kernel.org>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 20 Mar 2024 at 20:22, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi all,
>
> These two patches add support for STM32G0 family and nucleo-g071rb
> board. Patches have been tested with minimal embedded rust examples.
>
> Changes since v1:
>
>   - Patch 1:
>     - Convert tabs to spaces (checkpatch.pl)
>     - Correct lines longer than 80 characters (checkpatch.pl)
>     - Correct num-prio-bits (Samuel Tardieu)
>     - Correct num-irqs (Found reviewing RM0444)
>
>   - Patch 2:
>     - Convert tabs to spaces (checkpatch.pl)
>
> Felipe Balbi (2):
>   hw/arm: Add support for stm32g000 SoC family
>   hw/arm: Add nucleo-g071rb board
>
>  MAINTAINERS                    |  13 ++
>  hw/arm/Kconfig                 |  12 ++
>  hw/arm/meson.build             |   2 +
>  hw/arm/nucleo-g071rb.c         |  70 +++++++++
>  hw/arm/stm32g000_soc.c         | 253 +++++++++++++++++++++++++++++++++
>  include/hw/arm/stm32g000_soc.h |  62 ++++++++

Hi; I've left review comments on the two patches in this series.
There are a couple of "missing pieces" here:

(1) documentation. Arm board documentation is in rst format
in docs/system/arm/. You can either add the information for
this board to the existing stm32.rst which documents the other
STM32 boards we model, or if you think it's too different to
share a source file you can create a new one with the same
kind of structure. (Using the existing stm32.rst seems likely
to be best to me.)

(2) tests. Are there any conveniently publicly available guest
images from some URL that doesn't mind our CI downloading from
it, that would run on the board model as it is? If so, we could
consider writing an avocado test (these live in tests/avocado/),
which basically can do "run QEMU with this image and look for
this output on the serial port". This is a "nice-to-have", not
a requirement.

thanks
-- PMM

