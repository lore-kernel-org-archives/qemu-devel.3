Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5FFC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJAH-0006SZ-SC; Thu, 03 Jul 2025 08:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJA7-0006Pv-6J
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:35:35 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJA2-0007cH-Uv
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:35:33 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e8276224c65so7070427276.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751546129; x=1752150929; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ukwU3+QDrs6QMfVz3Z8sn/xC+wPkxCNFAHV7Cor+EFA=;
 b=pVdQLPWR5+DJ2yOXdZfx2NNpA8sYtzV8BxDwRJ5jb+Lugy7Whi+BDNc0Zg2V1/B29e
 i5/4l4lHNS/PWC7rQbBASSp2l36eVcWkcBC18+awCVG3tBMtAUcL9zlObqQnZomxVPXJ
 +gePj32yLUzAa8SMAWjWKXjzeKXI7buUSHGik4ASkGXvvPsEQ0+5qFzAYoTer9/Hrcy9
 aQ2yjn+Ux8s+OK7zLkzz1i6x36SdQ6rfCyVZfD1OCLy/7a9SXZvSHWqs5c7lQrfC/0F4
 Jaq8r/cmyaRK9SenhueazYaVE2BxOPyjak4kEqq9eI9ZCnBKwutuQGTIWP2iLKFReJB1
 x7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751546129; x=1752150929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ukwU3+QDrs6QMfVz3Z8sn/xC+wPkxCNFAHV7Cor+EFA=;
 b=J0rAaOugdm8qUpMItF5Ic76mfYrCAOJolCwPtDMwrmo0tYltk2mHW49sqjORdzziYe
 9RPhXm7GVjdN5POUo1JugqnmLH3q1vm1ODSDjOL/vA2ug1UXo3k1fmPRcGdiDJ0whdas
 k7jhJeFBnQinRYmHQYnEx5/LC3s9TDGz7YuRur3hvPq9TLIr7zb1oKCKLP9iwj6VhUmd
 /TrE8zoIzmJTY2aNpM+8DQT7Ay+/3vG9MkVrbUA9JUV38qEM2EFy3fDJMfHmixxPVpdf
 XEVFkP5RNOEr7askxL+qbmKkLHv1y3OrzzSY0NqiKXGp7I7nWw6l6VaAMVGvRJDawJ/v
 Q9wA==
X-Gm-Message-State: AOJu0YwB0YgiygPxAL1WHRAVUte9s7odUacyWr3RXnErXpaGIiZyTJD9
 rwrabXaPUzxoDCrUXMDSo3HqcIS5hmGPijv+mjRHPbz5vDrHNGEUF2LZe+PRAMtFXq2ga5a4iqN
 uyK0Ak9zw0gM7C8YIupvTaJUUCUbsm2mi40MnDvw8GA==
X-Gm-Gg: ASbGncvqeK6oF2jPBVN5RnL+zHbFnEje9QB5X3gZdPXzu4ulOkCLNOOGesxTOBlbahR
 5KO36Ty1EoEcgg0/8OLqPYAVjldDMTRk1vgu0hwkRtIOtIR5TCDUO+TdtfKiGI6q45n6UxeNjHS
 82vAjNHkvf49UCGvS6Wqo1FX5uRbkUAWj+2aP5lCpqjYje
X-Google-Smtp-Source: AGHT+IGs9KaEHNOG8VwVWNedWsq+xdCSEHHJgNVwiQWiboQD0XQ7pN57dXwFSI593FHbRkdxi0w7Q73qTBERzdICMCY=
X-Received: by 2002:a05:690c:9a89:b0:710:f39f:a2bc with SMTP id
 00721157ae682-71658fb9d60mr47207597b3.8.1751546129338; Thu, 03 Jul 2025
 05:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-86-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-86-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:35:18 +0100
X-Gm-Features: Ac12FXzGZ7cdhAWUMLqsbhUYVMlLo4R2y6R96IxXlAak-klTzTYB2iDzxi2933U
Message-ID: <CAFEAcA9KzEqGW2GufAqV-=--m0DGPKco5bV1vAfTF5xOYw-V2Q@mail.gmail.com>
Subject: Re: [PATCH v3 85/97] target/arm: Move ld1qq and st1qq primitives to
 sve_ldst_internal.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Wed, 2 Jul 2025 at 13:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move from sme_helper.c to the shared header.
> Add a comment noting the lack of atomicity.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve_ldst_internal.h | 63 ++++++++++++++++++++++++++++++
>  target/arm/tcg/sme_helper.c        | 44 +++------------------
>  2 files changed, 69 insertions(+), 38 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

