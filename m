Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884A6C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDpk-0006m6-TZ; Wed, 26 Aug 2026 09:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wzDpj-0006lb-TQ; Wed, 26 Aug 2026 09:38:27 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wzDpi-0004po-E3; Wed, 26 Aug 2026 09:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787751506; x=1819287506;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IsA8DjF0vXOGSyrTm6RVyG1i2dRPzlY7XZ4uNzXBxUY=;
 b=bp4q4tzoJtXksmh8FiXyWAqRMHa3gNkRLc1tZKeRVgi9canGpFTBmx/F
 rI7igJiW/6OIBy2834MwKWzoMiECrMf67URzeSFXnAqBJCRASF9hEG7kZ
 NeTXpWg285298J/npPdr43z6MHacmgyHV22BD9tpJB3fdmxVTS33ZgafS
 FiEnx3hrpn7652QzDgq3xRUotv4jfiImZejgXv3vqxq5ADAY1hgdpsbQC
 IqnJSWvauE0HotyhXgNgaYyYn1t4SK81zyCgg02+zhd6Q78lNDdv6K85N
 wovwU5V6uLN6qsOANMqZ8jCKDgrVZKAE/k3tMyotZiwivZla5aDeqOhqk A==;
X-CSE-ConnectionGUID: dSShFX8KTjG+1N5sIknnOg==
X-CSE-MsgGUID: V/7MoIsvSYCJ6geMAfCd5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="111016853"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="111016853"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 06:38:24 -0700
X-CSE-ConnectionGUID: yaiuLxGgT5qS8SBy6zuzdA==
X-CSE-MsgGUID: Ie2kZ+SyR4WsekNMi0TBAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="263821967"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 06:38:19 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/4] tests/qtest: Add RISC-V ACPI bios tables test for CXL
Date: Wed, 26 Aug 2026 21:38:10 +0800
Message-ID: <20260826133812.355470-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-5-cp0613@linux.alibaba.com>
References: <20260821081954.1171-5-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Chen Pei,

On Fri, 21 Aug 2026 16:19:54 +0800, Chen Pei wrote:
>  tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
>  tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6212 bytes
>  tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++

checkpatch errors on this one: expected files added together with
tests. The flow at the top of bios-tables-test.c wants the new files
added empty and listed in bios-tables-test-allowed-diff.h first, then
the test, then the AML and the emptied allowed-diff in a final patch.
The riscv64 goldens went in that way originally (cc3ba2422554).
Alistair's Acked-by would need re-applying to whichever patch ends up
holding the test code.

Worth settling 3/4 first -- if the _CRS ends up coming from firmware
enumeration, the DSDT here changes anyway.

Many thanks,
Junjie

