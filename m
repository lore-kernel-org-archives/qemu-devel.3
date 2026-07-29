Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EC9C55164
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDSz-0007AK-Ou; Wed, 29 Jul 2026 19:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3G4lqagYKCjIhWhigfUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--titusr.bounces.google.com>)
 id 1wpDSx-00078e-Ob
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:35 -0400
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3G4lqagYKCjIhWhigfUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--titusr.bounces.google.com>)
 id 1wpDSv-0007HU-SB
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:35 -0400
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2cccfa32670so16102695ad.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 16:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785366812; x=1785971612; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r0Q2A/3ze/zjMWoELy/FKDEtatpELgtMzBDktjSHJF0=;
 b=J9R9eU50LOEh1nCIodvpVfVnmX1DGixUxz4yA1thlPo9mj3N1Iz/rL8Z9AUXVRNLwd
 wSoC6RuiaZIXrB5WvzCZn0PMBtaJp4mkRTfgh4zbzZaYxmP6kK9OxipeLZlfXMAHMavA
 ncPuqr5TPI4yqXDKlE/kfWv+pU14LYYH0OjIpyh2A0IFfqB3Jpag50d7FUoJY1VpqEIM
 EgHkSefaF+xVA1zaqjUByzLKT/9rA6mVL35dqlHRSHwsGBRq2Z1PFmlgNMnfdEMqQ/mL
 74214675IJ6FdR9rrafDBqS1X1JVMyLbpkCtdnVjloKha/10lKnDyMTzjGSoELvKxuUr
 SVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785366812; x=1785971612;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r0Q2A/3ze/zjMWoELy/FKDEtatpELgtMzBDktjSHJF0=;
 b=PpqZ/fEW/xJTX3JFYnFhEpqXN8B2JqvD3mzDVp/hc/wJW0hRgQO67v5yAiLIJjCPvS
 vcQKQ7pya7GF2YaX77g7cLqUeR/1weGR31rqZ05Xwyi0OvoBqKIcDiDZA8D4d1On3zew
 /XBzY8nTVV0Isyka2IQr56kPrRupXDqT7s5t6eK3xSQTg+NX9HsJ7V+E7rU6lZqTXB2v
 fxj4nTwbB1CV2Os/6HQZcpX73oNMCcLJc4aipZU2pJxwIhOOe99Rdswzae3DRJH6aiFq
 Mnabhdt19Yxvdsrz6uP6DTg+U8PLqXGIBqVtVeWfsK4mi9lip3XnWwoyUNDDQBIZwWSk
 QrsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoM8zPEQLKwP2wcG/z1bC5VEZnMyoiZ89ikhKsXSDsSJ+b3lNZNt+KZDBhvHCX2GfGJlt+gY6sZi5EW@nongnu.org
X-Gm-Message-State: AOJu0YyT9siblzkdqc5QW+pWH3M0Zrn25XKAYLqEArEtUyESskYapbs7
 7YjsTWyaiuvqJTyGLkI2XHBM5LuSqlPpb8b/+f6uurdvPW4Z/ql/joixMPISWbvjOiSpKPY/Tae
 w1YfQbg==
X-Received: from dylq8.prod.google.com ([2002:a05:7300:5988:b0:313:fb09:e2c0])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1aae:b0:2cc:9763:e607
 with SMTP id d9443c01a7336-2d035d1a647mr2989835ad.27.1785366811882; Wed, 29
 Jul 2026 16:13:31 -0700 (PDT)
Date: Wed, 29 Jul 2026 23:13:18 +0000
In-Reply-To: <20260729231325.3808993-1-titusr@google.com>
Mime-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729231325.3808993-4-titusr@google.com>
Subject: [PATCH 3/8] hw/i2c: smbus: increase MAX_DATA_LEN
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::646;
 envelope-from=3G4lqagYKCjIhWhigfUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--titusr.bounces.google.com;
 helo=mail-pl1-x646.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The 32 byte payload was raised to 255 for block reads in the SMBus 3.0
specification. SMBus does not provide a way for devices to declare which
version of the spec they are designed to so we must allow newer devices
to return as much data as they allow.

vsmstate_smbus_extended_data is added to avoid breaking migration.

Specification: https://smbus.org/specs/SMBus_3_3_20240512.pdf

> 6.5.7 Block Write/Read
The Block Write begins with a slave address and a write condition. After th=
e command code the host issues a byte count which describes how many more b=
ytes will follow in the message. If a slave has 20 bytes to send, the byte =
count field will have the value 20 (14h), followed by the 20 bytes of data.=
 The byte count does not include the PEC byte. The byte count may be 0. A B=
lock Read or Block Write is allowed to transfer a maximum of 255 data bytes=
.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/i2c/smbus_slave.c         | 27 ++++++++++++++++++++++++++-
 include/hw/i2c/smbus_slave.h |  2 +-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index cfb61c879e..5dd2c38af7 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -215,6 +215,26 @@ bool smbus_vmstate_needed(SMBusDevice *dev)
     return dev->mode !=3D SMBUS_IDLE;
 }
=20
+#define SMBUS_DATA_MAX_LEN_OLD    34
+static bool smbus_extended_needed(void *opaque)
+{
+    SMBusDevice *dev =3D opaque;
+    return dev->data_len > SMBUS_DATA_MAX_LEN_OLD;
+}
+
+static const VMStateDescription vmstate_smbus_extended_data =3D {
+    .name =3D TYPE_SMBUS_DEVICE"/extended",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D smbus_extended_needed,
+    .fields =3D (const VMStateField[]) {
+        /* separately save [34..257) */
+        VMSTATE_UINT8_SUB_ARRAY(data_buf, SMBusDevice, SMBUS_DATA_MAX_LEN_=
OLD,
+            SMBUS_DATA_MAX_LEN - SMBUS_DATA_MAX_LEN_OLD),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_smbus_device =3D {
     .name =3D TYPE_SMBUS_DEVICE,
     .version_id =3D 1,
@@ -223,8 +243,13 @@ const VMStateDescription vmstate_smbus_device =3D {
         VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
         VMSTATE_INT32(mode, SMBusDevice),
         VMSTATE_INT32(data_len, SMBusDevice),
-        VMSTATE_UINT8_ARRAY(data_buf, SMBusDevice, SMBUS_DATA_MAX_LEN),
+        VMSTATE_UINT8_SUB_ARRAY(data_buf, SMBusDevice, 0,
+            SMBUS_DATA_MAX_LEN_OLD),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections =3D (const VMStateDescription * const[]) {
+        &vmstate_smbus_extended_data,
+        NULL
     }
 };
=20
diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
index 86bfe0a79e..59522ff1b1 100644
--- a/include/hw/i2c/smbus_slave.h
+++ b/include/hw/i2c/smbus_slave.h
@@ -64,7 +64,7 @@ struct SMBusDeviceClass {
     uint8_t (*receive_byte)(SMBusDevice *dev);
 };
=20
-#define SMBUS_DATA_MAX_LEN 34  /* command + len + 32 bytes of data.  */
+#define SMBUS_DATA_MAX_LEN 257  /* command + len + 255 bytes of data.  */
=20
 struct SMBusDevice {
     /* The SMBus protocol is implemented on top of I2C.  */
--=20
2.55.0.508.g3f0d502094-goog


