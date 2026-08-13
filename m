Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5223C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVcT-0005lw-H1; Thu, 13 Aug 2026 09:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wuVcS-0005lc-Lg
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:37:16 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wuVcR-0005UD-1i
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:37:16 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8484f229529so1791124b3a.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 06:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786628233; x=1787233033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LU3c7K+OtZGXFKKaiBRdDohYIWB+X8AIhAfaEwL+dZI=;
 b=njpn2kOz44zHWjH13TY8NLtWb/kA6tuQenPHf9UFGjWmHOWQSLHrfPHnm2BxxkKiQ6
 t5mVdxmbOR3YDypT/7qc/qr+UBZFPclbXuk6xLyEyEI+ov4MWS0XpL4hFocY0P5qa8y/
 hoy8ECgume08rxXPx9g6V/FYyRbyZwNAT1yI9pYGsigQ1ZhEfcW3qqV/5VoaUkUBaViJ
 TNZ8lbEOKBd8qZkrvI7f/Ma0lTz9TPzPvtGj7gEtZzjS14xmBN+f4IPv4pRnwlHz37Nl
 6EsjJZ8YULQ9OfoPY0qO1NBSXOBb/APD0OvVFlF7+I4Q4FEWkXp4TPWKIUdLUJfqRSYf
 LNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786628233; x=1787233033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LU3c7K+OtZGXFKKaiBRdDohYIWB+X8AIhAfaEwL+dZI=;
 b=HDl72+o6W/kIEsu6OXB8LjqPqHY/0l11kC/IRQk1AiNarJGXhLNIHkNBh0PSGuS92L
 YMUcHnJ4EeZDW4dM6ZR4HI7HXY+ArHm0xEwweCMRtFKms8nyLf4qoR9M1wd5Uclk7O5T
 foAc05tYlkUib8EsaLksgTklCZ/fq/HkekPxm8Lii/Fupz4Bn6fnB5lJFtD9JdmebpQb
 TonXQibGDF3hqGmJ7lFF+PFBcw1p8tNMeAmFrOSLHvYGQNGAZyh1Nbv1G8oUYWFUNR/l
 vkNzO6BmJy3xiIld7OMiPnUXWi26OSWdMEh2ceQXcjxckZKNbhpduJu9rw/Qb8tzK+em
 xkkw==
X-Gm-Message-State: AOJu0YykSESPwYKOMiUZa3b9CyfzqfO3NTpM7+u4aVUBP/FqHd1gr9xg
 NvvcUR1QNIyKUK129Wsvt3FfoUjMbcEGQdaGDfOWhGgIiIqVy9+/5hYy7AFRejGQUG4=
X-Gm-Gg: AR+sD13QqXjfUjtSGRghx3Zh9nXwuf694iV2dzsyuLWUWJ3XEQlbU+0eK1/kaJ+LQMr
 HVPdeoclk6otA263nUV0mf5rHP/+kTHZgAUsUQMXSiaRzOPjHhGGExZFwtYWcwhbGdpOXErc1iJ
 L8g94ZBNOGOiYY9jEZg/wBGLYSYbennlQWzwfDM6qXEudK3P5XZQEgWed4G0slSjcsIdF2V+OFO
 Rtgdind+hR6xHsgF3Wu5ZZjncIp584MHStv/mMoyWoaIGvZPzsalTl3LLmEgi2r7zw+9EJHjp1o
 ljAj8xAunz5sCTXxLJlTeBS2n3GAClirWyJhJnvkaEsnUfze0zagj7kCcyRtTlgL114lhMuZRq1
 WRrhr+qbH6g0zLk23YBxzTFXUW1Bkvjn3tsiKG3cL7nRoOHmW4AYkTUhXn7mN+TQCBDYSo4lViB
 2cLBTu4yOMT9D9eQUY/IQCh3EofezUzgSgtjguBYp5GLHdsxdIrVK3C93iuy/3
X-Received: by 2002:a05:6a00:4fc7:b0:848:32f5:4999 with SMTP id
 d2e1a72fcca58-84fc7563b85mr5443498b3a.30.1786628232939; 
 Thu, 13 Aug 2026 06:37:12 -0700 (PDT)
Received: from DESKTOP-DFGP8OG ([2409:8a55:ad2:6951::258])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef6849625sm1078901a12.1.2026.08.13.06.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:37:12 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 bmeng.cn@gmail.com, philmd@oss.qualcomm.com, pbonzini@redhat.com,
 lvivier@redhat.com, farosas@suse.de, caojunze424@gmail.com,
 raoyi <rao232328@gmail.com>
Subject: [PATCH v4 0/3] hw/timer: add DesignWare APB timer
Date: Thu, 13 Aug 2026 21:36:40 +0800
Message-ID: <20260813133643.20380-1-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=rao232328@gmail.com; helo=mail-pf1-x429.google.com
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

Add a generic DesignWare APB timer device model, and wire it
up for the K230 machine with num-timers=6 and a 6.25 MHz clock.

Changes since v3 (address review comments from Philippe Mathieu-Daude):
- Drop Clock framework mention from the commit message
- Cover the device in MAINTAINERS (device files in patch 1/3,
  test file in patch 3/3)
- Move trace calls to function entry
- Drop the addr mask; the MMIO region stays at 0x100 (the IP
  register implementation range; the SoC aperture is board-level)
- Hard-code comp-version (0x3231312A, "211*", IP component version)
- Use the Resettable API (phases.hold) instead of legacy reset
- Add unrealize to free per-channel ptimers
- Keep register offsets and bit definitions in the C file
- Drop private/public comments in the header
- Move K230 timer macros into k230.c

raoyi (3):
  hw/timer: add DesignWare APB timer model
  hw/riscv: add DesignWare APB timer to K230 board
  tests/qtest: add k230 dwapb timer test

 MAINTAINERS                         |   3 +
 hw/riscv/Kconfig                    |   1 +
 hw/riscv/k230.c                     |  33 ++-
 hw/timer/Kconfig                    |   4 +
 hw/timer/dw-apb-timer.c             | 376 ++++++++++++++++++++++++++++
 hw/timer/meson.build                |   1 +
 hw/timer/trace-events               |   8 +
 include/hw/riscv/k230.h             |   8 +
 include/hw/timer/dw-apb-timer.h     |  40 +++
 tests/qtest/k230-dwapb-timer-test.c | 274 ++++++++++++++++++++
 tests/qtest/meson.build             |   4 +-
 11 files changed, 748 insertions(+), 4 deletions(-)
 create mode 100644 hw/timer/dw-apb-timer.c
 create mode 100644 include/hw/timer/dw-apb-timer.h
 create mode 100644 tests/qtest/k230-dwapb-timer-test.c

-- 
2.53.0


