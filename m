Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11006CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 03:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8VWA-000816-Da; Mon, 13 Oct 2025 23:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8VW7-00080x-QM
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 23:16:03 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8VW5-0004yo-LI
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 23:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760411761; x=1791947761;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9fgtpRy1scbvzT9MZKwOphV6PVANUp1M0XKTRWlprEU=;
 b=A1KIDMUnLIIHMWTuK5FL0ucDX6cY0Lfw1suMDMMOXfuNRB3jdz/T7rWf
 0QHR8AoMnWSdf6I3XKvgmoC1uMxpNSzCN+7XjyFkDtPmXTumJk+1OehoW
 cj1LEevEh/rxbpsfse6IKjAAubeLkFBng4U9pVCRJqBdNFB7WIaaeKbZi
 g/156iluiz9tWXkt9pTGEdI6+dnUWSmlXM6GUaDTrmOlhOf499nE8iGdH
 9C51pIFJYS6lvBAb7xF5vXT4N8z+067yOXlFkInxgOoTgcuZ2s7Ue2kns
 HxO5oa87U8yOtE0lLpKpfjch5t08Qba7hamMAosb2tU/KECeeb+j/gpby w==;
X-CSE-ConnectionGUID: Jsbp5jV1TbybT2hm//7EBw==
X-CSE-MsgGUID: TEeIMBFAQcSkXmzb1vNHXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="66217230"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="66217230"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 20:15:59 -0700
X-CSE-ConnectionGUID: 3PCYaAXGQfWmDVv+QqfQ5Q==
X-CSE-MsgGUID: b0Hc+KZDTneusHrNJwS2JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="182225898"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 13 Oct 2025 20:15:58 -0700
Date: Tue, 14 Oct 2025 11:38:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/11] rust: qemu-macros: add ToMigrationState derive macro
Message-ID: <aO3Fm9DGQhdk9RC1@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-8-pbonzini@redhat.com>
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

On Wed, Oct 01, 2025 at 09:52:07AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 09:52:07 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/11] rust: qemu-macros: add ToMigrationState derive macro
> X-Mailer: git-send-email 2.51.0
> 
> Add a macro that recursively builds the "migrated" version
> of a struct.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.lock                         |   1 +
>  rust/migration/Cargo.toml               |   1 +
>  rust/migration/meson.build              |   2 +-
>  rust/migration/src/lib.rs               |   2 +
>  rust/migration/src/migratable.rs        |  12 +-
>  rust/qemu-macros/src/lib.rs             |  88 +++++++
>  rust/qemu-macros/src/migration_state.rs | 296 ++++++++++++++++++++++++
>  rust/qemu-macros/src/tests.rs           | 112 ++++++++-
>  8 files changed, 509 insertions(+), 5 deletions(-)
>  create mode 100644 rust/qemu-macros/src/migration_state.rs

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


