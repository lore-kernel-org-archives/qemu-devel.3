Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95FEC55162
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDSw-00077C-Af; Wed, 29 Jul 2026 19:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GIlqagYKCi8eTefdcRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--titusr.bounces.google.com>)
 id 1wpDSv-000773-AJ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:33 -0400
Received: from mail-pg1-x548.google.com ([2607:f8b0:4864:20::548])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GIlqagYKCi8eTefdcRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--titusr.bounces.google.com>)
 id 1wpDSt-0007GX-ME
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:33 -0400
Received: by mail-pg1-x548.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so1182248a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 16:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785366809; x=1785971609; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x1UDTL9ZjqiMvN0QpoWmSUkkhCIa6NFHpPd/+eOvUhg=;
 b=H+JphLfIOcUUR4ULhklUHuMhu2r4gcPBwejoBGETAt/5A4ETCHx5Va8Kqi3CUZOhRt
 Levc8Z0EWWzHogpSTZexBE62/JKkTyDv114dk4FuK+HQ9MfWBcoMrjbZ27sylNJk54+i
 RMB4Z5qE+DJyKo2mOtfxnB+WISxctH9ma35KoMB7BBiXVyrNIdadu8qKZGNs8aD7GjWZ
 mVMqvNtwr7qF5OBXaMx566vMV6V4XRB/Bfa7FIy6nTApbXU9QljFH7O13N8+FcAY2vEw
 dCFgm5yJsaYL6am7oOoWO61RufWtdVCYeKunjtm7WGgZyneLKSW1ohoLYCA1gsuoNKlQ
 laEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785366809; x=1785971609;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x1UDTL9ZjqiMvN0QpoWmSUkkhCIa6NFHpPd/+eOvUhg=;
 b=gcITa6tVQp33tcpeu6XWVGVOjCv3j9Z1DjYPw6BDV7uUw+8b9/9qq0UrpbW7yg45sI
 t5Qk+ZYhG98V6lTIFz+H2KUw17OkvrIt5/d1+tOshHvYwbCzOPg0DzFLcqcOkCuSqP9H
 9gy3lcGVJc9fdtkSyZ0x69dP0O73gZtZiaPXzfdvl9iDrFnBq1EjA1imvcVncH6nMzKj
 RDo3WAwfnhb3u94gfmSpDaqYgc7jCA9h3p9aHpJ9dnE678b7vEWyTri+6rh/Wes4qrtF
 mJAVoV/YNY0eV4lvdc/6lalm0pAlOcl2+wP3bVT3yzKc9cKsCR3EdRr5tPRo73tm8/Hq
 LMew==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqohbFgfgmqH/i40V9NuUVdeqMI23utZkOwDurJrdT3jfMC1cEXm7OrcAjiTBAtRDIgE1nrCZvLjKz@nongnu.org
X-Gm-Message-State: AOJu0YyBA+ePEjDTWklGc/ipUEGeYXAU/0PtVHG7qfhpkY9XRmcoHq5+
 8DRdku+DSf9RmUPhIvmwFiI5AaxGpQreHrtEOnHxnNGa0Eo5QH+AsOgFyuUBpKRXnDzqtYcxn8F
 QPQDbSg==
X-Received: from dybkm13.prod.google.com ([2002:a05:7301:d8d:b0:30c:83f3:7370])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3103:b0:3c0:9c19:b277
 with SMTP id adf61e73a8af0-3c90076eaefmr75663637.69.1785366808841; Wed, 29
 Jul 2026 16:13:28 -0700 (PDT)
Date: Wed, 29 Jul 2026 23:13:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729231325.3808993-1-titusr@google.com>
Subject: [PATCH 0/8] hw/i2c: PMBus updates and adm1266 fixes
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::548;
 envelope-from=3GIlqagYKCi8eTefdcRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--titusr.bounces.google.com;
 helo=mail-pg1-x548.google.com
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FUZZY_MILLION=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This series adds various fixes to PMBus and SMBus support.

Since v1:
- Added the adm1266 patches that fix accessing the MFR_* registers
- Fixed vout_mode handling to avoid values overflowing/being truncated
  by the adm1266 implementation.
- Added fix for PMBus vout_mode bug where guests accesses would break
  due to the bitfields being packed in the wrong order.
- Updated VMState to work around breaking migration while still storing
  the increased SMBus data.

The maximum SMBus data length is increased to 257 bytes, (payload is 255 by=
tes) to support SMBus 3.0 block transfers. SMBus devices don=E2=80=99t have=
 to report their specification version, and this change allows us to enable=
 newer PMBus devices that are based on top of SMBus 3.0.

Additionally, this series:
  - Adds the `DIV_ROUND_CLOSEST` helper macro, lifted from the linux implem=
entation, to match the rounding in linux drivers.
  - Adds PMBus helper functions to convert sensor values in milliunits to/f=
rom linear mode format (Linear16).

Jason Fan (1):
  hw/i2c: fix VOUT_MODE representation on little-endian machines

Titus Rwantare (7):
  osdep: add DIV_ROUND_CLOSEST
  hw/i2c: pmbus: add milliunits linear mode functions
  hw/i2c: smbus: increase MAX_DATA_LEN
  hw/sensor: update adm1266 block transfers
  hw/sensor: switch adm1266 to millivolts vout
  hw/sensor: adm1266: expose vout_mode over QMP
  hw/sensor: adm1266: set default VOUT mode

 hw/i2c/pmbus_device.c         |  39 +++++++
 hw/i2c/smbus_slave.c          |  27 ++++-
 hw/sensor/adm1266.c           | 176 +++++++++++++++++++++++-----
 include/hw/i2c/pmbus_device.h |  25 ++++
 include/hw/i2c/smbus_slave.h  |   2 +-
 include/qemu/osdep.h          |  13 +++
 tests/qtest/adm1266-test.c    | 210 ++++++++++++++++++++++++++++++++--
 7 files changed, 452 insertions(+), 40 deletions(-)

--=20
2.55.0.508.g3f0d502094-goog


