Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9457FC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp2rh-0006A1-Fj; Wed, 29 Jul 2026 07:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xinxie908@gmail.com>)
 id 1wp20b-00015l-Hv
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:59:34 -0400
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xinxie908@gmail.com>)
 id 1wp20Y-0004Bw-V4
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:59:33 -0400
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cc80544c74so2267905ad.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785322768; x=1785927568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hfQ4Z31L9bwxwkqJ0eTWQqvALRte8HscDksaKlvLlnU=;
 b=RxOdeqJ2CxHk7tQW3L9rsB5wpKfnEixxAQZ+NyAyIcURjrS34SzhEcZXR+ljCm3Rv/
 T3snQD6dzzC34OrxZrmaQMWGM7XT8DFZYl6+5NM8U3AfIelayLNiFBRZN1FpA0nUKSoL
 pvVyel2v1UFmoa9IRunuy5O7OQ7N1w7CK1g+9RdfcW0mwUNY7Zv3iwzWlb5miQtMgFqx
 ZmSy4XXFGydIIzPAgEdoGWOR4Yu7XHPZRPxuT30X84DyZwnRJQM6VsTw8BUXdgtqG++z
 PSfDXZToIe808fjm46EEPkf4npkST+yoGbe+yE3FGj2+Rm74aDrIOBPNOmhsP6ZrKvOy
 nkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785322768; x=1785927568;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hfQ4Z31L9bwxwkqJ0eTWQqvALRte8HscDksaKlvLlnU=;
 b=Tf3CWA8SodyLPZozhretcfrLyj5iJ0DyGSU+UTBG8Jik42W7Aeh3+jePhra5bKwFJK
 bUbqbdLDLMzi0zlUFWT/vmdEUy66ifdYQcNlg9xQGOFhWD11D5IbJtrlA7WjvlHPMtvW
 5GOZputKA60n7JNn1PtXCQRKSpVzqX6FxlhjchCJW7ZTL2M+y3W+ro8wuvOoCqICLtdQ
 jwRIFSZFNxsIw22qzjP8NpRAbjeqdX6N8HJe3Itra1Ov3jfl9DyKp+u4tB5Q59dqF45e
 Xncb2FwhHRK5xlhf/JMLd0Q7x6KzsIhccPL/Jdo5yKYxVLMlMZoHCAbig3c6aKwZTx0Z
 NNOw==
X-Gm-Message-State: AOJu0YxZ8r8MT0LWJoDNXQuxj3H1UZzT6mUjToiTXLHjxY3xHIIg1SJs
 72RGWm6UU4n858rjmw/+vujM+mYGtCHwmSPXHXQxNEcBZiep967bSYbJ4iwqP1WmZB6q2g==
X-Gm-Gg: AR+sD11gqdwKdhpwZxEodX7HxpfGD/JCcvXIm6BvRcjiBVsv9DVfi1KWRSZsf+Eld0I
 uM98niwUZbwuZNb6/6hhWn+KGRU4BhH7wMgLr/WiOwkNIo7WK1lLm0IMKRzyvxwHAmYpaTIO30w
 970fdifcHv0QYQo0ZMvjZZ4b+U1Fdy6kkq+1Lqm4Gj0pZwK0idZusWck8Gb9G9zbuMudMWo/WyA
 5B1jz3N2UIIERK7q6Iv9eTMJ9ivGahloD9RKP4DaLrnVecPGqOVM55P0YHDNoV4EDKRqwnHgave
 Gj+bON3illz5yuCzDlI/7+juYtoe/V30Kfhg66NhuZeS7wz4cWeF4XdSqtHxeFJgYarhYYCkioq
 m4AkCwhjLXI9O98FbGx94Eysn9aCj2/EqGCVIp5KowWBmFzwGPnp0QFXnH00GkhakE8CO6YN1TK
 DuWK45SuzvfYzUC5kaEU2e3a5M9H++5iOgzr6Qm6iG/YhDbDUjMpk2yup5FYmzL8ywK1fcl8+V9
 3VYdgzbIg==
X-Received: by 2002:a17:902:da81:b0:2ca:1594:451e with SMTP id
 d9443c01a7336-2d015cfb208mr69755035ad.31.1785322767921; 
 Wed, 29 Jul 2026 03:59:27 -0700 (PDT)
Received: from LAPTOP-LOCIFOSI.localdomain ([123.127.39.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bfa240sm9627135ad.65.2026.07.29.03.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 03:59:27 -0700 (PDT)
From: Xin Xie <xinxie908@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Xin Xie <xinxie908@gmail.com>
Subject: [PATCH v1 0/3] hw/riscv: add SDHCI support for K230
Date: Wed, 29 Jul 2026 18:59:00 +0800
Message-ID: <20260729105904.272939-1-xinxie908@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=xinxie908@gmail.com; helo=mail-pj2-x04.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Jul 2026 07:54:21 -0400
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

The Kendryte K230 contains two Synopsys DesignWare Core Mobile Storage
Host Controllers. The K230 machine currently exposes their MMIO ranges
as unimplemented devices, so software cannot access SD storage.

This series adds a K230 SDHCIv3 model based on the generic SDHCI model.
The model reuses the generic commands, PIO, SDMA and ADMA2 data paths
and provides the K230 0x1000-byte register layout. It implements the
documented capability and reset values, read-only Preset Value and
extension pointer registers, writable backing storage for most PHY and
vendor registers, and an always-ready PHY_PWRGOOD status bit required by
the K230 SDK reset sequence. It is worth noting that K230 documentation
describes an SDHCI v4.20 controller, while the generic QEMU SDHCI does not
support ADMA3. So this model reports v3 and does not advertise ADMA3.

Testing:
  - scripts/checkpatch.pl: 0 errors, 0 warnings, 747 lines checked
  - qemu:qtest-riscv64/k230-sdhci-test: 3 subtests passed
  - Linux direct boot: both controllers detected, r/w and e2fsck passed

Xin Xie (3):
  hw/sd: add Kendryte K230 SDHCI controller
  hw/riscv: enable SDHCI controllers on K230
  tests/qtest: add K230 SDHCI tests

 MAINTAINERS                   |   3 +
 docs/system/riscv/k230.rst    |   6 +-
 hw/riscv/Kconfig              |   1 +
 hw/riscv/k230.c               |  34 +++-
 hw/sd/Kconfig                 |   4 +
 hw/sd/k230_sdhci.c            | 311 ++++++++++++++++++++++++++++++++++
 hw/sd/meson.build             |   1 +
 include/hw/riscv/k230.h       |   4 +
 include/hw/sd/k230_sdhci.h    |  82 +++++++++
 tests/qtest/k230-sdhci-test.c | 214 +++++++++++++++++++++++
 tests/qtest/meson.build       |   5 +-
 11 files changed, 656 insertions(+), 9 deletions(-)
 create mode 100644 hw/sd/k230_sdhci.c
 create mode 100644 include/hw/sd/k230_sdhci.h
 create mode 100644 tests/qtest/k230-sdhci-test.c

-- 
2.43.0


