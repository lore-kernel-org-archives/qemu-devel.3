Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C96ECA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 14:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uto56-0002vf-EG; Wed, 03 Sep 2025 10:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uto54-0002ub-FY
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:03:22 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uto52-0005ro-Ix
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:03:22 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4cf40cd0d1so4420184a12.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756908198; x=1757512998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M3w8RPIf6POZ7C7KJr0+0dx8T0d/EoIA746DKMDQLsw=;
 b=nIZwuSrwSu4YG9UYMiM7N6ijmsDno+rBaYxs1lT1G8gfRwuk8BCYENlFzPZeAXA7PT
 2hn++B9YVXNMrqmr2P2pOx1U2QndYGd7hCYorpOZOW6S1uH0PbwJD4JIGidKjAiowjGD
 8jhQFvGGAzsmB8xGwuVhrMyTz/AqBboBhGl79LBTYdrU6B9xNYP7jgQySWDepYmbrVg5
 5OxWyfScyp9+GaAxQrae4VficgvTMxCx6keCtrVHlmmQgIPJ5CukiZfn/Bv2hgeqOlJy
 qRd4oUbs1iVBraRhKbSpxfM5EBmR3EADFOppfo6NDEeCkjAEabkf1OppKG0biZxiJWmn
 fEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756908198; x=1757512998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M3w8RPIf6POZ7C7KJr0+0dx8T0d/EoIA746DKMDQLsw=;
 b=FHdO27O/+IicpD6j94cyZ71WfihBJ9WsMR2NPLws047LLmCl+1b680xQjYL9ehtiOS
 3gTxzBCBk2k3c2TLxNjGpqu0sgSsORgNvkhBpGvXuInVonhVWr6yK9wMpIyxpjgOKsFQ
 GM/BcO4JYTmNu+LQiFWxFcFdTqkqbxvShAxogGtMhiXlQcCeEIz4Oi2j3ea0N5PN32lI
 58zDsgq2ds2T0Zq1zOpfiqnHu5xclzuZgw3mrCSR8bv8697p/GL+GkaBpAcQzyTWzK+5
 xfzBPEITjJwK8eG5KCCi2kS0/vD+wUpe8ZNcMk+RTf4ydDcAlGkvo1bS3G5A1Y6Hx5QT
 vFgQ==
X-Gm-Message-State: AOJu0YzF3MRLYGm3ezQIft45KWzgiUjNVlj/4dLdjoLwOcPZ2bFVXaky
 82QmFdQetiANfH9ugnaezzquBUOjaArhT5r0GY63bP0olwiRbewXsQmPcv1oej4q1zt2sJDYHsi
 veNT0sD5P+dTQMIgDpFjW02lBjzV3jG4SOtTbEVHfBXDSPonqQZRdSowEXNG5OLwSRUkoMUvvew
 VIc2aznxm3rCqdPneGR368YGnUQy/VKMsF8IxzFwWMlg==
X-Gm-Gg: ASbGncvciLFs3oObgfWrRh45nKLLfKfrWX+1LJ7eLdg54QV+CCcq22C1GzGMdoj3zcV
 Br0toSsgHkMBh2cB2Co7lqzKzTXCdudftXS8FD6DjPbgNl+V+Bpy/glHNyiWqnsT3OAUabJuP7E
 75WG/w+giKx/s4lMyDIDz8QBUSuoJn7Btg41VmsOiXRByvZD75QsCWXuDgBWS7AokzAb6D02Nmm
 Gu4bMbwCs8MYuQJaAfxzpuMeTNkvZTG1iBBFLIEiKrdrl8GTwDx/tYJ3llvReHLCjDp947kVoNm
 jJo9s+h3DsOcXedCFhN3zUGG970gEh8X9cBEWW5+fhSFPbY4RsklubZgAcuUYnUmEWA/voMC18D
 3qcssROcoXj257Ih3XI9NzgnjLOSC89iIvhRdDL0RX3oeAO+wxZAd+Y+N7+096S4ckNc=
X-Google-Smtp-Source: AGHT+IGmwPKj+NIB4ibRpFo+qrVCUgx3VQ4yjuv37nyVsu4JyUVD6hIv0tXX3cpri6qsihD+ULfZJw==
X-Received: by 2002:a17:903:298f:b0:24c:9c29:c9d1 with SMTP id
 d9443c01a7336-24c9c29cca0mr24237415ad.59.1756908196477; 
 Wed, 03 Sep 2025 07:03:16 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b14e1b097sm50720545ad.21.2025.09.03.07.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 07:03:16 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v3 0/3] Add Zvqdotq support
Date: Wed,  3 Sep 2025 22:03:05 +0800
Message-ID: <20250903140308.1705751-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This patch series adds Zvqdotq support.

The isa spec of Zvqdotq extension is not ratified yet, so this patch series
is based on the latest draft of the spec (v0.0.2) and make the Zvqdotq
extension as an experimental extension.

The draft of the Zvqdotq isa spec:
https://github.com/riscv/riscv-dot-product

v3:
* Fix casting and simplify vs1/vs2 access (Thanks for Richard Henderson's
  suggestion)

v2:
* Remove unnecessary variable and mask (Thanks for Richard Henderson's
  suggestion)

Max Chou (3):
  target/riscv: Add Zvqdotq cfg property
  target/riscv: rvv: Add Zvqdotq support
  target/riscv: Expose Zvqdotq extension as a cpu property

 target/riscv/cpu.c                            |  2 +
 target/riscv/cpu_cfg_fields.h.inc             |  1 +
 target/riscv/helper.h                         | 10 +++
 target/riscv/insn32.decode                    |  9 +++
 target/riscv/insn_trans/trans_rvzvqdotq.c.inc | 61 +++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                    |  5 ++
 target/riscv/translate.c                      |  1 +
 target/riscv/vector_helper.c                  | 57 +++++++++++++++++
 8 files changed, 146 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzvqdotq.c.inc

--
2.39.3


