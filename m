Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7C9C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 21:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHVXI-0001AN-L0; Wed, 12 Jun 2024 17:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sHVXG-0001A9-P1
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:29:38 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sHVXE-0002Za-Fl
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:29:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 146A1CE230B;
 Wed, 12 Jun 2024 21:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531AAC116B1;
 Wed, 12 Jun 2024 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718227764;
 bh=gt+Cie5GjRcEMh9MF7jw89P50AvIiR4ZOHECkKzlIfI=;
 h=Date:From:To:cc:Subject:From;
 b=hgAurXjrv6B0nxeyKkuXlvpooUxsgF1bn17IiqfULP1t2zwYPJFfpSZoZpzlAc+qh
 /V/cHzbBCmhWDKuhqv2kmN+2Abfc+ZxUaeh0GbXdLMrBPicokx+vwDk2gIGbTkFkAR
 vfSXjvRYEEZduTUP/Mr+JQid7DNF+ehi5sFkXJRg959MoPu2/XUGcj/5oZo8B5Rlma
 EWDsq4pp1AZcNrLXU4WtikQfJaPjTTmVPElJwPpUjv0bl00OxmT7XniZ+2CJsg5n7s
 gvS7CNysreGpafgm9Yadx6s4iEkUUf0zEC39FgXDoD2F8zkScMOhCdp05SvkEyht7U
 6P5dWB6ONmb+A==
Date: Wed, 12 Jun 2024 16:29:22 -0500 (CDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: qemu-devel@nongnu.org, stefanha@redhat.com
cc: sstabellini@kernel.org, peter.maydell@linaro.org, Edgar.Iglesias@amd.com
Subject: [PULL 0/5] virtio-grants-v8-tag
Message-ID: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=145.40.73.55; envelope-from=sstabellini@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:

  Merge tag 'virtio-grants-v8-tag' into staging (2024-06-09 11:21:55 -0700)

are available in the Git repository at:

  https://gitlab.com/sstabellini/qemu.git 

for you to fetch changes up to 6d87a2a311fe4a8363143e6914d000697ea0cd83:

  hw/arm: xen: Enable use of grant mappings (2024-06-09 20:16:14 +0200)

----------------------------------------------------------------
Edgar E. Iglesias (5):
      xen: mapcache: Make MCACHE_BUCKET_SHIFT runtime configurable
      xen: mapcache: Unmap first entries in buckets
      xen: mapcache: Pass the ram_addr offset to xen_map_cache()
      xen: mapcache: Add support for grant mappings
      hw/arm: xen: Enable use of grant mappings

 hw/arm/xen_arm.c                |   5 +
 hw/xen/xen-hvm-common.c         |  12 ++-
 hw/xen/xen-mapcache.c           | 234 ++++++++++++++++++++++++++++++----------
 include/hw/xen/xen-hvm-common.h |   3 +
 include/sysemu/xen-mapcache.h   |   2 +
 include/sysemu/xen.h            |   1 +
 system/physmem.c                |   9 +-
 7 files changed, 202 insertions(+), 64 deletions(-)

