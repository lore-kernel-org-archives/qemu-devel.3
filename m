Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5051C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 10:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMlB8-0001x8-L3; Wed, 04 Jun 2025 06:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMlB5-0001vO-V8
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:17:00 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMlB3-0004f5-W9
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749032218; x=1780568218;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=E9YqgOv9EzBex00N/hunJwseb2GdKCE8Z1Oph+/VDqg=;
 b=CUSVPtZJnjbet6+Uj21QXjf87U/CAun5m5/paldZY33WJSQmKK0c7rsK
 A4wwUWgtibMWOBzQO3dt4VaD7Fif7lwo/qsEX/4Nx71V8gFFPQS1IgkLf
 ExY0/bAbBZJ/twbomaNoTuOEnFzkW1Snn6TfkCzC8Llc9C6s9AJBUtnn7
 tvKcB/2Z8asP56o5CelFXK2GfGBWiOMVO1wf2fjWUVBshcPY75M6xBKQB
 bS8v9RsJu9/3qQFRnJFL3W/O0d1jA1N6H5VU9wF4CgL3/w7ye7/n0oWrE
 SX3XvQSqAlnt63EHxm9oLVCOZqsuQy8hrl1mD9eDx/bOCoCOmhQUGeBzV g==;
X-CSE-ConnectionGUID: zlmf4FVdRbepmDxTsbrH6g==
X-CSE-MsgGUID: +BUPYg6rQqCH1CawzQCsfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62160449"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="62160449"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 03:16:56 -0700
X-CSE-ConnectionGUID: L32H+nGcRRCNQOg2Ulu3Tw==
X-CSE-MsgGUID: n2RbOjjvR9CIN+lzBYte7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="150296944"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 04 Jun 2025 03:16:54 -0700
Date: Wed, 4 Jun 2025 18:38:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] i386/tdx: Clarify the error message of
 mrconfigid/mrowner/mrownerconfig
Message-ID: <aEAiD9LOZKtoZSBx@intel.com>
References: <20250603050305.1704586-1-xiaoyao.li@intel.com>
 <20250603050305.1704586-4-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603050305.1704586-4-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

On Tue, Jun 03, 2025 at 01:03:05AM -0400, Xiaoyao Li wrote:
> Date: Tue,  3 Jun 2025 01:03:05 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 3/3] i386/tdx: Clarify the error message of
>  mrconfigid/mrowner/mrownerconfig
> X-Mailer: git-send-email 2.43.0
> 
> The error message is misleading - we successfully decoded the data,
> the decoded data was simply with the wrong length.
> 
> Change the error message to show it is an length check failure with both
> the received and expected values.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Suggested by Daniel at https://lore.kernel.org/qemu-devel/aBzT3TrdldaN-uqx@redhat.com/
> ---
>  target/i386/kvm/tdx.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


