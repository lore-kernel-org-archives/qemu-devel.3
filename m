Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496D1CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpsPF-0004ku-CY; Thu, 28 Mar 2024 12:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpsPD-0004it-4n
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:15:07 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpsPB-0006g2-9i
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:15:06 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56899d9bf52so1545835a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711642503; x=1712247303; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fjVpOpA5Iq00oSecG01Q6+gTpD1AUnFdn7uVkFV+S7E=;
 b=qPGM8hbXMNgwurXo3u0Bshl1ZFVnYhtZYuXXIUk9Jrseh58ytYWSJi+jGMKePkOW5j
 S5NY871P56HWh42RkyvURpZ5DgtZKF+3lRqnY+7sWLJQo/5WUojbrfamCH3N9a+7ZdDz
 4dNpujoHLlP2KA8qcKn6+W6PjCONVKTNJfKX0BfT2R/tWUc+DqDcGx22FjU/XjyDxHoO
 EWpSiJzFaIMjilFYSIrbwz/+M7F5SfnjY+5aMvGX252WVZ8Ik7BXjJIUkA4MsZnqinK/
 JK+ipaGeFW6zdynt1B/Bn7Yx+uxPazY5eO4WxV9GmsOmI+vi3DCtnpMrHsP9b7xXmT+h
 grlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711642503; x=1712247303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fjVpOpA5Iq00oSecG01Q6+gTpD1AUnFdn7uVkFV+S7E=;
 b=hv9IpLwk66Cycr0OD0bU/RIw3/9QDVZsQytZ56E0qqzTVA+lv22rt+7kB1kCGoihvO
 FS5Zx0NzW9Yf+7HK9+WogIG2VEqkn12wm1WRQ4sk6D/RaGc28QnQw7XxM70G4Stmhl+N
 C1/xCYa/CoDOb2BmQTv580Dl4J/g9jagrQR41spUYawZiN2pox/zzfUIbKTi0EvKrfI7
 OSG40qI09RSPjFe0GpGSzkB643TB4s1ICL7t5yMSwkZku7SG5lse8OpvdwLSMmefaKFT
 ZutMawGf7fQUCCu5eVKTaVmrTKtV7krjj5vaK/e4fUdkhWnt2Y4+704he0nfNBcCVNry
 nJ7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTmvQc7x2qs0/00TB3rXWdAjN2CWQwVWLQ/GAoC0L5qtIbvpB+6XUQRM/7pTIcVPBY5rtzaXgrEzerXH++J9TvxG81uio=
X-Gm-Message-State: AOJu0YzDpss+KUW0gkHGNU9YKvvwaoTCobojwCj+/zh7C7lVQZ4nEVGU
 5ep2SHP2qfg2vRuXsEycghVN6sP+6Elcw4ko9ZbGHg0Ohbri6PoeRxWJKOMxHK5ON9G+dgvR82Z
 5qfhXq/LOmUvED5Q88s88cyQNV014w9Ea9FyYV5jeP24ekir6
X-Google-Smtp-Source: AGHT+IHEDxbaCck+EXlRRexpvg9IFpKVSfPgWlbXRi1A8uhWh1Xa5aVtrIY/JRk++ElQqCm8nvhimd/Xjs3gtP+6QbA=
X-Received: by 2002:a05:6402:2552:b0:56c:5a72:176a with SMTP id
 l18-20020a056402255200b0056c5a72176amr348883edb.3.1711642503467; Thu, 28 Mar
 2024 09:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240324165545.201908-1-arnaud.minier@telecom-paris.fr>
 <20240324165545.201908-7-arnaud.minier@telecom-paris.fr>
 <9e6142e9-83b1-465d-b29a-01f60f9cbc49@redhat.com>
In-Reply-To: <9e6142e9-83b1-465d-b29a-01f60f9cbc49@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 16:14:52 +0000
Message-ID: <CAFEAcA8ERinbcx9+2mtRMvJqDRxFhMZxzTiHXD_aLRA0zrsSfg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] tests/qtest: Add tests for the STM32L4x5 USART
To: Thomas Huth <thuth@redhat.com>
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-devel@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
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

On Mon, 25 Mar 2024 at 06:19, Thomas Huth <thuth@redhat.com> wrote:
> We are now using timeouts from the meson test harneess in meson.build, too,
> see the slow_qtests[] at the beginning of that file.
> You seem to be using a 10 minutes timeout in your test below
> (usart_wait_for_flag() function), but you didn't adjust the meson timeout
> setting in meson.build, so this does not quite match...
> How long does your test take on a very loaded machine (with --enable-debug
> used)? If it could take more than 30 seconds, you need to adjust the timeout
> in meson.build, too. If it is running very fast, you should likely adjust
> the 10 minutes timeout in usart_wait_for_flag() to < 30 seconds instead to
> match the meson timeout setting.

I'd forgotten about the meson harness timeout.

tests/qtest/microbit-test.c also has a 10 minute timeout but
isn't listed as a "slow qtest" (that's the pattern I suggested
Arnaud follow for this test).

If the meson test harness now handles timeouts, should we write
this kind of test to not have a timeout at all, so it simply
waits indefinitely for the UART to become ready after writing
data to the socket connected to the chardev? Or are there
scenarios where the test gets run but not via the meson harness
and where we would want to still have a timeout?
(For running the test executable by hand for debugging I think
hanging indefinitely is fine and arguably more helpful than
timing out and stopping.)

thanks
-- PMM

