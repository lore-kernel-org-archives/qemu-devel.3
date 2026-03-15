Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE38D58B0B
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 03:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1cMA-0004nX-Mn; Sat, 14 Mar 2026 23:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1cM8-0004mO-EZ
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 23:41:32 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1cM6-0003Qm-Py
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 23:41:32 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2be4781d2baso2140583eec.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 20:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773546089; x=1774150889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAyshNC7ls5ohrmw6pvTowpCpNZ/8pgu+r6HkRAfH/8=;
 b=PMTZyiOepSXXJNr4TViOrJ/lGkpipR5QEC8cV+uSIlshWf6E267/Kb4akqgQckV/pg
 IGATNfS1izfVH7H8FfCH1e6pLf+QtfW/sC6hjBmeAsOEoDdweTGD2qwDdjeIpYEx8v8E
 s4AtN9pTpIdC05lqadG4hO9+WY4QDPjPtFe/UjMOJ9viL/mjxRJM3yt+3QeOvuX07BmH
 Vvd3jGyl0flX7FGdvsAjvhvIhCIA5s3oOBkI8WK+XDioL2x1KhldlgHOp5lnErhDeWGM
 P5ZZbd+CPQWWNsfktjEKM4ZDphxMqo06J7u2KCJmoRtCnHWX9H8oSdQEAZ5cUheUl2Hk
 7tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773546089; x=1774150889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kAyshNC7ls5ohrmw6pvTowpCpNZ/8pgu+r6HkRAfH/8=;
 b=i8CRaJH6hr6mB1SG9CjTQ7471sn3uGCQ+7tTywLV2s/f8i3AOB7v2YL0WwHSq+gN7j
 lWBFr7QB9bJq5KZnOIKxZGp8GKFphpFM0+kQgfbRey200yiSkp6aJnOesis1at3JJX6I
 bMaQSLhem6NQrAMycHD1/ywujtehbAs5VZlrFJLq250B95WulwV7yQyrHNL2ryYQZv/y
 LWtejOXH2HyeplmAKjHw5PQP9WtLs8+R1BuLuSadm51Kskh6CgJrogMBje7N+6nXIOQl
 sHKJO/mvGGPBKXQSa1msXMrM6O71TUHyJn/+GsA4yfgu2zurpLMcBrC1AQeUj6StAPHr
 1zuA==
X-Gm-Message-State: AOJu0Yzg13w97EKbKs2EAqn8uox3HbDMlATICbVu7WB2YIbYz9IGrct7
 BDviDNhP6J+5ZH/USjBPraQM9hpOttb2gGWlRJI+6WvsnMMDufrmjRG9/x2pMdDu
X-Gm-Gg: ATEYQzxaQSQq14TVCwTeOXbYG+mheR2h3ejvTj+4kLsLKb12Fu8VkB5TOx0NP5FvlT6
 d+0ttWd5J7AH4b9NoMm6SJZnW/Sauck8k9M2QtbzehbHSVa80SGjrLbbH8eYGVi+l8SJAddZAEh
 jLKZH0mxcwGGQZFYrAqmOilj4kAApGIC3rFRBKx5cAvns7nPY6EZXtVQla0bzuafHF3Wd9UAk5A
 irdmnuYxBqgedEiRv7npP9PsFjhKvc/PPzsoeSTMki5P5rhuEUtuyRuRMUb4xDuczWP/1AprI1A
 YUOQdvvowsyovq/QVZ+SVE1Wcn0/5U66Q9jO74Z+DVO9Icm//wMd/FAEoe+XjSQdnyjvTF+8ba7
 L+oUS+aHi7g19gEbM2wZf9OaUMk1JF9l8mxh3V2uMHRWhGaJn71XiU5N5joA+Pr0WjkgFhcuySw
 wGvyXgyhjK/H3eUUnoz3fJFNEtBNRpB/k8Us7fDhk=
X-Received: by 2002:a05:7300:e208:b0:2ba:6723:5060 with SMTP id
 5a478bee46e88-2bea55edf0emr4424939eec.31.1773546088516; 
 Sat, 14 Mar 2026 20:41:28 -0700 (PDT)
Received: from 192.168.7.2 ([189.6.247.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3eec8fsm8886424eec.13.2026.03.14.20.41.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 14 Mar 2026 20:41:28 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v3 0/6] target/arm: ISV=0 data abort emulation library
Date: Sun, 15 Mar 2026 00:41:17 -0300
Message-ID: <20260315034123.41921-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313021850.42379-1-lucaaamaral@gmail.com>
References: <20260313021850.42379-1-lucaaamaral@gmail.com>
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

As suggested in v1 review, the library uses its own a64-ldst.decode
rather than sharing target/arm/tcg/a64.decode.  Beyond the practical
complexity noted in review, the two have incompatible purposes: TCG's
trans_* functions are a compiler — they emit IR ops into a translation
block for later execution.  This library's trans_* functions are an
interpreter — they execute directly against the vCPU register file and
memory.  The decodetree-generated dispatcher calls trans_* by name, so
both cannot coexist in the same translation unit.  Decode patterns are
kept consistent with TCG's where possible.

This series wires the library into HVF (macOS) and WHPX (Windows).  KVM
on ARM already handles ISV=0 data aborts in-kernel via
kvm_arm_handle_dabt_nisv(), but could use this library as a userspace
fallback in the future.

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
 target/arm/emulate/arm_emulate.c   | 747 +++++++++++++++++++++++++++++
 target/arm/emulate/arm_emulate.h   |  30 ++
 target/arm/emulate/meson.build     |   6 +
 target/arm/hvf/hvf.c               |  41 +-
 target/arm/meson.build             |   1 +
 target/arm/whpx/whpx-all.c         |  39 +-
 7 files changed, 1153 insertions(+), 4 deletions(-)
 create mode 100644 target/arm/emulate/a64-ldst.decode
 create mode 100644 target/arm/emulate/arm_emulate.c
 create mode 100644 target/arm/emulate/arm_emulate.h
 create mode 100644 target/arm/emulate/meson.build

-- 
2.52.0


