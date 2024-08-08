Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C564C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 22:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scBeV-00048G-7R; Thu, 08 Aug 2024 18:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1scBeT-00046m-AU
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 18:30:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1scBeP-0000RO-JV
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 18:30:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428243f928cso9738595e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723156228; x=1723761028; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDbWf7S+jHvhWYJgarJBEzT2BmhIx+/fg/YGtekisbM=;
 b=gKAzuRlNbxDdRiH8MVCCmKgXwMZCOmfcnkkSlh5xx22j3gtO7lWndpJ348Q3bjov08
 of5IeBBJrDJuoBc3MWrGUx3JMDshzsKY6daNVb+Jt5hreWxfWOAfx2ovXqKy0ok9dgUs
 TVQcgNyHBQN2QGYs8J4z9itIrfHAqOtVR3SVNzagwV3ca+j+8uiwywzEl+nH7s5JDpE5
 W8MTSnXs/ZMTDl4LsPflioKh1dJTyzvmUK1525Bn6Lh4ban8l8z8tNulVbEQw1gUROTM
 vUGOriGDQLCAo2UlcAGxeKDOlqrwYtu1Fvg7I0mK6SocXyCcBoxaMKrv6iQyDuYQa+dV
 tcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723156228; x=1723761028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDbWf7S+jHvhWYJgarJBEzT2BmhIx+/fg/YGtekisbM=;
 b=H1E9RK0lhF5TogpivE8OXlOccITZf4yeJLbOjjzpHRziv/93ahXCifuf5mJW9VVkFV
 4l1YV8b/aKEWXLyMZ2lgbtr1th9USmOxSqa3HEbie3BpHUC0GF8IErY4bEX9SHmNXhic
 gWyPsmz3IhZbhEx5AbFKT9FHbMZkTlCHZJt8nMjryShmGQa9A9S9M4rv9OHYcYVbblty
 0tLHpU0LcOBX/Wyw/a7ssNkBpiskIbCKqAnBtbz/9yyrqNkEQoC2MUm36+KYgYCKfefZ
 IFQJ8FZcBZ565AZA03E3bi9goSznjZB9zIk5iiomF40txZEewcoYGgHxaefMh2yvm+q2
 5UGQ==
X-Gm-Message-State: AOJu0YyS+W+ohRQVfLSdzD6QAtiBKDJUgiHY1v5oVsaIe58fYSb/RFp4
 Nh17nx8aOpHOocHnW4CHhGVNXksW37kCZa2EzIjRLFY/ceU+yYOA+c7HHl7u1xtvsLloB8rJN7t
 Ki4gMtyP4VLAWhRKEUHAYG9dYXmbTTWQIpBob
X-Google-Smtp-Source: AGHT+IEqnvJN5Y8sJ84Lt3EX/WIwzzjj2cRxrnhn3i4tWNpHYPWHvOioRenvD2KjlQYtlcy2wzpsA57W8LwBT5yL5y8=
X-Received: by 2002:a05:600c:1f93:b0:426:647b:1bf7 with SMTP id
 5b1f17b1804b1-4290af18b73mr28261325e9.32.1723156227477; Thu, 08 Aug 2024
 15:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
 <CAFn=p-abeXP+dUtp_gwH3dcD5DT-sTAFg=udVugrzcU1r8fXpA@mail.gmail.com>
In-Reply-To: <CAFn=p-abeXP+dUtp_gwH3dcD5DT-sTAFg=udVugrzcU1r8fXpA@mail.gmail.com>
From: Octavian Purdila <tavip@google.com>
Date: Thu, 8 Aug 2024 15:30:16 -0700
Message-ID: <CAGWr4cQL_LMWmEUdoPprRSp2k=CkQ0UJp5Q45qbAtUvvE6fDHg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, alistair@alistair23.me, 
 berrange@redhat.com, philmd@linaro.org, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=tavip@google.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 8, 2024 at 2:56=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
