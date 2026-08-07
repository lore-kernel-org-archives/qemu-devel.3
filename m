Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9ADC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsHil-0002bi-2g; Fri, 07 Aug 2026 06:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wsHij-0002b9-7J
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:22:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wsHih-0006gT-KJ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:22:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cecc8a3dbfso2770845ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 03:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786098150; x=1786702950; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4gF9EWQbicqWmKG+8e9s/SkbCgwQHR0L+IypKFkFoXE=;
 b=OGmLiR0eCnBw0eheRdoaiGbLNWbjnJGFaxPMy749ialK+TNFJ+GPDvdFGAbZtRvM2N
 gJBe2R0xcq4xcSwHlaz2o+uPSIwxWcblP47Hi07scccoKfL3nGNTxpX3ngZG5ZyHLMzb
 9AmXjdNqIlw27oypw3zgd9hgK60WS2DrZrc1C/cnmqZ5k9mpR6KpqSALE0Vi/woQ4mOj
 2qA0aIphTlvnoi/HGkzGdQH3zxeajTrBprNK6lwTUp7RAbhCKusXAvg04ZDKM7rn2kP1
 ShYIudvRVdixH4QYHMOlhXIb3CCSa7zi13kYzzis+bYeeESzqAR7kFii//B8IMfuNnm0
 X3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786098150; x=1786702950;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4gF9EWQbicqWmKG+8e9s/SkbCgwQHR0L+IypKFkFoXE=;
 b=A3HsylL+uwDZkMr69TFmIl6qt3TXiDM8PadPTn3+Fi3j1ogjKX2QWN5fdtBfTJ+/8I
 LymF51ZACsCLpnE2cSUbZ+pxXb1D1s8uOv8ScBVomogvIYPr72DTY3VmTTj5P/NkbDGY
 nDBjLHogGd/68v/cvmgERUkbfnJoyC55dLT7CmKxkDI2indJCR9iR4qXO19PjgtKcdoj
 VjL/pCQKlKdEcv+8zvBGB1Q8zgkA+1RxwuIozGhEVErnl0CckON4jzMT2WW8T0V1haPQ
 qBrh9XxWI7NTUEohE9sGig2HFBGes8YnSEqJIkDMwppZKVR9v5IDAwxtg5+6Bp2BkV7q
 0/hA==
X-Gm-Message-State: AOJu0YxSpRC+bfPfHkz0PiiOKR1Z4neshBRPdt9PVpFS8PTWdCLIbjkA
 fsH6IZ8HO7MCsVtHzeLUKp3pa3qdIVbi0e9v7frG/GyLV2HgA/RwmfU5
X-Gm-Gg: AR+sD12bPP713+AcPZoESqornES/vNI42c0oUi+axcjslYSIykBmi+IOGsYxlvmGrwg
 T6esTTP72msvzdR1YMY+CtppYZMUEsqQK3J5Ft/Zrq3zJ1fwQhTpYq7LBWFhDEQi1n3RvmR4Akh
 c08gA4D8e5JPQurwawn8HJCqFoOHOMCIZNj05dY9EpZIKNbKFkcFFQ+Stm+yNhCilml4Mfz9m9A
 4axT8b4l5qLilBeWrTj2rGdo7rRFi7htU80a5OUsZ4CVDIhQ+oLFE6tXpwVwM2WEIWXDkt/H2JR
 B1tIP/RIjqkN70/iIa3mDOVsAn5VFo3BTHLOlkzLd0adZO8LJsAIkp+i37iIoDvkwlXu1/m/SNg
 HdDBjQDjb9Xrpf9JYe0odL8EgwGhzXuwmfsi4PvAZhmrp77vYjyQGaf/LQ934UPFMudjy6aZQsc
 DZ/5v3xvNe1ldsPJ/Q0zw12AEvPZcuY1UYUzFKdWumxCIkPYbjQwRvTXm+3g==
X-Received: by 2002:a17:903:19cf:b0:2cc:f4d4:29a0 with SMTP id
 d9443c01a7336-2d0cab0db0dmr196361105ad.3.1786098149692; 
 Fri, 07 Aug 2026 03:22:29 -0700 (PDT)
Received: from [127.0.0.1] ([38.34.7.236]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86d3fcsm6158337eec.4.2026.08.07.03.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:22:29 -0700 (PDT)
From: Junze Cao <caojunze424@gmail.com>
Subject: [PATCH v2 0/3] riscv: Add K230 DDR controller and PHY models
Date: Fri, 07 Aug 2026 18:21:15 +0800
Message-Id: <20260807-k230-ddr-v2-v2-0-c531308ae819@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOQQ6CMBREr0K6tqT9bSi68h6GRSkfKAo1LRCVc
 HcpLlyxfMnMm1lIQG8xkEuyEI+zDdYNG8ApIabVQ4PUVhsTYJCxnCl6B8FoVXk6A61zJlSZaQN
 Cka3x9Fjb1267FT8OU9mhGaMiJmrvejq2HvXfqnjGBUgQ6VlwCYoCNdp10/BBCfLa9No+UuP62
 G9tGJ1/73dnHncOHPzAUazr+gVATnIQ9QAAAA==
X-Change-ID: 20260807-k230-ddr-v2-f8037b6ac237
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Junze Cao <caojunze424@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=caojunze424@gmail.com; helo=mail-pl1-x633.google.com
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

The K230 SDK U-Boot SPL initializes DRAM by programming the DDRC CFG
and DDR PHY MMIO regions. The k230 machine currently exposes the DDR
configuration region as unimplemented and does not provide the PHY, so
the SPL cannot complete the training and DFI handshakes.

Add minimal models for the register behavior exercised by the SDK SPL.
The controller model provides reset values, register access policy, DFI
and software-update handshakes, and the Init-to-Normal transition. The
PHY model provides CSR ownership, the training mailbox, and DFI
completion. Wire both devices into the k230 machine and document the
resulting SPL support.

These device models allow firmware to complete the DDR initialization
sequence.

Changes in v2:

* Add LOG_UNIMP messages for unimplemented DDR PHY register accesses,
  including reads returning zero and ignored writes.

Testing performed:

* scripts/checkpatch.pl --branch upstream/master..HEAD
* meson test -C build --print-errorlogs
  qemu:qtest-riscv64/k230-ddr-test (6 subtests passed)
* Booted the K230 SDK U-Boot SPL through DDR initialization to its SPI
  boot path

---
Junze Cao (3):
      hw/misc: Add K230 DDR controller and PHY models
      hw/riscv: Connect K230 DDR controller and PHY models
      tests/qtest: Add K230 DDR controller tests

 MAINTAINERS                 |   3 +
 docs/system/riscv/k230.rst  |   4 +
 hw/misc/k230_ddr.c          | 556 ++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build         |   1 +
 hw/riscv/k230.c             |  19 +-
 include/hw/misc/k230_ddr.h  |  59 +++++
 include/hw/riscv/k230.h     |   4 +
 tests/qtest/k230-ddr-test.c | 226 ++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 9 files changed, 871 insertions(+), 4 deletions(-)
---
base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
change-id: 20260807-k230-ddr-v2-f8037b6ac237

Best regards,
--  
Junze Cao <caojunze424@gmail.com>


