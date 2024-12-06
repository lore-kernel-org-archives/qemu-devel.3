Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4026EE77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJa3Y-0000Ow-2z; Fri, 06 Dec 2024 10:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJa3X-0000Of-2N
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:15:47 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJa3V-0004Dg-4g
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:15:46 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so21411921fa.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733498143; x=1734102943; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OSskhXuAt9jvxpfHFLEHi0ULAghIKMwNcZeQP8GAvo0=;
 b=K3nx3LPt+kgwTlwQdkZX2c04kEIqJz3oO1I7+87vzGFGRmwaFCxzyARd8bFYPyXF1S
 o961EAAdZifJzdRAiTpGK2dpjSZ7hkmyaB9DD2jc3GWimqcGzxUJ3vv3KlqWkHIQ+ZT/
 aoCWOLKU5fkI9p1NiYxJ3XAOvEjdUtPWvBz2aOS29iWrRMDmR0yReM/z5alH4cTln9wW
 OInIEdcniNFeU3WkqVJ4KcLLFydqbo+Cf1U5Hg9xXaZHU/UBMPCJivXF5V0hygllqW67
 4Wwz4e40kZcRmMkq91TkLnXE5/dPtZgfL8OQKUjC5oCbqzvES1JukY/B80M1U9XH4zSl
 meow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733498143; x=1734102943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OSskhXuAt9jvxpfHFLEHi0ULAghIKMwNcZeQP8GAvo0=;
 b=RD54ZHeveidDi26yVD4TYJcVdKkxHwAg3aw31pYW3n4luU+ZNk4H1bwE5sW241+4wD
 81F1E2GKfkcBaW5pbDPHdlNc9G/TMJv6nhjYA21wloWcsgdAamK101B8x9n7XAWFLvE3
 F1WbV9yjLyrnImOZ4WDLh7eoiMQDvwF7r+1b1mNvQ1RQlApFIl43nI9iGqXT0IG/AVFm
 3mAeXVBOvxUDl6LgNBlWF0FPqoKLIg8P2w0XIEnqTLoGy4jGZ+iRceSy/NoLXXJrgXmi
 /vXtxJo5QaM9Iya70eHypDr6sfpWvJ42emSSL7OhnrnG+vsYhQx5LF4AreyRHLRs0GEk
 O1WQ==
X-Gm-Message-State: AOJu0Yzgip8NFRs6rl7QjoFVvYHiaFqB5At6/T2YSuoDZwlp/EItWqXq
 cM8mIkObZwPVH9sjPsyXyZ0fTIsS1+mFoNwJR0gDtCFvsOpsB5I3M/tCMeSvqR/eZ7Z7DGxLMXK
 ZW2ut0BHnjh3w1is6hXSq6C1o7rvdl3/BnOGr/w==
X-Gm-Gg: ASbGnctZaWcl5ddN/8EY4eq4KceSM7whWCTtJ2rEuYI1R98Taxe6QvfVdU73C9GyNHv
 NLSyoXHyWY116loMbHyGjE/KsnbQhYrxj
X-Google-Smtp-Source: AGHT+IH2Q8yj+TQ4vDSzC78URcMIUuV1SSGHho0KajawscMNDKbOMQHPbEA5rwfJsMGTWoYaynlzP0qy8EhUGtoxfzs=
X-Received: by 2002:a2e:be8c:0:b0:300:1f9a:6132 with SMTP id
 38308e7fff4ca-3002fc9f31cmr25085631fa.28.1733498143115; Fri, 06 Dec 2024
 07:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-47-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-47-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:15:31 +0000
Message-ID: <CAFEAcA8+qoBfSxyzsF+156p2Um9tKfBqmx-_T+J08ChZwXfOsA@mail.gmail.com>
Subject: Re: [PATCH 46/67] target/arm: Remove helper_neon_{add,sub}l_u{16,32}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Sun, 1 Dec 2024 at 15:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These have generic equivalents: tcg_gen_vec_{add,sub}{16,32}_i64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

