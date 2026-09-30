Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7277CCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpiW-0000a0-NA; Wed, 30 Sep 2026 04:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBphw-0000Os-1t
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:30:42 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBphu-0000dG-K3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790757031; x=1822293031;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yClytq2f5zOxCmvvbWvTkugDq/63AbzrVr3gC20uros=;
 b=CEZiZ45s28OKGuSjbAzpTtGrsf5Y+GDd1DLx9TCrEL7JLEkRgjRjsSPp
 0W6Vkv6sShyNoA/c1FGaGlQDWqbmLW1Io1u6nU7BxmlOx6aaGfrwJeb2b
 PTeSiC/HUJYz89Rnsder7iaXBzIXuduyJ/goXzoixbssq1/jbQFRktsAC
 9dPJgWDq7C7XS3FEqsbbak8BLk11kVV00kk8T1lebpSppqx/+l4lqkYXS
 Icq+xMp0yJKLv101lv8CAVlVl4FvnviqJXsv4pFph5Ym0+ZHA6dt41Qtx
 RzsDzuCboobSVoSqSvJcusY1okH0vWYHDbbBFFhupD16sXcJYtjQjFxxC w==;
X-CSE-ConnectionGUID: 7OHITO3gRaSG8rGE3ZQd/g==
X-CSE-MsgGUID: FzNue9rITtOEnuLAg99Pnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90530825"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90530825"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:30:30 -0700
X-CSE-ConnectionGUID: MkYHoy0KSmCyKNuhGjUHcg==
X-CSE-MsgGUID: Kyc6RDU7QSeR3AbPqYaJLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="275184216"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2026 01:30:28 -0700
Date: Wed, 30 Sep 2026 16:30:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Andrey Polivoda <apolivodaa433@gmail.com>
Subject: Re: [PATCH 3/3] target/i386/tcg: clarify return value of decode_insn
Message-ID: <arzIowSr4DlmtKa4@intel.com>
References: <20260930065406.738374-1-pbonzini@redhat.com>
 <20260930065406.738374-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930065406.738374-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 30, 2026 at 08:54:06AM +0200, Paolo Bonzini wrote:
> Date: Wed, 30 Sep 2026 08:54:06 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 3/3] target/i386/tcg: clarify return value of decode_insn
> X-Mailer: git-send-email 2.55.0
> 
> It is clearer if decode_insn() returns whether a generator exists;
> if it does not, the entry is empty and all other checks such as
> validate_sse_prefix() or has_cpuid_feature() are moot.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/decode-new.c.inc | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


