Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C08C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 12:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcOhs-0008DP-UQ; Mon, 27 Jan 2025 07:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcOhp-0008D2-BZ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 07:59:09 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcOhn-0008B7-AJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 07:59:08 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e53a5ff2233so7692203276.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737982746; x=1738587546; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdylYNFuYbClYGwW5Wsg+W2PQ/s62I5CyPgXo9hpFiY=;
 b=QmnAAb7kNBU8Xmi7mMNU6piTLQwP7bFp1E3VY5OdL9YRt0PlUWyJjvhjREQp5AVMNW
 OGymn+mC3ZqI/NmpQHx8m71i9jn/noU081PyO++407y8o6OCtgb+OkPNwfJMcDKLxReI
 QPvK60uNBWgTdrLcfukT/3OFZQAn4upL5ju4Zpyn9JdJmSzJIW9Qgv1NlCcMLrOWNaqm
 /4cWXQQ0CUmmW/p+hTQCUYLVKQjzZejN27UB5TBAtGt6+UJxDXbTSN3AxkmWBkxu510o
 +mHim21AP3CPNHRTB3JUHFJ3iISIeoMKtwJ3sMcEhURhRdYSJDZicdqnHuvlmmGeujfn
 LX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737982746; x=1738587546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdylYNFuYbClYGwW5Wsg+W2PQ/s62I5CyPgXo9hpFiY=;
 b=uaX7g7qZ9wav8c5S+CmIERy3CfdfwiHi/X9b46xkOU96OqKv/nc9V50rXPOnSarC3x
 glckmpY+WXWj3m+ybfg6oEYLGddrW1GTxZxghqqQAPXJ1kALQSPb2k6BtVrI4MhmekYB
 3n+FFWjl4/X/tIcw+2t+4fukUw5tXSdT7VYvdnfmTFZ5TzImUr6WL4MhlrrgeBJdZlfi
 g5fSIBewfODW8nK6L+WEJfqE05n74fM3t8hW8z3Tj8IDZxyklSYwNtQmcB5X9YeEAzF5
 pVcOw4Ggztj4U5/B6L/irCU0SkoPUyROQKB8Hp4aapW6qcQwXgDXEkjiqRbC/Ch3AG4c
 Ww6A==
X-Gm-Message-State: AOJu0YytWoNiDWXeecav5ccFFKmxZvrJMjmfsuJwia9OHNgHCCyx4Ia3
 f6h7M30g3cDEICP6zIdnCc2PV088SwAw1ROxqYg8ibQ49/Fsx5PfztqNv6B8yeidA56WtWhs/Ek
 sVYK+DUCEiE8WRM/AkT0bO//IVGXisNUcDD7q/g==
X-Gm-Gg: ASbGncvJFMhqniyeU8yY+fXFFn/s5an0t+4f1XOeyH2TGQd5m78NAJN+R7b7HHsP7p7
 +sGkG7/Bji6WcKXQZfFSK9FGzrUiKt3pjty2iIMfEfZZnI90PYvwua0ndbQYdhdLuKix51H73yw
 ==
X-Google-Smtp-Source: AGHT+IGiGDJk6wm8jVHGBuNca2Q/tiOxVgVoWzGkILq/MwGkTEZuW/n+LMwRurgM6K0htQJoV4mI/cfDPagjaprozHU=
X-Received: by 2002:a05:6902:20c6:b0:e57:935d:380 with SMTP id
 3f1490d57ef6-e57b13310fcmr28856504276.47.1737982745873; Mon, 27 Jan 2025
 04:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20250112225614.33723-1-philmd@linaro.org>
In-Reply-To: <20250112225614.33723-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 12:58:54 +0000
X-Gm-Features: AWEUYZk9wDYB17YQTnGa-2avBqE2CZbXEEWgjgbGRgURm1j2PDy8jvuZrWDBk-Y
Message-ID: <CAFEAcA-B97c8ziB1UVRSuxNKB8=an=+JpbfsRcWuy3d25oP4EQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm/v7m: Remove Cortex-M &first_cpu uses
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>,
 qemu-arm@nongnu.org, 
 Felipe Balbi <balbi@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>, 
 Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Sun, 12 Jan 2025 at 22:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> After renaming a pair of fields in NRF51 & Stellaris boards,
> remove the &first_cpu global uses in Cortex-M boards.
>
> Rational is &first_cpu is going to be restricted to generic
> accelerator code, then be removed. Similarly the global
> 'cpus_queue' containing target-agnostic CPUs is going to be
> restricted to generic accelerator, thus hw/ won't have direct
> access to it anymore.
>
> Note, Cortex-A boards already have been dealt with in
> https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.o=
rg/
> "hw/cpu/arm: Remove one use of qemu_get_cpu() in A7/A15 MPCore priv"
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/arm/nrf51: Rename ARMv7MState 'cpu' -> 'armv7m'
>   hw/arm/stellaris: Add 'armv7m' local variable
>   hw/arm/v7m: Remove use of &first_cpu in machine_init()



Applied to target-arm.next, thanks.

-- PMM

