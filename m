Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0914C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYnG-0006Sh-2R; Fri, 23 Feb 2024 11:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYaQ-0008T1-Qq
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:39:49 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYaP-0000X5-0C
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:39:46 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so831439a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706383; x=1709311183; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WFBKtG++m5WB0UPPcxAztOZ7fOz1Q+/mOVR2jUOw6DU=;
 b=Pws0Y2NKOf90gzhOkkSR02yUjgmve23syBH6Th6gzcOhdyPXwMCkC1sMHoynXsytlY
 hEGhaRP3p/keAxRtavEOC14rhHx+xoojjyAZ9AhvkKMQ1vrKGMD70uQnOTpTWERK4XH0
 Bxnia+JHn9X1ob94QsTyfBjcR8EQktRApqZ7G2qlB8K0JQfltdz1dnzCQlUuew+2tCDj
 h0srVKjCzRNIwnAdlmTPm9TFSv4bsWRSlsHXbM26zLrEjJGyT6UDu9seZ88CLz+laRtx
 0FtN+cWppM0qjLlxfW1qj5K7wdJIUL2YR26cB0ByDCbEv5K24OlC8mjyFM37f0RRoqLR
 ymDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706383; x=1709311183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WFBKtG++m5WB0UPPcxAztOZ7fOz1Q+/mOVR2jUOw6DU=;
 b=vtXxOCJyJ2Uh5HGLPVLBHLixySAeoJEEE5V0//MN1g8YnwaQ0Z9l1sqVeuSAoSJnDI
 fcvQNsAPrCFf0dva1ipiOav3EqqAfEJrZfkcJiHejKxD23j6BdI1fIOB0m9nQ5J4RfnS
 H6xfF2aG7oG5c4WYKYqCdwgOqscxWsncpXIlpKECZONa2hvbolmJeOrW/RPM6ZeT3zUq
 LEnCdjNjvYcN3pJaM600ctsTct1bbXtq9GWbPifaVyyQRxS3U2jcJPFAjhi194ocN1jb
 DvNiSOCycmUV+kWYDgEMwguxGbaf4znfqFMy67u1w9j2qP1NUysn7in4xqz9Rf/SRax3
 ilyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpPcwKohlbB1Oh+KYl8QbsfoJ2oTDg3q48mRylSkJcgdo84YtkCxRgOPKZJqQwuvSMTeQDPaRDTZBPvfWbQNu1VGg6pqk=
X-Gm-Message-State: AOJu0YyqxlNQoupROpxpDYe4H+ASRutGZqCCphhllHNyxUzOKXbZ3/Fk
 5A5XZ2Ozd8psW6TEDylrLBkxaVpkYVG64ht7nE4zy3nFBu54O0EBVT0Zmwmk41bNy0mFsytuOqI
 7WMYoZUdXk9sP04+88yEc38+2xumaPbiLgKsIkg==
X-Google-Smtp-Source: AGHT+IHIfkXTJd3Qd1CJG2bKbNa5//UGfTy/hH5A7feY3PrC/vldWGQxstbJoP0Js+vDUOx9hZ4n/6szqval6x9buvU=
X-Received: by 2002:aa7:d058:0:b0:565:71ad:e1a6 with SMTP id
 n24-20020aa7d058000000b0056571ade1a6mr230634edo.27.1708706383354; Fri, 23 Feb
 2024 08:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-5-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-5-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:39:32 +0000
Message-ID: <CAFEAcA9CJ4XG2xdh6zLj85QCJOLRyzJwtjtUk8R5CxDW8OYACw@mail.gmail.com>
Subject: Re: [PATCH v5 04/41] Introduce BCM2838 SoC
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Feb 2024 at 01:20, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838.c                     | 98 ++++++++++++++++++++++++++++
>  hw/arm/bcm2838_peripherals.c         | 72 ++++++++++++++++++++
>  hw/arm/meson.build                   |  2 +
>  include/hw/arm/bcm2838.h             | 29 ++++++++
>  include/hw/arm/bcm2838_peripherals.h | 36 ++++++++++
>  5 files changed, 237 insertions(+)
>  create mode 100644 hw/arm/bcm2838.c
>  create mode 100644 hw/arm/bcm2838_peripherals.c
>  create mode 100644 include/hw/arm/bcm2838.h
>  create mode 100644 include/hw/arm/bcm2838_peripherals.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

