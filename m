Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EFECAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4lp-0007Vr-8y; Mon, 15 Sep 2025 04:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4ll-0007V8-UM
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4lb-0002OV-Sd
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-b4cb3367d87so2483895a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 01:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757925646; x=1758530446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iih7xAbkIVwm8hs8ScdLl1IC5PFzgf682PIyp/aNopc=;
 b=bn9YJUQbIKpw6q3oNT/Luus4HhYcgGYmBWY0y+r3opN6DX6ChasmNhG/0GR+lMwvZt
 tlOk0VyDta0tLVDzuugXP6yMnkxgGOFqyLu3TCuUaj0L8tttX5f/VrWzPbPfMmMfGqtx
 kqEGp4hD4GqTpUkfqs5c3GG3QnNIiRPKETOJXEcq2ld+JNK9PBg4CeVXu5Ps638upO0k
 NBM8o2IbU8QAEw7mMxQmuhYIJOyK3bYqsHQ1EdfhCZudj9/MC9fSrj+F2n65gxzj/HW/
 CF5cFHTr0yQbdUfG39nkbvobqCTxWfqKwDPJYLoUBp7fUjrsABbdQ5vXQL8Q7D+0M5ae
 4cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757925646; x=1758530446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iih7xAbkIVwm8hs8ScdLl1IC5PFzgf682PIyp/aNopc=;
 b=eBHMWmXTt0rxDfRmUxqX5DWo8k39K+i/SgX9O6+B/0K9/yCljZl9RfswYdqx/Y1pKb
 Jhld7zPwO317sxEmp44TV4yHy+Md+FIh25dlHUIY7MhtvuUlM7/yyLUwUQEwwbIs0lak
 hf6pGV/58Omvnlm0WzMQS7e6aGqX0FV/QpL5Q0uhWrjo8hBPsDeEr3Sc/J8Qu2ycqJVF
 UaVwC4e/wc08e8rJgi5VTj9abAyuhQlFP3HMHiX1jsZtEfM0SeQ3tDtsjXFF7vnD5WQJ
 /DmN9FmwY5ot9EKSXQaEIEhQmRysg0tJUOTLbs9yinIJryHUqgVxGPUiwZ2yXsXRFXEU
 E/eA==
X-Gm-Message-State: AOJu0YydvDRPkjLUxZJcvy8wTBaDDGolxZo1c6Hqhn2fqZvy7Bb/h5sB
 SLu6c15pA1KU7OEHo3PtcK5kfwaC9JvCzaINeGDhAVo36hOZFdaHqFYxOcctCgiMKMfR+RL7RW9
 Qb/PmTNxuvZRHZHyTvSkj+XwhFI/QwbFKKD5sJIz8b3ibK8sq/4KYzZYbbaykP3B1yp6qrB2kuP
 dTdYaFjIIUSDMduqskZa9Q1PCYvYciACmUc092kjEM2KZv
X-Gm-Gg: ASbGncv4hetuH7+qDJ2M/L9hiqJfRZ+PpHSX2xw3w6V1BBmlL1jD29nUd8xE2+paGod
 Xb2ra89gn71Jh3PbK6Veea0Tt17jcMehG0fB0LncSgCUzna8IKCb7Aa9/BKxfEOFuPOh/3yz6XN
 q8zIgQXZq7Ogpm/WIw3LS1XuqtZB4sQwA4kOmQkRiAlI3szbzfg6XbK3S4d7tnBliEftAegTSsh
 rKBLDz4r5H7vP1DxdXaO/q0xlCOVCHkyD20n1pZAJFO+NLsIH8R8TQLYGcFOFBcLSf0TGaJ6r4p
 q7FFqw2Bov2FjreiSuHqSosKapXWMfUSG8GZJSHIGJWPz3I+uu2ozIKJLWAYYMht7KQlBTSt5t5
 /HjOtCVOlZkZHZNZUAL/7ZePJJy3Pvd6TJb9tWImIecmYjalG2cxVOGjqtcnUPKSvCi44OO3ysl
 FYEg==
X-Google-Smtp-Source: AGHT+IF8GBKsn2E2IqWQIh9yf8BJT6AoeA++IiWEUePN6Gkc5Dd3heep8A/874CYVHPH0RbCWdip4g==
X-Received: by 2002:a17:902:ea09:b0:248:a4e2:e6d6 with SMTP id
 d9443c01a7336-25d268660d4mr128827905ad.39.1757925645542; 
 Mon, 15 Sep 2025 01:40:45 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26295996ff6sm55852045ad.64.2025.09.15.01.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 01:40:45 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 0/8] Add Zvfbfa extension support
Date: Mon, 15 Sep 2025 16:40:28 +0800
Message-ID: <20250915084037.1816893-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x541.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch series adds Zvfbfa extension support.

The isa spec of Zvfbfa extension is not ratified yet, so this patch series
is based on the latest draft of the spec (v0.1) and make the Zvfbfa extension
as an experimental extension.

The draft of the Zvfbfa isa spec:
https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfbfa.adoc

Max Chou (8):
  target/riscv: Add cfg properities for Zvfbfa extensions
  target/riscv: Add the Zvfbfa extension implied rule
  target/riscv: rvv: Add new VTYPE CSR field - altfmt
  target/riscv: Use the tb->cs_bqse as the extend tb flags.
  target/riscv: Introduce altfmt into DisasContext
  target/riscv: Introduce BF16 canonical NaN for Zvfbfa extension
  target/riscv: rvv: Support Zvfbfa vector bf16 operations
  target/riscv: Expose Zvfbfa extension as an experimental cpu property

 include/exec/translation-block.h           |   1 +
 target/riscv/cpu.c                         |  15 +-
 target/riscv/cpu.h                         |   6 +-
 target/riscv/cpu_cfg_fields.h.inc          |   1 +
 target/riscv/helper.h                      |  60 ++
 target/riscv/insn_trans/trans_rvbf16.c.inc |   2 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 992 +++++++++++++--------
 target/riscv/internals.h                   |   1 +
 target/riscv/tcg/tcg-cpu.c                 |  14 +-
 target/riscv/translate.c                   |  11 +
 target/riscv/vector_helper.c               | 358 +++++++-
 11 files changed, 1064 insertions(+), 397 deletions(-)

-- 
2.43.0


