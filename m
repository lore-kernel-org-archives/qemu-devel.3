Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD12C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5M8y-0005gC-Kj; Thu, 17 Apr 2025 06:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u5M8f-0005bR-Hh; Thu, 17 Apr 2025 06:06:36 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u5M8d-0003Zu-4B; Thu, 17 Apr 2025 06:06:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ee651e419so305988f8f.3; 
 Thu, 17 Apr 2025 03:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744884388; x=1745489188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=935At1+GEkK97IFVUQ39VPxRPadAohxu7N/GMPwO/IQ=;
 b=RlJU84Y8zUSp1mioHVd3xRWXrb2htGJXNfid/zbxRY4YsayXvjn7rsKodpqleFh68s
 6Nebfxj6lF2vv4vIY96DI+Z9LjNJ8Y6MIn4DIWXoVMPkBKfOtDqJ5u3ArYgXvZhI2te8
 BOUletSdZyrvEU0gjegr6effDpZIjf+sfvT8mSvldrCVKz9Qkw+XUlZqfSfRFTlMEQnX
 zkBQcATmPwjDg8H2zKtWiguBMydnEMufKmLR9ozqzdqxKH4I//qRcYX4lsaffratIN2A
 uy7csc4EFPTmJpuOhWg0lzpHlDsyYserxRsXpZpdKrFvs9vAOpFhEabAnPfoLRJ1smXC
 YbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744884388; x=1745489188;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=935At1+GEkK97IFVUQ39VPxRPadAohxu7N/GMPwO/IQ=;
 b=pG89ZmFFqxxn1fBomXvgNX+bZa216z/Nz+vUzAAfw+quD6bwRk6K5i2yhLV5kAC9A/
 JASkg3PJSKVf1EMV7dyIv/I5F71P1eBVLVX7EiFPY33M63iB9rDdZzc+574lg6qyMH6A
 rM9PCfUaygaprVqe2OcvrWU1TVNI2yE+czB77EqO+w5hWnXcwSj9g4+N39mn3OuXtG2u
 SAbEkkR+bXCqDZSCD3wECbO88m1sImoUKkcIBXGglJk3JT3Z57gwNxeDKJ800QhLDYwP
 m6gaAfde21EvRQdUFJu2qganw6R16bFMqZdRZSWYW5VgQGgjuEPkGszMfJxWQJTRYW0d
 MRrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8GlaCC7ToTBXvOE0eXrU63tyBP88WYyS6xbvjsHMslzchcgfT1pSn9+49f2p4Ui8Z47yt/E5TGw==@nongnu.org,
 AJvYcCWMDb7nmtQxvJNKPEq/LzOt9PRrBK4JKQQTLhEK3XzFBw0xpH9qQKOs7pjUNRPNVh3v2aVcEfKwsjkbSQ==@nongnu.org
X-Gm-Message-State: AOJu0YyXNQMwOIdAVHqtZ6yJUDqh/jN6I00Yr8dSOLUB0UX9SBX1rEq3
 joaYXdV8CSnsRZcfw0iUsxpUx68wplfLoagMz9acUfLvBsfVwWaU
X-Gm-Gg: ASbGncu294hDEIHk0vD8uz07yw8UEdQidjzrKbEP8PfZGJt3JEUt09qHR2kCk6W5jwf
 dc3Bp39Hjbc4Fhh/GCStyFE5sjegaNTwZ88FEL8rr3p67X0YErNt/Ek0SON0buuiZXVP5Eb7iOj
 ZRXMr15dxTKQpVdhsJLHubgEn1gnojm+OL7Oq62hZ1TqIW2BpDfwpLSANwt9VEJOLFb5z/1Rtt7
 3YsxNi4cfrih9SR2256NENb7djc+Z1IPgxpRgndT4YBECy1HfSupBOBY2r39b3IsTTp9Z3PDPOL
 pyLz7S2fU9LlmUeixx41tzdExlHfQIuAIvY=
X-Google-Smtp-Source: AGHT+IE9QJjHUr/1dAJm76wjiJvh93Kh37VtAUKjFimgqGrfkJYyYZ0t7pX6uD6MvB67hks9QlNfXg==
X-Received: by 2002:a05:6000:420d:b0:39c:2b28:604a with SMTP id
 ffacd0b85a97d-39ee5bb0c8fmr3984399f8f.50.1744884388279; 
 Thu, 17 Apr 2025 03:06:28 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c074sm19203938f8f.28.2025.04.17.03.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 03:06:27 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:06:21 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Kane Chen <kane_chen@aspeedtech.com>, Kane Chen via <qemu-devel@nongnu.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: troy_lee@aspeedtech.com, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/3=5D_hw/misc/aspeed=5Fot?=
 =?US-ASCII?Q?p=3A_Add_Aspeed_OTP_memory_device_model?=
