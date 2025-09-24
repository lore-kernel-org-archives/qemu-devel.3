Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5366ACAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1R4J-0000zr-GU; Wed, 24 Sep 2025 11:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1R4E-0000zO-N6; Wed, 24 Sep 2025 11:06:03 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1R44-0002Lv-Cz; Wed, 24 Sep 2025 11:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758726352; x=1790262352;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=b4IU1Zp4QVjxpkpgWOQnCqHajAF15dVkPgaL0QC0SVo=;
 b=Y0C7dZQSmZ5BD7mHzMWvGQ2cRWIPdJ2eUwX/n/0MF/vQQHMLCgQmqZrN
 lIKEKUzLiWQhFWgOWXiKBfXCSIHxHiOLXcIQGymNmQYR48yxKRMO3qJ0Q
 499/Ea3n9IlJAYmIGhzLB74NMsGGwOikzn2cUD4f3J7iEwhu0zEdJwld7
 1vAsPAH3nUgE3FpNRU3N53EoBk9xmTYuLaS08bZkPFWNPiDhahH8zdOzd
 P5o5M0a08C6NGIUlvUj56Zirq9ot+Ndq/l6jxL3/6vj38BVZ0JjUJ8Ew4
 5VNHjvYzxFUavs6X30NHXa4VRtd3ToJXFfJnvPI+JBqiq4KDTdz7Lzh5u w==;
X-CSE-ConnectionGUID: 4RkqoC07TXK+c4nJmd2afg==
X-CSE-MsgGUID: 3wlSyzOASOeMKCCj2Y4qyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71703706"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="71703706"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 08:05:45 -0700
X-CSE-ConnectionGUID: CLHtW1MbRKSSxhjs04TY1g==
X-CSE-MsgGUID: e+JJVQPmTfqIVQnObKBWGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="214184546"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2025 08:05:43 -0700
Date: Wed, 24 Sep 2025 23:27:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, manos.pitsidianakis@linaro.org
Subject: Re: [PATCH 3/7] rust: migration: extract vmstate_fields_ref
Message-ID: <aNQN7Nt7jKiA/rn1@intel.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
 <20250920142958.181910-4-pbonzini@redhat.com>
 <aNQMekqSqG7DjmPX@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNQMekqSqG7DjmPX@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Considerring the idea about returing &'static [VMStateField], I think at
> least we could return `_FIELDS.as_ptr()` directly from vmstate_fields!,
                         ^^^^^^^^^^^^^^^^
Sorry for copy error :(,  s/_FIELDS.as_ptr()/_FIELDS/

> and convert &'static [VMStateField] to *const [VMStateField] in
> fields(), just like subsections() did.

