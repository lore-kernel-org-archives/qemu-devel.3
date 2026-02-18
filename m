Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62622E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 06:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsb6R-0005wz-0o; Wed, 18 Feb 2026 01:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vsb6P-0005wl-DE
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:32:01 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vsb6N-0002v2-Nm
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:32:01 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7270C6013F;
 Wed, 18 Feb 2026 06:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DB9C19421;
 Wed, 18 Feb 2026 06:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771396318;
 bh=c6vDU6qxGmdW06UE3Ykjfk1TJfYOZ4o5fif5odKNA60=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c2JskeNdBqp7ZtmDuO6/RIeHG9J4ny4anMDEscejUvAAje7IKjh0VRRG0SqYTiXzm
 QzX62hWr1/j4sDF5oonxB4kzmnkmgU+6VR+W/a2P4tiiZRE7woETtaehmShk7RucaV
 4bImY/qi4Z8mHDgoe5YRaJUbeV3ShdMq/HhfTbbRMyxZuhG5hLQVO3HJgjyTmCMw5Q
 jbJdSe7xDTGgf+eqviU+ipLCBThB1oo9d7SNeD47iLNF2vnJGUmOvxM0hjAwF6DrAF
 7gn/qyZVKMUIOvIZC9awvmbMOhDI9JodYXzcYlqDmCpiQHMEgonJVQuoAXwUJm7iV0
 lQy8x8LZrE2Kg==
Date: Wed, 18 Feb 2026 06:31:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH 0/3] i386 emulate fixes
Message-ID: <20260218063156.GC2236050@liuwe-devbox-debian-v2.local>
References: <20260214131659.31378-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214131659.31378-1-shentey@gmail.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=wei.liu@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

On Sat, Feb 14, 2026 at 02:16:56PM +0100, Bernhard Beschow wrote:
> When testing Mohamed's recent x86_64 WHPX updates [1] I encountered two
> compilation issues under MSYS2/GCC which are fixed in this series. The last
> commit fixes a missed optimization opportunity in MSHV code.
> 
> The MSHV code will be reused in WHPX [1] which allowed me to test it. I
> didn't notice any performance benefits, though in theory there should be some
> due to less guest memory accesses.
> 
> Testing done:
> * Use a Linux VM for a couple of hours
> 
> [1] https://lore.kernel.org/qemu-devel/20260213034556.13471-1-mohamed@unpredictable.fr/
> 
> Bernhard Beschow (3):
>   target/i386/emulate/x86_decode: Fix compiler warning
>   target/i386/hvf/x86_mmu: Fix compiler warning
>   target/i386/emulate/x86_decode: Actually use stream in
>     decode_instruction_stream()

Reviewed-by: Wei Liu (Microsoft) <wei.liu@kernel.org>

