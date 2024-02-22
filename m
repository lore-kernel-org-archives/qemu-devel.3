Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D56AC54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd9b8-0000wx-OS; Thu, 22 Feb 2024 08:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9b7-0000sT-23
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:58:49 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9b5-0000Oo-Jp
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:58:48 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so10599287a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 05:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708610326; x=1709215126; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f4A5QTEiDWI+EfdbbvxQ+LWL8OIiOi+Y61Valh+/N3Q=;
 b=UGaSoyKhP4K89t3GwugN4+FezHSrvof1uLCwjf/dfPsjgQDLJt+HqxMpVmc3yi7ruV
 dIRTIVBS8iLGotSZRaErEgGXKFfPIRE55Bx0RXAm0TO7Qz80yq3dXluXUh9gipzCWGCz
 OUh2COq3H5kpnkT29wxumEByRLIoBHU2PyOQDVFiV1vsQdOnGxzA78IHQT2Mo1cqU1PE
 q0bEQrbTzt1/NkUPT+sEtTgleGmJKSlQy71/idqW9DK+gHnh8ipWswa5v1hWKRhvhrsL
 1yiud0jt2x5ytxyWG065AWBsiTLdJ3ryqUpiZ6nFOpqYIIob1D+igbiYzpBJudypx7c3
 xxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708610326; x=1709215126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f4A5QTEiDWI+EfdbbvxQ+LWL8OIiOi+Y61Valh+/N3Q=;
 b=TfaZqjfB0asi/2zBSiXiz3uTfzoX+qo4uY/nBZjyrYUzNCz1kdAQjzScyuFZEKsTra
 aPcY7/Dv7i48I1xmsZFlESjH3apMbYwujQrmOAf/BE7qiYnoBY1Fvc2Mw7fOvnOf3olu
 WaUj/6frEMcyHCMqgk6kkMygOvJmmt/vfWM4B+XSIXz9TZC62Dcu+HhVyX88dZ0vKRYz
 n5bV2D6idarb7FtLFfDNSTs4XV2w86Zs0DZFw4Zbp2zw+7cOJmXiHVOrh14DsOf5FIv6
 nsc5fXzo2q5L4Bw3NHujNt8VmUThb3dGVfhXbrIl386+nEdGthqCqHbE1ZmOyCAVVuNO
 Hvyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQo8pYAHvqKvRDDt5z54tGKV4eRNNqNZqYhVFWtDwbUy700LA8n6sLRXsVmdPSm0ZHoBe2qGS+JLydhKLidQ0vUF2VZ4c=
X-Gm-Message-State: AOJu0YyCg0v/MzJQbo0WKKBGU3V4uw4VUYIFMmxzOrHCPtEO5UIcFLsO
 dUraJpXFGpyH/eCvtoUtH2Z6quYPTisyE/x8v25ZQuZADkY6kEdf0jN+EBL52WZQJVpUdqDHtR3
 4DsbXQwyoXVAQ/f7HPkLXiMXsNsgjeD5AS2ntAA==
X-Google-Smtp-Source: AGHT+IGBvOXoSvzJqJtB1loWnl6+UTKKdjwEHe40d+rfbb7FuvNrbV6WI7EhKPyMXXpOvmPL+NA9gnjPzqbCaCZ7eaU=
X-Received: by 2002:aa7:cfda:0:b0:564:f9f3:801c with SMTP id
 r26-20020aa7cfda000000b00564f9f3801cmr2928331edy.33.1708610326159; Thu, 22
 Feb 2024 05:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20240215160202.2803452-1-ardb+git@google.com>
In-Reply-To: <20240215160202.2803452-1-ardb+git@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 13:58:35 +0000
Message-ID: <CAFEAcA8z-xqsBt4rFOkY0Rqj+7wJs+KLsCC9VFogxFthi=iKyQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Advertise Cortex-A53 erratum #843419 fix via
 REVIDR
To: Ard Biesheuvel <ardb+git@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 richard.henderson@linaro.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Feb 2024 at 16:02, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The Cortex-A53 r0p4 revision that QEMU emulates is affected by a CatA
> erratum #843419 (i.e., the most severe), which requires workarounds in
> the toolchain as well as the OS.
>
> Since the emulation is obviously not affected in the same way, we can
> indicate this via REVIDR bit #8, which on r0p4 has the meaning that no
> workarounds for erratum #843419 are needed.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>



Applied to target-arm.next, thanks.

-- PMM

