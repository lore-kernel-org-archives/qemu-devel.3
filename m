Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26162CF6BE2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdK4k-0004SJ-G0; Tue, 06 Jan 2026 22:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdK4i-0004ON-K2
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:19:08 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdK4f-0008Jo-Uy
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767755946; x=1799291946;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fAZ8PcQB9qlQsXfcvHtK3AJ6iG1BB2EddnnwUHlyLVU=;
 b=Ir/+2ZqYNXKyU4ss+nmPkc0O/yWI6IeXBOWM7xqFsRqRduZD4/m3JKHh
 uQu9hB4up41KoxeRV8iPWyPanynG/zJkri/S6gTh6XI3gY76/ghQ02SC7
 fv5SQXH2h2OQQ3mVwMQa8CZvMMsQGIAk6MJHQ0PJExON5cyTnhCors26B
 pLp9JeH4sivvw9EVVAarJta+34uSz32W5ge6RVKWoRTMysZm+702YI9F3
 ImzFwMwWrLJtGwjxClBScp9JrCnSISeQDNNB31FLHSso1NiWHXm67shyF
 vtDi8HUvaJXtWglfHqLMWRbOVwETMggWEspZAyuKXto8g5WyCHdFl4USo Q==;
X-CSE-ConnectionGUID: WZxPH22bQJCivbTrCYCKrA==
X-CSE-MsgGUID: EzLofw1bThKuLdL1VlSssQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69104116"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="69104116"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 19:19:04 -0800
X-CSE-ConnectionGUID: 2Tmsq6rNSquVNDbJfNP3Wg==
X-CSE-MsgGUID: zVWyOSuhTumCj0ImQdEX0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="207355561"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 06 Jan 2026 19:19:03 -0800
Date: Wed, 7 Jan 2026 11:44:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Xudong Hao <xudong.hao@intel.com>, Yu Chen <yu.c.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 10/10] dosc/cpu-models-x86: Add documentation for
 DiamondRapids
Message-ID: <aV3WnOrsaqjcU7N7@intel.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
 <20251120071030.961230-11-zhao1.liu@intel.com>
 <aVzwXfbHVUpx1FQx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVzwXfbHVUpx1FQx@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jan 06, 2026 at 11:22:05AM +0000, Daniel P. Berrangé wrote:
> Date: Tue, 6 Jan 2026 11:22:05 +0000
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH 10/10] dosc/cpu-models-x86: Add documentation for
>  DiamondRapids
> 
> In $SUBJECT   s/dosc/docs/

Yeah, thanks!

(Since this patch has been merged, I'll be more careful next. :-))

-Zhao


