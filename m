Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FE9C5DF98
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 19:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxrcs-0001sM-GP; Sat, 22 Aug 2026 15:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wxrcq-0001rz-VB
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:43:32 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wxrcp-00070k-03
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:43:32 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2caced6038eso21615075ad.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787427809; x=1788032609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=REGe0WKNsuh8WHgcdC+XmOy2OmwO/TbaMT7ihI1a4qg=;
 b=FePgqJIt8RgUrwKwjkSC2bCKLRUTplVKUsCY24Tq7cc30Qf+GFmvvlp4lVjeMYQsQx
 I6WOdckDBkRTpwW+yx1xx+TM+sJEAJPFSs8PD0JN3+EceMmeyrFg+vDirBFYJSfIdL8q
 Pzij7btvahEt5HQGCKnvuwyokfluYH/3/V8AreP3x0nWwrjmooc+J+/eZf5d9opD17UE
 ccEO7exr4K6Z15Xjp1doc2nRlM+WXy/Y+X3XPaxsSPY+Z+GUUTH9JldlrBwOefeUULyu
 S8fgcbFwwO4b1Gtaxz2kcMrdY2reVn9psgM+UOXRrhJ/IzCSrWBdczzCnL1vD4eJJeYM
 6Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787427809; x=1788032609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=REGe0WKNsuh8WHgcdC+XmOy2OmwO/TbaMT7ihI1a4qg=;
 b=YQLGW+3q4RfzM1nM96IOXpF59BN4TOZqast/WqhmPR2Blk+JvZ7D8IZP7M+06n/pm+
 cXAxFqgIvRj2kcKO5FE7Y4AnIkw1D06O2z4dYXVfmlFkcKh8AXHQyAs4TWMQ67OVzjGa
 rx2tpm08WED1hRH1640G/2euYhJyNFTTu133QMIEf6d6K5Af17IfFWiewK0oNTZMGYEk
 VzunYQum70ib/QCZRhqV9pX6cPSD/IAGSXHYXFWtJtk5xkuQ1xMNWWUWwRJvhgGEWnxL
 BKtzGIVNR4V78++jiTT9m42nHVyb5MosBJUUXBqC938o15A+K4rMYh0EnELtnoNXxdu4
 3LsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMODjqu8Uh2WiKctc/g65Yp1r6R/fJ4ZcXeQ5Zt40yDTIVLK7R6xM+7UJq8ZF63rijsrdKN795O3c1@nongnu.org
X-Gm-Message-State: AFuF++kRXq/yYfiGSagiU9KrLFTT9eG9GzICriCOXRhUz16tBQ2S3R58
 tB42lShbucQVAHBEE8TLzv5ykxBXXrbqdZhfvs9hd+JFSpVPrfKzpbIs
X-Gm-Gg: AR+sD11BXeW/ccVSM0vO3UtUHkXlhZSEbF8Ypf+cDFPyCHK5u7uEcwYk369ff9pWsha
 BRuSGaMgTu+Kc1XUuGTCkmxsc99rfUSdzkcWotIo5xV5AGXC8KIVzxLAd5bl92jcwahSWbG8ZQr
 aY0NLNvXS3pH+clcvNFpUbcGexWcDgy2pg8ASMvqt6HHU93EzYWaVc05BDJGHcG+501581RF92N
 laK9I2zdUnGz0HucisHtAh/nDRn0pzQPGW44dm1no/tYLFufXzsUuezwOwbiY/zjfxiRCAL4HkN
 1khGlYSEZesQ1V/5qnpPXkqLpWWM4PXIFPvW7uxqu/3E6e8AQPiiNaf3aueGLJubD5JsoGZd+Qo
 ZOFaU6Osog+B5JlEQr+pZ5Viiitm+FgU1sXx8VEteZUDf6uBIi99QoLdoMGj61Ba9LUCI/lnLp5
 iSIBriVFW2VDjt1Iat+dC+4BQxGNfdSLZNvXXD5pwOE95wWOIYHkpPX+C0bzp4vqyt7lLeEtcO9
 RRThSSLy+UcezXTcnWD4l5Tmd6EC/3TRNuEfkywFHvMyfWdakro8rbDGB0YuY6BoQ==
