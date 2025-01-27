Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D0FC0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 07:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcJJ4-0001s5-LC; Mon, 27 Jan 2025 02:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tcJJ1-0001r6-Rh
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 02:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tcJJ0-0004Sy-6N
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 02:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737961988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42qvlL78dnfS82bVP/f5tqzc+D9Sj9D/8AjVq5MHdww=;
 b=TtDXuVCtf2FgS/zbL8UXEIqYpbD67tOrVDFy/AMzSsNe1eanSgvYo6dtqZB7T7Why7qnqK
 5nVFLga28vZYrXW90UeTycuqEPWhKba/Na5sSoHN+9S7jl8kVp1K5OCdCbjcPxudi6fdpj
 cc+q07lCXKGLZ61ezChL6xDnYjJk304=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-t5HdofidPmSgkpAUXYd15Q-1; Mon, 27 Jan 2025 02:13:04 -0500
X-MC-Unique: t5HdofidPmSgkpAUXYd15Q-1
X-Mimecast-MFC-AGG-ID: t5HdofidPmSgkpAUXYd15Q
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab6930f94b7so113114766b.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 23:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737961983; x=1738566783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42qvlL78dnfS82bVP/f5tqzc+D9Sj9D/8AjVq5MHdww=;
 b=GHMoA/L8TRhP3eH/aiJSWIpdpBIuhQHQFk88S0kvHSYt8ppguoZfpOklQLHA+Ffd7V
 FpNM+4t2emqFcOONQeeNxDsXBpEfVQOdzqCMjPCyV42GregybL+f+OrCjdP/G0W8Qe99
 UdhwwFxt0TAkScnqXrOQ4HsC4TAJ2E8vUjrFb4rmK3iqyDnKey11lt0r8xXmxafqT3tP
 pjJgRZ53sItesQDyAigc5IJ1CUqySSna+Bhi4WQ8R4OyEM/6sQLa4FDngJpS1tyPjyrf
 wxjJvIieIwdQRDHB7T1KkKqTRRKwxkU1O3L5+k74f3WXYXFMxSS2cl3Qk3dqdr+pRsW8
 Z0yQ==
X-Gm-Message-State: AOJu0YzCffWVhop8ny7aRsw0HmzsH8pn+D6iM2edmTviVkBYefeUZlNs
 uoFNTTGh0MK6cHX0/Gbk9PKFEvPon5jE5ZMDESqvqEiNRaCuGKPCOwxs1OCg6f4EAETYE7Q4dcn
 j3r07Toyttchudy9G1sNDbug9J8VheRMghyc/VGfioDyIRF+NtPFb9BH7VClwGoJgizrU/iHomd
 UHMU4UK9h4jwj+LEftyJhLYQmadPg=
X-Gm-Gg: ASbGncsyNKa3gNf111UuFMSfEDaaO/aoOs0xN4Zgnkcva2ptZ6CMIqrDxUheBiwiWSg
 fId/ATjbGg0FzrBqNKNfV3eEE6rXhU9xirZIvtPfTnCp1QdzYOvaKPIAcn6cYcUc2
X-Received: by 2002:a17:907:2d8c:b0:ab6:53fb:a290 with SMTP id
 a640c23a62f3a-ab653fbaaa8mr2138483066b.27.1737961983162; 
 Sun, 26 Jan 2025 23:13:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2RX8m4YbyLj83FrUXfVZO39ZVU6q95oZEsPdpAN13roSSf9lOOt3SgXU7k2iBJBjgWHVgNduow4afzzfhTgM=
X-Received: by 2002:a17:907:2d8c:b0:ab6:53fb:a290 with SMTP id
 a640c23a62f3a-ab653fbaaa8mr2138481366b.27.1737961982741; Sun, 26 Jan 2025
 23:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20250120043847.954881-1-anisinha@redhat.com>
 <20250120043847.954881-4-anisinha@redhat.com>
In-Reply-To: <20250120043847.954881-4-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 27 Jan 2025 12:42:51 +0530
X-Gm-Features: AWEUYZloLw7zZlKAmlzYhzBI7-15W7hhGQ5XdVKmdN3COQ74zp0CfRn3eqTGrk4
Message-ID: <CAK3XEhOddr9qx+9kuMPn8nMftO8aAJLWiX51VH4UNvAx0LnJEQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tests/qtest/vmcoreinfo: add a unit test to
 exercize basic vmcoreinfo function
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 20, 2025 at 10:09=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> A new qtest is written that exercizes the fw-cfg DMA based read and write=
 ops
> to write values into vmcoreinfo fw-cfg file and read them back and verify=
 that
> they are the same.
>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Final ping on this patch.

> ---
>  MAINTAINERS                   |  2 +
>  tests/qtest/meson.build       |  1 +
>  tests/qtest/vmcoreinfo-test.c | 90 +++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 tests/qtest/vmcoreinfo-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 846b81e3ec..57167c3c73 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3016,6 +3016,7 @@ F: include/system/device_tree.h
>  Dump
>  S: Supported
>  M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> +R: Ani Sinha <anisinha@redhat.com>
>  F: dump/
>  F: hw/misc/vmcoreinfo.c
>  F: include/hw/misc/vmcoreinfo.h
> @@ -3026,6 +3027,7 @@ F: qapi/dump.json
>  F: scripts/dump-guest-memory.py
>  F: stubs/dump.c
>  F: docs/specs/vmcoreinfo.rst
> +F: tests/qtest/vmcoreinfo-test.c
>
>  Error reporting
>  M: Markus Armbruster <armbru@redhat.com>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 94b28e5a53..fc669336a6 100644
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


