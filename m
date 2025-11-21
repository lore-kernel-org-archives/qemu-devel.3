Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B5CCFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd6r-0004bH-9I; Fri, 21 Nov 2025 21:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vMcls-0002Gm-EM
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:50:41 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vMcjr-0005N2-Ub
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:50:38 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-298145fe27eso40559225ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763776094; x=1764380894; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHewKZjVMMaKu4baDesTs+xqwpyh2D6JtWuphQStcE8=;
 b=lZiVZveQnmeDkdPU4jYe/GO0GJQ9s1PuWyRB6TJpt0QbvKQctCvc0p+vLyY0j9OgTv
 xmP2NJ8WVOUhRDQiQk7J9OoAg7/EDv0n6sGAM5LYS2ZEJw6VRb1s36Q/Doh5R9TdxIjX
 r955VgBHFNc0ChbFjfFw1hey9ccT2tQFBLOqVkKj9O2fCNy2ecs9e9N0m/QZWjXqsM9j
 N38PXy0luY+K2hJZXPKIicEqGiDB5SLM49g9vMPbfXKC0f4Ak48cQ6VykOJqYRKTTT/g
 Jio0ABIKQJnTaMpSv75MECa4LW4HaDYDmTLRhK4NrygT16XMg6PIN/88QVivetFnZeMs
 twbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763776094; x=1764380894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EHewKZjVMMaKu4baDesTs+xqwpyh2D6JtWuphQStcE8=;
 b=NZo8qZIvu42EHU6OMGn3xypdpZEw6nI/ECvDnjuIwMqr0AreaFqww06zAR0dWiQNhT
 Yz9n0vw+vuL6c3WrP0OYVloWXAAnlWoYfx1RCZYHw89p6hkhtW9UN6tYzIWPoaqZW5TZ
 ZWHRK1dxN2LPDX3tQUfNweuDigRQoU+iZrYn8Z2MuGnGzsP3N+CA95EVeNp21DyuOUvY
 4T8Ea0Rdj6KKJSBaojXEt2zWV5r0Q2FOR8COnGx8BvWvpCI7OG5WHaSHIYyYianXJ8B8
 lROxi+w9vOzlbUHqXMFNAv6NLbABZ2oz/045xtvyb5VlaHoIiSgtzRbvFm54AVWO5ubG
 FJrA==
X-Gm-Message-State: AOJu0YwvP+yFrIdcHt0WsSPzMG9sH8ZX9GsUx+wS16Jr19TNdKkZBgEk
 CyPErPkpMpT86xJq4WoUkViM2r2FHG3opnoVnBnfAZlV6P6WX8aiWnpv+nsaqhVDoHZL62z2b1s
 NNQBmFGl8Zr2MUvMzEUpCdGNQcBJMDRaJNfsyErPh5Q/908mhlXUnMR3WPg==
X-Gm-Gg: ASbGnctc7ZpzRA0yIDJm2c4gSulLxTkK9UQY3xSgAnrH6i2lFgCRJukoff+b0mT9gtR
 AkeJB4naL5RE79z+oIZYfehk6bxuZmZByyqrVAuxoQ/RhGOpPxPS45IN/87zKBn7FwSBHo98q5i
 Rq0QhuRdqLUomoVm8uEsfCm2/WvRCI55iktSrzc8GQDi1mzpI759zcEJsXnOWzsy76K3V5mqevA
 d6OcIxpqBMK0SrowchaflGwmzZ1OuUKnaAINbtmzYIM16iJlxbfoFLsgnf5Ee//n2hfdwBmiV1X
 uqep6f0=
X-Google-Smtp-Source: AGHT+IFbzdQRFE+ECGmk1sWo2z3ZftzCuWMnQuwtHZAwl4ynlJCIcN254Vu8zXGtw9Cd0e7MvXjPVYMclTvVIihakqQ=
X-Received: by 2002:a05:690c:7087:b0:788:181b:869e with SMTP id
 00721157ae682-78a8b52b06fmr28313667b3.40.1763728077800; Fri, 21 Nov 2025
 04:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20251114034806.2440-1-jasowang@redhat.com>
 <CACGkMEvmuwGC_U3wW51v=qyuvU8qt5R-xx-jf5OR8gB8Fc3XOA@mail.gmail.com>
In-Reply-To: <CACGkMEvmuwGC_U3wW51v=qyuvU8qt5R-xx-jf5OR8gB8Fc3XOA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Nov 2025 12:27:45 +0000
X-Gm-Features: AWmQ_bmkb4CyAJ4EY8qnT5ZfZqt6lgk-v2Mem9F7XfaxP_8pFrAITo-BWojE68A
Message-ID: <CAFEAcA_x==cvj39sds5R+QSUKi5fyc-fJ3AbEv3_zGJkeo4FvA@mail.gmail.com>
Subject: Re: [PULL 0/5] Net patches
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-pl1-x62f.google.com
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

On Fri, 21 Nov 2025 at 04:03, Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Nov 14, 2025 at 11:48=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > The following changes since commit 9febfa94b69b7146582c48a868bd2330ac45=
037f:
> >
> >   Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into stagin=
g (2025-11-12 11:47:42 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/jasowang/qemu.git tags/net-pull-request
> >
> > for you to fetch changes up to a01344d9d78089e9e585faaeb19afccff2050abf=
:
> >
> >   net: pad packets to minimum length in qemu_receive_packet() (2025-11-=
14 09:59:55 +0800)
>
> Ping.

This was merged as commit 409be85c2f5422 a week ago ?

(Richard replied with the usual "applied, thanks" message but it looks
like that went to the list and wasn't cc'd to you.)

-- PMM

