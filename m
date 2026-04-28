Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF43FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHepA-0003O2-Aw; Tue, 28 Apr 2026 05:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHep8-0003M9-Je
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:33:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHep6-0007Pw-02
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:33:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so102480255e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777368821; x=1777973621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xekvDfh2dxmdIlEXP7S2Vcn3LeIat4hsKRy3BWYX78Y=;
 b=ZNYDD/TBdbg9ZFMv0YOWdwvc1VnuJeYJ8eVMBHbDMFtcQqz97fY+Uzn0g2dE7sOy+2
 1tacZmXQefLp+9TGSFM90pSyflOLpuYIDxfj26MzgFVkfJ7IHeJaDb9Z3FNEN61ARwbk
 xbuUR3m2jVmXgKYQ6IqTaZxwJe2+bBylZUefhRk6BvcYiiawKZDZShPs3xq0i1+1uUV+
 YDl/+Gj/Q1FZLohdKglHkvNKxtwy5dM9ExSe8dFkbr8ZoJzXvXlaxg1OfVjIMtGgerCS
 JlNMnIsDhUdyp1s+AcIw4iwvpiDYYtvyAHZIfYJGLthU8rWedMBETsgRfYMnkf4AAGMr
 GlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777368821; x=1777973621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xekvDfh2dxmdIlEXP7S2Vcn3LeIat4hsKRy3BWYX78Y=;
 b=DHP57GBMHUc6tsdUl/qPZhM7KHbZvv5dROcZUrttIVgkt3KOCJ/3na6G/TKkfZOsda
 mBfdNVXs7us5kPY5LpFTc1/Q9F9nHaYuhwQU/H+3h378qr8idjyZPa9yb/NcRxcn8w0o
 CGjkRBztNTloVQczwOnVrA4gR/vZObaWXQV/sExIUSapbPV1o47NkHOUevpinkl+lds8
 I/42Kw5qYgaqwICMSqoBb6qyHbpH0MMUhZ2PN3MRJy8KpjZ4XbTaDcvwlYmmHNy9daKd
 O5VpPvJ3iXUSn3TwBMo22XWiPnbrcxYnxoCHKb9KlDstOqQvpBSan1IHGWXoHNfaukdW
 mnXA==
X-Gm-Message-State: AOJu0YzS2sco4B6bU3HlDh8LOsjg3wXblhJ7nA4vFarEVUiWTJQvPh4l
 yGlrwD4a5//cg7ty5fvGu4fpqquu/hSXC8HTPB7HXLRQvIZSuTfkc0q3/XCMA2UHAD4IugOEHN4
 t+oJI
X-Gm-Gg: AeBDievbuSHwvcWLMAdqbryt1ZUhCH+SA/46vhbh8sOQ9pjcbdgcwl2sj7ffDnsy8ud
 dn4s2yCaFqRsrOxj4M6sa26ew8Tgix4Ec6cLqwADr9PH9TFiKYhwq1qyIdyB0o0MYJ9UQpo4ysJ
 rLUPLoYehFD6sXw8HM5SGRQZwD++PwsP4VZK+BRG6hCqGGu23BSiKGhjlakrxLfZEAkBzZDv9qf
 fsxslvaavcDncCHdbBPsAJ33/+6uwdSktuH323SHmOSD60H1MMDyKuSieND8xmznHWBbmJ/q3ps
 rcgIV+8mcwpKOiPZoppry2e4wkyxMJ+HNOZj86xyHDdkyqva5SLWu7KQ0OrfDPkU2eXWvgKtrTj
 2GZI2KJSSz5eRBiAsI6uqHlb7OD2qKp8b1bleJW7dfwuX+q/nboJLwhkXwdxGcg3ek5CwDQ/lsj
 iGGSJI4hsFL4CjKAhwh+j4sxbdB0XQbG2jNp2tu5LoxXg3jKc7e05sJ5XdU0lhTfkC+3vNaSkSR
 M5tgcprx28/CIxUR4zZm75b5oEiw3UqkIqs1P5kxQ==
X-Received: by 2002:a05:600c:3b13:b0:488:9e43:9690 with SMTP id
 5b1f17b1804b1-48a77afd324mr38740385e9.10.1777368821504; 
 Tue, 28 Apr 2026 02:33:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a774d7a1fsm19665595e9.4.2026.04.28.02.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 02:33:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 0/4] MemoryRegionOps .impl cleanups
Date: Tue, 28 Apr 2026 10:33:35 +0100
Message-ID: <20260428093339.2087081-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

This patchset is some fixes to MemoryRegionOps that were
accidentally setting odd .impl values, plus an extra assert
that we can now add that a MemoryRegionOps doesn't set
.impl.unaligned true but .valid.unaligned false. They're
originally from the CJ Chen / Tomoyuki Hirose patchset that
aims to support proper synthesis of unaligned accesses in
the memory system core. I still want to get that patchset
upstream, but for the moment this is a set of simple
cleanups:

 * riscv_iommu_trap_ops set .impl.unaligned but not
   .valid.unaligned
 * npcm7xx_fiu_flash_ops failed to set any .impl at all
 * xtensa_mx_pic_ops failed to set any .impl, and was
   less strict than it could be about .valid

Patches 1 and 4 have been reviewed.

thanks
-- PMM

CJ Chen (2):
  hw/riscv: iommu-trap: remove .impl.unaligned = true
  system/memory: assert on invalid MemoryRegionOps .unaligned combo

Peter Maydell (2):
  hw/npcm7xx_fiu: Specify .impl for npcm7xx_fiu_flash_ops
  hw/xtensa/mx_pic: Specify xtensa_mx_pic_ops .impl settings

 hw/riscv/riscv-iommu.c |  1 -
 hw/ssi/npcm7xx_fiu.c   |  5 +++++
 hw/xtensa/mx_pic.c     | 27 +++++++++++++++++++++++++++
 system/memory.c        |  1 +
 4 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.43.0