In-Reply-To: <20250417030957.2586802-2-kane_chen@aspeedtech.com>
References: <20250417030957.2586802-1-kane_chen@aspeedtech.com>
 <20250417030957.2586802-2-kane_chen@aspeedtech.com>
Message-ID: <BE49E71F-6FE7-4D87-BB24-A88035B94183@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42a.google.com
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



Am 17=2E April 2025 03:09:53 UTC schrieb Kane Chen via <qemu-devel@nongnu=
=2Eorg>:
>From: Kane-Chen-AS <kane_chen@aspeedtech=2Ecom>
>
>This introduces a new model for the ASPEED OTP (One-Time Programmable)
>memory=2E The device is implemented as a `SysBusDevice` and provides an
>abstracted interface for OTP read, write (program), and default value
>initialization=2E
>
>OTP content is backed by a block device and supports QEMU=E2=80=99s drive
>infrastructure via the "drive" property=2E
>
>Features:
>- Enforces irreversible bit programming logic (0->1 or 1->0)
>- Provides interface for SoC/secure controller integration
>- Validates bounds and bit-level constraints
>- Uses QEMU error handling conventions and logging
>
>Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech=2Ecom>
>---
> hw/misc/aspeed_otpmem=2Ec         | 217 ++++++++++++++++++++++++++++++++
> hw/misc/meson=2Ebuild             |   1 +
> include/hw/misc/aspeed_otpmem=2Eh |  40 ++++++
> 3 files changed, 258 insertions(+)
> create mode 100644 hw/misc/aspeed_otpmem=2Ec
> create mode 100644 include/hw/misc/aspeed_otpmem=2Eh
>
>diff --git a/hw/misc/aspeed_otpmem=2Ec b/hw/misc/aspeed_otpmem=2Ec
>new file mode 100644
>index 0000000000=2E=2Ecf4b3aa4d2
>--- /dev/null
>+++ b/hw/misc/aspeed_otpmem=2Ec
>@@ -0,0 +1,217 @@
>+/*
>+ *  ASPEED OTP (One-Time Programmable) memory
>+ *
>+ *  Copyright (C) 2025 Aspeed
>+ *
>+ * This code is licensed under the GPL version 2 or later=2E  See
>+ * the COPYING file in the top-level directory=2E
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "hw/block/block=2Eh"
>+#include "hw/block/flash=2Eh"
>+#include "hw/qdev-properties=2Eh"
>+#include "hw/qdev-properties-system=2Eh"
>+#include "system/block-backend=2Eh"
>+#include "qemu/log=2Eh"
>+#include "qemu/option=2Eh"
>+#include "hw/sysbus=2Eh"
>+#include "qemu/error-report=2Eh"
>+#include "hw/misc/aspeed_otpmem=2Eh"
>+
>+static const Property aspeed_otpmem_properties[] =3D {
>+    DEFINE_PROP_DRIVE("drive", AspeedOTPMemState, blk),
>+};
>+
>+static void aspeed_otpmem_read(void *opaque, uint32_t addr,
>+                               uint32_t *out, Error **errp)
>+{
>+    AspeedOTPMemState *otp =3D ASPEED_OTPMEM(opaque);
>+
>+    if (!otp->blk) {
>+        error_setg(errp, "OTP memory is not initialized");
>+        return;
>+    }

Since the same condition is checked in realize(), this if statement is unr=
eachable code=2E Maybe use an assert() here? There is more unreachable code=
 like this in other functions=2E

Best regards,
Bernhard

>+
>+    if (out =3D=3D NULL) {
>+        error_setg(errp, "out is NULL");
>+        return;
>+    }
>+
>+    if (addr > (otp->max_size - 4)) {
>+        error_setg(errp, "OTP memory 0x%x is exceeded", addr);
>+        return;
>+    }
>+
>+    if (blk_pread(otp->blk, (int64_t)addr, sizeof(uint32_t), out, 0) < 0=
) {
>+        error_setg(errp, "Failed to read data 0x%x", addr);
>+        return;
>+    }
>+    return;
>+}
>+
>+static bool valid_program_data(uint32_t otp_addr,
>+                                 uint32_t value, uint32_t prog_bit)
>+{
>+    uint32_t programmed_bits, has_programmable_bits;
>+    bool is_odd =3D otp_addr & 1;
>+
>+    /*
>+     * prog_bit uses 0s to indicate target bits to program:
>+     *   - if OTP word is even-indexed, programmed bits flip 0->1
>+     *   - if odd, bits flip 1->0
>+     * Bit programming is one-way only and irreversible=2E
>+     */
>+    if (is_odd) {
>+        programmed_bits =3D ~value & prog_bit;
>+    } else {
>+        programmed_bits =3D value & (~prog_bit);
>+    }
>+
>+    /* If there is some bit can be programed, to accept the request */
>+    has_programmable_bits =3D value ^ (~prog_bit);
>+
>+    if (programmed_bits) {
>+        qemu_log_mask(LOG_GUEST_ERROR,
>+                      "%s: Found programmed bits in addr %x\n",
>+                      __func__, otp_addr);
>+        for (int i =3D 0; i < 32; ++i) {
>+            if (programmed_bits & (1U << i)) {
>+                qemu_log_mask(LOG_GUEST_ERROR,
>+                              "  Programmed bit %d\n",
>+                              i);
>+            }
>+        }
>+    }
>+
>+    return has_programmable_bits !=3D 0;
>+}
>+
>+static bool program_otpmem_data(void *opaque, uint32_t otp_addr,
>+                             uint32_t prog_bit, uint32_t *value)
>+{
>+    AspeedOTPMemState *s =3D ASPEED_OTPMEM(opaque);
>+    bool is_odd =3D otp_addr & 1;
>+    uint32_t otp_offset =3D otp_addr << 2;
>+
>+    if (blk_pread(s->blk, (int64_t)otp_offset,
>+                  sizeof(uint32_t), value, 0) < 0) {
>+        qemu_log_mask(LOG_GUEST_ERROR,
>+                      "%s: Failed to read data 0x%x\n",
>+                      __func__, otp_offset);
>+        return false;
>+    }
>+
>+    if (!valid_program_data(otp_addr, *value, prog_bit)) {
>+        return false;
>+    }
>+
>+    if (is_odd) {
>+        *value &=3D ~prog_bit;
>+    } else {
>+        *value |=3D ~prog_bit;
>+    }
>+
>+    return true;
>+}
>+
>+static void aspeed_otpmem_prog(void *s, uint32_t otp_addr,
>+                               uint32_t data, Error **errp)
>+{
>+    AspeedOTPMemState *otp =3D ASPEED_OTPMEM(s);
>+    uint32_t otp_offset, value;
>+
>+    if (!otp->blk) {
>+        error_setg(errp, "OTP memory is not initialized");
>+        return;
>+    }
>+
>+    if (otp_addr > (otp->max_size >> 2)) {
>+        error_setg(errp, "OTP memory 0x%x is exceeded", otp_addr);
>+        return;
>+    }
>+
>+    otp_offset =3D otp_addr << 2;
>+    if (!program_otpmem_data(s, otp_addr, data, &value)) {
>+        error_setg(errp, "Failed to program data");
>+        return;
>+    }
>+
>+    if (blk_pwrite(otp->blk, (int64_t)otp_offset,
>+                   sizeof(value), &value, 0) < 0) {
>+        error_setg(errp, "Failed to write data");
>+    }
>+
>+    return;
>+}
>+
>+static void aspeed_otpmem_set_default(void *s, uint32_t otp_offset,
>+                                      uint32_t data, Error **errp)
>+{
>+    AspeedOTPMemState *otp =3D ASPEED_OTPMEM(s);
>+
>+    if ((otp_offset + 4) > otp->max_size) {
>+        error_setg(errp, "OTP memory 0x%x is exceeded", otp_offset);
>+        return;
>+    }
>+
>+    if (blk_pwrite(otp->blk, (int64_t)otp_offset,
>+                   sizeof(data), &data, 0) < 0) {
>+        error_setg(errp, "Failed to write data");
>+    }
>+    return;
>+}
>+
>+static AspeedOTPMemOps aspeed_otpmem_ops =3D {
>+    =2Eread =3D aspeed_otpmem_read,
>+    =2Eprog =3D aspeed_otpmem_prog,
>+    =2Eset_default_value =3D aspeed_otpmem_set_default
>+};
>+
>+static void aspeed_otpmem_realize(DeviceState *dev, Error **errp)
>+{
>+    AspeedOTPMemState *s =3D ASPEED_OTPMEM(dev);
>+
>+    if (!s->blk) {
>+        error_setg(&error_fatal, "OTP memory is not initialized");
>+        return;
>+    }
>+
>+    s->max_size =3D blk_getlength(s->blk);
>+    if (s->max_size < 0 || (s->max_size % 4)) {
>+        error_setg(&error_fatal,
>+                   "Unexpected OTP memory size: %" PRId64 "",
>+                   s->max_size);
>+        return;
>+    }
>+
>+    s->ops =3D &aspeed_otpmem_ops;
>+
>+    return;
>+}
>+
>+static void aspeed_otpmem_system_reset(DeviceState *dev)
>+{
>+    return;
>+}
>+
>+static void aspeed_otpmem_class_init(ObjectClass *klass, void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+
>+    device_class_set_legacy_reset(dc, aspeed_otpmem_system_reset);
>+    dc->realize =3D aspeed_otpmem_realize;
>+    device_class_set_props(dc, aspeed_otpmem_properties);
>+
>+}
>+
>+static const TypeInfo aspeed_otpmem_types[] =3D {
>+    {
>+        =2Ename           =3D TYPE_ASPEED_OTPMEM,
>+        =2Eparent         =3D TYPE_SYS_BUS_DEVICE,
>+        =2Einstance_size  =3D sizeof(AspeedOTPMemState),
>+        =2Eclass_init     =3D aspeed_otpmem_class_init,
>+    },
>+};
>+
>+DEFINE_TYPES(aspeed_otpmem_types)
>diff --git a/hw/misc/meson=2Ebuild b/hw/misc/meson=2Ebuild
>index 6d47de482c=2E=2Eed1eaaa2ad 100644
>--- a/hw/misc/meson=2Ebuild
>+++ b/hw/misc/meson=2Ebuild
>@@ -136,6 +136,7 @@ system_ss=2Eadd(when: 'CONFIG_ASPEED_SOC', if_true: f=
iles(
>   'aspeed_sbc=2Ec',
>   'aspeed_sdmc=2Ec',
>   'aspeed_xdma=2Ec',
>+  'aspeed_otpmem=2Ec',
>   'aspeed_peci=2Ec',
>   'aspeed_sli=2Ec'))
>=20
>diff --git a/include/hw/misc/aspeed_otpmem=2Eh b/include/hw/misc/aspeed_o=
tpmem=2Eh
>new file mode 100644
>index 0000000000=2E=2E11e2de70b6
>--- /dev/null
>+++ b/include/hw/misc/aspeed_otpmem=2Eh
>@@ -0,0 +1,40 @@
>+/*
>+ *  ASPEED OTP (One-Time Programmable) memory
>+ *
>+ *  Copyright (C) 2025 Aspeed
>+ *
>+ * This code is licensed under the GPL version 2 or later=2E  See
>+ * the COPYING file in the top-level directory=2E
>+ */
>+
>+#ifndef ASPEED_OTPMMEM_H
>+#define ASPEED_OTPMMEM_H
>+
>+#include "hw/sysbus=2Eh"
>+#include "qapi/error=2Eh"
>+
>+#define TYPE_ASPEED_OTPMEM "aspeed=2Eotpmem"
>+#define ASPEED_OTPMEM_DRIVE "otpmem"
>+
>+#define ASPEED_OTPMEM(obj) OBJECT_CHECK(AspeedOTPMemState, (obj), \
>+                                        TYPE_ASPEED_OTPMEM)
>+
>+typedef struct AspeedOTPMemOps {
>+    void (*read)(void *s, uint32_t addr, uint32_t *out, Error **errp);
>+    void (*prog)(void *s, uint32_t addr, uint32_t data, Error **errp);
>+    void (*set_default_value)(void *s, uint32_t otp_offset,
>+                              uint32_t data, Error **errp);
>+} AspeedOTPMemOps;
>+
>+typedef struct AspeedOTPMemState {
>+    SysBusDevice parent_obj;
>+
>+    MemoryRegion mmio;
>+    BlockBackend *blk;
>+    int64_t max_size;
>+
>+    AspeedOTPMemOps *ops;
>+} AspeedOTPMemState;
>+
>+#endif /* ASPEED_OTPMMEM_H */
>+

