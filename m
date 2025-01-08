Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDA0E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 15:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXtm-0001xW-Vh; Wed, 08 Jan 2025 10:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVXtZ-0001tn-Hm; Wed, 08 Jan 2025 10:22:58 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVXtW-0005EQ-L7; Wed, 08 Jan 2025 10:22:56 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3ecae02beso781098a12.0; 
 Wed, 08 Jan 2025 07:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736349764; x=1736954564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+f7UOlWeL8+YCrnm6mVFVB4mI6TIS4CM7dpB1OmgzV0=;
 b=E6iKtGSXomy0zcT0G+/0UxDhSlavbOJTlqhB26IvrSWuJ6yxJg6buhPxU5ksiIC7P7
 hBeyCkKHz1bYIsjVLvqDF9XRrv9uCLxWjOodDvwUT+HAegXxSg8qCtPAuOhbQyb3oPcf
 b+hreu8MEmer/5ZhRb0sBmTqnVvADOYgUQ7jkkL9e7uteYGeRVUxbgS95RIuK+49ZxBV
 ZPM/7EFyN0YyosJDWGgmqxBgjrXidBb/ELDWh4dNT+iSKG9//rZ6xtx2NeaHAVIPtHN1
 YvYh6g3pevSppadyXSIHVacOCud24tGFpyUiN9pS5jqcjMaUx8+oppk5XPIgN3jq0IrP
 FMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736349764; x=1736954564;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+f7UOlWeL8+YCrnm6mVFVB4mI6TIS4CM7dpB1OmgzV0=;
 b=Js9wi6XtqtZVSGRuzUhf+P5WyXIEqweqd6jvXJ2Rzzf3JNX+4sS8efdUnuVg5B0x5g
 oEA48jsPBzh6+BCrL74zEUeL0JkcBe3Yvi7LN0e3QhAg5JGmZ/hu6Mda8EQNIQW7GfM1
 nyo4hxH+PGCE7bprxrI7HFCzvvtiipejQYhl+AsBjIfx1ZgvDYz9IiZv1l3tlFxzvaAJ
 zFec4WUSwkIv61idDfemX8grbMs4ivmsERZmIBfWf5rBseXjQVxkMB7RuordMV9vvhb7
 t+9N1fFRqZtuZrQmeOVN7kOO/v2jsE1RqJf6eQSHBXDeofrOpvQ0lXpGmVFSnlHMKYHo
 aGiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeMg2knTj9b2ilC4cIoReDDBxTAgdmNgyQrK3p9Mxczx5W0YZiVdWNVEE5l0trEksFjVua7aEPE+azCA==@nongnu.org,
 AJvYcCXAdv7LXC082kMMBJiBraK+FHjINK285R8pp+ed0/P1UCuCgRbakmMpNqZySQv0AR3mhTBzUvyVKA==@nongnu.org
X-Gm-Message-State: AOJu0YyUMe8KvshryJGUxKx2mc8R/5l3PmQiJiXFiF+Y81z5D5GOfA8k
 pJxAacBNPCOkvLcSUq2SzirGDShFTTjW8EA4ePaBYutC7XE+RvhWfr+kcw==
X-Gm-Gg: ASbGncu9jw2VTjkeyQLaZ1vI6Ykc/9OZ6Lx0VqLLrHU3fBDZge7JLBPJHaHAXSDQWl7
 qoNCkioU3zlEopisM0pCp3ea+/SH2NZzo3UPJazShg7wWfjWoaAlnMh4c44fd12kLZtBC9yf0Ea
 6Pu9bu8vYV5+MIxuW4evzIt2V1g2kaM2KuveenSudf4bSRTPNU9N2TiTP134VnMY85UG6maeGPK
 gFgMBqovBWy6ZqpL6JBoxkhk3n0KzeclF1hlbslTHv+FvxzTIG7KvR6ihTv2BS7QTqq2NtuQRE8
 FdTkBORJsL+n7HsJ8NZ8zez2V+4=
