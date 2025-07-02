Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB6EC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 06:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWqqO-0006mu-AU; Wed, 02 Jul 2025 02:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWqqM-0006m4-TS; Wed, 02 Jul 2025 02:21:18 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWqqJ-0000MV-6h; Wed, 02 Jul 2025 02:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751437275; x=1782973275;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KDE7bcX47aDBLE8+1wi3xHJx7irP5QBRBP1cPyNpGEo=;
 b=S1odRBYjEpI/BIUqYM4kOJNSETBc7U0+0u2Mo3ZkeyOqFiTic5Xp2rFz
 WIVVlqnwkaJl7ouYvOlTxcbcNwotYMGcyTilh5Y1/XFjxsYPuHadidGhk
 FUuc2rS4prqX8WrhkuK/0ZYQBXKtBMWHbZP5p86vyVppTsE+BDvUsOcwg
 FHMRIDc+umupqySwj5ZZDfCr1EFPMC4OTrWNTMbtCMGCCj6zoPjDXoIsC
 v53Gcc585TD6esu7EX2QXyyZJPisGBzU3bZ0yzubTquraXLo33hu5OSoJ
 IJLVFypWAaqa8efYPZM/eCPrOy893bnpfVUFywjx6d5DGr8cP1V+TMx17 A==;
X-CSE-ConnectionGUID: v7EedJXyQ4Ok6SoCk7SCgg==
X-CSE-MsgGUID: MkXSxus7RISQUaVqEVbjmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="65069877"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="65069877"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 23:21:10 -0700
X-CSE-ConnectionGUID: 2DOTjRfKRXCZODe51K6jvQ==
X-CSE-MsgGUID: hIXI8E1kSa2EoaubLjUqNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="191160559"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 01 Jul 2025 23:21:09 -0700
Date: Wed, 2 Jul 2025 14:42:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-stable@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] accel/kvm: Adjust the note about the minimum required
 kernel version
Message-ID: <aGTU2enBBQj7lu3E@intel.com>
References: <20250702060319.13091-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702060319.13091-1-thuth@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jul 02, 2025 at 08:03:19AM +0200, Thomas Huth wrote:
> Date: Wed,  2 Jul 2025 08:03:19 +0200
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH] accel/kvm: Adjust the note about the minimum required
>  kernel version
> 
> From: Thomas Huth <thuth@redhat.com>
> 
> Since commit 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and
> KVM_CAP_IOEVENTFD_ANY_LENGTH") we require at least kernel 4.4 to
> be able to use KVM. Adjust the upgrade_note accordingly.
> While we're at it, remove the text about kvm-kmod and the
> SourceForge URL since this is not actively maintained anymore.
> 
> Fixes: 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I just mentioned the kernel version in another patch thread. I found
x86 doc said it requires v4.5 or newer ("OS requirements" section in
docs/system/target-i386.rst).

> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index d095d1b98f8..e3302b087f4 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2571,8 +2571,7 @@ static int kvm_init(MachineState *ms)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>      static const char upgrade_note[] =
> -        "Please upgrade to at least kernel 2.6.29 or recent kvm-kmod\n"
> -        "(see http://sourceforge.net/projects/kvm).\n";
> +        "Please upgrade to at least kernel 4.4.\n";
>      const struct {
>          const char *name;
>          int num;
> -- 
> 2.50.0
> 
> 