>
>
> On Mon, Aug 5, 2024 at 4:17=E2=80=AFPM Octavian Purdila <tavip@google.com=
> wrote:
>>
>> From: Stefan Stanacar <stefanst@google.com>
>>
>> From: Stefan Stanacar <stefanst@google.com>
>>
>> The CMSIS System View Description format(CMSIS-SVD) is an XML based
>> description of Arm Cortex-M microcontrollers provided and maintained
>> by sillicon vendors. It includes details such as peripherals registers
>> (down to bitfields), peripheral register block addresses, reset
>> values, etc.
>>
>> This script uses this information to create header files that makes it
>> easier to emulate peripherals.
>>
>> The script can be used to create either peripheral specific headers or
>> board / system specific information. The script generated headers are
>> similar to the SVDConv utility.
>>
>> Peripheral specific headers contains information such as register
>> layout, register names and reset values for registers:
>>
>>   typedef struct {
>>     ...
>>     union {
>>       uint32_t PSELID;              /* 0x00000FF8 Peripheral Select and
>>                                      * Flexcomm module ID */
>>       struct {
>>         uint32_t PERSEL : 3;        /* [2..0] Peripheral Select */
>>         uint32_t LOCK : 1;          /* [3..3] Lock the peripheral select=
 */
>>         uint32_t USARTPRESENT : 1;  /* [4..4] USART present indicator */
>>         uint32_t SPIPRESENT : 1;    /* [5..5] SPI present indicator */
>>         uint32_t I2CPRESENT : 1;    /* [6..6] I2C present indicator */
>>         uint32_t I2SPRESENT : 1;    /* [7..7] I2S Present */
>>         uint32_t : 4;
>>         uint32_t ID : 20;           /* [31..12] Flexcomm ID */
>>       } PSELID_b;
>>     };
>>     ...
>>   } FLEXCOMM_Type;                  /* Size =3D 4096 (0x1000) */
>>
>>   #define FLEXCOMM_PSELID_PERSEL_Pos (0UL)
>>   #define FLEXCOMM_PSELID_PERSEL_Msk (0x7UL)
>>   #define FLEXCOMM_PSELID_LOCK_Pos (3UL)
>>   #define FLEXCOMM_PSELID_LOCK_Msk (0x8UL)
>>   ...
>>
>>   typedef enum {                /* FLEXCOMM_PSELID_LOCK */
>>     /* Peripheral select can be changed by software. */
>>     FLEXCOMM_PSELID_LOCK_UNLOCKED =3D 0,
>>     /* Peripheral select is locked and cannot be changed until this
>>      * Flexcomm module or the entire device is reset. */
>>     FLEXCOMM_PSELID_LOCK_LOCKED =3D 1,
>>   } FLEXCOMM_PSELID_LOCK_Enum;
>>   ...
>>
>>   #define FLEXCOMM_REGISTER_NAMES_ARRAY(_name) \
>>     const char *_name[sizeof(FLEXCOMM_Type)] =3D { \
>>         [4088 ... 4091] =3D "PSELID", \
>>         [4092 ... 4095] =3D "PID", \
>>     }
>>
>> Board specific headers contains information about peripheral base
>> register addresses.
>>
>> Signed-off-by: Stefan Stanacar <stefanst@google.com>
>> Signed-off-by: Octavian Purdila <tavip@google.com>
>> ---
>>  configure                 |   2 +-
>>  meson.build               |   4 +
>>  python/setup.cfg          |   1 +
>>  python/tests/minreqs.txt  |   3 +
>>  pythondeps.toml           |   3 +
>>  scripts/svd-gen-header.py | 342 ++++++++++++++++++++++++++++++++++++++
>>  6 files changed, 354 insertions(+), 1 deletion(-)
>>  create mode 100755 scripts/svd-gen-header.py
>>
>> diff --git a/configure b/configure
>> index 5ad1674ca5..811bfa5d54 100755
>> --- a/configure
>> +++ b/configure
>> @@ -956,7 +956,7 @@ mkvenv=3D"$python ${source_path}/python/scripts/mkve=
nv.py"
>>  # Finish preparing the virtual environment using vendored .whl files
>>
>>  $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
>> -     ${source_path}/pythondeps.toml meson || exit 1
>> +     ${source_path}/pythondeps.toml meson svd-gen-header || exit 1
>

Hi John,

Thanks for reviewing!

>
> I haven't read the rest of this series; I'm chiming in solely from the bu=
ild/python maintainer angle. Do we *always* need pysvd, no matter how QEMU =
was configured? Adding it to the meson line here is a very big hammer.
>

I think the minimum we can do is to install it only if CONFIG_ARM is
enabled. That might change in the future if the models we create with
pysvd are enabled for other architectures.

> If not, consider looking at how sphinx (the "docs" group) is only conditi=
onally installed into the configure venv and mimic that using the appropria=
te configure flags that necessitate the availability of pyvsd for the QEMU =
build.

