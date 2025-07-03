Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4744C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXImp-0006so-Ov; Thu, 03 Jul 2025 08:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXImj-0006sA-Qj
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:11:27 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXImg-0006nM-VQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:11:25 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70e302191a3so78836187b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751544681; x=1752149481; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBgsgIeawqL0c81jNvHXOOlPF0rya4pW0p9Ob7Foz/o=;
 b=eQ451OX7r4z3rBaBjTswQc9M+nz60xQxl4wuRremhHLGTBM/+vCY3vVZGhKnT3gsfS
 sSR86mGMzRHvgu2j2yFeW0k7h6LR8dm8T7UXP58zKf/3GipElFyU0To8kCkBWvTl1Idg
 TSae9zdW5j9ZSYhS/MS4twp08kIrdSSwmfVZLXYmKBC7Wi6yKjs9h2yz8QLhfseLHulw
 bFvRcixk9wzCXqZOS4IsJP2osfwjv1z7J3EemKOIF3AhcPp65lJ/m4S7TK91SjfXnuKB
 RmFeBRTZsRimklrcTBZ/ay7VMY9O63lGtRsrVfbiVbPpNkiMo54cDh1v2ULFB6/e6+3j
 MRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751544681; x=1752149481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBgsgIeawqL0c81jNvHXOOlPF0rya4pW0p9Ob7Foz/o=;
 b=OpIYq38jx9xnnrOUgpEQ4790h/LXSQbAABG7Dfy8rltvgaG5zwwWxGoBb6hSf9Gh/e
 SEi9+WY984Da4OOw/uUGac6vQwpYrPGh58Jvjn5s+0qutbEQiHaPXismGYXFCOGdUEBj
 N8IwoJP/HbW1EU4k5zOeyTlGDxYnzm3bW5+T62w54+ASb3eDhZnvpe158u/ivVxPRdUb
 3HxbWDameP2lTx9cS/Z5aZnFaJmi0o/TRHdVM2x1aDwlHPzaaC8jFmXzeXFMXsVsZfqb
 ipWOx9ccS8jHmr17PnzNBc8APh2btPgicEJ+ZK2u62oPrBWiggP+Yw6JR/eo3QqqH2u3
 XPtQ==
X-Gm-Message-State: AOJu0YyVoSqtUcQ670lpjN/o36bmyEB4TYtMnryiJxmlkwqwCGNvw7Zo
 XMjlCTRfSuDcti5g6mcZYzOzRKF2445KJQlRqni8914SW2jIvCIvgY7PhQ2SHE0ZjMPFb4I637j
 fzb2hFT4YCXLGvtXBmQieH2/WuMW0x6KJFNW/52XNGA==
X-Gm-Gg: ASbGnctF8mtrc02rU2wKap89UgAsxAWQEed37iLfNYW62uuVj/SpaYGVmszDTTyklVg
 cmxL9eIM8xn15NgnSSBqNgIzy/Gidw6iKqOCKR3cf+U2eHoCizvS0X+tbtb/b4dObA7qxtPVpzT
 SioCCYHiL3KNJrfI6sPuIwkdzpmVqvFUbGyVo3mlpCtaGMi9aXkFaNqsA=
X-Google-Smtp-Source: AGHT+IFcpxQEv3MMrgVMeLnGlTkHB5GADBeS/fBPMj8kDbLFxdulqjRgdNrZ9rXGOlWgOfzn6X3wjqsBYQ9jJBI/kNY=
X-Received: by 2002:a05:690c:4d08:b0:711:16d4:60dd with SMTP id
 00721157ae682-7165a3b79dbmr42241117b3.19.1751544681514; Thu, 03 Jul 2025
 05:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-68-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-68-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:11:10 +0100
X-Gm-Features: Ac12FXzROUe-GSMMD9HwXQHHMfS4Z6N1UeYaYN7gdodYlBFfAwYwjcA-lu7qKrc
Message-ID: <CAFEAcA8cVHuaGfYvAqivUznibD-2b_snwmnsjM3Hzy-pNr-pOA@mail.gmail.com>
Subject: Re: [PATCH v3 67/97] target/arm: Implement SVE2p1 WHILE (predicate
 pair)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

