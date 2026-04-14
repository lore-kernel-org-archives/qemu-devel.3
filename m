Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70627F9D0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 20:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCkoH-0003BP-B2; Tue, 14 Apr 2026 16:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1wCkoE-0003B5-Bh
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 16:56:34 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1wCkoC-0003iq-WD
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 16:56:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B85360018;
 Tue, 14 Apr 2026 20:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9732EC19425;
 Tue, 14 Apr 2026 20:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776200189;
 bh=SEVVX+T8EAnuE2AvHFMohBML2a8jJPATdfyzZvBc6jg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Zz2cgqiJqYBmoULEeXG4CqZSTGNHcUuC4C1ZLU5JuVSk2JiGT+ytt7INxXSv8bqc5
 MzzQmP6D/fx4fug8aw5VXFhGc2XFyFX1dmnEiiGETA4/dWjcWgBntDVgHlsP2fX7Eh
 3v83IAmOOW5VpivXmb+hIx7/wxO9I6ZJQdGKJzVhLZzJzYtShDDSqgVJ6ErB/a+/vD
 yA2pdkk1KOBH4gDrCAUqYsF5b6ms212w5GcWIBdB90jVZlqV9Wf4lde37i7Epv4cAL
 R5bGyua+oXR4IMrETJ1eaFDlClQPHzojckGJb9TNPPbCAvEPv7wlsKz9xGrcVVxU8D
 u3cOEdNvxhJ4A==
Date: Tue, 14 Apr 2026 20:56:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 9/9] accel/mshv: disable la57 (5lvl paging)
Message-ID: <20260414205628.GA2900143@liuwe-devbox-debian-v2.local>
References: <20260414155433.483186-1-magnuskulke@linux.microsoft.com>
 <20260414155433.483186-10-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414155433.483186-10-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=wei.liu@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 14, 2026 at 05:54:33PM +0200, Magnus Kulke wrote:
> This change disable la57 paging on the mshv hypervisor on both the
> mshv processor feature bitmap and mask the cpuid feature leaf to the
> guest.
> 
> Since the removal of hypervisor-assisted gva=>gpa translation in
> 1c85a4a3d7 we have seen MMIO errors in guests on la57-enabled hw. We
> will have to investigate and test this further.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

