Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23687C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 19:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s04pJ-00031C-Cr; Thu, 25 Apr 2024 15:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s04pD-0002uQ-9z
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 15:32:08 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s04p1-0006C6-P4
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 15:32:04 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51bab51e963so1748110e87.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714073509; x=1714678309; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KTZxjBualWG7G5uD513wTTeGOZBcOOhsfmHgW/cBn20=;
 b=VuvUSnLPT6zN4Xlrc0Uds4wJUa59O+u+mKuJTwqcikeypjvY413KWoSjeHRvjuQQ+0
 YRkisOVcFBSd/MaL2kRrMN6gzC/m6efzeA/gAdzlkPpEixxO+Fj/NiebIfqvZrO+IjdH
 M0SUlU6iW7zo0WzxSO3IgMCDFV9yVgNfq0O7+gdkg2eDjmu1Fau9fCbwOo2sh4xPgVOb
 RXDIPDEa0zuaAUKW/I4qw9b+YaCndQBlCzcIKLE9t/BrhVMHNy3N6GmK6GNposfam8h8
 3DmdZHiHY7cpHxNcZWwrkFokiLMtnb63JIs4b4vKiSvQVnWIJD9IxNJ3eDaKHmaOXxDJ
 oKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714073509; x=1714678309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KTZxjBualWG7G5uD513wTTeGOZBcOOhsfmHgW/cBn20=;
 b=uK8Qx0+Ijbav89adfIsXidFh2lEyZ7T920rfxre74wSTJ1+ZYTWyAxgLF9ZVG2MtVG
 kBT3/IDYViujP5nLmqeLJ95NZorf5VZgtmAXKy7Bg5Oblu61nzysbtdR8151XT39Rw94
 J0hF2vYeAFbaVOK7yBPvT6KrlYUci4sW0sVQW87oMnqjZxPFmVfyeoVUHnX8FSuEAGA+
 K3HLhaOBsv9Kb/j9LT9LGVTUo9Ea6hGRCcuMKxcosJD9EP4binDmGbwutcRbucVh67Bx
 Sdhsgn/KyxBYhJrRN+VWnxNI+ChDFjOVhHa47HZBqc2GibBWq1aqLyOR0Tr3A5X0tvlD
 TTIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8hMqgBdpSH39p/rjgAh5q2l2jb9R8FflwquPFcfSq137XCdELUODyaLvRw4NjZ3qQ82EeAgjMXo9/NiHJrcCSF9Qfvqs=
X-Gm-Message-State: AOJu0Yzk4DjNeFVUa4YO8FXp1YaG1nVEot9BkKAhwLaL9wJ4CZqEOHWH
 H8NSWLYNf9SM0cvCw5uovQ5nIidXmakJGTfURcpWjcQh0AdVh78cYLB9yRpYfzRPHgc/qmcbqj6
 N/blUP3ftaIO75wW/X2d6TDpker6RljLAd/ASeg==
X-Google-Smtp-Source: AGHT+IFoDtOWigsrfZ/2/hfCBZQQ2WLL2aMyPvOBZbG5xeUxbpE9A3F2m0jvcOu7fdpmOXuvxUckLBYrJcB2L00KoSc=
X-Received: by 2002:a05:6512:480f:b0:51b:f0c7:a95c with SMTP id
 eo15-20020a056512480f00b0051bf0c7a95cmr219985lfb.8.1714073509261; Thu, 25 Apr
 2024 12:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240415151845.1564201-1-peter.maydell@linaro.org>
In-Reply-To: <20240415151845.1564201-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2024 20:31:38 +0100
Message-ID: <CAFEAcA86Frw=GcWdjOgXsbP+9dgGjQpxP79k=nKshPm9LK0QVQ@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado: update sunxi kernel from armbian to 6.6.16
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

Whoops, forgot to cc the allwinner maintainers/reviewers on this.
Ping for review, please?

thanks
-- PMM

