Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01BCC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZy7d-0005za-8v; Tue, 13 Feb 2024 14:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rZy7Z-0005x0-Qd
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:07:10 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rZy7X-0000Bk-UP
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:07:09 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so189530266b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707851224; x=1708456024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hzjt7uRp4YurEkm37kV+ZwNKR8f+l2xXJvaxFgIpTX8=;
 b=FpLw/pfIlzrWJISZc0TQguD8PkLxsjq+ZamG52Y6u9gdyfYpmiM/7GU86MFxrR00y2
 4BdamPA11/NiQ449xy9CC4rsjjggJejRXpWKfwX2iZ8DlnCbXS+Jm1IQgcNL1aAkZqVA
 xOJtH3aQAruEWlpg/Eu4qf1vQGWb3e0F8Alr27Wn5sImcyILJG0FuG8WVbC3Zpabn1oI
 AAsQ7Rnlx7kgUrQrrv1CVOQKtf1/E7vE1BNH4rAhCuebyT9ZazQXiRkhrAne4L2aGDk2
 RWjqCnFjT7mrLTS6ulA1bWcWGzvSniAFD2lA+V4cbGb/MEDISo9rom+gpMi8sEs+55/G
 JWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707851224; x=1708456024;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hzjt7uRp4YurEkm37kV+ZwNKR8f+l2xXJvaxFgIpTX8=;
 b=XUNngBcYXCna/Y56mWYvImXF5B+vfrQZBURzEYCJiMwRgtH4kgezVUNuGwCjCRVxxa
 ZQGcWVpqJop5T5ORcb1p1gGa5FDHAeTHen3+aXK39Egnv0oGwnBYr3X+wErTpLXV0hFZ
 gr36ONV6Z6zwb9oDHG2jHEhqBitoDBSa0X8+53yNCPp3lw/nrO96ycQrO41MuMk+R+uJ
 VTcXZ0dZp4XGy2bizjOmfRo3KtIpq7rsBtELUJ6ch6FyWN3zefvTbff7GdA46HmE0fwW
 v+r2aP3OeVEUw+an9ij9Wb35mGLTuACR2ULDKaI+KzQcBF5zq1KZhgP1vCdJgreuksPu
 VAHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuKyiGYOM80Bh2WAt+zLyeFW4bmhaIH/cj1kQi2akVVee/eirhSJBW/4kyqvoQeQVVDg1aR2aFlvg9MwgGZJSp5Zg5Df0=
X-Gm-Message-State: AOJu0YzOnkRu4WdLAXOYcodxECxHYmEjAqNqtdw22J8sSHMU6B8S7HuH
 9575XDilKp1b9bPutHOTbFlXV7P4Dm/YBS3lW4rlvhCxuAXSdNqH
X-Google-Smtp-Source: AGHT+IEIHGvAJs8fDtOD8A48lj/jvmvYRRjNxlr59LUPmhj1+lZKlU/IvcS5qGmYv37Fi9dudmqJFQ==
X-Received: by 2002:a17:906:b48:b0:a3c:a3eb:6109 with SMTP id
 v8-20020a1709060b4800b00a3ca3eb6109mr198518ejg.14.1707851224389; 
 Tue, 13 Feb 2024 11:07:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXuhcqxUBLv959x8dT41mjB3NkI1iHiyNzrLQ9BtZ15d11aaOvLdKEQ6JacHLRcMS6Y7SPioTYfmuRr6TCMqDWgJNR4xRumzB+PhHn23ONFcnCc/DvJNLAJVg==
Received: from [127.0.0.1] (dynamic-089-012-064-238.89.12.pool.telefonica.de.
 [89.12.64.238]) by smtp.gmail.com with ESMTPSA id
 w22-20020a170906481600b00a3c5661c646sm1557646ejq.148.2024.02.13.11.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 11:07:04 -0800 (PST)
Date: Tue, 13 Feb 2024 19:07:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
CC: philmd@linaro.org, balaton@eik.bme.hu
Subject: Re: [PATCH v3 6/9] isa: extract FDC37M81X to a separate file
In-Reply-To: <20240213155005.109954-7-pbonzini@redhat.com>
References: <20240213155005.109954-1-pbonzini@redhat.com>
 <20240213155005.109954-7-pbonzini@redhat.com>
Message-ID: <110B8B05-6247-4BD3-B129-E1268184A5E8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 13=2E Februar 2024 15:50:01 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>isa-superio=2Ec currently defines a SuperIO chip that is not used
>by any other user of the file=2E  Extract the chip to a separate file=2E
>
>Reviewed-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>

I think in v2 Zoltan only pointed out a typo in the commit message (which =
is now fixed) but didn't add an R-b tag so far=2E

Best regards,
Bernhard

>Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> hw/isa/fdc37m81x-superio=2Ec | 32 ++++++++++++++++++++++++++++++++
> hw/isa/isa-superio=2Ec       | 18 ------------------
> hw/isa/Kconfig             |  4 ++++
> hw/isa/meson=2Ebuild         |  1 +
> hw/mips/Kconfig            |  2 +-
> 5 files changed, 38 insertions(+), 19 deletions(-)
> create mode 100644 hw/isa/fdc37m81x-superio=2Ec
>
>diff --git a/hw/isa/fdc37m81x-superio=2Ec b/hw/isa/fdc37m81x-superio=2Ec
>new file mode 100644
>index 00000000000=2E=2E55e91fbca17
>--- /dev/null
>+++ b/hw/isa/fdc37m81x-superio=2Ec
>@@ -0,0 +1,32 @@
>+/*
>+ * SMS FDC37M817 Super I/O
>+ *
>+ * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter=2E
>+ * See the COPYING file in the top-level directory=2E
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "hw/isa/superio=2Eh"
>+
>+static void fdc37m81x_class_init(ObjectClass *klass, void *data)
>+{
>+    ISASuperIOClass *sc =3D ISA_SUPERIO_CLASS(klass);
>+
>+    sc->serial=2Ecount =3D 2; /* NS16C550A */
>+    sc->parallel=2Ecount =3D 1;
>+    sc->floppy=2Ecount =3D 1; /* SMSC 82077AA Compatible */
>+    sc->ide=2Ecount =3D 0;
>+}
>+
>+static const TypeInfo types[] =3D {
>+    {
>+        =2Ename          =3D TYPE_FDC37M81X_SUPERIO,
>+        =2Eparent        =3D TYPE_ISA_SUPERIO,
>+        =2Eclass_init    =3D fdc37m81x_class_init,
>+    },
>+};
>+
>+DEFINE_TYPES(types)
>diff --git a/hw/isa/isa-superio=2Ec b/hw/isa/isa-superio=2Ec
>index 98d50844f71=2E=2Ea8c8c58ef7f 100644
>--- a/hw/isa/isa-superio=2Ec
>+++ b/hw/isa/isa-superio=2Ec
>@@ -190,27 +190,9 @@ static const TypeInfo isa_superio_type_info =3D {
>     =2Einstance_size =3D sizeof(ISASuperIODevice),
> };
>=20
>-/* SMS FDC37M817 Super I/O */
>-static void fdc37m81x_class_init(ObjectClass *klass, void *data)
>-{
>-    ISASuperIOClass *sc =3D ISA_SUPERIO_CLASS(klass);
>-
>-    sc->serial=2Ecount =3D 2; /* NS16C550A */
>-    sc->parallel=2Ecount =3D 1;
>-    sc->floppy=2Ecount =3D 1; /* SMSC 82077AA Compatible */
>-    sc->ide=2Ecount =3D 0;
>-}
>-
>-static const TypeInfo fdc37m81x_type_info =3D {
>-    =2Ename          =3D TYPE_FDC37M81X_SUPERIO,
>-    =2Eparent        =3D TYPE_ISA_SUPERIO,
>-    =2Eclass_init    =3D fdc37m81x_class_init,
>-};
>-
> static void isa_superio_register_types(void)
> {
>     type_register_static(&isa_superio_type_info);
>-    type_register_static(&fdc37m81x_type_info);
> }
>=20
> type_init(isa_superio_register_types)
>diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
>index 5df3c09cd51=2E=2E73c6470805c 100644
>--- a/hw/isa/Kconfig
>+++ b/hw/isa/Kconfig
>@@ -23,6 +23,10 @@ config ISA_SUPERIO
>     # Some users of ISA_SUPERIO do not use it
>     #select IDE_ISA
>=20
>+config FDC37M81X
>+    bool
>+    select ISA_SUPERIO
>+
> config PC87312
>     bool
>     select ISA_SUPERIO
>diff --git a/hw/isa/meson=2Ebuild b/hw/isa/meson=2Ebuild
>index 2ab99ce0c6b=2E=2Ef650b395071 100644
>--- a/hw/isa/meson=2Ebuild
>+++ b/hw/isa/meson=2Ebuild
>@@ -4,6 +4,7 @@ system_ss=2Eadd(when: 'CONFIG_ISA_BUS', if_true: files('i=
sa-bus=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio=
=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_PC87312', if_true: files('pc87312=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_PIIX', if_true: files('piix=2Ec'))
>+system_ss=2Eadd(when: 'CONFIG_FDC37M81X', if_true: files('fdc37m81x-supe=
rio=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-supe=
rio=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_VT82C686', if_true: files('vt82c686=2Ec'))
>=20
>diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>index afcfb2b8eca=2E=2Ee57db4f6412 100644
>--- a/hw/mips/Kconfig
>+++ b/hw/mips/Kconfig
>@@ -1,7 +1,7 @@
> config MALTA
>     bool
>+    select FDC37M81X
>     select GT64120
>-    select ISA_SUPERIO
>     select PIIX
>=20
> config MIPSSIM

