Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925B5C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5PF-0003FX-JN; Thu, 23 May 2024 06:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5PD-0003F5-TK
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:10:39 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5P8-0005vn-4e
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:10:39 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5725cfa2434so3799722a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716459031; x=1717063831; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c3pe79/NgUnaZihhZ1R1O0Y/eSsp+DC4yaVPYL0vedU=;
 b=R9Wg6W2bIOyOILy8QlixkyviM4EG+fZ1qG9S/YSEifmIPn4YhATmNjAvkGxdXQDAsN
 Z98dNNBbbX4ZKBFTKuv65cYOBioXLxHk+vuNI3ohyLwx0pNjnBiqBEmXalGicHmpVIoa
 YC1Ibc9yC3PQzAGYWdJlZOEh3gHJNElywPQNexe2CTfxf0ll7LFX2CBYXhyus64xcU7O
 7e5kNpEcpUs/jbUQMOsl8JuVS8PtvkshtJ6DlkqU2czzzltYsMKMDRMoKIFngYzUDPA3
 XQL+z5soILmJdmu7izaUS81drjbzNHXYRozty3BVFW3wdilIri8VEZBYlbc6x9V8aij0
 IcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716459031; x=1717063831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c3pe79/NgUnaZihhZ1R1O0Y/eSsp+DC4yaVPYL0vedU=;
 b=HXSq5fUDVZel7/C59ahkIySXUUUXl5k5QBQKDDqiZTJes/bCktyVOX7ZOH8qedDkd8
 T2EpvCNsJoFJfjhS4N/CC/VoRuVVklsxhGo1g6csr7ErPBEC9WbPSvBW1exy7XOlMzZ8
 xoWe/yrYEzPk3UZw0H4tIOV0KKtJXSxXeeYIN3qtfhkE8uVf+Gc6TXuPdTxArmcvNZkX
 VRdoKQ1EiEHPfs76zF3bCnFHgp0UppKWvHSoDqdjMA7xPU8RNQCEDELXI3RsSln0WPNV
 PvpmYDqbMSibiYaxU+bgMqifJbRbG/lj/BhSiaN/7dfjMD0kK+YA1TsKBoDUNuTH8b1M
 rMUg==
X-Gm-Message-State: AOJu0YzES3c6iOg2XvqhwjlA9eS394dCLfetgRxdRPy+Sl23yRFPKjf4
 UjQFeH5kgMIJTL3QqDSouLaCXwb5ZMQhHrdQ+spusSIXiieAupjJtEdbslhnWiOjnPWoB2hs+MH
 MfMwIruI9IYGkYRB2jcD2/akic9SnwA2xoTxpPA==
X-Google-Smtp-Source: AGHT+IHNE6kD+Np6iHTrCkbcqKM3GBvqaRCbg8NFeZNuaJVIhADIsu7GuMp7KY7lOkFYF4FWWPqkBZRcDrTvSKjWeBs=
X-Received: by 2002:a50:d6cd:0:b0:571:bb79:51aa with SMTP id
 4fb4d7f45d1cf-57832c5df1dmr4089004a12.39.1716459030843; Thu, 23 May 2024
 03:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-8-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 11:10:19 +0100
Message-ID: <CAFEAcA8adnMTVEciS34dO4psnxyfc=+GJUuashNuT0YpK0DV+Q@mail.gmail.com>
Subject: Re: [PATCH 07/57] target/arm: Convert Cryptographic 2-register SHA512
 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 6 May 2024 at 02:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  5 ++++
>  target/arm/tcg/translate-a64.c | 50 ++--------------------------------
>  2 files changed, 8 insertions(+), 47 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

