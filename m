Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0904D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 21:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3SA-0005Hn-MM; Sun, 11 Jan 2026 16:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3S8-0005HJ-V0
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:29 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3S7-0003pe-4M
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:28 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81f3b4ae67bso570669b3a.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168705; x=1768773505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VktFmYwbNak4rx63/CkzhXp2Acb2T9tdf4g+0JQIRZw=;
 b=SyYCILPNkMtj8rVAhzPm+Oel+vvHG7evceiX0VEJWH1G4vujI/0VbvfeF32EQIsFVV
 VLSB19+8lXS5z0oqF4NUQPbJaD43J7+W8otoM+j/D/YKVIvD3Z2EDZmHS5qL8MLAjrEz
 1WyP6jsCc9yNBYBRuwvFSlP+IpF7vyZHnncuJc7lMpDHdXF4zClWLul7HY8PEeBWnyCI
 7hsucERwg0gfMYu5LoktxqotrTpEL9DS9GQ8oO6JQ+4rn3XYVAf+GeAqmgCrz9LFj+r3
 rMVHZVOw4uI/0yJN51Ybl2VLmhhlnL9cPY61Vy1VcAFYAG0+S7cqG+t7NjXJ18XcrclJ
 +jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168705; x=1768773505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VktFmYwbNak4rx63/CkzhXp2Acb2T9tdf4g+0JQIRZw=;
 b=KA4rKWjmLJVI+0Zy8pB3eK0NcCGtPaVMmjRgyoGJTfUDSjrPZLLzUi9QCQ0LDk/AWK
 zdsW64l6HzVm5Hjvcx+w9anG2NbBZ6WAFB0rAgoyhl5wUFIWBu9+qUi0QWwQjBjTMT3o
 GAf4g4bS4paGpGLuJej6AHLSiJob2lcMS6Xl0KLoZf4BBWysAfxuBCEQpcTuoblX7VZr
 W6N5jFxG6RdmLZ0L06ulPRjYopCT+SA+cEpkNHBUR5gztlJCkzl4SDrrzoOnNs3UE3zz
 YxZtTTEiic1rEEw4xP6Rvv7963PyA3L3gWrQ83ZAX9UrTY144OHIGaH9ZG6Ob+lwIa4h
 2aEg==
X-Gm-Message-State: AOJu0Yzw8X/+1y2QR6ynwfcY2tsH2CdLitT8D0evsm/Cnav2pHOwtxey
 H7eK3ECBmKPYUIs4SpfPZwfvXObxv8v4A90vneJcSXBFiUXY9LZ0tb06/IkPuUZYGy7L1TwpGrT
 VvmogPjM=
X-Gm-Gg: AY/fxX696tL3iwTJa6C+f8XnUPIp0+BYONixojuPjksZLUgOdnkKPgNbgoXS/qsk+uV
 /RgfNQxnJ7+rtbem85/pqkorrCN+VY4c/nDVvT3mSDNnpO0t2d8/4RvKYvl4dhY1pSg+08YSTK2
 cCH7EQ0d86QSCYEpxKAG0sHNLAxFrvw8bxje5Bos3aZYkGxbJSXAFOQI5+Ppv0jIuIvPVeZQbmy
 +WxRMe13ZhOsIfV8OJsUNcwG4Sh+e3WznY492QF1yRD2UWj6E6BMs9Im32yf/o0UpFJimF6UPQa
 fn2cSbup65hRD7HlLky7NlffxB0ghvm0cQJoK+DAdrNyEjUHw+TEHm+1H78WgXnCTZqmorqmPo9
 ca12V4XTkK2cIPdJufBxpSlgUr5gPm8ewX2cgJFjVHFqYcv8+8RIxX1dVGwokjLgzEFNhRRQLJE
 UsH5kXqJO0ppgwTHM=
X-Google-Smtp-Source: AGHT+IHdIuQ2y9oHRw/OGeiZDvmKDIyouGOeM5Lteld9kSk8+9IIijkf3CunSgJm7QvTkKcPNlktlA==
X-Received: by 2002:a05:6a20:3941:b0:366:14ac:e20d with SMTP id
 adf61e73a8af0-3898fa81a9fmr15238322637.75.1768168705122; 
 Sun, 11 Jan 2026 13:58:25 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] tcg/linux-user patch queue
Date: Mon, 12 Jan 2026 08:58:05 +1100
Message-ID: <20260111215819.569209-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

The following changes since commit b254e486242466dad881fc2bbfa215f1b67cd30f:

  Merge tag 'pull-riscv-to-apply-20260109' of https://github.com/alistair23/qemu into staging (2026-01-10 10:31:57 +1100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260112

for you to fetch changes up to 365a2248ae69f306fe7997fd966bcb1c16a08695:

  meson: disable libatomic with GCC >= 16 (2026-01-12 08:49:33 +1100)

----------------------------------------------------------------
tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}
tcg/optimize: Fixes for o_mask and a_mask
linux-user: Correction to HWCAP2 accessor
linux-user: Fixes for mremap
linux-user: Implement epoll_pwait2 syscall
meson: disable libatomic with GCC >= 16

----------------------------------------------------------------
Daniel P. Berrangé (1):
      meson: disable libatomic with GCC >= 16

Jean-Christian CÎRSTEA (1):
      linux-user: allow null `pathname` for statx()/fstatat()

Jim MacArthur (1):
      linux-user/elfload.c: Correction to HWCAP2 accessor

Matthew Lugg (4):
      linux-user: fix mremap unmapping adjacent region
      linux-user: fix mremap errors for invalid ranges
      linux-user: fix reserved_va page leak in do_munmap
      tests: add tcg coverage for fixed mremap bugs

Michael Tokarev (2):
      linux-user: cleanup epoll_pwait ifdeff'ery
      linux-user: implement epoll_pwait2 syscall

Paolo Bonzini (1):
      tcg/optimize: Do use affected bits

Richard Henderson (3):
      tcg/optimize: Save o_mask in fold_masks_zosa_int
      tcg/optimize: Fix a_mask computation for orc
      tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}

 linux-user/elfload.c            |  2 +-
 linux-user/mmap.c               | 16 ++++++++------
 linux-user/syscall.c            | 47 +++++++++++++++++++++++++++--------------
 tcg/optimize.c                  |  7 +++---
 tests/tcg/multiarch/test-mmap.c | 42 ++++++++++++++++++++++++++++++++++--
 meson.build                     |  9 ++++++++
 tcg/riscv/tcg-target.c.inc      | 33 +++++++++++++++++------------
 7 files changed, 114 insertions(+), 42 deletions(-)

