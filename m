Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F2FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 18:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMtTR-00017g-EU; Thu, 27 Jun 2024 14:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMtTP-00017B-QK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:03:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMtTN-0001LW-T3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:03:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-706aab1b7ffso1526652b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 11:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719511432; x=1720116232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DxICO0F0UJwA9kf7MHQo5KZWHjxvwUlAc5IoQOIpIPQ=;
 b=YfW1Bm5IFGEc6/qEGvzbAB7+KCNtI5GQRDFBwuJHeW6UzRgwOi1E2PY2sDXkZt+kjN
 Pcbsqf+yf4SyOuLVkqlFeCS8Fa9amEWThIKtXPx4BxB7/kXFjSK4mtt/bTKAqWnXG/xj
 Rs6cQa7ZmzkXZJAyjQmtvbzyFSI7wUoEi6y20yVgAKLHVloFlyqTH6ssu7/HTSvmtBf/
 x784qnzYxO9x0NOdJHW0Fhxcr+/37JA9ywfA3aPvELxc26bHma/GPA6QZtTW7NRQs1hv
 bLyGt8s5AkABsBnoHKK0hIh2V02ejCR/jF5OMlLPZk8uKZKxsZhxVS7TrusibanstEAn
 ZYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719511432; x=1720116232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DxICO0F0UJwA9kf7MHQo5KZWHjxvwUlAc5IoQOIpIPQ=;
 b=tRfnduAEK82xLZ8POuIPyKUcv35jdWe1qm5J9c/IrNVYLINPOL0wPIDKsvBQMNw7xy
 w9U8SX/Ww50tVBdvugLzK1eWl27dfeu4/j6ikddq9vTEJ1eUktZr3lPY26nz9GHPQa8P
 ODpq6HEeIjqORHtDeuHHtmJM0UvzT9ENAK+VZ8zJnga6FTIx1EWVRdPs2ysOv0UY2mGe
 Z9LFLzTeycwpMJce5pphUvMB2B+/wVsl6phSAJckGFBit8aTm0hBMXLDimeywyg5lIhZ
 Zi03ph0t9atVTxVDbDIkL+d4wjyTvagAjYl67op++6NIE0rlC6wRhEFZNt/QTFjU60sS
 mXQQ==
X-Gm-Message-State: AOJu0Ywff9NwAhULvbgrXVCScUVE49NpH7+GzfHAMid6bHT4VY00qc3w
 PB23xSKy6oMJXvM6vHsr2Ovcna5vxhOk6zhPA23Zx1wAMH2JG/ZIvaGI+Nn1kJOJIrwhEZEhkLV
 L
X-Google-Smtp-Source: AGHT+IEYKhu6juYqZWS/IjBBWxmc7Mm7kpR8o+6dr4QCIKxo2aEm9TBOxS7bwAxef7cgk1nOKlYMQQ==
X-Received: by 2002:a05:6a00:2fcc:b0:704:2f65:4996 with SMTP id
 d2e1a72fcca58-706745b45cemr13741508b3a.11.1719511431951; 
 Thu, 27 Jun 2024 11:03:51 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ecf764sm2170b3a.106.2024.06.27.11.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 11:03:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: brad@comstyle.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org
Subject: [PATCH 0/3] util: Add cpuinfo support for riscv
Date: Thu, 27 Jun 2024 11:03:47 -0700
Message-Id: <20240627180350.128575-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Do cpu feature detection in util, like other hosts.
Support the OpenBSD ucontext_t.
Support the Linux __riscv_hwprobe syscall.

r~

Richard Henderson (3):
  util/cpuinfo-riscv: Support host/cpuinfo.h for riscv
  util/cpuinfo-riscv: Support OpenBSD signal frame
  util/cpuinfo-riscv: Use linux __riscv_hwprobe syscall

 meson.build                       |   6 ++
 host/include/riscv/host/cpuinfo.h |  23 ++++++
 tcg/riscv/tcg-target.h            |  46 ++++++------
 util/cpuinfo-riscv.c              | 118 ++++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.c.inc        |  84 ++-------------------
 util/meson.build                  |   2 +
 6 files changed, 178 insertions(+), 101 deletions(-)
 create mode 100644 host/include/riscv/host/cpuinfo.h
 create mode 100644 util/cpuinfo-riscv.c

-- 
2.34.1


