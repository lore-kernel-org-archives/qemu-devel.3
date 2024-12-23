Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F3AE7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 06:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPbq2-0008Qz-0M; Mon, 23 Dec 2024 01:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tPbpi-0008PP-1h
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 01:22:26 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tPbpe-0007Q1-V0
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 01:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734934943; x=1766470943;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Y+aj8IZ1/4HBp8Yui8+A0nkaCd3wPeRRt6koqQ31tLc=;
 b=igTrq+FefiBoPBqwAyf09ShE4X+q9x14WGUQ7ccLY33mhnJeNMPQ8GY0
 os6j/Ff1z15Cs2VNGRLEnrtiz3bm2ZfFGq4OBsBWh6M0slHHkXnz3LL4J
 k0pBoKWPpFYC1izLmYlGQ7ILTV5JcUIkA4Gm1kFrJiOLuy2h95H9QMQfL
 g3ldZ8xGJ+eNikWqMxCbK3UJPN1rGq0dqY4ps3xRodL9/7oLYZWY9SUpH
 l6eAhYsjovTGxSRPHaclUL8USL/OgtCRkz34nHGtZavdBzJ2d59Fl3HwF
 qjEtwHhLkB3MqMQ1EnQ4x1S7JfAGgr6vONFGUo2NlSdDq2DkicWpu0q1Z w==;
X-CSE-ConnectionGUID: LyoZdQ9LRYqk80Hj4E2LbA==
X-CSE-MsgGUID: crrKOjTMTuqMuGeHgogePw==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="45887689"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; d="scan'208";a="45887689"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2024 22:22:17 -0800
X-CSE-ConnectionGUID: JftQB85VR4ehky0VTTufqQ==
X-CSE-MsgGUID: 9MDpE5qVRBux+74EeNApFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; d="scan'208";a="98983173"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 22 Dec 2024 22:22:16 -0800
Date: Mon, 23 Dec 2024 14:40:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 00/12] Next round of qemu_api patches
Message-ID: <Z2kF+Txj4jNJw/u3@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Fri, Dec 20, 2024 at 03:29:42PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:42 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 00/12] Next round of qemu_api patches
> X-Mailer: git-send-email 2.47.1
> 
> This includes:
> 
> 1) the outcome of reviewing
>    https://lore.kernel.org/qemu-devel/20241209123717.99077-1-pbonzini@redhat.com/T/,
>    especially with respect to instance_finalize implementation and
>    Rust-defined subclasses (patches 1-6)
> 
> 2) the beginnings of separating instance_init/instance_post_init, making
>    the latter take &self (patches 7-9)
> 
> 3) extracting pl011's logic to convert an integer into an enum into a
>    #[derive(TryInto)] procedural macro (patches 10-11)
> 
> 4) a one-off change that I noticed while reading Cargo documentation
>    (patch 12)

This series is the v2 of https://lore.kernel.org/qemu-devel/20241219121216.416905-1-pbonzini@redhat.com/

I will go through this series this week. :)

> Zhao: I have placed these in rust-next, but feel free to ignore them for
> your next HPET submission.  I have also included in my tree your test
> additions for usage in CI, but I'm not including them here to give you
> the opportunity to post them with a commit message and a signed-off-by.
> If you don't have time, it's in safe hands. :)

If possible, I would really appreciate it if you could add it to your
series :-) It seems fragmented if I send it separately.

Thanks,
Zhao