X-Google-Smtp-Source: AGHT+IGsbuaUE0RpqSsw3+xQ4eLW0iVCQVa+/dP+SVcSGxzIc/BQnzUDQqKlru9NEeAHMIDBhhERdA==
X-Received: by 2002:a17:906:7314:b0:aaf:f32:cd34 with SMTP id
 a640c23a62f3a-ab2ab6a84ecmr258443266b.15.1736349763830; 
 Wed, 08 Jan 2025 07:22:43 -0800 (PST)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e894b60sm2542977166b.68.2025.01.08.07.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 07:22:43 -0800 (PST)
Date: Wed, 08 Jan 2025 14:26:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 04/14] hw/core: Introduce TYPE_SHARED_IRQ
In-Reply-To: <20250108092538.11474-5-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-5-shentey@gmail.com>
Message-ID: <0481ED42-8DAB-41D5-B1F9-89D5E5756DFE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 8=2E Januar 2025 09:25:28 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>---
> include/hw/core/shared-irq=2Eh | 39 ++++++++++++++++
> hw/core/shared-irq=2Ec         | 88 ++++++++++++++++++++++++++++++++++++
> hw/core/Kconfig              |  3 ++
> hw/core/meson=2Ebuild          |  1 +
> 4 files changed, 131 insertions(+)
> create mode 100644 include/hw/core/shared-irq=2Eh
> create mode 100644 hw/core/shared-irq=2Ec
>
>diff --git a/include/hw/core/shared-irq=2Eh b/include/hw/core/shared-irq=
=2Eh
>new file mode 100644

As pointed out by David, this device is redundant to TYPE_OR_IRQ=2E I'll d=
rop it in v2=2E

Best regards,
Bernhard

