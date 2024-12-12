Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31754E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfm0-0001lJ-10; Thu, 12 Dec 2024 04:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLfly-0001l1-33; Thu, 12 Dec 2024 04:46:18 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLflv-0002dZ-7p; Thu, 12 Dec 2024 04:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733996775; x=1765532775;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=i5soMDtGLK0fsFthBO+nJaF+S7lgNsHL246rf1nyrr4=;
 b=L0COiHWpkVW5B8/dXWUTKvH8FraFdTmC9IStAgep05FLDUgCfrjY1giV
 QScrcVVYTdVjsajjC7Anzl59Eskf533ZP0BxsXQexw8jB0vslm8oAT/sb
 awJzt6eFrANEtoVId8cPUgl0m4vyL7eJclo6Q2/mChx89zMP8Sh1NFM4d
 /TYbiqSzGJQgDtgcxkisZKqaepGkyAGCXikLLxq9awnIsd7ROIxDD9SfD
 kqTfBJWYSTzjvvWU8TCVpfSNfL+ZgpVk4cn+slI3vnnMgQbSTKz41zdnd
 23GjAoJpiRJRPS09iuvUh4t/RwlQWPGKJGQ7FPVzcYIDEwXbNjzxwwj2T A==;
X-CSE-ConnectionGUID: BJpUNd7zQ26FRJx9dLJ5Jg==
X-CSE-MsgGUID: y7TMGbsjTsSlPpXIo25n5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34313369"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="34313369"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 01:46:10 -0800
X-CSE-ConnectionGUID: Y5zt/nSaSjSMQLo1sTpCsg==
X-CSE-MsgGUID: R2F60qqFT/SNMczMDuoz+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="96054507"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 12 Dec 2024 01:46:10 -0800
Date: Thu, 12 Dec 2024 18:04:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 21/26] rust: tests: allow writing more than one test
Message-ID: <Z1q1KAShyW44BJCg@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-22-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-22-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

> +fn init_qom() {
> +    static ONCE: Mutex<Cell<bool>> = Mutex::new(Cell::new(false));
> +
> +    let g = ONCE.lock().unwrap();
> +    if !g.get() {
> +        unsafe {
> +            module_call_init(module_init_type::MODULE_INIT_QOM);
> +        }
> +        g.set(true);
> +    }
> +}

Only one question: what is the purpose of using a Mutex here?

Others LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


