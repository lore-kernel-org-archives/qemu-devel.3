Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D0AC5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxssx-0007p3-7U; Sat, 22 Aug 2026 17:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wxssv-0007oP-Ae
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:04:13 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wxssq-0002qv-6v
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:04:13 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c1c50c1e29bso348266866b.3
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787432646; x=1788037446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C4UpZeWfTiSJYpw1MLG2Esws2ocptFwER3yYU0370DM=;
 b=NTK1fW+0igF2/C3q52vMzSW6a4JqYvfEAqQYhqpvOnHtDQ6EhyZ93+3LUUnR8/yhgB
 JqpzRQHtrpJruZTKuausdOXMSB1kZTjkxVVtkc2/xSNO8JShvmVRsh6lttlb9dJ+w4/t
 VODHpONicI62TfUUQUqX5oWXDoX1tPBbOcZu9PzH3YL/jZ+es5rpbQF6YKyjlAed1Wcp
 In6hOHVc0MeT/oDAA6oiT9oMfw1hg5GFUa7bJg0KvHwXfbxIqcItXOZdNSug6n4nXDug
 w3w8KY3KfvFXv1vKTw06X/ENrO9P4/xAR2r3AeJsMeuwySUGZ/Y1URGuH171DY3KQj4J
 50jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787432646; x=1788037446;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C4UpZeWfTiSJYpw1MLG2Esws2ocptFwER3yYU0370DM=;
 b=hK5S+0gd8Q3jeuG7QETuHUmYbRhgkYs/j0lsxMn3Cb9LoUZ+2tdDAEwGGyfufxyKIW
 tcoO5QFzD+Fh08XxjeLSpJQTZJYvQ39h3fCfh0iamcoOlxu34kpKztmHY4ZjzeN+bQUH
 OITVjBEHc1m2/P5hmYLqnistuFyucT7ISrmAm6kkcwXudmIEA1f+cXsuDWfzxTXyho4F
 ncd1qjl+6ML8LbcxLK29mco1QyqbmaB7XYuZ+IfniBs2uVv6r8rOfYc6iUDcSbsRuYGz
 K+BYRpAklacMCKLDxAmDq/b7/7+fj1N5bOrggAKIdyBMic1LavHLoXuXs5K7TJ2H/WeV
 OQ0Q==
X-Gm-Message-State: AFuF++kfzgPgdSext4GpWIIiFrhni34/TIVwxGgvnZdz19cUC6ivOGlh
 uKDp2fLVTRjM1AKn44grOse/LtAu7tJ9l8bgfoTSViU+xRHBbuaNgzHz
X-Gm-Gg: AR+sD10JtObLJY87WisvBj9oYIkB43Nx4txhdaGj//mqNB7kNhC9EFBfNEXPjcjanuf
 g9tMxPntpztuoAI1SSqmzqeF+x2kFVm6SkhQ7e0dxahXuw9RuDsOGdslCyGhbbOe7hfkDJTCPvD
 Dy2xY0laY/E9aahZ1G9sibNJn8hnSN9oWSVNWbQ/b1nh6mnrOfTYy4nOykCYlkINoRdUobkfTbn
 Ltlwg5EQDoy9MWdKv9RBTBj//0BivRPZ409AqBByanBK1YZPOSjYZxN+RFSwDzJNUnC30ZUXFty
 4zF8uUdywBEgfifdPB+qdcm/MPq5i8aSXMVkLcCS30m2AgudUIImSD68rLUcru1iwyfGNzEBpZg
 q/0tJvmRCge+QX++F0WC2WWmqK6ZJG1WCHanXWWIVFS3RHuEXrDCOacqWMZkQqg3PSG35rXUlm9
 +J4iWPI57N5co1iag5FYrsEBVRIYP4MDCMK/1XJpkie5/iKsMaqQ==
X-Received: by 2002:a17:907:c243:b0:c24:47b8:ae5b with SMTP id
 a640c23a62f3a-c246a68418emr1864820866b.22.1787432645495; 
 Sat, 22 Aug 2026 14:04:05 -0700 (PDT)
