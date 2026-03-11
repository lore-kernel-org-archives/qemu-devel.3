Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C20D103E2E6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0REo-0008Le-7w; Wed, 11 Mar 2026 17:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0REm-0008Kn-UX
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:37:04 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0REl-0003hl-LZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:37:04 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A15D943A05;
 Wed, 11 Mar 2026 21:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C45FC4CEF7;
 Wed, 11 Mar 2026 21:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773265022;
 bh=9LV1YYkf490SL19ohc0jMVPx7hamFkKHllgfULyGAeU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J0l8G/lkhxrSW6+A9cRGnuq5izFNGA1ggbA5iBiaA3zDzqxwZ2z4m4CiyEzIQ9Eza
 JYLTcEQE8fOuOy2l+dk4zXzJ36pF7JnphPnCw6fsoeGXJ9n2mRfBq3aAjariBomEwD
 E0fDH4+fiIa1OSaia0DGYFsjbDT1R6kkuqNouisu5e7SpwFC/WcdKmbnthLX5vEV+F
 w1qErDaZCaISkQWj2ZI9NpyXmONgAWskg3qVQTXn3EAYam8LSgxv6ihi8pu9TFLvDU
 tGKMyftVCkmRYdUr3z1AuIHO1fJ97ksk2sap1iVvf3GFJxwlYxJUKY85At2Ftojl7s
 gDf8lo+C9t+Bg==
Date: Wed, 11 Mar 2026 21:37:01 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 5/9] target/i386/mshv: set cpu model name on -cpu host
Message-ID: <20260311213701.GG3612627@liuwe-devbox-debian-v2.local>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
 <20260311113505.1177878-6-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311113505.1177878-6-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 12:35:01PM +0100, Magnus Kulke wrote:
> By registering a cpu_accel_class for mshv, we can report an accurate
> model name on -cpu host.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

