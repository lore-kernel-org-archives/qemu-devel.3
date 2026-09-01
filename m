Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E737C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 22:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Wj6-0002XQ-5e; Tue, 01 Sep 2026 18:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x1Wj4-0002Wf-3V; Tue, 01 Sep 2026 18:13:06 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x1Wj1-0005Uf-2B; Tue, 01 Sep 2026 18:13:05 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hZKqX3X9Qz81N1;
 Wed,  2 Sep 2026 00:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788300776;
 bh=RDvRKY4mMTCTTrJOVKjXXs/rBSkBpVxGsTJMG59sCDk=;
 h=From:Subject:Date:In-Reply-To:Cc:To:References:From;
 b=fDG1jdt3aXS9G/wdnuPwE9p1nO+t/6/f60cI+5TN/002yVcWnltcVzvzImmVWjaa5
 ROROwCriybUs2zRo9mOEOcBFg4spKrllJAzmhuSj4YoPPqoG69JDLnk2mzSB/Ij3Ol
 t40yWPRntTI+uiBZeSbFLHtl3NAU1v0Eid1h+BW1rqzHBPSSCycAo82mWwEB4oA4TT
 iPUKq4K+D+kp8noitZyNNV/oYbwATy5Ph7wTaHQV9M9s49VYyy6RgN3bGCSfIK/rSg
 wwx7XHtpJRklmY0lPC9LX0QqUjg3y3AUaerNvxDVWt7ZBTS6S3ueZhXEDwGiX5494i
 acTZKC/u7qXGw==