Thanks for the pointer, I'll take a look.

>
> We also need to provide a way for pysvd to be available offline; some pac=
kages are available via distro libs and if this package is available for ev=
ery distro we officially support, that's sufficient (but requires updates t=
o our various docker and VM test configuration files to add the new depende=
ncy). Otherwise, like we do for meson, we need to vendor the wheel in the t=
ree so offline tarball builds will continue to work.
>
> It looks like pysvd is a pure python package with no dependencies, so it =
should be OK to vendor it in qemu.git/python/wheels/ - look at qemu.git/pyt=
hon/scripts/vendor.py and consider updating and running this script.

Thanks, I'll look at it and add it in v2.

>
> (The real blocker here is that RPM builds are performed offline and depen=
dencies that cannot be satisfied via rpm can't be added through pip. We nee=
d any one of these to be true: (A) pyvsd is available (of a sufficient vers=
ion) in all distro repositories we target; (B) This build feature is condit=
ional and nobody minds if it never gets enabled for RPM builds; (C) The pac=
kage can be vendored.)
>
> ~~js
>
> That said, you might be the first person I've seen outside of Paolo and I=
 to brave mucking around with the python build venv. You deserve a bravery =
sticker :)
>
>>
>>  # At this point, we expect Meson to be installed and available.
>>  # We expect mkvenv or pip to have created pyvenv/bin/meson for us.
>> diff --git a/meson.build b/meson.build
>> index ec59effca2..dee587483b 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3235,6 +3235,10 @@ tracetool_depends =3D files(
>>    'scripts/tracetool/vcpu.py'
>>  )
>>
>> +svd_gen_header =3D [
>> +  python, files('scripts/svd-gen-header.py')
>> +]
>> +
>>  qemu_version_cmd =3D [find_program('scripts/qemu-version.sh'),
>>                      meson.current_source_dir(),
>>                      get_option('pkgversion'), meson.project_version()]
>> diff --git a/python/setup.cfg b/python/setup.cfg
>> index 48668609d3..bc830c541a 100644
>> --- a/python/setup.cfg
>> +++ b/python/setup.cfg
>> @@ -45,6 +45,7 @@ devel =3D
>>      urwid >=3D 2.1.2
>>      urwid-readline >=3D 0.13
>>      Pygments >=3D 2.9.0
>> +    pysvd >=3D 0.2.3
>>
>>  # Provides qom-fuse functionality
>>  fuse =3D
>> diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
>> index a3f423efd8..7993fcd23c 100644
>> --- a/python/tests/minreqs.txt
>> +++ b/python/tests/minreqs.txt
>> @@ -22,6 +22,9 @@ distlib=3D=3D0.3.6
>>  # Dependencies for FUSE support for qom-fuse
>>  fusepy=3D=3D2.0.4
>>
>> +# Dependencies for svd-gen-regs
>> +pysvd=3D=3D0.2.3
>> +
>>  # Test-runners, utilities, etc.
>>  avocado-framework=3D=3D90.0
>>
>> diff --git a/pythondeps.toml b/pythondeps.toml
>> index 9c16602d30..8416b17650 100644
>> --- a/pythondeps.toml
>> +++ b/pythondeps.toml
>> @@ -32,3 +32,6 @@ sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", install=
ed =3D "1.1.1" }
>>  # avocado-framework, for example right now the limit is 92.x.
>>  avocado-framework =3D { accepted =3D "(>=3D88.1, <93.0)", installed =3D=
 "88.1", canary =3D "avocado" }
