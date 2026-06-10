Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E52CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIN8-000762-Bk; Wed, 10 Jun 2026 08:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wXIN3-00075f-8n; Wed, 10 Jun 2026 08:49:26 -0400
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wXIMy-0002JU-O2; Wed, 10 Jun 2026 08:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1781095751; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=VgwXepwFFsri2bY3lEgyRhohnclkVYpV0ZEn+hkeglA=;
 b=jaWmKsUv8vNemmUypiebC5pTslXZJ05Qk23OBW6joyqOlyAMYLiv2eO7RlMtv8FiXYu3UyCiqJByj+uUFwWNaToetdnmmv3zzxUBtxsMPYhfzTpeqNq2uHzS7GHXF0CpspsDM1BCV9SLWKRD2aYqbMVICNGBx3u6m5uw6eA8RpY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=16; SR=0;
 TI=SMTPD_---0X4ahYAK_1781095746; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X4ahYAK_1781095746 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 10 Jun 2026 20:49:10 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org
Cc: alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 cp0613@linux.alibaba.com, daniel.barboza@oss.qualcomm.com,
 fan.ni@samsung.com, guoren@kernel.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, liwei1518@gmail.com, palmer@dabbelt.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 sunilvl@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for
 CXL host bridge dependency
Date: Wed, 10 Jun 2026 20:49:06 +0800
Message-ID: <20260610124906.131956-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609134659.3dc89b40@jic23-huawei>
References: <20260609134659.3dc89b40@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.100 (deferred)
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
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

On Tue, 9 Jun 2026 13:47:09 +0100, Jonathan Cameron <jic23@kernel.org> wrote:

Hi Jonathan,

Thanks for the detailed review!

> It may be a good idea to add a bios tables test as well.

Okay. I'll add a RISC-V ACPI bios tables test in v2 to cover
the _DEP additions and prevent regressions.

> Please also include an iasl -d dump of the relevant additions to DSDT
> in the patch description. Much easier to review than the code that
> generates it!

Will do. I'll include the iasl -d decompiled output of the ACPI0017
device (with _DEP) in the v2 commit message.

> In general looks fine to me and great that you are clearing this up.
> Seems it's luck that x86 and ARM64 worked without this (or strictly
> speaking other things enforcing the ordering). Ultimately we probably
> want to add this to those two architectures as well.

Agreed. I can send a follow-up series to add _DEP for x86/ARM64
once this lands on RISC-V.

> > +        if (s->bus) {
> > +            PCIBus *bus;
> > +            uint32_t num_cxl_hbs = 0;
> > +
> > +            QLIST_FOREACH(bus, &s->bus->child, sibling) {
> > +                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> > +                    num_cxl_hbs++;
> 
> I think you only care if there is at least one. Instead of counting, just set
> a bool and break out early if you find one.

As Peter pointed out, the count is actually needed for
aml_package(num_cxl_hbs) to set the correct number of elements.
We'd need two loops regardless (one to count, one to populate), so
I'll keep the current structure.

Best,
Pei

