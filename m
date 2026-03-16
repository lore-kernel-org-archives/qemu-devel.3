Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861A5F30295
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 02:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1y2Z-00025E-OX; Sun, 15 Mar 2026 22:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1y2V-00024p-U9
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 22:50:43 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1y2U-0000UT-7d
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 22:50:43 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2bea8220c38so100373eec.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 19:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773629440; x=1774234240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFV8pUWgtx+69aaPDmrdLgnX5kLnd23GngIxOmLhPpQ=;
 b=nLnnDHZCM09HIGeiuf8i+zJ3TcpkLlyRkEJ3ZvJ+g6lCmfzIADKcWDfwYAnuCWjPLP
 xgOPcIVflaS3zZl0SxuseXvj8cYY2w4em+VuOW95YRDcBpdjUw18Hru1q8LJ7dTkujJu
 lvdNj/iQHYD/u7pgJCQp1jLC/iGVOd5vgMuxjICn0SXxcj0KYtrmwAEZF92nBHajUKBK
 3yzrQa30IBcbVa90Ed8uouE+W8zjsFczBuzgLBOA8a6GaS4b4iG1Zx4hJzoqQOqIjtrQ
 +qGHy5Hpx9hrqKoWT9DxM9/S2oVBrGfElwaYUgK1cNlYLF3YLIQHbd9QiK7zynwbtvQs
 CcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773629440; x=1774234240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bFV8pUWgtx+69aaPDmrdLgnX5kLnd23GngIxOmLhPpQ=;
 b=l5umksjBbE2Whn6I7BA9qS3s9s4oS4DECIuFJv00lGPlCFinaU1zK9xr89mtUHA33s
 v/+aEjAbkuptNiLPJbHZqluIzxkKF+Y06Lg4QUAcBE0AoN3Pfr1dzVejMbFYQVcssYFZ
 FTQASDM8NEBAq5CPNdyUK0xtYqQ+BTx99d4+sbZdBboPlK/WYvoD15dVrFHdLrVWDhXG
 qXXhiYn8cTC5dJSdx2aT6yVprAl6wk2VF5gU8qJ3YiWuDPHoKguzhiLxEadLuTxKdh/L
 n1D2fpRsMju8nd2DFSWjDj4SbdCNTfvonvtfOFjaskBsJ0DOnArD9FOwm6BSNNPEbZJs
 Q5MQ==
X-Gm-Message-State: AOJu0YyPgWKfqxLGiFcF4N5B8THKU7KnFHadvvuoE441XQWqacQOm28j
 BMyLDI03qWVLBhmGa1zMhM5dA13uD5RnG3pcAAPhQYBrAskfOk+oIziF5O8tMzuB
X-Gm-Gg: ATEYQzyToyK/ayP20Zz/WZ1QS32f21Ew1S3ZRPNIo9YgiKHboVdISwQpyd/olxmQN9A
 x424XgRD+JSRG4fsGCgwwQQqDWEUF6K806eT9iUdX7e1zOVvzkzBE0Tqhqm2UZDArPnJdO7QSrP
 L7VuBFgzmWcPnO9cEBn9avZhU8ZkZDqqzfLO/4hvbZri9u8/hIE5tDa1PTjO/W2poZah39dTj5o
 ijGIXO/ELyLJ0CmKG3AOkDhUcc11mFJS50d8mx5wjrS2Z9d28fjCxalidvAU25z0ke+0UVa1J/K
 Z4S24j01IzAlBLIjO02Qi+sl160HgUyCm/T4GemG9Mm3jJmPRhhcsB6gL9esXLQq718NKvwMarq
 +1J1f9XR/6jVF8TULp2l/rOivzjp+m987X1V0uH+hRwBjjMtXe3R/C2Mk2lwtVrmwG4MMzryIQl
 kZ27vNjMo/Zx1qQMr4j0NwE3s0K9Uvr5lpmxwgc1I=
X-Received: by 2002:a05:7300:a984:b0:2c0:cc90:a71 with SMTP id
 5a478bee46e88-2c0cc901e39mr54521eec.8.1773629440409; 
 Sun, 15 Mar 2026 19:50:40 -0700 (PDT)
Received: from 192.168.7.2 ([189.6.247.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3a12e2sm13138973eec.2.2026.03.15.19.50.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 15 Mar 2026 19:50:39 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v4 0/6] target/arm: ISV=0 data abort emulation library
Date: Sun, 15 Mar 2026 23:50:28 -0300
Message-ID: <20260316025034.85611-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260315034123.41921-1-lucaaamaral@gmail.com>
References: <20260315034123.41921-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add a shared emulation library for AArch64 load/store instructions that
cause ISV=0 data aborts under hardware virtualization, and wire it into
HVF (macOS) and WHPX (Windows).

When the Instruction Syndrome Valid bit is clear, the hypervisor cannot
determine the faulting instruction's target register or access size from
the syndrome alone.  This previously hit an assert(isv) and killed the
VM.  The library fetches and decodes the faulting instruction using a
decodetree-generated decoder, then emulates it directly against the vCPU
register file and memory.

The library uses its own a64-ldst.decode rather than sharing
target/arm/tcg/a64.decode — TCG's trans_* functions emit IR into a
translation block, while this library's execute directly.  Decode
patterns are kept consistent with TCG's where possible.

Changes since v3:
  - Inject synchronous external abort (matching kvm_inject_arm_sea()
    syndrome) on unhandled instruction or memory error, instead of
    silently advancing PC or returning an error.
  - Fix WHPX advance_pc bug: error paths no longer advance PC.
  - Add page-crossing guard in mem_read/mem_write to prevent partial
    side effects from cpu_memory_rw_debug().

Changes since v2:
  - Split monolithic patch into 6 incremental patches: framework, then
    one patch per coherent instruction group (Peter)
  - Removed per-backend callback ops; library uses CPUArchState directly
    with cpu_memory_rw_debug() for memory access (Mohamed)
  - Removed mock unit tests (Mohamed; kvm-unit-tests is the right
    vehicle for decoder validation)
  - Added architectural justification for separate decode file

Lucas Amaral (6):
  target/arm/emulate: add ISV=0 emulation library with load/store
    immediate
  target/arm/emulate: add load/store register offset
  target/arm/emulate: add load/store pair
  target/arm/emulate: add load/store exclusive
  target/arm/emulate: add atomic, compare-and-swap, and PAC load
  target/arm/hvf,whpx: wire ISV=0 emulation for data aborts

 target/arm/emulate/a64-ldst.decode | 293 +++++++++++
 target/arm/emulate/arm_emulate.c   | 758 +++++++++++++++++++++++++++++
 target/arm/emulate/arm_emulate.h   |  30 ++
 target/arm/emulate/meson.build     |   6 +
 target/arm/hvf/hvf.c               |  46 +-
 target/arm/meson.build             |   1 +
 target/arm/whpx/whpx-all.c         |  61 ++-
 7 files changed, 1191 insertions(+), 4 deletions(-)
 create mode 100644 target/arm/emulate/a64-ldst.decode
 create mode 100644 target/arm/emulate/arm_emulate.c
 create mode 100644 target/arm/emulate/arm_emulate.h
 create mode 100644 target/arm/emulate/meson.build

-- 
2.52.0


