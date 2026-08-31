Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21558C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x117A-0002U8-PB; Mon, 31 Aug 2026 08:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1x1178-0002Tv-Oc; Mon, 31 Aug 2026 08:27:50 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1x1172-00056f-4p; Mon, 31 Aug 2026 08:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788179229; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=MfytZgrUoxi5w+GhXTszANgVF/RRSgRgxu/r5c0/kwY=;
 b=MXRYt1umFSdvsbQY4swJHL8OQUlsPeefOmOoayw/I2gCNmA/ildDIuCy0kBKbDNA4GaI6p5YtUwDRYN8tq+2C5vVPYMFHz5sxgPVcUMfYPzSSMcsh++FnZD8dwRpJbBTw2y1xjouwRkDZW2IXsL3uroVGEw11SxF3ZshidB9RDs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R761e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=20; SR=0;
 TI=SMTPD_---0X9zRnOJ_1788179224; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X9zRnOJ_1788179224 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 31 Aug 2026 20:27:08 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 6/6] tests/qtest: Update RISC-V CXL ACPI golden master
 binaries
Date: Mon, 31 Aug 2026 20:27:01 +0800
Message-ID: <20260831092000.610001-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831063826.409086-1-junjie.cao@intel.com>
References: <20260828151317.815-1-cp0613@linux.alibaba.com>
 <20260828151317.815-7-cp0613@linux.alibaba.com>
 <20260831063826.409086-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=cp0613@linux.alibaba.com; helo=out30-99.freemail.mail.aliyun.com
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

Thanks a lot for catching this and for the detailed analysis.

> A golden carrying the firmware's allocation is the same situation as
> the q35 CXL golden with SeaBIOS, it just has to come from the blob the
> test boots.

You are right, my mistake: the golden was generated against my local
edk2-stable202602 build used for the boot testing, not the in-tree
edk2-riscv-code.fd that the test boots.

I have regenerated DSDT.cxl with the in-tree firmware and it now
matches yours (same 6331 bytes, sha1
20608434d5b8c7e06d24a59e3a366cb23d1b0238).
I will update DSDT.cxl and the related details in the commit message
in v5.

Thanks,
Pei