>>  pycdlib =3D { accepted =3D ">=3D1.11.0" }
>> +
>> +[svd-gen-header]
>> +pysvd =3D { accepted =3D ">=3D0.2.3.", installed =3D "0.2.3" }
>> diff --git a/scripts/svd-gen-header.py b/scripts/svd-gen-header.py
>> new file mode 100755
>> index 0000000000..ab8cb4b665
>> --- /dev/null
>> +++ b/scripts/svd-gen-header.py
>> @@ -0,0 +1,342 @@
>> +#!/usr/bin/env python3
>> +
>> +# Copyright 2024 Google LLC
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>> +# See the COPYING file in the top-level directory.
>> +#
>> +# Use this script to generate a C header file from an SVD xml
>> +#
>> +# Two mode of operations are supported: peripheral and system.
>> +#
>> +# When running in peripheral mode a header for a specific peripheral
>> +# is going to be generated. It will define a type and structure with
>> +# all of the available registers at the bitfield level. An array that
>> +# contains the reigster names indexed by address is also going to be
>> +# generated as well as a function to initialize registers to their
>> +# reset values.
>> +#
>> +# Invocation example:
>> +#
>> +# svd_gen_header -i MIMXRT595S_cm33.xml -o flexcomm.h -p FLEXCOMM0 -t F=
LEXCOMM
>> +#
>> +# When running in system mode a header for a specific system /
>> +# platform will be generated. It will define register base addresses
>> +# and interrupt numbers for selected peripherals.
>> +#
>> +# Invocation example:
>> +#
>> +# svd_gen_header -i MIMXRT595S_cm33.xml -o rt500.h -s RT500 -p FLEXCOMM=
0 \
>> +#                -p CLKCTL0 -p CLKCTL1
>> +#
>> +
>> +import argparse
>> +import datetime
>> +import re
>> +import os
>> +import sys
>> +import xml.etree.ElementTree
>> +import pysvd
>> +
>> +data_type_by_bits =3D {
>> +    8: "uint8_t",
>> +    16: "uint16_t",
>> +    32: "uint32_t",
>> +}
>> +
>> +
>> +def get_register_array_name_and_size(register):
>> +    """Return register name and register array size.
>> +
>> +    The SVD can define register arrays and pysvd encodes the whole set
>> +    as as regular register with their name prepended by [<array size>].
>> +
>> +    Returns a tuple with the register name and the size of the array or
>> +    zero if this is not a register set.
>> +
>> +    """
>> +
>> +    split =3D re.split(r"[\[\]]", register.name)
>> +    return (split[0], int(split[1]) if len(split) > 1 else 0)
>> +
>> +
>> +def generate_register(register):
>> +    """Generate register data.
>> +
>> +    This include a field for accessing the full 32bits as we as
>> +    bitfield based register fields.
>> +
>> +    """
>> +
>> +    data_type =3D data_type_by_bits[register.size]
>> +
>> +    out =3D f"    /* 0x{register.addressOffset:08X} {register.descripti=
on} */\n"
>> +    out +=3D "    union {\n"
>> +    out +=3D f"        {data_type} {register.name};\n"
>> +    out +=3D "        struct {\n"
>> +
>> +    fields =3D sorted(register.fields, key=3Dlambda field: field.bitOff=
set)
>> +    last_msb =3D -1
>> +    for field in fields:
>> +        reserve_bits =3D 0
>> +        lsb =3D field.bitOffset
>> +        msb =3D field.bitWidth + lsb - 1
>> +
>> +        if last_msb =3D=3D -1 and lsb > 0:
>> +            reserve_bits =3D lsb
>> +
>> +        if last_msb !=3D -1 and (lsb - last_msb) > 1:
>> +            reserve_bits =3D lsb - last_msb - 1
>> +
>> +        if reserve_bits > 0:
>> +            out +=3D f"            {data_type}:{reserve_bits};\n"
>> +
>> +        out +=3D f"            /* [{msb}..{lsb}] {field.description} */=
\n"
>> +        out +=3D f"            {data_type} {field.name} : {field.bitWid=
th};\n"
>> +
>> +        last_msb =3D msb
>> +
>> +    if register.size - last_msb > 1:
>> +        out +=3D f"            {data_type}:{register.size - last_msb - =
1};\n"
>> +
>> +    reg_name, reg_array_size =3D get_register_array_name_and_size(regis=
ter)
>> +    if reg_array_size > 0:
>> +        out +=3D f"        }} {reg_name}_b[{reg_array_size}];\n"
>> +    else:
>> +        out +=3D f"        }} {reg_name}_b;\n"
>> +    out +=3D "    };\n\n"
>> +
>> +    return out
>> +
>> +
>> +def generate_pos_and_msk_defines(name, periph):
>> +    """Generate Pos and Msk defines"""
>> +
>> +    out =3D "\n"
>> +    for reg in periph.registers:
>> +        for field in reg.fields:
>> +            reg_name, _ =3D get_register_array_name_and_size(reg)
>> +            field_name =3D f"{name}_{reg_name}_{field.name}"
>> +            out +=3D f"#define {field_name}_Pos ({field.bitOffset}UL)\n=
"
>> +            mask =3D ((1 << field.bitWidth) - 1) << field.bitOffset
>> +            out +=3D f"#define {field_name}_Msk (0x{mask:x}UL)\n"
>> +
>> +    return out
>> +
>> +
>> +def generate_enum_values(name, periph):
>> +    """Generate enum values"""
>> +
>> +    out =3D "\n"
>> +    for reg in periph.registers:
>> +        reg_name, _ =3D get_register_array_name_and_size(reg)
>> +        for field in reg.fields:
>> +            if hasattr(field, "enumeratedValues"):
>> +                out +=3D "\n"
>> +                out +=3D "typedef enum {\n"
>> +                for enum in field.enumeratedValues.enumeratedValues:
>> +                    enum_name =3D f"{name}_{reg_name}_{field.name}_{enu=
m.name}"
>> +                    out +=3D f"    /* {enum.description} */\n"
>> +                    out +=3D f"    {enum_name} =3D {enum.value},\n"
>> +                out +=3D f"}} {name}_{reg_name}_{field.name}_Enum;\n"
>> +
>> +    return out
>> +
>> +
>> +def generate_register_names_array_macro(name, periph):
>> +    """Generate register names array macro"""
>> +
>> +    out =3D f"#define {name}_REGISTER_NAMES_ARRAY(_name) \\\n"
>> +    out +=3D f"    const char *_name[sizeof({name}_Type)] =3D {{ \\\n"
>> +    for reg in periph.registers:
>> +        reg_name, reg_array_size =3D get_register_array_name_and_size(r=
eg)
>> +        if reg_array_size > 0:
>> +            for i in range(0, reg_array_size):
>> +                start =3D reg.addressOffset + i * reg.size // 8
>> +                stop =3D reg.addressOffset + (i + 1) * reg.size // 8 - =
1
>> +                out +=3D f'        [{start} ... {stop}] =3D "{reg_name}=
{i}", \\\n'
>> +        else:
>> +            start =3D reg.addressOffset
>> +            stop =3D reg.addressOffset + reg.size // 8 - 1
>> +            out +=3D f'        [{start} ... {stop}] =3D "{reg.name}", \=
\\n'
>> +    out +=3D "    }\n"
>> +
>> +    return out
>> +
>> +
>> +def generate_reset_registers_function(name, periph):
>> +    """Generate reset registers function"""
>> +
>> +    out =3D "\n"
>> +    fname =3D f"{name.lower()}_reset_registers"
>> +    out +=3D f"static inline void {fname}({name}_Type *regs)\n"
>> +    out +=3D "{\n"
>> +    for reg in periph.registers:
>> +        reg_name, reg_array_size =3D get_register_array_name_and_size(r=
eg)
>> +        if reg_array_size > 0:
>> +            for i in range(0, int(reg_array_size)):
>> +                out +=3D f"    regs->{reg_name}[{i}] =3D {hex(reg.reset=
Value)};\n"
>> +        else:
>> +            out +=3D f"    regs->{reg_name} =3D {hex(reg.resetValue)};\=
n"
>> +    out +=3D "}\n"
>> +
>> +    return out
>> +
>> +
>> +def generate_peripheral_header(periph, name):
>> +    """Generate peripheral header
>> +
>> +    The following information is generated:
>> +
>> +    * typedef with all of the available registers and register fields,
>> +    position and mask defines for register fields.
>> +
>> +    * enum values that encode register fields options.
>> +
>> +    * a macro that defines the register names indexed by the relative
>> +    address of the register.
>> +
>> +    * a function that sets the registers to their reset values
>> +
>> +    """
>> +
>> +    out =3D f"/* {name} - {periph.description} */\n\n"
>> +    out +=3D "typedef struct {\n"
>> +
>> +    last_reg_offset =3D 0
>> +    cnt =3D 0
>> +    for reg in periph.registers:
>> +        reserved_words =3D 0
>> +        if (reg.addressOffset - last_reg_offset) > 0:
>> +            reserved_words =3D int((reg.addressOffset - last_reg_offset=
) // 4)
>> +            cnt +=3D 1
>> +
>> +        if cnt:
>> +            show_count =3D cnt
>> +        else:
>> +            show_count =3D ""
>> +
>> +        if reserved_words =3D=3D 1:
>> +            out +=3D f"    uint32_t RESERVED{show_count};\n\n"
>> +        elif reserved_words > 1:
>> +            out +=3D f"    uint32_t RESERVED{show_count}[{reserved_word=
s}];\n\n"
>> +
>> +        out +=3D generate_register(reg)
>> +        last_reg_offset =3D reg.addressOffset + reg.size // 8
>> +
>> +    size =3D periph.addressBlocks[0].size
>> +    out +=3D f"}} {name}_Type; /* Size =3D {size} (0x{size:X}) */\n"
>> +
>> +    out +=3D "\n\n"
>> +
>> +    out +=3D generate_pos_and_msk_defines(name, periph)
>> +
>> +    out +=3D generate_enum_values(name, periph)
>> +
>> +    out +=3D generate_register_names_array_macro(name, periph)
>> +
>> +    out +=3D generate_reset_registers_function(name, periph)
>> +
>> +    return out
>> +
>> +
>> +def get_same_class_peripherals(svd, periph):
>> +    """Get a list of peripherals that are instances of the same class."=
""
>> +
>> +    return [periph] + [
>> +        p
>> +        for p in svd.peripherals
>> +        if p.derivedFrom and p.derivedFrom.name =3D=3D periph.name
>> +    ]
>> +
>> +
>> +def generate_system_header(system, svd, periph):
>> +    """Generate base and irq defines for given list of peripherals"""
>> +
>> +    out =3D ""
>> +
>> +    for p in get_same_class_peripherals(svd, periph):
>> +        out +=3D f"#define {system}_{p.name}_BASE 0x{p.baseAddress:X}UL=
\n"
>> +    out +=3D "\n"
>> +
>> +    for p in get_same_class_peripherals(svd, periph):
>> +        for irq in p.interrupts:
>> +            out +=3D f"#define {system}_{irq.name}_IRQn 0x{irq.value}UL=
\n"
>> +    out +=3D "\n"
>> +
>> +    return out
>> +
>> +
>> +def main():
>> +    """Script to generate C header file from an SVD file"""
>> +
>> +    parser =3D argparse.ArgumentParser()
>> +    parser.add_argument(
>> +        "-i", "--input", type=3Dstr, help=3D"Input SVD file", required=
=3DTrue
>> +    )
>> +    parser.add_argument(
>> +        "-o", "--output", type=3Dstr, help=3D"Output .h file", required=
=3DTrue
>> +    )
>> +    parser.add_argument(
>> +        "-p",
>> +        "--peripheral",
>> +        action=3D"append",
>> +        help=3D"peripheral name from the SVD file",
>> +        required=3DTrue,
>> +    )
>> +    parser.add_argument(
>> +        "-t",
>> +        "--type-name",
>> +        type=3Dstr,
>> +        help=3D"name to be used for peripheral definitions",
>> +        required=3DFalse,
>> +    )
>> +    parser.add_argument(
>> +        "-s",
>> +        "--system",
>> +        type=3Dstr,
>> +        help=3D"name to be used for the system definitions",
>> +        required=3DFalse,
>> +    )
>> +
>> +    args =3D parser.parse_args()
>> +
>> +    node =3D xml.etree.ElementTree.parse(args.input).getroot()
>> +    svd =3D pysvd.element.Device(node)
>> +
>> +    # Write license header
>> +    out =3D "/*\n"
>> +    license_text =3D svd.licenseText.split("\\n")
>> +    for line in license_text:
>> +        sline =3D f" * {line.strip()}"
>> +        out +=3D f"{sline.rstrip()}\n"
>> +
>> +    now =3D datetime.datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S")
>> +    out +=3D f" * @note Automatically generated by {os.path.basename(__=
file__)}"
>> +    out +=3D f" on {now} UTC from {os.path.basename(args.input)}.\n"
>> +    out +=3D " *\n */\n\n"
>> +
>> +    # Write some generic defines
>> +    out +=3D "#pragma once\n\n"
>> +
>> +    for name in args.peripheral:
>> +        periph =3D svd.find(name)
>> +        if periph:
>> +            if args.system:
>> +                out +=3D generate_system_header(args.system, svd, perip=
h)
>> +            else:
>> +                out +=3D generate_peripheral_header(
>> +                    periph, args.type_name if args.type_name else perip=
h.name
>> +                )
>> +        else:
>> +            print(f"No such peripheral: {name}")
>> +            return 1
>> +
>> +    with open(args.output, "w", encoding=3D"ascii") as output:
>> +        output.write(out)
>> +
>> +    return 0
>> +
>> +
>> +if __name__ =3D=3D "__main__":
>> +    sys.exit(main())
>> --
>> 2.46.0.rc2.264.g509ed76dc8-goog
>>

