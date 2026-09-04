Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBC3C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2QLt-0008OC-Sq; Fri, 04 Sep 2026 05:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x2QLs-0008Nv-0J; Fri, 04 Sep 2026 05:36:52 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x2QLp-0005BF-SJ; Fri, 04 Sep 2026 05:36:51 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hbrvh02GSz7wk4;
 Fri,  4 Sep 2026 11:36:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788514608;
 bh=ulRnfpzkMQVYDkb1s03I4TGsy5E7BMXQy9IMdLmrZnk=;
 h=From:Subject:Date:In-Reply-To:Cc:To:References:From;
 b=a2R5+6jNXeW0hvb/CLMumPOeWGzsl/mZuRSemxRa/qRR6XdlWf781V6NmpWUGMOod
 9z7f1CVJKLD+HrimikaQ87uJn9J61q0+/aam1jBps7/9EsQH/ah8adUTtvEKHfecqV
 fl7Jif7Cu2O+FqClLKERKW1k/PHef8DB8hrHxYzj3fA6qnmXsq3422ejUqMt7s5Ab6
 ttRgVsEYKKE0WcWWifW6vBtUb2BMqPF3ZtNLUFC5G7GRbIULfEBWBkupJM+VLQeUtc
 XA4AVOTw+1UZL5Nvv7VAinJW/rbrmoowwmNOJmCWVIFk1IgcyLD3CMHP5unjD7/pmS
 zYaL9bwqUEtQQ==
Received: from smtpclient.apple (unknown [134.206.232.123])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hbrvg52l6z7std;
 Fri,  4 Sep 2026 11:36:47 +0200 (CEST)
From: gilles grimaud <gilles.grimaud@univ-lille.fr>
Message-Id: <1CC0709A-09B0-493E-A92B-5D7978B48BFE@univ-lille.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_33D5AEF6-BED0-4D22-B65F-D44CB0A3E50E"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH RFC v2 08/30] hw/misc: add RP2040 crystal and ring
 oscillators
Date: Fri, 4 Sep 2026 11:36:37 +0200
In-Reply-To: <875x0orlup.fsf@draig.linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-9-gilles.grimaud@univ-lille.fr>
 <875x0orlup.fsf@draig.linaro.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


