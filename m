Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD949C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1U-00088w-Ig; Wed, 01 Jul 2026 06:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1N-0007uh-6I
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:22 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1L-0004OY-7X
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:20 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso823206c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901098; x=1783505898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRNfT3D5Z/wezS5G4aIcA3jn0+E99UwzkzcQnvxWEZc=;
 b=TEQT9upn7aosVLvbFjKl8RFLAWIGlvkZ7yYNs1obHnSWw2OJMfuXY6Yy7tv9XVU02r
 fIoU5tnuItwMso9PUjXpwt7w72R/aq5AIqtedsxUIQIV4X8MGzqWAG7iLWfqGajsyv5F
 ikR8HCW1sZw4dE8KRSqEPVDjzv6/9EJlYflRozcxLtHcvmcKttbojh1ohAlC3PPkGz4s
 lgJPgziIHeZ6Ek8D4auz3rRuljW/uO8ZwZo4e2r9yCLq85OVgrwCdOV0pEsWKuID1F6n
 gha0nFBZNFNN2uLnnnOmGJ2EN8wxfP3hnIcwI87hsb8ycoujiPwZjURfXjFHB6f71bZq
 0bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901098; x=1783505898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uRNfT3D5Z/wezS5G4aIcA3jn0+E99UwzkzcQnvxWEZc=;
 b=X3SgDK0CkORkbjZFBzRia0zD6NYg9Sazb8aKmbDW2m9zkQNwNDX5GQxVlRU69FinQB
 qHni0e0nKKP3cPaQLFfdvuD4rTveIr22M7kjckGqPF2xoI0y8D/8v56Z6N4RgH8fHw1F
 PiWIFF87/odEjKBZirRlA1vz1ju5UsYPHraM5J6aC0pfQsfQz9qT4OxZANIN+fnQNHjM
 DXortsBnYJ5QhnS2sdcAw/+IX2ewNJEIw8LllE6CCbarAaWtJyN+rIPODKUlKbu2uusD
 6QcOhju0HEZBpd+si1dAAIXjVNAhUjqzNSHkgEVt+oiiCAj6Jt3rAy3qKZgc0kKZEIVd
 99+w==
X-Gm-Message-State: AOJu0YzS8r3xEte0y17cffLnBrMRSKZ/VOH2uMgoLdpBb0M4XEKw1uxL
 vManq+MPAcTCn6/knKPCtN5qKOsRa5d6D+ObkM8Xk9ld7BpmOW3vmScSsOiR7w==
X-Gm-Gg: AfdE7cnYHoxvqgw7l2245kwhHtmRmo84DL6rjn6DD7n/sZSQiAEblu+w12qUSwLcYF2
 bNfcCVQuDxUhY/9vgyaOqkv2FXP/pMVZse8haq36Zq0w9cI8CVds16AnbxL44Df8hwKrVe1pLHV
 kHbCrfwN5j0C/LPMrdUQOm5VBfHr9r/N/97giCABSTKRNlsU9G7fUc7OnkGJ5vA/Ix3YPj/t/Hp
 EKg9c53m4BZ85JHgmPG0n+A8WGXRjrRSZH5wQRBpW9mxDwA2DOg/8tL5q/BvyJ8xp/HuD1aq50r
 tWXUkL0n6xQKZRxYqzbxVmRXu9R1Pwen3l6rkCUZd11Kk3J1ajp+/ygrEJGm21cZ+oAbJw2Tq8n
 ewPOnqTsIAhY1AdOl+ePbmFX5WZNQ30QSDm7RCEjOvQMHM1oq3qGmF+/rr9D1Rd7gnFP4GYj847
 s3fjti7iENDEPAT89JhO0AsIAtk3rq7EE=
X-Received: by 2002:a05:7022:6b92:b0:130:6c8f:5a87 with SMTP id
 a92af1059eb24-13b36d9c667mr1082662c88.13.1782901097601; 
 Wed, 01 Jul 2026 03:18:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 03/39] tests/functional/riscv64: Add virt machine AIA boot test
Date: Wed,  1 Jul 2026 20:17:16 +1000
Message-ID: <20260701101752.2522962-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

Add coverage of the riscv64 virt machine's Advanced Interrupt
Architecture models. With this the APLIC and IMSIC models are used by
Linux, catching regressions.

This test requires a kernel >= 6.10, as AIA drivers were added to Linux
in 6.10.

Boot time is ~5s on a laptop.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260617054034.1020724-4-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/functional/riscv64/test_tuxrun.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
index 43d1242be5..6203a45060 100755
--- a/tests/functional/riscv64/test_tuxrun.py
+++ b/tests/functional/riscv64/test_tuxrun.py
@@ -41,6 +41,13 @@ def test_riscv64_maxcpu(self):
         self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
                            rootfs_asset=self.ASSET_RISCV64_ROOTFS)
 
+    def test_riscv64_aia(self):
+        self.set_machine('virt')
+        self.vm.set_machine('virt,aia=aplic-imsic')
+        self.cpu='max'
+        self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
+                           rootfs_asset=self.ASSET_RISCV64_ROOTFS)
+
     def test_riscv64_rv32(self):
         self.set_machine('virt')
         self.cpu='rv32'
-- 
2.54.0


