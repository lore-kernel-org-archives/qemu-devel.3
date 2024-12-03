Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599DBE74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIW6E-0004QA-FY; Tue, 03 Dec 2024 11:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIW6C-0004Pv-ES
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:50:08 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIW6A-0004Bw-1K
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:50:08 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ffced84ba8so56108351fa.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733244603; x=1733849403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npXND+pX0oipabSNbkcpsz8Pha27Q+AoCH/sH6eJPD4=;
 b=Zlv3YKJDCTLmaUd2f5cqSB3Luv9ZLXgoFwbPphJJKXELcLDR3I6/m0mtvQuVTrTlpj
 fnU6+9hXZqABpU/xm6tMYIQtc2O4qmSHW6vZe+EOLtKuFB2HLUTdakjIwJ+UMH8rC4vj
 3/vMGqTA3ikSBJKHRmOTw3UDTKlJjKKrzW3fRSDYeT7oW0XhKZY5uv1/XrCVU+Vzd/nH
 caANrh8A/ZKIOXIo2ZqpXTvPj5wBG2+QuA/PvflgiJkcG67j4e/5A9fSpw/gCvTE/thd
 4hUhjkGVsHqJnv7C8+DbxWdZhdNtu08RtMdBg0vvxhdwlHl4eLuP9tYzlncBnicLesP1
 Zj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733244603; x=1733849403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npXND+pX0oipabSNbkcpsz8Pha27Q+AoCH/sH6eJPD4=;
 b=PflxMZI+eYN2NTZnTCSCkYd7H6xIC3CwgCiKEY2YVA5VVTrwaquslpoxKrMKqUEa8y
 0UAkqVonpqIwuXWGWVZQkOEIdtF0r8PXNqt0uBn+T1q5+ymLIBaRCrwsCvX14tYPoBtV
 32JfM2BiwzQde4wFSJ62x49+5/bVK5RFIkPRJQ5PzOl85SwndUyoUQUbx6xVZ40McSNK
 oqHIaR2/oM3ohvZ0oeMbu/7Nj8yN/PDXLoIzOnezHZpgzHiwxl/SO92wAuzH4FDkmpxL
 Q4TUfoiHS5G0AUXxfL/1GjLqcRIJrQmxKgrkCXAx8DGUZhEp76xlovPVpu2319nbcFp7
 ZHtw==
X-Gm-Message-State: AOJu0YytcFLzMZEsPbEASYleU5zHPWZFfQ8D17jHKXn19etWCW0qDQ6m
 JUEkqWDqsjqTSxwiNGuGOfq9/OxtOvR8jt9oTZTR0DBdnksgQzCL3MiTL8p3DRrQeP+OPem1zCd
 2TpbfpVtGQuTIPlrKj1SrKnqGOeCZFOtcYcmE3s5wk6OjZJv2
X-Gm-Gg: ASbGncsR1iLb+/lyh2lGpnHC23i1MU+TJLP4d3ePegxBS80L/oFRyTXfpeAjfwwGBlE
 aXKAHQ6BW47y2+nc+jjv0EFNNoauV+lB4
X-Google-Smtp-Source: AGHT+IGDW8vJCdDucIDk2XbC2pl1eOvrVJQNsrK6IJmTOnBL6st/Y7y+1pRMhS+iPYUcaoGgyN8y5w9swJC+ByYq5fE=
X-Received: by 2002:a2e:bd82:0:b0:2fb:5ebe:ed40 with SMTP id
 38308e7fff4ca-30009c3443dmr20122551fa.15.1733244603354; Tue, 03 Dec 2024
 08:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20241203113140.63513-1-philmd@linaro.org>
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 16:49:52 +0000
Message-ID: <CAFEAcA-7FHseHZwt4odOpM5z5BJ+MEX_WVyvOgk=aBK0S_5oeA@mail.gmail.com>
Subject: Re: [PULL 00/13] Misc fixes for 2024-12-03
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Tue, 3 Dec 2024 at 11:32, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit eb22a064455aeebc105cc89bf77f48aa18b529=
38:
>
>   Merge tag 'pull-request-2024-12-02' of https://gitlab.com/thuth/qemu in=
to staging (2024-12-02 16:16:15 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20241203
>
> for you to fetch changes up to 964d2a0cf8136cdafc07f6fd847ebf897965dc35:
>
>   system: Select HVF by default when no other accelerator is available (2=
024-12-03 12:28:06 +0100)
>
> ----------------------------------------------------------------
> Misc fixes for QEMU v9.2.0
>
> ----------------------------------------------------------------
>
> Ahmad Fatoum (1):
>   hw/openrisc/openrisc_sim: keep serial@90000000 as default
>
> Bibo Mao (1):
>   MAINTAINERS: add myself as the maintainer for LoongArch VirtMachine
>
> Brian Cain (1):
>   MAINTAINERS: update email addr for Brian Cain
>
> Daniel P. Berrang=C3=A9 (4):
>   hw/core/machine: diagnose wrapping of maxmem
>   hw/virtio: fix crash in processing balloon stats
>   tests/qtest: drop 'fuzz-' prefix from virtio-balloon test
>   tests/qtest: add test for querying balloon guest stats
>
> Joel Holdsworth (1):
>   hw/openrisc: Fixed undercounting of TTCR in continuous mode
>
> Peter Maydell (1):
>   target/riscv: Avoid bad shift in riscv_cpu_do_interrupt()
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   ui/cocoa: Temporarily ignore annoying deprecated declaration warnings
>   meson: Add missing SDL dependency to system/main.c
>   hw/display/vga: Do not reset 'big_endian_fb' in vga_common_reset()
>   system: Select HVF by default when no other accelerator is available


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

