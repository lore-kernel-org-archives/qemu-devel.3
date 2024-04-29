Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CDAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 20:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Xnh-000644-DN; Mon, 29 Apr 2024 16:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1s1Xnf-00063g-E1; Mon, 29 Apr 2024 16:40:35 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1s1Xna-00032r-Nb; Mon, 29 Apr 2024 16:40:35 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-61804067da0so46667597b3.0; 
 Mon, 29 Apr 2024 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714423227; x=1715028027; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6V/CrElNwNNnlxTPID4N4FF9zSfvE0AWNUJIIWDEKWc=;
 b=fepzNRcxcXP0bZ04CKKpMdS1HUsc5N+w2v5HKzMvPxATnXKl9vyfzO6jfBIDyoMJQN
 nLrenHIj5ZpIuSJgiFIotx6ahiqCZWG+f+pZgXclx66MSNGsAAy2pglvURlFHuzJM62G
 KQU5b4Hq2P+pqUWjsMJEzb44m+plr6k6LIDpaK/4Re1Uv7WGACWwgp3fxotCUPYbZ7Hd
 DhNAl8X2zWGjpOiWP0+dZHLlmD/8G8MTHWBmCCB1yCmeBMdDdjCkkXHx07kfABIo8rja
 qKsiLE+f8yrwmRKAcNtue0T2vjD0AkUGNBPLY9Iwi22d9gHvt3/IAv/p5knutgyU8Nzd
 htAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714423227; x=1715028027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6V/CrElNwNNnlxTPID4N4FF9zSfvE0AWNUJIIWDEKWc=;
 b=nmAbZwuHeB8HVUb+P1cxFOHdyNUn5PL9veOCMWDd2xbWNKEaGA7W8ExDtMobhW34Ir
 Wq34UbgefKp50N0/R6OMrYSrHuacP2JFQRdAZYj/CONiwvRhqF26flaQ307iziDoAwid
 GFdWeeTRnsrrEHYgC4H4nR0peZbRjyCjqEs7MmQJWpRdDosVtn36iFTLY0vly1wpRqWN
 NO09AD/Aaa0YW4Ap1lgsuIpsIYvxfbXv0Dmsutji1nsC4R0pN6tHIRjHvjmmyiLS5Lrh
 a0gAGVakT1b9b+zO6MH113Q/QQPrmbYRdfKuNfI02G8WNuXVjr2hQvpN+szgbZoEcKuB
 osUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhsGI2SFPt3m3Gw6HtLOj2J1SsJqH+RQL2x+nQsgiirZhoQ2UxpJhuG9Y3FV3q0t1f5JrzB8JaNPVcYDRgOFkbEXefD9Jq/8nEq6I/ouoaN0dkS4TNPXr12SI/NWYjzEqXypaWBPi8MS6XUXmN2uZ/bCY=
X-Gm-Message-State: AOJu0Yy1nI+GjvBzUdZorU81VCIW9iuhvvfxj1BXZ6ih+rNSPY45tnIf
 PX5Nn9c46yoc0w4NioBS3Ct6tyPZAyqGwWTLSuQODZDvJSlMVwoT9JqW6kU5lJIkFuj+4jZuSWf
 +oVak1cuuqoE/QGDvGzINI0EtzVs=
X-Google-Smtp-Source: AGHT+IFzJ3zPemtiJq0HwRYklLhnJ1U4JRcpsWMm83woHWMhF3iJiKRzU39n6HyrYfspBBkprauWbN96zx4niSR2g5g=
X-Received: by 2002:a05:690c:6c82:b0:615:187:541d with SMTP id
 is2-20020a05690c6c8200b006150187541dmr8792070ywb.24.1714423227372; Mon, 29
 Apr 2024 13:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240415151845.1564201-1-peter.maydell@linaro.org>
 <CAFEAcA86Frw=GcWdjOgXsbP+9dgGjQpxP79k=nKshPm9LK0QVQ@mail.gmail.com>
 <CABtshVRrPv8uUuX3C2k1BPkS4-_0HQH6aKiMFmLr1B1bck-+Pg@mail.gmail.com>
