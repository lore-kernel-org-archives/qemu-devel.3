Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A25C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 21:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scAa9-0008K6-Mh; Thu, 08 Aug 2024 17:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scAa7-0008JW-8A
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scAa0-0000LP-A9
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723152110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLPtZPUKddDNP87L93XTR/IIJcKRJZUGbYYpeZaDdUg=;
 b=N+W9Q9shhkpEfH2ok2mIYtvTZ3QYjrTQuln7KV+5pFHxUjg2WYdL3enbnO1rA1uK+2vpVw
 rBSD1NB5ZgYXGGSgZt5XMS2xS5JB6YaZsssr0wq/+jbnnEmUwneeZpWKcP3RiwTBcT5qjz
 2fRKJK1I3TpUw9SHUvJ4wDrOc22q7Ew=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-kTHobRgsN7-OJAGJ-LiKMA-1; Thu, 08 Aug 2024 17:21:49 -0400
X-MC-Unique: kTHobRgsN7-OJAGJ-LiKMA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3685a5a765fso757334f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 14:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723152108; x=1723756908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WLPtZPUKddDNP87L93XTR/IIJcKRJZUGbYYpeZaDdUg=;
 b=KJdlcHrEr9UJRRan1E8YwYhmBJbWXqSMq/KEzsRjwiC39Ivdc9NFUoDLqxytrBRwGQ
 /qaL7QiFIdhexWoyMVXc9DQRG1z1inFosGTxMg6KhS+WFMOgZ9lrIIhncWAFoOQw2ulP
 wpbkQTdb78W85htIkq9qg4CtQPxXBzN2QHboui+Y2IXDgqNzJ6wt4ZpM02BaQH1B5MCN
 g6LIPP8+lxU+3CmemP+12uaD4GnluodTNXQwPll4OIxQf2rkSGOOKEjUbGmYiItUk8PY
 TNnw0axckM6bjTYC8rCjKFGIR+Tr5UcQ7OcpUwGAwFgvw7LWKHL/OY6VwfF8DcyNx0uM
 tYlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpuQskDjoyld50BzJWDcaNEy19+R2lPRg50ZPOT9QodDSy3DwXLMl1Ky12+kxg8y03d7R0tco0CFSirKe3OKzuRjZw7PM=
X-Gm-Message-State: AOJu0YxlKeHkrf3JW6BX+Qap2KE0PCLWoLz/whzXNu1DMCh6cMF+6mPc
 a70kemosyxFHg7vpUJ+SQZ5sG47EjNQ88KUI+73UiKssj+loBExZCUAo1h9rneE2iwr9pqbu9qo
 HcuVMSH51bqtqLXdMn/MgCZ+Zc4WlZ5HYA150xLqAABdCao/4HV+gPdeG9u6emg/i029F0/S6fL
 LYLhFgjSy+Ln/P30TUHEnDX7oOeKA=
X-Received: by 2002:a05:6000:1cf:b0:367:9988:7300 with SMTP id
 ffacd0b85a97d-36d2756618dmr2070472f8f.45.1723152107659; 
 Thu, 08 Aug 2024 14:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPmYHKhri53tZxH5NWUbU870LS2qKDyA3fOEeqCZIEJOHz5hBIeZU0xrI8L2Qr0J/x/Kj1Znv8CIhujiU3VgM=
X-Received: by 2002:a05:6000:1cf:b0:367:9988:7300 with SMTP id
 ffacd0b85a97d-36d2756618dmr2070461f8f.45.1723152107048; Thu, 08 Aug 2024
 14:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
In-Reply-To: <0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 8 Aug 2024 17:21:33 -0400
Message-ID: <CAFn=p-Y27zap1P5G3NibdZS26iGwCqh8U0vgW0Vw31f53+oU1w@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate GHES
 error inject
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, 
 Cleber Rosa <crosa@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003c2407061f329d17"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000003c2407061f329d17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 5:44=E2=80=AFPM Mauro Carvalho Chehab <
mchehab+huawei@kernel.org> wrote:

