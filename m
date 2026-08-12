Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9567DC5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2W9-0001sy-Lh; Wed, 12 Aug 2026 02:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wu2Vp-0000zg-Pr
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:32:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wu2Vk-00047m-RB
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:32:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so8172675ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786516343; x=1787121143; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:content-type
 :message-id:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+BHWnBbixY8f05f9HpuT54nzFAEjgiYRdNAZSYh9faI=;
 b=sFxvKQ4sj8V0r6El+2GTDbczBsIn8QYjPR/iTnVcsdmDRm0TBzVzDaMmwzqecrM3Yq
 5gsNfd4PQCALeCRmklAy3+yzZFk2wBBVslpA8Dq2XuT3X3Z/a3VjVl1snLmU0T0ny/uj
 HANIGVtjgmgtG6HVLSIBcWJHvmWXG04g+ESOswfixOGFfUoK94FasPkrdVmJ1txdmFoS
 1CM4p1CQJkSrSsW5vTVi5x5cPqIl2qWax1eA9F58lM+7WoThihGmN39IAheSXZEHcb3V
 QOofCdgzxjqtHFWqxefPk1G92RoG2iKDFFJlAEYbZEL7umLb8WEG8uVTVcq89dHyc3GJ
 DpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516343; x=1787121143;
 h=references:to:cc:in-reply-to:date:subject:mime-version:content-type
 :message-id:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+BHWnBbixY8f05f9HpuT54nzFAEjgiYRdNAZSYh9faI=;
 b=Cx8l4qyHWlf2nJJ1DuTVxEEwotrWDeZmgRLGx26uxIpE3ITK07QlxZjIr0yQjojl+c
 0ex9ICORCgtePdCo87105qsn1ZmhAa86tzyU99vw1y3dtrbK6XnehyKx4se5IkN724bT
 e2Vf8iRQ6ADuuQetPzkSRS99FGIVP9cW7xWHTpb1I1UPFsMht/GaLV99paoW4RWaY51c
 hNSDcVspszIocg+mV5UD/p+JYUzFIrNHlGM5jli/wrCRaITN8uPka2c127mobGymbgSt
 +MoZtroeSy09LWzcoIqhL/oIxHo9saMAh8udoP0mmbiqoR9k/tO1WA5a5LsG2B+KRj6R
 tKPg==
X-Gm-Message-State: AOJu0Ywux0tGpRzEPn2wXgzaPWLa8+jrZU5YE8jIMGQbYlgLqf7C3jmE
 5uZB1vqAvDkvZVFnCuJoaWJiGYBbnw8I7sah1sLJAmMxgI/07F14f/1szgwGJZyT
X-Gm-Gg: AR+sD12TpY2W64J4vEZKAOq+Cuw71WBBK0vFOc541HM/67onre7jq1Slfled2e8A3wd
 ygHZefQKUPNkbcL/bSFcRKoxdviOtxhL/8k0mJ/g42DR3tuPELlvDjeJw2+vdqLaJRXsOtkdL6i
 uLuBE5rU34aWp5zwnF6aZMCBiEVpYSkWWDZqDNUZAE9AnJQ3kggl5zhhmMTX9ml08lO4w1X2y89
 nO7dQOQLeZimHd2UldfCTxTvqUa7jacNT7nQ6C7B/tireg63/dmTh7UgVocNsx9nYgi+M4X90dJ
 Qt+Lcf8mfQ7WlrZNTTfm0M8Ntq8Me1Wn61xWhQpCggH3uagn1vWpNWkkNPV+LXNDcXhc+hIsFlz
 pntr54wSknsWbVOaoVGQmBbNN9vSWZUxJ6xyK/jPHmwEKloIcqc2ygNRo5t7XnG9xw9THA7/HmZ
 da7LoMzqPbCaEsuxUtFZouvrSRg6tM0JPOGynr5H3el1hwkDk64xFXz8B8OxDkCWylkQ==
X-Received: by 2002:a17:902:ec8a:b0:2c0:e2ea:6b0c with SMTP id
 d9443c01a7336-2d3456dfed4mr31825545ad.21.1786516343206; 
 Tue, 11 Aug 2026 23:32:23 -0700 (PDT)
