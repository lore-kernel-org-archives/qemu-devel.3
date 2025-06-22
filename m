Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC08C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT88Y-00070M-LW; Sat, 21 Jun 2025 20:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uT88O-0006jo-IV
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:00:34 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uT88M-0006zy-OB
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:00:32 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-60727e46168so5659618a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750550427; x=1751155227; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hdeo3zyXkZCOO+89nKELdfCfnlYDx5woouJjHM3Sej0=;
 b=TMPSmmkZThG4te/iWPJ6ItKmqkg8gNAlFkQy/FZeke5DCuuAtmuH+QVwlh46b2ugC/
 9z4vKwVv3TuRkmcu8W1bapbZM9KjPbpKuTvocSYAvkTLNovYM2VbAAWhoqHlzKK0qOrk
 4vl0CK6z0/aqfizG3pZZIu2N9YQsuTgWgZ0Rich3jRMTMK0cUVl+rn9eMMhnjfcp4/dV
 MOZVTYZyN9M7Ype0Rdsnk5byw/1edwf73k49QNITMj/veOhRHaun+BcHGcf30TQTJISd
 eLRnwKGKJxhH9vl4U7UXXZ1xoIv3rLNdyi9iGiqH1Z0eahU733tsbBxCBcTQsVbcqBlo
 cvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550427; x=1751155227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hdeo3zyXkZCOO+89nKELdfCfnlYDx5woouJjHM3Sej0=;
 b=jwoJoloQG3wpHH373Z2qK4wCaDFcaifxXtgOwTxUChw0L7qu87rnBTcs4TnA33RU0y
 K6ckNlwRkfHNsV1CBxvqfHc/qib4p7Z6Ifb2iXrViFugJdson9S7tjXNrKHEuPj6ZWtz
 Wx80SER3kQiZijCXr7C9Oj1uCtNygIpMhJ5mjwreHb1FJyy/7aI+uxmlT7V465t7GsVZ
 GSKBvZ9jgpU4ruRFDvDpCyciT6cUWqbHqA+QJObffJGrRCS3+9UBJYm7tWn19yClETW2
 dyIUMJMAqwm376z/MquazuZVZsq/KYef9sUtH29uE8K1qj4/YSwmMvFI+w/LfRRjxwZg
 FMSw==
X-Gm-Message-State: AOJu0YxBMhmcDqPgf1qOgQR5p4YNTxXCcjLUR6ge9WR7OCW7Rt8V3bGH
 f6Mec8VXpRKTGQZJ0vwlKXOX3sug/tCsV7+6eRVXF+DdxkojSadk/C4mTYTJ9rDqrHCRevOPsNV
 BNSjUp713EPyNBVrtMju9yJtdftVHGonGYQ==
X-Gm-Gg: ASbGncvWmz3+Tj4CVNIuY7hDkt2ltpfz1MoPY+57FrKkzrAEFlzw3ueIwOSLNzKQRzX
 NzZYWoJ8zV/cnSUdCoorjlcZ6ITsJ1AdTHodqC+v7TRmcce9Ip5/20eAbjsLppzT51ZyVir5oME
 LvWlhyBvY4ReP+1z14W0rnpeJCimQJo6a2sdgHv+vygw==
X-Google-Smtp-Source: AGHT+IF6dMAmf5TCQVIuOlNiCsFC6pIsO65sIZ22TS2AyxFMeOraa594EyOHtEPQ108KhkuyTuSgdGqyORqwwcvyH1U=
X-Received: by 2002:aa7:d71a:0:b0:60b:9cf8:b218 with SMTP id
 4fb4d7f45d1cf-60b9cf8b656mr2064496a12.7.1750550426760; Sat, 21 Jun 2025
 17:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
In-Reply-To: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 21 Jun 2025 20:00:14 -0400
X-Gm-Features: AX0GCFsaIx4eYVhuiiXUiWWX-IqXmWkVSGp8j01KL2JL6JrMYvzPL7yWNC9aL58
Message-ID: <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
Subject: Re: FreeBSD 14.1 aarch64 iso URL is down
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat, Jun 21, 2025 at 7:59=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:

(I forgot to CC qemu-devel)

>
> Hi,
> This might only be temporary, but the CI is getting HTTP 404 Not Found
> for the following URL:
> https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.1/FreeB=
SD-14.1-RELEASE-arm64-aarch64-bootonly.iso
>
> https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848
>
> Stefan

