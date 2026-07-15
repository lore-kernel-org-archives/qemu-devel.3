Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD76C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 22:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk81L-00075o-Pj; Wed, 15 Jul 2026 18:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nodokaorganized@gmail.com>)
 id 1wk7u2-0006dU-Im
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 18:16:30 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nodokaorganized@gmail.com>)
 id 1wk7u1-0000cH-4d
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 18:16:30 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-92e4fd65b2bso203795385a.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 15:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784153788; x=1784758588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nxzepMBbkIIZVZQ82bi+yBrRdvUXrx5G2o6j3RW/4NI=;
 b=E7C1X81vRjrIKq7DCsGFQoNAVScXjHkw+EJaSR7cJO7XCLDCh/cQnXdVMtlS0ZXt4+
 SFR2UwJSFk5j0BpYI5mbVf9YsZCJn/w1smuSAyTnc7/Awwzf74uCxo7Nsnlw8vSpdegT
 HMCev1d8jAbfXo3iXgueYfFroaHmFCTsHOQM0wSJT9Pqgc78oJZ290Fp8zk3DnoN4HaD
 ysoBVTzIIC2qgZPrBZjVoOe0ahpvIwlBFetIapgL91Y0HKHlmsHX9w1T0ToFg7BQE1Zw
 JFTHYCZy+2ngmbUgGrj8ImrlvhVU3SjD9XaBS6QHmX23c++eBdPGbMNH6Fsj6xINeTWd
 u6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784153788; x=1784758588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nxzepMBbkIIZVZQ82bi+yBrRdvUXrx5G2o6j3RW/4NI=;
 b=TT1b5ANfxSmyLO8YQ3WBMd0fKa/ymBBR2+uJ0u1rxpwjrk5RUNBCbz5dml9W+4li+f
 hSK5KzrT7V6zfd+h0w4BA7xq34cMmMyFezlOOTdJ7L+WIZFx/dgOU1agMmwCiSFVHT1i
 jWhqFQUO4Kt6i+KhOmAcI8GuPWV5sZkfWy352T1IpivMbl3mRF3xgwEwP180HrsKjvhf
 yjMtT9JvTpJH93mCFw+rPjN96Q2DjW7FmjrmVwIQS+3/Gcj3e67Tt3XiM4GeLKIG1F59
 NFb+uIoE7CTjIirkxdiUI2MOSAqGrUdwWWSyclK4usIQEhhzZSCIRClLzeojkB7oLTZS
 NAzw==
X-Gm-Message-State: AOJu0Yz7kDAkg8O9VgLvVqLvf6uQKo/s9YTkcgFAUuP0HenyxJ0YPBkh
 PiAnHdqOpsq1vz+UgjCUFpR7SvGiar13KVG1fJ+t7++248y66VrRsRItUm1lRnfdH5zOCg==
X-Gm-Gg: AfdE7cl3M9j/t2wmzV3hpSxfyhezUR7Eg2bkpT56/Qn5MreTNmiOhKGeBjmkDR1pHUR
 GSaqag2gErL0TJVGHBpBtdvZLVRZDOW/XeGDbAYBa7X2v3T0sJaGXAb6/klRVAMoYb3UUWzEwbB
 IEku6RHWfzjWraxu8OEvU98juVgy8weXUsNLNKhSZkUhBFKfBJ6ov1Pn0BWwlojbms/T0ufV0ck
 oiMDYziiUiu+wp4h7/GcNK/fDuNK3SW9v+SEtm4YMQRUHr6zIsA05r/lEyFyoo508iIRZqDzikp
 xFPzvnsjxaOIAzyYfgYK2uKnuoPfE3tBgXx5CvleOtCa9GXHlCfImq/f5BxUCdL727+N4k5Nz94
 c/NZsnhHjXyh90ldBAqi9xE2anwFM4RYnJdnET7C/QbLsQ36H/BHqXqzWp6lG8vosMWR9Z/zdF5
 f3UneifHiIyJTbyfp759iGu9LCfNS0eDsQVUGh+0aovJiQ/m/ds6Q+bKn3+7ZhEEcFxk2l150lA
 UFo2a2V80g78RbjfuSFRFqYScS48cY7OH+wxfiMEPZnEeWA
X-Received: by 2002:a05:620a:44c6:b0:92b:6805:919f with SMTP id
 af79cd13be357-92ef2c7a9dcmr2185491385a.71.1784153787297; 
 Wed, 15 Jul 2026 15:16:27 -0700 (PDT)
Received: from ip-172-32-0-41.us-east-2.compute.internal
 (ec2-3-143-144-70.us-east-2.compute.amazonaws.com. [3.143.144.70])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b88a38sm1775107885a.12.2026.07.15.15.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 15:16:26 -0700 (PDT)
From: Nodoka Shibasaki <nodokaorganized@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Nodoka Shibasaki <nodokaorganized@gmail.com>
Subject: [RFC PATCH 0/1] hw/misc: emulated Nexthop FPGA I2C (Xilinx AXI-IIC)
 device
Date: Wed, 15 Jul 2026 22:13:59 +0000
Message-ID: <20260715221400.1484805-1-nodokaorganized@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=nodokaorganized@gmail.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Jul 2026 18:24:02 -0400
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

Hi all,

This RFC adds a QEMU device model, "xiic-fpga-i2c", for a Nexthop-style
PCIe FPGA that exposes Xilinx AXI-IIC (i2c-xiic) controllers. The goal
is to let the SONiC platform bring-up path (the multifpgapci + i2c-xiic
kernel drivers, plus the userspace platform code that walks the I2C
tree) be exercised under QEMU without access to real switch hardware.

The device presents a PCIe function with a BAR0 register window that
decodes the AXI-IIC register map, gives each channel its own QEMU I2C
bus (so standard slave models such as at24c-eeprom / tmp105 / tmp421 can
be attached from the command line), drives real transfers through the
i2c core in dynamic (DTR) mode, and delivers completion via MSI with a
legacy INTx fallback.

Open questions I would appreciate guidance on:

  1. Is an emulation of a vendor-specific FPGA appropriate for hw/misc,
     or would you prefer it live elsewhere / be structured differently?
     It is modelled as a TEST_DEVICES-gated device alongside EDU and
     pci-testdev, since its purpose is CI/bring-up rather than modelling
     a shipping board.

  2. The AXI-IIC register decode here is deliberately partial: it
     implements the subset the Linux i2c-xiic driver actually touches in
     dynamic mode. I can flesh out the static/manual mode if that is
     preferred for a general-purpose model.

  3. A documentation file under docs/specs/ can be added if this is
     something you would consider merging; I left it out of the RFC to
     keep the first posting focused on the device itself.

This series is based on current master (191489ba75). No documentation or
qtest is included yet (happy to add both if there is interest).

Thanks,
Nodoka

Nodoka Shibasaki (1):
  hw/misc: add xiic-fpga-i2c, an emulated Nexthop PCIe FPGA I2C
    controller

 MAINTAINERS             |   5 +
 hw/misc/Kconfig         |   6 +
 hw/misc/meson.build     |   1 +
 hw/misc/xiic_fpga_i2c.c | 651 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 663 insertions(+)
 create mode 100644 hw/misc/xiic_fpga_i2c.c

-- 
2.50.1


