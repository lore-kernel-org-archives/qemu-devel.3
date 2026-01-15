Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55196D44C40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMrh-0004tR-1c; Thu, 15 Jan 2026 07:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vgMrd-0004rw-6l; Thu, 15 Jan 2026 07:54:13 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vgMrb-0004zW-Dr; Thu, 15 Jan 2026 07:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768481652; x=1800017652;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fwge3zK8SEsQODkGXwBAwwKTKvpbQl8D/iyb9Pa5KYM=;
 b=Q/Wc2tpSgnDX4Xd7tmQyNfOrEqT5mmURxa6blzFI/pPPoC2GhkESXN4v
 gPaT0Lr/qToaxc9rytfAk8ol4eBQHectwkIimimmmW5KTa26FUBLPFXSE
 ZQLuzknGSuK+61g4T5lfil8mawmYcUU5aaWYTA9PXAPmQ2WnReKBIOVyc
 0tkNn1nKXIXwNPJUna/6011A/GuG1ptNJ6Zd8WPCyH69vMamxHx/oPDyi
 foZu6LVOABJb/BZFa+Z+Oza646PUaPTjmusAxVoNIB5Oc8LXzyoDkHtVc
 qd/8x+li/bjlSY3F/wliY7yS6DMIDJcxANmOcX+fGWQF0PJfmD99p3UW2 g==;
X-CSE-ConnectionGUID: S6xcR+WCTwWQoibFy1fmBQ==
X-CSE-MsgGUID: eXzq7lOiR2+MV9uL9KgXxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="73418483"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="73418483"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 04:54:09 -0800
X-CSE-ConnectionGUID: FWlDDYORQ46TOu+QIXDv2A==
X-CSE-MsgGUID: tGQAaSQLT9mKJnubJr6DKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="209461095"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 15 Jan 2026 04:54:07 -0800
Date: Thu, 15 Jan 2026 21:19:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: Re: [PATCH v2 08/16] rust/qobject: add Display/Debug
Message-ID: <aWjpaNwzXf178Vq+@intel.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108131043.490084-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jan 08, 2026 at 02:10:35PM +0100, Paolo Bonzini wrote:
> Date: Thu,  8 Jan 2026 14:10:35 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 08/16] rust/qobject: add Display/Debug
> X-Mailer: git-send-email 2.52.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/util/src/qobject/mod.rs | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


