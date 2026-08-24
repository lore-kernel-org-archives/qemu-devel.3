Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EDDC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNgn-0000CF-3p; Mon, 24 Aug 2026 01:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wyNgN-0008T4-8i
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:57:23 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wyNgA-0004E5-46
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:57:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84faf87d19dso3031798b3a.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787551023; x=1788155823; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Urw+TPvG2B1ng41zr1P/WXr1QBJ22AO4z2NlpERbuIk=;
 b=f+xOUq3e8OAqwMCiOSHSjMjdBTAdTICEFePqGlv5RH+NEGeotjoLBKAlzAHJpZvZgP
 Lr3N0zQp2a0c+MMaFak7vi+xEXCKND+6v1+/JBA+qiE45k8MsSexaBmizxKSBFPDRqNL
 6x1hhhqNPtrFemKXTlr3MFbSqjP5C3gN+vnit6E4JItv1ZiArEesPLdQ90g0q3hBbD+i
 V8cS11e2FE2h3lSre/XZYXVBpUs0TLCOTKAAp9c1V9tFWSsEnOwEybnBSvWXchJe420P
 uhjUnvS8qQSgOUsyVgyvLaaux3avy7H3fst3SzCEvSpkH/P6bKfUYDDFFOEAF4sVXKJB
 4T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787551023; x=1788155823;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Urw+TPvG2B1ng41zr1P/WXr1QBJ22AO4z2NlpERbuIk=;
 b=iW0MKMc9pnwmE5D5O0dbGLGJPj35gPNphsD1+lpQcW7ewLeY6kOxqFDbOPK9VGwwV/
 7/5UktT5VMZf87HkiTGFK4CnScHHUfZkpXT6GWHZJ0am/wiVJ6NQ9KQRsGohIH6gyYmG
 1QHyW6IUpN7ZaWqx+bdRHRmYzsbhcLO/oqKWd8IbTZ8ivUytYItaOP0bsorLOzRVTcCN
 Se+gMmCcPvi9h5RqYvEtNqUrCHWGs3X9yCF9B3/VYDZ3FiQj/SuAspMxYUYdjvT+gUnT
 1nXC2n9Wq29csNbE4bqyUgCBpoL3S9/V8FDAE5c6qtln8fwWb8sf8+6KrEXxIrmAbpZA
 AKeA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqinHLqPPXmr69u7R1OzuYYHf7sd/gm4V7acFNkigNF+mvH3xLClB2Ky2cJMtlGvpE96Td8h3kqsDXY@nongnu.org
X-Gm-Message-State: AFuF++mCpyc0kvXjpd1W4tq38ps215K91TwV/vJ0vUCdvDT56EQNXvro
 879PrfYL58xd1u2kmC/TUehbLKifG8dq84XjtZ+eaxLvqCSQgQXrMvs5
X-Gm-Gg: AR+sD12mknKy6KksKMhyPTa7CHvhm0kApDGr92CQftjgifNL8TCwQOof2f8Hqtd9foN
 6Mg+B58CXMdYfuLlOesY1jrQ/DiCc8k3jScxz9lpBbNR65xNAPtDRXJGIDlVkogo8Qtp1+kevqa
 fUWp7UItB51Y9wtBvoCTKJRiW99t2M8C4k4nYbDI13yidugQlRycImfJyfVL0HoaprVxId06juI
 9h5HE/ucdof5G4B4YCQ4G8KfVHCW38tRUF2NhlAo07kfwtfFqZgYKbbICwaj5Wzr0dKypz/K/Xv
 DMJ078v/nM4/037wrrQSThdWMQQywkb8SRikxE6EqqFsIwsddqUiso9Rl0TFw3dTorf5jsWG78A
 Bxp4B9ZZwCJ1Uvg2UVkbhMvQjnhLZ1QwMc3PBaSZiVeDb284B8YN0RGvuAwcpQCTwnegx4RkiSP
 OUBAFuEpJHvCr+TYoPk2OUxHwNarGjKP9mZRrMfjFpodcmusBbhS9Zh4EKvUyDhFCd1eoAkuy8P
 qI8W2NqBSIo6b3RAQGeXuuA20UMie6suD3in7YhOI1FHnqPifBOodHS5R8X0XIj+TwpJt+G6vuv
 8i2C9Cjz4QPET+QR5CRc4g==
X-Received: by 2002:a05:6a00:2d86:b0:84e:24f:2677 with SMTP id
 d2e1a72fcca58-8520b966111mr26176715b3a.4.1787551023463; 
 Sun, 23 Aug 2026 22:57:03 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520f03b494sm1583474b3a.33.2026.08.23.22.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:57:03 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/riscv: Post-review cleanups 
Date: Mon, 24 Aug 2026 15:26:36 +0930
Message-ID: <20260824055642.41098-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Phil made a bunch of suggestions during the Atlantis review for things
to clean up afterwards. Here are those cleanups. The patches are
otherwise unrelated.

Joel Stanley (4):
  hw/riscv/boot: Make RISCVBootInfo const where possible
  hw/riscv/virt: Use hwaddr for IMSIC device tree address
  tests/functional: Avoid unnecessary removal of scratch files
  hw/riscv/atlantis: Document QEMU-only I2C device tree nodes

 include/hw/riscv/boot.h                   |  6 +++---
 hw/riscv/boot.c                           |  6 +++---
 hw/riscv/tt_atlantis.c                    |  1 +
 hw/riscv/virt.c                           |  5 +++--
 tests/functional/arm/test_bpim2u.py       | 11 -----------
 tests/functional/arm/test_orangepi.py     |  9 ---------
 tests/functional/riscv64/test_sifive_u.py |  4 ----
 7 files changed, 10 insertions(+), 32 deletions(-)

-- 
2.47.3