Received: from smtpclient.apple ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d350ff0772sm2055865ad.21.2026.08.11.23.32.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Aug 2026 23:32:22 -0700 (PDT)
From: Jack wang <163wangjack@gmail.com>
Message-Id: <776B3C22-7612-401E-B7F2-5658A942DEC8@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_6A6F271E-A998-4CFE-A70F-ECAC3DAAFC24"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [RFC PATCH v1 5/5] rust/hw/gpio: add native unit tests
Date: Wed, 12 Aug 2026 14:31:59 +0800
In-Reply-To: <20260726145119.19881-6-163wangjack@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 qemu-rust@nongnu.org, caojunze424@gmail.com
To: qemu-devel@nongnu.org
References: <20260726145119.19881-1-163wangjack@gmail.com>
 <20260726145119.19881-6-163wangjack@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Apple-Mail=_6A6F271E-A998-4CFE-A70F-ECAC3DAAFC24
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi all,

A polite ping for this RFC series.Thanks advice for Philippe advice and =
I am ready for v2.
Could anyone have other suggestions for my patch. I am appreciative for =
your advice and ready to fix it in v2

> 2026=E5=B9=B47=E6=9C=8826=E6=97=A5 22:51=EF=BC=8CJack Wang =
<163wangjack@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Add native Rust unit tests that link GpioRegisters directly and =
exercise
> the CRL/CRH decode and IDR update algorithm in-process, without =
booting a
> machine or pulling in the softmmu memory subsystem.
>=20
> Signed-off-by: Jack Wang <163wangjack@gmail.com>
> ---
> rust/hw/gpio/tests/tests.rs | 191 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 191 insertions(+)
> create mode 100644 rust/hw/gpio/tests/tests.rs
>=20
> diff --git a/rust/hw/gpio/tests/tests.rs b/rust/hw/gpio/tests/tests.rs
> new file mode 100644
> index 0000000000..ca4d5ed4d6
> --- /dev/null
> +++ b/rust/hw/gpio/tests/tests.rs
> @@ -0,0 +1,191 @@
> +// Native Rust unit tests for the STM32F1xx GPIO register logic.
> +//
> +// Copyright 2026, Jack Wang
> +// Author(s): Jack Wang <163wangjack@gmail.com>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// Unlike tests/qtest/stm32f103_gpio-test.c (which drives the device =
over a
> +// socket from an external qemu-system-arm process), these tests link =
the
> +// device crate directly and exercise `GpioRegisters` in-process. =
This gives
> +// fast, native Rust coverage of the CRL/CRH decode + IDR algorithm =
without
> +// booting a machine or pulling in the softmmu memory subsystem.
> +//
> +// `GpioRegisters` deliberately has no QOM object, no MemoryRegion =
and no
> +// InterruptSource, so it can be constructed with =
`GpioRegisters::new()` and
> +// called directly. Only the BQL mock (bql::start_test) is required, =
because
> +// the register cells are `BqlCell`s.
> +//
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +use stm32f1xx_gpio::gpio::{
> +    GpioRegisters, PinUpdate, REG_BRR, REG_BSRR, REG_CRH, REG_CRL, =
REG_IDR, REG_ODR, RESET_CRH,
> +    RESET_CRL,
> +};
> +
> +/// Take the mock BQL so `BqlCell` accesses are permitted. =
Integration tests
> +/// run with `--test-threads=3D1`, so this is safe to call from every =
test.
> +fn regs() -> GpioRegisters {
> +    bql::start_test();
> +    GpioRegisters::new()
> +}
> +
> +// 4-bit MODE[1:0]+CNF[1:0] pin configurations (RM0008).
> +const CFG_INPUT_FLOATING: u32 =3D 0x4; // MODE=3D00 CNF=3D01 (reset =
default)
> +const CFG_INPUT_PULL: u32 =3D 0x8; // MODE=3D00 CNF=3D10, ODR selects =
up/down
> +const CFG_OUTPUT_PP: u32 =3D 0x1; // MODE=3D01 CNF=3D00, general =
push-pull
> +
> +/// Set the 4-bit config nibble for `pin` in CRL/CRH via an MMIO =
write.
> +fn set_config(r: &GpioRegisters, pin: usize, cfg: u32) {
> +    let reg =3D if pin < 8 { REG_CRL } else { REG_CRH };
> +    let shift =3D ((pin % 8) * 4) as u32;
> +    let old =3D r.read(reg);
> +    r.write(reg, (old & !(0xF << shift)) | (cfg << shift));
> +}
> +
> +fn set_odr_bit(r: &GpioRegisters, pin: usize, value: u32) {
> +    let old =3D r.read(REG_ODR);
> +    r.write(REG_ODR, (old & !(1 << pin)) | (value << pin));
> +}
> +
> +/// True if pin `pin` is set in a [`PinUpdate`] and its reported =
level is
> +/// `level`.
> +fn pin_changed_to(upd: PinUpdate, pin: usize, level: bool) -> bool {
> +    (upd.mask & (1 << pin)) !=3D 0 && (((upd.levels >> pin) & 1) !=3D =
0) =3D=3D level
> +}
> +
> +#[test]
> +/// A freshly created register block holds the RM0008 reset values.
> +fn test_reset_values() {
> +    let r =3D regs();
> +    assert_eq!(r.read(REG_CRL), RESET_CRL);
> +    assert_eq!(r.read(REG_CRH), RESET_CRH);
> +    assert_eq!(r.read(REG_IDR), 0);
> +    assert_eq!(r.read(REG_ODR), 0);
> +}
> +
> +#[test]
> +/// `reset` restores the reset state after the registers are dirtied.
> +fn test_reset_restores() {
> +    let r =3D regs();
> +    r.write(REG_CRL, 0xDEAD_BEEF);
> +    r.write(REG_ODR, 0x0000_FFFF);
> +    assert_ne!(r.read(REG_CRL), RESET_CRL);
> +
> +    r.reset();
> +
> +    assert_eq!(r.read(REG_CRL), RESET_CRL);
> +    assert_eq!(r.read(REG_CRH), RESET_CRH);
> +    assert_eq!(r.read(REG_IDR), 0);
> +    assert_eq!(r.read(REG_ODR), 0);
> +}
> +
> +#[test]
> +/// Push-pull output: IDR follows ODR; ODR written while input is =
latched,
> +/// and the out-pin change is reported.
> +fn test_output_mode() {
> +    let r =3D regs();
> +    let pin =3D 5;
> +
> +    // Set ODR while still a floating input: IDR unaffected, no out =
change.
> +    let idle =3D set_odr_and_report(&r, pin, 1);
> +    assert_eq!(r.read(REG_IDR), 0);
> +    assert_eq!(idle.mask & (1 << pin), 0);
> +
> +    // Switch to push-pull output: pin now follows ODR (high), and =
flips.
> +    let old =3D r.read(REG_CRL);
> +    let to_output =3D r.write(
> +        REG_CRL,
> +        (old & !(0xF << (pin * 4))) | (CFG_OUTPUT_PP << (pin * 4)),
> +    );
> +    assert_eq!(r.read(REG_IDR), 1 << pin);
> +    assert!(pin_changed_to(to_output, pin, true));
> +
> +    // Clear ODR bit: pin goes low, and flips back.
> +    let to_low =3D set_odr_and_report(&r, pin, 0);
> +    assert_eq!(r.read(REG_IDR), 0);
> +    assert!(pin_changed_to(to_low, pin, false));
> +}
> +
> +/// Helper: write one ODR bit and return the resulting [`PinUpdate`].
> +fn set_odr_and_report(r: &GpioRegisters, pin: usize, value: u32) -> =
PinUpdate {
> +    let old =3D r.read(REG_ODR);
> +    r.write(REG_ODR, (old & !(1 << pin)) | (value << pin))
> +}
> +
> +#[test]
> +/// Floating input: an external drive is reflected in IDR and =
reported.
> +fn test_input_mode() {
> +    let r =3D regs();
> +    let pin =3D 6usize;
> +
> +    set_config(&r, pin, CFG_INPUT_FLOATING);
> +
> +    let drive_high =3D r.gpio_set(pin, 1);
> +    assert_eq!(r.read(REG_IDR), 1 << pin);
> +    assert!(pin_changed_to(drive_high, pin, true));
> +
> +    let drive_low =3D r.gpio_set(pin, 0);
> +    assert_eq!(r.read(REG_IDR), 0);
> +    assert!(pin_changed_to(drive_low, pin, false));
> +}
> +
> +#[test]
> +/// Input pull mode: ODR selects pull-up (IDR=3D1) vs pull-down =
(IDR=3D0),
> +/// with no external driver connected.
> +fn test_pull_up_down() {
> +    let r =3D regs();
> +    let pin =3D 0;
> +
> +    set_odr_bit(&r, pin, 1);
> +    set_config(&r, pin, CFG_INPUT_PULL);
> +    assert_eq!(r.read(REG_IDR), 1 << pin);
> +
> +    set_odr_bit(&r, pin, 0);
> +    assert_eq!(r.read(REG_IDR), 0);
> +}
> +
> +#[test]
> +/// BSRR sets/resets ODR bits (set has priority); BRR resets ODR =
bits.
> +fn test_bsrr_brr() {
> +    let r =3D regs();
> +    let pin =3D 1;
> +
> +    r.write(REG_BSRR, 1 << pin);
> +    assert_eq!(r.read(REG_ODR), 1 << pin);
> +
> +    r.write(REG_BSRR, 1 << (pin + 16));
> +    assert_eq!(r.read(REG_ODR), 0);
> +
> +    r.write(REG_BSRR, 1 << pin);
> +    r.write(REG_BRR, 1 << pin);
> +    assert_eq!(r.read(REG_ODR), 0);
> +
> +    // Set has priority over reset within one BSRR write.
> +    r.write(REG_BSRR, (1 << pin) | (1 << (pin + 16)));
> +    assert_eq!(r.read(REG_ODR), 1 << pin);
> +}
> +
> +#[test]
> +/// A pin driven externally, then reconfigured as push-pull output, =
is
> +/// disconnected: IDR follows ODR, not the stale external level.
> +fn test_push_pull_disconnect() {
> +    let r =3D regs();
> +    let pin =3D 7usize;
> +
> +    // Drive high externally as input.
> +    set_config(&r, pin, CFG_INPUT_FLOATING);
> +    r.gpio_set(pin, 1);
> +    assert_eq!(r.read(REG_IDR), 1 << pin);
> +    assert_eq!(r.disconnected_pins() & (1 << pin), 0); // now =
connected
> +
> +    // Reconfigure as push-pull output with ODR=3D0: pin must drop to =
0,
> +    // and the external driver must be disconnected.
> +    set_odr_bit(&r, pin, 0);
> +    set_config(&r, pin, CFG_OUTPUT_PP);
> +    assert_eq!(r.read(REG_IDR), 0);
> +    assert_ne!(r.disconnected_pins() & (1 << pin), 0); // =
disconnected again
> +
> +    // Further external drives are ignored while output push-pull.
> +    r.gpio_set(pin, 1);
> +    assert_eq!(r.read(REG_IDR), 0);
> +}
> --=20
> 2.53.0
>=20