In-Reply-To: <CABtshVRrPv8uUuX3C2k1BPkS4-_0HQH6aKiMFmLr1B1bck-+Pg@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 29 Apr 2024 22:40:16 +0200
Message-ID: <CAPan3Wp7jzm+ErEi0LR+F0acOggt94FPfJCYb-VEUGriiZnPtw@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado: update sunxi kernel from armbian to 6.6.16
To: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007660100617424386"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, MIME_BOUND_DIGITS_15=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

--0000000000007660100617424386
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter, Strahinja,

I can confirm that the orangepi-pc and cubieboard based tests are working
OK using the newer kernel 6.6.16:

  $ ARMBIAN_ARTIFACTS_CACHED=3Dyes AVOCADO_ALLOW_LARGE_STORAGE=3Dyes
./build/pyvenv/bin/avocado --show=3Dapp,console run -t machine:orangepi-pc =
-t
machine:cubieboard tests/avocado/boot_linux_console.py
  ...
  RESULTS    : PASS 7 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 1
  JOB TIME   : 177.65 s

So for this patch:
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

About the BootLinuxConsole.test_arm_orangepi_bionic_20_08 test, I'd be
happy to provide a patch to revive that test.
Since that test is no longer working without having the image available,
this could also be a good moment to re-consider if armbian is really the
best input for testing
the orangepi-pc board. The image is relatively larger and slower compared
to other images, like the two openwrt based tests for cubieboard and bpim2u=
.

After some searching I've found that Openwrt also has orangepi-pc support:
  https://openwrt.org/toh/xunlong/orange_pi_pc

That image works fine with our emulated orangepi-pc board:

$ qemu-system-arm -M orangepi-pc -sd
openwrt-23.05.0-sunxi-cortexa7-xunlong_orangepi-pc-ext4-sdcard.img
-nographic
U-Boot SPL 2020.07-OpenWrt-r23497-6637af95aa (Oct 09 2023 - 21:45:35 +0000)
DRAM: 1024 MiB
Failed to set core voltage! Can't set CPU frequency
Trying to boot from MMC1


U-Boot 2020.07-OpenWrt-r23497-6637af95aa (Oct 09 2023 - 21:45:35 +0000)
Allwinner Technology

CPU:   Allwinner H3 (SUN8I 0000)
Model: Xunlong Orange Pi PC
...
Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.15.134 (builder@buildhost)
(arm-openwrt-linux-muslgnueabi-gcc (OpenWrt GCC 12.3.0 r23497-6637af95aa)
12.3.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Mon Oct 9 21:45:35 2023
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7),
cr=3D30c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
...
BusyBox v1.36.1 (2023-10-09 21:45:35 UTC) built-in shell (ash)

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 OpenWrt 23.05.0, r23497-6637af95aa
 -----------------------------------------------------
=3D=3D=3D WARNING! =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
There is no root password defined on this device!
Use the "passwd" command to set up a new password
in order to prevent unauthorized SSH logins.
--------------------------------------------------
root@(none):/# uname -a
Linux (none) 5.15.134 #0 SMP Mon Oct 9 21:45:35 2023 armv7l GNU/Linux

Using openwrt also for the orangepi-pc test instead of armbian also gives
some consistency between the various tests, to some degree. What are you
opinions on this?

Regards,
Niek


On Fri, Apr 26, 2024 at 12:24=E2=80=AFAM Strahinja Jankovic <
strahinjapjankovic@gmail.com> wrote:

