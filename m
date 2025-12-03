Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9898D12694
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQkCF-0003hJ-Eb; Wed, 03 Dec 2025 05:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQkCE-0003Z7-24; Wed, 03 Dec 2025 05:34:54 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQkCC-0001Lq-II; Wed, 03 Dec 2025 05:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764758092; x=1796294092;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ow76zXthBJgFU2QVUEtkvgrJkROf68t8XaAlZ+9V4wU=;
 b=Boyo2fn1QXlcPB49dIEGa6+5iHONnnKl9ZiShre2Y2tATOsGIsWcdkoa
 v9iS2CtAPsobkp7iKKaXo7i3+IqebCklIMMDNxnSbGAfYggKBTlxmfeHs
 3CzojraVXaGlUt0v6xiqITMmQbAqbjRMzKfgezVhJ+nyu3B4ui+mhaOU8
 HxtqNZVD96BdApY83aYkA3ws9Ou46imXuk4UBhEaW4ngdJuywElYOwOye
 lvaSi+zyqZzHdvrx4+kabOMQUPOfVNbemNtW+qoJt1/bUY373ysYspWIW
 fAQuHSzWKPyjyVigltdayzwzch9QmF8ReeB/RbpXTGKjN0Y+RpECvSmvY g==;
X-CSE-ConnectionGUID: Djxg25xXQfSZh4wMfirdZQ==
X-CSE-MsgGUID: f509D9vKS5+4RkvVHtRfBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="54296010"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="54296010"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 02:34:50 -0800
X-CSE-ConnectionGUID: 3zIhFLNZRbO2BV+/gx9vHA==
X-CSE-MsgGUID: VpTGPSGgSFq2C5NUQ20AbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="195432918"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 03 Dec 2025 02:34:49 -0800
Date: Wed, 3 Dec 2025 18:59:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 5/9] rust: do not copy the SysBusDevice
Message-ID: <aTAYFLIqHGq4x726@intel.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
 <20251127132036.84384-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127132036.84384-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Nov 27, 2025 at 02:20:32PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Nov 2025 14:20:32 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 5/9] rust: do not copy the SysBusDevice
> X-Mailer: git-send-email 2.51.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/core/src/sysbus.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


