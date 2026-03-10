Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141C6FD2D98
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxaX-0007LN-Ej; Tue, 10 Mar 2026 09:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxaV-0007JH-6d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:57:31 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxaS-0008Ui-74
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773151048; x=1804687048;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=XTUPqibs5W5ggZyYlo/hQHkMR+oBUCEHJRswAdOPPx0=;
 b=L3xJstJFwqFtiWp5r80yvSVNOAp7fhFbHK3C5Pig/ciNSHB6onzdN/dS
 ZPHONnYTFsGbuqJ6QcE41uuDGKCBFCORUZ9sa4TP9ywE39JKs56wWlGq3
 nFmqlZM043PEiwQHj9yYBp5qRKHAcn8I/BTvBGuYSEMDOoHRIO4qV4er7
 3owQkCluS3QHAFmTmczqi9GmvmB0Ke/mVN8oC7vLrCGH9ghA8+Bra2PUH
 6o79J9g6yOq+Wv0j7LBZyiGigX4NRHMHqxuFOK20GOXvJYjkCREih0llI
 g+4fox6nIXXkfMXWK7T6aDO3ncHaZMLT8Guc+lWQxMEME+Kyr+DwnlNQa g==;
X-CSE-ConnectionGUID: rCarKsnaRee9RYYwxIXjCQ==
X-CSE-MsgGUID: 9BwRuDcvTY2o9Wyyfwqtag==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74098391"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="74098391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 06:57:25 -0700
X-CSE-ConnectionGUID: ScqKj6g/Sz+FN7lyVPQpgw==
X-CSE-MsgGUID: pXLOEhDkTwyt3dSwaRQfpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="219250202"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 10 Mar 2026 06:57:23 -0700
Date: Tue, 10 Mar 2026 22:23:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 01/10] hw/i386/pc: Remove deprecated
 pc-q35/pc-i440fx/xenfv 3.1 machines
Message-ID: <abApZDXZuAThaBoA@intel.com>
References: <20260309145013.44327-1-philmd@linaro.org>
 <20260309145013.44327-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309145013.44327-2-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 09, 2026 at 03:50:03PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  9 Mar 2026 15:50:03 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 01/10] hw/i386/pc: Remove deprecated
>  pc-q35/pc-i440fx/xenfv 3.1 machines
> X-Mailer: git-send-email 2.53.0
> 
> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20260307152635.83893-2-philmd@linaro.org>
> ---
>  hw/i386/pc_piix.c | 25 -------------------------
>  hw/i386/pc_q35.c  | 14 --------------
>  2 files changed, 39 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


