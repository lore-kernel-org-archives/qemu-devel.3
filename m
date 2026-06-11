Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A468CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXczr-0006M7-H8; Thu, 11 Jun 2026 06:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wXczn-0006Lk-R4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:50:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wXczl-0002XW-L0
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:50:47 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84229481d44so3245649b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1781175044; x=1781779844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rd+4cRtGN3SmQC/zhJnnLLKTs3tW0tLvUsOUlwiyHHM=;
 b=ZOPOdzWxJ40fIdmEasd3eQIBWeft9x4X06CkWzjshfPcjY0wo+3X4VBF2uRad46c+l
 WXC0y8byU5dxthuCQ2TKAD8Z9q/v+q21tvHKOga7VI8kUsNI1YshAhjFhVMjnQgbee45
 0tpktEIU8NLkyfAZpP/z70yz/l5Z4NtuHBlpnS1xJxCxaNfm2svI6sSLJN8DU7fIcorw
 Sr0+ly3pXtF6hmnD8nX0Uz0T8Nev7g28UUjgIZtHnF1UHeqcc9ZZyEihz7k+AXTK3k3E
 QWBQoeWY6UbyZ9Mwcnq6fA0ktSEW0e4VUO/l0G6xnmc9EqDSDFOP2UzI7GeJuFFqCu0i
 mGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781175044; x=1781779844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rd+4cRtGN3SmQC/zhJnnLLKTs3tW0tLvUsOUlwiyHHM=;
 b=XHFS0O0oCJ1vNbHL6ohxVYumL3of9MDefLPjPWsv69MLEvy5dQIiKM2QzVEIw/0MJW
 Einte61HXeO+aS0yNyEr7dvgahwSFTuQxRBLm7Nax4i94SDuL7TnkKWZU7uWCihGZDXT
 yueGLLiP/N6PyGcdCYYigSKoKEi7lrnRngm5jSy1c6IMTYuU8mFp0W3ZOTY7ZP0I+nXj
 7qCQUFO0IRcSu6YvZ2x37JRY3Xt8Occys5IzYJdbtiMwzq3HIitIxcrAwb92UKfY5xKs
 +jiqLZtMdQMSRdyVnXDwfsJCQbQ6FlZDBg08iGrSG9pkPWBgTWiM6PL79cbf+4gfUINO
 baWg==
X-Gm-Message-State: AOJu0YxWXl0KLU85YYtLvb1f7VTtXT658WZ4yqZYX7MmFIPd8QKa3Vml
 d2XyjkbDxKvnqIa0lb67lRk11rUJgWnkM87m15I386RKSgG8UaNivX2oIVjIUun8gWPH1RXTOT8
 vv4Fej8Yx4+1USowo5t4XmmmN7Cdk5T0pQXQ1DkryyGKxC8as0YOS+5OkNnDKNUZ3y5hYqxBc1N
 +ZrgJAV6XJylBGfNbwrtW/1iFOjgY91QR0iwmWQ0U=
X-Gm-Gg: Acq92OHImF91SaaRWsLPqmcm2wieGbInD1aYivQuXrKbK5Gt+OmzUzL9/N5TeAfRaNM
 oHd3jWhf45QTOl1g0HuVN1tQUMz3OtJhnl6d4DKHS5IIecPZ4asTVQngJCu9hUmwAiVyVS1/UWI
 z1w97GVLypyc3B4essnxfXkM4T8LN8bwMQWlXf7JlIRwxujYRFQJn3vtIiY+Sh4n7TjbVOz6gox
 4l4Yos1gpHIuKz/r2cIZzWDuTd6L2mnhV+ssA3yvFPxYoux9r8/IFu0e1jpWDcZZZne0X9eaPdN
 Brx+3+kQxUBkgvCZN7U9lrQrIgVKMSPoeq0sB6lZVtH+ZJgSDF15jZm1Ce1RkrtKluF0eAbl5Bp
 vDvnbaHY7KXDe/NqRynTeBIhqeCnn5xwsA75DAPNt1Q7oh1rfSxBs+xm7VJSnAHcDxITCTIu7sd
 RtTP6t1KctiTVJy/C/e1fp1qjcsNJPIANStUrJ/74AbUpyUOOXfWPqnup2F2ylNjnXDWI4Cdl+3
 JZnWuBdx+jmPCOgZJRdg7ICrDIkR8wewkghYA==
X-Received: by 2002:a05:6a00:6017:b0:81e:ef16:b288 with SMTP id
 d2e1a72fcca58-84336a9e365mr2590189b3a.22.1781175043455; 
 Thu, 11 Jun 2026 03:50:43 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-843383197e5sm1657818b3a.52.2026.06.11.03.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:50:42 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 0/2] target/riscv: Fix mstatus.FS dirty tracking for FP
 exception-raising instructions
Date: Thu, 11 Jun 2026 18:50:35 +0800
Message-ID: <20260611105037.157773-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
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

The RISC-V privileged architecture specification 3.1.6 defines
mstatus.FS that

  "The FS field encodes the status of the floating-point unit state,
   including the floating-point registers f0–f31 and the CSRs fcsr,
   frm, and fflags."

Any instruction that modifies this state must transition mstatus.FS
to dirty. In particular, fflags is part of the tracked state, so any
instruction that sets a new bit in fflags (e.g. raises a FP exception
flag — must set mstatus.FS to dirty).

But current implementation was failing to set mstatus.FS to dirty:

1. Scalar FP instructions that write integer registers (comparisons
   and FP-to-integer conversions):

Instructions such as FEQ.S, FLT.D, FLE.H, FCVT.W.S, FCVT.WU.D,
and FCVTMOD.W.D write their results to integer registers, so
mark_fs_dirty is correctly not called to set fs to dirty at
translation time. However, following scalar instructions may raise FP
exception flags:
- Comparisons: fle/fleq/flt/fltq/feq
  — raise NV on NaN operands
- FP-to-integer: fcvt.[w|wu|l|lu]/fcvtmod.w.d
  — raise NX on inexact or NV on out-of-range

2. Vector FP instructions (all arithmetic, comparison, conversion, and
   reduction operations in the V extension):

When a vector FP instruction raises a FP exception (e.g., vfdiv.vv
producing a divide-by-zero, or vmflt.vv comparing NaN values), it
modifies fflags — an FP CSR — but current implementation did not dirty
mstatus.FS.

This patchset fixes this issue by
1. Save float_exception_flags before the softfloat operation
2. Perform the operation
3. If any new exception bits are set, set fs to dirty

Max Chou (2):
  target/riscv: Set mstatus.FS dirty when scalar FP raises exceptions
  target/riscv: rvv: Set mstatus.FS dirty when vector FP raises
    exceptions

 target/riscv/cpu.h           |   1 +
 target/riscv/fpu_helper.c    | 157 +++++++++++++++++++----
 target/riscv/vector_helper.c | 241 +++++++++++++++++++----------------
 3 files changed, 258 insertions(+), 141 deletions(-)

-- 
2.43.7


