Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F0C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 13:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taae9-0008Eu-OZ; Wed, 22 Jan 2025 08:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taae3-0008BA-LU; Wed, 22 Jan 2025 08:19:47 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taae1-0006ks-LC; Wed, 22 Jan 2025 08:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737551986; x=1769087986;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ojv5QrTK/it8nf4qOPUO8BNwhuSJcBS9bLeRkI2TH/Y=;
 b=fGUR72A7dMFD/CyncOYzsXaw7qkyDqsclfGnugvIXStMKYgDF5Yp50u1
 wMspdGdvYn9nZKzwLX/M9FBPHvhKPg4DoAx/+QCJZdzBnvyFzWbUbf7Ly
 lktlNqTQ0TJbntuqMCpQJC8NLCh6ZrTgffl9qGL0mRWxqI305wiVUsrTl
 8EuXFt0+IARXFlrK0cL0FhFNogVnNCC3sdZxeOLOUUa65MZqlof9AKYf6
 vkTLoAlBmf8R6CxgHQiPuhqV3VMcuNbnymktX2JqH0RFbwrRMztxe4FNH
 lEHlbb+Edwqpna0VwfO4xmnnTZ/HnLXmOLxtd+RtOTBtXwKCjfHFL/582 w==;
X-CSE-ConnectionGUID: 7lMYbcsnQI2vRGfbdQEiLA==
X-CSE-MsgGUID: V9WHgYtsQ9WFmOFM3EWEjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="38256643"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="38256643"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 05:19:43 -0800
X-CSE-ConnectionGUID: qJO4BTwQQsanwUgyqp1jTQ==
X-CSE-MsgGUID: moYdAgTeTzOTJMJysvWH6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="112152707"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 22 Jan 2025 05:19:41 -0800
Date: Wed, 22 Jan 2025 21:39:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/10] rust: pl011: hide unnecessarily "pub" items from
 outside pl011::device
Message-ID: <Z5D097/Eqen1BZhE@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117092657.1051233-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Jan 17, 2025 at 10:26:49AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:26:49 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/10] rust: pl011: hide unnecessarily "pub" items from
>  outside pl011::device
> X-Mailer: git-send-email 2.47.1
> 
> The only public interfaces for pl011 are TYPE_PL011 and pl011_create.
> Remove pub from everything else.
> 
> Note: the "allow(dead_code)" is removed later.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs       |  2 +-
>  rust/hw/char/pl011/src/device_class.rs |  2 +-
>  rust/hw/char/pl011/src/lib.rs          | 13 ++++++++-----
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


