Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1019C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 10:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPIzn-0002eD-0J; Wed, 11 Jun 2025 06:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPIzl-0002Yp-C9; Wed, 11 Jun 2025 06:47:49 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPIzj-0002Gv-Ij; Wed, 11 Jun 2025 06:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749638868; x=1781174868;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8D0GGfYU0Tw4972vz+bqe7kJGRZlLX5oEJ2OBkzYpEw=;
 b=EDkSictbse7cvdQlYTvl/jXauzhrMtzRKRhJz4ZHhrSEsCMAKoR3lpEr
 WFxkek7QhMUz0Q/Skh5o14HDcxy6/+w4zuAUQvCEuPexShMZoQDosn+O8
 O2Ucm9TgRKQX+xPTfeyAa6JcorKkGtw5qIfRvACVAKixfyrF/o4rJCQ2J
 Q7z4BBkMOIn5z8LErUckZlDVYbOLvYz0Pkr0wpkySRo5SST0WC5fWgY/p
 11is8puZhQSxk/al9E89pSfZG0p8BpEal62OtFnRVbqfuymAlsvxrJfAQ
 kndutzr9SOM+Snhg/7JNzdTlzfVuZTD9+qmqqndZclKL0bZRZG4Z7pmKw Q==;
X-CSE-ConnectionGUID: kPypbl0RRP+kPpR8pflSVQ==
X-CSE-MsgGUID: Q0/603npQmGfJw9v/98Cag==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62055948"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="62055948"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 03:47:46 -0700
X-CSE-ConnectionGUID: G0aowGx1RnuhUMg8pf/o+Q==
X-CSE-MsgGUID: HqMm7XP3T+GWFW7tHsqdeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="170337623"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 11 Jun 2025 03:47:44 -0700
Date: Wed, 11 Jun 2025 19:09:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 1/5] rust: qemu_api: introduce MaybeUninit field projection
Message-ID: <aEljzPOf/76W25iC@intel.com>
References: <20250609154423.706056-1-pbonzini@redhat.com>
 <20250609154423.706056-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154423.706056-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Mon, Jun 09, 2025 at 05:44:19PM +0200, Paolo Bonzini wrote:
> Date: Mon,  9 Jun 2025 17:44:19 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/5] rust: qemu_api: introduce MaybeUninit field projection
> X-Mailer: git-send-email 2.49.0
> 
> Add a macro that makes it possible to convert a MaybeUninit<> into
> another MaybeUninit<> for a single field within it.  Furthermore, it is
> possible to use the resulting MaybeUninitField<> in APIs that take the
> parent object, such as memory_region_init_io().
> 
> This allows removing some of the undefined behavior from instance_init()
> functions, though this may not be the definitive implementation.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/meson.build   |  1 +
>  rust/qemu-api/src/lib.rs    |  1 +
>  rust/qemu-api/src/uninit.rs | 85 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 rust/qemu-api/src/uninit.rs

...

> +impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
> +    type Target = MaybeUninit<U>;
> +
> +    fn deref(&self) -> &MaybeUninit<U> {
> +        // SAFETY: self.child was obtained by dereferencing a valid mutable
> +        // reference; the content of the memory may be invalid or uninitialized
> +        // but MaybeUninit<_> makes no assumption on it
> +        unsafe { &*(self.child.cast()) }
> +    }
> +}
> +
> +impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
> +    fn deref_mut(&mut self) -> &mut MaybeUninit<U> {
> +        // SAFETY: self.child was obtained by dereferencing a valid mutable
> +        // reference; the content of the memory may be invalid or uninitialized
> +        // but MaybeUninit<_> makes no assumption on it
> +        unsafe { &mut *(self.child.cast()) }
> +    }
> +}

Nice trick.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