On Mon, 15 Apr 2024 at 16:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The Linux kernel 5.10.16 binary for sunxi has been removed from
> apt.armbian.com. This means that the avocado tests for these machines
> will be skipped (status CANCEL) if the old binary isn't present in
> the avocado cache.
>
> Update to 6.6.16, in the same way we did in commit e384db41d8661
> when we moved to 5.10.16 in 2021.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2284
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> At this point in the release cycle I don't think I really want
> to put this into 9.0, though I could just about squeeze it in.
>
> cc'ing stable as an FYI -- since the tests fall back to the
> CANCEL status this doesn't break CI, so it's not a requirement
> to backport to any stable branches. But it would probably be
> preferable to get the coverage back on the stable branches so
> we can detect if we get something wrong on a backport of a
> patch that affects these machines.
> ---
>  tests/avocado/boot_linux_console.py | 70 ++++++++++++++---------------
>  tests/avocado/replay_kernel.py      |  8 ++--
>  2 files changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
> index 989b65111c0..d0ab5aaa83a 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -646,12 +646,12 @@ def test_arm_cubieboard_initrd(self):
>          :avocado: tags=accel:tcg
>          """
>          deb_url = ('https://apt.armbian.com/pool/main/l/'
> -                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> -        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> +        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>          kernel_path = self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinuz-5.10.16-sunxi')
> -        dtb_path = '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
> +                                            '/boot/vmlinuz-6.6.16-current-sunxi')
> +        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> @@ -690,12 +690,12 @@ def test_arm_cubieboard_sata(self):
>          :avocado: tags=accel:tcg
>          """
>          deb_url = ('https://apt.armbian.com/pool/main/l/'
> -                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> -        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> +        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>          kernel_path = self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinuz-5.10.16-sunxi')
> -        dtb_path = '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
> +                                            '/boot/vmlinuz-6.6.16-current-sunxi')
> +        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>          rootfs_url = ('https://github.com/groeck/linux-build-test/raw/'
>                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> @@ -872,13 +872,13 @@ def test_arm_bpim2u(self):
>          :avocado: tags=machine:bpim2u
>          :avocado: tags=accel:tcg
>          """
> -        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
> -                   'linux-image-current-sunxi_21.02.2_armhf.deb')
> -        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +        deb_url = ('https://apt.armbian.com/pool/main/l/'
> +                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> +        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>          kernel_path = self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinuz-5.10.16-sunxi')
> -        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
> +                                            '/boot/vmlinuz-6.6.16-current-sunxi')
> +        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
>                      'sun8i-r40-bananapi-m2-ultra.dtb')
>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>
> @@ -899,13 +899,13 @@ def test_arm_bpim2u_initrd(self):
>          :avocado: tags=accel:tcg
>          :avocado: tags=machine:bpim2u
>          """
> -        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
> -                   'linux-image-current-sunxi_21.02.2_armhf.deb')
> -        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +        deb_url = ('https://apt.armbian.com/pool/main/l/'
> +                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> +        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>          kernel_path = self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinuz-5.10.16-sunxi')
> -        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
> +                                            '/boot/vmlinuz-6.6.16-current-sunxi')
> +        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
>                      'sun8i-r40-bananapi-m2-ultra.dtb')
>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> @@ -946,13 +946,13 @@ def test_arm_bpim2u_gmac(self):
>          """
>          self.require_netdev('user')
>
> -        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
> -                   'linux-image-current-sunxi_21.02.2_armhf.deb')
> -        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +        deb_url = ('https://apt.armbian.com/pool/main/l/'
> +                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> +        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>          kernel_path = self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinuz-5.10.16-sunxi')
> -        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
> +                                            '/boot/vmlinuz-6.6.16-current-sunxi')
> +        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
>                      'sun8i-r40-bananapi-m2-ultra.dtb')
>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>          rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
> @@ -1049,12 +1049,12 @@ def test_arm_orangepi(self):
>          :avocado: tags=accel:tcg
>          """
>          deb_url = ('https://apt.armbian.com/pool/main/l/'
> -                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> -        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> +        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>          kernel_path = self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinuz-5.10.16-sunxi')
> -        dtb_path = '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
> +                                            '/boot/vmlinuz-6.6.16-current-sunxi')
> +        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>
>          self.vm.set_console()
> @@ -1075,12 +1075,12 @@ def test_arm_orangepi_initrd(self):
>          :avocado: tags=machine:orangepi-pc
>          """
>          deb_url = ('https://apt.armbian.com/pool/main/l/'
> -                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> -        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> +        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>          kernel_path = self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinuz-5.10.16-sunxi')
> -        dtb_path = '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
> +                                            '/boot/vmlinuz-6.6.16-current-sunxi')
> +        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> @@ -1121,12 +1121,12 @@ def test_arm_orangepi_sd(self):
>          self.require_netdev('user')
>
>          deb_url = ('https://apt.armbian.com/pool/main/l/'
> -                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> -        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> +        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>          kernel_path = self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinuz-5.10.16-sunxi')
> -        dtb_path = '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
> +                                            '/boot/vmlinuz-6.6.16-current-sunxi')
> +        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>          rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
>                        'buildroot-baseline/20221116.0/armel/rootfs.ext2.xz')
> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
> index 10d99403a4c..0474f7b7c8e 100644
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -203,12 +203,12 @@ def test_arm_cubieboard_initrd(self):
>          :avocado: tags=machine:cubieboard
>          """
>          deb_url = ('https://apt.armbian.com/pool/main/l/'
> -                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> -        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> +        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>          kernel_path = self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinuz-5.10.16-sunxi')
> -        dtb_path = '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
> +                                            '/boot/vmlinuz-6.6.16-current-sunxi')
> +        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> --
> 2.34.1
>

