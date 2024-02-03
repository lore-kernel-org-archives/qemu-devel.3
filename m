Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332C9C4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 10:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCzV-0007xN-MJ; Sat, 03 Feb 2024 05:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCzU-0007xF-QE
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 05:11:16 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCzS-0006vA-TV
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 05:11:16 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ddfb0dac4dso2264746b3a.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 02:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706955073; x=1707559873;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6WLZ2WTdsc/ueCR6cAHfOEbBL9spf0DSW49S1h7NVEI=;
 b=r2vw3S2Bh4rcy6XENGYQmR+g6R0iA0CqAvto4e7ThFMDqf5SM93cRBHUF2Bs9+eM51
 8y3D2SzkDctqiNcoMMEUw0HpMARmFrX8Ofmww/Vl/W49eaaseweXD/ysTDu6cZv8oEm1
 X9gjzJoSy52oL0Imk99PMcTB04/VwlXT1y3PTKgqsKci9yS/cjSWzfgjfnCxxVgE4hiG
 OAR/gaLc/8fPGeNRxY68hdC5dSJIgP0oNnypB/P8n+6dm5AkdPNkKZU32e8IMqv7jydH
 j8/DQSCKn8fCTkE8t0J6GK3hqC50rvZovYdd97O137XFUrvoEjLSHae55joBsyBy2bh7
 J4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706955073; x=1707559873;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6WLZ2WTdsc/ueCR6cAHfOEbBL9spf0DSW49S1h7NVEI=;
 b=IdEdVeAZniytTuH9maNfcPm0cDk3fqbJlPthNu/Tkidy/4rIFMKxEEmPbzI/xlTFnw
 Vqn+zW8UUOPqtPKFNbnH5ek8MNrlh9vIm9JQhDgLXpQIZ3CAro9ZPqT9zzaXSQtTYanQ
 H/nVNMJtQ72r+8Bw8LEqPagwx6tyBnR2liseDYCLK3d4/9sQ/md1mecbkQodbVSvbhWV
 xY+wmUsphlDRiFbF0tDmbKmE11p3LdvRSP1utIia3nyC9aOwfG1qxPkUmgVM5k65JN8L
 VAVN/Tbg+QoS3vMGhk0HGUz1nz5OioDWQMVPpdA9uJNvbRx+iYbKfLgAWib8RXNrELHZ
 SydA==
X-Gm-Message-State: AOJu0YyopSAkV2tlMNTmVVxVlLRgeN7O39znpt7pCNzTEVLzqlFhgGyi
 hH6/ZhLpCHoDYCz1diq2DDZ1bcQbb7xDId6CIggqETMQlh3+NxMG4FrFhpiusRg=
X-Google-Smtp-Source: AGHT+IFexZg7LjBVY814izMUgMBc9hImOofyVnOVzYttooNuKTonzmEWgfBOx27+PukxzJg+LRhQyw==
X-Received: by 2002:a62:f212:0:b0:6e0:32e6:3f59 with SMTP id
 m18-20020a62f212000000b006e032e63f59mr72792pfh.11.1706955073450; 
 Sat, 03 Feb 2024 02:11:13 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXzSsPkFAjQ3R4ri7bA+gOtgLJesm34SHvMmxUvVz0c2Wn0w+UV4VJ6K6UukrDIkzPPyhyTjl6LNDNXmfZWppme3ftpaQ0SZ9hKQVGW1zbrx/Pn6LsIZk5vchyRxF11neheGgBSQbi8elYhfvyAK+5CXBKKkKDSHPdWfiU4FobzszVsAs6jRF1IlmEyl5l2//md4pLeKE2O/SB7Y4hsf/hze9+ZCnHLcry8QBFsmQTRcQ+kVIA7qMmF/KCbBXLafapW7lrWE+a+kESLjXa+SOR+U4MNBfRHlEWlGEIrtdFYFFZfqbdVg2lUzOz2v46RaqaqK8wImissYnaDYn9xsLjQF70bderAUOwslNoiTiuEdqZV8C84gGSSkUGeLDGiUDtj9H3sWuIvDBRQLQVFh3t0Zv7XgDy3mACZZqsyywL62ua8wkixtQb5gcsHVic1iD+XCWtSTFAeX2nrQQcZ
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 y7-20020a62b507000000b006dfef3ed2d4sm3038449pfe.110.2024.02.03.02.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 02:11:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v11 0/3] gdbstub and TCG plugin improvements
Date: Sat, 03 Feb 2024 19:11:07 +0900
Message-Id: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADwRvmUC/2XNyw7CIBAF0F8xrMUw0PJw5X8YFxQGZWFrwJAa0
 3+XNqnxsbw3c+48ScYUMZP95kkSlpjj0NcAsN0Qd7H9GWn0tSCccQEcBE0xu0KDc0Y2zGjpAqm
 3t4QhjsvQ8VTzJeb7kB7LblFz+7tQFGXUKsmglVYIFQ7ePvo47txwJfNE0Z9Mr0xX5kwXeAet5
 l79MbOyhgG0KzOVhQAKECx6p/8YsA/H3++AzdB32BphlETzBadpegGJb3KeQwEAAA==
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series extracts fixes and refactorings that can be applied
independently from "[PATCH v9 00/23] plugins: Allow to read registers".

