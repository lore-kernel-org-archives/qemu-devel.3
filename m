Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376DDC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 12:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEkQ-0006fR-GA; Fri, 24 Jul 2026 08:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wnEkO-0006f9-R3; Fri, 24 Jul 2026 08:11:24 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wnEkI-00039N-En; Fri, 24 Jul 2026 08:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784895048; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=AY2MUFtWa7qbEgOXmtH7fiAkQnXvuDoQ+rmq6ZDnlW0=;
 b=SkBvlUe0ez7y4ULN4wVzJvcuSgizuCJLT6sa8Miuc+RPxCN3x2U+xlnSErR1sRQXy6p3uNElTDs5WqxwRAEJKrWk9D3LPZT+TNIFoUW//LTZiAX/JvxQKvlKF1quG9xIHv6uwWRepv/sGiHQr2Bg179KjFEw/LikRVGJZH1EE+A=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=18; SR=0;
 TI=SMTPD_---0X7j4T27_1784895030; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X7j4T27_1784895030 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jul 2026 20:10:47 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, sunilvl@ventanamicro.com, dave.jiang@intel.com,
 alison.schofield@intel.com, imammedo@redhat.com, mst@redhat.com,
 guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hw/riscv/virt,
 gpex: Provide 32-bit MMIO window for CXL host bridges
Date: Fri, 24 Jul 2026 20:10:20 +0800
Message-ID: <20260724020000.100000-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722135240.763013-1-junjie.cao@intel.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
 <20260618093827.3507-4-cp0613@linux.alibaba.com>
 <20260722135240.763013-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=cp0613@linux.alibaba.com; helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Hi Junjie,

Thanks for the thorough review.

> cfg->cxl_mmio32 is a single range on the main GPEX host, but this block
> runs once per CXL host bridge in the QLIST_FOREACH(bus, &bus->child)
> loop, so with more than one pxb-cxl every ACPI0016 gets a _CRS that
> declares the *same* [cxl_base, cxl_base + 256 MiB) window.

You're right. The static path synthesises the bridge window from the
machine-global cfg->cxl_mmio32 rather than per-bridge state, so it
does not scale past one pxb-cxl.

> is supporting more than one pxb-cxl in scope for this series, or is a
> single CXL host bridge the intended target for now? If the latter, a
> note to that effect in the commit message would help.

For this series the intended target is a single CXL host bridge,
which matches the bios-tables test case (one pxb-cxl at bus_nr=12).
I'll add a note to the commit message in v3.

> One smaller thing about the hand-built template: the bus range is
> hard-coded to [bus_num, bus_num + 15], so with cxl.1 at bus_nr=12 and
> cxl.2 at bus_nr=16 the two _CRS come out as [0x0C,0x1B] and [0x10,0x1F],
> which overlap on buses 0x10-0x1B.

This is a related symptom of the same root cause: pxb-cxl only carries
a bus_nr and the actual subordinate bus count is not known at
ACPI-build time, so neither build_crs() nor a static constant can
produce a correct span for the multi-bridge case.  The +15 heuristic
is borrowed from the ARM virt machine's gpex handling where a single
pxb is the norm.

> Both really trace back to the same spot: the static branch synthesises
> the bridge's window and bus range from machine-global constants
> (cfg->cxl_mmio32 and the fixed +15) rather than anything per-bridge, so
> neither scales past one pxb-cxl.

Agreed.  I'll add a TODO comment at the static branch in gpex-acpi.c
to flag this for future work, and document the single-bridge limitation
in the commit message as noted above.

Thanks,
Pei

