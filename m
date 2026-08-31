Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5A0C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x13Dc-0003tg-EY; Mon, 31 Aug 2026 10:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1x13Db-0003tC-0K; Mon, 31 Aug 2026 10:42:39 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1x13DX-0003LV-FT; Mon, 31 Aug 2026 10:42:38 -0400
Received: from [10.1.75.105] (unknown [89.93.216.19])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id AF23DB0054E;
 Mon, 31 Aug 2026 16:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1788187350;
 bh=RCm+Q2H5Q55Q/wRYf9ExJ3E4N6JxqQxRKKtJJq7fLvs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MmDebnBZXDuef90ILGyAI0hu1cc5JJcU8F3nRVF+s2h2Z4cVIB/78+mxYsmzp6Tj+
 akCX394u/fMk0JvCeZWc0wt5k/yL2HW1DAeg6dYL0Jipb/FcurNMczrCBZ/pTFCmrU
 W0T1KtfBSY1ZifHD2EAEO9b9dWVBijIoKXcZKeH/dFYgHlLmb3cVMrvZO9ID3l2cQ1
 11H3N8WKtjrLdTaKYIKhNi7XN/MiOpbEPS8aB9Ilh8bNa0bs9LUNROiWp/sxc9uNZL
 vo6OLtCegpCDVw2P55SxETQrZh2KtnC/DGWKhvnNJDlUrgfdnoAgs306LkW3xjxgdn
 G0XuONbRFX1aw==
From: Emmanuel Blot <emmanuel.blot@free.fr>
To: qemu-devel@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
Subject: [PING] Re: [PATCH v2 00/25] hw/arm: Facebook SanMiguel BMC and
 TMP75-family sensors
Date: Mon, 31 Aug 2026 16:42:04 +0200
X-Mailer: MailMate (3.0r7024)
Message-ID: <8B002EB0-F9EB-45C8-B533-AB297B3AF66D@free.fr>
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_8398102A-4657-4908-812A-F2DBCF68768C_="
X-MS-Reactions: disallow
Received-SPF: pass client-ip=212.27.42.1; envelope-from=emmanuel.blot@free.fr;
 helo=smtp1-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--=_MailMate_8398102A-4657-4908-812A-F2DBCF68768C_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Gentle ping on the sensor half of this series.

The patches that need your eyes are the hw/sensor/tmp105 ones:

  01-05  cleanups: state made private to the implementation,
         parent_obj rename, Resettable conversion, fault-queue
         enforcement, temperature property description
  07     TMP75, TMP175 and LM75B variants
  08-11  qtest coverage for the above

01-05 are behaviour-preserving apart from 04, which enforces the
fault queue that was already configurable but ignored.

Happy to respin the sensor patches as their own series if that is
easier to review separately from the Aspeed board work.

Thanks,
Emmanuel


On 31 Jul 2026, at 12:44, Emmanuel Blot wrote:

> This series adds the Facebook SanMiguel BMC, promotes the
> TMP75/TMP175/LM75B sensors from generic TMP105 stand-ins to improved,
> dedicated models, and introduces the test-side plumbing needed to
> exercise real I2C devices from functional tests without hardcoding QOM
> paths.
>
> The work falls into four parts.
>
> 1. TMP* sensor models
>
> The TMP105 model was the only stand-in for a whole family of pin- and
> register-compatible parts, and several boards worked around the gap wit=
h
> private TYPE_TMP75 / TYPE_LM75 aliases that resolved back to a plain
> TMP105.
>
> The model is first cleaned up for correctness and QEMU convention. One
> of those changes touches migrated state, which gains an optional
> subsection so existing streams stay compatible.
>
> On that base, TMP75/TMP175/LM75B become variants selected by a small
> per-type class descriptor. The variant is class data, so the wire forma=
t
> is unchanged and all variants share the existing vmstate. qtest coverag=
e
> is added for the per-variant behaviour. The existing BMC boards then
> drop their local aliases and instantiate the real models.
>
> 2. SanMiguel BMC
>
> A new AST2600-based machine for the Facebook SanMiguel BMC, derived fro=
m
> its device tree. It wires up three TMP75 sensors, IO expanders, FRU
> EEPROMs, an I2C mux and an RTC across its I2C buses, and provides its
> RAM, flash and networking; the FRU EEPROMs are populated with data read=

> from physical hardware. A functional test boots the OpenBMC image and
> drives each sensor over QOM, checking the guest hwmon interface reports=