--Apple-Mail=_6A6F271E-A998-4CFE-A70F-ECAC3DAAFC24
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><p style=3D"margin: 0px; font-width: =
normal; line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal;"><span =
style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
caret-color: rgb(0, 0, 0);">Hi all,</span><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px;"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px;"><font color=3D"#000000"><span =
style=3D"caret-color: rgb(0, 0, 0);">A polite ping for this RFC =
series.Thanks advice for Philippe advice and I am ready for =
v2.</span></font></p><p style=3D"margin: 0px; font-width: normal; =
line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal;"><font =
color=3D"#000000">Could anyone have other suggestions for my patch. I am =
appreciative for your advice and ready to fix it in =
v2</font></p><div><br><blockquote type=3D"cite"><div>2026=E5=B9=B47=E6=9C=88=
26=E6=97=A5 22:51=EF=BC=8CJack Wang &lt;163wangjack@gmail.com&gt; =
=E5=86=99=E9=81=93=EF=BC=9A</div><br =
class=3D"Apple-interchange-newline"><div><div>Add native Rust unit tests =
that link GpioRegisters directly and exercise<br>the CRL/CRH decode and =
IDR update algorithm in-process, without booting a<br>machine or pulling =
in the softmmu memory subsystem.<br><br>Signed-off-by: Jack Wang =
&lt;163wangjack@gmail.com&gt;<br>---<br> rust/hw/gpio/tests/tests.rs | =
191 ++++++++++++++++++++++++++++++++++++<br> 1 file changed, 191 =
insertions(+)<br> create mode 100644 =
rust/hw/gpio/tests/tests.rs<br><br>diff --git =
a/rust/hw/gpio/tests/tests.rs b/rust/hw/gpio/tests/tests.rs<br>new file =
mode 100644<br>index 0000000000..ca4d5ed4d6<br>--- /dev/null<br>+++ =
b/rust/hw/gpio/tests/tests.rs<br>@@ -0,0 +1,191 @@<br>+// Native Rust =
unit tests for the STM32F1xx GPIO register logic.<br>+//<br>+// =
Copyright 2026, Jack Wang<br>+// Author(s): Jack Wang =
&lt;163wangjack@gmail.com&gt;<br>+// SPDX-License-Identifier: =
GPL-2.0-or-later<br>+//<br>+// Unlike tests/qtest/stm32f103_gpio-test.c =
(which drives the device over a<br>+// socket from an external =
qemu-system-arm process), these tests link the<br>+// device crate =
directly and exercise `GpioRegisters` in-process. This gives<br>+// =
fast, native Rust coverage of the CRL/CRH decode + IDR algorithm =
without<br>+// booting a machine or pulling in the softmmu memory =
subsystem.<br>+//<br>+// `GpioRegisters` deliberately has no QOM object, =
no MemoryRegion and no<br>+// InterruptSource, so it can be constructed =
with `GpioRegisters::new()` and<br>+// called directly. Only the BQL =
mock (bql::start_test) is required, because<br>+// the register cells =
are `BqlCell`s.<br>+//<br>+// SPDX-License-Identifier: =
GPL-2.0-or-later<br>+<br>+use stm32f1xx_gpio::gpio::{<br>+ =
&nbsp;&nbsp;&nbsp;GpioRegisters, PinUpdate, REG_BRR, REG_BSRR, REG_CRH, =
REG_CRL, REG_IDR, REG_ODR, RESET_CRH,<br>+ =
&nbsp;&nbsp;&nbsp;RESET_CRL,<br>+};<br>+<br>+/// Take the mock BQL so =
`BqlCell` accesses are permitted. Integration tests<br>+/// run with =
`--test-threads=3D1`, so this is safe to call from every test.<br>+fn =
regs() -&gt; GpioRegisters {<br>+ =
&nbsp;&nbsp;&nbsp;bql::start_test();<br>+ =
&nbsp;&nbsp;&nbsp;GpioRegisters::new()<br>+}<br>+<br>+// 4-bit =
MODE[1:0]+CNF[1:0] pin configurations (RM0008).<br>+const =
CFG_INPUT_FLOATING: u32 =3D 0x4; // MODE=3D00 CNF=3D01 (reset =
default)<br>+const CFG_INPUT_PULL: u32 =3D 0x8; // MODE=3D00 CNF=3D10, =
ODR selects up/down<br>+const CFG_OUTPUT_PP: u32 =3D 0x1; // MODE=3D01 =
CNF=3D00, general push-pull<br>+<br>+/// Set the 4-bit config nibble for =
`pin` in CRL/CRH via an MMIO write.<br>+fn set_config(r: =
&amp;GpioRegisters, pin: usize, cfg: u32) {<br>+ &nbsp;&nbsp;&nbsp;let =
reg =3D if pin &lt; 8 { REG_CRL } else { REG_CRH };<br>+ =
&nbsp;&nbsp;&nbsp;let shift =3D ((pin % 8) * 4) as u32;<br>+ =
&nbsp;&nbsp;&nbsp;let old =3D r.read(reg);<br>+ =
&nbsp;&nbsp;&nbsp;r.write(reg, (old &amp; !(0xF &lt;&lt; shift)) | (cfg =
&lt;&lt; shift));<br>+}<br>+<br>+fn set_odr_bit(r: &amp;GpioRegisters, =
pin: usize, value: u32) {<br>+ &nbsp;&nbsp;&nbsp;let old =3D =
r.read(REG_ODR);<br>+ &nbsp;&nbsp;&nbsp;r.write(REG_ODR, (old &amp; !(1 =
&lt;&lt; pin)) | (value &lt;&lt; pin));<br>+}<br>+<br>+/// True if pin =
`pin` is set in a [`PinUpdate`] and its reported level is<br>+/// =
`level`.<br>+fn pin_changed_to(upd: PinUpdate, pin: usize, level: bool) =
-&gt; bool {<br>+ &nbsp;&nbsp;&nbsp;(upd.mask &amp; (1 &lt;&lt; pin)) !=3D=
 0 &amp;&amp; (((upd.levels &gt;&gt; pin) &amp; 1) !=3D 0) =3D=3D =
level<br>+}<br>+<br>+#[test]<br>+/// A freshly created register block =
holds the RM0008 reset values.<br>+fn test_reset_values() {<br>+ =
&nbsp;&nbsp;&nbsp;let r =3D regs();<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_CRL), RESET_CRL);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_CRH), RESET_CRH);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), 0);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_ODR), =
0);<br>+}<br>+<br>+#[test]<br>+/// `reset` restores the reset state =
after the registers are dirtied.<br>+fn test_reset_restores() {<br>+ =
&nbsp;&nbsp;&nbsp;let r =3D regs();<br>+ =
&nbsp;&nbsp;&nbsp;r.write(REG_CRL, 0xDEAD_BEEF);<br>+ =
&nbsp;&nbsp;&nbsp;r.write(REG_ODR, 0x0000_FFFF);<br>+ =
&nbsp;&nbsp;&nbsp;assert_ne!(r.read(REG_CRL), RESET_CRL);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;r.reset();<br>+<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_CRL), RESET_CRL);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_CRH), RESET_CRH);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), 0);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_ODR), =
0);<br>+}<br>+<br>+#[test]<br>+/// Push-pull output: IDR follows ODR; =
ODR written while input is latched,<br>+/// and the out-pin change is =
reported.<br>+fn test_output_mode() {<br>+ &nbsp;&nbsp;&nbsp;let r =3D =
regs();<br>+ &nbsp;&nbsp;&nbsp;let pin =3D 5;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;// Set ODR while still a floating input: IDR =
unaffected, no out change.<br>+ &nbsp;&nbsp;&nbsp;let idle =3D =
set_odr_and_report(&amp;r, pin, 1);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), 0);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(idle.mask &amp; (1 &lt;&lt; pin), =
0);<br>+<br>+ &nbsp;&nbsp;&nbsp;// Switch to push-pull output: pin now =
follows ODR (high), and flips.<br>+ &nbsp;&nbsp;&nbsp;let old =3D =
r.read(REG_CRL);<br>+ &nbsp;&nbsp;&nbsp;let to_output =3D r.write(<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;REG_CRL,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(old &amp; !(0xF &lt;&lt; (pin =
* 4))) | (CFG_OUTPUT_PP &lt;&lt; (pin * 4)),<br>+ =
&nbsp;&nbsp;&nbsp;);<br>+ &nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), =
1 &lt;&lt; pin);<br>+ =
&nbsp;&nbsp;&nbsp;assert!(pin_changed_to(to_output, pin, =
true));<br>+<br>+ &nbsp;&nbsp;&nbsp;// Clear ODR bit: pin goes low, and =
flips back.<br>+ &nbsp;&nbsp;&nbsp;let to_low =3D =
set_odr_and_report(&amp;r, pin, 0);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), 0);<br>+ =
&nbsp;&nbsp;&nbsp;assert!(pin_changed_to(to_low, pin, =
false));<br>+}<br>+<br>+/// Helper: write one ODR bit and return the =
resulting [`PinUpdate`].<br>+fn set_odr_and_report(r: =
&amp;GpioRegisters, pin: usize, value: u32) -&gt; PinUpdate {<br>+ =
&nbsp;&nbsp;&nbsp;let old =3D r.read(REG_ODR);<br>+ =
&nbsp;&nbsp;&nbsp;r.write(REG_ODR, (old &amp; !(1 &lt;&lt; pin)) | =
(value &lt;&lt; pin))<br>+}<br>+<br>+#[test]<br>+/// Floating input: an =
external drive is reflected in IDR and reported.<br>+fn =
test_input_mode() {<br>+ &nbsp;&nbsp;&nbsp;let r =3D regs();<br>+ =
&nbsp;&nbsp;&nbsp;let pin =3D 6usize;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;set_config(&amp;r, pin, CFG_INPUT_FLOATING);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;let drive_high =3D r.gpio_set(pin, 1);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), 1 &lt;&lt; pin);<br>+ =
&nbsp;&nbsp;&nbsp;assert!(pin_changed_to(drive_high, pin, =
true));<br>+<br>+ &nbsp;&nbsp;&nbsp;let drive_low =3D r.gpio_set(pin, =
0);<br>+ &nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), 0);<br>+ =
&nbsp;&nbsp;&nbsp;assert!(pin_changed_to(drive_low, pin, =
false));<br>+}<br>+<br>+#[test]<br>+/// Input pull mode: ODR selects =
pull-up (IDR=3D1) vs pull-down (IDR=3D0),<br>+/// with no external =
driver connected.<br>+fn test_pull_up_down() {<br>+ =
&nbsp;&nbsp;&nbsp;let r =3D regs();<br>+ &nbsp;&nbsp;&nbsp;let pin =3D =
0;<br>+<br>+ &nbsp;&nbsp;&nbsp;set_odr_bit(&amp;r, pin, 1);<br>+ =
&nbsp;&nbsp;&nbsp;set_config(&amp;r, pin, CFG_INPUT_PULL);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), 1 &lt;&lt; pin);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;set_odr_bit(&amp;r, pin, 0);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), =
0);<br>+}<br>+<br>+#[test]<br>+/// BSRR sets/resets ODR bits (set has =
priority); BRR resets ODR bits.<br>+fn test_bsrr_brr() {<br>+ =
&nbsp;&nbsp;&nbsp;let r =3D regs();<br>+ &nbsp;&nbsp;&nbsp;let pin =3D =
1;<br>+<br>+ &nbsp;&nbsp;&nbsp;r.write(REG_BSRR, 1 &lt;&lt; pin);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_ODR), 1 &lt;&lt; pin);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;r.write(REG_BSRR, 1 &lt;&lt; (pin + 16));<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_ODR), 0);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;r.write(REG_BSRR, 1 &lt;&lt; pin);<br>+ =
&nbsp;&nbsp;&nbsp;r.write(REG_BRR, 1 &lt;&lt; pin);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_ODR), 0);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;// Set has priority over reset within one BSRR =
write.<br>+ &nbsp;&nbsp;&nbsp;r.write(REG_BSRR, (1 &lt;&lt; pin) | (1 =
&lt;&lt; (pin + 16)));<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_ODR), 1 &lt;&lt; =
pin);<br>+}<br>+<br>+#[test]<br>+/// A pin driven externally, then =
reconfigured as push-pull output, is<br>+/// disconnected: IDR follows =
ODR, not the stale external level.<br>+fn test_push_pull_disconnect() =
{<br>+ &nbsp;&nbsp;&nbsp;let r =3D regs();<br>+ &nbsp;&nbsp;&nbsp;let =
pin =3D 7usize;<br>+<br>+ &nbsp;&nbsp;&nbsp;// Drive high externally as =
input.<br>+ &nbsp;&nbsp;&nbsp;set_config(&amp;r, pin, =
CFG_INPUT_FLOATING);<br>+ &nbsp;&nbsp;&nbsp;r.gpio_set(pin, 1);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), 1 &lt;&lt; pin);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.disconnected_pins() &amp; (1 &lt;&lt; =
pin), 0); // now connected<br>+<br>+ &nbsp;&nbsp;&nbsp;// Reconfigure as =
push-pull output with ODR=3D0: pin must drop to 0,<br>+ =
&nbsp;&nbsp;&nbsp;// and the external driver must be disconnected.<br>+ =
&nbsp;&nbsp;&nbsp;set_odr_bit(&amp;r, pin, 0);<br>+ =
&nbsp;&nbsp;&nbsp;set_config(&amp;r, pin, CFG_OUTPUT_PP);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), 0);<br>+ =
&nbsp;&nbsp;&nbsp;assert_ne!(r.disconnected_pins() &amp; (1 &lt;&lt; =
pin), 0); // disconnected again<br>+<br>+ &nbsp;&nbsp;&nbsp;// Further =
external drives are ignored while output push-pull.<br>+ =
&nbsp;&nbsp;&nbsp;r.gpio_set(pin, 1);<br>+ =
&nbsp;&nbsp;&nbsp;assert_eq!(r.read(REG_IDR), 0);<br>+}<br>-- =
<br>2.53.0<br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_6A6F271E-A998-4CFE-A70F-ECAC3DAAFC24--

