Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D734C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCiv-0000k6-3s; Wed, 29 May 2024 02:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCis-0000jN-PZ
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:23:42 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCij-0005BW-Vv
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716963814; x=1748499814;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/ZgaiUN5BbUrHiPpdVw4VnNTDHeOLOcSkio18qlp2C0=;
 b=EzGHkdlvJfx1n4EdhAPMx+6IbF54ZqHzLRud3ZNvAhBc0R+KSLXKyZdI
 CbQqnCpu1eA9OLl27alubzwP95N02p1jUrnXbysxp6eyPex+9rjm+gP+v
 /wG0mG+JtMBkamEqA5w5NIsxZ2SumjTAgEQFYbG552iA+Nvl/cKbsZDjr
 0c40f/rb75Y4FX9rxHc6HTW0k6Np1pq2YAqh8oCW/CnM71BNW3LlBIxMz
 JTEvhiE2MYscnoekvtSgs8VQI/30BPQ03QzXODxZ1unyXFd10z55/4cEw
 YHHV2D2LVUyQliEpx8YUNVjUt+AzPZgbSUadYmJS9rVXvObsSNV4pHBnv w==;
X-CSE-ConnectionGUID: JGk8VjxiQ5+g2LQu2Qvq/g==
X-CSE-MsgGUID: ooQ1jvqjSW6vabWYd7yXug==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17139384"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="17139384"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:23:31 -0700
X-CSE-ConnectionGUID: HeNqn8KrS+ONyHJ6vaPkjw==
X-CSE-MsgGUID: +60b5aNxS+K7P+796eRN+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="39754583"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 28 May 2024 23:23:29 -0700
Date: Wed, 29 May 2024 14:38:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v5 20/23] hw/i386/pc: Remove deprecated pc-i440fx-2.3
 machine
Message-ID: <ZlbNfZkVOD6wNI4N@intel.com>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-21-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529051539.71210-21-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, May 29, 2024 at 07:15:36AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed, 29 May 2024 07:15:36 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v5 20/23] hw/i386/pc: Remove deprecated pc-i440fx-2.3
>  machine
> X-Mailer: git-send-email 2.41.0
> 
> The pc-i440fx-2.3 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/about/deprecated.rst       |  4 ++--
>  docs/about/removed-features.rst |  2 +-
>  hw/i386/pc.c                    | 25 -------------------------
>  hw/i386/pc_piix.c               | 19 -------------------
>  4 files changed, 3 insertions(+), 47 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


