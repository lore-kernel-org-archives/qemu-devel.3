Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCF1C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 09:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txjbQ-0004LO-77; Thu, 27 Mar 2025 05:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1txjbK-0004CU-CS
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:32:38 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1txjbH-00080y-Np
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:32:37 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1txjbF-003mVy-EL;
 Thu, 27 Mar 2025 09:32:33 +0000
Date: Thu, 27 Mar 2025 09:32:33 +0000
From: John Levon <levon@movementarian.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH for-10.1 v2 03/37] vfio: Introduce a new header file for
 external migration services
Message-ID: <Z+UbMZZkVwWCU+pW@movementarian.org>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-4-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326075122.1299361-4-clg@redhat.com>
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

On Wed, Mar 26, 2025 at 08:50:48AM +0100, Cédric Le Goater wrote:

> The migration core subsystem makes use of the VFIO migration API to
> collect statistics on the number of bytes transferred. These services
> are declared in "hw/vfio/vfio-common.h" which also contains VFIO
> internal declarations. Move the migration declarations into a new
> header file "hw/vfio/vfio-migration.h" to reduce the exposure of VFIO
> internals.
> 
> While at it, use a 'vfio_migration_' prefix for these services.
> 
> To be noted, vfio_migration_add_bytes_transferred() is a VFIO
> migration internal service which we will moved in the subsequent
> patches.
> 
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

