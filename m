Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEE8C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 14:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmZrs-0004sF-2V; Mon, 24 Feb 2025 09:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmZrg-0004ra-HG; Mon, 24 Feb 2025 09:55:24 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmZre-0000xY-Cj; Mon, 24 Feb 2025 09:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740408922; x=1771944922;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=R1TuVWvo1RQjKE5AVxQjox+V72uDHcoDwboFvQuuqGw=;
 b=BfoLTfJ1C4brQlm1Sj3Pzt8s5oLikrxlGmkKbgN1mqQsFScKtIxVBPaq
 x2RI9JvZoApi/iCUC7GeZP3s8VcizGL1KADtiFhkLz9EwK4AiEwI9NXBq
 SvrYxIgjKzEh5tAjUjpSxF9NPr5SzgikcljSmYgpKZJYgeAlr38We4tpH
 tkLJ7hETwHx5R1N9fNg5sszlvj/IygKh25hT+6HCPfsnOr2IAlycJ4/uq
 pjleZLrf0Zvt3JlHac9APREPkUfngw1XvolNmc/uqTzu2W267IvZ9+V5N
 rgpPTnDVZuH+50SaMUxoI6XMYAJQMgjWiEjpjHhKmvkK4po1/KXu5+SLQ g==;
X-CSE-ConnectionGUID: y2KsQdhlSiSX0hcZnVI0Tw==
X-CSE-MsgGUID: QfGzMtCBSZKb1kCa/3ur/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58712891"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="58712891"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 06:55:18 -0800
X-CSE-ConnectionGUID: hvKwJfv9Styzp3oCj3hB8w==
X-CSE-MsgGUID: 2VoTg29MTwqf9+Am6doPew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="120201996"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 24 Feb 2025 06:55:17 -0800
Date: Mon, 24 Feb 2025 23:14:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/15] rust: pl011, qemu_api tests: do not use
 ClassInitImpl
Message-ID: <Z7yM7lDXs1Ohjt4b@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Fri, Feb 21, 2025 at 06:03:31PM +0100, Paolo Bonzini wrote:
> Date: Fri, 21 Feb 2025 18:03:31 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/15] rust: pl011, qemu_api tests: do not use ClassInitImpl
> X-Mailer: git-send-email 2.48.1
> 
> Outside the qemu_api crate, orphan rules make the usage of ClassInitImpl
> unwieldy.  Now that it is optional, do not use it.
> 
> For PL011Class, this makes it easier to provide a PL011Impl trait similar
> to the ones in the qemu_api crate.  The device id consts are moved there.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 38 ++++++++++++++++----------------
>  rust/qemu-api/tests/tests.rs     | 33 ++++++++++-----------------
>  2 files changed, 31 insertions(+), 40 deletions(-)>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