Received: from localhost ([2a02:8071:50c5:5c0::361b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24962bd8fasm671946866b.28.2026.08.22.14.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:04:04 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Bin
 Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Fabiano
 Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH v2 14/14] tests: add AM64x unit, qtest and
 functional tests
In-Reply-To: <87jypkpxnb.fsf@draig.linaro.org>
References: <20260820124824.618671-1-wafgo01@gmail.com>
 <20260820124824.618671-15-wafgo01@gmail.com>
 <87jypkpxnb.fsf@draig.linaro.org>
Date: Sat, 22 Aug 2026 23:04:04 +0200
Message-ID: <87tsolj29n.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=wafgo01@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-08-20 17:25, Alex Benn=C3=A9e wrote:

Hi Alex,

> Wadim Mueller <wafgo01@gmail.com> writes:
>
>> Cover the new code:
>>
>>  - tests/unit/test-k3-bootrom: combined boot image parser, including
>>    malformed input.
>>  - tests/qtest/am64-virt-test: machine topology, GICv3 redistributor
>>    layout, SMP handling, DMSC TI-SCI request/response handling.
>>  - tests/qtest/ti-am64-i2c-test: I2C soft reset, NACK on an absent
>>    address and a transfer against the on-SoM EEPROM.
>>  - tests/qtest/am64-adma-pacing-test: reproducer for the SDHCI ADMA
>>    pacing fix earlier in this series; without the fix it fails.
>>  - tests/functional/aarch64/test_am64_bootrom: builds a synthetic
>>    combined boot image with a bare-metal R5 payload and checks that the
>>    ROM boot path runs it. If QEMU_TEST_TIBOOT3 points at a real
>>    tiboot3.bin, that is booted as well.
>
> I commend you for including tests. One of the challenges of the myriad
> of board models we have is not having any way to know if they are used.
> It certainly helps if there are known images and tests to validate this.
>

Thanks a lot for looking at the series.

I agree, and this is the weakest part of my series at the moment. What
is there today:

  test_synthetic_image  runs in CI, but the tiboot3.bin is built by the
                        test itself, so it only proves the ROM parser
                        and that the R5 starts at the certified entry
  test_linux_gicv3      runs in CI, fetches a kernel with Asset(),
                        covers GICv3 and SMP bringup
  test_vendor_tiboot3   skipUnless(QEMU_TEST_TIBOOT3), so it never runs
                        in CI

So exactly the interesting path, R5 SPL -> TF-A/OP-TEE -> U-Boot ->
Linux, which is the reason why this model exists at all, is the one
which is hidden behind an environment variable. This is also the part
which would break silently, because nothing else exercises the DMSC
and the secure proxy in a realistic way.

I would prefer to make this a real Asset(url, sha256), so that CI boots
actual firmware. The firmware I test with is a vendor BSP build for the
board I have here (a phyCORE-AM64x SoM).

Before I do this, I would like to know your opinion: is a vendor BSP
artifact acceptable as an asset for a functional test, or do you need
something with better availability guarantees than a vendor download
area? The alternative would be that I build a minimal boot chain from
upstream U-Boot and TF-A and host it somewhere stable. This is more
reproducible, but then CI tests my own build and not a shipping image,
so I am not sure if this is really better.

>>
>> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
>> ---
>>  tests/functional/aarch64/meson.build          |   2 +
>>  tests/functional/aarch64/test_am64_bootrom.py | 137 +++++
>>  tests/qtest/am64-adma-pacing-test.c           | 243 +++++++++
>>  tests/qtest/am64-virt-test.c                  | 502 ++++++++++++++++++
>>  tests/qtest/meson.build                       |   1 +
>>  tests/qtest/ti-am64-i2c-test.c                | 137 +++++
>>  tests/unit/meson.build                        |   1 +
>>  tests/unit/test-k3-bootrom.c                  | 263 +++++++++
>
> That said I think splitting the unit, qtest and functional tests into
> separate commits would be worthwhile here.
>

Yes, that makes sense. I will split it in v3 like this:

  tests/unit:       test-k3-bootrom.c
  tests/qtest:      am64-virt-test.c, ti-am64-i2c-test.c
  tests/functional: test_am64_bootrom.py

The only one I would keep out of this is am64-adma-pacing-test.c. It
belongs to patch 3, because it is the reproducer for exactly that fix,
so both can be dropped together as soon as Bin's SDHCI series is
merged.

Best regards,
Wadim

>>  8 files changed, 1286 insertions(+)
>>  create mode 100644 tests/functional/aarch64/test_am64_bootrom.py
>>  create mode 100644 tests/qtest/am64-adma-pacing-test.c
>>  create mode 100644 tests/qtest/am64-virt-test.c
>>  create mode 100644 tests/qtest/ti-am64-i2c-test.c
>>  create mode 100644 tests/unit/test-k3-bootrom.c
>>
>> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aar=
ch64/meson.build
>> index e81afd6c39..6962ae1da1 100644
>> --- a/tests/functional/aarch64/meson.build
>> +++ b/tests/functional/aarch64/meson.build
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0-or-later
>>=20=20
>>  test_aarch64_timeouts =3D {
>> +  'am64_bootrom' : 300,
>>    'aspeed_ast2700a1' : 600,
>>    'aspeed_ast2700a2' : 600,
>>    'aspeed_ast2700fc' : 600,
>> @@ -26,6 +27,7 @@ tests_aarch64_system_quick =3D [
>>  ]
>>=20=20
>>  tests_aarch64_system_thorough =3D [
>> +  'am64_bootrom',
>>    'aspeed_ast2700a1',
>>    'aspeed_ast2700a2',
>>    'aspeed_ast2700fc',
>> diff --git a/tests/functional/aarch64/test_am64_bootrom.py b/tests/funct=
ional/aarch64/test_am64_bootrom.py
>> new file mode 100644
>> index 0000000000..2203ec7585
>> --- /dev/null
>> +++ b/tests/functional/aarch64/test_am64_bootrom.py
>> @@ -0,0 +1,137 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Boot-ROM emulation test for am64-virt machine: build a synthetic TI
>> +# combined boot image and check the R5 payload runs from the certified
>> +# entry.  Optionally boots a vendor tiboot3.bin via QEMU_TEST_TIBOOT3.
>> +#
>> +# Copyright (c) 2026 CMBLU Energy AG
>> +# Author: Wadim Mueller <wafgo01@gmail.com>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import os
>> +import struct
>> +
>> +from qemu_test import Asset, QemuSystemTest, wait_for_console_pattern
>> +from unittest import skipUnless
>> +
>> +# Checked-in DTB path; pc-bios/dtb/am64-virt.dtb does not get copied in=
to
>> +# the build directory.
>> +SOURCE_DIR =3D os.path.normpath(
>> +    os.path.join(os.path.dirname(__file__), '..', '..', '..'))
>> +
>> +
>> +def der(tag, payload):
>> +    n =3D len(payload)
>> +    if n < 0x80:
>> +        hdr =3D bytes([tag, n])
>> +    else:
>> +        hdr =3D bytes([tag, 0x82, n >> 8, n & 0xff])
>> +    return hdr + payload
>> +
>> +
>> +def der_int(v):
>> +    out =3D v.to_bytes((v.bit_length() + 7) // 8 or 1, 'big')
>> +    if out[0] & 0x80:
>> +        out =3D b'\x00' + out
>> +    return der(0x02, out)
>> +
>> +
>> +EXT_BOOT_OID =3D bytes.fromhex('06092b0601040182260109')
>> +SHA512_OID =3D bytes.fromhex('0609608648016503040203')
>> +
>> +
>> +def component(ctype, core, opts, dest, size):
>> +    return der(0x30,
>> +               der_int(ctype) + der_int(core) + der_int(opts) +
>> +               der(0x04, dest.to_bytes(4, 'big')) + der_int(size) +
>> +               SHA512_OID + der(0x04, bytes(64)))
>> +
>> +
>> +# Bare-metal A32 stub, linked at 0x70000000: prints a magic string on
>> +# main UART0 (0x02800000, 16550 THR at offset 0), then parks.
>> +SBL_STUB =3D struct.pack(
>> +    '<10I',
>> +    0xe59f001c,  # ldr r0, [pc, #0x1c]   ; r0 =3D 0x02800000
>> +    0xe28f101c,  # add r1, pc, #0x1c     ; r1 =3D msg
>> +    0xe4d12001,  # loop: ldrb r2, [r1], #1
>> +    0xe3520000,  # cmp r2, #0
>> +    0x0a000001,  # beq hang
>> +    0xe5802000,  # str r2, [r0]
>> +    0xeafffffa,  # b loop
>> +    0xeafffffe,  # hang: b hang
>> +    0x00000000,  # (pad)
>> +    0x02800000,  # UART0 literal
>> +) + b'K3BOOTROM-OK\r\n\x00'
>> +
>> +
>> +def make_tiboot3():
>> +    sbl =3D SBL_STUB
>> +    sysfw =3D b'FAKE-SYSFW-PAYLOAD'
>> +    cfg =3D b'FAKE-CFG'
>> +    info =3D der(0x30,
>> +               der_int(len(sbl) + len(sysfw) + len(cfg)) + der_int(3) +
>> +               component(1, 16, 0, 0x70000000, len(sbl)) +
>> +               component(2, 0, 0, 0x44000, len(sysfw)) +
>> +               component(18, 0, 0, 0x7b000, len(cfg)))
>> +    ext =3D der(0x30, EXT_BOOT_OID + der(0x04, info))
>> +    cert =3D der(0x30, ext)
>> +    return cert + sbl + sysfw + cfg
>> +
>> +
>> +class Am64BootRom(QemuSystemTest):
>> +
>> +    # The gated Linux boot subtest can need about 90 s under TCG on a
>> +    # development host. 300 s leaves room for slower CI machines.
>> +    timeout =3D 300
>> +
>> +    def boot_bios(self, path):
>> +        self.set_machine('am64-virt')
>> +        self.vm.set_console()
>> +        self.vm.add_args('-bios', path)
>> +        self.vm.launch()
>> +
>> +    def test_synthetic_image(self):
>> +        path =3D os.path.join(self.workdir, 'tiboot3-synth.bin')
>> +        with open(path, 'wb') as f:
>> +            f.write(make_tiboot3())
>> +        self.boot_bios(path)
>> +        wait_for_console_pattern(self, 'K3BOOTROM-OK')
>> +
>> +    @skipUnless(os.getenv('QEMU_TEST_TIBOOT3'),
>> +                'set QEMU_TEST_TIBOOT3=3D<path to tiboot3.bin>')
>
> Are there any publicly available images we could boot on this board? I'm
> sure for you QEMU_TEST_TIBOOT3 works well - but having a public known
> good image means other devs can check things haven't broken on a refactor.
>

>> +    def test_vendor_tiboot3(self):
>> +        self.boot_bios(os.getenv('QEMU_TEST_TIBOOT3'))
>> +        # The SYSFW ABI line also proves boot notification plus TISCI
>> +        # VERSION before execution reaches the unmodelled DDR init.
>> +        wait_for_console_pattern(self, 'U-Boot SPL')
>> +        wait_for_console_pattern(self, 'SYSFW ABI:')
>> +
>> +    # Standalone arm64 netboot kernel.  It has PL011 and GICv3 drivers =
but
>> +    # no initramfs, so expected rootfs panic comes after the milestones,
>> +    # which this test cares about.
>> +    ASSET_KERNEL =3D Asset(
>> +        ('http://ports.ubuntu.com/ubuntu-ports/dists/bionic-updates/mai=
n/'
>> +         'installer-arm64/20101020ubuntu543.19/images/netboot/'
>> +         'ubuntu-installer/arm64/linux'),
>> +        'ce54f74ab0b15cfd13d1a293f2d27ffd79d8a85b7bb9bf21093ae9513864ac=
79')
>> +
>> +    def test_linux_gicv3(self):
>> +        kernel_path =3D self.ASSET_KERNEL.fetch()
>> +        dtb =3D os.path.join(SOURCE_DIR, 'pc-bios', 'dtb', 'am64-virt.d=
tb')
>> +        self.set_machine('am64-virt')
>> +        self.vm.set_console()
>> +        self.vm.add_args('-kernel', kernel_path,
>> +                         '-dtb', dtb,
>> +                         '-append', 'console=3DttyAMA0 earlycon')
>> +        self.vm.launch()
>> +        wait_for_console_pattern(
>> +            self,
>> +            'GICv3: CPU0: found redistributor 0 region '
>> +            '0:0x0000000001840000')
>> +        wait_for_console_pattern(self, 'CPU1: Booted secondary processo=
r')
>> +        wait_for_console_pattern(self, 'ttyAMA0')
>> +
>> +
>> +if __name__ =3D=3D '__main__':
>> +    QemuSystemTest.main()
>> diff --git a/tests/qtest/am64-adma-pacing-test.c b/tests/qtest/am64-adma=
-pacing-test.c
>> new file mode 100644
>> index 0000000000..7b503d86ed
>> --- /dev/null
>> +++ b/tests/qtest/am64-adma-pacing-test.c
>> @@ -0,0 +1,243 @@
>> +/*
>> + * QTest for AM64x SDHCI ADMA2 virtual-clock pacing
>> + *
>> + * CMD18 over a 12-descriptor ADMA2 chain has to complete synchronously
>> + * when no DMA-boundary interrupt is requested.  A sliced transfer needs
>> + * at least one SDHC_TRANSFER_DELAY virtual-clock step.
>> + *
>> + * Copyright (c) 2026 CMBLU Energy AG
>> + * Author: Wadim Mueller <wafgo01@gmail.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +
>> +/*
>> + * Keep the small SDHCI subset local; sdhci-internal.h is not usable fr=
om
>> + * qtests, since it exposes SDHCIState internals.
>> + */
>> +#define SDHC_ARGUMENT              0x08
>> +#define SDHC_TRNMOD                0x0C
>> +#define SDHC_TRNS_DMA              0x0001
>> +#define SDHC_TRNS_BLK_CNT_EN       0x0002
>> +#define SDHC_TRNS_READ             0x0010
>> +#define SDHC_TRNS_MULTI            0x0020
>> +#define SDHC_CMDREG                0x0E
>> +#define SDHC_CMD_DATA_PRESENT      (1 << 5)
>> +#define SDHC_RSPREG0               0x10
>> +#define SDHC_PRNSTS                0x24
>> +#define SDHC_CARD_PRESENT          0x00010000
>> +#define SDHC_HOSTCTL               0x28
>> +#define SDHC_CTRL_ADMA2_32         0x10
>> +#define SDHC_BLKSIZE               0x04
>> +#define SDHC_CLKCON                0x2C
>> +#define SDHC_CLOCK_INT_EN          0x0001
>> +#define SDHC_CLOCK_SDCLK_EN        (1 << 2)
>> +#define SDHC_SWRST                 0x2F
>> +#define SDHC_RESET_ALL             0x01
>> +#define SDHC_NORINTSTS             0x30
>> +#define SDHC_NIS_ERR               0x8000
>> +#define SDHC_NIS_CMDCMP            0x0001
>> +#define SDHC_NIS_TRSCMP            0x0002
>> +#define SDHC_NORINTSTSEN           0x34
>> +#define SDHC_ERRINTSTSEN           0x36
>> +#define SDHC_ADMASYSADDR           0x58
>> +#define SDHC_ADMA_ATTR_ACT_TRAN    (1 << 5)
>> +#define SDHC_ADMA_ATTR_END         (1 << 1)
>> +#define SDHC_ADMA_ATTR_VALID       (1 << 0)
>> +#define SDHC_TRANSFER_DELAY        100
>> +/* NDESC stays above SDHC_ADMA_DESCS_PER_DELAY (5). */
>> +
>> +/*
>> + * Probe both AM64x SDHCI instances.  The first free sd-bus gets the
>> + * test card, so the base with CARD_PRESENT depends from realize order.
>> + */
>> +#define SDHCI_SD_BASE     0x0fa00000ULL
>> +#define SDHCI_EMMC_BASE   0x0fa10000ULL
>> +
>> +/* Scratch DDR: ADMA descriptor table plus target buffer. */
>> +#define ADMA_TABLE_ADDR   0x82000000ULL
>> +#define ADMA_BUF_ADDR     0x82100000ULL
>> +
>> +#define BLK_LEN           512
>> +#define NDESC             12      /* > SDHC_ADMA_DESCS_PER_DELAY (5) */
>> +
>> +/* SDHCI command-register response-type encodings (CMDREG bits [1:0]). =
*/
>> +#define RESP_NONE         0x0000
>> +#define RESP_R2           0x0001  /* 136-bit (CID/CSD) */
>> +#define RESP_R48          0x0002  /* 48-bit  (R1/R3/R6/R7) */
>> +#define RESP_R1B          0x0003  /* 48-bit with busy (R1b) */
>> +
>> +/* ACMD41 argument: HCS (bit30) + a 3.3-3.6V voltage window (non-enquir=
y). */
>> +#define ACMD41_ARG        0x40FF8000u
>> +/* CMD8 argument: VHS =3D 2.7-3.6V + recommended check pattern 0xAA. */
>> +#define CMD8_ARG          0x000001AAu
>> +
>> +/* Bounded command-complete poll; returns actual latched NORINTSTS. */
>> +static uint16_t sd_cmd(QTestState *qts, uint64_t base, uint8_t cmd,
>> +                       uint32_t arg, uint16_t flags)
>> +{
>> +    uint16_t sts =3D 0;
>> +    int i;
>> +
>> +    qtest_writel(qts, base + SDHC_ARGUMENT, arg);
>> +    qtest_writew(qts, base + SDHC_CMDREG, ((uint16_t)cmd << 8) | flags);
>> +
>> +    /* CMDREG write runs synchronously sdhci_send_command(). */
>> +    for (i =3D 0; i < 1000; i++) {
>> +        sts =3D qtest_readw(qts, base + SDHC_NORINTSTS);
>> +        if (sts & SDHC_NIS_CMDCMP) {
>> +            break;
>> +        }
>> +    }
>> +    g_assert_cmphex(sts & SDHC_NIS_CMDCMP, =3D=3D, SDHC_NIS_CMDCMP);
>> +
>> +    /* Clear all latched normal-interrupt status bits (write-1-to-clear=
). */
>> +    qtest_writew(qts, base + SDHC_NORINTSTS, 0xffff);
>> +    return sts;
>> +}
>> +
>> +/* Return the controller base whose PRNSTS reports a card inserted. */
>> +static uint64_t find_card_base(QTestState *qts)
>> +{
>> +    uint32_t sd_sts =3D qtest_readl(qts, SDHCI_SD_BASE + SDHC_PRNSTS);
>> +    uint32_t emmc_sts =3D qtest_readl(qts, SDHCI_EMMC_BASE + SDHC_PRNST=
S);
>> +
>> +    if (sd_sts & SDHC_CARD_PRESENT) {
>> +        return SDHCI_SD_BASE;
>> +    }
>> +    if (emmc_sts & SDHC_CARD_PRESENT) {
>> +        return SDHCI_EMMC_BASE;
>> +    }
>> +    g_assert_not_reached();
>> +}
>> +
>> +/* Bring SD card to transfer state. */
>> +static void sd_bring_up_card(QTestState *qts, uint64_t base)
>> +{
>> +    uint32_t rca;
>> +
>> +    /* Host reset, clock on (INT_EN sets INT_STABLE), latch all status.=
 */
>> +    qtest_writeb(qts, base + SDHC_SWRST, SDHC_RESET_ALL);
>> +    qtest_writew(qts, base + SDHC_CLKCON,
>> +                 SDHC_CLOCK_INT_EN | SDHC_CLOCK_SDCLK_EN);
>> +    qtest_writew(qts, base + SDHC_NORINTSTSEN, 0xffff);
>> +    qtest_writew(qts, base + SDHC_ERRINTSTSEN, 0xffff);
>> +
>> +    sd_cmd(qts, base, 0,  0x00000000, RESP_NONE);  /* CMD0  GO_IDLE_STA=
TE   */
>> +    sd_cmd(qts, base, 8,  CMD8_ARG,   RESP_R48);    /* CMD8  SEND_IF_CO=
ND    */
>> +
>> +    /* ACMD41: CMD55 (APP_CMD) then CMD41 (SEND_OP_COND), until powered=
 up. */
>> +    for (int i =3D 0; i < 100; i++) {
>> +        sd_cmd(qts, base, 55, 0x00000000, RESP_R48);
>> +        sd_cmd(qts, base, 41, ACMD41_ARG, RESP_R48);
>> +        /* Non-enquiry ACMD41 powers up the model; the loop is a guard.=
 */
>> +        break;
>> +    }
>> +
>> +    sd_cmd(qts, base, 2, 0x00000000, RESP_R2);     /* CMD2  ALL_SEND_CI=
D    */
>> +    sd_cmd(qts, base, 3, 0x00000000, RESP_R48);    /* CMD3  SEND_RELATI=
VE   */
>> +
>> +    /* R6 packs the assigned RCA in the upper 16 bits of RSPREG0. */
>> +    rca =3D qtest_readl(qts, base + SDHC_RSPREG0) >> 16;
>> +
>> +    sd_cmd(qts, base, 7, rca << 16, RESP_R1B);     /* CMD7  SELECT_CARD=
     */
>> +    sd_cmd(qts, base, 16, BLK_LEN,  RESP_R48);     /* CMD16 SET_BLOCKLE=
N    */
>> +}
>> +
>> +/*
>> + * 32-bit ADMA2 entries are little-endian 64-bit words: attr in bits
>> + * [6:0], length in [31:16], address in [63:32].  No INT bit is set,
>> + * so we expect the whole chain in one call.
>> + */
>> +static void build_adma_table(QTestState *qts)
>> +{
>> +    for (int i =3D 0; i < NDESC; i++) {
>> +        uint8_t attr =3D SDHC_ADMA_ATTR_VALID | SDHC_ADMA_ATTR_ACT_TRAN;
>> +        uint32_t addr =3D (uint32_t)(ADMA_BUF_ADDR + (uint64_t)i * BLK_=
LEN);
>> +
>> +        if (i =3D=3D NDESC - 1) {
>> +            attr |=3D SDHC_ADMA_ATTR_END;
>> +        }
>> +        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8,
>> +                     ((uint32_t)BLK_LEN << 16) | attr);
>> +        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8 + 4, addr);
>> +    }
>> +}
>> +
>> +static void test_adma_pacing(void)
>> +{
>> +    char *tmp =3D NULL;
>> +    int fd;
>> +    GError *err =3D NULL;
>> +    uint64_t base;
>> +    QTestState *qts;
>> +    uint16_t sts;
>> +    int steps =3D 0;
>> +
>> +    /* 1 MiB raw backing file, filled with zero. */
>> +    fd =3D g_file_open_tmp("am64-adma-XXXXXX.raw", &tmp, &err);
>> +    g_assert_no_error(err);
>> +    g_assert_cmpint(fd, >=3D, 0);
>> +    g_assert_cmpint(ftruncate(fd, 1 * 1024 * 1024), =3D=3D, 0);
>> +    close(fd);
>> +
>> +    qts =3D qtest_initf("-machine am64-virt -accel qtest -display none "
>> +                      "-drive if=3Dnone,id=3Dsd0,file=3D%s,format=3Draw=
 "
>> +                      "-device sd-card,drive=3Dsd0", tmp);
>> +
>> +    base =3D find_card_base(qts);
>> +    sd_bring_up_card(qts, base);
>> +
>> +    /* Select ADMA2 32-bit as DMA engine (Host Control 1 bits [4:3]). */
>> +    qtest_writeb(qts, base + SDHC_HOSTCTL, SDHC_CTRL_ADMA2_32);
>> +
>> +    build_adma_table(qts);
>> +
>> +    /* Program descriptor/geometry and clear old status. */
>> +    qtest_writel(qts, base + SDHC_ADMASYSADDR, (uint32_t)ADMA_TABLE_ADD=
R);
>> +    qtest_writel(qts, base + SDHC_ADMASYSADDR + 4,
>> +                 (uint32_t)(ADMA_TABLE_ADDR >> 32));
>> +    qtest_writel(qts, base + SDHC_BLKSIZE, BLK_LEN | (NDESC << 16));
>> +    qtest_writew(qts, base + SDHC_TRNMOD,
>> +                 SDHC_TRNS_DMA | SDHC_TRNS_BLK_CNT_EN |
>> +                 SDHC_TRNS_READ | SDHC_TRNS_MULTI);
>> +    qtest_writel(qts, base + SDHC_ARGUMENT, 0);  /* start block 0 */
>> +    qtest_writew(qts, base + SDHC_NORINTSTS, 0xffff);
>> +
>> +    /* CMD18 READ_MULTIPLE_BLOCK kicks off ADMA. */
>> +    qtest_writew(qts, base + SDHC_CMDREG,
>> +                 (18 << 8) | SDHC_CMD_DATA_PRESENT | RESP_R48);
>> +
>> +    /*
>> +     * Transfer Complete has to be already set.  A batched 12-descriptor
>> +     * chain needs at least one SDHC_TRANSFER_DELAY step.
>> +     */
>> +    while (!((sts =3D qtest_readw(qts, base + SDHC_NORINTSTS)) &
>> +             SDHC_NIS_TRSCMP)) {
>> +        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
>> +        steps++;
>> +        g_assert_cmpint(steps, <, 1000);
>> +    }
>> +
>> +    /* Completion has to be Transfer Complete with no error interrupt. =
*/
>> +    g_assert_cmphex(sts & SDHC_NIS_TRSCMP, =3D=3D, SDHC_NIS_TRSCMP);
>> +    g_assert_cmphex(sts & SDHC_NIS_ERR, =3D=3D, 0);
>> +
>> +    g_test_message("ADMA %d descriptors: %d clock steps", NDESC, steps);
>> +
>> +    /* The fixed path completes whole chain in one pass: no clock steps=
. */
>> +    g_assert_cmpint(steps, =3D=3D, 0);
>> +
>> +    qtest_quit(qts);
>> +    unlink(tmp);
>> +    g_free(tmp);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +    qtest_add_func("/am64/sdhci/adma-pacing", test_adma_pacing);
>> +    return g_test_run();
>> +}
>> diff --git a/tests/qtest/am64-virt-test.c b/tests/qtest/am64-virt-test.c
>> new file mode 100644
>> index 0000000000..c0a9a26275
>> --- /dev/null
>> +++ b/tests/qtest/am64-virt-test.c
>> @@ -0,0 +1,502 @@
>> +/*
>> + * QTests for AM64 virt machine
>> + *
>> + * Copyright (c) 2026 CMBLU Energy AG
>> + * Author: Wadim Mueller <wafgo01@gmail.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "qobject/qdict.h"
>> +#include "qobject/qlist.h"
>> +
>> +#define OCSRAM_BASE 0x70000000ULL
>> +#define OCSRAM_SIZE (2 * 1024 * 1024)
>> +#define MAIN_UART0_BASE 0x02800000ULL
>> +
>> +static void test_ocsram_rw(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    qtest_writel(qts, OCSRAM_BASE, 0xdeadbeef);
>> +    g_assert_cmphex(qtest_readl(qts, OCSRAM_BASE), =3D=3D, 0xdeadbeef);
>> +    qtest_writel(qts, OCSRAM_BASE + OCSRAM_SIZE - 4, 0x12345678);
>> +    g_assert_cmphex(qtest_readl(qts, OCSRAM_BASE + OCSRAM_SIZE - 4), =
=3D=3D,
>> +                    0x12345678);
>> +    /* Boot parameters must stay in OCSRAM. */
>> +    qtest_writel(qts, 0x701bebfc, 0x0);
>> +    g_assert_cmphex(qtest_readl(qts, 0x701bebfc), =3D=3D, 0x0);
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_main_uart0_present(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    /* Idle 16550: transmitter empty bits are set. */
>> +    g_assert_cmphex(qtest_readl(qts, MAIN_UART0_BASE + (5 << 2)) & 0x60,
>> +                    =3D=3D, 0x60);
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_r5f_cpu_present(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +    QDict *resp =3D qtest_qmp(qts, "{'execute': 'query-cpus-fast'}");
>> +    QList *cpus =3D qdict_get_qlist(resp, "return");
>> +
>> +    /* 2x A53 + 1x M4 + 1x R5F */
>> +    g_assert_cmpint(qlist_size(cpus), =3D=3D, 4);
>> +    qobject_unref(resp);
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_devstat(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    /* CTRLMMR_MAIN_DEVSTAT: primary bootmode =3D eMMC (0x9 << 3). */
>> +    g_assert_cmphex(qtest_readl(qts, 0x43000030), =3D=3D, 0x48);
>> +    /* mmr_unlock() kick writes have to be accepted. */
>> +    qtest_writel(qts, 0x43008008, 0x68ef3490);
>> +    qtest_writel(qts, 0x4300800c, 0xd172bc5a);
>> +    qtest_quit(qts);
>> +}
>> +
>> +#define DDRSS_CFG_BASE    0x0f308000ULL
>> +#define SP_TARGET(thread) (0x4D000000ULL + (thread) * 0x1000)
>> +#define SP_RT(thread)     (0x4A600000ULL + (thread) * 0x1000)
>> +
>> +static void test_dmsc_r5_version(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +    /*
>> +     * R5 secure-host TISCI VERSION request.  The zero secure prefix
>> +     * has to be skipped before parsing the TISCI header.
>> +     */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x04, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x08, 0x0a230002);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x0c, 0x00000002);
>> +    /* Commit with the last data word. */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x3c, 0x00000000);
>> +
>> +    /* Response has to land on RX thread 0. */
>> +    for (int i =3D 0; i < 100; i++) {
>> +        if (qtest_readl(qts, SP_RT(0)) & 0xff) {
>> +            break;
>> +        }
>> +        g_usleep(10 * 1000);
>> +    }
>> +    g_assert_cmpuint(qtest_readl(qts, SP_RT(0)) & 0xff, >, 0);
>> +
>> +    /* Secure prefix, echoed VERSION type, ACK bit is set. */
>> +    g_assert_cmphex(qtest_readl(qts, SP_TARGET(0) + 0x08) & 0xffff,
>> +                    =3D=3D, 0x0002);
>> +    g_assert_cmphex(qtest_readl(qts, SP_TARGET(0) + 0x0c) & 0x2, =3D=3D=
, 0x2);
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_dmsc_r5_get_freq(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    /*
>> +     * R5 secure-host GET_FREQ (0x010e) for MMCSD0 clock 1.  This
>> +     * controls packed request layout and nonzero frequency response.
>> +     */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x04, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x08, 0x0a23010e);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x0c, 0x00000002);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x10, 57);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x14, 1);
>> +    /* commit by writing the last data word */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x3c, 0x00000000);
>> +
>> +    /* response has to land on RX thread 0 (message count > 0) */
>> +    for (int i =3D 0; i < 100; i++) {
>> +        if (qtest_readl(qts, SP_RT(0)) & 0xff) {
>> +            break;
>> +        }
>> +        g_usleep(10 * 1000);
>> +    }
>> +    g_assert_cmpuint(qtest_readl(qts, SP_RT(0)) & 0xff, >, 0);
>> +
>> +    /* Secure prefix, echoed GET_FREQ type, ACK bit is set. */
>> +    g_assert_cmphex(qtest_readl(qts, SP_TARGET(0) + 0x08) & 0xffff,
>> +                    =3D=3D, 0x010e);
>> +    g_assert_cmphex(qtest_readl(qts, SP_TARGET(0) + 0x0c) & 0x2, =3D=3D=
, 0x2);
>> +    /* freq_hz follows the 8-byte TISCI header and has to be nonzero. */
>> +    g_assert_cmpuint(qtest_readl(qts, SP_TARGET(0) + 0x10), !=3D, 0);
>> +    qtest_quit(qts);
>> +}
>> +
>> +/*
>> + * Requests without TISCI_MSG_FLAG_AOP must get no reply.  Else a stale
>> + * message in the single-slot RX thread breaks later request/response
>> + * pairing, so keep RX count at zero for both no-response messages.
>> + */
>> +static void test_dmsc_r5_no_response_flag(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    /*
>> +     * Drain the reset-time boot notification.  Reading register 15 cle=
ars
>> +     * the inbound thread message count again.
>> +     */
>> +    if (qtest_readl(qts, SP_RT(0)) & 0xff) {
>> +        qtest_readl(qts, SP_TARGET(0) + 0x3c);
>> +    }
>> +
>> +    /* WAIT_PROC_BOOT_STATUS (0xc401), hdr.flags =3D 0: no response. */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x04, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x08, 0x0a23c401);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x0c, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x3c, 0x00000000);
>> +    g_usleep(50 * 1000);
>> +    g_assert_cmphex(qtest_readl(qts, SP_RT(0)) & 0xff, =3D=3D, 0);
>> +
>> +    /* SET_DEVICE (0x0200), hdr.flags =3D 0: no response. */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x04, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x08, 0x0a230200);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x0c, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x10, 121);   /* device id */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x14, 0);     /* state off */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x3c, 0x00000000);
>> +    g_usleep(50 * 1000);
>> +    g_assert_cmphex(qtest_readl(qts, SP_RT(0)) & 0xff, =3D=3D, 0);
>> +
>> +    /* AOP messages still get a response. */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x04, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x08, 0x0a230002);   /* VERSION */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x0c, 0x00000002);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x3c, 0x00000000);
>> +    for (int i =3D 0; i < 100; i++) {
>> +        if (qtest_readl(qts, SP_RT(0)) & 0xff) {
>> +            break;
>> +        }
>> +        g_usleep(10 * 1000);
>> +    }
>> +    g_assert_cmphex(qtest_readl(qts, SP_RT(0)) & 0xff, >, 0);
>> +    qtest_quit(qts);
>> +}
>> +
>> +/*
>> + * TISCI_MSG_SYS_RESET (0x0005) is a no-response request, but it still
>> + * triggers a full machine reset.
>> + */
>> +static void test_dmsc_r5_sys_reset(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    /* Drain the reset-time boot notification. */
>> +    if (qtest_readl(qts, SP_RT(0)) & 0xff) {
>> +        qtest_readl(qts, SP_TARGET(0) + 0x3c);
>> +    }
>> +
>> +    /* SYS_RESET from host 35, with secure prefix and hdr.flags =3D 0. =
*/
>> +    qtest_writel(qts, SP_TARGET(1) + 0x04, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x08, 0x0a230005);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x0c, 0x00000000);
>> +    /* commit: write the last data word */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x3c, 0x00000000);
>> +
>> +    /* The DMSC reset request appears as QEMU RESET event. */
>> +    qtest_qmp_eventwait(qts, "RESET");
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_dmtimer_counts(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +    uint32_t t0, t1;
>> +
>> +    /* TCLR.ST is safe also when the model free-runs. */
>> +    qtest_writel(qts, 0x02400038, 1);
>> +    t0 =3D qtest_readl(qts, 0x0240003c);
>> +    qtest_clock_step(qts, 1000000); /* +1 ms */
>> +    t1 =3D qtest_readl(qts, 0x0240003c);
>> +    /* 20 MHz -> 1 ms =3D 20000 ticks */
>> +    g_assert_cmpuint(t1 - t0, =3D=3D, 20000);
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_dmtimer_prescaler(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +    uint32_t t0, t1;
>> +
>> +    /*
>> +     * PTV=3D2 with PRE_EN gives 20 MHz / (2 << 2), i.e. 1 ms is
>> +     * 2500 ticks.
>> +     */
>> +    qtest_writel(qts, 0x02400038, 0x2b);
>> +    t0 =3D qtest_readl(qts, 0x0240003c);
>> +    qtest_clock_step(qts, 1000000); /* +1 ms virtual time */
>> +    t1 =3D qtest_readl(qts, 0x0240003c);
>> +    g_assert_cmpuint(t1 - t0, =3D=3D, 2500);
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_dmtimer_reconfigure(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +    uint32_t t0, t1;
>> +
>> +    /*
>> +     * Changing the prescaler while the timer runs must only affect time
>> +     * after the TCLR write, never rescale already-elapsed ticks.
>> +     */
>> +    qtest_writel(qts, 0x02400038, 1);           /* ST, no prescaler */
>> +    t0 =3D qtest_readl(qts, 0x0240003c);
>> +    qtest_clock_step(qts, 1000000);             /* +1 ms @ 20 MHz  */
>> +    qtest_writel(qts, 0x02400038, 0x2b);        /* PTV=3D2, PRE_EN, AR,=
 ST */
>> +    qtest_clock_step(qts, 1000000);             /* +1 ms @ 2.5 MHz */
>> +    t1 =3D qtest_readl(qts, 0x0240003c);
>> +    g_assert_cmpuint(t1 - t0, =3D=3D, 20000 + 2500);
>> +    qtest_quit(qts);
>> +}
>> +
>> +#define GICD_BASE 0x01800000ULL
>> +#define GICR_BASE 0x01840000ULL
>> +#define GIC_PIDR2 0xffe8
>> +
>> +static void test_gicv3_present(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    /* GICD_PIDR2.ArchRev must report a GICv3 distributor. */
>> +    g_assert_cmphex((qtest_readl(qts, GICD_BASE + GIC_PIDR2) >> 4) & 0x=
f,
>> +                    =3D=3D, 3);
>> +    /* first redistributor frame at actual AM64x GICR base */
>> +    g_assert_cmphex((qtest_readl(qts, GICR_BASE + GIC_PIDR2) >> 4) & 0x=
f,
>> +                    =3D=3D, 3);
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_ddrss_stub(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    /* DENALI_CTL_0 writes must persist, including dram_class DDR4. */
>> +    qtest_writel(qts, DDRSS_CFG_BASE + 0x0, 0x00000A00);
>> +    g_assert_cmphex(qtest_readl(qts, DDRSS_CFG_BASE + 0x0), =3D=3D, 0x0=
0000A00);
>> +
>> +    /* Done bits are ORed into status reads, also after writes. */
>> +    qtest_writel(qts, DDRSS_CFG_BASE + 0x214C, 0x0);
>> +    g_assert_cmphex(qtest_readl(qts, DDRSS_CFG_BASE + 0x214C) & 0x1, =
=3D=3D, 0x1);
>> +    qtest_writel(qts, DDRSS_CFG_BASE + 0x538, 0x0);
>> +    g_assert_cmphex(qtest_readl(qts, DDRSS_CFG_BASE + 0x538) & (1u << 1=
3),
>> +                    =3D=3D, 1u << 13);
>> +    qtest_writel(qts, DDRSS_CFG_BASE + 0x558, 0x0);
>> +    g_assert_cmphex(qtest_readl(qts, DDRSS_CFG_BASE + 0x558) & (1u << 2=
5),
>> +                    =3D=3D, 1u << 25);
>> +
>> +    /*
>> +     * ECC priming needs both BIST_DONE latches: INT_STATUS_MASTER bit 8
>> +     * and INT_STATUS_BIST bit 0, resp. CTL_341 raw bit 16.
>> +     */
>> +    qtest_writel(qts, DDRSS_CFG_BASE + 0x538, 0x0);
>> +    g_assert_cmphex(qtest_readl(qts, DDRSS_CFG_BASE + 0x538) & (1u << 8=
),
>> +                    =3D=3D, 1u << 8);
>> +    qtest_writel(qts, DDRSS_CFG_BASE + 0x554, 0x0);
>> +    g_assert_cmphex(qtest_readl(qts, DDRSS_CFG_BASE + 0x554) & (1u << 1=
6),
>> +                    =3D=3D, 1u << 16);
>> +    qtest_quit(qts);
>> +}
>> +
>> +/*
>> + * SET_CONFIG (0xc100) records the A53 bootvector, and PROC_GET_STATUS
>> + * (0xc400) must echo it.  The packed payload has processor_id at byte 0
>> + * and bootvector_low at bytes 1..4, so 0x701c0000 is written as
>> + * 0x1c000020 / 0x00000070.
>> + */
>> +static void test_dmsc_r5_bootvector_capture(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +    uint32_t reg4, reg5, bootvector_lo;
>> +
>> +    /* drain boot notification pre-queued on thread 0 at reset */
>> +    if (qtest_readl(qts, SP_RT(0)) & 0xff) {
>> +        qtest_readl(qts, SP_TARGET(0) + 0x3c);
>> +    }
>> +
>> +    qtest_writel(qts, SP_TARGET(1) + 0x04, 0x00000000);      /* sec hdr=
 */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x08, 0x0a23c100);      /* hdr */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x0c, 0x00000002);      /* AOP */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x10, 0x1c000020);      /* id+bv */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x14, 0x00000070);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x18, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x1c, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x3c, 0x00000000);