> the injected value back.
>
> 3. Python device locator
>
> A QOM path names a device by its position under the object that owns it=
,
> in enumeration order =E2=80=94 it says nothing about where the device s=
its in
> the bus topology. From a QOM path alone it is impossible to tell where =
a
> device is actually connected or what purpose it serves.
>
> DeviceLocator is a pure-Python helper that resolves a device from a
> string descriptor of its position =E2=80=94 bus, address, type, on-bus =
index =E2=80=94
> by walking the bus/device hierarchy. It uses only standard QOM queries
> over QMP: no new QEMU commands, no model changes. A self-check exercise=
s
> the grammar and its error paths against a paused SanMiguel BMC; it need=
s
> no disk image and runs in about a second.
>
> Note: the helper adopts the 3.10 type-hint syntax rather than the 3.9
> equivalents; 3.9 reached end of life on 2025-10-31. The import is
> guarded so the module still loads on 3.9 and dependent tests skip there=
=2E
>
> Two small test-framework fixes ride along: the set_machine probe VM now=

> gets the per-test workdir instead of the hardcoded /var/tmp default, an=
d
> the Aspeed OpenBMC helper can optionally assert the booted device-tree
> model.
>
> 4. Catalina follow-ups
>
> The final three commits are the tail of the earlier "hw/arm: improve
> Aspeed Catalina BMC emulation" series: functional tests for the PCA9555=

> and PCA9554 IO expanders, plus the PCA9554 change that drives its input=

> pins externally. They were held back because reaching such devices from=