>index 0000000000=2E=2E803c303dd0
>--- /dev/null
>+++ b/include/hw/core/shared-irq=2Eh
>@@ -0,0 +1,39 @@
>+/*
>+ * IRQ sharing device=2E
>+ *
>+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+/*
>+ * This is a simple device which has one GPIO output line and multiple G=
PIO
>+ * input lines=2E The output line is active if at least one of the input=
 lines is=2E
>+ *
>+ * QEMU interface:
>+ *  + N unnamed GPIO inputs: the input lines
>+ *  + one unnamed GPIO output: the output line
>+ *  + QOM property "num-lines": sets the number of input lines
>+ */
>+#ifndef HW_SHARED_IRQ_H
>+#define HW_SHARED_IRQ_H
>+
>+#include "hw/sysbus=2Eh"
>+#include "qom/object=2Eh"
>+
>+#define TYPE_SHARED_IRQ "shared-irq"
>+
>+#define MAX_SHARED_LINES 16
>+
>+
>+OBJECT_DECLARE_SIMPLE_TYPE(SharedIRQ, SHARED_IRQ)
>+
>+struct SharedIRQ {
>+    DeviceState parent_obj;
>+
>+    qemu_irq out_irq;
>+    uint16_t irq_states;
>+    uint8_t num_lines;
>+};
>+
>+#endif
>diff --git a/hw/core/shared-irq=2Ec b/hw/core/shared-irq=2Ec
>new file mode 100644
>index 0000000000=2E=2Eb2a4ea4a66
>--- /dev/null
>+++ b/hw/core/shared-irq=2Ec
>@@ -0,0 +1,88 @@
>+/*
>+ * IRQ sharing device=2E
>+ *
>+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "hw/core/shared-irq=2Eh"
>+#include "hw/irq=2Eh"
>+#include "hw/qdev-properties=2Eh"
>+#include "qapi/error=2Eh"
>+#include "migration/vmstate=2Eh"
>+
>+static void shared_irq_handler(void *opaque, int n, int level)
>+{
>+    SharedIRQ *s =3D opaque;
>+    uint16_t mask =3D BIT(n);
>+
>+    if (level) {
>+        s->irq_states |=3D mask;
>+    } else {
>+        s->irq_states &=3D ~mask;
>+    }
>+
>+    qemu_set_irq(s->out_irq, !!s->irq_states);
>+}
>+
>+static void shared_irq_init(Object *obj)
>+{
>+    SharedIRQ *s =3D SHARED_IRQ(obj);
>+
>+    qdev_init_gpio_out(DEVICE(s), &s->out_irq, 1);
>+}
>+
>+static void shared_irq_realize(DeviceState *dev, Error **errp)
>+{
>+    SharedIRQ *s =3D SHARED_IRQ(dev);
>+
>+    if (s->num_lines < 1 || s->num_lines >=3D MAX_SHARED_LINES) {
>+        error_setg(errp,
>+                   "IRQ shared number of lines %d must be between 1 and =
%d",
>+                   s->num_lines, MAX_SHARED_LINES);
>+        return;
>+    }
>+
>+    qdev_init_gpio_in(dev, shared_irq_handler, s->num_lines);
>+}
>+
>+static const Property shared_irq_properties[] =3D {
>+    DEFINE_PROP_UINT8("num-lines", SharedIRQ, num_lines, 1),
>+};
>+
>+static const VMStateDescription shared_irq_vmstate =3D {
>+    =2Ename =3D TYPE_SHARED_IRQ,
>+    =2Eversion_id =3D 1,
>+    =2Eminimum_version_id =3D 1,
>+    =2Efields =3D (const VMStateField[]) {
>+        VMSTATE_UINT16(irq_states, SharedIRQ),
>+        VMSTATE_END_OF_LIST()
>+    },
>+};
>+
>+static void shared_irq_class_init(ObjectClass *klass, void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+
>+    /* No state to reset */
>+    device_class_set_props(dc, shared_irq_properties);
>+    dc->vmsd =3D &shared_irq_vmstate;
>+    dc->realize =3D shared_irq_realize;
>+
>+    /* Reason: Needs to be wired up to work */
>+    dc->user_creatable =3D false;
>+}
>+
>+static const TypeInfo shared_irq_types[] =3D {
>+    {
>+       =2Ename =3D TYPE_SHARED_IRQ,
>+       =2Eparent =3D TYPE_DEVICE,
>+       =2Einstance_size =3D sizeof(SharedIRQ),
>+       =2Einstance_init =3D shared_irq_init,
>+       =2Eclass_init =3D shared_irq_class_init,
>+    },
>+};
>+
>+DEFINE_TYPES(shared_irq_types)
>diff --git a/hw/core/Kconfig b/hw/core/Kconfig
>index d1bdf765ee=2E=2Eddff977963 100644
>--- a/hw/core/Kconfig
>+++ b/hw/core/Kconfig
>@@ -32,6 +32,9 @@ config PLATFORM_BUS
> config REGISTER
>     bool
>=20
>+config SHARED_IRQ
>+    bool
>+
> config SPLIT_IRQ
>     bool
>=20
>diff --git a/hw/core/meson=2Ebuild b/hw/core/meson=2Ebuild
>index ce9dfa3f4b=2E=2E6b5bdc8ec7 100644
>--- a/hw/core/meson=2Ebuild
>+++ b/hw/core/meson=2Ebuild
>@@ -21,6 +21,7 @@ system_ss=2Eadd(when: 'CONFIG_OR_IRQ', if_true: files('=
or-irq=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_PLATFORM_BUS', if_true: files('platform-bu=
s=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_PTIMER', if_true: files('ptimer=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_REGISTER', if_true: files('register=2Ec'))
>+system_ss=2Eadd(when: 'CONFIG_SHARED_IRQ', if_true: files('shared-irq=2E=
c'))
> system_ss=2Eadd(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq=2Ec'=
))
> system_ss=2Eadd(when: 'CONFIG_XILINX_AXI', if_true: files('stream=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt=
=2Ec'))