Received: from smtpclient.apple (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4hZKqX1zC9z6tpV;
 Wed,  2 Sep 2026 00:12:56 +0200 (CEST)
From: gilles grimaud <gilles.grimaud@univ-lille.fr>
Message-Id: <470BA89A-6FE4-4741-AA30-CE7C1C8E162E@univ-lille.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_DA9B7C27-23DF-4DA8-B30A-B30807CFC484"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH RFC v2 03/30] hw/misc: add RP2040 diagnostic helpers
Date: Wed, 2 Sep 2026 00:12:46 +0200
In-Reply-To: <87qzjcu8ni.fsf@draig.linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-4-gilles.grimaud@univ-lille.fr>
 <87qzjcu8ni.fsf@draig.linaro.org>
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


--Apple-Mail=_DA9B7C27-23DF-4DA8-B30A-B30807CFC484
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Alex,

Thanks, I agree that the shared diagnostic layer is unnecessary.

I will drop this patch, including its Kconfig symbol. Completely
unimplemented MMIO regions will continue to use
TYPE_UNIMPLEMENTED_DEVICE, while partial device models will use local
qemu_log_mask(LOG_UNIMP, ...) calls where a diagnostic remains useful.

Those diagnostics will therefore be introduced together with the device
that owns the corresponding register or behavior.

Thanks,
--
Gilles Grimaud - 2XS/SISE - CRIStAL/IRCICA - CNRS/Univ. Lille =20



> Le 1 sept. 2026 =C3=A0 20:30, Alex Benn=C3=A9e =
<alex.bennee@linaro.org> a =C3=A9crit :
>=20
> Gilles Grimaud <gilles.grimaud@univ-lille.fr =
<mailto:gilles.grimaud@univ-lille.fr>> writes:
>=20
>> From: gilles grimaud <gilles.grimaud@univ-lille.fr =
<mailto:gilles.grimaud@univ-lille.fr>>
>>=20
>> Add shared helpers for reporting unimplemented RP2040 features and =
register accesses. Keeping the formatting in one place makes shallow =
peripheral models explicit and gives their diagnostics a consistent =
component, address, offset and value format.
>>=20
>> Add a dedicated Kconfig symbol so the helpers remain disabled until
>> selected by the RP2040 SoC.
>=20
> This seems over-engineered. What is wrong with:
>=20
>  qemu_log_mask(LOG_UNIMP, "%s: ....", __func__, ...);
>=20
> In the various call sites. Most of the funcs seem to be prefixed =
anyway.
>=20
> In the meantime you can instantiate TYPE_UNIMPLEMENTED_DEVICE for any
> memory regions you have no implementation for.
>=20
>>=20
>> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
>> ---
>> MAINTAINERS                  |  7 ++++++
>> hw/misc/Kconfig              |  3 +++
>> hw/misc/meson.build          |  1 +
>> hw/misc/rp2040_nyi.c         | 47 =
++++++++++++++++++++++++++++++++++++
>> include/hw/misc/rp2040_nyi.h | 19 +++++++++++++++
>> 5 files changed, 77 insertions(+)
>> create mode 100644 hw/misc/rp2040_nyi.c
>> create mode 100644 include/hw/misc/rp2040_nyi.h
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 55f6f2e3c0..db641d9c4c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1035,6 +1035,13 @@ F: docs/system/arm/raspi.rst
>> F: tests/functional/arm/test_raspi2.py
>> F: tests/functional/aarch64/test_raspi*.py
>>=20
>> +Raspberry Pi Pico / RP2040
>> +M: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
>> +L: qemu-arm@nongnu.org
>> +S: Maintained
>> +F: hw/*/rp2040*
>> +F: include/hw/*/rp2040*
>> +
>> Real View
>> M: Peter Maydell <peter.maydell@linaro.org>
>> L: qemu-arm@nongnu.org
>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> index 46e3c03cc8..de7a0f56fa 100644
>> --- a/hw/misc/Kconfig
>> +++ b/hw/misc/Kconfig
>> @@ -101,6 +101,9 @@ config FSL_IMX8MP_ANALOG
>> config FSL_IMX8MP_CCM
>>     bool
>>=20
>> +config RP2040_NYI
>> +    bool
>> +
>> config STM32_RCC
>>     bool
>>=20
>> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
>> index 54e07aacda..8611d59437 100644
>> --- a/hw/misc/meson.build
>> +++ b/hw/misc/meson.build
>> @@ -98,6 +98,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>>   'bcm2835_cprman.c',
>>   'bcm2835_powermgt.c',
>> ))
>> +system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: =
files('rp2040_nyi.c'))
>> system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
>> system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
>> system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: =
files('xlnx-zynq-ddrc.c'))
>> diff --git a/hw/misc/rp2040_nyi.c b/hw/misc/rp2040_nyi.c
>> new file mode 100644
>> index 0000000000..7e9e4c09a1
>> --- /dev/null
>> +++ b/hw/misc/rp2040_nyi.c
>> @@ -0,0 +1,47 @@
>> +/*
>> + * RP2040 "not yet implemented" diagnostics
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/misc/rp2040_nyi.h"
>> +#include "qemu/log.h"
>> +
>> +void rp2040_log_nyi(const char *component, const char *feature,
>> +                    const char *detail)
>> +{
>> +    if (g_str_has_prefix(component, "rp2040.")) {
>> +        component +=3D strlen("rp2040.");
>> +    }
>> +
>> +    qemu_log_mask(LOG_UNIMP, "Not yet implemented: rp2040.%s: =
%s%s%s\n",
>> +                  component, feature, detail ? ": " : "",
>> +                  detail ? detail : "");
>> +}
>> +
>> +void rp2040_log_unimplemented_read(const char *component, unsigned =
size,
>> +                                   uint64_t addr, uint64_t offset,
>> +                                   uint64_t value)
>> +{
>> +    char detail[128];
>> +
>> +    snprintf(detail, sizeof(detail),
>> +             "size %u, addr 0x%08" PRIx64 ", offset 0x%04" PRIx64
>> +             " -> 0x%0*" PRIx64,
>> +             size, addr, offset, size << 1, value);
>> +    rp2040_log_nyi(component, "unimplemented read", detail);
>> +}
>> +
>> +void rp2040_log_unimplemented_write(const char *component, unsigned =
size,
>> +                                    uint64_t addr, uint64_t offset,
>> +                                    uint64_t value)
>> +{
>> +    char detail[128];
>> +
>> +    snprintf(detail, sizeof(detail),
>> +             "size %u, addr 0x%08" PRIx64 ", offset 0x%04" PRIx64
>> +             ", value 0x%0*" PRIx64,
>> +             size, addr, offset, size << 1, value);
>> +    rp2040_log_nyi(component, "unimplemented write", detail);
>> +}
>> diff --git a/include/hw/misc/rp2040_nyi.h =
b/include/hw/misc/rp2040_nyi.h
>> new file mode 100644
>> index 0000000000..c23805973b
>> --- /dev/null
>> +++ b/include/hw/misc/rp2040_nyi.h
>> @@ -0,0 +1,19 @@
>> +/*
>> + * RP2040 "not yet implemented" diagnostics
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_MISC_RP2040_NYI_H
>> +#define HW_MISC_RP2040_NYI_H
>> +
>> +void rp2040_log_nyi(const char *component, const char *feature,
>> +                    const char *detail);
>> +void rp2040_log_unimplemented_read(const char *component, unsigned =
size,
>> +                                   uint64_t addr, uint64_t offset,
>> +                                   uint64_t value);
>> +void rp2040_log_unimplemented_write(const char *component, unsigned =
size,
>> +                                    uint64_t addr, uint64_t offset,
>> +                                    uint64_t value);
>> +
>> +#endif
>=20
> --=20


--Apple-Mail=_DA9B7C27-23DF-4DA8-B30A-B30807CFC484
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div>Hi =
Alex,</div><div><br></div><div>Thanks, I agree that the shared =
diagnostic layer is unnecessary.</div><div><br></div><div>I will drop =
this patch, including its Kconfig symbol. =
Completely</div><div>unimplemented MMIO regions will continue to =
use</div><div>TYPE_UNIMPLEMENTED_DEVICE, while partial device models =
will use local</div><div>qemu_log_mask(LOG_UNIMP, ...) calls where a =
diagnostic remains useful.</div><div><br></div><div>Those diagnostics =
will therefore be introduced together with the device</div><div>that =
owns the corresponding register or =
behavior.</div><div><br></div><div>Thanks,</div><div>--</div><div><div>Gil=
les Grimaud - 2XS/SISE - CRIStAL/IRCICA -&nbsp;CNRS/Univ. =
Lille&nbsp;&nbsp;</div><div><br></div><br =
class=3D"Apple-interchange-newline">
</div>
<div><br><blockquote type=3D"cite"><div>Le 1 sept. 2026 =C3=A0 20:30, =
Alex Benn=C3=A9e &lt;alex.bennee@linaro.org&gt; a =C3=A9crit :</div><br =
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
solid;">From: gilles grimaud &lt;<a =
href=3D"mailto:gilles.grimaud@univ-lille.fr">gilles.grimaud@univ-lille.fr<=
/a>&gt;<br><br>Add shared helpers for reporting unimplemented RP2040 =
features and register accesses. Keeping the formatting in one place =
makes shallow peripheral models explicit and gives their diagnostics a =
consistent component, address, offset and value format.<br><br>Add a =
dedicated Kconfig symbol so the helpers remain disabled =
until<br>selected by the RP2040 SoC.<br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">This seems over-engineered. What is wrong =
with:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
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
display: inline !important;">&nbsp;qemu_log_mask(LOG_UNIMP, "%s: ....", =
__func__, ...);</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">In the various call sites. Most of the =
funcs seem to be prefixed anyway.</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">In the meantime you can instantiate =
TYPE_UNIMPLEMENTED_DEVICE for any</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
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
display: inline !important;">memory regions you have no implementation =
for.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;"><br>Signed-off-by: gilles grimaud =
&lt;gilles.grimaud@univ-lille.fr&gt;<br>---<br>MAINTAINERS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;7 ++++++<br>hw/misc/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| &nbsp;3 +++<br>hw/misc/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;1 =
+<br>hw/misc/rp2040_nyi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 47 =
++++++++++++++++++++++++++++++++++++<br>include/hw/misc/rp2040_nyi.h | =
19 +++++++++++++++<br>5 files changed, 77 insertions(+)<br>create mode =
100644 hw/misc/rp2040_nyi.c<br>create mode 100644 =
include/hw/misc/rp2040_nyi.h<br><br>diff --git a/MAINTAINERS =
b/MAINTAINERS<br>index 55f6f2e3c0..db641d9c4c 100644<br>--- =
a/MAINTAINERS<br>+++ b/MAINTAINERS<br>@@ -1035,6 +1035,13 @@ F: =
docs/system/arm/raspi.rst<br>F: =
tests/functional/arm/test_raspi2.py<br>F: =
tests/functional/aarch64/test_raspi*.py<br><br>+Raspberry Pi Pico / =
RP2040<br>+M: Gilles Grimaud &lt;gilles.grimaud@univ-lille.fr&gt;<br>+L: =
qemu-arm@nongnu.org<br>+S: Maintained<br>+F: hw/*/rp2040*<br>+F: =
include/hw/*/rp2040*<br>+<br>Real View<br>M: Peter Maydell =
&lt;peter.maydell@linaro.org&gt;<br>L: qemu-arm@nongnu.org<br>diff --git =
a/hw/misc/Kconfig b/hw/misc/Kconfig<br>index 46e3c03cc8..de7a0f56fa =
100644<br>--- a/hw/misc/Kconfig<br>+++ b/hw/misc/Kconfig<br>@@ -101,6 =
+101,9 @@ config FSL_IMX8MP_ANALOG<br>config =
FSL_IMX8MP_CCM<br>&nbsp;&nbsp;&nbsp;&nbsp;bool<br><br>+config =
RP2040_NYI<br>+ &nbsp;&nbsp;&nbsp;bool<br>+<br>config =
STM32_RCC<br>&nbsp;&nbsp;&nbsp;&nbsp;bool<br><br>diff --git =
a/hw/misc/meson.build b/hw/misc/meson.build<br>index =
54e07aacda..8611d59437 100644<br>--- a/hw/misc/meson.build<br>+++ =
b/hw/misc/meson.build<br>@@ -98,6 +98,7 @@ system_ss.add(when: =
'CONFIG_RASPI', if_true: =
files(<br>&nbsp;&nbsp;'bcm2835_cprman.c',<br>&nbsp;&nbsp;'bcm2835_powermgt=
.c',<br>))<br>+system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: =
files('rp2040_nyi.c'))<br>system_ss.add(when: 'CONFIG_SLAVIO', if_true: =
files('slavio_misc.c'))<br>system_ss.add(when: 'CONFIG_ZYNQ', if_true: =
files('zynq_slcr.c'))<br>system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', =
if_true: files('xlnx-zynq-ddrc.c'))<br>diff --git a/hw/misc/rp2040_nyi.c =
b/hw/misc/rp2040_nyi.c<br>new file mode 100644<br>index =
0000000000..7e9e4c09a1<br>--- /dev/null<br>+++ =
b/hw/misc/rp2040_nyi.c<br>@@ -0,0 +1,47 @@<br>+/*<br>+ * RP2040 "not yet =
implemented" diagnostics<br>+ *<br>+ * SPDX-License-Identifier: =
GPL-2.0-or-later<br>+ */<br>+<br>+#include "qemu/osdep.h"<br>+#include =
"hw/misc/rp2040_nyi.h"<br>+#include "qemu/log.h"<br>+<br>+void =
rp2040_log_nyi(const char *component, const char *feature,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;const char *detail)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;if (g_str_has_prefix(component, "rp2040.")) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;component +=3D =
strlen("rp2040.");<br>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qemu_log_mask(LOG_UNIMP, "Not yet implemented: =
rp2040.%s: %s%s%s\n",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;component, feature, detail ? ": " : "",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;detail ? detail : "");<br>+}<br>+<br>+void =
rp2040_log_unimplemented_read(const char *component, unsigned size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t addr, =
uint64_t offset,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t =
value)<br>+{<br>+ &nbsp;&nbsp;&nbsp;char detail[128];<br>+<br>+ =
&nbsp;&nbsp;&nbsp;snprintf(detail, sizeof(detail),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"s=
ize %u, addr 0x%08" PRIx64 ", offset 0x%04" PRIx64<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" =
-&gt; 0x%0*" PRIx64,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;si=
ze, addr, offset, size &lt;&lt; 1, value);<br>+ =
&nbsp;&nbsp;&nbsp;rp2040_log_nyi(component, "unimplemented read", =
detail);<br>+}<br>+<br>+void rp2040_log_unimplemented_write(const char =
*component, unsigned size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t =
addr, uint64_t offset,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t =
value)<br>+{<br>+ &nbsp;&nbsp;&nbsp;char detail[128];<br>+<br>+ =
&nbsp;&nbsp;&nbsp;snprintf(detail, sizeof(detail),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"s=
ize %u, addr 0x%08" PRIx64 ", offset 0x%04" PRIx64<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",=
 value 0x%0*" PRIx64,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;si=
ze, addr, offset, size &lt;&lt; 1, value);<br>+ =
&nbsp;&nbsp;&nbsp;rp2040_log_nyi(component, "unimplemented write", =
detail);<br>+}<br>diff --git a/include/hw/misc/rp2040_nyi.h =
b/include/hw/misc/rp2040_nyi.h<br>new file mode 100644<br>index =
0000000000..c23805973b<br>--- /dev/null<br>+++ =
b/include/hw/misc/rp2040_nyi.h<br>@@ -0,0 +1,19 @@<br>+/*<br>+ * RP2040 =
"not yet implemented" diagnostics<br>+ *<br>+ * SPDX-License-Identifier: =
GPL-2.0-or-later<br>+ */<br>+<br>+#ifndef =
HW_MISC_RP2040_NYI_H<br>+#define HW_MISC_RP2040_NYI_H<br>+<br>+void =
rp2040_log_nyi(const char *component, const char *feature,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;const char *detail);<br>+void =
rp2040_log_unimplemented_read(const char *component, unsigned size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t addr, =
uint64_t offset,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t =
value);<br>+void rp2040_log_unimplemented_write(const char *component, =
unsigned size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t =
addr, uint64_t offset,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t =
value);<br>+<br>+#endif<br></blockquote><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
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
display: inline !important;">--<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote></div><br></body></html>=

--Apple-Mail=_DA9B7C27-23DF-4DA8-B30A-B30807CFC484--