> Hi Peter,
>
> I ran the avocado tests and this patch looks good to me.
> The only comment I have would be that the `test_arm-Orangepi_bionic_20_08=
`
> is not executed anymore since the image is not available, but I guess tha=
t
> can be another patch.
>
>
>
> On Thu, Apr 25, 2024 at 9:31=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org>
> wrote:
>
>> Whoops, forgot to cc the allwinner maintainers/reviewers on this.
>> Ping for review, please?
>>
>> thanks
>> -- PMM
>>
>> On Mon, 15 Apr 2024 at 16:18, Peter Maydell <peter.maydell@linaro.org>
>> wrote:
>> >
>> > The Linux kernel 5.10.16 binary for sunxi has been removed from
>> > apt.armbian.com. This means that the avocado tests for these machines
>> > will be skipped (status CANCEL) if the old binary isn't present in
>> > the avocado cache.
>> >
>> > Update to 6.6.16, in the same way we did in commit e384db41d8661
>> > when we moved to 5.10.16 in 2021.
>> >
>> > Cc: qemu-stable@nongnu.org
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2284
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > ---
>> > At this point in the release cycle I don't think I really want
>> > to put this into 9.0, though I could just about squeeze it in.
>> >
>> > cc'ing stable as an FYI -- since the tests fall back to the
>> > CANCEL status this doesn't break CI, so it's not a requirement
>> > to backport to any stable branches. But it would probably be
>> > preferable to get the coverage back on the stable branches so
>> > we can detect if we get something wrong on a backport of a
>> > patch that affects these machines.
>> > ---
>> >  tests/avocado/boot_linux_console.py | 70 ++++++++++++++--------------=
-
>> >  tests/avocado/replay_kernel.py      |  8 ++--
>> >  2 files changed, 39 insertions(+), 39 deletions(-)
>> >
>> > diff --git a/tests/avocado/boot_linux_console.py
>> b/tests/avocado/boot_linux_console.py
>> > index 989b65111c0..d0ab5aaa83a 100644
>> > --- a/tests/avocado/boot_linux_console.py
>> > +++ b/tests/avocado/boot_linux_console.py
>> > @@ -646,12 +646,12 @@ def test_arm_cubieboard_initrd(self):
>> >          :avocado: tags=3Daccel:tcg
>> >          """
>> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
>> > -
>>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
>> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
>> > +
>>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
>> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> >          kernel_path =3D self.extract_from_deb(deb_path,
>> > -
>> '/boot/vmlinuz-5.10.16-sunxi')
>> > -        dtb_path =3D
>> '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
>> > +
>> '/boot/vmlinuz-6.6.16-current-sunxi')
>> > +        dtb_path =3D
>> '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
>> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
>> >          initrd_url =3D ('https://github.com/groeck/linux-build-test/r=
aw/
>> '
>> >
>> '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
>> > @@ -690,12 +690,12 @@ def test_arm_cubieboard_sata(self):
>> >          :avocado: tags=3Daccel:tcg
>> >          """
>> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
>> > -
>>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
>> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
>> > +
>>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
>> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> >          kernel_path =3D self.extract_from_deb(deb_path,
>> > -
>> '/boot/vmlinuz-5.10.16-sunxi')
>> > -        dtb_path =3D
>> '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
>> > +
>> '/boot/vmlinuz-6.6.16-current-sunxi')
>> > +        dtb_path =3D
>> '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
>> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
>> >          rootfs_url =3D ('https://github.com/groeck/linux-build-test/r=
aw/
>> '
>> >
>> '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
>> > @@ -872,13 +872,13 @@ def test_arm_bpim2u(self):
>> >          :avocado: tags=3Dmachine:bpim2u
>> >          :avocado: tags=3Daccel:tcg
>> >          """
>> > -        deb_url =3D ('
>> https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
>> > -                   'linux-image-current-sunxi_21.02.2_armhf.deb')
>> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
>> > +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
>> > +
>>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
>> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> >          kernel_path =3D self.extract_from_deb(deb_path,
>> > -
>> '/boot/vmlinuz-5.10.16-sunxi')
>> > -        dtb_path =3D ('/usr/lib/linux-image-current-sunxi/'
>> > +
>> '/boot/vmlinuz-6.6.16-current-sunxi')
>> > +        dtb_path =3D ('/usr/lib/linux-image-6.6.16-current-sunxi/'
>> >                      'sun8i-r40-bananapi-m2-ultra.dtb')
>> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
>> >
>> > @@ -899,13 +899,13 @@ def test_arm_bpim2u_initrd(self):
>> >          :avocado: tags=3Daccel:tcg
>> >          :avocado: tags=3Dmachine:bpim2u
>> >          """
>> > -        deb_url =3D ('
>> https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
>> > -                   'linux-image-current-sunxi_21.02.2_armhf.deb')
>> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
>> > +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
>> > +
>>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
>> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> >          kernel_path =3D self.extract_from_deb(deb_path,
>> > -
>> '/boot/vmlinuz-5.10.16-sunxi')
>> > -        dtb_path =3D ('/usr/lib/linux-image-current-sunxi/'
>> > +
>> '/boot/vmlinuz-6.6.16-current-sunxi')
>> > +        dtb_path =3D ('/usr/lib/linux-image-6.6.16-current-sunxi/'
>> >                      'sun8i-r40-bananapi-m2-ultra.dtb')
>> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
>> >          initrd_url =3D ('https://github.com/groeck/linux-build-test/r=
aw/
>> '
>> > @@ -946,13 +946,13 @@ def test_arm_bpim2u_gmac(self):
>> >          """
>> >          self.require_netdev('user')
>> >
>> > -        deb_url =3D ('
>> https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
>> > -                   'linux-image-current-sunxi_21.02.2_armhf.deb')
>> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
>> > +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
>> > +
>>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
>> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> >          kernel_path =3D self.extract_from_deb(deb_path,
>> > -
>> '/boot/vmlinuz-5.10.16-sunxi')
>> > -        dtb_path =3D ('/usr/lib/linux-image-current-sunxi/'
>> > +
>> '/boot/vmlinuz-6.6.16-current-sunxi')
>> > +        dtb_path =3D ('/usr/lib/linux-image-6.6.16-current-sunxi/'
>> >                      'sun8i-r40-bananapi-m2-ultra.dtb')
>> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
>> >          rootfs_url =3D ('
>> http://storage.kernelci.org/images/rootfs/buildroot/'
>> > @@ -1049,12 +1049,12 @@ def test_arm_orangepi(self):
>> >          :avocado: tags=3Daccel:tcg
>> >          """
>> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
>> > -
>>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
>> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
>> > +
>>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
>> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> >          kernel_path =3D self.extract_from_deb(deb_path,
>> > -
>> '/boot/vmlinuz-5.10.16-sunxi')
>> > -        dtb_path =3D
>> '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
>> > +
>> '/boot/vmlinuz-6.6.16-current-sunxi')
>> > +        dtb_path =3D
>> '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
>> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
>> >
>> >          self.vm.set_console()
>> > @@ -1075,12 +1075,12 @@ def test_arm_orangepi_initrd(self):
>> >          :avocado: tags=3Dmachine:orangepi-pc
>> >          """
>> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
>> > -
>>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
>> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
>> > +
>>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
>> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> >          kernel_path =3D self.extract_from_deb(deb_path,
>> > -
>> '/boot/vmlinuz-5.10.16-sunxi')
>> > -        dtb_path =3D
>> '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
>> > +
>> '/boot/vmlinuz-6.6.16-current-sunxi')
>> > +        dtb_path =3D
>> '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
>> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
>> >          initrd_url =3D ('https://github.com/groeck/linux-build-test/r=
aw/
>> '
>> >
>> '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
>> > @@ -1121,12 +1121,12 @@ def test_arm_orangepi_sd(self):
>> >          self.require_netdev('user')
>> >
>> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
>> > -
>>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
>> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
>> > +
>>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
>> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> >          kernel_path =3D self.extract_from_deb(deb_path,
>> > -
>> '/boot/vmlinuz-5.10.16-sunxi')
>> > -        dtb_path =3D
>> '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
>> > +
>> '/boot/vmlinuz-6.6.16-current-sunxi')
>> > +        dtb_path =3D
>> '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
>> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
>> >          rootfs_url =3D ('
>> http://storage.kernelci.org/images/rootfs/buildroot/'
>> >
>> 'buildroot-baseline/20221116.0/armel/rootfs.ext2.xz')
>> > diff --git a/tests/avocado/replay_kernel.py
>> b/tests/avocado/replay_kernel.py
>> > index 10d99403a4c..0474f7b7c8e 100644
>> > --- a/tests/avocado/replay_kernel.py
>> > +++ b/tests/avocado/replay_kernel.py
>> > @@ -203,12 +203,12 @@ def test_arm_cubieboard_initrd(self):
>> >          :avocado: tags=3Dmachine:cubieboard
>> >          """
>> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
>> > -
>>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
>> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
>> > +
>>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
>> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
>> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> >          kernel_path =3D self.extract_from_deb(deb_path,
>> > -
>> '/boot/vmlinuz-5.10.16-sunxi')
>> > -        dtb_path =3D
>> '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
>> > +
>> '/boot/vmlinuz-6.6.16-current-sunxi')
>> > +        dtb_path =3D
>> '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
>> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
>> >          initrd_url =3D ('https://github.com/groeck/linux-build-test/r=
aw/
>> '
>> >
>> '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
>> > --
>> > 2.34.1
>> >
>>
>
> Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
>
>
> Best regards,
> Strahinja
>
>

--=20
Niek Linnenbank

--0000000000007660100617424386
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter, Strahinja,</div><div><br></div><div>I can c=
onfirm that the orangepi-pc and cubieboard based tests are working OK using=
 the newer kernel 6.6.16:</div><div><br></div><div>=C2=A0 $ ARMBIAN_ARTIFAC=
TS_CACHED=3Dyes AVOCADO_ALLOW_LARGE_STORAGE=3Dyes ./build/pyvenv/bin/avocad=
o --show=3Dapp,console run -t machine:orangepi-pc -t machine:cubieboard tes=
ts/avocado/boot_linux_console.py</div><div>=C2=A0 ...</div><div>=C2=A0 RESU=
LTS =C2=A0 =C2=A0: PASS 7 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 1<br>=C2=A0 JOB TIME =C2=A0 : 177.65 s</div><div><br></div><div>=
So for this patch:</div><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"ma=
ilto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</div><div>T=
ested-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">n=
ieklinnenbank@gmail.com</a>&gt;<br></div><div><br></div><div>About the Boot=
LinuxConsole.test_arm_orangepi_bionic_20_08 test, I&#39;d be happy to provi=
de a patch to revive that test.<br></div><div>Since that test is no longer =
working without having the image available, this could also be a good momen=
t to re-consider if armbian is really the best input for testing</div><div>=
the orangepi-pc board. The image is relatively larger and slower compared t=
o other images, like the two openwrt based tests for cubieboard and bpim2u.=
</div><div><br></div><div>After some searching I&#39;ve found that Openwrt =
also has orangepi-pc support:</div><div>=C2=A0 <a href=3D"https://openwrt.o=
rg/toh/xunlong/orange_pi_pc">https://openwrt.org/toh/xunlong/orange_pi_pc</=
a></div><div><br></div><div>That image works fine with our emulated orangep=
i-pc board:</div><div><br></div><div>$ qemu-system-arm -M orangepi-pc -sd o=
penwrt-23.05.0-sunxi-cortexa7-xunlong_orangepi-pc-ext4-sdcard.img -nographi=
c</div><div>U-Boot SPL 2020.07-OpenWrt-r23497-6637af95aa (Oct 09 2023 - 21:=
45:35 +0000)<br>DRAM: 1024 MiB<br>Failed to set core voltage! Can&#39;t set=
 CPU frequency<br>Trying to boot from MMC1<br><br><br>U-Boot 2020.07-OpenWr=
t-r23497-6637af95aa (Oct 09 2023 - 21:45:35 +0000) Allwinner Technology<br>=
<br>CPU: =C2=A0 Allwinner H3 (SUN8I 0000)<br>Model: Xunlong Orange Pi PC</d=
iv><div>...</div><div>Starting kernel ...<br><br>[ =C2=A0 =C2=A00.000000] B=
ooting Linux on physical CPU 0x0<br>[ =C2=A0 =C2=A00.000000] Linux version =
5.15.134 (builder@buildhost) (arm-openwrt-linux-muslgnueabi-gcc (OpenWrt GC=
C 12.3.0 r23497-6637af95aa) 12.3.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Mo=
n Oct 9 21:45:35 2023<br>[ =C2=A0 =C2=A00.000000] CPU: ARMv7 Processor [410=
fc075] revision 5 (ARMv7), cr=3D30c5387d<br>[ =C2=A0 =C2=A00.000000] CPU: d=
iv instructions available: patching division code<br>[ =C2=A0 =C2=A00.00000=
0] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache=
</div><div>...</div><div>BusyBox v1.36.1 (2023-10-09 21:45:35 UTC) built-in=
 shell (ash)<br><br>=C2=A0 _______ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ________ =C2=A0 =C2=A0 =C2=A0 =C2=A0__<br>=
=C2=A0| =C2=A0 =C2=A0 =C2=A0 |.-----.-----.-----.| =C2=A0| =C2=A0| =C2=A0|.=
----.| =C2=A0|_<br>=C2=A0| =C2=A0 - =C2=A0 || =C2=A0_ =C2=A0| =C2=A0-__| =
=C2=A0 =C2=A0 || =C2=A0| =C2=A0| =C2=A0|| =C2=A0 _|| =C2=A0 _|<br>=C2=A0|__=
_____|| =C2=A0 __|_____|__|__||________||__| =C2=A0|____|<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |__| W I R E L E S S =C2=A0 F R E E D O M<br>=C2=A0---=
--------------------------------------------------<br>=C2=A0OpenWrt 23.05.0=
, r23497-6637af95aa<br>=C2=A0----------------------------------------------=
-------<br>=3D=3D=3D WARNING! =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>There=
 is no root password defined on this device!<br>Use the &quot;passwd&quot; =
command to set up a new password<br>in order to prevent unauthorized SSH lo=
gins.<br>--------------------------------------------------<br>root@(none):=
/# uname -a<br>Linux (none) 5.15.134 #0 SMP Mon Oct 9 21:45:35 2023 armv7l =
GNU/Linux</div><div><br></div><div>Using openwrt also for the orangepi-pc t=
est instead of armbian also gives some consistency between the various test=
s, to some degree. What are you opinions on this?</div><div><br></div><div>=
Regards,</div><div>Niek<br></div><div><br></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 26, 2024 at 12:=
24=E2=80=AFAM Strahinja Jankovic &lt;<a href=3D"mailto:strahinjapjankovic@g=
mail.com">strahinjapjankovic@gmail.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi =
Peter,<div><br></div><div>I ran the avocado tests and this patch looks good=
 to me.</div><div>The only comment I have would be that the `test_arm-Orang=
epi_bionic_20_08` is not executed anymore since the image is not available,=
 but I guess that can be another patch.</div><div><br></div><div><br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Thu, Apr 25, 2024 at 9:31=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto=
:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Whoops=
, forgot to cc the allwinner maintainers/reviewers on this.<br>
Ping for review, please?<br>
<br>
thanks<br>
-- PMM<br>
<br>
On Mon, 15 Apr 2024 at 16:18, Peter Maydell &lt;<a href=3D"mailto:peter.may=
dell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<=
br>
&gt;<br>
&gt; The Linux kernel 5.10.16 binary for sunxi has been removed from<br>
&gt; <a href=3D"http://apt.armbian.com" rel=3D"noreferrer" target=3D"_blank=
">apt.armbian.com</a>. This means that the avocado tests for these machines=
<br>
&gt; will be skipped (status CANCEL) if the old binary isn&#39;t present in=
<br>
&gt; the avocado cache.<br>
&gt;<br>
&gt; Update to 6.6.16, in the same way we did in commit e384db41d8661<br>
&gt; when we moved to 5.10.16 in 2021.<br>
&gt;<br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-s=
table@nongnu.org</a><br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/228=
4" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2284</a><br>
&gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt; At this point in the release cycle I don&#39;t think I really want<br>
&gt; to put this into 9.0, though I could just about squeeze it in.<br>
&gt;<br>
&gt; cc&#39;ing stable as an FYI -- since the tests fall back to the<br>
&gt; CANCEL status this doesn&#39;t break CI, so it&#39;s not a requirement=
<br>
&gt; to backport to any stable branches. But it would probably be<br>
&gt; preferable to get the coverage back on the stable branches so<br>
&gt; we can detect if we get something wrong on a backport of a<br>
&gt; patch that affects these machines.<br>
&gt; ---<br>
&gt;=C2=A0 tests/avocado/boot_linux_console.py | 70 ++++++++++++++---------=
------<br>
&gt;=C2=A0 tests/avocado/replay_kernel.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++-=
-<br>
&gt;=C2=A0 2 files changed, 39 insertions(+), 39 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_=
linux_console.py<br>
&gt; index 989b65111c0..d0ab5aaa83a 100644<br>
&gt; --- a/tests/avocado/boot_linux_console.py<br>
&gt; +++ b/tests/avocado/boot_linux_console.py<br>
&gt; @@ -646,12 +646,12 @@ def test_arm_cubieboard_initrd(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"http=
s://github.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/&#39;<br=
>
&gt; @@ -690,12 +690,12 @@ def test_arm_cubieboard_sata(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_url =3D (&#39;<a href=3D"http=
s://github.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/&#39;<br=
>
&gt; @@ -872,13 +872,13 @@ def test_arm_bpim2u(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:bpim2u<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/linux-5.10.16-sunxi/" rel=3D"noreferrer" target=3D"=
_blank">https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/</a>&#39;<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https://apt.=
armbian.com/pool/main/l/</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-c=
urrent-sunxi/&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-6=
.6.16-current-sunxi/&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;sun8i-r40-bananapi-m2-ultra.dtb&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;<br>
&gt; @@ -899,13 +899,13 @@ def test_arm_bpim2u_initrd(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:bpim2u<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/linux-5.10.16-sunxi/" rel=3D"noreferrer" target=3D"=
_blank">https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/</a>&#39;<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https://apt.=
armbian.com/pool/main/l/</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-c=
urrent-sunxi/&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-6=
.6.16-current-sunxi/&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;sun8i-r40-bananapi-m2-ultra.dtb&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"http=
s://github.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
&gt; @@ -946,13 +946,13 @@ def test_arm_bpim2u_gmac(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.require_netdev(&#39;user&#39;)<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/linux-5.10.16-sunxi/" rel=3D"noreferrer" target=3D"=
_blank">https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/</a>&#39;<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https://apt.=
armbian.com/pool/main/l/</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-c=
urrent-sunxi/&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-6=
.6.16-current-sunxi/&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;sun8i-r40-bananapi-m2-ultra.dtb&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_url =3D (&#39;<a href=3D"http=
://storage.kernelci.org/images/rootfs/buildroot/" rel=3D"noreferrer" target=
=3D"_blank">http://storage.kernelci.org/images/rootfs/buildroot/</a>&#39;<b=
r>
&gt; @@ -1049,12 +1049,12 @@ def test_arm_orangepi(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
&gt; @@ -1075,12 +1075,12 @@ def test_arm_orangepi_initrd(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:orangepi-pc=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"http=
s://github.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/&#39;<br=
>
&gt; @@ -1121,12 +1121,12 @@ def test_arm_orangepi_sd(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.require_netdev(&#39;user&#39;)<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_url =3D (&#39;<a href=3D"http=
://storage.kernelci.org/images/rootfs/buildroot/" rel=3D"noreferrer" target=
=3D"_blank">http://storage.kernelci.org/images/rootfs/buildroot/</a>&#39;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;buildroot-baseline/20221116.0/armel/rootfs.ext2.xz&#39;)=
<br>
&gt; diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_ker=
nel.py<br>
&gt; index 10d99403a4c..0474f7b7c8e 100644<br>
&gt; --- a/tests/avocado/replay_kernel.py<br>
&gt; +++ b/tests/avocado/replay_kernel.py<br>
&gt; @@ -203,12 +203,12 @@ def test_arm_cubieboard_initrd(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:cubieboard<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"http=
s://github.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/&#39;<br=
>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br></blockquote><div><br><span>Reviewed</span>-<span>by</span>: Strahi=
nja Jankovic &lt;<a href=3D"mailto:strahinja.p.jankovic@gmail.com" target=
=3D"_blank">strahinja.p.jankovic@gmail.com</a>&gt;=C2=A0<br><br><br>Best re=
gards,<br>Strahinja</div><div><br></div></div></div>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Niek Linnenbank<br><br></div></div></div>

--0000000000007660100617424386--