> Using the QMP GHESv2 API requires preparing a raw data array
> containing a CPER record.
>
> Add a helper script with subcommands to prepare such data.
>
> Currently, only ARM Processor error CPER record is supported.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS                    |   3 +
>  scripts/arm_processor_error.py | 352 +++++++++++++++++++++++++++++++++
>  scripts/ghes_inject.py         |  59 ++++++
>  scripts/qmp_helper.py          | 249 +++++++++++++++++++++++
>  4 files changed, 663 insertions(+)
>  create mode 100644 scripts/arm_processor_error.py
>  create mode 100755 scripts/ghes_inject.py
>  create mode 100644 scripts/qmp_helper.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 655edcb6688c..e490f69da1de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2081,6 +2081,9 @@ S: Maintained
>  F: hw/arm/ghes_cper.c
>  F: hw/acpi/ghes_cper_stub.c
>  F: qapi/ghes-cper.json
> +F: scripts/ghes_inject.py
> +F: scripts/arm_processor_error.py
> +F: scripts/qmp_helper.py
>
>  ppc4xx
>  L: qemu-ppc@nongnu.org
> diff --git a/scripts/arm_processor_error.py
> b/scripts/arm_processor_error.py
> new file mode 100644
> index 000000000000..df4efa508790
> --- /dev/null
> +++ b/scripts/arm_processor_error.py
> @@ -0,0 +1,352 @@
> +#!/usr/bin/env python3
> +#
> +# pylint: disable=3DC0301, C0114, R0912, R0913, R0914, R0915, W0511
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +# TODO: current implementation has dummy defaults.
> +#
> +# For a better implementation, a QMP addition/call is needed to
> +# retrieve some data for ARM Processor Error injection:
> +#
> +#   - machine emulation architecture, as ARM current default is
> +#     for AArch64;
> +#   - ARM registers: power_state, midr, mpidr.
> +
> +import argparse
> +import json
> +
> +from qmp_helper import (qmp_command, get_choice, get_mult_array,
> +                        get_mult_choices, get_mult_int, bit,
> +                        data_add, to_guid)
> +
> +# Arm processor EINJ logic
> +#
> +ACPI_GHES_ARM_CPER_LENGTH =3D 40
> +ACPI_GHES_ARM_CPER_PEI_LENGTH =3D 32
> +
> +# TODO: query it from emulation. Current default valid only for Aarch64
> +CONTEXT_AARCH64_EL1 =3D 5
> +
> +class ArmProcessorEinj:
> +    """
> +    Implements ARM Processor Error injection via GHES
> +    """
> +
> +    def __init__(self):
> +        """Initialize the error injection class"""
> +
> +        # Valid choice values
> +        self.arm_valid_bits =3D {
> +            "mpidr":    bit(0),
> +            "affinity": bit(1),
> +            "running":  bit(2),
> +            "vendor":   bit(3),
> +        }
> +
> +        self.pei_flags =3D {
> +            "first":        bit(0),
> +            "last":         bit(1),
> +            "propagated":   bit(2),
> +            "overflow":     bit(3),
> +        }
> +
> +        self.pei_error_types =3D {
> +            "cache":        bit(1),
> +            "tlb":          bit(2),
> +            "bus":          bit(3),
> +            "micro-arch":   bit(4),
> +        }
> +
> +        self.pei_valid_bits =3D {
> +            "multiple-error":   bit(0),
> +            "flags":            bit(1),
> +            "error-info":       bit(2),
> +            "virt-addr":        bit(3),
> +            "phy-addr":         bit(4),
> +        }
> +
> +        self.data =3D bytearray()
> +
> +    def create_subparser(self, subparsers):
> +        """Add a subparser to handle for the error fields"""
> +
> +        parser =3D subparsers.add_parser("arm",
> +                                       help=3D"Generate an ARM processor
> CPER")
> +
> +        arm_valid_bits =3D ",".join(self.arm_valid_bits.keys())
> +        flags =3D ",".join(self.pei_flags.keys())
> +        error_types =3D ",".join(self.pei_error_types.keys())
> +        pei_valid_bits =3D ",".join(self.arm_valid_bits.keys())
> +
> +        # UEFI N.16 ARM Validation bits
> +        g_arm =3D parser.add_argument_group("ARM processor")
> +        g_arm.add_argument("--arm", "--arm-valid",
> +                           help=3Df"ARM valid bits: {arm_valid_bits}")
> +        g_arm.add_argument("-a", "--affinity",  "--level",
> "--affinity-level",
> +                           type=3Dlambda x: int(x, 0),
> +                           help=3D"Affinity level (when multiple levels
> apply)")
> +        g_arm.add_argument("-l", "--mpidr", type=3Dlambda x: int(x, 0),
> +                           help=3D"Multiprocessor Affinity Register")
> +        g_arm.add_argument("-i", "--midr", type=3Dlambda x: int(x, 0),
> +                           help=3D"Main ID Register")
> +        g_arm.add_argument("-r", "--running",
> +                           action=3Dargparse.BooleanOptionalAction,
> +                           default=3DNone,
> +                           help=3D"Indicates if the processor is running=
 or
> not")
> +        g_arm.add_argument("--psci", "--psci-state",
> +                           type=3Dlambda x: int(x, 0),
> +                           help=3D"Power State Coordination Interface -
> PSCI state")
> +
> +        # TODO: Add vendor-specific support
> +
> +        # UEFI N.17 bitmaps (type and flags)
> +        g_pei =3D parser.add_argument_group("ARM Processor Error Info
> (PEI)")
> +        g_pei.add_argument("-t", "--type", nargs=3D"+",
> +                        help=3Df"one or more error types: {error_types}"=
)
> +        g_pei.add_argument("-f", "--flags", nargs=3D"*",
> +                        help=3Df"zero or more error flags: {flags}")
> +        g_pei.add_argument("-V", "--pei-valid", "--error-valid",
> nargs=3D"*",
> +                        help=3Df"zero or more PEI valid bits:
> {pei_valid_bits}")
> +
> +        # UEFI N.17 Integer values
> +        g_pei.add_argument("-m", "--multiple-error", nargs=3D"+",
> +                        help=3D"Number of errors: 0: Single error, 1:
> Multiple errors, 2-65535: Error count if known")
> +        g_pei.add_argument("-e", "--error-info", nargs=3D"+",
> +                        help=3D"Error information (UEFI 2.10 tables N.18=
 to
> N.20)")
> +        g_pei.add_argument("-p", "--physical-address",  nargs=3D"+",
> +                        help=3D"Physical address")
> +        g_pei.add_argument("-v", "--virtual-address",  nargs=3D"+",
> +                        help=3D"Virtual address")
> +
> +        # UEFI N.21 Context
> +        g_ctx =3D parser.add_argument_group("Processor Context")
> +        g_ctx.add_argument("--ctx-type", "--context-type", nargs=3D"*",
> +                        help=3D"Type of the context (0=3DARM32 GPR, 5=3D=
ARM64
> EL1, other values supported)")
> +        g_ctx.add_argument("--ctx-size", "--context-size", nargs=3D"*",
> +                        help=3D"Minimal size of the context")
> +        g_ctx.add_argument("--ctx-array", "--context-array", nargs=3D"*"=
,
> +                        help=3D"Comma-separated arrays for each context"=
)
> +
> +        # Vendor-specific data
> +        g_vendor =3D parser.add_argument_group("Vendor-specific data")
> +        g_vendor.add_argument("--vendor", "--vendor-specific", nargs=3D"=
+",
> +                        help=3D"Vendor-specific byte arrays of data")
> +
> +    def parse_args(self, args):
> +        """Parse subcommand arguments"""
> +
> +        cper =3D {}
> +        pei =3D {}
> +        ctx =3D {}
> +        vendor =3D {}
> +
> +        arg =3D vars(args)
> +
> +        # Handle global parameters
> +        if args.arm:
> +            arm_valid_init =3D False
> +            cper["valid"] =3D get_choice(name=3D"valid",
> +                                       value=3Dargs.arm,
> +                                       choices=3Dself.arm_valid_bits,
> +                                       suffixes=3D["-error", "-err"])
> +        else:
> +            cper["valid"] =3D 0
> +            arm_valid_init =3D True
> +
> +        if "running" in arg:
> +            if args.running:
> +                cper["running-state"] =3D bit(0)
> +            else:
> +                cper["running-state"] =3D 0
> +        else:
> +            cper["running-state"] =3D 0
> +
> +        if arm_valid_init:
> +            if args.affinity:
> +                cper["valid"] |=3D self.arm_valid_bits["affinity"]
> +
> +            if args.mpidr:
> +                cper["valid"] |=3D self.arm_valid_bits["mpidr"]
> +
> +            if "running-state" in cper:
> +                cper["valid"] |=3D self.arm_valid_bits["running"]
> +
> +            if args.psci:
> +                cper["valid"] |=3D self.arm_valid_bits["running"]
> +
> +        # Handle PEI
> +        if not args.type:
> +            args.type =3D ["cache-error"]
> +
> +        get_mult_choices(
> +            pei,
> +            name=3D"valid",
> +            values=3Dargs.pei_valid,
> +            choices=3Dself.pei_valid_bits,
> +            suffixes=3D["-valid", "-info", "--information", "--addr"],
> +        )
> +        get_mult_choices(
> +            pei,
> +            name=3D"type",
> +            values=3Dargs.type,
> +            choices=3Dself.pei_error_types,
> +            suffixes=3D["-error", "-err"],
> +        )
> +        get_mult_choices(
> +            pei,
> +            name=3D"flags",
> +            values=3Dargs.flags,
> +            choices=3Dself.pei_flags,
> +            suffixes=3D["-error", "-cap"],
> +        )
> +        get_mult_int(pei, "error-info", args.error_info)
> +        get_mult_int(pei, "multiple-error", args.multiple_error)
> +        get_mult_int(pei, "phy-addr", args.physical_address)
> +        get_mult_int(pei, "virt-addr", args.virtual_address)
> +
> +        # Handle context
> +        get_mult_int(ctx, "type", args.ctx_type, allow_zero=3DTrue)
> +        get_mult_int(ctx, "minimal-size", args.ctx_size, allow_zero=3DTr=
ue)
> +        get_mult_array(ctx, "register", args.ctx_array, allow_zero=3DTru=
e)
> +
> +        get_mult_array(vendor, "bytes", args.vendor, max_val=3D255)
> +
> +        # Store PEI
> +        pei_data =3D bytearray()
> +        default_flags  =3D self.pei_flags["first"]
> +        default_flags |=3D self.pei_flags["last"]
> +
> +        error_info_num =3D 0
> +
> +        for i, p in pei.items():        # pylint: disable=3DW0612
> +            error_info_num +=3D 1
> +
> +            # UEFI 2.10 doesn't define how to encode error information
> +            # when multiple types are raised. So, provide a default only
> +            # if a single type is there
> +            if "error-info" not in p:
> +                if p["type"] =3D=3D bit(1):
> +                    p["error-info"] =3D 0x0091000F
> +                if p["type"] =3D=3D bit(2):
> +                    p["error-info"] =3D 0x0054007F
> +                if p["type"] =3D=3D bit(3):
> +                    p["error-info"] =3D 0x80D6460FFF
> +                if p["type"] =3D=3D bit(4):
> +                    p["error-info"] =3D 0x78DA03FF
> +
> +            if "valid" not in p:
> +                p["valid"] =3D 0
> +                if "multiple-error" in p:
> +                    p["valid"] |=3D self.pei_valid_bits["multiple-error"=
]
> +
> +                if "flags" in p:
> +                    p["valid"] |=3D self.pei_valid_bits["flags"]
> +
> +                if "error-info" in p:
> +                    p["valid"] |=3D self.pei_valid_bits["error-info"]
> +
> +                if "phy-addr" in p:
> +                    p["valid"] |=3D self.pei_valid_bits["phy-addr"]
> +
> +                if "virt-addr" in p:
> +                    p["valid"] |=3D self.pei_valid_bits["virt-addr"]
> +
> +            # Version
> +            data_add(pei_data, 0, 1)
> +
> +            data_add(pei_data, ACPI_GHES_ARM_CPER_PEI_LENGTH, 1)
> +
> +            data_add(pei_data, p["valid"], 2)
> +            data_add(pei_data, p["type"], 1)
> +            data_add(pei_data, p.get("multiple-error", 1), 2)
> +            data_add(pei_data, p.get("flags", default_flags), 1)
> +            data_add(pei_data, p.get("error-info", 0), 8)
> +            data_add(pei_data, p.get("virt-addr", 0xDEADBEEF), 8)
> +            data_add(pei_data, p.get("phy-addr", 0xABBA0BAD), 8)
> +
> +        # Store Context
> +        ctx_data =3D bytearray()
> +        context_info_num =3D 0
> +
> +        if ctx:
> +            for k in sorted(ctx.keys()):
> +                context_info_num +=3D 1
> +
> +                if "type" not in ctx:
> +                    ctx[k]["type"] =3D CONTEXT_AARCH64_EL1
> +
> +                if "register" not in ctx:
> +                    ctx[k]["register"] =3D []
> +
> +                reg_size =3D len(ctx[k]["register"])
> +                size =3D 0
> +
> +                if "minimal-size" in ctx:
> +                    size =3D ctx[k]["minimal-size"]
> +
> +                size =3D max(size, reg_size)
> +
> +                size =3D (size + 1) % 0xFFFE
> +
> +                # Version
> +                data_add(ctx_data, 0, 2)
> +
> +                data_add(ctx_data, ctx[k]["type"], 2)
> +
> +                data_add(ctx_data, 8 * size, 4)
> +
> +                for r in ctx[k]["register"]:
> +                    data_add(ctx_data, r, 8)
> +
> +                for i in range(reg_size, size):   # pylint: disable=3DW0=
612
> +                    data_add(ctx_data, 0, 8)
> +
> +        # Vendor-specific bytes are not grouped
> +        vendor_data =3D bytearray()
> +        if vendor:
> +            for k in sorted(vendor.keys()):
> +                for b in vendor[k]["bytes"]:
> +                    data_add(vendor_data, b, 1)
> +
> +        # Encode ARM Processor Error
> +        data =3D bytearray()
> +
> +        data_add(data, cper["valid"], 4)
> +
> +        data_add(data, error_info_num, 2)
> +        data_add(data, context_info_num, 2)
> +
> +        # Calculate the length of the CPER data
> +        cper_length =3D ACPI_GHES_ARM_CPER_LENGTH
> +        cper_length +=3D len(pei_data)
> +        cper_length +=3D len(vendor_data)
> +        cper_length +=3D len(ctx_data)
> +        data_add(data, cper_length, 4)
> +
> +        data_add(data, arg.get("affinity-level", 0), 1)
> +
> +        # Reserved
> +        data_add(data, 0, 3)
> +
> +        data_add(data, arg.get("mpidr-el1", 0), 8)
> +        data_add(data, arg.get("midr-el1", 0), 8)
> +        data_add(data, cper["running-state"], 4)
> +        data_add(data, arg.get("psci-state", 0), 4)
> +
> +        # Add PEI
> +        data.extend(pei_data)
> +        data.extend(ctx_data)
> +        data.extend(vendor_data)
> +
> +        self.data =3D data
> +
> +    def run(self, host, port):
> +        """Execute QMP commands"""
> +
> +        guid =3D to_guid(0xE19E3D16, 0xBC11, 0x11E4,
> +                       [0x9C, 0xAA, 0xC2, 0x05,
> +                        0x1D, 0x5D, 0x46, 0xB0])
> +
> +        qmp_command(host, port, guid, self.data)
> diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py
> new file mode 100755
> index 000000000000..8415ccbbc53d
> --- /dev/null
> +++ b/scripts/ghes_inject.py
> @@ -0,0 +1,59 @@
> +#!/usr/bin/env python3
> +#
> +# pylint: disable=3DC0301, C0114
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +import argparse
> +
> +from arm_processor_error import ArmProcessorEinj
> +
> +EINJ_DESCRIPTION =3D """
> +Handle ACPI GHESv2 error injection logic QEMU QMP interface.\n
> +
> +It allows using UEFI BIOS EINJ features to generate GHES records.
> +
> +It helps testing Linux CPER and GHES drivers and to test rasdaemon
> +error handling logic.
> +
> +Currently, it support ARM processor error injection for ARM processor
> +events, being compatible with UEFI 2.9A Errata.
> +
> +This small utility works together with those QEMU additions:
> +- https://gitlab.com/mchehab_kernel/qemu/-/tree/arm-error-inject-v2
> +"""
> +
> +def main():
> +    """Main program"""
> +
> +    # Main parser - handle generic args like QEMU QMP TCP socket options
> +    parser =3D argparse.ArgumentParser(prog=3D"einj.py",
> +
>  formatter_class=3Dargparse.RawDescriptionHelpFormatter,
> +                                     usage=3D"%(prog)s [options]",
> +                                     description=3DEINJ_DESCRIPTION,
> +                                     epilog=3D"If a field is not defined=
, a
> default value will be applied by QEMU.")
> +
> +    g_options =3D parser.add_argument_group("QEMU QMP socket options")
> +    g_options.add_argument("-H", "--host", default=3D"localhost", type=
=3Dstr,
> +                           help=3D"host name")
> +    g_options.add_argument("-P", "--port", default=3D4445, type=3Dint,
> +                           help=3D"TCP port number")
> +
> +    arm_einj =3D ArmProcessorEinj()
> +
> +    # Call subparsers
> +    subparsers =3D parser.add_subparsers(dest=3D'command')
> +
> +    arm_einj.create_subparser(subparsers)
> +
> +    args =3D parser.parse_args()
> +
> +    # Handle subparser commands
> +    if args.command =3D=3D "arm":
> +        arm_einj.parse_args(args)
> +        arm_einj.run(args.host, args.port)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()
> diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> new file mode 100644
> index 000000000000..13fae7a7af0e
> --- /dev/null
> +++ b/scripts/qmp_helper.py
>

I'm going to admit I only glanced at this very briefly, but -- is there a
chance you could use qemu.git/python/qemu/qmp instead of writing your own
helpers here?

If *NOT*, is there something that I need to add to our QMP library to
facilitate your script?


> @@ -0,0 +1,249 @@
> +#!/usr/bin/env python3
> +#
> +# pylint: disable=3DC0301, C0114, R0912, R0913, R0915, W0511
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +import json
> +import socket
> +import sys
> +
> +from base64 import b64encode
> +
> +#
> +# Socket QMP send command
> +#
> +def qmp_command(host, port, guid, data):
> +    """Send commands to QEMU though QMP TCP socket"""
> +
> +    # Fill the commands to be sent
> +    commands =3D []
> +
> +    # Needed to negotiate QMP and for QEMU to accept the command
> +    commands.append('{ "execute": "qmp_capabilities" } ')
> +
> +    base64_data =3D b64encode(bytes(data)).decode('ascii')
> +
> +    cmd_arg =3D {
> +        'cper': {
> +            'notification-type': guid,
> +            "raw-data": base64_data
> +        }
> +    }
> +
> +    command =3D '{ "execute": "ghes-cper", '
> +    command +=3D '"arguments": ' + json.dumps(cmd_arg) + " }"
> +
> +    commands.append(command)
> +
> +    s =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> +    try:
> +        s.connect((host, port))
> +    except ConnectionRefusedError:
> +        sys.exit(f"Can't connect to QMP host {host}:{port}")
>

You should be able to use e.g.

legacy.py's QEMUMonitorProtocol class for synchronous connections, e.g.

from qemu.qmp.legacy import QEMUMonitorProtocol

qmp =3D QEMUMonitorProtocol((host, port))
qmp.connect(negotiate=3DTrue)

If you want to run the script w/o setting up a virtual environment or
installing the package, take a look at the hacks in scripts/qmp/ for how I
support e.g. qom-get directly from the source tree.


> +
> +    data =3D s.recv(1024)
> +    try:
> +        obj =3D json.loads(data.decode("utf-8"))
> +    except json.JSONDecodeError as e:
> +        print(f"Invalid QMP answer: {e}")
> +        s.close()
> +        return
> +
> +    if "QMP" not in obj:
> +        print(f"Invalid QMP answer: {data.decode("utf-8")}")
> +        s.close()
> +        return
> +
> +    for i, command in enumerate(commands):
>

Then here you'd use qmp.cmd (raises exception on QMPError) or qmp.cmd_raw
or qmp.cmd_obj (returns the QMP response as the return value even if it was
an error.)

More details:
https://qemu.readthedocs.io/projects/python-qemu-qmp/en/latest/qemu.qmp.leg=
acy.html

There's also an async version, but it doesn't look like you require that
complexity, so you can ignore it.

~~js

+        s.sendall(command.encode("utf-8"))
> +        data =3D s.recv(1024)
> +        try:
> +            obj =3D json.loads(data.decode("utf-8"))
> +        except json.JSONDecodeError as e:
> +            print(f"Invalid QMP answer: {e}")
> +            s.close()
> +            return
> +
> +        if isinstance(obj.get("return"), dict):
> +            if obj["return"]:
> +                print(json.dumps(obj["return"]))
> +            elif i > 0:
> +                print("Error injected.")
> +        elif isinstance(obj.get("error"), dict):
> +            error =3D obj["error"]
> +            print(f'{error["class"]}: {error["desc"]}')
> +        else:
> +            print(json.dumps(obj))
> +
> +    s.shutdown(socket.SHUT_WR)
> +    while 1:
> +        data =3D s.recv(1024)
> +        if data =3D=3D b"":
> +            break
> +        try:
> +            obj =3D json.loads(data.decode("utf-8"))
> +        except json.JSONDecodeError as e:
> +            print(f"Invalid QMP answer: {e}")
> +            s.close()
> +            return
> +
> +        if isinstance(obj.get("return"), dict):
> +            print(json.dumps(obj["return"]))
> +        if isinstance(obj.get("error"), dict):
> +            error =3D obj["error"]
> +            print(f'{error["class"]}: {error["desc"]}')
> +        else:
> +            print(json.dumps(obj))
> +
> +    s.close()
> +
> +
> +#
> +# Helper routines to handle multiple choice arguments
> +#
> +def get_choice(name, value, choices, suffixes=3DNone):
> +    """Produce a list from multiple choice argument"""
> +
> +    new_values =3D 0
> +
> +    if not value:
> +        return new_values
> +
> +    for val in value.split(","):
> +        val =3D val.lower()
> +
> +        if suffixes:
> +            for suffix in suffixes:
> +                val =3D val.removesuffix(suffix)
> +
> +        if val not in choices.keys():
> +            sys.exit(f"Error on '{name}': choice {val} is invalid.")
> +
> +        val =3D choices[val]
> +
> +        new_values |=3D val
> +
> +    return new_values
> +
> +
> +def get_mult_array(mult, name, values, allow_zero=3DFalse, max_val=3DNon=
e):
> +    """Add numbered hashes from integer lists"""
> +
> +    if not allow_zero:
> +        if not values:
> +            return
> +    else:
> +        if values is None:
> +            return
> +
> +        if not values:
> +            i =3D 0
> +            if i not in mult:
> +                mult[i] =3D {}
> +
> +            mult[i][name] =3D []
> +            return
> +
> +    i =3D 0
> +    for value in values:
> +        for val in value.split(","):
> +            try:
> +                val =3D int(val, 0)
> +            except ValueError:
> +                sys.exit(f"Error on '{name}': {val} is not an integer")
> +
> +            if val < 0:
> +                sys.exit(f"Error on '{name}': {val} is not unsigned")
> +
> +            if max_val and val > max_val:
> +                sys.exit(f"Error on '{name}': {val} is too little")
> +
> +            if i not in mult:
> +                mult[i] =3D {}
> +
> +            if name not in mult[i]:
> +                mult[i][name] =3D []
> +
> +            mult[i][name].append(val)
> +
> +        i +=3D 1
> +
> +
> +def get_mult_choices(mult, name, values, choices,
> +                     suffixes=3DNone, allow_zero=3DFalse):
> +    """Add numbered hashes from multiple choice arguments"""
> +
> +    if not allow_zero:
> +        if not values:
> +            return
> +    else:
> +        if values is None:
> +            return
> +
> +    i =3D 0
> +    for val in values:
> +        new_values =3D get_choice(name, val, choices, suffixes)
> +
> +        if i not in mult:
> +            mult[i] =3D {}
> +
> +        mult[i][name] =3D new_values
> +        i +=3D 1
> +
> +
> +def get_mult_int(mult, name, values, allow_zero=3DFalse):
> +    """Add numbered hashes from integer arguments"""
> +    if not allow_zero:
> +        if not values:
> +            return
> +    else:
> +        if values is None:
> +            return
> +
> +    i =3D 0
> +    for val in values:
> +        try:
> +            val =3D int(val, 0)
> +        except ValueError:
> +            sys.exit(f"Error on '{name}': {val} is not an integer")
> +
> +        if val < 0:
> +            sys.exit(f"Error on '{name}': {val} is not unsigned")
> +
> +        if i not in mult:
> +            mult[i] =3D {}
> +
> +        mult[i][name] =3D val
> +        i +=3D 1
> +
> +
> +#
> +# Data encode helper functions
> +#
> +def bit(b):
> +    """Simple macro to define a bit on a bitmask"""
> +    return 1 << b
> +
> +
> +def data_add(data, value, num_bytes):
> +    """Adds bytes from value inside a bitarray"""
> +
> +    data.extend(value.to_bytes(num_bytes, byteorder=3D"little"))
> +
> +def to_guid(time_low, time_mid, time_high, nodes):
> +    """Create an GUID string"""
> +
> +    assert(len(nodes) =3D=3D 8)
> +
> +    clock =3D nodes[0] << 8 | nodes[1]
> +
> +    node =3D 0
> +    for i in range(2, len(nodes)):
> +        node =3D node << 8 | nodes[i]
> +
> +    s =3D f"{time_low:08x}-{time_mid:04x}-"
> +    s +=3D f"{time_high:04x}-{clock:04x}-{node:012x}"
> +
> +    return s
> --
> 2.45.2
>
>

--0000000000003c2407061f329d17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 2, 2024 at 5:44=E2=80=AFP=
M Mauro Carvalho Chehab &lt;<a href=3D"mailto:mchehab%2Bhuawei@kernel.org">=
mchehab+huawei@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Using the QMP GHESv2 API requires preparing a raw =
data array<br>
containing a CPER record.<br>
<br>
Add a helper script with subcommands to prepare such data.<br>
<br>
Currently, only ARM Processor error CPER record is supported.<br>
<br>
Signed-off-by: Mauro Carvalho Chehab &lt;<a href=3D"mailto:mchehab%2Bhuawei=
@kernel.org" target=3D"_blank">mchehab+huawei@kernel.org</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0scripts/arm_processor_error.py | 352 ++++++++++++++++++++++++++++++++=
+<br>
=C2=A0scripts/ghes_inject.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 59 ++=
++++<br>
=C2=A0scripts/qmp_helper.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 249 +++++++=
++++++++++++++++<br>
=C2=A04 files changed, 663 insertions(+)<br>
=C2=A0create mode 100644 scripts/arm_processor_error.py<br>
=C2=A0create mode 100755 scripts/ghes_inject.py<br>
=C2=A0create mode 100644 scripts/qmp_helper.py<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 655edcb6688c..e490f69da1de 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -2081,6 +2081,9 @@ S: Maintained<br>
=C2=A0F: hw/arm/ghes_cper.c<br>
=C2=A0F: hw/acpi/ghes_cper_stub.c<br>
=C2=A0F: qapi/ghes-cper.json<br>
+F: scripts/ghes_inject.py<br>
+F: scripts/arm_processor_error.py<br>
+F: scripts/qmp_helper.py<br>
<br>
=C2=A0ppc4xx<br>
=C2=A0L: <a href=3D"mailto:qemu-ppc@nongnu.org" target=3D"_blank">qemu-ppc@=
nongnu.org</a><br>
diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.p=
y<br>
new file mode 100644<br>
index 000000000000..df4efa508790<br>
--- /dev/null<br>
+++ b/scripts/arm_processor_error.py<br>
@@ -0,0 +1,352 @@<br>
+#!/usr/bin/env python3<br>
+#<br>
+# pylint: disable=3DC0301, C0114, R0912, R0913, R0914, R0915, W0511<br>
+# SPDX-License-Identifier: GPL-2.0<br>
+#<br>
+# Copyright (C) 2024 Mauro Carvalho Chehab &lt;<a href=3D"mailto:mchehab%2=
Bhuawei@kernel.org" target=3D"_blank">mchehab+huawei@kernel.org</a>&gt;<br>
+<br>
+# TODO: current implementation has dummy defaults.<br>
+#<br>
+# For a better implementation, a QMP addition/call is needed to<br>
+# retrieve some data for ARM Processor Error injection:<br>
+#<br>
+#=C2=A0 =C2=A0- machine emulation architecture, as ARM current default is<=
br>
+#=C2=A0 =C2=A0 =C2=A0for AArch64;<br>
+#=C2=A0 =C2=A0- ARM registers: power_state, midr, mpidr.<br>
+<br>
+import argparse<br>
+import json<br>
+<br>
+from qmp_helper import (qmp_command, get_choice, get_mult_array,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 get_mult_choices, get_mult_int, bit,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 data_add, to_guid)<br>
+<br>
+# Arm processor EINJ logic<br>
+#<br>
+ACPI_GHES_ARM_CPER_LENGTH =3D 40<br>
+ACPI_GHES_ARM_CPER_PEI_LENGTH =3D 32<br>
+<br>
+# TODO: query it from emulation. Current default valid only for Aarch64<br=
>
+CONTEXT_AARCH64_EL1 =3D 5<br>
+<br>
+class ArmProcessorEinj:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Implements ARM Processor Error injection via GHES<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 def __init__(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Initialize the error injecti=
on class&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Valid choice values<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arm_valid_bits =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mpidr&quot;:=C2=A0 =C2=A0 =
bit(0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;affinity&quot;: bit(1),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;running&quot;:=C2=A0 bit(2=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vendor&quot;:=C2=A0 =C2=A0=
bit(3),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pei_flags =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;first&quot;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 bit(0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;last&quot;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0bit(1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;propagated&quot;:=C2=A0 =
=C2=A0bit(2),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;overflow&quot;:=C2=A0 =C2=
=A0 =C2=A0bit(3),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pei_error_types =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cache&quot;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 bit(1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tlb&quot;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bit(2),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;bus&quot;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bit(3),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;micro-arch&quot;:=C2=A0 =
=C2=A0bit(4),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pei_valid_bits =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;multiple-error&quot;:=C2=
=A0 =C2=A0bit(0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;flags&quot;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bit(1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;error-info&quot;:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0bit(2),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;virt-addr&quot;:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bit(3),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;phy-addr&quot;:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bit(4),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.data =3D bytearray()<br>
+<br>
+=C2=A0 =C2=A0 def create_subparser(self, subparsers):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Add a subparser to handle fo=
r the error fields&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser =3D subparsers.add_parser(&quot;arm&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help=3D&q=
uot;Generate an ARM processor CPER&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arm_valid_bits =3D &quot;,&quot;.join(self.arm=
_valid_bits.keys())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags =3D &quot;,&quot;.join(self.pei_flags.ke=
ys())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_types =3D &quot;,&quot;.join(self.pei_er=
ror_types.keys())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pei_valid_bits =3D &quot;,&quot;.join(self.arm=
_valid_bits.keys())<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # UEFI N.16 ARM Validation bits<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_arm =3D parser.add_argument_group(&quot;ARM =
processor&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_arm.add_argument(&quot;--arm&quot;, &quot;--=
arm-valid&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3Df&quot;ARM valid bits: {arm_valid_bits}&quot=
;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_arm.add_argument(&quot;-a&quot;, &quot;--aff=
inity&quot;,=C2=A0 &quot;--level&quot;, &quot;--affinity-level&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0type=3Dlambda x: int(x, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;Affinity level (when multiple levels a=
pply)&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_arm.add_argument(&quot;-l&quot;, &quot;--mpi=
dr&quot;, type=3Dlambda x: int(x, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;Multiprocessor Affinity Register&quot;=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_arm.add_argument(&quot;-i&quot;, &quot;--mid=
r&quot;, type=3Dlambda x: int(x, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;Main ID Register&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_arm.add_argument(&quot;-r&quot;, &quot;--run=
ning&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0action=3Dargparse.BooleanOptionalAction,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0default=3DNone,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;Indicates if the processor is running =
or not&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_arm.add_argument(&quot;--psci&quot;, &quot;-=
-psci-state&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0type=3Dlambda x: int(x, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;Power State Coordination Interface - P=
SCI state&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO: Add vendor-specific support<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # UEFI N.17 bitmaps (type and flags)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_pei =3D parser.add_argument_group(&quot;ARM =
Processor Error Info (PEI)&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_pei.add_argument(&quot;-t&quot;, &quot;--typ=
e&quot;, nargs=3D&quot;+&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3Df&quot;one or more error types: {error_types}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_pei.add_argument(&quot;-f&quot;, &quot;--fla=
gs&quot;, nargs=3D&quot;*&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3Df&quot;zero or more error flags: {flags}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_pei.add_argument(&quot;-V&quot;, &quot;--pei=
-valid&quot;, &quot;--error-valid&quot;, nargs=3D&quot;*&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3Df&quot;zero or more PEI valid bits: {pei_valid_bits}&quot=
;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # UEFI N.17 Integer values<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_pei.add_argument(&quot;-m&quot;, &quot;--mul=
tiple-error&quot;, nargs=3D&quot;+&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;Number of errors: 0: Single error, 1: Multiple erro=
rs, 2-65535: Error count if known&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_pei.add_argument(&quot;-e&quot;, &quot;--err=
or-info&quot;, nargs=3D&quot;+&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;Error information (UEFI 2.10 tables N.18 to N.20)&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_pei.add_argument(&quot;-p&quot;, &quot;--phy=
sical-address&quot;,=C2=A0 nargs=3D&quot;+&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;Physical address&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_pei.add_argument(&quot;-v&quot;, &quot;--vir=
tual-address&quot;,=C2=A0 nargs=3D&quot;+&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;Virtual address&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # UEFI N.21 Context<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_ctx =3D parser.add_argument_group(&quot;Proc=
essor Context&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_ctx.add_argument(&quot;--ctx-type&quot;, &qu=
ot;--context-type&quot;, nargs=3D&quot;*&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;Type of the context (0=3DARM32 GPR, 5=3DARM64 EL1, =
other values supported)&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_ctx.add_argument(&quot;--ctx-size&quot;, &qu=
ot;--context-size&quot;, nargs=3D&quot;*&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;Minimal size of the context&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_ctx.add_argument(&quot;--ctx-array&quot;, &q=
uot;--context-array&quot;, nargs=3D&quot;*&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;Comma-separated arrays for each context&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Vendor-specific data<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_vendor =3D parser.add_argument_group(&quot;V=
endor-specific data&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_vendor.add_argument(&quot;--vendor&quot;, &q=
uot;--vendor-specific&quot;, nargs=3D&quot;+&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 help=3D&quot;Vendor-specific byte arrays of data&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def parse_args(self, args):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Parse subcommand arguments&q=
uot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cper =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pei =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor =3D {}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg =3D vars(args)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Handle global parameters<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if args.arm:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arm_valid_init =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cper[&quot;valid&quot;] =3D get_=
choice(name=3D&quot;valid&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value=3Da=
rgs.arm,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0choices=
=3Dself.arm_valid_bits,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0suffixes=
=3D[&quot;-error&quot;, &quot;-err&quot;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cper[&quot;valid&quot;] =3D 0<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arm_valid_init =3D True<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;running&quot; in arg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if args.running:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cper[&quot;running=
-state&quot;] =3D bit(0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cper[&quot;running=
-state&quot;] =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cper[&quot;running-state&quot;] =
=3D 0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if arm_valid_init:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if args.affinity:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cper[&quot;valid&q=
uot;] |=3D self.arm_valid_bits[&quot;affinity&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if args.mpidr:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cper[&quot;valid&q=
uot;] |=3D self.arm_valid_bits[&quot;mpidr&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;running-state&quot; in =
cper:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cper[&quot;valid&q=
uot;] |=3D self.arm_valid_bits[&quot;running&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if args.psci:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cper[&quot;valid&q=
uot;] |=3D self.arm_valid_bits[&quot;running&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Handle PEI<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not args.type:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args.type =3D [&quot;cache-error=
&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_choices(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pei,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;valid&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 values=3Dargs.pei_valid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 choices=3Dself.pei_valid_bits,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 suffixes=3D[&quot;-valid&quot;, =
&quot;-info&quot;, &quot;--information&quot;, &quot;--addr&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_choices(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pei,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;type&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 values=3Dargs.type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 choices=3Dself.pei_error_types,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 suffixes=3D[&quot;-error&quot;, =
&quot;-err&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_choices(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pei,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&quot;flags&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 values=3Dargs.flags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 choices=3Dself.pei_flags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 suffixes=3D[&quot;-error&quot;, =
&quot;-cap&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_int(pei, &quot;error-info&quot;, args=
.error_info)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_int(pei, &quot;multiple-error&quot;, =
args.multiple_error)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_int(pei, &quot;phy-addr&quot;, args.p=
hysical_address)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_int(pei, &quot;virt-addr&quot;, args.=
virtual_address)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Handle context<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_int(ctx, &quot;type&quot;, args.ctx_t=
ype, allow_zero=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_int(ctx, &quot;minimal-size&quot;, ar=
gs.ctx_size, allow_zero=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_array(ctx, &quot;register&quot;, args=
.ctx_array, allow_zero=3DTrue)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_mult_array(vendor, &quot;bytes&quot;, args=
.vendor, max_val=3D255)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Store PEI<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pei_data =3D bytearray()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default_flags=C2=A0 =3D self.pei_flags[&quot;f=
irst&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default_flags |=3D self.pei_flags[&quot;last&q=
uot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_info_num =3D 0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for i, p in pei.items():=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # pylint: disable=3DW0612<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_info_num +=3D 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # UEFI 2.10 doesn&#39;t define h=
ow to encode error information<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # when multiple types are raised=
. So, provide a default only<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # if a single type is there<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;error-info&quot; not in=
 p:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if p[&quot;type&qu=
ot;] =3D=3D bit(1):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[&q=
uot;error-info&quot;] =3D 0x0091000F<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if p[&quot;type&qu=
ot;] =3D=3D bit(2):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[&q=
uot;error-info&quot;] =3D 0x0054007F<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if p[&quot;type&qu=
ot;] =3D=3D bit(3):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[&q=
uot;error-info&quot;] =3D 0x80D6460FFF<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if p[&quot;type&qu=
ot;] =3D=3D bit(4):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[&q=
uot;error-info&quot;] =3D 0x78DA03FF<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;valid&quot; not in p:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[&quot;valid&quot=
;] =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;multiple-=
error&quot; in p:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[&q=
uot;valid&quot;] |=3D self.pei_valid_bits[&quot;multiple-error&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;flags&quo=
t; in p:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[&q=
uot;valid&quot;] |=3D self.pei_valid_bits[&quot;flags&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;error-inf=
o&quot; in p:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[&q=
uot;valid&quot;] |=3D self.pei_valid_bits[&quot;error-info&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;phy-addr&=
quot; in p:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[&q=
uot;valid&quot;] |=3D self.pei_valid_bits[&quot;phy-addr&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;virt-addr=
&quot; in p:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[&q=
uot;valid&quot;] |=3D self.pei_valid_bits[&quot;virt-addr&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Version<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(pei_data, 0, 1)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(pei_data, ACPI_GHES_ARM=
_CPER_PEI_LENGTH, 1)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(pei_data, p[&quot;valid=
&quot;], 2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(pei_data, p[&quot;type&=
quot;], 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(pei_data, p.get(&quot;m=
ultiple-error&quot;, 1), 2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(pei_data, p.get(&quot;f=
lags&quot;, default_flags), 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(pei_data, p.get(&quot;e=
rror-info&quot;, 0), 8)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(pei_data, p.get(&quot;v=
irt-addr&quot;, 0xDEADBEEF), 8)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(pei_data, p.get(&quot;p=
hy-addr&quot;, 0xABBA0BAD), 8)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Store Context<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx_data =3D bytearray()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 context_info_num =3D 0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ctx:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in sorted(ctx.keys()):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context_info_num +=
=3D 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;type&quot=
; not in ctx:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx[=
k][&quot;type&quot;] =3D CONTEXT_AARCH64_EL1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;register&=
quot; not in ctx:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx[=
k][&quot;register&quot;] =3D []<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_size =3D len(c=
tx[k][&quot;register&quot;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D 0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;minimal-s=
ize&quot; in ctx:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
 =3D ctx[k][&quot;minimal-size&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D max(size,=
 reg_size)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D (size + 1=
) % 0xFFFE<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Version<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(ctx_data,=
 0, 2)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(ctx_data,=
 ctx[k][&quot;type&quot;], 2)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(ctx_data,=
 8 * size, 4)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for r in ctx[k][&q=
uot;register&quot;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=
_add(ctx_data, r, 8)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in range(reg=
_size, size):=C2=A0 =C2=A0# pylint: disable=3DW0612<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=
_add(ctx_data, 0, 8)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Vendor-specific bytes are not grouped<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor_data =3D bytearray()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if vendor:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in sorted(vendor.keys()):<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for b in vendor[k]=
[&quot;bytes&quot;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=
_add(vendor_data, b, 1)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Encode ARM Processor Error<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D bytearray()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(data, cper[&quot;valid&quot;], 4)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(data, error_info_num, 2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(data, context_info_num, 2)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Calculate the length of the CPER data<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cper_length =3D ACPI_GHES_ARM_CPER_LENGTH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cper_length +=3D len(pei_data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cper_length +=3D len(vendor_data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cper_length +=3D len(ctx_data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(data, cper_length, 4)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(data, arg.get(&quot;affinity-level&qu=
ot;, 0), 1)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Reserved<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(data, 0, 3)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(data, arg.get(&quot;mpidr-el1&quot;, =
0), 8)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(data, arg.get(&quot;midr-el1&quot;, 0=
), 8)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(data, cper[&quot;running-state&quot;]=
, 4)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_add(data, arg.get(&quot;psci-state&quot;,=
 0), 4)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Add PEI<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data.extend(pei_data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data.extend(ctx_data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data.extend(vendor_data)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.data =3D data<br>
+<br>
+=C2=A0 =C2=A0 def run(self, host, port):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Execute QMP commands&quot;&q=
uot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 guid =3D to_guid(0xE19E3D16, 0xBC11, 0x11E4,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0[0x9C, 0xAA, 0xC2, 0x05,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x1D, 0x5D, 0x46, 0xB0])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_command(host, port, guid, self.data)<br>
diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py<br>
new file mode 100755<br>
index 000000000000..8415ccbbc53d<br>
--- /dev/null<br>
+++ b/scripts/ghes_inject.py<br>
@@ -0,0 +1,59 @@<br>
+#!/usr/bin/env python3<br>
+#<br>
+# pylint: disable=3DC0301, C0114<br>
+# SPDX-License-Identifier: GPL-2.0<br>
+#<br>
+# Copyright (C) 2024 Mauro Carvalho Chehab &lt;<a href=3D"mailto:mchehab%2=
Bhuawei@kernel.org" target=3D"_blank">mchehab+huawei@kernel.org</a>&gt;<br>
+<br>
+import argparse<br>
+<br>
+from arm_processor_error import ArmProcessorEinj<br>
+<br>
+EINJ_DESCRIPTION =3D &quot;&quot;&quot;<br>
+Handle ACPI GHESv2 error injection logic QEMU QMP interface.\n<br>
+<br>
+It allows using UEFI BIOS EINJ features to generate GHES records.<br>
+<br>
+It helps testing Linux CPER and GHES drivers and to test rasdaemon<br>
+error handling logic.<br>
+<br>
+Currently, it support ARM processor error injection for ARM processor<br>
+events, being compatible with UEFI 2.9A Errata.<br>
+<br>
+This small utility works together with those QEMU additions:<br>
+- <a href=3D"https://gitlab.com/mchehab_kernel/qemu/-/tree/arm-error-injec=
t-v2" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/mchehab_kerne=
l/qemu/-/tree/arm-error-inject-v2</a><br>
+&quot;&quot;&quot;<br>
+<br>
+def main():<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Main program&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 # Main parser - handle generic args like QEMU QMP TCP socket=
 options<br>
+=C2=A0 =C2=A0 parser =3D argparse.ArgumentParser(prog=3D&quot;einj.py&quot=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0formatter_class=
=3Dargparse.RawDescriptionHelpFormatter,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage=3D&quot;%(=
prog)s [options]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0description=3DEI=
NJ_DESCRIPTION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0epilog=3D&quot;I=
f a field is not defined, a default value will be applied by QEMU.&quot;)<b=
r>
+<br>
+=C2=A0 =C2=A0 g_options =3D parser.add_argument_group(&quot;QEMU QMP socke=
t options&quot;)<br>
+=C2=A0 =C2=A0 g_options.add_argument(&quot;-H&quot;, &quot;--host&quot;, d=
efault=3D&quot;localhost&quot;, type=3Dstr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;host name&quot;)<br>
+=C2=A0 =C2=A0 g_options.add_argument(&quot;-P&quot;, &quot;--port&quot;, d=
efault=3D4445, type=3Dint,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;TCP port number&quot;)<br>
+<br>
+=C2=A0 =C2=A0 arm_einj =3D ArmProcessorEinj()<br>
+<br>
+=C2=A0 =C2=A0 # Call subparsers<br>
+=C2=A0 =C2=A0 subparsers =3D parser.add_subparsers(dest=3D&#39;command&#39=
;)<br>
+<br>
+=C2=A0 =C2=A0 arm_einj.create_subparser(subparsers)<br>
+<br>
+=C2=A0 =C2=A0 args =3D parser.parse_args()<br>
+<br>
+=C2=A0 =C2=A0 # Handle subparser commands<br>
+=C2=A0 =C2=A0 if args.command =3D=3D &quot;arm&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arm_einj.parse_args(args)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arm_einj.run(args.host, args.port)<br>
+<br>
+<br>
+if __name__ =3D=3D &quot;__main__&quot;:<br>
+=C2=A0 =C2=A0 main()<br>
diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py<br>
new file mode 100644<br>
index 000000000000..13fae7a7af0e<br>
--- /dev/null<br>
+++ b/scripts/qmp_helper.py<br></blockquote><div><br></div><div>I&#39;m goi=
ng to admit I only glanced at this very briefly, but -- is there a chance y=
ou could use qemu.git/python/qemu/qmp instead of writing your own helpers h=
ere?</div><div><br></div><div>If *NOT*, is there something that I need to a=
dd to our QMP library to facilitate your script?<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
@@ -0,0 +1,249 @@<br>
+#!/usr/bin/env python3<br>
+#<br>
+# pylint: disable=3DC0301, C0114, R0912, R0913, R0915, W0511<br>
+# SPDX-License-Identifier: GPL-2.0<br>
+#<br>
+# Copyright (C) 2024 Mauro Carvalho Chehab &lt;<a href=3D"mailto:mchehab%2=
Bhuawei@kernel.org" target=3D"_blank">mchehab+huawei@kernel.org</a>&gt;<br>
+<br>
+import json<br>
+import socket<br>
+import sys<br>
+<br>
+from base64 import b64encode<br>
+<br>
+#<br>
+# Socket QMP send command<br>
+#<br>
+def qmp_command(host, port, guid, data):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Send commands to QEMU though QMP TCP socke=
t&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 # Fill the commands to be sent<br>
+=C2=A0 =C2=A0 commands =3D []<br>
+<br>
+=C2=A0 =C2=A0 # Needed to negotiate QMP and for QEMU to accept the command=
<br>
+=C2=A0 =C2=A0 commands.append(&#39;{ &quot;execute&quot;: &quot;qmp_capabi=
lities&quot; } &#39;)<br>
+<br>
+=C2=A0 =C2=A0 base64_data =3D b64encode(bytes(data)).decode(&#39;ascii&#39=
;)<br>
+<br>
+=C2=A0 =C2=A0 cmd_arg =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;cper&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;notification-type&#39;: gui=
d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;raw-data&quot;: base64_dat=
a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 command =3D &#39;{ &quot;execute&quot;: &quot;ghes-cper&quot=
;, &#39;<br>
+=C2=A0 =C2=A0 command +=3D &#39;&quot;arguments&quot;: &#39; + json.dumps(=
cmd_arg) + &quot; }&quot;<br>
+<br>
+=C2=A0 =C2=A0 commands.append(command)<br>
+<br>
+=C2=A0 =C2=A0 s =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s.connect((host, port))<br>
+=C2=A0 =C2=A0 except ConnectionRefusedError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(f&quot;Can&#39;t connect to QMP host =
{host}:{port}&quot;)<br></blockquote><div><br></div><div>You should be able=
 to use e.g.</div><div><br></div><div>legacy.py&#39;s QEMUMonitorProtocol c=
lass for synchronous connections, e.g.</div><div><br></div><div>from qemu.q=
mp.legacy import QEMUMonitorProtocol</div><div><br></div><div>qmp =3D QEMUM=
onitorProtocol((host, port))</div><div>qmp.connect(negotiate=3DTrue)</div><=
div><br></div><div>If you want to run the script w/o setting up a virtual e=
nvironment or installing the package, take a look at the hacks in scripts/q=
mp/ for how I support e.g. qom-get directly from the source tree.<br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 data =3D s.recv(1024)<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D json.loads(data.decode(&quot;utf-8&quo=
t;))<br>
+=C2=A0 =C2=A0 except json.JSONDecodeError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Invalid QMP answer: {e}&quot;)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 if &quot;QMP&quot; not in obj:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Invalid QMP answer: {data.decode(=
&quot;utf-8&quot;)}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 for i, command in enumerate(commands):<br></blockquote><div>=
<br></div><div>Then here you&#39;d use qmp.cmd (raises exception on QMPErro=
r) or qmp.cmd_raw or qmp.cmd_obj (returns the QMP response as the return va=
lue even if it was an error.)</div><div><br></div><div>More details: <a hre=
f=3D"https://qemu.readthedocs.io/projects/python-qemu-qmp/en/latest/qemu.qm=
p.legacy.html">https://qemu.readthedocs.io/projects/python-qemu-qmp/en/late=
st/qemu.qmp.legacy.html</a></div><div><br></div><div>There&#39;s also an as=
ync version, but it doesn&#39;t look like you require that complexity, so y=
ou can ignore it.<br></div><div><br></div><div>~~js<br></div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s.sendall(command.encode(&quot;utf-8&quot;))<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D s.recv(1024)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D json.loads(data.decode(&=
quot;utf-8&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except json.JSONDecodeError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Invalid QMP answer:=
 {e}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(obj.get(&quot;return&quot;), dic=
t):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if obj[&quot;return&quot;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(json.dumps(o=
bj[&quot;return&quot;]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif i &gt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Error =
injected.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif isinstance(obj.get(&quot;error&quot;), di=
ct):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D obj[&quot;error&quot;]=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&#39;{error[&quot;class&q=
uot;]}: {error[&quot;desc&quot;]}&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(json.dumps(obj))<br>
+<br>
+=C2=A0 =C2=A0 s.shutdown(socket.SHUT_WR)<br>
+=C2=A0 =C2=A0 while 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D s.recv(1024)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if data =3D=3D b&quot;&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D json.loads(data.decode(&=
quot;utf-8&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except json.JSONDecodeError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Invalid QMP answer:=
 {e}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(obj.get(&quot;return&quot;), dic=
t):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(json.dumps(obj[&quot;retur=
n&quot;]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(obj.get(&quot;error&quot;), dict=
):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D obj[&quot;error&quot;]=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&#39;{error[&quot;class&q=
uot;]}: {error[&quot;desc&quot;]}&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(json.dumps(obj))<br>
+<br>
+=C2=A0 =C2=A0 s.close()<br>
+<br>
+<br>
+#<br>
+# Helper routines to handle multiple choice arguments<br>
+#<br>
+def get_choice(name, value, choices, suffixes=3DNone):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Produce a list from multiple choice argume=
nt&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 new_values =3D 0<br>
+<br>
+=C2=A0 =C2=A0 if not value:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return new_values<br>
+<br>
+=C2=A0 =C2=A0 for val in value.split(&quot;,&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D val.lower()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if suffixes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for suffix in suffixes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D val.remove=
suffix(suffix)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if val not in choices.keys():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(f&quot;Error on &#39;{n=
ame}&#39;: choice {val} is invalid.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D choices[val]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_values |=3D val<br>
+<br>
+=C2=A0 =C2=A0 return new_values<br>
+<br>
+<br>
+def get_mult_array(mult, name, values, allow_zero=3DFalse, max_val=3DNone)=
:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Add numbered hashes from integer lists&quo=
t;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 if not allow_zero:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not values:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if values is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not values:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if i not in mult:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mult[i] =3D {}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mult[i][name] =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 i =3D 0<br>
+=C2=A0 =C2=A0 for value in values:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for val in value.split(&quot;,&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D int(val, 0=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except ValueError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(f&quot;Er=
ror on &#39;{name}&#39;: {val} is not an integer&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if val &lt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(f&quot;Er=
ror on &#39;{name}&#39;: {val} is not unsigned&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if max_val and val &gt; max_val:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(f&quot;Er=
ror on &#39;{name}&#39;: {val} is too little&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if i not in mult:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mult[i] =3D {}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if name not in mult[i]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mult[i][name] =3D =
[]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mult[i][name].append(val)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i +=3D 1<br>
+<br>
+<br>
+def get_mult_choices(mult, name, values, choices,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0suffixes=3DNone, allow_zero=3DFalse):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Add numbered hashes from multiple choice a=
rguments&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 if not allow_zero:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not values:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if values is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 i =3D 0<br>
+=C2=A0 =C2=A0 for val in values:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_values =3D get_choice(name, val, choices, =
suffixes)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if i not in mult:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mult[i] =3D {}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mult[i][name] =3D new_values<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i +=3D 1<br>
+<br>
+<br>
+def get_mult_int(mult, name, values, allow_zero=3DFalse):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Add numbered hashes from integer arguments=
&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if not allow_zero:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not values:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if values is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 i =3D 0<br>
+=C2=A0 =C2=A0 for val in values:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D int(val, 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except ValueError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(f&quot;Error on &#39;{n=
ame}&#39;: {val} is not an integer&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if val &lt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(f&quot;Error on &#39;{n=
ame}&#39;: {val} is not unsigned&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if i not in mult:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mult[i] =3D {}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mult[i][name] =3D val<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i +=3D 1<br>
+<br>
+<br>
+#<br>
+# Data encode helper functions<br>
+#<br>
+def bit(b):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Simple macro to define a bit on a bitmask&=
quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 return 1 &lt;&lt; b<br>
+<br>
+<br>
+def data_add(data, value, num_bytes):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Adds bytes from value inside a bitarray&qu=
ot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 data.extend(value.to_bytes(num_bytes, byteorder=3D&quot;litt=
le&quot;))<br>
+<br>
+def to_guid(time_low, time_mid, time_high, nodes):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Create an GUID string&quot;&quot;&quot;<br=
>
+<br>
+=C2=A0 =C2=A0 assert(len(nodes) =3D=3D 8)<br>
+<br>
+=C2=A0 =C2=A0 clock =3D nodes[0] &lt;&lt; 8 | nodes[1]<br>
+<br>
+=C2=A0 =C2=A0 node =3D 0<br>
+=C2=A0 =C2=A0 for i in range(2, len(nodes)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D node &lt;&lt; 8 | nodes[i]<br>
+<br>
+=C2=A0 =C2=A0 s =3D f&quot;{time_low:08x}-{time_mid:04x}-&quot;<br>
+=C2=A0 =C2=A0 s +=3D f&quot;{time_high:04x}-{clock:04x}-{node:012x}&quot;<=
br>
+<br>
+=C2=A0 =C2=A0 return s<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div></div>

--0000000000003c2407061f329d17--


