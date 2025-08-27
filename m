Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD17CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHOH-0002NE-1l; Wed, 27 Aug 2025 10:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urHOC-0002LR-Bh; Wed, 27 Aug 2025 10:44:40 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urHO5-0001de-FC; Wed, 27 Aug 2025 10:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756305874; x=1787841874;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mRi7teFjtyQ0V5zHbFF5pZ28nyknigHSLJ/UIbQgA7w=;
 b=EWv5PcpLnvS01ZaxhB8DFAu/9QaZMXySs4zCwJZpHbRHJARaZ2c4pWPA
 mYA0iG8c7ZBM70nLbt75MUeWTJBRPHQlmcuspNkme16PDuBc9I3rpUtZl
 61Sro/+bda6LyjbuAomX4Pj4UwFs72vrhQA4moQsB3bSPk9BPQ5kFfjQB
 EGkhKa2V9HZqGLmEu5bklqHTWCdrfaasThPMNAir7JH8ZKhBtQ2uTBsNE
 rFGGVsr5GrUwyyh7H0VOzahTN1s5mQp+DvS/0ie9OlVlL1VL8h+7HaSX3
 P2suVODsCPrXzxFgRJqq9hKBDFYjvLUCVTV6DdJZqTj8VWhC43MhqaCPN A==;
X-CSE-ConnectionGUID: AGVUuqojR269Q5THaH4UWw==
X-CSE-MsgGUID: wcoClQ4oTo+x/fXIBeowZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="83964581"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="83964581"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:44:30 -0700
X-CSE-ConnectionGUID: rIduckGPTkGOgm84N5v8Vw==
X-CSE-MsgGUID: ybQy4QXcSju/CADQdsg5Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169147453"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 27 Aug 2025 07:44:28 -0700
Date: Wed, 27 Aug 2025 23:06:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 04/22] rust: make build.rs generic over various
 ./rust/projects
Message-ID: <aK8e5uTtY5Mcs1XN@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-5-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Wed, Aug 27, 2025 at 02:41:26PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:26 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 04/22] rust: make build.rs generic over various
>  ./rust/projects
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Guess the name of the subdir from the manifest directory, instead of
> hard-coding it. In the following commits, other crates can then link to
> this file, instead of maintaining their own copy.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  rust/qemu-api/build.rs | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