--Apple-Mail=_33D5AEF6-BED0-4D22-B65F-D44CB0A3E50E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> Le 2 sept. 2026 =C3=A0 12:25, Alex Benn=C3=A9e =
<alex.bennee@linaro.org> a =C3=A9crit :
>=20
> Gilles Grimaud <gilles.grimaud@univ-lille.fr =
<mailto:gilles.grimaud@univ-lille.fr>> writes:
>=20
>> From: gilles grimaud <gilles.grimaud@univ-lille.fr>
>>=20
>> Model the RP2040 XOSC and ROSC register blocks and expose their clock =
outputs. Use virtual time for the ROSC COUNT register and provide either =
QEMU guest entropy or a machine-selectable deterministic seed for =
RANDOMBIT. Add qtests for the ROSC register behavior and deterministic =
stream.
>>=20
>> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
>> ---
>> hw/arm/Kconfig                 |   2 +
>> hw/arm/raspi_pico.c            |  56 +++++
>> hw/arm/rp2040.c                |  14 +-
>> hw/misc/Kconfig                |   6 +
>> hw/misc/meson.build            |   2 +
>> hw/misc/rp2040_rosc.c          | 430 =
+++++++++++++++++++++++++++++++++
>> hw/misc/rp2040_xosc.c          | 237 ++++++++++++++++++
>> include/hw/arm/rp2040.h        |   4 +
>> include/hw/misc/rp2040_rosc.h  |  42 ++++
>> include/hw/misc/rp2040_xosc.h  |  33 +++
>> tests/qtest/meson.build        |   1 +
>> tests/qtest/rp2040-rosc-test.c | 146 +++++++++++
>> 12 files changed, 971 insertions(+), 2 deletions(-)
>> create mode 100644 hw/misc/rp2040_rosc.c
>> create mode 100644 hw/misc/rp2040_xosc.c
>> create mode 100644 include/hw/misc/rp2040_rosc.h
>> create mode 100644 include/hw/misc/rp2040_xosc.h
>> create mode 100644 tests/qtest/rp2040-rosc-test.c
>>=20
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 89c479ab6d..b55a75fd5a 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -379,10 +379,12 @@ config RP2040
>>     select ARM_V7M
>>     select PL011
>>     select RP2040_NYI
>> +    select RP2040_ROSC
>>     select RP2040_SYSCFG
>>     select RP2040_SYSINFO
>>     select RP2040_TBMAN
>>     select RP2040_VREG
>> +    select RP2040_XOSC
>>     select UNIMP
>>=20
>> config STM32F100_SOC
>> diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
>> index 2bb7d4e511..2a65176dc6 100644
>> --- a/hw/arm/raspi_pico.c
>> +++ b/hw/arm/raspi_pico.c
>> @@ -14,6 +14,7 @@
>> #include "hw/arm/rp2040.h"
>> #include "hw/core/boards.h"
>> #include "hw/core/qdev-properties.h"
>> +#include "qemu/cutils.h"
>> #include "system/address-spaces.h"
>> #include "system/system.h"
>> #include "qom/object.h"
>> @@ -28,8 +29,43 @@ struct RaspiPicoMachineState {
>>=20
>>     RP2040State soc;
>>     MemoryRegion flash;
>> +    char *rosc_random_seed;
>> +    uint64_t rosc_random_seed_value;
>> +    bool rosc_random_seed_set;
>> };
>>=20
>> +static char *raspi_pico_get_rosc_random_seed(Object *obj, Error =
**errp)
>> +{
>> +    RaspiPicoMachineState *s =3D RASPI_PICO_MACHINE(obj);
>> +
>> +    return g_strdup(s->rosc_random_seed ?: "");
>> +}
>> +
>> +static void raspi_pico_set_rosc_random_seed(Object *obj, const char =
*value,
>> +                                            Error **errp)
>> +{
>> +    RaspiPicoMachineState *s =3D RASPI_PICO_MACHINE(obj);
>> +    uint64_t seed;
>> +
>> +    if (!value || !*value) {
>> +        g_free(s->rosc_random_seed);
>> +        s->rosc_random_seed =3D NULL;
>> +        s->rosc_random_seed_value =3D 0;
>> +        s->rosc_random_seed_set =3D false;
>> +        return;
>> +    }
>> +
>> +    if (qemu_strtou64(value, NULL, 0, &seed) < 0) {
>> +        error_setg(errp, "invalid ROSC random seed '%s'", value);
>> +        return;
>> +    }
>> +
>> +    g_free(s->rosc_random_seed);
>> +    s->rosc_random_seed =3D g_strdup(value);
>=20
> Why do you need to keep the string if it is simply a representation of =
a
> uint64_t?

Agreed. I will replace it with a typed uint64 property in v3.

>=20
>> +    s->rosc_random_seed_value =3D seed;
>> +    s->rosc_random_seed_set =3D true;
>=20
> This never gets looked at.

These are passed to the ROSC from raspi_pico_init(). I will keep the
presence flag only to distinguish an unset property from an explicit
zero seed, and make that path clearer in v3.

--
Gilles Grimaud - 2XS/SISE - CRIStAL/IRCICA - CNRS/Univ. Lille =20=

--Apple-Mail=_33D5AEF6-BED0-4D22-B65F-D44CB0A3E50E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br><div><blockquote type=3D"cite"><div>Le=
 2 sept. 2026 =C3=A0 12:25, Alex Benn=C3=A9e =
&lt;alex.bennee@linaro.org&gt; a =C3=A9crit :</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Gilles Grimaud &lt;</span><a =
href=3D"mailto:gilles.grimaud@univ-lille.fr" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">gilles.grimaud@univ-lille.fr</a><span style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; writes:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;">From: gilles grimaud =
&lt;gilles.grimaud@univ-lille.fr&gt;<br><br>Model the RP2040 XOSC and =
ROSC register blocks and expose their clock outputs. Use virtual time =
for the ROSC COUNT register and provide either QEMU guest entropy or a =
machine-selectable deterministic seed for RANDOMBIT. Add qtests for the =
ROSC register behavior and deterministic stream.<br><br>Signed-off-by: =
gilles grimaud =
&lt;gilles.grimaud@univ-lille.fr&gt;<br>---<br>hw/arm/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +<br>hw/arm/raspi_pico.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;56 +++++<br>hw/arm/rp2040.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| &nbsp;14 +-<br>hw/misc/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| &nbsp;&nbsp;6 +<br>hw/misc/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;2 +<br>hw/misc/rp2040_rosc.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 430 =
+++++++++++++++++++++++++++++++++<br>hw/misc/rp2040_xosc.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 237 =
++++++++++++++++++<br>include/hw/arm/rp2040.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;4 =
+<br>include/hw/misc/rp2040_rosc.h &nbsp;| &nbsp;42 =
++++<br>include/hw/misc/rp2040_xosc.h &nbsp;| &nbsp;33 =
+++<br>tests/qtest/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 =
+<br>tests/qtest/rp2040-rosc-test.c | 146 +++++++++++<br>12 files =
changed, 971 insertions(+), 2 deletions(-)<br>create mode 100644 =
hw/misc/rp2040_rosc.c<br>create mode 100644 =
hw/misc/rp2040_xosc.c<br>create mode 100644 =
include/hw/misc/rp2040_rosc.h<br>create mode 100644 =
include/hw/misc/rp2040_xosc.h<br>create mode 100644 =
tests/qtest/rp2040-rosc-test.c<br><br>diff --git a/hw/arm/Kconfig =
b/hw/arm/Kconfig<br>index 89c479ab6d..b55a75fd5a 100644<br>--- =
a/hw/arm/Kconfig<br>+++ b/hw/arm/Kconfig<br>@@ -379,10 +379,12 @@ config =
RP2040<br>&nbsp;&nbsp;&nbsp;&nbsp;select =
ARM_V7M<br>&nbsp;&nbsp;&nbsp;&nbsp;select =
PL011<br>&nbsp;&nbsp;&nbsp;&nbsp;select RP2040_NYI<br>+ =
&nbsp;&nbsp;&nbsp;select RP2040_ROSC<br>&nbsp;&nbsp;&nbsp;&nbsp;select =
RP2040_SYSCFG<br>&nbsp;&nbsp;&nbsp;&nbsp;select =
RP2040_SYSINFO<br>&nbsp;&nbsp;&nbsp;&nbsp;select =
RP2040_TBMAN<br>&nbsp;&nbsp;&nbsp;&nbsp;select RP2040_VREG<br>+ =
&nbsp;&nbsp;&nbsp;select RP2040_XOSC<br>&nbsp;&nbsp;&nbsp;&nbsp;select =
UNIMP<br><br>config STM32F100_SOC<br>diff --git a/hw/arm/raspi_pico.c =
b/hw/arm/raspi_pico.c<br>index 2bb7d4e511..2a65176dc6 100644<br>--- =
a/hw/arm/raspi_pico.c<br>+++ b/hw/arm/raspi_pico.c<br>@@ -14,6 +14,7 =
@@<br>#include "hw/arm/rp2040.h"<br>#include =
"hw/core/boards.h"<br>#include "hw/core/qdev-properties.h"<br>+#include =
"qemu/cutils.h"<br>#include "system/address-spaces.h"<br>#include =
"system/system.h"<br>#include "qom/object.h"<br>@@ -28,8 +29,43 @@ =
struct RaspiPicoMachineState =
{<br><br>&nbsp;&nbsp;&nbsp;&nbsp;RP2040State =
soc;<br>&nbsp;&nbsp;&nbsp;&nbsp;MemoryRegion flash;<br>+ =
&nbsp;&nbsp;&nbsp;char *rosc_random_seed;<br>+ =
&nbsp;&nbsp;&nbsp;uint64_t rosc_random_seed_value;<br>+ =
&nbsp;&nbsp;&nbsp;bool rosc_random_seed_set;<br>};<br><br>+static char =
*raspi_pico_get_rosc_random_seed(Object *obj, Error **errp)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;RaspiPicoMachineState *s =3D =
RASPI_PICO_MACHINE(obj);<br>+<br>+ &nbsp;&nbsp;&nbsp;return =
g_strdup(s-&gt;rosc_random_seed ?: "");<br>+}<br>+<br>+static void =
raspi_pico_set_rosc_random_seed(Object *obj, const char *value,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error **errp)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;RaspiPicoMachineState *s =3D =
RASPI_PICO_MACHINE(obj);<br>+ &nbsp;&nbsp;&nbsp;uint64_t seed;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;if (!value || !*value) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_free(s-&gt;rosc_random_seed);<=
br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;rosc_random_seed =3D =
NULL;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;rosc_random_seed_value =3D=
 0;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;rosc_random_seed_set =3D =
false;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;if (qemu_strtou64(value, =
NULL, 0, &amp;seed) &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, "invalid ROSC =
random seed '%s'", value);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;g_free(s-&gt;rosc_random_seed);<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;rosc_random_seed =3D =
g_strdup(value);<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Why do you need to keep the string if it is =
simply a representation of a</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">uint64_t?</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote><div><br></div><div>Agreed. I will replace it =
with a typed uint64 property in v3.</div><div><br></div><blockquote =
type=3D"cite"><div><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;">+ =
&nbsp;&nbsp;&nbsp;s-&gt;rosc_random_seed_value =3D seed;<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;rosc_random_seed_set =3D =
true;<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">This never gets looked =
at.</span></div></blockquote><div><br></div><div>These are passed to the =
ROSC from raspi_pico_init(). I will keep the</div><div>presence flag =
only to distinguish an unset property from an explicit</div><div>zero =
seed, and make that path clearer in =
v3.</div><div><br></div></div>--<br>Gilles Grimaud - 2XS/SISE - =
CRIStAL/IRCICA -&nbsp;CNRS/Univ. Lille &nbsp;</body></html>=

--Apple-Mail=_33D5AEF6-BED0-4D22-B65F-D44CB0A3E50E--

