Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F033FC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGbC-0002G4-UK; Thu, 03 Jul 2025 05:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGbA-00028w-IF
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:51:20 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGb8-0000tP-QV
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:51:20 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70e64b430daso59469857b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751536277; x=1752141077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/NoHf2a1Zo6RocIxZitcR//DWchIRQTyoNenFJdE110=;
 b=JsK/05Ph3YbfVP/ByX8pExnn8dlYrm7+0uc4dumVxAbKa0dVrbatHt+0fCjpRP0rkJ
 s/+l35nKDb8KfPxNrm2xkskt5IlwG7pzqtOvTbOAIz9x8pD1jCLRsLTl7kcyN6tLah7P
 FcJJWCON6f4+W5ppmzr+XdQBFj8J9yoLpmOBv1GfALeRFKqg/VYyZqOaNuN/dqvRY//L
 1/EdTkP3CfmiG8Q03xyDmwdaPAFHDwqogfjc2zxnNi5l1uhzxR04e3sYw/JISDhhI5eI
 /qmW+NRQCK9omME8sLWPRUxOc0SGhvNgrL2pqoj56+nQg7Vme4sFDTw0fTVENccvIbWd
 Y/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751536277; x=1752141077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/NoHf2a1Zo6RocIxZitcR//DWchIRQTyoNenFJdE110=;
 b=Xn+aqlvZTgt8ryl9JEZLD1Hj7nOqzQ7zTXymCLhhpTo7V4cq6fK1P2h/9FUNtcDUj0
 LonO4k19BCQ5HaAd8CHxMCtiY6rklEyBm35e/F0fX/nMu7kmkczGHox7vZFo1ku6ZDcI
 4u+LPNiB2d36771/X3YBzinkifaoDAcicO3QmZvvu/qnMX5mSlCoh9z1p+9tDLwkqiHx
 4R6ct46wJHuTG8DTYFQDknvAK2nkewzigT5zQT0v2NtLbajM7Roa8xSsEPy0DxuizzM+
 tR7iUIUuDBWKNwmHDxnuf+WRCmC2SaV7hkGj08z2Z2uDZ4hlj9itAZX30hhV0xkzB4PB
 t2Pw==
X-Gm-Message-State: AOJu0YzAjgpkR2MjOtpf+s1cKHtYt69G7Qksk8rNJLxQ3mRFJ7S1QdId
 B1xPqDfwNjxG6OSNXtEefgik9ZTSreKDVE2Ez0/3I622zHjiPGA/SXTvj8/dhFOMngqWFoZNUFu
 2KdZfN6F2mYxKfHXDp7RReGFHSew06asxoeigN4LsNgHwWVBMExoD
X-Gm-Gg: ASbGncu3FVOlXz1CzngHUrNxFqdm4UIVh8kCbCYsVCUMcK5HEi/MZ+Mqfm8J5cXKgMo
 FnSMWz/TnFN+cD9jSWeSp9AI15wwTuYMYM8ik2Wz8rk4cGpuuC0GRh39uzVl9xzse+bJoSWghdD
 CsjXMn7JFW1xiWcSCbl7nGTeg6IWSvlftCeI7osRsxhQZJ
X-Google-Smtp-Source: AGHT+IGKKWUa8M9rE6jWLkeRt5OWt9bk63aHJuuRF6sMsDtGNRhijkMJm95EQacj1GWIi4T62F2e5B39x0BnK7fXTd4=
X-Received: by 2002:a05:690c:64c7:b0:70e:7ae4:5a3e with SMTP id
 00721157ae682-7164d2cb17bmr96914047b3.11.1751536277594; Thu, 03 Jul 2025
 02:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-41-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:51:06 +0100
X-Gm-Features: Ac12FXzjj2X34VeGZRD6FBw9FZdPBaPVVvALvmDb_4SJQUfxkaXQ9UDWjxPSU20
Message-ID: <CAFEAcA-e6hSoEMh=2TUieqmBMnmX1-uAd2PRkHsGVW8jV-BT=g@mail.gmail.com>
Subject: Re: [PATCH v3 40/97] target/arm: Implement SME2 FADD, FSUB, BFADD,
 BFSUB
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper.h        |  2 ++
>  target/arm/tcg/translate-sme.c | 44 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/vec_helper.c    |  2 ++
>  target/arm/tcg/sme.decode      | 25 +++++++++++++++++++
>  4 files changed, 73 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

