Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89345E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWESS-00023M-Vn; Fri, 10 Jan 2025 07:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWESQ-00021w-W6
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:49:47 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWESP-0000JG-8m
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:49:46 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so3545255276.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736513384; x=1737118184; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9K8ZwpJGZ8gRKQbrw98qzTEe8mwF8u7FM/xvHIFq8s=;
 b=zb01zAlyBdN8R8AlXJTCGwwUPyEugaStOo6R1nXKOKsnuVgIDk/FW6nnn8qB8mMUu6
 /h5aeH/Z2UueL49OdYUoAAN5Pv2qqkkaIxZImJXek1bwiFkq6x3yYeUkwphQf+qnxEFB
 4thOAtWElgAcgt8BE4Cd+1RLu3CJMvRZS+vczfPZkoo46kuRfCzgG2sVBgqXMaui5OnC
 qtPmJAfGKvt2C1RUvwhJk2o3WZodT2bbKe/sd8s4pekxTReZ4cPqh1smq1CnSei3q54y
 +dwLXJFFhIloqKcOz2jcv9rEm6mTOpbBxBYMRiEAjGHLxhgbDeJL/uBUzaW5FClkzULh
 H1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513384; x=1737118184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9K8ZwpJGZ8gRKQbrw98qzTEe8mwF8u7FM/xvHIFq8s=;
 b=XKAFWM2QfqgDc6Ua30q0/3fWb2u81OUmeFBKFIX0itx/TfHqliYCQaHpyhkbz4d0wi
 3CcBYl4ASGIm1dhRXTHAiEKX7GuaRFS9uo38QLa+wLjRcvXYGPNAvahrqHwxRb9BIqXz
 Xk9bNu7pGQzc89y08YEhVNvH7s4/0XuWdytORya6hG0IFQ9B4lFpWCmyVsJtr09AEabR
 /m96mc4CfptkL8uNSR9/I0NnBJa8S69YraNmPl45r9iDdt46MrfFArUxDik+H6bPxv+K
 pwb74NXVuUFWf0w6vZNMtLVfkn1h9NNpJnuN4s7PYX5Vo5lk2aPRukU0bZM06uiQNszw
 cPMA==
X-Gm-Message-State: AOJu0Yz2sscvwG8rd1eIIk+yWHwK3BZOTKchcxt/Zar6H5jw7zWMJAGp
 xGVdFAeSkvkBimgxAkAjv3a1E4hlhFEATqn38rUrm4N9vXWzRHsTA4Tb9egjcZC57BL+qlQRSMY
 AIma39lB6EwrU2hDFyiou0ykVKmujB5RUgXS01Q==
X-Gm-Gg: ASbGnctPwSlzD5kd6kBGicLyHRso1XtBrWl5Kq+b8kzUy3oMY1SrHt8xI4lvhYTQQQ4
 1DJXWwYwa2/f9ZhVwI9K9Hy6uN4+NxA1gsniR524=
X-Google-Smtp-Source: AGHT+IF1pjlNUYep4xP89lSzVgrWt87SkF0zDi1wFOqOcW+2X4Lh1OGDmi64cAGMyW2xkhGe96Fc8V2IBucdO9D8xvI=
X-Received: by 2002:a05:690c:31a:b0:6ef:7370:96ee with SMTP id
 00721157ae682-6f5312209femr82031427b3.12.1736513384187; Fri, 10 Jan 2025
 04:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20250103172239.18562-1-philmd@linaro.org>
In-Reply-To: <20250103172239.18562-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 12:49:32 +0000
X-Gm-Features: AbW1kvY6t4d2AkdiEqXqblyedvgoRObIf1Dq22Vj5m84wOVjSVk-jgM8qbzaxz8
Message-ID: <CAFEAcA-3KSQvuPTBV2Zehq+t==z_nnqk90EY6vL5xasj7NSp0g@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] tests/qtest: Update tests using PL011 UART
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Fri, 3 Jan 2025 at 17:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> (Series fully reviewed)
>
> Since v6:
> - Corrected ASM comment (Fabiano)
>
> This series split a patch [*] which was previously posted
> too compact in multiple trivial steps. The last patch
> initializes the PL011 Control register, enabling the
> UART and its transmit channel, before using it to send
> the 'T' character in the boot-serial-test.
>
> [*] https://lore.kernel.org/qemu-devel/20240719181041.49545-10-philmd@lin=
aro.org/
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   tests/qtest/boot-serial-test: Improve ASM comments of PL011 tests
>   tests/qtest/boot-serial-test: Reduce for() loop in PL011 tests
>   tests/qtest/boot-serial-test: Reorder pair of instructions in PL011
>     test
>   tests/qtest/boot-serial-test: Initialize PL011 Control register



Applied to target-arm.next, thanks.

-- PMM

