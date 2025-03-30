Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E842CC36011
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 21:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyzkU-0004X3-NV; Sun, 30 Mar 2025 16:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tyzkM-0004WI-Is; Sun, 30 Mar 2025 16:59:10 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tyzkK-0007SC-KY; Sun, 30 Mar 2025 16:59:10 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so650836366b.0; 
 Sun, 30 Mar 2025 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743368346; x=1743973146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=StYftgc5iHlTGp6x4Dv1YFEFA9vPoOzDhm2ng6GqJik=;
 b=iZy/avF2n58U+X8V6+BTOrLdxuBBLyNbjqwJZtHpyjQLNkR17vKalAmStjlxf/MiWu
 jSDIvt8zCHmWgeFCl1vFCLRw+U8XLI2xEAAmIWYF74aod8hAWTxcF7sA3SncE1H6vPmK
 mPXjNgWI0mFUHMF1zwV4tt/rMofYVBNNBaPrDn3xg50pmHa25zPYY08qtdXa4Z/uUb3X
 wwsg3lmU048TiAOlwN5sWaiWSSFjVmMDm5giONPcObyVEVY1ztrWsXm0EnYbMM0NS3rk
 +xTW7ty48hPN2c6KdUMjv4tqU1Y5kwbLZfyzMJwldMNIyUHNK+JzlY9xYsfMs2xZY1Rx
 IGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743368346; x=1743973146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=StYftgc5iHlTGp6x4Dv1YFEFA9vPoOzDhm2ng6GqJik=;
 b=CYxPKKh2EH+PEnN7Zhti09rD6K3vvRftZsNJFLB7AaFMyAX6TF8N1wSdb5HU7oUicQ
 iC4sPdKcqkNAuuQEbbmKt2ds0UdBd4Jwt3xHJ7xfBbPp1WcNWmaPSEpmzfE7ffwt4yFo
 p5MxuhFAso+t1fKmrcchiBtymO96cOoBpAXgyl5A/coDL1Hd2UQhRdXAJcYeVOamaGWL
 4vOr34qn9QqHNO/3vPcUhvmeva1ub/Td3FSaZ8E1mAsQWKdzJq6e+99VcfQS7X3htI2f
 BJRBuduorWB+qWnzk+Wf/Iv5P07FDQwE2SGOhF5ZWOw3SeE9rNI51h1tpCkcHm37DEjR
 ybtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsr6w4o1fW6HYLC+zh4cp2GXlPGT4wu9TJONKYNboUlb2LhGl7ZqPNQYtBeOt2IUCgC6hNT4VRFQI=@nongnu.org
X-Gm-Message-State: AOJu0YzpoitS5n7VipXILFKY7Yg160xCr8NftVrRONJkYknVm9Xqlzxg
 W621/DY/LjznX/WhSiGPhzKu8mbf6Mffcjt26jH4ZWzN6z4qpvV0KU6G7g==
X-Gm-Gg: ASbGnct7P+rTqeWf8RtD4ekdIdybElD0sp439OZ87zGhwP8qzdzMc0y8SV+/oDKoB1N
 QyLLnIIAi4CH5qw6X0zjf06ODAjS5VRW/TH31eeZ2MDoE+r6h5Ya0nPblzFgAhc242XgLJRK5QD
 FoniIFyerrPIVeha8IY8w0CbpnLl4EfE/xsVSUkX/e/WzSKhUFo5AK26f8jEN6w7lX37O+6Xhs0
 g4Nzpl4iITtyo+u2d7dAT+JR0w4EZIrVHAu6NXZEZJ8K2AnGKsBJ1n6T2Aa56K9+OFrp9485x3n
 8Z6rSd3lRqZqfrOG004U7c7KqpM+uUuF0zGnb/4nP9mbxDvvXT/vLKe6lGpi76+YYvPuhQJhNVa
 +WaF/MMMAohc7flE9T8uDiaatQirS2IE96OEJKvcNKHCKRan2soApaBSYVvM2x2ZqJg==
X-Google-Smtp-Source: AGHT+IEEfyCCmm1IOl+oCEhENGmsCQw0P2ZLIr4EL/dcHgNLzbyV7NQBbfKoV4ztC7X250+5Ab7gbQ==
X-Received: by 2002:a17:907:7e96:b0:ac7:37da:cd46 with SMTP id
 a640c23a62f3a-ac738ba8055mr532992266b.49.1743368345529; 
 Sun, 30 Mar 2025 13:59:05 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-2ddd-7900-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2ddd:7900:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71967fdbbsm520902466b.135.2025.03.30.13.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 13:59:05 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/2] Initial logging support for Rust
Date: Sun, 30 Mar 2025 22:58:55 +0200
Message-ID: <20250330205857.1615-1-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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

This series introduces a qemu_log_mask!() macro which works similar to the =
C=0D
version while catering to Rust expectations. It is just a thin wrapper arou=
nd=0D
qemu_log(). The macro then gets used in the pl011 device which either had i=
ts=0D
logging commented out or relied on eprintln!() which can't be silenced by u=
sers.=0D
=0D
Note that this is my first Rust contribution, so please check if the usage =
of=0D
`unsafe` is sound.=0D
=0D
Bernhard Beschow (2):=0D
  rust/qemu-api: Add initial logging support based on C API=0D
  rust/hw/char/pl011/src/device: Implement logging=0D
=0D
 docs/devel/rust.rst              |  1 +=0D
 rust/wrapper.h                   |  2 ++=0D
 rust/hw/char/pl011/src/device.rs | 12 ++++---=0D
 rust/qemu-api/meson.build        |  1 +=0D
 rust/qemu-api/src/lib.rs         |  1 +=0D
 rust/qemu-api/src/log.rs         | 55 ++++++++++++++++++++++++++++++++=0D
 6 files changed, 68 insertions(+), 4 deletions(-)=0D
 create mode 100644 rust/qemu-api/src/log.rs=0D
=0D
-- =0D
2.49.0=0D
=0D

