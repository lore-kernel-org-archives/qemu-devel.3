Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F72EFCE53
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 00:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxwXb-0001KQ-7u; Wed, 04 Mar 2026 19:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1vxwXY-0001Jg-Vy
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:26:09 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1vxwXX-0004wl-La
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:26:08 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D149361340;
 Thu,  5 Mar 2026 00:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B08C4CEF7;
 Thu,  5 Mar 2026 00:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772670365;
 bh=UepqIuLUKCKQnNwC65D5tmrrRilTbI7Lk7HQcWTAN+4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=GX9WQERhXAUVKacd6EkeI8nb+Eudhlsnoe568bmhGvFi6Voe8M/SE7e9joocIU7Ue
 tpds6qLTJ6kOcdokTG6vze9TUGMi6C8iRBAIuXiqJpx97XQnR6BdP/mJhbPD6p1/zc
 tCKv+eR6PXo28O1KK2bAaE7+8e/568CXRLbKT9cSQgb9i80yDwlFMye2kdaBpMmntG
 3+C1IH/p2yeMcgDKPKMx1i7pAQUxVvtBV6RkLJ7Ug8tR7y55hU9ERqISqYHfN51BOB
 lapA0cqHweXRseVGeyPZBufXX2aYq1ERfUsG3gxR7ObAJEZZcoENcRjAIDOIqvvUd6
 V5A30nL6s3F3Q==
Date: Wed, 4 Mar 2026 16:26:03 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, 
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 5/5] hw/xen: xenpvh: Add prop to enable/disable the
 mapcache
In-Reply-To: <20260304015222.979224-6-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2603041625580.250016@ubuntu-linux-20-04-desktop>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
 <20260304015222.979224-6-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=sstabellini@kernel.org; helo=tor.source.kernel.org
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
> Add a machine property to enable/disable the mapcache.
> Default it to enabled for backwards compatibility.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