>> +    for (int i =3D 0; i < 100 && !(qtest_readl(qts, SP_RT(0)) & 0xff); =
i++) {
>> +        g_usleep(10 * 1000);
>> +    }
>> +    g_assert_cmphex(qtest_readl(qts, SP_TARGET(0) + 0x0c) & 0x2, =3D=3D=
, 0x2);
>> +    qtest_readl(qts, SP_TARGET(0) + 0x3c);                    /* drain =
*/
>> +
>> +    /* PROC_GET_STATUS (0xc400), proc 32: bootvector_low has to echo. */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x04, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x08, 0x0a23c400);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x0c, 0x00000002);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x10, 32);               /* proc_i=
d */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x3c, 0x00000000);
>> +    for (int i =3D 0; i < 100 && !(qtest_readl(qts, SP_RT(0)) & 0xff); =
i++) {
>> +        g_usleep(10 * 1000);
>> +    }
>> +
>> +    /*
>> +     * Secure responses carry a zero prefix at +0x04.  processor_id is
>> +     * response byte 8, so bootvector_lo starts one byte into register 4
>> +     * and has to be rebuilt from registers 4 and 5.
>> +     */
>> +    reg4 =3D qtest_readl(qts, SP_TARGET(0) + 0x10);
>> +    reg5 =3D qtest_readl(qts, SP_TARGET(0) + 0x14);
>> +    bootvector_lo =3D (reg4 >> 8) | ((reg5 & 0xff) << 24);
>> +    g_assert_cmphex(bootvector_lo, =3D=3D, 0x701c0000);
>> +    qtest_quit(qts);
>> +}
>> +
>> +#define SDHCI_SD_BASE   0x0fa00000ULL
>> +#define SDHCI_EMMC_BASE 0x0fa10000ULL
>> +
>> +static void test_sdhci_present(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    /*
>> +     * CAPAB bit 28 advertises 64-bit system-bus support, which is need=
ed
>> +     * for A53 SPL ADMA2-64 transfers.
>> +     */
>> +    g_assert_cmphex(qtest_readl(qts, SDHCI_SD_BASE + 0x40), =3D=3D, 0x1=
57c34b4);
>> +    g_assert_cmphex(qtest_readl(qts, SDHCI_EMMC_BASE + 0x40), =3D=3D, 0=
x157c34b4);
>> +    /* Host controller version (0xFE): SDHCI spec 3.00. */
>> +    g_assert_cmphex(qtest_readw(qts, SDHCI_SD_BASE + 0xFE) & 0xff, =3D=
=3D, 2);
>> +    /* PHY window: PHY_STAT1 reads CALDONE|DLLRDY */
>> +    g_assert_cmphex(qtest_readl(qts, 0x0fa08000ULL + 0x130) & 0x3, =3D=
=3D, 0x3);
>> +    g_assert_cmphex(qtest_readl(qts, 0x0fa18000ULL + 0x130) & 0x3, =3D=
=3D, 0x3);
>> +    qtest_quit(qts);
>> +}
>> +
>> +#define TRNG_BASE 0x40910000ULL
>> +
>> +static void test_trng_stub(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    /* readiness bit is permanently set */
>> +    g_assert_cmphex(qtest_readl(qts, TRNG_BASE + 0x10) & 0x1, =3D=3D, 0=
x1);
>> +    /* Output words must be nonzero and change between reads. */
>> +    uint32_t a =3D qtest_readl(qts, TRNG_BASE + 0x00);
>> +    uint32_t b =3D qtest_readl(qts, TRNG_BASE + 0x00);
>> +
>> +    g_assert_cmpuint(a, !=3D, 0);
>> +    g_assert_true(a !=3D b || qtest_readl(qts, TRNG_BASE + 0x04) !=3D a=
);
>> +    /* INTACK writes are accepted. */
>> +    qtest_writel(qts, TRNG_BASE + 0x10, 0x1);
>> +    /* CONTROL is RAM-backed: read back actual written value */
>> +    qtest_writel(qts, TRNG_BASE + 0x14, 0x400);
>> +    g_assert_cmphex(qtest_readl(qts, TRNG_BASE + 0x14), =3D=3D, 0x400);
>> +    qtest_quit(qts);
>> +}
>> +
>> +/*
>> + * A53_0 uses threads 9/8 with the same secure prefix as the R5 secure
>> + * pair.  If it is classified non-secure, the request header shifts and
>> + * response prefix is missing, leaving BL31 waiting forever.
>> + */
>> +static void test_dmsc_a53_secure_version(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    if (qtest_readl(qts, SP_RT(8)) & 0xff) {
>> +        qtest_readl(qts, SP_TARGET(8) + 0x3c);
>> +    }
>> +
>> +    /*
>> +     * A53_0 secure-host VERSION request: zero secure prefix, host 10,
>> +     * and AOP is set.
>> +     */
>> +    qtest_writel(qts, SP_TARGET(9) + 0x04, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(9) + 0x08, 0x010a0002);
>> +    qtest_writel(qts, SP_TARGET(9) + 0x0c, 0x00000002);
>> +    qtest_writel(qts, SP_TARGET(9) + 0x3c, 0x00000000);
>> +
>> +    for (int i =3D 0; i < 100; i++) {
>> +        if (qtest_readl(qts, SP_RT(8)) & 0xff) {
>> +            break;
>> +        }
>> +        g_usleep(10 * 1000);
>> +    }
>> +    g_assert_cmphex(qtest_readl(qts, SP_RT(8)) & 0xff, >, 0);
>> +
>> +    /* VERSION type echoed and ACK bit is set. */
>> +    g_assert_cmphex(qtest_readl(qts, SP_TARGET(8) + 0x08) & 0xffff,
>> +                    =3D=3D, 0x0002);
>> +    g_assert_cmphex(qtest_readl(qts, SP_TARGET(8) + 0x0c) & 0x2, =3D=3D=
, 0x2);
>> +    qtest_quit(qts);
>> +}
>> +
>> +/*
>> + * TISCI_MSG_FWL_SET (0x9000) is a bare-ACK request.  Without handler
>> + * it falls through to the unknown-message NAK path.
>> + */
>> +static void test_dmsc_fwl_set_ack(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +
>> +    if (qtest_readl(qts, SP_RT(0)) & 0xff) {
>> +        qtest_readl(qts, SP_TARGET(0) + 0x3c);
>> +    }
>> +
>> +    /*
>> +     * R5 secure FWL_SET: type 0x9000, host 35, AOP set, fwl_id 0x23,
>> +     * region 3, one permission register.
>> +     */
>> +    qtest_writel(qts, SP_TARGET(1) + 0x04, 0x00000000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x08, 0x0b239000);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x0c, 0x00000002);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x10, 0x00030023);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x14, 0x00000001);
>> +    qtest_writel(qts, SP_TARGET(1) + 0x3c, 0x00000000);
>> +
>> +    for (int i =3D 0; i < 100; i++) {
>> +        if (qtest_readl(qts, SP_RT(0)) & 0xff) {
>> +            break;
>> +        }
>> +        g_usleep(10 * 1000);
>> +    }
>> +    g_assert_cmphex(qtest_readl(qts, SP_RT(0)) & 0xff, >, 0);
>> +
>> +    g_assert_cmphex(qtest_readl(qts, SP_TARGET(0) + 0x08) & 0xffff,
>> +                    =3D=3D, 0x9000);
>> +    g_assert_cmphex(qtest_readl(qts, SP_TARGET(0) + 0x0c) & 0x2, =3D=3D=
, 0x2);
>> +    qtest_quit(qts);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +    qtest_add_func("/am64-virt/ocsram", test_ocsram_rw);
>> +    qtest_add_func("/am64-virt/main-uart0", test_main_uart0_present);
>> +    qtest_add_func("/am64-virt/r5f-present", test_r5f_cpu_present);
>> +    qtest_add_func("/am64-virt/devstat", test_devstat);
>> +    qtest_add_func("/am64-virt/dmsc-r5-version", test_dmsc_r5_version);
>> +    qtest_add_func("/am64-virt/dmsc-r5-get-freq", test_dmsc_r5_get_freq=
);
>> +    qtest_add_func("/am64-virt/dmsc-no-response",
>> +                   test_dmsc_r5_no_response_flag);
>> +    qtest_add_func("/am64-virt/dmsc-sys-reset", test_dmsc_r5_sys_reset);
>> +    qtest_add_func("/am64-virt/dmsc-bootvector",
>> +                   test_dmsc_r5_bootvector_capture);
>> +    qtest_add_func("/am64-virt/dmtimer", test_dmtimer_counts);
>> +    qtest_add_func("/am64-virt/dmtimer-prescaler", test_dmtimer_prescal=
er);
>> +    qtest_add_func("/am64-virt/dmtimer-reconfigure", test_dmtimer_recon=
figure);
>> +    qtest_add_func("/am64-virt/gicv3", test_gicv3_present);
>> +    qtest_add_func("/am64-virt/ddrss-stub", test_ddrss_stub);
>> +    qtest_add_func("/am64-virt/sdhci", test_sdhci_present);
>> +    qtest_add_func("/am64-virt/trng", test_trng_stub);
>> +    qtest_add_func("/am64-virt/dmsc-a53-secure-version",
>> +                   test_dmsc_a53_secure_version);
>> +    qtest_add_func("/am64-virt/dmsc-fwl-set", test_dmsc_fwl_set_ack);
>> +    return g_test_run();
>> +}
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index f7c7d06620..d915fb4199 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -274,6 +274,7 @@ qtests_aarch64 =3D \
>>    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>>     config_all_devices.has_key('CONFIG_ARM_VIRT') ?
>>     ['iommu-smmuv3-test'] : []) + \
>> +  (config_all_devices.has_key('CONFIG_AM64_VIRT') ? ['am64-virt-test', =
'ti-am64-i2c-test', 'am64-adma-pacing-test'] : []) + \
>>    qtests_cxl +                                                         =
                         \
