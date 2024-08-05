Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D22C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 22:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb6ei-0006L1-1e; Mon, 05 Aug 2024 18:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sb6eg-0006HX-EH; Mon, 05 Aug 2024 18:58:18 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sb6ee-0005n8-3t; Mon, 05 Aug 2024 18:58:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc6ee64512so83441095ad.0; 
 Mon, 05 Aug 2024 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722898694; x=1723503494; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQo43CuNT6vG16mBnQH7B4RZJd96dp9SwqJs/InHS18=;
 b=hZIiC0woOMQLhYi4jNyP9nua5uV/lnWn6d3Ch8+sW5mXKDdkHhK+W453WhAlMqTrDv
 D/NdIHM1syh3V4xX2vAYmaHjPxBxzl8i03k+syDUr+Mxl0TAL55LcJ56qsfnkcnRwU07
 1eNJZBLs3tqoPxhLGIne3fX/dxvgycfn+QH+0bPVAO+vkCB6TX5+J00JJZpxVs2Ir3iG
 OmhL/QKVyueVp3Tbqv3J0Yetypm1rOp0VRJmSqbCB0NRWXZ7pvAhDpwKhV2Vw/FFdmy8
 z+eHNP1gW/kX8DhfPrhzuefSOTkGzBzAg2iCw/5Ps35KeBYmRXaNmkuf88xwnmHkRwnu
 XbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722898694; x=1723503494;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EQo43CuNT6vG16mBnQH7B4RZJd96dp9SwqJs/InHS18=;
 b=gIOh7r/7EFuhiTZ1xxr1nxZRoUbuvR+rm2lJDfVLZxW4jNGaLWJp0MCHkSQJGs0IrB
 HIylkHZpJAa57uArc3VxiiOSFIsJwRyLr9PQS0+c48T5IBbWq19Zs8z9SIOuEuNJShL/
 8l1BBUNMZoXu3oEPKpBcwzahapBXHXshMwcB4xs2ac6cPQNc86/D5iydbi+/J5OUb9Li
 NlCjTGxG1bKX78d4NdD1VdsI2tp58cF3UqHstjq+GoaYDMqFcxYwLIPd4jjvbQNN3Qqt
 mDbeEJJcjAZsLyyTC/FSesgQ4c9jedl35A2y6HKk9f5YJUi3/bnlZOUHeR4tcInjur+6
 9z0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+nuul/LgVncO9mBKMUoOLYhF1OngXbYc5WG5HbUlp6zbGIUJo5fxMSJkxKTpgpfWCIM9F8CqLkF3odIcJDx7ktmeAZSuCefY8N6TDC4S6dI8Df2TL3xde2Nw=
X-Gm-Message-State: AOJu0Yy3BF7Sx71d0m2iOo8tnUeVtIyfiftqsgdnVOwypuJrGyexWlkf
 b3rH+5aa4zItdGd579y3MLNw4Vb6hKtOE4WaeWqDEbkJ8YZ/dYUj
X-Google-Smtp-Source: AGHT+IE3nr1gV5PmJE9dgoAnUiA9/5rjRuQumRM8tGUcj4ViLRxx9mjZxs3df6Lkl31fi7jQtbtaOg==
X-Received: by 2002:a17:902:e5c9:b0:1fb:64da:b142 with SMTP id
 d9443c01a7336-1ff574f685bmr129160725ad.59.1722898694106; 
 Mon, 05 Aug 2024 15:58:14 -0700 (PDT)
