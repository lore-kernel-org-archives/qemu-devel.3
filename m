Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D96C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thVtP-0004rA-TP; Mon, 10 Feb 2025 10:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thVtN-0004pk-VZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:40:14 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thVtL-0003YL-Bt
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:40:13 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e5b1c7c31b2so3656074276.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202010; x=1739806810; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OnSd/e/jEqTUcYBz684UyvujbuuystBLx+4LOUZE/hg=;
 b=rsz8GeMRPBP9xXqWTUSAryrUM6twgyDMpeHsFs+J3kxatpP4N7Bvdm37bdJ5+xB3ge
 3Khw1Y5d5B5vGXHZSEaI/z+hE8fu3BjBcbidGcKN9SmmpYeoFqQ07a+Bsefdvk0hSMdX
 vbTkIxH41BG62fdutvDztJB5pOHZr0jJzG4bmxEaCZaXyK1nW/RLqn6f0yI7ODgrvjYI
 hROO0Emk1TWf+A7beIT+dL7xLby+lLikg9ysotxF7FJYW0gKA5p8oYZwj6IDaeoecBdd
 RH32xS8RlRMDpmdQgTxSdE9GVW36c9AlFkCwhhciyNZMfGM4yhglo3qSdrjedsbqz21v
 xSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202010; x=1739806810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OnSd/e/jEqTUcYBz684UyvujbuuystBLx+4LOUZE/hg=;
 b=NdMWQFQOFI55hHGyaHO4F9otcp7h/ttbYB6nPjZKhWA8w51Hw6UtRLNTp5vDXUeOoj
 mHYYWZQ5H58qWy/DCX9r8w97kCZCkn393F81JZwKCsrxeUbASY6ycIcN0GqwofuFYZed
 09UGAsJK43q2XM0zAWjKmM2+0tvLJOmg2AMY1/0iV5v6W6a6+UH/TVxZpaLk6mOX1w9q
 jg+4yi5qW+P/WKRQUPxqDn0AXNaV8FjhTY75Cs+PNQCdY/ISeHCvgnXYSsT4vhpjtlu/
 F0wxp4UuMVcr5RBscwi5+CrglUYYsPbBcjmFmyJnBMx7F+B7577OOM76rO5kTj72uhiJ
 7gZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC39BB81RfriUGmbBZDhEeROMw9MQsHOCtuBU7cPjTAXoBmxb5rk8bAyuSq3fNpGBunaF1RagDYNIp@nongnu.org
X-Gm-Message-State: AOJu0YzOwNdlCsUdgMpRVWo4J1J3ISl4MMPeWkuwKTQW+J6HDyQXgHEJ
 Qnw6XdO1x/TSb1Dj11MC3aZSMVowtzTmS05UNsmqQy81mpHHc/o+u7guoGgmi2rTUXbeixmoH3c
 SkdkIoPCsKdTzRiTkyEwBfEuAU0MF4KHSX6rUGg==
X-Gm-Gg: ASbGncsptvu7040eIHp/V4VTXqrY8cr9x389NC+HL9vm2vjSvg5Kp7c68L3lEd9wsMV
 uS57HNqkuUpSlxmQFZNB5chRe5DmW7U0m4rM6GHZjcIXXTFHu8UbTgqXlZzX7FkDvchEHMK73+A
 ==
X-Google-Smtp-Source: AGHT+IGZ6tTtQbSYRKN7SBTNNh5paFiswS2IAV7Qu5inH+1JnCBNWIVqaP4UBWFpzvDbKN87vztRT1l9CP9Efq1p3fs=
X-Received: by 2002:a05:6902:1021:b0:e5b:38df:b44e with SMTP id
 3f1490d57ef6-e5b46b7d685mr9947422276.2.1739202009938; Mon, 10 Feb 2025
 07:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20250210135804.3526943-1-peter.maydell@linaro.org>
In-Reply-To: <20250210135804.3526943-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 15:39:58 +0000
X-Gm-Features: AWEUYZlKrxW_nY6VZoKTKhrWWp6oTjox6P5o4lp5DpJJOmaWb-04m8RbnrXulOg
Message-ID: <CAFEAcA_gA9CSsQboFYT5ZmOUc3Gr=c25ayOVyW=RzCqT3fdWYg@mail.gmail.com>
Subject: Re: [PATCH] util/qemu-timer.c: Don't warp timer from timerlist_rearm()
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Mon, 10 Feb 2025 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Currently we call icount_start_warp_timer() from timerlist_rearm().
> This produces incorrect behaviour, because timerlist_rearm() is
> called, for instance, when a timer callback modifies its timer.  We
> cannot decide here to warp the timer forwards to the next timer
> deadline merely because all_cpu_threads_idle() is true, because the
> timer callback we were called from (or some other callback later in
> the list of callbacks being invoked) may be about to raise a CPU
> interrupt and move a CPU from idle to ready.5A
>
> The only valid place to choose to warp the timer forward is from the
> main loop, when we know we have no outstanding IO or timer callbacks
> that might be about to wake up a CPU.

This patch also seems to fix
https://gitlab.com/qemu-project/qemu/-/issues/2703
(a report that with an x86 system sometimes the ptimer
period would be longer than you'd programmed the ptimer for).

thanks
-- PMM

