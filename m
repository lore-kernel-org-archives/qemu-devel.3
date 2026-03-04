Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575DFEFCE4D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 23:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxw6h-00048c-9M; Wed, 04 Mar 2026 18:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1vxw6g-00048E-98
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 18:58:22 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1vxw6f-0008TD-0n
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 18:58:22 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2403A44100;
 Wed,  4 Mar 2026 23:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241F4C4CEF7;
 Wed,  4 Mar 2026 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772668697;
 bh=DPt5htaOCfcgqP4MO7Lq2RngC1FbWjZzqXZYuC57Qy8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=c5S9RKS4ZjuSN0YHIAeMDXCJyy8MzdXORIQXJew3n0sUik9MbmfH9yqGvq1d4/xxz
 PAC4Lrb69SAI8lHjtSQUCl8NgfS70S348p4d0ActpJkbWGlM92PplCAUXXk9NRBuiJ
 zq9W2mQ2t/nVIFfq0nFcy+XyDBNdJBp2k54cN2frZt9i0JtodIxBFAN4dA+bYhj28d
 4KLyMl+Jmcl5u0yhRzUTl628lxOWl3pOLkRnuD5dLn3dbnN6qx3vQGSH1sqQ9K33Vd
 bApM1gpqiLc+1QHLXwtxMZXvz0wFYhiY8nxrq0MvabSeKOzPdCrQmP8TTtql++xZmn
 BEIo81ePGzN5g==
Date: Wed, 4 Mar 2026 15:58:12 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, 
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 1/5] xen: mapcache: Assert mapcache existance
In-Reply-To: <20260304015222.979224-2-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2603041558040.250016@ubuntu-linux-20-04-desktop>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
 <20260304015222.979224-2-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=sstabellini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 4 Mar 2026, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Assert that the mapcache was created prior to being used.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


