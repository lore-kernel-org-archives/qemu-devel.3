Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21405C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgG7-00013D-EG; Tue, 11 Aug 2026 02:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wtgG5-0000u3-8c
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:46:45 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wtgG3-0005Kf-PO
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:46:45 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ceab75934dso31280245ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786430802; x=1787035602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FBwNOMc/SAl281CjXepHyn4BKE9Is/xBSKKyC3DkFWU=;
 b=G7sZLV+fpMcZA2flY1okR3+7N2L7a28ulYjQkZ+feDZMTHiHrEea3kQ9cn0DwwZf3p
 8FAud2KIelOeBiJikcNCITrTDSAE1x6s15gHn0KwnaAH4oJaIz5lmphtaAKef8zxYfVv
 SGrkOaPyPGkXdZjn/qWCMQrqEKveHfOeFIRm+BJmYopUBFv0TjcnWHPCk0RjDcwOBtND
 zOqFMgHc58wSfuS66RAZjJ6ebLvETxvIcBi93S+oALEq3tmgSK/0MomrklfYkPyipw0r
 FHlsA7G8WHtBUJNjLws+6xCZ8cFZ9iIMsjQcRI+k13Wz9779v2vxUjBfZRDuW5Jyiapb
 X5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786430802; x=1787035602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FBwNOMc/SAl281CjXepHyn4BKE9Is/xBSKKyC3DkFWU=;
 b=KuS7omZWp3/y9nt+hLzJ/Dq0uLY12QFYNV/AuQRD8yf+jtZpzujFrD/pd0+1zMaopU
 RzxT8upKjBH2yvnTr0WNdW+mNsAdMxdZbX/uEaW61OXkbSZs0wKo4OfMzC4iISBsb9Sz
 YnSZfTGf4TQNBfdGJ7DqJUegVTH1lEUdRER3GI96Gbg/1UXKUxCVcOzyz4D8m+k0ET1a
 tKetlGWoAv9wK16arm/AzzKeMsoc/CmbrQDnVUSQ4oM5UiTpKPlP1pEVhQrL9hTJkifw
 S9Jj4d1XzxWm0afFQruUIjNX1Qo5Y3MryPErHCj/bkDjy5JflyGuSMytMBZUgALkidYH
 3vJA==
X-Gm-Message-State: AOJu0Yx9RJ6edKea3dHF02g7hU1WZTbozk5DBWNuWlkJf/b3BnpI9PoV
 nRxZY7Uik0mFFgQ2AdbB99eZzhSz39Vssg6S6VACcKhXSZj14QkBfnLCsV/kgQ==
X-Gm-Gg: AR+sD12+3nOlRTIgNYtO4H0zy/NwD8g+u3xrqzXm3THu2jkrDbby8lFwvL/1y0FZkVW
 NLHVLIx0XEcpjgYBJxrZkpuMSj7QnF8NyWrJe745v10U5MYtSdFKv9+fVA1AXGm5U1EkJWqKp2b
 1jTxCEGoJzoufH7u4dDesM/rQou0l33rfkaTqfFTY30G4m9vQPWc6EZlDMxAzQecIwTRJLG35hJ
 3Fjy671oyevcX3ZNCjqoF5UgcyVExDOM6Hi7ADAPIXVpHtFhUmGcKAVvZvnQoNQE9G7TEAYD+Vb
 328TBohaiuxntkOFsSs6bhROwIANPwLqu53qc1RAZQbxw5OinbTXW7qG4etWxiJCW2Zq36hZLww
 Te2SIixDHOfjkkhYCYdIHFJsnqmT44iIDLfzcSD3s7Dgkkq4c/kv1ZnrkzOtcjaIh1CYgHZp+Si
 TwxADzDSwZcw99KQh2Bi359lMk7pVxdnrIeoSjPce/K1YpUqQp6Qadq5dXxa94cKUMOmulBvLj
X-Received: by 2002:a17:902:da8c:b0:2ca:f8ef:33e4 with SMTP id
 d9443c01a7336-2d3178f4d33mr11782915ad.17.1786430801760; 
 Mon, 10 Aug 2026 23:46:41 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.235.190.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d315f3ffd5sm2591015ad.30.2026.08.10.23.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 23:46:40 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 caojunze424@gmail.com, bmeng.cn@gmail.com, raoyi <rao232328@gmail.com>
Subject: [PATCH v3 0/3] hw/timer: add DesignWare APB timer
Date: Tue, 11 Aug 2026 14:46:07 +0800
Message-ID: <20260811064612.16517-1-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=rao232328@gmail.com; helo=mail-pl1-x634.google.com
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

Changes since v2:
- Per Bin Meng's review, refactored from K230-specific device
  to a generic DesignWare APB Timer model with num-timers property
- K230 board sets num-timers=6 and clock frequency accordingly

Changes since v1:
- Split into 3 patches: model, board integration, tests
- Remove goto pattern from read/write handlers
- Fix include order, add explicit bitops.h include
- Add QOM <private>/<public> markers in struct
- Fix copyright headers

raoyi (3):
  hw/timer: add DesignWare APB timer model
  hw/riscv: add DesignWare APB timer to K230 board
  tests/qtest: add k230 dwapb timer test

 MAINTAINERS                         |   3 +
 hw/riscv/Kconfig                    |   1 +
 hw/riscv/k230.c                     |  32 +++-
 hw/timer/Kconfig                    |   4 +
 hw/timer/dw-apb-timer.c             | 341 ++++++++++++++++++++++++++++
 hw/timer/meson.build                |   1 +
 hw/timer/trace-events               |   8 +
 include/hw/riscv/k230.h             |  12 ++
 include/hw/timer/dw-apb-timer.h     |  65 +++++
 tests/qtest/k230-dwapb-timer-test.c | 261 +++++++++++++++++++++
 tests/qtest/meson.build             |   4 +-
 11 files changed, 728 insertions(+), 4 deletions(-)
 create mode 100644 hw/timer/dw-apb-timer.c
 create mode 100644 include/hw/timer/dw-apb-timer.h
 create mode 100644 tests/qtest/k230-dwapb-timer-test.c

-- 
2.53.0


