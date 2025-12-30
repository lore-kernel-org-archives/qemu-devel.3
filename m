Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63414E94113
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 06:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaSys-0006pQ-Lj; Tue, 30 Dec 2025 01:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaSyh-0006nJ-6g
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:13:08 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaSyf-00046x-BY
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:13:06 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso11428526b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 22:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767075183; x=1767679983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XvspG0nwtXz45+7BcMmaNltvwpMH9nkZAv9CcUzEGYQ=;
 b=ZDCND/Y8xlXFbMAnWF6nt++uMKKEF+LLoP4mbLlOi9c5RZ04976jzhzTyoiss615eF
 sOLxgTCsOyvK56wZM5C+Y8VRHspAoK7zplvc6EScXTpL4dtrln7nc659lw+W56580j1D
 +VLhbg4JZPenqv286hW0G/GAY2l/y4HDOvKYN8mVByZau0z7beOmYAKSgMuORfmADA7c
 8KbwjuaquCStQW2uEKOa6KCLWTiJ91GBUACwAjE9IFOvculEUNPsfoFnBVxYePbkXirc
 tdiMXwFwpnbAyZA6yR8EwAHV9j1L0x2Ec/wQZBIzPa5GC6Q4OwnhAeg0Zk0ArE1OjAnn
 hIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767075183; x=1767679983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvspG0nwtXz45+7BcMmaNltvwpMH9nkZAv9CcUzEGYQ=;
 b=uD8MSGyfp6/zITrGjoWJOseBXEOO+pJXpQblf+qFF+cmmX89rUwwd2eWWltXIAya2i
 3cNIizog9JWeU0UhoEdMgeZb+DhRhAS8kWEmKwa+5cGxDE65/HTZnQbU5XztUEjAttDe
 220Ha43ec5yfGEm/MqkGPQVexg5ry8kDEbETq+0PXyNyfwsshtVV4/eqk9VHMWmeqZr/
 XqJQk6KeSdyGxryxCQ2L+4wuYk/dZKaXDXapx/cEeqq7g/MUZqwVifNJPuWZSK9v+F3g
 93nC/FMtcScODAGxUKMxJWr3vKDnp2DoCcCmlfbCD4DCu0WO7ZI9EQfKcBkWxbuHbZdq
 HWcQ==
X-Gm-Message-State: AOJu0Yxicy5Eoy36XFm7D6PNmyP16Qis/fD2Ro7pRiRGVWZ2slN4Eb2/
 1RGKfdWUKORa6whoXicF/NyjitTPwNzTVXBRNLvk/uq0TUgjPr96CnmJRK4sVGX7Tg0hZsAoD5f
 zA1FIwMPx/y2AhEk3MgYeS1+jKOmGD701Mk216D9LU+HZ8GzRVyTcYVsZsFjK4AFPNFhHbs2BIl
 01sg703XnEpfcYSJsPoLiUwNAiD2M80ldEOuAuGxnrZ9E=
X-Gm-Gg: AY/fxX71k6l5av5QjCXRzIBFvYOdfahRUEKXJ1A4xYD5cVBpuzpHl+AHzZE2T2+Czkm
 Dspcm6BhyZL6IlK1eREOJBDU7h9if8RfbMG/IsEVJF4JlpHNsMVsuApaZc5j7YiF3eCg+x0IJrB
 U+RTWTmSQ+vx3Vg1lld1XtKd48Dyd12+F7GP4q0jtDHSuPUShlu8b9xiVrpckXcejKDZdcrcwPj
 34dz4IHD9I36iWdctD7+69+CrjB1CbU5nyfPED/D/IjCbFj608Pj2qrQdmtSHppIvBVJcbm2Atx
 9pLMRY7KuOuZ7Tmf7NivMdGNyk6PN9rwZq4yGWTchlqv0XChS5O33CRn0tcFHPbJNnqTDY2IuRq
 FYSnolUOw6dZbFm2CdZIKjk8K0HWfiLCJwdq/3tY29msQqvm0OuPHt1jVV4h4eK+C9e/k3M0Ki+
 ZbF4OV4SKZ4s9tWHcGjWTsffNvhKgGGp6QZvvxCvVQyGbAKyKlcQ==
X-Google-Smtp-Source: AGHT+IHNOLQYRzcmLPaisYkHKC5Ekq693XDX9l4SeQ8SiXdeO191jT/lOToSqm2PvsfGWrawMvU6tA==
X-Received: by 2002:a05:6a21:6da2:b0:35e:4171:b7e2 with SMTP id
 adf61e73a8af0-376aacfc6c8mr27905398637.55.1767075183315; 
 Mon, 29 Dec 2025 22:13:03 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e79a1778esm26960906a12.13.2025.12.29.22.13.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 22:13:03 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v2 0/2] target/riscv: Fix PMP address alignment
Date: Tue, 30 Dec 2025 14:12:56 +0800
Message-ID: <20251230061258.15596-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x42a.google.com
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

This series fixes PMP address alignment to comply with the RISC-V
specification WARL (Write-Any, Read-Legal) semantics.

When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
value is smaller than the PMP granularity, it needs to be aligned
to the PMP granularity.

Changes in v2:
- Fixed commit message grammar ("it needs to be aligned")
- Use ROUND_DOWN() macro for TOR address alignment to improve
  code readability 

Jay Chang (2):
  target/riscv: Align pmp size to pmp-granularity
  target/riscv: Use ROUND_DOWN for PMP address alignment

 target/riscv/pmp.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.48.1