>>    ['arm-cpu-features',
>>     'numa-test',
>> diff --git a/tests/qtest/ti-am64-i2c-test.c b/tests/qtest/ti-am64-i2c-te=
st.c
>> new file mode 100644
>> index 0000000000..eda8d8032f
>> --- /dev/null
>> +++ b/tests/qtest/ti-am64-i2c-test.c
>> @@ -0,0 +1,137 @@
>> +/*
>> + * QTests for AM64x main_i2c0 controller
>> + *
>> + * Copyright (c) 2026 CMBLU Energy AG
>> + * Author: Wadim Mueller <wafgo01@gmail.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +
>> +/* main_i2c0 window: i2c@20000000, len 0x100. */
>> +#define I2C0_BASE 0x20000000ULL
>> +
>> +/* OMAP I2C V2 register offsets. */
>> +#define I2C_V2_SYSC          0x10
>> +#define I2C_V2_IRQSTATUS_RAW 0x24
>> +#define I2C_V2_IRQSTATUS     0x28
>> +#define I2C_V2_SYSS          0x90
>> +#define I2C_V2_CNT           0x98
>> +#define I2C_V2_DATA          0x9c
>> +#define I2C_V2_CON           0xa4
>> +#define I2C_V2_SA            0xac
>> +
>> +/* Register bits. */
>> +#define I2C_SYSC_SRST   (1 << 1)  /* SYSCONFIG soft reset */
>> +#define I2C_SYSS_RDONE  (1 << 0)  /* reset done */
>> +#define I2C_STAT_NACK   (1 << 1)  /* no acknowledgement */
>> +#define I2C_STAT_ARDY   (1 << 2)  /* register access ready */
>> +#define I2C_STAT_RRDY   (1 << 3)  /* receive data ready */
>> +
>> +#define I2C_CON_EN  (1 << 15)     /* module enable */
>> +#define I2C_CON_MST (1 << 10)     /* master mode */
>> +#define I2C_CON_STP (1 << 1)      /* stop condition */
>> +#define I2C_CON_STT (1 << 0)      /* start condition */
>> +
>> +/*
>> + * SYSCONFIG.SRST must make SYSS.RDONE assert, or the firmware spins in
>> + * the soft-reset poll.
>> + */
>> +static void test_soft_reset_completes(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +    uint32_t syss =3D 0;
>> +
>> +    qtest_writew(qts, I2C0_BASE + I2C_V2_SYSC, I2C_SYSC_SRST);
>> +
>> +    for (int i =3D 0; i < 16; i++) {
>> +        syss =3D qtest_readw(qts, I2C0_BASE + I2C_V2_SYSS);
>> +        if (syss & I2C_SYSS_RDONE) {
>> +            break;
>> +        }
>> +    }
>> +    g_assert_cmphex(syss & I2C_SYSS_RDONE, =3D=3D, I2C_SYSS_RDONE);
>> +    qtest_quit(qts);
>> +}
>> +
>> +/*
>> + * Reads from an address without a slave must raise NACK promptly, sinc=
e a
>> + * driver would otherwise wait forever for an I2C event. No slave is
>> + * attached here, so any address does.
>> + */
>> +static void test_nack_on_absent_slave(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt");
>> +    uint32_t stat;
>> +
>> +    /* Bring the controller out of reset as firmware does. */
>> +    qtest_writew(qts, I2C0_BASE + I2C_V2_SYSC, I2C_SYSC_SRST);
>> +    (void)qtest_readw(qts, I2C0_BASE + I2C_V2_SYSS);
>> +
>> +    /* Address 0x51 has no slave: one-byte master read. */
>> +    qtest_writew(qts, I2C0_BASE + I2C_V2_SA, 0x51);
>> +    qtest_writew(qts, I2C0_BASE + I2C_V2_CNT, 1);
>> +    qtest_writew(qts, I2C0_BASE + I2C_V2_CON,
>> +                 I2C_CON_EN | I2C_CON_MST | I2C_CON_STT | I2C_CON_STP);
>> +
>> +    stat =3D qtest_readw(qts, I2C0_BASE + I2C_V2_IRQSTATUS_RAW);
>> +    g_assert_cmphex(stat & I2C_STAT_NACK, =3D=3D, I2C_STAT_NACK);
>> +
>> +    /* IRQSTATUS mirrors NACK and is write-1-to-clear. */
>> +    stat =3D qtest_readw(qts, I2C0_BASE + I2C_V2_IRQSTATUS);
>> +    g_assert_cmphex(stat & I2C_STAT_NACK, =3D=3D, I2C_STAT_NACK);
>> +    qtest_writew(qts, I2C0_BASE + I2C_V2_IRQSTATUS, I2C_STAT_NACK);
>> +    stat =3D qtest_readw(qts, I2C0_BASE + I2C_V2_IRQSTATUS);
>> +    g_assert_cmphex(stat & I2C_STAT_NACK, =3D=3D, 0);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +/*
>> + * With a slave on the bus a one-byte master read has to ACK, return DA=
TA
>> + * and then finish with ARDY. An at24c EEPROM at 0x50 serves as the sla=
ve;
>> + * it comes up erased, so offset 0 reads back as 0x00.
>> + */
>> +static void test_eeprom_read_first_byte(void)
>> +{
>> +    QTestState *qts =3D qtest_init("-machine am64-virt "
>> +                                 "-device at24c-eeprom,address=3D0x50,"
>> +                                 "rom-size=3D4096");
>> +    uint32_t stat;
>> +    uint8_t b;
>> +
>> +    qtest_writew(qts, I2C0_BASE + I2C_V2_SYSC, I2C_SYSC_SRST);
>> +    (void)qtest_readw(qts, I2C0_BASE + I2C_V2_SYSS);
>> +
>> +    /* One-byte read from 0x50; address pointer starts by 0. */
>> +    qtest_writew(qts, I2C0_BASE + I2C_V2_SA, 0x50);
>> +    qtest_writew(qts, I2C0_BASE + I2C_V2_CNT, 1);
>> +    qtest_writew(qts, I2C0_BASE + I2C_V2_CON,
>> +                 I2C_CON_EN | I2C_CON_MST | I2C_CON_STT | I2C_CON_STP);
>> +
>> +    /* Slave ACKed and data are ready. */
>> +    stat =3D qtest_readw(qts, I2C0_BASE + I2C_V2_IRQSTATUS_RAW);
>> +    g_assert_cmphex(stat & I2C_STAT_NACK, =3D=3D, 0);
>> +    g_assert_cmphex(stat & I2C_STAT_RRDY, =3D=3D, I2C_STAT_RRDY);
>> +
>> +    /* Offset 0 of the erased EEPROM reads as 0x00. */
>> +    b =3D qtest_readw(qts, I2C0_BASE + I2C_V2_DATA) & 0xff;
>> +    g_assert_cmphex(b, =3D=3D, 0x00);
>> +
>> +    /* Single-byte transfer complete: ARDY, no more RRDY. */
>> +    stat =3D qtest_readw(qts, I2C0_BASE + I2C_V2_IRQSTATUS_RAW);
>> +    g_assert_cmphex(stat & I2C_STAT_ARDY, =3D=3D, I2C_STAT_ARDY);
>> +    g_assert_cmphex(stat & I2C_STAT_RRDY, =3D=3D, 0);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +    qtest_add_func("/am64/i2c/soft-reset", test_soft_reset_completes);
>> +    qtest_add_func("/am64/i2c/nack", test_nack_on_absent_slave);
>> +    qtest_add_func("/am64/i2c/eeprom-read", test_eeprom_read_first_byte=
);
>> +    return g_test_run();
>> +}
>> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
>> index dc3fb954c0..be2aab4274 100644
>> --- a/tests/unit/meson.build
>> +++ b/tests/unit/meson.build
>> @@ -41,6 +41,7 @@ tests =3D {
>>    'test-bitops': [],
>>    'test-bitcnt': [],
>>    'test-qgraph': ['../qtest/libqos/qgraph.c'],
>> +  'test-k3-bootrom': ['../../hw/arm/k3-bootrom-parse.c'],
>>    'check-qom-interface': [qom],
>>    'check-qom-proplist': [qom],
>>    'test-qemu-opts': [],
>> diff --git a/tests/unit/test-k3-bootrom.c b/tests/unit/test-k3-bootrom.c
>> new file mode 100644
>> index 0000000000..b030d7df9b
>> --- /dev/null
>> +++ b/tests/unit/test-k3-bootrom.c
>> @@ -0,0 +1,263 @@
>> +/*
>> + * Unit tests for K3 boot-ROM combined-image parser
>> + *
>> + * Copyright (c) 2026 CMBLU Energy AG
>> + * Author: Wadim Mueller <wafgo01@gmail.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/arm/k3-bootrom.h"
>> +
>> +/* Minimal DER emitters. */
>> +
>> +static GByteArray *der_tlv(uint8_t tag, const uint8_t *data, size_t len)
>> +{
>> +    GByteArray *a =3D g_byte_array_new();
>> +
>> +    g_byte_array_append(a, &tag, 1);
>> +    if (len < 0x80) {
>> +        uint8_t l =3D len;
>> +        g_byte_array_append(a, &l, 1);
>> +    } else if (len <=3D 0xffff) {
>> +        uint8_t l[3] =3D { 0x82, len >> 8, len & 0xff };
>> +        g_byte_array_append(a, l, 3);
>> +    } else {
>> +        g_assert_not_reached();
>> +    }
>> +    if (data) {
>> +        g_byte_array_append(a, data, len);
>> +    }
>> +    return a;
>> +}
>> +
>> +static GByteArray *der_wrap(uint8_t tag, GByteArray *inner)
>> +{
>> +    GByteArray *a =3D der_tlv(tag, inner->data, inner->len);
>> +    g_byte_array_unref(inner);
>> +    return a;
>> +}
>> +
>> +static void der_append(GByteArray *dst, GByteArray *src)
>> +{
>> +    g_byte_array_append(dst, src->data, src->len);
>> +    g_byte_array_unref(src);
>> +}
>> +
>> +static GByteArray *der_uint(uint64_t v)
>> +{
>> +    uint8_t buf[9];
>> +    int n =3D 0;
>> +    uint64_t t =3D v;
>> +
>> +    do {
>> +        n++;
>> +        t >>=3D 8;
>> +    } while (t);
>> +    if (v >> (n * 8 - 1) & 1) {
>> +        n++; /* leading zero keeps it positive */
>> +    }
>> +    for (int i =3D 0; i < n; i++) {
>> +        buf[i] =3D v >> ((n - 1 - i) * 8);
>> +    }
>> +    return der_tlv(0x02, buf, n);
>> +}
>> +
>> +/* OID 1.3.6.1.4.1.294.1.9 (ext_boot_info), pre-encoded TLV */
>> +static const uint8_t ext_boot_oid[] =3D {
>> +    0x06, 0x09, 0x2b, 0x06, 0x01, 0x04, 0x01, 0x82, 0x26, 0x01, 0x09
>> +};
>> +/* OID 2.16.840.1.101.3.4.2.3 (sha512), pre-encoded TLV */
>> +static const uint8_t sha512_oid[] =3D {
>> +    0x06, 0x09, 0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03
>> +};
>> +
>> +static GByteArray *der_component(uint32_t ctype, uint32_t core,
>> +                                 uint32_t opts, uint32_t dest, uint64_t=
 size)
>> +{
>> +    GByteArray *seq =3D g_byte_array_new();
>> +    uint8_t dest_be[4] =3D { dest >> 24, dest >> 16, dest >> 8, dest };
>> +    uint8_t sha[64] =3D { 0 };
>> +
>> +    der_append(seq, der_uint(ctype));
>> +    der_append(seq, der_uint(core));
>> +    der_append(seq, der_uint(opts));
>> +    der_append(seq, der_tlv(0x04, dest_be, sizeof(dest_be)));
>> +    der_append(seq, der_uint(size));
>> +    g_byte_array_append(seq, sha512_oid, sizeof(sha512_oid));
>> +    der_append(seq, der_tlv(0x04, sha, sizeof(sha)));
>> +    return der_wrap(0x30, seq);
>> +}
>> +
>> +/*
>> + * Layout follows u-boot tools/binman/btool/openssl.py
>> + * x509_cert_rom_combined(): SBL, SYSFW, SYSFW-DATA payloads are after
>> + * the certificate.
>> + */
>> +static GByteArray *make_image(const uint8_t *sbl, size_t sbl_len)
>> +{
>> +    static const uint8_t sysfw_blob[16] =3D "SYSFW-payload";
>> +    static const uint8_t cfg_blob[8] =3D "BCFG";
>> +    GByteArray *info =3D g_byte_array_new();
>> +    GByteArray *ext, *cert, *img;
>> +
>> +    der_append(info, der_uint(sbl_len + sizeof(sysfw_blob)
>> +                              + sizeof(cfg_blob)));      /* extImgSize =
*/
>> +    der_append(info, der_uint(3));                       /* numComp */
>> +    der_append(info, der_component(K3_COMP_TYPE_SBL, 16, 0,
>> +                                   0x70000000, sbl_len));
>> +    der_append(info, der_component(K3_COMP_TYPE_SYSFW, 0, 0,
>> +                                   0x44000, sizeof(sysfw_blob)));
>> +    der_append(info, der_component(K3_COMP_TYPE_SYSFW_DATA, 0, 0,
>> +                                   0x7b000, sizeof(cfg_blob)));
>> +    info =3D der_wrap(0x30, info);
>> +
>> +    /* extension is SEQ { OID, OCTETSTRING { info } } */
>> +    ext =3D g_byte_array_new();
>> +    g_byte_array_append(ext, ext_boot_oid, sizeof(ext_boot_oid));
>> +    der_append(ext, der_wrap(0x04, info));
>> +    ext =3D der_wrap(0x30, ext);
>> +
>> +    /* fake cert: top-level SEQUENCE around the extension */
>> +    cert =3D der_wrap(0x30, ext);
>> +
>> +    img =3D g_byte_array_new();
>> +    g_byte_array_append(img, cert->data, cert->len);
>> +    g_byte_array_unref(cert);
>> +    g_byte_array_append(img, sbl, sbl_len);
>> +    g_byte_array_append(img, sysfw_blob, sizeof(sysfw_blob));
>> +    g_byte_array_append(img, cfg_blob, sizeof(cfg_blob));
>> +    return img;
>> +}
>> +
>> +/* Certificate-only image with caller given component sizes. */
>> +static GByteArray *make_cert_with_sizes(const uint64_t *sizes, size_t n)
>> +{
>> +    GByteArray *info =3D g_byte_array_new();
>> +    GByteArray *ext;
>> +    uint64_t total =3D 0;
>> +
>> +    for (size_t i =3D 0; i < n; i++) {
>> +        total +=3D sizes[i];
>> +    }
>> +    der_append(info, der_uint(total));                   /* extImgSize =
*/
>> +    der_append(info, der_uint(n));                       /* numComp */
>> +    for (size_t i =3D 0; i < n; i++) {
>> +        der_append(info, der_component(K3_COMP_TYPE_SBL, 16, 0,
>> +                                       0x70000000, sizes[i]));
>> +    }
>> +    info =3D der_wrap(0x30, info);
>> +
>> +    ext =3D g_byte_array_new();
>> +    g_byte_array_append(ext, ext_boot_oid, sizeof(ext_boot_oid));
>> +    der_append(ext, der_wrap(0x04, info));
>> +    ext =3D der_wrap(0x30, ext);
>> +    return der_wrap(0x30, ext);
>> +}
>> +
>> +static void test_parse_ok(void)
>> +{
>> +    static const uint8_t sbl[32] =3D "SBL-payload";
>> +    GByteArray *img =3D make_image(sbl, sizeof(sbl));
>> +    K3BootImage out;
>> +    Error *err =3D NULL;
>> +
>> +    g_assert_true(k3_bootrom_parse(img->data, img->len, &out, &err));
>> +    g_assert_null(err);
>> +    g_assert_cmpuint(out.num_comps, =3D=3D, 3);
>> +    g_assert_cmpuint(out.comps[0].comp_type, =3D=3D, K3_COMP_TYPE_SBL);
>> +    g_assert_cmphex(out.comps[0].dest_addr, =3D=3D, 0x70000000);
>> +    g_assert_cmpuint(out.comps[0].comp_size, =3D=3D, sizeof(sbl));
>> +    g_assert_cmpuint(out.comps[0].payload_offset, =3D=3D, out.cert_len);
>> +    g_assert_cmphex(out.comps[1].dest_addr, =3D=3D, 0x44000);
>> +    g_assert_cmpuint(out.comps[2].payload_offset, =3D=3D,
>> +                     out.cert_len + sizeof(sbl) + 16);
>> +    g_assert_cmpint(memcmp(img->data + out.comps[0].payload_offset,
>> +                           sbl, sizeof(sbl)), =3D=3D, 0);
>> +    g_byte_array_unref(img);
>> +}
>> +
>> +static void test_parse_not_der(void)
>> +{
>> +    static const uint8_t junk[64] =3D { 0xff, 0x00, 0x41 };
>> +    K3BootImage out;
>> +    Error *err =3D NULL;
>> +
>> +    g_assert_false(k3_bootrom_parse(junk, sizeof(junk), &out, &err));
>> +    g_assert_nonnull(err);
>> +    error_free(err);
>> +}
>> +
>> +static void test_parse_no_extension(void)
>> +{
>> +    /* Valid DER SEQUENCE, but no ext_boot_info OID. */
>> +    static const uint8_t seq[] =3D { 0x30, 0x03, 0x02, 0x01, 0x05 };
>> +    K3BootImage out;
>> +    Error *err =3D NULL;
>> +
>> +    g_assert_false(k3_bootrom_parse(seq, sizeof(seq), &out, &err));
>> +    g_assert_nonnull(err);
>> +    error_free(err);
>> +}
>> +
>> +static void test_parse_truncated_payload(void)
>> +{
>> +    static const uint8_t sbl[32] =3D "SBL-payload";
>> +    GByteArray *img =3D make_image(sbl, sizeof(sbl));
>> +    K3BootImage out;
>> +    Error *err =3D NULL;
>> +
>> +    /* Truncated payload: comp_size claims are beyond file. */
>> +    g_assert_false(k3_bootrom_parse(img->data, img->len - 20, &out, &er=
r));
>> +    g_assert_nonnull(err);
>> +    error_free(err);
>> +    g_byte_array_unref(img);
>> +}
>> +
>> +static void test_parse_size_exceeds_u32(void)
>> +{
>> +    /* comp_size wider than 32 bits must not truncate silently. */
>> +    static const uint64_t sizes[1] =3D { UINT32_MAX + 1ull };
>> +    GByteArray *img =3D make_cert_with_sizes(sizes, G_N_ELEMENTS(sizes)=
);
>> +    K3BootImage out;
>> +    Error *err =3D NULL;
>> +
>> +    g_assert_false(k3_bootrom_parse(img->data, img->len, &out, &err));
>> +    g_assert_nonnull(err);
>> +    error_free(err);
>> +    g_byte_array_unref(img);
>> +}
>> +
>> +static void test_parse_size_sum_wraps_32bit(void)
>> +{
>> +    /*
>> +     * Each single size fits in 32 bits, but their sum must not wrap the
>> +     * running total.
>> +     */
>> +    static const uint64_t sizes[3] =3D {
>> +        0xf0000000, 0xf0000000, 0xf0000000
>> +    };
>> +    GByteArray *img =3D make_cert_with_sizes(sizes, G_N_ELEMENTS(sizes)=
);
>> +    K3BootImage out;
>> +    Error *err =3D NULL;
>> +
>> +    g_assert_false(k3_bootrom_parse(img->data, img->len, &out, &err));
>> +    g_assert_nonnull(err);
>> +    error_free(err);
>> +    g_byte_array_unref(img);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +    g_test_add_func("/k3-bootrom/parse-ok", test_parse_ok);
>> +    g_test_add_func("/k3-bootrom/not-der", test_parse_not_der);
>> +    g_test_add_func("/k3-bootrom/no-extension", test_parse_no_extension=
);
>> +    g_test_add_func("/k3-bootrom/truncated", test_parse_truncated_paylo=
ad);
>> +    g_test_add_func("/k3-bootrom/size-exceeds-u32",
>> +                    test_parse_size_exceeds_u32);
>> +    g_test_add_func("/k3-bootrom/size-sum-wraps-32bit",
>> +                    test_parse_size_sum_wraps_32bit);
>> +    return g_test_run();
>> +}
>
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

