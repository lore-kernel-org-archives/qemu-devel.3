Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E66606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fb5QZSt9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW4i-0007O4-PU; Mon, 09 Nov 2026 15:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1xQW4X-0006bt-KN
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:34:35 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1xQW4W-0007s2-5D
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:34:33 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E965A42A11;
 Mon,  9 Nov 2026 20:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EBB1F0089F;
 Mon,  9 Nov 2026 20:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794256462;
 bh=g5T6umnSQct9FJ4i4bTQJHGh+zm/sJ2yp9adYBHV3LQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fb5QZSt9dPAlpjc0Bj2XYtrHmBAUhYWVyrd7qtLojUHF3ghowffQorgBKCOyd/Iop
 v5sxvNQA096ubX7p8SDFhBVvJhe8WhUvnq6Rr53Dgo9EonC8cwolxbBBkyH3ghY57h
 +PL0DhVcs259a9ueUj/DPrEKZmKrdUdRrMnuTJLZvCt+Pda3/jw1uvnMBgyH9SL1pR
 R7vPks/HbX0ckLUH3/QZjO+igHDwE9ZCpNtnny+LEXGeXZV6jH4NvvU/BZC6SicbUp
 mRMdart62u87GraD4m1co7S5O/Lm2XbAgUJ9SYQEscrmRDhHxG8pOyMHn3CsSfEwuk
 i8ABUy7Z7USdA==
Date: Mon, 9 Nov 2026 12:34:21 -0800
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: Re: [PATCH] target/i386/mshv: add MshvPutState for vcpu writes
Message-ID: <20261109203421.GB3536171@liuwe-devbox-debian-v2.local>
References: <20261109123949.724711-1-magnuskulke@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109123949.724711-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 01:39:49PM +0100, Magnus Kulke wrote:
> Currently QEMU marks a vcpu state as dirty also on merely inspectional
> reads, e.g. via "info registers", which triggers a writeback to the
> hypervisor. For MSRs that cause a side-effect when written to this is
> undesired.
> 
> We introduce an MshvPutState flag into the writeback logic to differentiate
> "runtime" from "full" and "reset" writebacks that should occur e.g. after
> a migration or startup.
> 
> Discrete side-effectful MSRs are excluded in runtime writebacks. So far
> we only mark one MSR as not runtime-safe, but probably more will be
> added eventually.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

