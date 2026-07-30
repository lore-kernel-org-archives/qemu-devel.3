Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C1FC55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQxI-0006Jw-D2; Thu, 30 Jul 2026 09:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wpQx0-0006Cz-V9
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:37:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wpQwz-0005ws-9G
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:37:30 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cad8076b01so26021835ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418646; x=1786023446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WRMY2E9FxrNj1re4bnuTp0tUVJ08lXuNTXOMzGgnK3g=;
 b=p+GghPFevxIiYpe4cnbZoV2iKy+BLPXL3zcTwLsQY2v1dkjxdeCSJo+7C25DQUI/v4
 fpLOM/GI6F2gWoxpd/2bN68A7gbhEGjlA0F3j2Tn1nBwMFA3kwm1YJdUaSWqu21NVs51
 roBFi4WoyaPxBZup2eWs2GXR5XZlNKYMKWK2ucsGBiePGwEnCHeGs6YZPNNGulr04Jql
 eSb+qYh7VIf9aeE4KlUmMOtueOF0UIwcIYQPxDgLffV15L17VqqcXO5knn8x/5DJjSLx
 jWNa9BvwOdv2HxO6Y2Cv86LHmszNaKfVI9kN5qBsJqFMqA14ymagEUrkYobD3agBe8jm
 BQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418646; x=1786023446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WRMY2E9FxrNj1re4bnuTp0tUVJ08lXuNTXOMzGgnK3g=;
 b=ofF7/t0btZpt4Q/2h18qL17DOzMXruamf3wFJEcCFt6+QWIPOYd7bAGIHOMsob6T6E
 kxjhfPDsr6Kcpw8DCpvhQazXm5hMeh7vBM/OOJ8FeYvZuKAjslLPegwPecJJtAbqjnHI
 LXvmBsWsFpDF2q9PncPaQwruljjte+pa6/seQKNSeASMZf/M2f8iJ7XTaPxI99JfQUDm
 +YNcM0REbCpE2H+h+DdNTuNJEnEpN4QsyabN5lNB/VG1IFrN+Z/Mrn2j5iUYW9o1b/TQ
 gPF51ZMceICPBzbTLialJ/slDGhgCjhnGl6IXach9y0UVcHnS/MM5xidcRpD7IoIsgGi
 jBRg==
X-Gm-Message-State: AOJu0Yy4BY1XX1COj0OeV6FtJcBj1mmbS1KtydWH0i3liceHZ3i1PR7z
 Ey/IfhytG7LCUjzRsZLj8jRHezmUIeTZWiFAn7nnN2D8+hlZ/WyPVQimk96i+J9AVG4i6Q==
X-Gm-Gg: AR+sD13R8c8zcBM+m0G9pZ4y8XDFpN3qWJHtgFX6pENrRogmIn3R94wU2COFfNSfVxx
 oOiwMgrO+y5GAwxdaiDskZVZ58wGqf3f+TfjZdhRxoENvO0vkYwMTQlrVVmJEEjDBugTDQPZQPw
 R3DWH9LLQ0dmLR0fcOgnkJ+jJ4/wCU8IK01bI3pz71kS8TDnkfzKBTz4pJF3Eb7wOFxA1hwskKl
 ucFYbVFPocfxMxkmw5whIUu9E3oBQjwwdY4Mavr7foUJVKodk/5weq/QMACp4jxg/mX0S6WUAtQ
 1UpWDTK0dB6qbwao0OnRGb9s8SBHBXbFNiB9KpcHTmkr79dbq2gbKOyo/EMDmB8E6Hll9r6I0Fk
 eSbmn46b5z2mgxfkdhNwyFRMFAE3rcemTqpN5cmRR+nNCaVcfWrfq2azAEgZiHMy+0p0D6DP376
 UUTbjCcQ8Ne8NfyYEH3lkj0NF8U12rlYP9wr/eCu6RD7VxLuWtytmFcNEw1KR7npc+4N9JeHo=
X-Received: by 2002:a17:903:384d:b0:2cf:4339:aaa with SMTP id
 d9443c01a7336-2d03dcc6f61mr4232185ad.12.1785418646233; 
 Thu, 30 Jul 2026 06:37:26 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.230.138.58])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bf845asm26757745ad.60.2026.07.30.06.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:37:25 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 caojunze424@gmail.com, raoyi <rao232328@gmail.com>
Subject: [PATCH v2 0/3] hw/timer: add k230 dwapb timer
Date: Thu, 30 Jul 2026 21:37:08 +0800
Message-ID: <20260730133713.3253-1-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=rao232328@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add DesignWare APB timer peripheral for K230 machine.
The timer uses the Clock framework for frequency input,
preparing for future CMU integration.

Changes since v1:
- Split into 3 patches: model, board integration, tests
- Remove goto pattern from read/write handlers
- Fix include order, add explicit bitops.h include
- Add QOM <private>/<public> markers in struct
- Fix copyright headers

raoyi (3):
  hw/timer: add k230 dwapb timer model
  hw/riscv: integrate k230 dwapb timer into k230 board
  tests/qtest: add k230 dwapb timer test

 MAINTAINERS                         |   3 +
 hw/riscv/Kconfig                    |   1 +
 hw/riscv/k230.c                     |  23 +-
 hw/timer/Kconfig                    |   4 +
 hw/timer/k230_dwapb_timer.c         | 317 ++++++++++++++++++++++++++++
 hw/timer/meson.build                |   1 +
 hw/timer/trace-events               |   9 +
 include/hw/riscv/k230.h             |   8 +
 include/hw/timer/k230_dwapb_timer.h |  72 +++++++
 tests/qtest/k230-dwapb-timer-test.c | 227 ++++++++++++++++++++
 tests/qtest/meson.build             |   2 +-
 11 files changed, 663 insertions(+), 4 deletions(-)
 create mode 100644 hw/timer/k230_dwapb_timer.c
 create mode 100644 include/hw/timer/k230_dwapb_timer.h
 create mode 100644 tests/qtest/k230-dwapb-timer-test.c

-- 
2.53.0


