Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D74C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMnO0-0002fp-6T; Thu, 27 Jun 2024 07:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sMnNz-0002fV-GG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:33:55 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sMnNx-00061F-UJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719488034; x=1751024034;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0NL+nmkpCPNX7akUPyfviVYGmBOjvMuOeDL9oTzCj6Q=;
 b=Nuy5IH/X+WEZyzy3iGJm+dKPSi4x2vA8ZySIGzvMtN2imDYpHYG/MBh1
 AytW9eh5AIMdGrBiwWufV7fgg+H7agk8Ft5TOPUrMFqWW7r1/6tyW/2e7
 gPkKMbh08d3Xi/wbY2NBIKyNpJALlPEg53LJmjFEOI0ZxovZJEy8OptAr
 gKuWvwKF38SluDSnn1eFrRQMPOzL0nIEg15lR8GMdHeq+FREfjx9T5SNf
 ocv6oH9UAC3pm9jQlqJt2euowhBXOqrb3exXxhrooDCAAQl0lJvksx8Ay
 yuUtYbm7QspqUdsgAT+AFRpRHitTq001wipp3ukSuaoYGdZeh5cWKe11R Q==;
X-CSE-ConnectionGUID: EC422CtvQnmnnXrQpOZqEg==
X-CSE-MsgGUID: ZPKmbDZDSoaPZKqgwIQQWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="20374128"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="20374128"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2024 04:33:48 -0700
X-CSE-ConnectionGUID: 1YstrzuPRtqBBa+3vwNu5A==
X-CSE-MsgGUID: uwSe4danRjqLIX1eiNhMuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="48959304"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 27 Jun 2024 04:33:46 -0700
Date: Thu, 27 Jun 2024 19:49:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386/tcg: remove unused enum
Message-ID: <Zn1RwYPoH3FKqoir@intel.com>
References: <20240627105919.981453-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627105919.981453-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, Jun 27, 2024 at 12:59:19PM +0200, Paolo Bonzini wrote:
> Date: Thu, 27 Jun 2024 12:59:19 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] target/i386/tcg: remove unused enum
> X-Mailer: git-send-email 2.45.2
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/translate.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


