Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41542C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabQp-0000vU-Q1; Thu, 15 Feb 2024 08:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rabQi-0000uy-C6
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:05:33 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rabQf-0007wI-Rs
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:05:31 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-561587ce966so1643878a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 05:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708002328; x=1708607128; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P72819blLW8ODq1qfDtLgN/B2hbVdRf2dZsfpr3d4yA=;
 b=HSJWZeTCjLmJTZkfz3YjiYK8ZAYhj52iE+0MisHLmX/dV+0ObLG6vW/D1oQWXNvLpM
 j/2T30NaxR1C0V/2URj2OEtJheGj5LjvXTgZzsY5UjQYV2kP1r+B2sMzbDnPefFTSX5+
 mCS2jKJGTpAIvE3PCcHcVemooBu4zF/n0HsxV4QcI391ok/eaoEr7Y81UhKpifLKDFoh
 J+BGebzdkxKDsHiUWYOJXSK6JPCwrCc6aWJkFMA2GyV1oegJXHXHVYV6Ip5QS9AwjAB9
 tt4ULv1KWNGZvlAhL4cOk6liHl5Lkoo6yRxMrqPgznIMO/s3dZwpboj7apjG+7zbkYtE
 uNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708002328; x=1708607128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P72819blLW8ODq1qfDtLgN/B2hbVdRf2dZsfpr3d4yA=;
 b=RLwGmFxTcjDC615kJC5yRj1cnzHfiOa0Y2f+8pWAXTAOtMUP2aywRCY13bOW4enCFt
 aZvUSh6uwZhTGCtbb+Cn++xGwizmWVBzFKP5lidihAsbkN9ACeUJ28mNYUEYmlXIfrQJ
 TI+LUoteZvpsXYI42VT/CGBiMtVfp3JX4xv95m7M5C9fYqb1ViPHspKdiEBLT/+2Z1AM
 qXPO44Iuso5Lzg3s2HJvapFz0HXxn7yP1rbvbL04oIllCjUvr98wbVxbkza5N6VakfoC
 wROWtmp+DmBeX0+gGuiza/3WPtPYXhdMmucCrJ6ItBNskPwT8Aj/BmLCn9zxMFgNO4C3
 yqzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4IpnDj/b+VM141x+g+OUCyexwbCah4WmFkx/s+UCIegxDZ8S9amSpdOSofQRdus30K6iX51WA2w7VukGUqyoJZkMlfvo=
X-Gm-Message-State: AOJu0YyBbnaePgndg7y/Z6of8ZKT10aWEgTzvI2sPbRSqaqsBAQB1dC1
 OvbBMKFa6yuSDA/pn2Z7NGlkPdl9S/rWw2R7YywTUkl1cZITnpqzsxXiT1fB4nT4uJHYBC6Y3ny
 6dOIZ1MACheAHLAtoeATp+3lIdSu326dloBooZg==
X-Google-Smtp-Source: AGHT+IGMxEVOeLxhgG8viuFwOEnN7KK0Gp97xbokgcdTlPCnYaxN/GYhR0DOQTeRXa2Cdp2Mqrc0UiHlJJadXqr5RI4=
X-Received: by 2002:a05:6402:2b8f:b0:561:3704:329c with SMTP id
 fj15-20020a0564022b8f00b005613704329cmr5000302edb.8.1708002323681; Thu, 15
 Feb 2024 05:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20240208194759.2858582-1-nabihestefan@google.com>
In-Reply-To: <20240208194759.2858582-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 13:05:12 +0000
Message-ID: <CAFEAcA9JTeTk-mXW2+zub5dbRQBMkuiz2m0Fgx0t9K33pzLN2w@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Sending small fix for NPCM GMAC test to properly
 test on Nuvoton 7xx
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 8 Feb 2024 at 19:48, Nabih Estefan <nabihestefan@google.com> wrote:
>
> Accidentally added extra file to v2 that broke email sending (and was
> not meant to be upstreamed). Sending our v3 to skip that confusion.
>
> Removing testing for PCS registers since that doesn't exist on 7xx.
>
> Nabih Estefan (1):
>   tests/qtest: Fixing GMAC test to run in 7xx
>
>  tests/qtest/meson.build      |  4 +-
>  tests/qtest/npcm_gmac-test.c | 84 +-----------------------------------
>  2 files changed, 4 insertions(+), 84 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

