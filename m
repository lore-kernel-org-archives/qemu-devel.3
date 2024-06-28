Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58479C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAnZ-0001b3-TF; Fri, 28 Jun 2024 08:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAnY-0001ak-88
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:33:52 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAnV-0004jV-Sk
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:33:51 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57cd26347d3so721710a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578028; x=1720182828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Y88NQ5ZZ5VMLUx8Kdsxd8pVwphCioxcOZX0cssQyys=;
 b=px2hLnBU23NRIA50TqTA7x1kcSQIYQzeLJuliz9G0v/G2lKAsdIRc2ihSU1k2QQYPS
 a0L2juPvLXj28NI+pxV+WX4QrgYl4ZYaV054NZuOoTDhTeDpVPLwgio5q0E4jecfjEFL
 1W7O17psK56GRCBZeRVI9Ht9TxlIY8fnCBuLEwV1UwqL2m7j+RHXV2+qzUEhxgUpKcnV
 xietUgDF+r46EV72UFlmhe3YDFpkvBBEnDbPM0m7sM5DXStlD387Up8rAL+TJ9U90R1c
 hwyBAVqyzMr2EeIugfqxSLMDqa6jbbZW3pj/1wiBLx5dzXqCGn8CxPcrx/kqPY5hGA/o
 BtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578028; x=1720182828;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Y88NQ5ZZ5VMLUx8Kdsxd8pVwphCioxcOZX0cssQyys=;
 b=S6RTimq5nxH7y1HqCxCqMOd37rxxFWnvfJVozB0n+GVaOkbt7SWAX1XMobh3e6lLDF
 ZQrW25Stk4trLwJVChmo6r9ULuzq6ytz7Y1mhebPyNyE6jzUExcRhbiXpasBtGkE58JZ
 SO/UcpsuOqsiW1bVbXx42YU/7SxzCl9y4yE0C10lKzKT4Ey+hWpK4gqHQrQEMD26dREV
 HAk5Q6hdmMbMsr+NHMDi+65UiHqey3pgiv+6qR386LTHGM7/p8Ah9qgH4zRJ7lqhcOMN
 1iSvQLlho6TuT+z34HJ9ujVgDCHqIWrVSC1LsOSGqA8NtwoVXpVNqaIBRsyH9MCXl/oZ
 LSbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlYlFseyBSvgIoL5PJjo5nzwJpNBrMN3c2xDTMgs2CqZ4zkVh3TFIEUQqNLxfttQWkeYgtweu82iPQGnuwpeN6nvWYwgQ=
X-Gm-Message-State: AOJu0YyLacVrheZ/kG7/t0Ui0Gbc693JbrZ8z6kTt4oZPuirtb31jaxv
 bIOslTMdTzugYb46ZncP23h6lcr0VgSUGse8O34zP02m1elbAEioL4o1lgVU61g=
X-Google-Smtp-Source: AGHT+IH6WiGzPFnHFvG+vHfwo+4deUWjZ++MhrtwmvgKnFMb+9JCvp0NE+PyY/ghNNq91F9CHvqoyA==
X-Received: by 2002:a17:906:c206:b0:a6f:adf7:b073 with SMTP id
 a640c23a62f3a-a7245b4cccfmr1062769966b.10.1719578027901; 
 Fri, 28 Jun 2024 05:33:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf633desm76225966b.73.2024.06.28.05.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:33:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A2125F7A1;
 Fri, 28 Jun 2024 13:33:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/6] tests/tcg/arm: Fix fcvt result messages
In-Reply-To: <20240627-tcg-v2-1-1690a813348e@daynix.com> (Akihiko Odaki's
 message of "Thu, 27 Jun 2024 22:58:02 +0900")
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
 <20240627-tcg-v2-1-1690a813348e@daynix.com>
Date: Fri, 28 Jun 2024 13:33:46 +0100
Message-ID: <87r0chnt5h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> The test cases for "converting double-precision to single-precision"
> emits float but the result variable was typed as uint32_t and corrupted
> the printed values. Propertly type it as float.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Fixes: 8ec8a55e3fc9 ("tests/tcg/arm: add fcvt test cases for AArch32/64")
> ---
>  tests/tcg/arm/fcvt.c       |   2 +-
>  tests/tcg/aarch64/fcvt.ref | 604 ++++++++++++++++++++++-----------------=
------
>  2 files changed, 303 insertions(+), 303 deletions(-)

Queued to testing/next, thanks. I'll take the rest of the clang bits
when the remaining cases are ironed out.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

