Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC69C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 20:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXQlo-00066D-SL; Thu, 03 Jul 2025 16:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uXQlB-0005o1-P9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 16:42:24 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uXQl8-0004qd-RM
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 16:42:21 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-313bb9b2f5bso391344a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1751575336; x=1752180136;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avcS83d1xROyrkb+P9B6fRdqS6ZXLOHUYmszroxpApg=;
 b=AhfB0IUaMdEESYCOz4ProZ0sX+evNHSHamwSyd6hgozyDQqAq3zjJybVdBYyP+NDvD
 r6iVT7nuEIgYjPzKTQMfA5XR2WVwIQom3R/53qBU1sFp7GZM+0j3DrsLv3x2NHxSyZp4
 gAf++72Js4dJetlg1pD8EC9a5ltU39wi4omDhrvS+l2jgtJnk1j24kBRTNXwgnjLtS8Z
 Ow5IujNdPFpY4lkGuzOtFTdzKCxp94qy3iLmRkoAjYdq1wVZYFDxh9xEV9nPzejaY3rM
 uNePFmkv7I75yGH4oowhwYzWm9Ixedrx4295Rpzaw720zudgrmgf6jWzZ9P1rnJcrd+f
 7wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751575336; x=1752180136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avcS83d1xROyrkb+P9B6fRdqS6ZXLOHUYmszroxpApg=;
 b=f1M2Vix6qJ0OeZl3RC3OmGNzziiMjqMyhRYutRGSHFrE/pIsWyyoXRfa2Ri26FSd4D
 Y6L491rFCdtSQrRN4VV5hyLEnMv4rKjPS4Ji6+DJ+bNNfF59f1JMIvZr2bMgpTYpPt/G
 wxNJVoRv9JPsBKj0YdrieS7wjnfc2vBe6yYVmTorW7pvldnLLh8wGWggnmIOk7adcUM/
 sDQFW248q/59fK2FC5mpp8aG+zzbbhbKtDm2htK5g0dC1nxy2SMnTBBJTKKdn4BbhuXW
 tsQe/Z15KIw5wVyVNLSWQj8V722KpsC8UA7WDBh+CTIVDsu+u8YPxWjFfGZqpZxsd7Vj
 /CPw==
X-Gm-Message-State: AOJu0Yz3eU61Uw6ET2hHUy1mBSIkn3JcTytbKyMAakASW4lN9Q3TIIcc
 2AhUMlZIsqafEbNyCHli60D+qsFjIg0st0NS3XzYcCHwTHImWZW+WPArTXRxhB6rWqPLx6nhwmM
 HbS+7+PILwoa1ffeElwyvfRNPhs5t+bv9LVs3ekxYYw==
X-Gm-Gg: ASbGnctxgkQUmcgv9hmK9zOgK89tmuGfyQScGb9VzIE+Rq4qoGatQegLJnZjDWgdee5
 Dm5n+ruhGlJPOmlonTxd2+kWoX/rMZxs2IzQUIlIvgm/KZKIpJS8aX7ACX/LCukE6mk6VJixJa5
 GaLAzKSDRbe5sC4+v+UnLUzohaFtHrQaqShXvK8AXuhps=
X-Google-Smtp-Source: AGHT+IHHpPgN8rnUbcdZ/xDo5IoKTDzfIDPb6TS7YA2cs9uMK6SNgXUc21+94Qqzn3vWYRgLY5+kNVqyZ1VaVkIi+Hk=
X-Received: by 2002:a17:90b:3dc8:b0:311:e8cc:4253 with SMTP id
 98e67ed59e1d1-31aac436a71mr59636a91.2.1751575336441; Thu, 03 Jul 2025
 13:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250701105809.366180-1-thuth@redhat.com>
In-Reply-To: <20250701105809.366180-1-thuth@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 3 Jul 2025 14:42:04 -0600
X-Gm-Features: Ac12FXyZmu9HvAPM6zhdITrUKOMhC-JJWBaKQojR5x_lqQ02a2kNVjNvQQF1TPI
Message-ID: <CANCZdfoRtq53M5zf+KZD3rU9CggTZ0kNj0+=-yvAZ-ijziFzTw@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/test_aarch64_sbsaref_freebsd: Fix the
 URL of the ISO image
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-arm@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 1, 2025 at 4:58=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The original image has been removed from the server, so the test
> currently fails if it has to fetch the asset, but we can still
> download the ISO from the archive server. While we're at it, prefer
> the XZ compressed image, it's much smaller and thus the download
> should be faster.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/test_aarch64_sbsaref_freebsd.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/fun=
ctional/test_aarch64_sbsaref_freebsd.py
> index 26dfc5878bb..92ebc69c9b1 100755
> --- a/tests/functional/test_aarch64_sbsaref_freebsd.py
> +++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
> @@ -18,9 +18,9 @@
>  class Aarch64SbsarefFreeBSD(QemuSystemTest):
>
>      ASSET_FREEBSD_ISO =3D Asset(
> -        ('https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES=
/'
> -         '14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso'),
> -        '44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad46=
1')
> +        ('http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/old-release=
s/arm64'
> +         '/aarch64/ISO-IMAGES/14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bo=
otonly.iso.xz'),
> +        '7313a4495ffd71ab77b49b1e83f571521c32756e1d75bf48bd890e0ab0f7582=
7')
>
>      # This tests the whole boot chain from EFI to Userspace
>      # We only boot a whole OS for the current top level CPU and GIC
> @@ -28,7 +28,7 @@ class Aarch64SbsarefFreeBSD(QemuSystemTest):
>      def boot_freebsd14(self, cpu=3DNone):
>          fetch_firmware(self)
>
> -        img_path =3D self.ASSET_FREEBSD_ISO.fetch()
> +        img_path =3D self.uncompress(self.ASSET_FREEBSD_ISO)
>
>          self.vm.set_console()
>          self.vm.add_args(

Reviewed-by: Warner Losh <imp@bsdimp.com>

Though maybe updating to 14.3 would be better.

Warner

