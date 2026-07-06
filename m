Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78483C44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 23:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgsJJ-0001Tb-2l; Mon, 06 Jul 2026 19:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rzNMagYKCqATITUSRGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--titusr.bounces.google.com>)
 id 1wgsJH-0001SA-7O
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:07 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rzNMagYKCqATITUSRGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--titusr.bounces.google.com>)
 id 1wgsJF-000746-E3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:06 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-c860544c077so9783845a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 16:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783378864; x=1783983664; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6fU0aRx9V9/Af1UMElRogGHAdUuCSDaABAHFfvVjCok=;
 b=RXTeyjJAb/QcY/5DhSxT8F4TmzZNhx9AgsZFUpNrHdAGfUE0n6LtooNIjAnM+6m/o8
 4mFw3wZ+0GH7Va7cGfA3qo2U6lhmRwasJIftDwIZyOjg7LR90Wr0eB1Mfya7Oyrv7lVX
 uwxwDRdY5jQeA/XgutAWKM57ZqviGah5n0hwmYdi/bSW2fffpHhs+HY8EoogqbPQoq+S
 YDq2rY10tjNqCz/53gjkhY7WsAKNur7pMBpnZm5zUjr3jJVdAlxEpRM97QS/QIWxiUJv
 LikJqEpuZ7rakMQQ3hlwRgh2PDRXa1WI0/y0Eyn68QQW+dOCwkR5g0Le20USSoybdpuY
 GCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783378864; x=1783983664;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6fU0aRx9V9/Af1UMElRogGHAdUuCSDaABAHFfvVjCok=;
 b=EhGcMiH4J12HedbWOHtIAxx7AdOl2eOo4AxaUwG5uWMEPgVcdP4dcAs8MQMPevVg8w
 Dj3NyKm6qH8HT3u1EA98wjnPjJmJxD41gjeiI5DkCX+mpmPpe92ge/FTer7+BXCyRInn
 ApEMkZVPhtn3zKEDraOp45zxrVqPHPgEwXefFJgsWOQ6axKhZIbyGKLN+8Xnc/xHJ4u2
 aFlIeML6SeKQrsdYCuJmkrlNats48jU7rpO0Ur7kIu81Au/Y+VfB4j6GWMt2pLHiX9Sp
 S1HkJtCSYe99goEE1oZTFaovVswb3miNeYYD7QsVqf7xp3nr1fgjIyThw4Z6HYUZb83i
 ZhNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RopEtUE30yPa6lGAFWP1hTyspnXqBRd5+Rw/Cuh2b78scoYK38jDoNK6EPNUJD5OX85N3itrNmoHJZP@nongnu.org
X-Gm-Message-State: AOJu0Yy1kIeizX/OsXUPWuiCC7QNhGCLQV8rquFiC6EEVQNJMqfDMzJc
 d1QUAjGwXaeTw98apW4yd+VFMPNbzgfgzXRmQ+P/XVbEG/4eV+92LXJHIVkBeG977Rk+pcYdG5B
 dLPXVbA==
X-Received: from dybhh38.prod.google.com
 ([2002:a05:7301:2926:b0:30f:1d9a:8ad6])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a94:b0:3bf:49c8:f63
 with SMTP id adf61e73a8af0-3c08ee392edmr3310349637.37.1783378863541; Mon, 06
 Jul 2026 16:01:03 -0700 (PDT)
Date: Mon,  6 Jul 2026 23:00:53 +0000
In-Reply-To: <20260706230056.1888992-1-titusr@google.com>
Mime-Version: 1.0
References: <20260706230056.1888992-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706230056.1888992-5-titusr@google.com>
Subject: [PATCH 4/5] hw/i2c: smbus: increase MAX_DATA_LEN
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 titusr <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3rzNMagYKCqATITUSRGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--titusr.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: titusr <titusr@google.com>

The 32 byte payload was raised to 255 for block reads in the SMBus 3.0
specification. SMBus does not provide a way for devices to declare which
version of the spec they are designed to so we must allow newer devices
to return as much data as they allow.

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
 hw/i2c/smbus_slave.c         | 4 ++--
 include/hw/i2c/smbus_slave.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index cfb61c879e..407a118d24 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -217,8 +217,8 @@ bool smbus_vmstate_needed(SMBusDevice *dev)
=20
 const VMStateDescription vmstate_smbus_device =3D {
     .name =3D TYPE_SMBUS_DEVICE,
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (const VMStateField[]) {
         VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
         VMSTATE_INT32(mode, SMBusDevice),
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
2.55.0.rc2.803.g1fd1e6609c-goog