X-Received: by 2002:a17:903:1965:b0:2cf:7db9:e13e with SMTP id
 d9443c01a7336-2d64d17b076mr163234185ad.3.1787427809116; 
 Sat, 22 Aug 2026 12:43:29 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d676895799sm5892715ad.38.2026.08.22.12.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:43:28 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pierrick.bouvier@oss.qualcomm.com, almer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 wxchen0913@gmail.com, jserv@ccns.ncku.edu.tw, marscheng@google.com,
 eleanor15x@gmail.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 0/7] hw/riscv: Add support for Milk-V Duo board
Date: Sat, 22 Aug 2026 19:43:07 +0000
Message-ID: <20260822194315.2550260-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add initial support for the Milk-V Duo board.

The Sophgo CV1800B SoC features T-Head C906 processing, standard PLIC
and CLINT controllers, a dw8250 uart, and basic clock control. The
current implementation can successfully run OpenSBI and boot Linux v7.0
from an SD card to the Linux shell.
---
P.S. Apologies for the delay between v3 and v4. I'll keep the gap
     between revisions tighter next time.

Changes in v4:
- dw8250: Fix memory access sizes, handle dynamic 'regshift', log
          unimplemented writes, and propagate errors.
- cv1800b_clk: Replace magic numbers with macros and sizeof().
- cv1800b: Move static properties and child device initialization to
           instance_init and propagate errp.
- milkv_duo: Use riscv_default_firmware_name(), riscv_load_fdt(), and
             DEFINE_TYPES().
- docs: Add a doc for milk-v duo board.
- tests: Add an end to end boot test.

Changes in v3:
- Rebase on master branch.
- Drop custom T-Head PMU CSR patch to avoid duplication.
- Use REG_BYTE_WIDTH macro in clock controller.

Changes in v2:
- Added link for the custom T-Head PMU CSRs
- Added qtest to validate basic for the dw8250 and clock controller.
- Removed RFC tag.

Kuan-Wei Chiu (7):
  hw/char: Add dw8250 UART
  hw/misc: Add Sophgo CV1800B clock controller
  hw/riscv: Add Sophgo CV1800B SoC support
  hw/riscv: Add Milk-V Duo board support
  tests/qtest: Add qtest for Milk-V Duo board
  tests/functional/riscv64:  Add boot test for Milk-V Duo board
  docs/system/riscv: Add Milk-V Duo board documentation

 MAINTAINERS                                 |  14 ++
 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/milkv-duo.rst             |  49 ++++++
 docs/system/target-riscv.rst                |   1 +
 hw/char/Kconfig                             |   4 +
 hw/char/dw8250.c                            | 131 +++++++++++++++
 hw/char/meson.build                         |   1 +
 hw/misc/Kconfig                             |   3 +
 hw/misc/cv1800b_clk.c                       |  90 ++++++++++
 hw/misc/meson.build                         |   1 +
 hw/riscv/Kconfig                            |  14 ++
 hw/riscv/cv1800b.c                          | 174 ++++++++++++++++++++
 hw/riscv/meson.build                        |   3 +
 hw/riscv/milkv_duo.c                        | 120 ++++++++++++++
 include/hw/char/dw8250.h                    |  27 +++
 include/hw/misc/cv1800b_clk.h               |  26 +++
 include/hw/riscv/cv1800b.h                  |  56 +++++++
 tests/functional/riscv64/meson.build        |   1 +
 tests/functional/riscv64/test_milkv_duo.py  |  50 ++++++
 tests/qtest/meson.build                     |   3 +-
 tests/qtest/milkv-duo-test.c                |  70 ++++++++
 21 files changed, 838 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/riscv/milkv-duo.rst
 create mode 100644 hw/char/dw8250.c
 create mode 100644 hw/misc/cv1800b_clk.c
 create mode 100644 hw/riscv/cv1800b.c
 create mode 100644 hw/riscv/milkv_duo.c
 create mode 100644 include/hw/char/dw8250.h
 create mode 100644 include/hw/misc/cv1800b_clk.h
 create mode 100644 include/hw/riscv/cv1800b.h
 create mode 100755 tests/functional/riscv64/test_milkv_duo.py
 create mode 100644 tests/qtest/milkv-duo-test.c

-- 
2.55.0.766.g2966f0265a-goog


