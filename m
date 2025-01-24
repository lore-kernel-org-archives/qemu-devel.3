Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7479C02182
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 02:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb9Pm-00026v-MT; Thu, 23 Jan 2025 21:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tb9Pg-00026Z-FJ; Thu, 23 Jan 2025 21:27:17 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tb9Pe-0002qi-2r; Thu, 23 Jan 2025 21:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737685634; x=1769221634;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9LQixIvYkgZld28dIClne+7xAbIyCpUlr46P9e+1tC4=;
 b=HT0Y+qSGUKxMocQqYmH30nRgR3ZuTaQV8wFmp/grklJV5P4kyLL12dmQ
 EMRKUmqbChI7DFNVQs/nIoGfXEUxvn8Lf3GXGmchM/bNQb6SbVDtyTkn+
 ZFkd2cvEvddHAcVYvVm8ckMj6ayX+zchFZMfhS+vuEnmFUz75kvy5ChwK
 t/eIMNQKBWHoHqVwIcgiQ6cgHtK1pRO87vNTdLqbZRbeyQaMxvhW285E/
 RaIfbIV4Jx78c21ieDhEIsHz97Sv53K3da3rta5q2Z1WNU7jwD1LP791t
 vQlloriUEObE2rCoPzMVYSyzcUBmWZPKpixlZWYaHeFF2d/dy9ZwDywHt A==;
X-CSE-ConnectionGUID: MQ95wZV7RgSOnCA5nOtEjg==
X-CSE-MsgGUID: za6YWIz6SbGacvQf8nDotQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41046679"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="41046679"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 18:27:08 -0800
X-CSE-ConnectionGUID: ZPkhJFUuQT20ka+utw5IsA==
X-CSE-MsgGUID: wTr4SFthQAOdsvTgtvjaaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="107451242"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 23 Jan 2025 18:27:08 -0800
Date: Fri, 24 Jan 2025 10:46:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [RFC PATCH 00/10] rust: remaining part of qdev bindings
Message-ID: <Z5L/BtIKWSkRyLzG@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Fri, Jan 17, 2025 at 08:39:53PM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 20:39:53 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [RFC PATCH 00/10] rust: remaining part of qdev bindings
> X-Mailer: git-send-email 2.47.1
> 
> This is what I have left for qdev bindings, including 1) reference
> counting and object creation 2) clocks 3) Resettable 4) MemoryRegionOps.
> I have no rush for this series, and I expect HPET to be merged before it.

I'll get HPET v2 sorted out and sent quickly (in the this weekend), then
I'll go through this series. :-)

Regards,
Zhao


