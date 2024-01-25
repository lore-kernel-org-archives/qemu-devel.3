Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03C7C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 12:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSzAw-00089i-V1; Thu, 25 Jan 2024 07:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSzAs-000893-1c
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 07:49:43 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSzAp-0000aY-Km
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 07:49:41 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55c2c90c67dso5278299a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 04:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706186973; x=1706791773; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MGRoQROCc47nZ6NgFMBEtB+Bm2iE7zSPMm7VFK+t52k=;
 b=rjewQg29m3K+A2d816jZ8F1FykJ1Odo3LJTrPyNNcMfaWKorSm8dnND2MaBekB3p3Z
 9KUVaGBxLZ0MoHQKMmme+rYPP/7F4lDRC48k+KZL0bULdwQsUNOCIZORa5XHiwowG32l
 ROt6U3otYIWmKBClrKr9EBMowU669LUDZpqCduiAKZQGPyC5Y2evLwZBg5BrLmilfkOW
 Q2A0X5XF3YSXP+UBmMTzhc+q38eUmj/vkrXbFrWRiX9M3ABLbr36y6nzoYZ4tmSgsE5g
 I+JvxVOogTSrq9KsDOiCdrmzUinttjsKKkOQX8NwHb28brD8iWIcGIQxPZzUWw0UEefb
 AiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706186973; x=1706791773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGRoQROCc47nZ6NgFMBEtB+Bm2iE7zSPMm7VFK+t52k=;
 b=L3E6J4LA3wvjK6qem/vSUsUQ0Fq6G4bNwMdUnxgUv0kqiOkDk7zXSYv9TIASIOZyqD
 18kC6Vtle5J2EjeIQM5srgY9KzGxAaJbEUstG5QZlIfJf/C+YmVJR7mOCE1e6Qzznw8c
 QvoTLfQVHSFcpR2ogKdq9Almv7XnEYZdPcZIxQXdkl6At22NTXEmtnbIqTqEpvMSgmC8
 N3bguXtE0xaWFCk7I9U0C2qwOW95u+hesnqMdv24dojyZ6gJIAnjuz44tm+x/5Sse2aH
 pByE8sJsOW7aqkv0zW1lOM4gbhHbKl6Gabz8YQQlHWGdB3ozQpJsL6LNz47eHKSkg0Wr
 3K6A==
X-Gm-Message-State: AOJu0YymfcnTi0axKaXQRA2MewihcPPI9Sg5js70zutSGHYSRBspoXXI
 hx2dn8ucwg5H8RY87OXVeyZ5m/eyFDafvJjkrBa1LN88eE22slFxh7Ks+QPZIqoNyoefDsnyKWP
 e7mbIRafvvgtqfTVuFevtNXfR8g96z5SV9GXbuA==
X-Google-Smtp-Source: AGHT+IFxSmxrU+wV2epbWdcy9Glp2j+O/LjX2T5JPTh6clIyVn64vBckcuqd+IhT1PzdS7q5ae0zLO5gJrvJA4NgTaY=
X-Received: by 2002:a50:ab52:0:b0:55c:6283:3a95 with SMTP id
 t18-20020a50ab52000000b0055c62833a95mr643354edc.64.1706186972699; Thu, 25 Jan
 2024 04:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20240122211215.95073-1-gustavo.romero@linaro.org>
In-Reply-To: <20240122211215.95073-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2024 12:49:21 +0000
Message-ID: <CAFEAcA_-tW7god6zhhBW3J_CmBpFARgnysphM7yi5h=9S4a4HA@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system/arm/virt.rst: Add note on CPU features off
 by default
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 alex.bennee@linaro.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 22 Jan 2024 at 21:12, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Add a note on CPU features that are off by default in `virt` machines.
> Some CPU features will remain off even if a CPU-capable CPU (e.g.,
> `-cpu max`) is selected because they require support in both the CPU
> itself and in the wider system. Therefore, the user, besides selecting a
> CPU that supports such features, must also turn on the feature using a
> machine option.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Applied to target-arm.next, thanks.

-- PMM

