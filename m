Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40B2FED9F6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YWT-0003MW-D9; Tue, 17 Mar 2026 13:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YWF-0003Lc-CB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:47:51 -0400
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YWD-0006xm-Qp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:47:51 -0400
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-127380532eeso801792c88.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773769667; x=1774374467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R8sGN3pUZfb1jPFD6m9bHWDlQGgRDF8SFG+PAv18Xgc=;
 b=LRaY72vx1y5PFhBszqS/QUbuiZYelmj8uVsWHocRcJPuw5wb2x0TVZlfyX2yethV8E
 LsSeb0hS6uDEKwkUCqe0TgFbVQ35R1YLyEWPe61mgiz5WogORQM9XspK3IR3UkjQENCz
 8Qgi2lpgYRV3K5a1zCbYWGslmptbbNnp2VlEkkyDGA1SzJSJNU6Ar7j4SX5pP5mMDlDx
 as9nPdzOhMPmquu2tPNEhP1AQgZW+CDmVFrYqGJYPzFCtn6xvlnKPFakbqnoMo3kdjmT
 jyC1i61PdBXUCQgqL97Filj1oGxPIQpkcBz0zryGuTn1GTh1XwOwDID18vZyiPRUWHAh
 bR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769667; x=1774374467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8sGN3pUZfb1jPFD6m9bHWDlQGgRDF8SFG+PAv18Xgc=;
 b=r566dg6IMCSSA42qZ2Jzxmnec6sqWM2aWdZ6tJTEQOc28K7SJ1yegfwRBlx2u+hhCu
 Ix1So0GAgNfqo7F+kE5SnHnyxjrso6pChUA10fTDbW/qi5x/azKhqC6yEV38qk95Zpy3
 JosWq7kLbcPGb0K3VgwSO+5K89Zjn4IcrlJPA3zGols3wyd48fIwlLk8r4Q1Z/qjeWHj
 4kW33iVmEmbpCuKrCQB2Ud/Ww09UtgVh6qYHubixJfp8ySNjCcNyGIwDKqQlKV70GZpy
 RGSs9VkyL5eYJlUQE07nD+V1TiIKlJjKnJpWSoGKpFyeWQ3AmabyMWZIJgJyjQAyiz39
 FL0A==
X-Gm-Message-State: AOJu0YyZRaGfUjZWHgbm5pRCqb6CCtEMOcrcuN4zQGg3BTozLMsvjAql
 Bkz6cndf50cVcgizEPFW6HisRJoFwAqebGY9ddf/gDOBWdTGs2Um0+nJLRDALnHm
X-Gm-Gg: ATEYQzxO19ZdebDnn5r6cjQAOnpcUd3+2ZVecQHKBYIj76+9JTxNCMXt9fyi6flf7f9
 cKwfBJvIg+2vphLcPBL+gujyk/qsD+6qMr7Xt3i2ejVlj6fmbSbKtB9aegagEYHUTNC3z0mY0dd
 vW2C1sYfjtFwxLvQBrYlApNB+fID5ZslDWeeYTE7ed987/WF2kPRpZ5/ZttLyhtjgN3afdsYqxq
 cfu33pxpQoAUTHLoPy4O9r1qty0EjCbVpK0+IAbvhfhly0KWg/ajdc3OcWcn3gD4FPvR2XGGedu
 OE8By5rjmkDYK5FN4pb+FS9Qlc25WgW5ZYTUhR3o3MIzduTlO/XAJRgj8/DR//QrqznSa6kfmJe
 oh1iBQGkc1+GmHw/HTHEVZ+GFZoQUS0y14ZWe69cinb7fXUxbg1uIgN2W6wO/J9DWk7Ea4N6Rqs
 qFzeTOKmku3QlC3Ybrc8hsvmQojTmmck8EWp2YXkpr8wGSItSNDbBG
X-Received: by 2002:a05:7022:6085:b0:128:d202:883 with SMTP id
 a92af1059eb24-1299ba11ebdmr241545c88.3.1773769667229; 
 Tue, 17 Mar 2026 10:47:47 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-129b4147522sm281844c88.15.2026.03.17.10.47.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:47:46 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 0/6] target/arm: ISV=0 data abort emulation library
Date: Tue, 17 Mar 2026 14:47:34 -0300
Message-ID: <20260317174740.31674-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x122f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
patterns are kept consistent with TCG's where possible; differences
are noted in the relevant commit messages.

Changes since v4:
  - Rebased onto current master
  - Add SPDX license identifier to new meson.build
  - Resent as new top-level thread (Alex Bennée)

Changes since v3:
  - Document decodetree pattern differences from TCG in commit
    messages for patches 1/6 and 5/6.

Changes since v2:
  - Inject synchronous external abort (matching kvm_inject_arm_sea()
    syndrome) on unhandled instruction or memory error, instead of
    silently advancing PC or returning an error.
  - Fix WHPX advance_pc bug: error paths no longer advance PC.
  - Add page-crossing guard in mem_read/mem_write to prevent partial
    side effects from cpu_memory_rw_debug().

Changes since v1:
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
 target/arm/emulate/meson.build     |   8 +
 target/arm/hvf/hvf.c               |  46 +-
 target/arm/meson.build             |   1 +
 target/arm/whpx/whpx-all.c         |  61 ++-
 7 files changed, 1193 insertions(+), 4 deletions(-)
 create mode 100644 target/arm/emulate/a64-ldst.decode
 create mode 100644 target/arm/emulate/arm_emulate.c
 create mode 100644 target/arm/emulate/arm_emulate.h
 create mode 100644 target/arm/emulate/meson.build

-- 
2.52.0


