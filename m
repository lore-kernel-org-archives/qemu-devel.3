Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A017E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVs1d-0002lp-PW; Thu, 09 Jan 2025 07:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tVs1c-0002le-S6
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:52:36 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tVs1a-0007o1-3g
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:52:36 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d41848901bso1663390a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736427151; x=1737031951; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/4K1Tzj+mjbPz6oH9xzb/Q/lOqYbIx8Zuv9auoeSrgs=;
 b=XCFicJ7M3t2XdgtZDIubjOL5mkNQPQX1Th2JVGPacGaRjUJVIQtGMDGWqN0K0sPu3/
 w+0gXqE38BZ4oJV9dSnLO0301sT974HhPqXKv0ucX/Ak8SZ7S+Q3sSc1ZkvKDifosWUP
 I48mr6yr7h/tfRt8suk3TH6vPctVOzfqAAAJhxlJnqC+jtn3IM2BiOdEq8fxpLN5xQgL
 OB6VUpOxT5iUB9TB5iZ/5yXNa1NS/Dk4DOLGPR2UZWnCsGkKVbujy4M86kVrFTi42uVo
 vEtxe/Z1qM2Ec6G8YpmtF3mvBcF4I5aT2pE2FtdFtbQ9smY5D26NhtjJ5Hm7cvGKbYxZ
 wS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736427151; x=1737031951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/4K1Tzj+mjbPz6oH9xzb/Q/lOqYbIx8Zuv9auoeSrgs=;
 b=PpsEdnasYRTHVI7b9pvVczrONz2U5BRsVcV+FWiLQA63rAl5VWEdzNBseA94HZbYiA
 AzyqHaSNqqujqymo+M1bXqrO+KI9sZWGifb0lhZw5lgujUzojlWak0H+9EgwJx7yrqPZ
 u81KG71zgZEXmPuYJsY0IoRWUGI3nxDcBTWjoMMqF5yl6z4ddW5tHvMULYhS4IMRU/I0
 IyP24HHMuV8I2c8OtOUrjWc8pH+iGaauSBj8hd1xuL42hvoVChUzlmqWkUs7UB2jnBpb
 np21Olf5VlbtxXnqKZqMZScOk+mQkjPoTwb571oj4MKeRu7mp4IRRTqs63nOpVGALgv7
 /KjQ==
X-Gm-Message-State: AOJu0YwoM0eGOnB2EQO4hxi2nPG5YXdCQNOlzvs+ZMtyC2hB1nT6I0fk
 Q4UWMKv2ie0Khva5iU4DkZIDIjmq5NF1m526jj4G7fc79VA0MdpVoR99aJqtj4xzMP9vu6fVuNr
 7MKP7HMTqfNC86/4/CTEgUrXWQTM=
X-Gm-Gg: ASbGncvLxYE6fKrauhgkRqg7j+a99tELfvMyY9cbFx6It60bWXkm0ljgakQrXV5jAKM
 AMYcccxy0wQjDBLqdJ2ga6m8GSleASlEgkIyQ
X-Google-Smtp-Source: AGHT+IHU6leJ5TPR8jV0KMNZTsfxT24LSsZs5XKvis7b9NUj4EW73IWq9OMz9yiLmeCQkWyvw6/S5+kfudsJnSIKC74=
X-Received: by 2002:a05:6402:84d:b0:5d3:fcca:cab1 with SMTP id
 4fb4d7f45d1cf-5d986288138mr2180966a12.15.1736427151239; Thu, 09 Jan 2025
 04:52:31 -0800 (PST)
MIME-Version: 1.0
References: <20250108111023.156073-1-dwmw2@infradead.org>
In-Reply-To: <20250108111023.156073-1-dwmw2@infradead.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Jan 2025 07:52:19 -0500
X-Gm-Features: AbW1kvbRL6TWFrshipa1TsW0BOZv7uTDuBEqGiKdyLcSToKIICRvjhbP9zMMxT4
Message-ID: <CAJSP0QUyq6RfYPPV2EXthMaLr82Z9htEohaP4f+P=MLUF=JCWg@mail.gmail.com>
Subject: Re: [PULL 0/1] vmclock queue
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Peter Hilber <quic_philber@quicinc.com>, 
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
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

On Wed, 8 Jan 2025 at 06:11, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> The following changes since commit 6528013b5f5ba6bb3934b7f5fe57a3110680530f:
>
>   Merge tag 'qga-pull-2025-01-06' of https://github.com/kostyanf14/qemu into staging (2025-01-06 09:39:02 -0500)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/users/dwmw2/qemu.git tags/pull-vmclock-20250108
>
> for you to fetch changes up to 6502ea82b26dc28c83fbc9c766af7a408a8ca827:
>
>   hw/acpi: Add vmclock device (2025-01-07 16:22:04 +0000)
>
> ----------------------------------------------------------------
> Add vmclock device
>
> ----------------------------------------------------------------
> David Woodhouse (1):
>       hw/acpi: Add vmclock device
>
>  hw/acpi/Kconfig                              |   5 +
>  hw/acpi/meson.build                          |   1 +
>  hw/acpi/vmclock.c                            | 179 ++++++++++++++++++++++++++
>  hw/i386/Kconfig                              |   1 +
>  hw/i386/acpi-build.c                         |  10 +-
>  include/hw/acpi/vmclock.h                    |  34 +++++
>  include/standard-headers/linux/vmclock-abi.h | 182 +++++++++++++++++++++++++++
>  scripts/update-linux-headers.sh              |   1 +
>  8 files changed, 412 insertions(+), 1 deletion(-)
>  create mode 100644 hw/acpi/vmclock.c
>  create mode 100644 include/hw/acpi/vmclock.h
>  create mode 100644 include/standard-headers/linux/vmclock-abi.h

On IRC you mentioned that you'd like me to pick up this pull request.
If the ACPI subsystem maintainers don't want to take this through
their tree then let's set up pull request handling for vmclock:

1. Add a MAINTAINERS file entry for vmclock covering the new files
(e.g. hw/acpi/vmclock.c) with yourself as maintainer.
2. Send pull requests with a GPG-signed tag (git tag --sign) and
ensure that the repo URL in the email is https:// (the tooling rejects
unencrypted http:// and git:// repo URLs).

Thank you!

Stefan

