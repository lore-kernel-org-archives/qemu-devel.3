Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69992C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 12:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYOdQ-0005XR-9u; Thu, 16 Jan 2025 07:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tYOdN-0005XA-Vq
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tYOdL-00048C-HO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737029152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6Bp0KAjpvMk95VXBO+I/VCRNv3QHTB8x4opGzeU/NU=;
 b=blxN7ox0mf/skaQFXDf8bqQVy5lExzknBVo++KScCk3ATsyQVVAo5dokpUcuVV11RST03K
 ulYzKWtukvZ1+bfuqeeB5vIjvHZHc9mkkGNkSy2GFYv4UHrpgj7pzUpQ2fJLKrpmg6x3DJ
 nij7JlKhy0eozmLEIcR/AD2/tfNaq8k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-y7j5yYLWOz25nVncdxiQBQ-1; Thu, 16 Jan 2025 07:05:49 -0500
X-MC-Unique: y7j5yYLWOz25nVncdxiQBQ-1
X-Mimecast-MFC-AGG-ID: y7j5yYLWOz25nVncdxiQBQ
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aaf901a0ef9so73710166b.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 04:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737029148; x=1737633948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6Bp0KAjpvMk95VXBO+I/VCRNv3QHTB8x4opGzeU/NU=;
 b=O2IR7IKMO4AKOfLF+ReusryQl64bsV+YU+kaaizHHfrrjYGrzXq1jpTu0hBA65Nsv3
 gFMRR8TiW2E+7tbIq9F5P/FizWkF+0aX3nCNObuCQPokzzcPps530crI9Fqc88dM5A7V
 f+XPCB8TjcuQ8jBZm8i2T204MY6Qz/CfWYOsNhr7D8GkBYDfVMSxs5PXNakHrru7OPpw
 Elt/zgQfl5u4FSnpUC2Q2nM4xR+Oxa5/TC00GBNDbiv9wbvkldRjHEjlDBOUXRuJFC7f
 xXVgltqxndBzB9QVOwIEwVl9yug2v8XqyOFyMBAxSSFHhcLKPmMDtiXvwyGp6k2NcyaP
 0jjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjNLPIgPI2imQkZ+0QKszytz4VdCKZtdrOXO6gNFzGj9TVkrhlembwzDiPrxriP5rM7v0bjoPyHP/A@nongnu.org
X-Gm-Message-State: AOJu0YwoSusr9QAJuLu/8B/pX4HVydSF4v3TNGe1IeFAhv+4JOU+hOKo
 uNbUblezhw84EDxsLm96EEl9GKmM0vZsrw52GmvBbyqTnP7GbaD2H4sSVtB7fQBnM9zXY44M6sF
 0MS7P0xrGSVlhzbzgltfEimaV1Tz47A4BuVlMhbim5QhevmUG0RsgmEiTSr99KJ+g360bk+ZDsn
 APAT05QuVP3G18XYULB+XUPjV72wI=
X-Gm-Gg: ASbGncuZr3DoBuRMy/1a8xpC9fL/TBryDBdDX4D/8OgLEeVI2jFqRLqqG0eBMewRadk
 /vkUHSkEEUtGl7wJu5omKoSLnkmNoIrDqw/Q16is=
X-Received: by 2002:a17:907:97d2:b0:aab:73c5:836 with SMTP id
 a640c23a62f3a-ab2ab711bfemr3142775766b.32.1737029148259; 
 Thu, 16 Jan 2025 04:05:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn/OLLF1GgXnRkQDiBQp8eTqXRhr+n0R6mNuF8XFs+8T8Cx/e1uEPh3W8W/aU1hrqqCZj5vSbkFzsLn82+Z9Q=
X-Received: by 2002:a17:907:97d2:b0:aab:73c5:836 with SMTP id
 a640c23a62f3a-ab2ab711bfemr3142773866b.32.1737029147876; Thu, 16 Jan 2025
 04:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20250110104619.267564-1-anisinha@redhat.com>
 <20250110104619.267564-4-anisinha@redhat.com>
In-Reply-To: <20250110104619.267564-4-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 16 Jan 2025 17:35:36 +0530
X-Gm-Features: AbW1kvb7tHBDgGO355XN8mKlNp-JGMNqXNOswUtA-9bW1xlSMYh1iVemBipnquU
Message-ID: <CAK3XEhPyfAy1sC+TRF9wR94F6EOj7TBsV4tVnTiizLpG0XkpLg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] tests/qtest/vmcoreinfo: add a unit test to
 exercize basic vmcoreinfo function
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Jan 10, 2025 at 4:16=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> A new qtest is written that exercizes the fw-cfg DMA based read and write=
 ops
> to write values into vmcoreinfo fw-cfg file and read them back and varify=
 that
> they are the same.
>

Ping ...

> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  MAINTAINERS                   |  2 +
>  tests/qtest/meson.build       |  1 +
>  tests/qtest/vmcoreinfo-test.c | 90 +++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 tests/qtest/vmcoreinfo-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2101b51217..4723d413ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3005,6 +3005,7 @@ F: include/system/device_tree.h
>  Dump
>  S: Supported
>  M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> +R: Ani Sinha <anisinha@redhat.com>
>  F: dump/
>  F: hw/misc/vmcoreinfo.c
>  F: include/hw/misc/vmcoreinfo.h
> @@ -3015,6 +3016,7 @@ F: qapi/dump.json
>  F: scripts/dump-guest-memory.py
>  F: stubs/dump.c
>  F: docs/specs/vmcoreinfo.rst
> +F: tests/qtest/vmcoreinfo-test.c
>
>  Error reporting
>  M: Markus Armbruster <armbru@redhat.com>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index c5a70021c5..9804451e25 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -57,6 +57,7 @@ qtests_i386 =3D \
>    (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +=
                    \
>    (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +  =
                    \
>    (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +=
                    \
> +  (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test']=
 : []) +            \
>    (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +=
                    \
>    (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +   =
                    \
>    (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +  =
                    \
> diff --git a/tests/qtest/vmcoreinfo-test.c b/tests/qtest/vmcoreinfo-test.=
c
> new file mode 100644
> index 0000000000..dcf3b5ae05
> --- /dev/null
> +++ b/tests/qtest/vmcoreinfo-test.c
> @@ -0,0 +1,90 @@
> +/*
> + * qtest vmcoreinfo test case
> + *
> + * Copyright Red Hat. 2025.
> + *
> + * Authors:
> + *  Ani Sinha   <anisinha@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "libqos/libqos-pc.h"
> +#include "libqtest.h"
> +#include "standard-headers/linux/qemu_fw_cfg.h"
> +#include "libqos/fw_cfg.h"
> +#include "qemu/bswap.h"
> +#include "hw/misc/vmcoreinfo.h"
> +
> +static void test_vmcoreinfo_write_basic(void)
> +{
> +    QFWCFG *fw_cfg;
> +    QOSState *qs;
> +    FWCfgVMCoreInfo info;
> +    size_t filesize;
> +    uint16_t guest_format;
> +    uint16_t host_format;
> +    uint32_t size;
> +    uint64_t paddr;
> +
> +    qs =3D qtest_pc_boot("-device vmcoreinfo");
> +    fw_cfg =3D pc_fw_cfg_init(qs->qts);
> +
> +    memset(&info, 0 , sizeof(info));
> +    /* read vmcoreinfo and read back the host format */
> +    filesize =3D qfw_cfg_read_file(fw_cfg, qs, FW_CFG_VMCOREINFO_FILENAM=
E,
> +                                &info, sizeof(info));
> +    g_assert_cmpint(filesize, =3D=3D, sizeof(info));
> +
> +    host_format =3D le16_to_cpu(info.host_format);
> +    g_assert_cmpint(host_format, =3D=3D, FW_CFG_VMCOREINFO_FORMAT_ELF);
> +
> +    memset(&info, 0 , sizeof(info));
> +    info.guest_format =3D cpu_to_le16(FW_CFG_VMCOREINFO_FORMAT_ELF);
> +    info.size =3D cpu_to_le32(1 * MiB);
> +    info.paddr =3D cpu_to_le64(0xffffff00);
> +    info.host_format =3D cpu_to_le16(host_format);
> +
> +    /* write the values to the host */
> +    filesize =3D qfw_cfg_write_file(fw_cfg, qs, FW_CFG_VMCOREINFO_FILENA=
ME,
> +                                  &info, sizeof(info));
> +    g_assert_cmpint(filesize, =3D=3D, sizeof(info));
> +
> +    memset(&info, 0 , sizeof(info));
> +
> +    /* now read back the values we wrote and compare that they are the s=
ame */
> +    filesize =3D qfw_cfg_read_file(fw_cfg, qs, FW_CFG_VMCOREINFO_FILENAM=
E,
> +                                &info, sizeof(info));
> +    g_assert_cmpint(filesize, =3D=3D, sizeof(info));
> +
> +    size =3D le32_to_cpu(info.size);
> +    paddr =3D le64_to_cpu(info.paddr);
> +    guest_format =3D le16_to_cpu(info.guest_format);
> +
> +    g_assert_cmpint(size, =3D=3D, 1 * MiB);
> +    g_assert_cmpint(paddr, =3D=3D, 0xffffff00);
> +    g_assert_cmpint(guest_format, =3D=3D, FW_CFG_VMCOREINFO_FORMAT_ELF);
> +
> +    pc_fw_cfg_uninit(fw_cfg);
> +    qtest_shutdown(qs);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    const char *arch =3D qtest_get_arch();
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
> +        /* skip for non-x86 */
> +        exit(EXIT_SUCCESS);
> +    }
> +
> +    qtest_add_func("vmcoreinfo/basic-write",
> +                   test_vmcoreinfo_write_basic);
> +
> +    return g_test_run();
> +}
> --
> 2.45.2
>


