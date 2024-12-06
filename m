Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3F0E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJawk-0007Fh-U2; Fri, 06 Dec 2024 11:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJawd-00079Z-41
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:12:43 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJawb-0001gD-4j
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:12:42 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa5ec8d6f64so235826566b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733501559; x=1734106359; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+TvohvwF7sIiq4yJFQu2i4lbU2okTZinLyLmTusnUQU=;
 b=PMe7C3Mz0C0lLJgCwjTxpsYk3v36VmKK1QwCD244ZNtCAhJJGlPD46yi+4ix3v4zoI
 u3OY9yBFGLQhs3nsZ6nocrsXK9O1VSjsqP3tAM5YfHJWJEg60gMFwbfcN49Rrt9LuopN
 YBbdtu2GatK6Cw9OGDdLGDHWLSXcRKKAP0vBnR9O3GM4Nm9CZVzdqFJOC1YpbvhKtAUw
 rG3B0ftJFS5m/lPkQNdl7tIBvrUH3zdGICsBJNKYlE3ous/5KDWybK+EAtt4/Zf8tvp7
 MyUkTte7B3b+OLxoa6PBeJf+6uite66M0XSD0/wxn/QVdD5tIZCU3uguxNlj5lUX32Vp
 AEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733501559; x=1734106359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+TvohvwF7sIiq4yJFQu2i4lbU2okTZinLyLmTusnUQU=;
 b=V0DTi02s+elMKjTkcJDcxDonYVtAHlr/m4JpHutJAddCIXCMrlRdzzTAiX125UDxcP
 FEdldhR6onPoImNjwXFxxisyxvFis+FcVXwIeRxDqnb2EjS1HmdlIdLtxBrUOj/rt4zI
 DWJE9dJEI38WMf/3J96Qosvu4RymN1GRPhNRkUHXrxDnC7tryzIsgfWh2+6eJqiSgPcs
 PQu/u2dh2rGf5dRHdFgcgAJA2rQScz4wpO+pKcSJT2/4ZA5Ku0VLlb1eDmeMAz4yF4oX
 BNDk604WrZx9VEX6Fg1VmYWspbDrn+HTtEZ2OnCkAeY4EODUlgwl9C0UVIhFSeuBfqRy
 3whw==
X-Gm-Message-State: AOJu0Yzd/GNWAPmfJB9DVEWgqElJ+vGwYphMi2W/XPjZtn608/RV5ocb
 E3EYSJnOHsr9FRgeid7rGqfWZ6Yw19DI5N+I/K1Z+8BefhOw/v2eXr1gi2ItM5pSU9oW7rT+Pg4
 yFpzBEJI24xGvdJdJ1Hloy/tSsoWhtYt5kxCd7qofGbysiMwO
X-Gm-Gg: ASbGncsvEkR70fU4u5Rwux7v4uLVvwa/k0rKWgeT3tV8nMyXLlYBT2Ya+m+VTHCUxJt
 ukfrRU2XoyjwJrILL9KfurO3RRZajwfqI
X-Google-Smtp-Source: AGHT+IEcKiatG1uZ4B8JBmUUi/peUwip0x/gDbLTZoM9jsygtyp1KfdAZBLh2tUpl5nK0dEalln7Hxa3QAFjXyPl4ok=
X-Received: by 2002:a05:6402:3604:b0:5d0:d2ed:ebb with SMTP id
 4fb4d7f45d1cf-5d3be661a54mr8373931a12.3.1733501559244; Fri, 06 Dec 2024
 08:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-55-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-55-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 16:12:28 +0000
Message-ID: <CAFEAcA9=vDpu3bBqXskg2xjFeqsV7qQnhgnzw8BCbLqBRo1QiQ@mail.gmail.com>
Subject: Re: [PATCH 54/67] target/arm: Convert FRINT* (vector) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Sun, 1 Dec 2024 at 15:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 176 ++++++++++++---------------------
>  target/arm/tcg/a64.decode      |  26 +++++
>  2 files changed, 88 insertions(+), 114 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