> a test needs a stable way to reference them by bus position =E2=80=94 t=
he QOM
> re-parenting patch tried then was rejected, and the device locator now
> unblocks them.
>
> Based on:
>
>   repo:   https://github.com/legoater/qemu.git
>   branch: aspeed-11.1
>   commit: 04d27371e3 ("hw/arm: catalina: add NIC and FIO temperature se=
nsors")
>
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
> Changes in v2:
> - Simplify TMP105 multiple variant initialization
> - Improve reliability against malformed device locator strings
> - Remove an obsolete reference to INA23x devices from a commit log mess=
age
> - Rebase patch series on aspeed-next branch
> - Fix invalid JSON syntax in SanMiguel FRU descriptions
> - Link to v1: https://lore.kernel.org/qemu-devel/20260729-sanmiguel-bmc=
-locator-v1-0-c8f9a8d101f6@free.fr
>
> To: qemu-devel@nongnu.org
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Steven Lee <steven_lee@aspeedtech.com>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>
> Cc: Kane Chen <kane_chen@aspeedtech.com>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: qemu-arm@nongnu.org
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <th.huth+qemu@posteo.eu>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>
> ---
> Emmanuel Blot (25):
>       hw/sensor: tmp105: make device state private to the implementatio=
n
>       hw/sensor: tmp105: name the parent object field parent_obj
>       hw/sensor: tmp105: implement Resettable reset
>       hw/sensor: tmp105: enforce the configurable fault queue
>       hw/sensor: tmp105: describe the temperature property
>       hw/arm: aspeed: guard board-local temperature-sensor aliases
>       hw/sensor: tmp105: add TMP75, TMP175 and LM75B variants
>       tests/qtest: tmp105: cover the ALERT fault queue
>       tests/qtest: tmp105: cover the TMP75, TMP175 and LM75B variants
>       tests/qtest: tmp105: cover one-shot and fault-queue write immunit=
y
>       tests/qtest: tmp105: cover shutdown clearing the ALERT across var=
iants
>       hw/arm: sanmiguel: add Facebook SanMiguel BMC machine
>       hw/arm: sanmiguel: populate EEPROM data
>       hw/arm: catalina: use the real TMP75 model
>       hw/arm: fuji: use the real TMP75 and LM75B temperature sensors
>       tests/functional: aspeed: optionally check the device tree model =
on boot
>       tests/functional: give the set_machine probe VM the test workdir
>       tests/functional: add a pure-Python device-locator resolver
>       tests/functional: add a device-locator self-check
>       tests/functional: aspeed: add hwmon sensor read helpers
>       tests/functional/arm: sanmiguel: add BMC boot test
>       tests/functional/arm: catalina: test TMP75
>       tests/functional/arm: catalina: test PCA9555 IO expander via QOM
>       hw/arm: catalina: drive pca9554 io expander input pins externally=

>       tests/functional/arm: catalina: test PCA9554 IO expander via QOM
>
>  hw/arm/aspeed_ast2600_catalina.c              |  14 +-
>  hw/arm/aspeed_ast2600_fuji.c                  |  16 +-
>  hw/arm/aspeed_ast2600_sanmiguel.c             | 405 ++++++++++++++++++=

>  hw/arm/meson.build                            |   1 +
>  hw/sensor/tmp105.c                            | 304 ++++++++++---
>  include/hw/sensor/tmp105.h                    |  46 +-
>  tests/functional/arm/meson.build              |   3 +
>  tests/functional/arm/test_aspeed_catalina.py  | 107 ++++-
>  tests/functional/arm/test_aspeed_sanmiguel.py |  72 ++++
>  tests/functional/arm/test_device_locator.py   | 120 ++++++
>  tests/functional/aspeed.py                    |  21 +-
>  tests/functional/qemu_test/locator.py         | 586 ++++++++++++++++++=
++++++++
>  tests/functional/qemu_test/testcase.py        |   2 +-
>  tests/qtest/tmp105-test.c                     | 359 ++++++++++++++++
>  14 files changed, 1934 insertions(+), 122 deletions(-)
> ---
> base-commit: e5d3f5ac8633de310066f14862b17e4cac8ef8a5
> change-id: 20260729-sanmiguel-bmc-locator-db13cceae66c
>
> Best regards,
> --
> Emmanuel Blot <emmanuel.blot@free.fr>

--=_MailMate_8398102A-4657-4908-812A-F2DBCF68768C_=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8"=
>
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"markdown" sty=
le=3D"white-space: normal;">
<p dir=3D"auto">Hi Philippe,</p>
<p dir=3D"auto">Gentle ping on the sensor half of this series.</p>
<p dir=3D"auto">The patches that need your eyes are the hw/sensor/tmp105 =
ones:</p>
<p dir=3D"auto">01-05  cleanups: state made private to the implementation=
,<br>
parent_obj rename, Resettable conversion, fault-queue<br>
enforcement, temperature property description<br>
07     TMP75, TMP175 and LM75B variants<br>
08-11  qtest coverage for the above</p>
<p dir=3D"auto">01-05 are behaviour-preserving apart from 04, which enfor=
ces the<br>
fault queue that was already configurable but ignored.</p>
<p dir=3D"auto">Happy to respin the sensor patches as their own series if=
 that is<br>
easier to review separately from the Aspeed board work.</p>
<p dir=3D"auto">Thanks,<br>
Emmanuel</p>
<p dir=3D"auto">On 31 Jul 2026, at 12:44, Emmanuel Blot wrote:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">This series adds the Facebook SanMiguel BMC, promotes the=
<br>
TMP75/TMP175/LM75B sensors from generic TMP105 stand-ins to improved,<br>=

dedicated models, and introduces the test-side plumbing needed to<br>
exercise real I2C devices from functional tests without hardcoding QOM<br=
>
paths.</p>
<p dir=3D"auto">The work falls into four parts.</p>
<ol>
<li>TMP* sensor models</li>
</ol>
<p dir=3D"auto">The TMP105 model was the only stand-in for a whole family=
 of pin- and<br>
register-compatible parts, and several boards worked around the gap with<=
br>
private TYPE_TMP75 / TYPE_LM75 aliases that resolved back to a plain<br>
TMP105.</p>
<p dir=3D"auto">The model is first cleaned up for correctness and QEMU co=
nvention. One<br>
of those changes touches migrated state, which gains an optional<br>
subsection so existing streams stay compatible.</p>
<p dir=3D"auto">On that base, TMP75/TMP175/LM75B become variants selected=
 by a small<br>
per-type class descriptor. The variant is class data, so the wire format<=
br>
is unchanged and all variants share the existing vmstate. qtest coverage<=
br>
is added for the per-variant behaviour. The existing BMC boards then<br>
drop their local aliases and instantiate the real models.</p>
<ol start=3D"2">
<li>SanMiguel BMC</li>
</ol>
<p dir=3D"auto">A new AST2600-based machine for the Facebook SanMiguel BM=
C, derived from<br>
its device tree. It wires up three TMP75 sensors, IO expanders, FRU<br>
EEPROMs, an I2C mux and an RTC across its I2C buses, and provides its<br>=

RAM, flash and networking; the FRU EEPROMs are populated with data read<b=
r>
from physical hardware. A functional test boots the OpenBMC image and<br>=

drives each sensor over QOM, checking the guest hwmon interface reports<b=
r>
the injected value back.</p>
<ol start=3D"3">
<li>Python device locator</li>
</ol>
<p dir=3D"auto">A QOM path names a device by its position under the objec=
t that owns it,<br>
in enumeration order =E2=80=94 it says nothing about where the device sit=
s in<br>
the bus topology. From a QOM path alone it is impossible to tell where a<=
br>
device is actually connected or what purpose it serves.</p>
<p dir=3D"auto">DeviceLocator is a pure-Python helper that resolves a dev=
ice from a<br>
string descriptor of its position =E2=80=94 bus, address, type, on-bus in=
dex =E2=80=94<br>
by walking the bus/device hierarchy. It uses only standard QOM queries<br=
>
over QMP: no new QEMU commands, no model changes. A self-check exercises<=
br>
the grammar and its error paths against a paused SanMiguel BMC; it needs<=
br>
no disk image and runs in about a second.</p>
<p dir=3D"auto">Note: the helper adopts the 3.10 type-hint syntax rather =
than the 3.9<br>
equivalents; 3.9 reached end of life on 2025-10-31. The import is<br>
guarded so the module still loads on 3.9 and dependent tests skip there.<=
/p>
<p dir=3D"auto">Two small test-framework fixes ride along: the set_machin=
e probe VM now<br>
gets the per-test workdir instead of the hardcoded /var/tmp default, and<=
br>
the Aspeed OpenBMC helper can optionally assert the booted device-tree<br=
>
model.</p>
<ol start=3D"4">
<li>Catalina follow-ups</li>
</ol>
<p dir=3D"auto">The final three commits are the tail of the earlier &quot=
;hw/arm: improve<br>
Aspeed Catalina BMC emulation&quot; series: functional tests for the PCA9=
555<br>
and PCA9554 IO expanders, plus the PCA9554 change that drives its input<b=
r>
pins externally. They were held back because reaching such devices from<b=
r>
a test needs a stable way to reference them by bus position =E2=80=94 the=
 QOM<br>
re-parenting patch tried then was rejected, and the device locator now<br=
>
unblocks them.</p>
<p dir=3D"auto">Based on:</p>
<p dir=3D"auto">repo:   <a href=3D"https://github.com/legoater/qemu.git" =
style=3D"color: #777777;">https://github.com/legoater/qemu.git</a><br>
branch: aspeed-11.1<br>
commit: 04d27371e3 (&quot;hw/arm: catalina: add NIC and FIO temperature s=
ensors&quot;)</p>
<h2>Signed-off-by: Emmanuel Blot <a href=3D"mailto:emmanuel.blot@free.fr"=
 style=3D"color: #777777;">emmanuel.blot@free.fr</a></h2>
<p dir=3D"auto">Changes in v2:</p>
<ul>
<li>Simplify TMP105 multiple variant initialization</li>
<li>Improve reliability against malformed device locator strings</li>
<li>Remove an obsolete reference to INA23x devices from a commit log mess=
age</li>
<li>Rebase patch series on aspeed-next branch</li>
<li>Fix invalid JSON syntax in SanMiguel FRU descriptions</li>
<li>Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/20260729-sa=
nmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr" style=3D"color: #777777;">=
https://lore.kernel.org/qemu-devel/20260729-sanmiguel-bmc-locator-v1-0-c8=
f9a8d101f6@free.fr</a></li>
</ul>
<p dir=3D"auto">To: <a href=3D"mailto:qemu-devel@nongnu.org" style=3D"col=
or: #777777;">qemu-devel@nongnu.org</a><br>
Cc: Philippe Mathieu-Daud=C3=A9 <a href=3D"mailto:philmd@mailo.com" style=
=3D"color: #777777;">philmd@mailo.com</a><br>
Cc: C=C3=A9dric Le Goater <a href=3D"mailto:clg@kaod.org" style=3D"color:=
 #777777;">clg@kaod.org</a><br>
Cc: Peter Maydell <a href=3D"mailto:peter.maydell@linaro.org" style=3D"co=
lor: #777777;">peter.maydell@linaro.org</a><br>
Cc: Steven Lee <a href=3D"mailto:steven_lee@aspeedtech.com" style=3D"colo=
r: #777777;">steven_lee@aspeedtech.com</a><br>
Cc: Jamin Lin <a href=3D"mailto:jamin_lin@aspeedtech.com" style=3D"color:=
 #777777;">jamin_lin@aspeedtech.com</a><br>
Cc: Kane Chen <a href=3D"mailto:kane_chen@aspeedtech.com" style=3D"color:=
 #777777;">kane_chen@aspeedtech.com</a><br>
Cc: Andrew Jeffery <a href=3D"mailto:andrew@codeconstruct.com.au" style=3D=
"color: #777777;">andrew@codeconstruct.com.au</a><br>
Cc: Joel Stanley <a href=3D"mailto:joel@jms.id.au" style=3D"color: #77777=
7;">joel@jms.id.au</a><br>
Cc: <a href=3D"mailto:qemu-arm@nongnu.org" style=3D"color: #777777;">qemu=
-arm@nongnu.org</a><br>
Cc: Fabiano Rosas <a href=3D"mailto:farosas@suse.de" style=3D"color: #777=
777;">farosas@suse.de</a><br>
Cc: Laurent Vivier <a href=3D"mailto:lvivier@redhat.com" style=3D"color: =
#777777;">lvivier@redhat.com</a><br>
Cc: Paolo Bonzini <a href=3D"mailto:pbonzini@redhat.com" style=3D"color: =
#777777;">pbonzini@redhat.com</a><br>
Cc: Thomas Huth <a href=3D"mailto:th.huth+qemu@posteo.eu" style=3D"color:=
 #777777;">th.huth+qemu@posteo.eu</a><br>
Cc: &quot;Daniel P. Berrang=C3=A9&quot; <a href=3D"mailto:berrange@redhat=
=2Ecom" style=3D"color: #777777;">berrange@redhat.com</a></p>
<hr style=3D"border: 0; height: 1px; background: #333; background-image: =
linear-gradient(to right, #ccc, #333, #ccc);">
<p dir=3D"auto">Emmanuel Blot (25):<br>
hw/sensor: tmp105: make device state private to the implementation<br>
hw/sensor: tmp105: name the parent object field parent_obj<br>
hw/sensor: tmp105: implement Resettable reset<br>
hw/sensor: tmp105: enforce the configurable fault queue<br>
hw/sensor: tmp105: describe the temperature property<br>
hw/arm: aspeed: guard board-local temperature-sensor aliases<br>
hw/sensor: tmp105: add TMP75, TMP175 and LM75B variants<br>
tests/qtest: tmp105: cover the ALERT fault queue<br>
tests/qtest: tmp105: cover the TMP75, TMP175 and LM75B variants<br>
tests/qtest: tmp105: cover one-shot and fault-queue write immunity<br>
tests/qtest: tmp105: cover shutdown clearing the ALERT across variants<br=
>
hw/arm: sanmiguel: add Facebook SanMiguel BMC machine<br>
hw/arm: sanmiguel: populate EEPROM data<br>
hw/arm: catalina: use the real TMP75 model<br>
hw/arm: fuji: use the real TMP75 and LM75B temperature sensors<br>
tests/functional: aspeed: optionally check the device tree model on boot<=
br>
tests/functional: give the set_machine probe VM the test workdir<br>
tests/functional: add a pure-Python device-locator resolver<br>
tests/functional: add a device-locator self-check<br>
tests/functional: aspeed: add hwmon sensor read helpers<br>
tests/functional/arm: sanmiguel: add BMC boot test<br>
tests/functional/arm: catalina: test TMP75<br>
tests/functional/arm: catalina: test PCA9555 IO expander via QOM<br>
hw/arm: catalina: drive pca9554 io expander input pins externally<br>
tests/functional/arm: catalina: test PCA9554 IO expander via QOM</p>
<h2>hw/arm/aspeed_ast2600_catalina.c              |  14 +-<br>
hw/arm/aspeed_ast2600_fuji.c                  |  16 +-<br>
hw/arm/aspeed_ast2600_sanmiguel.c             | 405 ++++++++++++++++++<br=
>
hw/arm/meson.build                            |   1 +<br>
hw/sensor/tmp105.c                            | 304 ++++++++++---<br>
include/hw/sensor/tmp105.h                    |  46 +-<br>
tests/functional/arm/meson.build              |   3 +<br>
tests/functional/arm/test_aspeed_catalina.py  | 107 ++++-<br>
tests/functional/arm/test_aspeed_sanmiguel.py |  72 ++++<br>
tests/functional/arm/test_device_locator.py   | 120 ++++++<br>
tests/functional/aspeed.py                    |  21 +-<br>
tests/functional/qemu_test/locator.py         | 586 +++++++++++++++++++++=
+++++<br>
tests/functional/qemu_test/testcase.py        |   2 +-<br>
tests/qtest/tmp105-test.c                     | 359 ++++++++++++++++<br>
14 files changed, 1934 insertions(+), 122 deletions(-)</h2>
<p dir=3D"auto">base-commit: e5d3f5ac8633de310066f14862b17e4cac8ef8a5<br>=

change-id: 20260729-sanmiguel-bmc-locator-db13cceae66c</p>
<h2>Best regards,</h2>
<p dir=3D"auto">Emmanuel Blot <a href=3D"mailto:emmanuel.blot@free.fr" st=
yle=3D"color: #777777;">emmanuel.blot@free.fr</a></p>
</blockquote>

</div>
</div>
</body>

</html>

--=_MailMate_8398102A-4657-4908-812A-F2DBCF68768C_=--

