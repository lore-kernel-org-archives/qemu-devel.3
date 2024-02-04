Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F1BC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 20:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWifV-0004Ak-C0; Sun, 04 Feb 2024 15:00:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rWifR-00049m-D6
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 15:00:41 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rWifO-0005Dq-RR
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 15:00:41 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40ef3f351d2so26933725e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 12:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707076835; x=1707681635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=or3cPuPgT8c+WmLoTmfZpvuCDdPLRzLETvAjBlWPbNQ=;
 b=OoqCpsydxNL3rjiUIHI5ub2EhmHFSSIquF2tNxApE4a5e9Jvc1I6lmHfm2L0/RaAyl
 ApiXFncOwB2HXV4902rpjEdJyYgMH6NwU4LNQ/DIOjutJ3YPJwPl1XDR3lZACq2acNPP
 GUZIAIhQc8+QxeQ3wVMUixUhjyCoL4527g9qyH0plJZN77PldDGo4/4pjSJb105SmCiO
 Sh7/uZqd+1bXLf6PneBOPaNeGv+yJXjPcab/XtjEYNhdxG0NdK1V5nJPp4CQ31L9P/Pp
 Ck/Dre2MDhjLzmyYGrsYwA7vKbMSgz1Ru6JSHvnsIImdJDlGP7gVcZ/3JkkhR+H2IWlL
 IDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707076835; x=1707681635;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=or3cPuPgT8c+WmLoTmfZpvuCDdPLRzLETvAjBlWPbNQ=;
 b=e6e/3DWrVsbeYoTlcAg1TPN4lvVKrg0oOjoRlJsiYC4Wda3pzy3sqVGI/C0SHmXhiG
 aZ0ll04Y1Rma2ZxwOaGMCpGZ1ALCGsfg/kLTgSO3qQK8kJAPnZSVfkk1FXryJkCqxF6T
 T9bAf0sgePbOImzF9l5IZHVjwJdCbVIENskAInod+lZGgC82sO1GJ4FXwLZijlD9rH75
 5IBixgLbCSKIHM3Rqmy8vO/Z9wp2kez/1OUNtw9GME8KubNmHm1GAn5y10xMOZIUYsOk
 ImdsmhWciGbE0E74rf6SuOvH3ggczLDAEfLgKNUSR2G4hpf22KoKz6iryZ7U2P02WP7A
 nHgA==
X-Gm-Message-State: AOJu0YxPjxEGU1AHafUEEblm9l3Jc/VUezZHZf2xAYNnaBUrujH1vwaB
 GhsHBmandBp6fPAIF+W0YRWcCLwPYqT71C5yyxEp9OvCeBFGF3ZgkfRkJNqg
X-Google-Smtp-Source: AGHT+IF3O2+7xu3KyvaqBM2bUmpWxOB8FZJEQDAiRbeBANsB/efHN9v0J75SM1d7RMVZJH6kWtS+CA==
X-Received: by 2002:a05:600c:35cc:b0:40f:cb0d:4de6 with SMTP id
 r12-20020a05600c35cc00b0040fcb0d4de6mr2757146wmq.5.1707076834965; 
 Sun, 04 Feb 2024 12:00:34 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXJO/9ZxesvXCZ7zbckdx0W2jlqAoP0A/CYFBLpX82Cbp5AUA3Rprf5I2pDy1pxjGSGqTCo1ZFv2YZhyrp3GWZb6GSt
Received: from ?IPv6:::1?
 (p200300faaf172400f91c3a0c834573ad.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:f91c:3a0c:8345:73ad])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c358400b0040fb7c87c73sm6561043wmq.45.2024.02.04.12.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Feb 2024 12:00:34 -0800 (PST)
Date: Sun, 04 Feb 2024 20:00:31 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
CC: philmd@linaro.org
Subject: Re: [PATCH 2/4] isa: extract FDC37M81X to a separate file
In-Reply-To: <20240129133751.1106716-3-pbonzini@redhat.com>
References: <20240129133751.1106716-1-pbonzini@redhat.com>
 <20240129133751.1106716-3-pbonzini@redhat.com>
Message-ID: <E227AD11-6FA5-4FB0-9238-86101F71C80D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
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



Am 29=2E Januar 2024 13:37:46 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>isa-superio=2Ec currently defines a SuperIO chip that depends on
>CONFIG_IDE_ISA, but not all users of isa-superio=2Ec depend on that
>symbol=2E  Extract the chip to a separate file so that there is an
>obvious place to select IDE_ISA=2E
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> hw/isa/fdc37m81x-superio=2Ec | 37 +++++++++++++++++++++++++++++++++++++
> hw/isa/isa-superio=2Ec       | 19 -------------------
> hw/isa/Kconfig             |  5 +++++
> hw/isa/meson=2Ebuild         |  1 +
> hw/mips/Kconfig            |  2 +-
> 5 files changed, 44 insertions(+), 20 deletions(-)
> create mode 100644 hw/isa/fdc37m81x-superio=2Ec
>
>diff --git a/hw/isa/fdc37m81x-superio=2Ec b/hw/isa/fdc37m81x-superio=2Ec
>new file mode 100644
>index 00000000000=2E=2E5ad769b69e8
>--- /dev/null
>+++ b/hw/isa/fdc37m81x-superio=2Ec
>@@ -0,0 +1,37 @@
>+/*
>+ * Generic ISA Super I/O
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
>+/* SMS FDC37M817 Super I/O */
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
>+static const TypeInfo fdc37m81x_type_info =3D {
>+    =2Ename          =3D TYPE_FDC37M81X_SUPERIO,
>+    =2Eparent        =3D TYPE_ISA_SUPERIO,
>+    =2Einstance_size =3D sizeof(ISASuperIODevice),
>+    =2Eclass_init    =3D fdc37m81x_class_init,
>+};
>+
>+static void fdc37m81x_register_types(void)
>+{
>+    type_register_static(&fdc37m81x_type_info);
>+}
>+
>+type_init(fdc37m81x_register_types)
>diff --git a/hw/isa/isa-superio=2Ec b/hw/isa/isa-superio=2Ec
>index 7dbfc374da3=2E=2E80e0c34652e 100644
>--- a/hw/isa/isa-superio=2Ec
>+++ b/hw/isa/isa-superio=2Ec
>@@ -187,28 +187,9 @@ static const TypeInfo isa_superio_type_info =3D {
>     =2Eclass_init =3D isa_superio_class_init,
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

Isn't this assignment redundant?

>-}
>-
>-static const TypeInfo fdc37m81x_type_info =3D {
>-    =2Ename          =3D TYPE_FDC37M81X_SUPERIO,
>-    =2Eparent        =3D TYPE_ISA_SUPERIO,
>-    =2Einstance_size =3D sizeof(ISASuperIODevice),
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
>index 7884179d08b=2E=2Eaf856af052d 100644
>--- a/hw/isa/Kconfig
>+++ b/hw/isa/Kconfig
>@@ -23,6 +23,11 @@ config ISA_SUPERIO
>     # Some users of ISA_SUPERIO do not use it
>     #select IDE_ISA
>=20
>+config FDC37M81X
>+    bool

+    select ISA_SUPERIO
(in alphabetical order)

>+    select ISA_BUS

Shouldn't it `depend on ISA_BUS`? If so, the previous patch should be adap=
ted as well=2E

>+    select IDE_ISA

Not needed=2E This device doesn't have an IDE interface=2E

Best regards,
Bernhard

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
>index ab61af209a0=2E=2E94b969c21db 100644
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

