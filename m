Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A73C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ved-0003eA-RZ; Mon, 31 Aug 2026 02:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0veb-0003ZP-Ld; Mon, 31 Aug 2026 02:38:01 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0vea-0003m7-8g; Mon, 31 Aug 2026 02:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788158280; x=1819694280;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vo/XQf+M5yJhZppndfhOXW182R1VefSU2/G8yHNnK5M=;
 b=YdyrGvwwv2R/SXCahnVV4FtUAgY48Ool68VKh7YG33Tu3XCq2zXJ5lAL
 PlE7vG3RkS3L+NWZR24zFeFW8sPVFB/lSlfzwHjWBBq01GkNWtXja3AkH
 cVKIF8pBRoZ5ifYuVosNe/7FFCPsGo+/JiPGlAaw2oxLCZQmQb6gFnkCS
 qg8ph56djgg6aSbYrZ1oMoD7nNJX21HEXvZrUMy/SMdpL+4vbBfWHbH6u
 /4u8D65jCq/WowjYYqqbyoS42e2MSH1AVC0of/rBUSfaNc97mX7yOe1k5
 k6Z1VL5fa7qvo9CmFBbbfSiU5EL1TSnpgbzqYRV0LMTlDLhxJFX24gYOq Q==;
X-CSE-ConnectionGUID: m+2QITwsRh6BP1ydLnlQDw==
X-CSE-MsgGUID: AOXAFEgWRyehPdeSYiNwsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88578068"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88578068"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:37:58 -0700
X-CSE-ConnectionGUID: uGF+0WdUSdyku6Wx3xz3Dw==
X-CSE-MsgGUID: ahmy2BwDSkG7fQxW2HI2lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="293521469"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:37:53 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 4/6] tests/qtest: Prepare golden files for the RISC-V
 CXL ACPI test
Date: Mon, 31 Aug 2026 14:37:46 +0800
Message-ID: <20260831063747.409053-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828151317.815-5-cp0613@linux.alibaba.com>
References: <20260828151317.815-5-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=junjie.cao@intel.com;
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

On Fri, 28 Aug 2026 23:13:03 +0800, Chen Pei wrote:
> Add empty DSDT.cxl and CEDT.cxl golden files and list them in
> bios-tables-test-allowed-diff.h, in preparation for the RISC-V CXL
> bios-tables test added in the following patch.  The populated golden
> master binaries are committed separately in a final patch, following
> the bios-tables-test update process.

Reviewed-by: Junjie Cao <junjie.cao@intel.com>

Many thanks,
Junjie

