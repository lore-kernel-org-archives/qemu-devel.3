Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD345D1269E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQkBk-00035t-EF; Wed, 03 Dec 2025 05:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQkBh-000349-Vx; Wed, 03 Dec 2025 05:34:22 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQkBf-0001JP-FH; Wed, 03 Dec 2025 05:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764758059; x=1796294059;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=inhhs329/9yVPKnXShSu3foIt2Ziv52EkedCdZUKx6E=;
 b=MK2K28WjRPzDrJbWDPz24zJQzFlcxK68gYUUOz9cq7IhRr0EiX1d+Vx3
 1fMsqzECMpyUHuz1qHPAzo4bjC+NUbxqy91fWXsIl3h9fT2f6+TQdrjrz
 dOhsSSmsySbn8y+QHIBij0LON2564rh93QAGzL+dJe/hOb6fnTtfWhfwz
 XNsDCse3+gA9y8SloQQ/NDjfIVDBs4soSuCQ68E+F+djzu90o9n510b8Y
 PjyNo301W64r8zsKlO8D9NdlanoYDs/UxyIZ4gW/l+/QpfV2oGci+ym+P
 Tax4KXjRbWxChMJeKMZQxfeIIHixCCe/n1GhwumlTwxLXB0gy2UWZ6ywi A==;
X-CSE-ConnectionGUID: buH7igE4SYGj6HqEbPH8Dg==
X-CSE-MsgGUID: KAn7m56cS0mX8u6Um59Xyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="92226046"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="92226046"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 02:34:15 -0800
X-CSE-ConnectionGUID: mfyNq3ngREG0Mh7JOEKAQQ==
X-CSE-MsgGUID: 2OsZE3fbRIerAolCyU2XFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="199592629"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 03 Dec 2025 02:34:14 -0800
Date: Wed, 3 Dec 2025 18:58:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 4/9] rust/bql: make bindings public
Message-ID: <aTAX8PJgUIv19+Yg@intel.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
 <20251127132036.84384-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127132036.84384-5-pbonzini@redhat.com>
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

On Thu, Nov 27, 2025 at 02:20:31PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Nov 2025 14:20:31 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 4/9] rust/bql: make bindings public
> X-Mailer: git-send-email 2.51.1
> 
> For consistency with other crates.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/bql/src/lib.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Other crates appear to require being public mods to ensure binding
compilation succeeds or to use raw binding in somewhere, but currently
bql's raw binding hasn't been used anywhere.

I think maybe it's better to keep this mod as private until someone
needs it. This helps justify whether raw binding is truly necessary.
Direct binding uses should be minimized if possible.

Thanks,
Zhao


