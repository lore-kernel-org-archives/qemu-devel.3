Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573E0C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 19:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHpFq-000506-HN; Wed, 21 May 2025 15:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHpFk-0004zn-Rp
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:37:25 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHpFi-0004WR-Oj
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:37:24 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6ff4faf858cso51182917b3.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 12:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747856238; x=1748461038; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbzmVBRSO4g4c0IGjooH1aJnH8y7YXALfQS1pfKpUOs=;
 b=Lrp79kIALmY/p/ZO9+i2e3f8ecZqQvgfbnoRc3+EPmkd0hYcytC+DydXnQaISGkpPf
 LjljSkRFiQCfOTSZERv1KMkl+XAanwNbvMn9rA7+g2hA1p38dboAb2W7oBNYbXW2hJXA
 Zi6jOJf9df0olz075XrZPSzMTNUecSf/wu9pUcWFLoGMY/JQnNgj0qybZk1wET2myDNf
 KY9cyg/xj9fWqEt9NggmWum+9Lj85xkTXnNAKdcipG+ByjAVdFO8Cy7K5crABl34amH/
 38mBLXwVvyJa215yzs4rnn6xStypr1qNE82tCasDUwFtyfmMcyqyWw/iSOHmdE6ZL+SQ
 TlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747856238; x=1748461038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbzmVBRSO4g4c0IGjooH1aJnH8y7YXALfQS1pfKpUOs=;
 b=HbWotPCkbNq3hzDo5h+1gXMWUIQj4bsQBmUvkCrmehsMBgrhlRFnUfxdpSoOh5Fv0a
 yHVP11z/CS8bKK7c+tt7MREl5twwxUGRccHk0lx7lwe5ysy/tiH03ry5XiSWNHiyyaVG
 vGPsGUZQNMHlZ+f5VwGPhoGZL2mlD+I6Y9RbrogLDqm6R+LA6dHpAc1CXabpAyHtOA0f
 g4m6tqAGc4pqjirWrO+zIF6hinNzvqD9c9RSUMjrkBzMDR30XvVspYEyoB6jrGqN6tRe
 MAIXgqK+NSUkLGHyJPGz71S77WzIpKvYhPirinxn3VV4KPd4Qop5Y5ITxpcBclaHRqEm
 OdwA==
X-Gm-Message-State: AOJu0YzFRiH4GjdO8qkgm347pBquO+GyRJUaRSnUw5JLAd4MV6QPuuss
 jCEG/VSVd204K7XWu95QLiEoUZ5LA+Xk0i8TuVxM3zgJgMDHF5l/VKRBySB648CZSTUZvf9MaAN
 KW3zl6tJzJsOC52e5vHiY8bNJsYwtCopZJb7dwGlyGQ==
X-Gm-Gg: ASbGnctABuT7paaicTiYm5pxpyzZkppCoC2NPCiPhXscdnPuUI9YphYW2kvgzOjD5W5
 c3mVktt2JR1oSPx0SrE6IjQukjew2UWNvzAYzNtquR2n0G9rMua6yzi4TORkRuJpMg7y8eUsFqm
 Gl+FxlOHZm9C7ytQj5diiPY85kdXyWVPbbSg==
X-Google-Smtp-Source: AGHT+IEOyWq9QA/1KkZ2inmA/jQx7YoWrVu16m5QczKYzyz+0BkxVK7QwJcmhdui9XnHJtwjmKtG/cO3uPQFocwxqLY=
X-Received: by 2002:a05:690c:4c13:b0:70c:a5c2:cef8 with SMTP id
 00721157ae682-70ca7a070c8mr325848057b3.19.1747856238395; Wed, 21 May 2025
 12:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXoQBbA-HATMo0OTLOnUcvYjHiUM2nmAQj1i=ZXkbStoQ@mail.gmail.com>
In-Reply-To: <CAJSP0QXoQBbA-HATMo0OTLOnUcvYjHiUM2nmAQj1i=ZXkbStoQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 May 2025 20:37:05 +0100
X-Gm-Features: AX0GCFtfZQSInK7TE5olKuW0RYA4wvbwV4cjGPbqsJYG8Ac3CkNZFLY2CxwzYec
Message-ID: <CAFEAcA_A36=RrQ2K+kLQgwVRdT=dFJkPW4vTsQn9RZ7FJMpktQ@mail.gmail.com>
Subject: Re: QEMU 10.1 release schedule
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 21 May 2025 at 19:30, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> Hi,
> Daniel Berrang=C3=A9 has proposed a release schedule that looks good to m=
e.
> The release will happen just before the KVM Forum conference.
>
> Please reply if you have any questions or concerns about these dates!
>
> - Soft freeze: 2025-07-22
> - Hard freeze (rc0): 2025-07-29
> - rc1: 2025-08-05
> - rc2: 2025-08-12
> - rc3: 2025-08-19
> - Release or rc4: 2025-08-26
> - Release if rc4 was needed: 2025-09-02
>
> https://wiki.qemu.org/Planning/10.1

Personally if I were running the release this time around I
would move everything a week earlier, to avoid the potential
need to do a release the week of KVM Forum. (My experience is
that "we need an rc4" is the common case.)

-- PMM