The patch "target/riscv: Move MISA limits to class" was replaced with
patch "target/riscv: Move misa_mxl_max to class" since I found instances
may have different misa_ext_mask.

V6 -> V7:
  Rebased.

V5 -> V6:
  Added patch "default-configs: Add TARGET_XML_FILES definition".
  Rebased.

V4 -> V5:
  Added patch "hw/riscv: Use misa_mxl instead of misa_mxl_max".

V3 -> V4:
  Added patch "gdbstub: Check if gdb_regs is NULL".

V2 -> V3:
  Restored patch sets from the previous version.
  Rebased to commit 800485762e6564e04e2ab315132d477069562d91.

V1 -> V2:
  Added patch "target/riscv: Do not allow MXL_RV32 for TARGET_RISCV64".
  Added patch "target/riscv: Initialize gdb_core_xml_file only once".
  Dropped patch "target/riscv: Remove misa_mxl validation".
  Dropped patch "target/riscv: Move misa_mxl_max to class".
  Dropped patch "target/riscv: Validate misa_mxl_max only once".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v11:
- Rebased on: https://github.com/alistair23/qemu/tree/riscv-to-apply.next
- Link to v10: https://lore.kernel.org/r/20240128-riscv-v10-0-fdbe593976e9@daynix.com

Changes in v10:
- Dropped patch "hw/riscv: Use misa_mxl instead of misa_mxl_max" due to
  invalid assumption that the relevant code is only used for kernel
  loading.
- Link to v9: https://lore.kernel.org/r/20240115-riscv-v9-0-ff171e1aedc8@daynix.com

Changes in v9:
- Rebased to commit 977542ded7e6b28d2bc077bcda24568c716e393c.
- Link to v8: https://lore.kernel.org/r/20231218-riscv-v8-0-c9bf2b1582d7@daynix.com

Changes in v8:
- Added a more detailed explanation for patch "hw/riscv: Use misa_mxl
  instead of misa_mxl_max". (Alistair Francis)
- Link to v7: https://lore.kernel.org/r/20231213-riscv-v7-0-a760156a337f@daynix.com

---
Akihiko Odaki (3):
      target/riscv: Remove misa_mxl validation
      target/riscv: Move misa_mxl_max to class
      target/riscv: Validate misa_mxl_max only once

 target/riscv/cpu.h         |   4 +-
 hw/riscv/boot.c            |   3 +-
 target/riscv/cpu.c         | 181 ++++++++++++++++++++++++++-------------------
 target/riscv/gdbstub.c     |  12 ++-
 target/riscv/kvm/kvm-cpu.c |  10 +--
 target/riscv/machine.c     |   7 +-
 target/riscv/tcg/tcg-cpu.c |  44 ++---------
 target/riscv/translate.c   |   3 +-
 8 files changed, 133 insertions(+), 131 deletions(-)
---
base-commit: 0c9d286cf791cdda76fd57e4562e2cb18d4a79e2
change-id: 20231213-riscv-fcc9640986cf

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


