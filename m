Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DABC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taEZd-0000QW-7X; Tue, 21 Jan 2025 08:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taEZb-0000QK-9b; Tue, 21 Jan 2025 08:45:43 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taEZZ-0005sL-H6; Tue, 21 Jan 2025 08:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737467141; x=1769003141;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=muGHiidZLTLJRipkgoY+CjuShBySb59jLuPf+tRRdu0=;
 b=in6J/hsbLk/39y4j5BSCoPM/YMV2cD2ENi4tl49/UDNhzVmkk5S0KKOA
 FDqw02uCW/JYhdbpLsYS96OUltVl04e+37IAZ/4eUUKWZa7KtQQsiZlsJ
 5mmg7/yBuTjh+vmt/KWzw5i2f6vvKrv+9X1evbcPpa1BfQFZSKvGGlruE
 GHm/FjARHarK4D0yDpRbBTESB+75IG/qWmo2IJ3SuFy/YRmqxKrj4AdLD
 Iip+Jc2WGoEbGMpKJQPrqck4Gtut3yvRlM6fpoVM9tT3xJ2AEx/smKVQz
 cK+zViBlIDQHq0m0k39pyi9NlHF+cNmS6OwHqI4dLCpUDMSVk3VOW3LGs A==;
X-CSE-ConnectionGUID: 61dflEi3QSiA+oXB5zHCiw==
X-CSE-MsgGUID: 8qFnHV04T/6Y88YY56VoZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38123092"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="38123092"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 05:45:39 -0800
X-CSE-ConnectionGUID: 7QZi4zctQ2aw1cIcdXI8MA==
X-CSE-MsgGUID: gsw5AV4tTMSY13Vq3+lysQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="106822586"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 21 Jan 2025 05:45:37 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH RESEND 0/2] rust/pl011: miscellaneous cleanups
Date: Tue, 21 Jan 2025 22:04:55 +0800
Message-Id: <20250121140457.84631-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

(Resend the series since it was missed on https://lore.kernel.org/qemu-devel/.)

Hi,

This series includes the following cleanups:

 * Patch 1: Make realize() safe to only accept immutable self
            reference, which is in prepare to introduce gpio bindings
            [1].

 * Patch 2: Clean up `bindings::*` for pl011, which is inspired by
            Paolo's comment on HPET [2].

[1]: https://lore.kernel.org/qemu-devel/Z4h3Q%2FJBxtWxi+bK@intel.com/
[2]: https://lore.kernel.org/qemu-devel/b107c5c3-9ee4-4939-a4e3-eff0cd92bad6@redhat.com/

Thanks and Best Regards,
Zhao

---
Zhao Liu (2):
  rust/qdev: Make REALIZE safe
  rust/pl011: Avoid bindings::*

 rust/hw/char/pl011/src/device.rs | 23 +++++++++++++++--------
 rust/qemu-api/src/qdev.rs        |  2 +-
 2 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.34.1


