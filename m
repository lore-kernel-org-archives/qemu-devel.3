Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A56FC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwoY-0004gM-9F; Wed, 19 Mar 2025 13:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1tuwnI-0004I2-Oe
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:01:33 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1tuwnH-00074f-5U
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:01:28 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1tuwnF-001U1h-DK;
 Wed, 19 Mar 2025 17:01:25 +0000
Date: Wed, 19 Mar 2025 17:01:25 +0000
From: John Levon <levon@movementarian.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: [PATCH for-10.1 20/32] vfio: Introduce new files for CPR
 definitions and declarations
Message-ID: <Z9r4Zc2DksD3QVth@movementarian.org>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-21-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318095415.670319-21-clg@redhat.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 18, 2025 at 10:54:03AM +0100, Cédric Le Goater wrote:

> Gather all CPR related declarations into "cpr.h" to reduce exposure
> of VFIO internals in "hw/vfio/vfio-common.h".
> 
> Order file list in meson.build while at it.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/cpr.h                 | 15 +++++++++++++++
>  include/hw/vfio/vfio-common.h |  3 ---
>  hw/vfio/container.c           |  1 +
>  hw/vfio/cpr.c                 |  1 +
>  hw/vfio/iommufd.c             |  1 +
>  hw/vfio/meson.build           |  2 +-
>  6 files changed, 19 insertions(+), 4 deletions(-)
>  create mode 100644 hw/vfio/cpr.h
> 
> diff --git a/hw/vfio/cpr.h b/hw/vfio/cpr.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..88a5e7f878a3e01df3410f6f0a9c8b5ccddefe28
> --- /dev/null
> +++ b/hw/vfio/cpr.h
> @@ -0,0 +1,15 @@
> +/*
> + * VFIO display

Copy-paste error?

regards
john