Received: from localhost ([1.145.206.202]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592b659asm73685275ad.301.2024.08.05.15.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 15:58:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Aug 2024 08:58:06 +1000
Message-Id: <D38CM1VZ3K2M.25N2MXFIFENIY@gmail.com>
Subject: Re: [PATCH v3 20/24] tests/functional: Convert the ppc_hv avocado
 test into a standalone test
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>
Cc: "Fabiano Rosas" <farosas@suse.de>, "Paolo Bonzini"
 <pbonzini@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "John Snow" <jsnow@redhat.com>, <qemu-ppc@nongnu.org>,
 "Richard Henderson" <richard.henderson@linaro.org>, "Ani Sinha"
 <anisinha@redhat.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Thomas Huth" <thuth@redhat.com>
X-Mailer: aerc 0.18.2
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-21-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-21-berrange@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

Thanks for doing this.

I have a fix for this problem, it's a bug with the test harness
code but was not merged yet. I'll re-send it.

Thanks,
Nick

On Wed Jul 31, 2024 at 3:03 AM AEST, Daniel P. Berrang=C3=A9 wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> Note: The original Avocado test seems currently to be broken, it hangs
> when the guest is trying to install additional packages. So mark it as
> broken for now until it gets fixed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../test_ppc64_hv.py}                         | 48 ++++++++-----------
>  1 file changed, 20 insertions(+), 28 deletions(-)
>  rename tests/{avocado/ppc_hv_tests.py =3D> functional/test_ppc64_hv.py} =
(88%)
>  mode change 100644 =3D> 100755
>
> diff --git a/tests/avocado/ppc_hv_tests.py b/tests/functional/test_ppc64_=
hv.py
> old mode 100644
> new mode 100755
> similarity index 88%
> rename from tests/avocado/ppc_hv_tests.py
> rename to tests/functional/test_ppc64_hv.py
> index bf8822bb97..a45657c87e
> --- a/tests/avocado/ppc_hv_tests.py
> +++ b/tests/functional/test_ppc64_hv.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>  # Tests that specifically try to exercise hypervisor features of the
>  # target machines. powernv supports the Power hypervisor ISA, and
>  # pseries supports the nested-HV hypervisor spec.
> @@ -7,10 +9,10 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
> =20
> -from avocado import skipIf, skipUnless
> -from avocado.utils import archive
> -from avocado_qemu import QemuSystemTest
> -from avocado_qemu import wait_for_console_pattern, exec_command
> +from unittest import skipIf, skipUnless
> +from qemu_test.utils import archive_extract
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern, exec_command
>  import os
>  import time
>  import subprocess
> @@ -47,7 +49,7 @@ def missing_deps():
>  @skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(dep=
s))
>  @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stu=
ck due to console handling problem')
>  @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
> -@skipUnless(os.getenv('SPEED') =3D=3D 'slow', 'runtime limited')
> +@skip('broken test - guest fails to install packages')
>  class HypervisorTest(QemuSystemTest):
> =20
>      timeout =3D 1000
> @@ -55,6 +57,12 @@ class HypervisorTest(QemuSystemTest):
>      panic_message =3D 'Kernel panic - not syncing'
>      good_message =3D 'VFS: Cannot open root device'
> =20
> +    # Alpine use sha256 so I recalculated this myself
> +    ASSET_ISO =3D Asset(
> +        ('https://dl-cdn.alpinelinux.org/alpine/v3.18/'
> +         'releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso'),
> +        'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3f=
f')
> +
>      def extract_from_iso(self, iso, path):
>          """
>          Extracts a file from an iso file into the test workdir
> @@ -84,14 +92,7 @@ def extract_from_iso(self, iso, path):
>      def setUp(self):
>          super().setUp()
> =20
> -        iso_url =3D ('https://dl-cdn.alpinelinux.org/alpine/v3.18/releas=
es/ppc64le/alpine-standard-3.18.4-ppc64le.iso')
> -
> -        # Alpine use sha256 so I recalculated this myself
> -        iso_sha256 =3D 'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d554861009=
9af75300edd7b3ff'
> -        iso_path =3D self.fetch_asset(iso_url, asset_hash=3Diso_sha256,
> -                                    algorithm =3D "sha256")
> -
> -        self.iso_path =3D iso_path
> +        self.iso_path =3D self.ASSET_ISO.fetch()
>          self.vmlinuz =3D self.extract_from_iso(iso_path, '/boot/vmlinuz-=
lts')
>          self.initramfs =3D self.extract_from_iso(iso_path, '/boot/initra=
mfs-lts')
> =20
> @@ -159,12 +160,8 @@ def do_test_kvm(self, hpt=3DFalse):
>          wait_for_console_pattern(self, 'alpine:~#')
> =20
>      def test_hv_pseries(self):
> -        """
> -        :avocado: tags=3Darch:ppc64
> -        :avocado: tags=3Dmachine:pseries
> -        :avocado: tags=3Daccel:tcg
> -        """
>          self.require_accelerator("tcg")
> +        self.set_machine('pseries')
>          self.vm.add_args("-accel", "tcg,thread=3Dmulti")
>          self.vm.add_args('-device', 'nvme,serial=3D1234,drive=3Ddrive0')
>          self.vm.add_args("-machine", "x-vof=3Don,cap-nested-hv=3Don")
> @@ -174,12 +171,8 @@ def test_hv_pseries(self):
>          self.do_stop_alpine()
> =20
>      def test_hv_pseries_kvm(self):
> -        """
> -        :avocado: tags=3Darch:ppc64
> -        :avocado: tags=3Dmachine:pseries
> -        :avocado: tags=3Daccel:kvm
> -        """
>          self.require_accelerator("kvm")
> +        self.set_machine('pseries')
>          self.vm.add_args("-accel", "kvm")
>          self.vm.add_args('-device', 'nvme,serial=3D1234,drive=3Ddrive0')
>          self.vm.add_args("-machine", "x-vof=3Don,cap-nested-hv=3Don,cap-=
ccf-assist=3Doff")
> @@ -189,12 +182,8 @@ def test_hv_pseries_kvm(self):
>          self.do_stop_alpine()
> =20
>      def test_hv_powernv(self):
> -        """
> -        :avocado: tags=3Darch:ppc64
> -        :avocado: tags=3Dmachine:powernv
> -        :avocado: tags=3Daccel:tcg
> -        """
>          self.require_accelerator("tcg")
> +        self.set_machine('powernv')
>          self.vm.add_args("-accel", "tcg,thread=3Dmulti")
>          self.vm.add_args('-device', 'nvme,bus=3Dpcie.2,addr=3D0x0,serial=
=3D1234,drive=3Ddrive0',
>                           '-device', 'e1000e,netdev=3Dnet0,mac=3DC0:FF:EE=
:00:00:02,bus=3Dpcie.0,addr=3D0x0',
> @@ -204,3 +193,6 @@ def test_hv_powernv(self):
>          self.do_test_kvm()
>          self.do_test_kvm(True)
>          self.do_stop_alpine()
> +
> +if __name__ =3D=3D '__main__':
> +    QemuSystemTest.main()


