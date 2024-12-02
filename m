Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1548D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7p1-0005lR-2e; Mon, 02 Dec 2024 09:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI7oz-0005jh-9d
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:54:45 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI7ow-0005ji-Pn
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:54:45 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d0bf77af4dso3399620a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733151273; x=1733756073; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x+tShc0S9uH1feridpiXqx3AfVxO2lepmsZpTo11gI8=;
 b=zTYHMwDuEDOIcaxwUmXdRlSuB/NE1VlFH274N3hTkUzAxUUfpYil4sG8nKyryfZ8jh
 ZTIYD+0/6/5K2N3U6ktS0+3c9L0rYuy4bnWftWa/fxM/tr86qkeao1OephauQLWx9zbN
 WNOcvC6xWAswGrSlDfgvWPWHGdIWw4FpHzQh17V3UkXxS8/z5C3HsFQ3NElYZvOiNVWD
 Nc6Q4DIpoGNVfId0ojLno5UOwwoARKAaxgxxTSbBI+mhW5rMUk21rdzOPxXKIb403fQP
 sMI+WVwLecENI43q+NFDg9Lia39POKc3+7iIi6sIe2wcCXVPIqJ9D3GuiJYI5XKw62JZ
 iO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733151273; x=1733756073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x+tShc0S9uH1feridpiXqx3AfVxO2lepmsZpTo11gI8=;
 b=VZ07UGELU+r3NCDwASxdyKviaoamn6NFw3TRVUamfuP2U62yUJP4+Z6bxZ5k8EMaGL
 hFgfHoGumcltrnRTyOITBcZZqN7QNbnh0eFoJ/GfK52MxgrBGhojASmjFkKwrSa1ehIC
 U1wLDA5AdbEEHfw+GBxz2MRiepWgOq+ac1i3rATu+3eOZjDI4WEgCIEaGHhRTgRTxkiF
 F7zSt+J82uhLROeqJxz3hg5rqD7Jh+VQ6t88y9/+V9bnAtUdRmSEnj0CVQYNaoVsrFfi
 2luF7fi90NjMRa6sqTSHfdBt/6/2ZdBVCetLj1wPn8J2363Y3MbwWV+0j5iV6Ufdb/Rc
 j2Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl4lm59FbnD1SWfsrqoJWIfAedoxIDhyfTUeXeGjGkvnhENJc/BFQ5P+7lQYLKx9GKEZSvySqlQFO9@nongnu.org
X-Gm-Message-State: AOJu0Yxd+w6gMma0huIM3RF1iWwowc+D4M0il+niZ6cR3TwVaxpifY1H
 5o1jM6DQU/XMhXw/CN3v1o/mWe6OGtyG04sBQirQmy9jkmVxA7uOslURRZBcAlHqJqgUfBQOqbO
 h063exkbvNx6OXbhPVqJvzjvCJyACQhdIvemzdSS2oga7gdcC
X-Gm-Gg: ASbGncuv6v9KnWkOgsiO1tP+45GFunJfjHaN9ozJcnJoyYoJ3udYK914htpdTU24byX
 3kkyUtZK9PgxWdHmZAvo+uCTXEN48C7LB
X-Google-Smtp-Source: AGHT+IHACPF6Gq8s1WirGP2IJhmGZs0Vx/QRBYd5qa/iXVwQwOdRBZ9kUih3UhKo7xxBk2k2SDV3mtUK1P218bo7OWM=
X-Received: by 2002:a05:6402:458a:b0:5d0:e243:8c4c with SMTP id
 4fb4d7f45d1cf-5d0e2438f25mr6138677a12.10.1733151273521; Mon, 02 Dec 2024
 06:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20241106104041.624806-2-frolov@swemel.ru>
In-Reply-To: <20241106104041.624806-2-frolov@swemel.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 14:54:22 +0000
Message-ID: <CAFEAcA-b+XcYEm1MASzedYchmy0TOpv2djqssJtQdu2CTw_jTw@mail.gmail.com>
Subject: Re: [PATCH] hw/timer: fix int underflow
To: Dmitry Frolov <frolov@swemel.ru>
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 6 Nov 2024 at 10:41, Dmitry Frolov <frolov@swemel.ru> wrote:
>
> Both timeout and return value of imx_gpt_update_count() are unsigned.
> Thus "limit" can not be negative, but obviously it was implied.

For changes to device models, you need to look at the
data sheet for the device to determine the correct
behaviour so you can confirm that the change you're
making is right. This commit message doesn't include
any of that reasoning, which means reviewers have to
do it all for themselves.

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  hw/timer/imx_gpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
> index 23b3d79bdb..06e4837fed 100644
> --- a/hw/timer/imx_gpt.c
> +++ b/hw/timer/imx_gpt.c
> @@ -238,7 +238,7 @@ static void imx_gpt_compute_next_timeout(IMXGPTState *s, bool event)
>      }
>
>      /* the new range to count down from */
> -    limit = timeout - imx_gpt_update_count(s);
> +    limit = (long long)timeout - imx_gpt_update_count(s);

We really shouldn't be using "long long" here in the
first place. If we need a 64-bit signed integer to
give correct behaviour then that's int64_t. Almost
all the handful of uses of 'long long' in hw/ are
doing it just as a lazy way to avoid PRIx64 in a
printf format string.

The GPT has a 32-bit up-counter. If timeout is, for
instance, 0x9000_0000 and the current count is
0x2000_0000 then we want the new "limit" value to
be 0x7000_0000 because we still have 0x7000_0000
cycles to go til we hit the next point where we want
to generate a compare event. So I think we do indeed
want to cast to a 64-bit signed value here.

(More broadly I think the problem with this device is
that it's trying to use ptimer (which is a down-counter)
to model an up-counter. This doesn't work very well,
and it's better to not do that. Arguably we should have
some nicer abstractions over raw qtimers for the
up-counter case and/or get ptimer to handle that
too, but that's a lot of work...)

thanks
-- PMM

