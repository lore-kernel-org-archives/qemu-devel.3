Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8054BC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11A3-0003TP-8L; Mon, 31 Aug 2026 08:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1x119r-0003Qr-2z; Mon, 31 Aug 2026 08:30:39 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1x119l-000652-4f; Mon, 31 Aug 2026 08:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788179421; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=rP0u+r1sBvXL9q/dJ/o6Igg9T9W93ERYox9RGe9wdsA=;
 b=ZwyWtoWZoRM5Mwj1zkGvmuNODgF5O3jxLrJhhJl+kOFFpS5EoChjYxJXvT2Lelu/tVfQAF/LRr1Xhxtx34CiqQolsgLPSw+7bx//dB+W6LdQJXd3iYsQSRvmwmHnWOOuk6r7FYjh5u+cYx0TmgJP7IIWfZKJ0ewP9NOY/YyFkBw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=20; SR=0;
 TI=SMTPD_---0X9yvDeI_1788179416; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X9yvDeI_1788179416 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 31 Aug 2026 20:30:20 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 3/6] hw/riscv/virt: Advertise the CXL host bridge to
 firmware via extra-pci-roots
Date: Mon, 31 Aug 2026 20:30:13 +0800
Message-ID: <20260831115000.610002-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831063723.409036-1-junjie.cao@intel.com>
References: <20260828151317.815-1-cp0613@linux.alibaba.com>
 <20260828151317.815-4-cp0613@linux.alibaba.com>
 <20260831063723.409036-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

Thanks a lot for the review and for testing this end to end!

> One optional thing about placement: select PXB in 1/6 also brings
> plain pxb-pcie to riscv virt, and that one needs the same fw_cfg file
> with cxl=off -- as posted, a pxb-pcie with cxl=off is never populated
> by the firmware. arm/virt, pc and hppa make the call unconditionally,
> and the generator returns nothing without an expander root bus, so it
> can sit outside the cxl block. Moved here: the pxb-pcie case
> enumerates with cxl=off and the four riscv64 ACPI cases still pass.
> Here or as a follow-up, your call.

Good catch -- thanks for the heads-up.  Since 1/6 selects PXB, plain
pxb-pcie is indeed left unadvertised to firmware with cxl=off as
posted.  I will move pci_bus_add_fw_cfg_extra_pci_roots() out of the
cxl block in v5, in line with arm/virt, pc and hppa.

Thanks again,
Pei

