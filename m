Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6DAC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzua-0002Q2-Gh; Wed, 02 Jul 2025 12:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robh@kernel.org>)
 id 1uWzuW-0002Ml-P0; Wed, 02 Jul 2025 12:02:13 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robh@kernel.org>)
 id 1uWzuV-00077P-4u; Wed, 02 Jul 2025 12:02:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E439261120;
 Wed,  2 Jul 2025 16:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD14C4CEEF;
 Wed,  2 Jul 2025 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751472120;
 bh=xhuFKpiwZrBgAaTXDyaz7iKnGuYXiQhyBnHX7CVw36M=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fCPpCgfQrywQeGriuCowRWndpRw9g7TmluXbJ4bmPgswaAP/vb2crckkBPfUJt3ky
 1KE8AK+DMzEC2GUJz8tSLTtEiU+UN1qFiqRnFsvNLehaHmXd/04S/jYcuXaq7+4gbA
 AKe/0eawOOgvoYCVYSN6QBzeQDONxLJYi5V9oHmjyIbfu77SWFHXLW1VoYduZG+FZt
 +fGw7wect3syHgtNM7j4ay/YqLiSDFCjk8XVHvfbo1r1m1vV7n5NXspjdNm36SyyvH
 7oJoPXfm3CTtP9YkvlVkXCq4rZ/yGa/nE9RYlakiYRSiIVxqLLzFucP6q9mT3o7I5t
 lPs5DjO5JQklw==
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-ae3c5f666bfso130912566b.3; 
 Wed, 02 Jul 2025 09:02:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUvebD6S8oeno1gtUU7pKofbJNKEEDNfm7dhNsKIcXZgfCwzA3kYJeW12V9D9h1DF0vow2VAFhDpA==@nongnu.org,
 AJvYcCXM1GOXZ6nBZeVbAxYuNQNqP1ruf/8OG/Z9d4riZkH3DzFifFOzIGn+bDpPbb0QDauf07p0Wv/A7fB1tg==@nongnu.org
X-Gm-Message-State: AOJu0YyfaAI1zLXjxgHWtQr7c244JDPagLa3Ox6ZiYzDnzl/bfsoWzVN
 1o63Pxek7sm8nkWtR1kxCl8uP/eI7ZvvaX3cMO2hbSOb0W5C66CU0J45JWuG9wfZvGmIw+Hel7e
 J5zU57Q0UQmktns37qkEFBLmh3YRb4A==
X-Google-Smtp-Source: AGHT+IEX1u1c1SUivBtrEA6yAJJ3GFKzDcFz0bIp0/papFfqkHMdtM8NHIHg/HXxi1+bggrh1zghtm1PH//THjsWfhk=
X-Received: by 2002:a17:907:d23:b0:ae3:7113:d6f1 with SMTP id
 a640c23a62f3a-ae3c2bc0370mr387683266b.25.1751472119090; Wed, 02 Jul 2025
 09:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250702113051.46483-1-thuth@redhat.com>
In-Reply-To: <20250702113051.46483-1-thuth@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 2 Jul 2025 11:01:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJS_YaJ-TfKykCYxrrva0m_Z=SPw+w0bmVdT3p_pxg9=w@mail.gmail.com>
X-Gm-Features: Ac12FXxQgNAAWnb-w0nYqhK7Lwgl0OGYORTICm9cDS0Q0NCC9Vjd0QM5WXN-4qM
Message-ID: <CAL_JsqJS_YaJ-TfKykCYxrrva0m_Z=SPw+w0bmVdT3p_pxg9=w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/highbank: Mark the "highbank" and the "midway"
 machine as deprecated
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=robh@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 2, 2025 at 6:31=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> From: Thomas Huth <thuth@redhat.com>
>
> We don't have any automatic regression tests for these machines and
> when asking the usual suspects on the mailing list we came to the
> conclusion that nobody tests these machines manually, too, so it seems
> like this is currently just completely unused code. Mark them as depre-
> cated to see whether anybody still speaks up during the deprecation
> period, otherwise we can likely remove these two machines in a couple
> of releases.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Here's the preceeding discussion on the mailing list:
>  https://lore.kernel.org/qemu-devel/CAFEAcA_0Hu8+G50sy0FJ2rX-=3DcNymLddDd=
rS2nN5ZY-doKiT8w@mail.gmail.com/
>
>  docs/about/deprecated.rst | 7 +++++++
>  hw/arm/highbank.c         | 2 ++
>  2 files changed, 9 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

Rob

