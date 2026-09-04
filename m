Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E0CC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2NSU-0001hW-18; Fri, 04 Sep 2026 02:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x2NSS-0001h2-06; Fri, 04 Sep 2026 02:31:28 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x2NSQ-000614-Ko; Fri, 04 Sep 2026 02:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788503486; x=1820039486;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=11jAH+UdxIuvAgNHcn0v9by3IYDSKRv4sbKpNUWVv5Y=;
 b=WEhYTiJcnbXrlOb7ib7mlQhngtHYkSuv93a+06dburLPucjL8EEi3oDp
 ++PJ0EWiUTfMtuSuDQ415qM1FIb/GqIf/UXjYLto+68iJE3yp+X8/5QBF
 bxvAQ+RWe+8CEhe0VVyAG3kHSRxcXPV3KvI8vlHGQNi8biRwl+KyM4ZBH
 28tU2iiLxnIQCLmy3c3LoQNwnBSGtTlgiSp2XSXUiycljA1ZDTpY+md8B
 W/Guq43LC191Sr4vRQ5TlrdsN3qD0Pc8kglYQ229lqzrYfUxI44WzzzTd
 88s5LKdm/pQyl1bwuewDXe3hM0GHo/bqwq+vH6xxeizbB4FcWaFriA2hg A==;
X-CSE-ConnectionGUID: 3rmS/uzFRICRvgO1QHlWyA==
X-CSE-MsgGUID: cJnpgPyOTAu/VEkUIhEbbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106520173"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="106520173"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 23:31:24 -0700
X-CSE-ConnectionGUID: dcRThzp1Q8W9ihozM0WyPQ==
X-CSE-MsgGUID: 7fveJ5ZzSt6vup/xczTW+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="266697877"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 23:31:20 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 2/6] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for
 CXL host bridge dependency
Date: Fri,  4 Sep 2026 14:31:11 +0800
Message-ID: <20260904063112.452333-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831132340.5345-3-cp0613@linux.alibaba.com>
References: <20260831132340.5345-3-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=junjie.cao@intel.com;
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

On Mon, 31 Aug 2026 21:23:33 +0800, Chen Pei wrote:
> This pairs with kernel commit 3a59c3b772e5 ("ACPI: PCI: Clear _DEP
> dependencies after PCI root bridge attach"), which calls
> acpi_dev_clear_dependencies() in acpi_pci_root_add().

One comment on the commit message: the kernel side is really the
pair 3a59c3b772e5 + bf5418a5fe63 (both in v7.2). Without the second
the _DEP is simply ignored, so the deferred case never happens. Worth
citing both.

Reviewed-by: Junjie Cao <junjie.cao@intel.com>

Many thanks,
Junjie

